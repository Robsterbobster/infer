(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd
open Unix
module L = Logging
open PulseBasicInterface
open PulseDomainInterface
module SummaryPost = PulseSummaryPost

let read_existing_json file_name = Yojson.Safe.from_file file_name

let append_to_json_array original_json new_data_json =
  match original_json with
  | `List lst -> `List (lst @ [new_data_json])
  | _ -> `List ([new_data_json])

(* Acquire a lock on the file *)
let lock_file fname =
  let fd = openfile fname ~perm:0o644 ~mode:[O_RDWR; O_CREAT] in
  lockf fd F_LOCK 0L;
  fd

(* Release the lock on the file *)
let unlock_file fd =
  lockf fd F_ULOCK 0L;
  close fd

let write_issue_report_json (issue_report: PulseSummaryPost.issue_report) =
  let json_report = [%yojson_of: PulseSummaryPost.issue_report] issue_report in
  let existing_json = read_existing_json "issue_report.json" in
  let json = append_to_json_array existing_json json_report in
  let f_json json_content fname = Yojson.Safe.to_file fname json_content;
  in
  f_json json "issue_report.json"

let report ~is_suppressed ~latent proc_desc err_log astate diagnostic  =
  let open Diagnostic in
  (*L.debug_dev "REPORT ERROR: %s\n" (get_message diagnostic);*)
  if is_suppressed && not Config.pulse_report_issues_for_tests then ()
  else
    (* Report suppressed issues with a message to distinguish them from non-suppressed issues.
       Useful for infer's tests. *)
    let extra_trace =
      if is_suppressed && Config.pulse_report_issues_for_tests then
        let depth = 0 in
        let tags = [] in
        let location = Diagnostic.get_location diagnostic in
        [Errlog.make_trace_element depth location "*** SUPPRESSED ***" tags]
      else []
    in
    let extras =
      let copy_type = get_copy_type diagnostic |> Option.map ~f:Typ.to_string in
      Jsonbug_t.{cost_polynomial= None; cost_degree= None; nullsafe_extra= None; copy_type}
    in
    (*let loc = Procdesc.get_loc proc_desc in
    let path = Location*)
    let is_vendor_func = if Config.autogenerated_check_mode then PulseOperations.check_in_vendor_world (Procname.get_method (Procdesc.get_proc_name proc_desc)) else false in
    if Config.autogenerated_check_mode && (not is_vendor_func) then(
    let issue = get_issue_type ~latent diagnostic in
    let issue_string = Format.asprintf "%a" IssueType.pp issue in
    let responsible_var = get_var diagnostic in
    let error_loc = Diagnostic.get_location diagnostic in
    let issue_report = SummaryPost.construct_issue_report proc_desc error_loc issue_string responsible_var astate in
    (*L.debug_dev "%a\n" Procdesc.pp_signature proc_desc;
    L.debug_dev "Issue location: %a\n" Location.pp error_loc;
    L.debug_dev "Issue type: %a\n" IssueType.pp issue;
    L.debug_dev "Responsible var:%s\n" responsible_var;
    L.debug_dev "State:%a\n" AbductiveDomain.sum_pp astate;*)
    write_issue_report_json issue_report;);
    Reporting.log_issue proc_desc err_log ~loc:(get_location diagnostic)
      ~ltr:(extra_trace @ get_trace diagnostic)
      ~extras Pulse
      (get_issue_type ~latent diagnostic)
      (get_message diagnostic)


let report_latent_issue proc_desc err_log latent_issue ~is_suppressed astate =
  LatentIssue.to_diagnostic latent_issue |> report ~latent:true ~is_suppressed proc_desc err_log astate


(* skip reporting on Java classes annotated with [@Nullsafe] if requested *)
let is_nullsafe_error tenv ~is_nullptr_dereference jn =
  (not Config.pulse_nullsafe_report_npe)
  && is_nullptr_dereference
  && match NullsafeMode.of_java_procname tenv jn with Default -> false | Local _ | Strict -> true


(* skip reporting for constant dereference (eg null dereference) if the source of the null value is
   not on the path of the access, otherwise the report will probably be too confusing: the actual
   source of the null value can be obscured as any value equal to 0 (or the constant) can be
   selected as the candidate for the trace, even if it has nothing to do with the error besides
   being equal to the value being dereferenced *)
let is_constant_deref_without_invalidation (invalidation : Invalidation.t) access_trace =
  match invalidation with
  | ConstantDereference _ ->
      not (Trace.has_invalidation access_trace)
  | CFree
  | CustomFree _
  | CppDelete
  | CppDeleteArray
  | EndIterator
  | GoneOutOfScope _
  | OptionalEmpty
  | StdVector _
  | JavaIterator _ ->
      false


let is_constant_deref_without_invalidation_diagnostic (diagnostic : Diagnostic.t) =
  match diagnostic with
  | ErlangError _
  | MemoryLeak _
  | ResourceLeak _
  | RetainCycle _
  | ReadUninitializedValue _
  | StackVariableAddressEscape _
  | TaintFlow _
  | UnnecessaryCopy _ ->
      false
  | AccessToInvalidAddress {invalidation; access_trace} ->
      is_constant_deref_without_invalidation invalidation access_trace


let is_suppressed tenv proc_desc ~is_nullptr_dereference ~is_constant_deref_without_invalidation
    astate =
  if is_constant_deref_without_invalidation then (
    L.d_printfln ~color:Red
      "Dropping error: constant dereference with no invalidation in the access trace" ;
    true )
  else
    match Procdesc.get_proc_name proc_desc with
    | Procname.Java jn when is_nullptr_dereference ->
        let b = is_nullsafe_error tenv ~is_nullptr_dereference jn in
        if b then (
          L.d_printfln ~color:Red "Dropping error: conflicting with nullsafe" ;
          b )
        else
          let b = not (AbductiveDomain.skipped_calls_match_pattern astate) in
          if b then
            L.d_printfln ~color:Red
              "Dropping error: skipped an unknown function not in the allow list" ;
          b
    | _ ->
        false


let summary_of_error_post tenv proc_desc location mk_error astate =
  let result = if Config.autogenerated_check_mode then AbductiveDomain.summary_of_post_no_filter tenv proc_desc location astate else 
    AbductiveDomain.summary_of_post tenv proc_desc location astate
  in
  match result with
  | Sat (Ok summary)
  | Sat (Error (`MemoryLeak (summary, _, _, _)) | Error (`ResourceLeak (summary, _, _, _)))
  | Sat (Error (`RetainCycle (summary, _, _, _, _))) ->
      (* ignore potential memory leaks: error'ing in the middle of a function will typically produce
         spurious leaks *)
      Sat (mk_error summary)
  | Sat (Error (`PotentialInvalidAccessSummary (summary, addr, trace))) ->
      (* ignore the error we wanted to report (with [mk_error]): the abstract state contained a
         potential error already so report [error] instead *)
      Sat
        (AccessResult.of_abductive_summary_error
           (`PotentialInvalidAccessSummary (summary, addr, trace)) )
  | Unsat ->
      Unsat


let summary_error_of_error tenv proc_desc location (error : AccessResult.error) :
    AccessResult.summary_error SatUnsat.t =
  match error with
  | Summary summary_error ->
      Sat summary_error
  | PotentialInvalidAccess {astate; address; must_be_valid} ->
      summary_of_error_post tenv proc_desc location
        (fun astate -> PotentialInvalidAccessSummary {astate; address; must_be_valid})
        astate
  | ReportableError {astate; diagnostic} ->
    (*L.debug_dev "ReportableError: %a\n" AbductiveDomain.pp astate;*)
      summary_of_error_post tenv proc_desc location
        (fun astate -> ReportableErrorSummary {astate; diagnostic})
        astate
  | ISLError {astate} ->
      summary_of_error_post tenv proc_desc location (fun astate -> ISLErrorSummary {astate}) astate

let report_summary_error tenv proc_desc err_log location (access_error : AccessResult.summary_error) :
    ExecutionDomain.summary option =
  match access_error with
  | PotentialInvalidAccessSummary {astate; address; must_be_valid} ->
      let invalidation = Invalidation.ConstantDereference IntLit.zero in
      let access_trace = fst must_be_valid in
      let is_constant_deref_without_invalidation =
        is_constant_deref_without_invalidation invalidation access_trace
      in
      let is_suppressed =
        is_suppressed tenv proc_desc ~is_nullptr_dereference:true
          ~is_constant_deref_without_invalidation astate
      in
      if is_suppressed then L.d_printfln "suppressed error" ;
      if Config.pulse_report_latent_issues then
        report ~latent:true ~is_suppressed proc_desc err_log astate
          (AccessToInvalidAddress
             { calling_context= []
             ; invalid_address= address
             ; invalidation= ConstantDereference IntLit.zero
             ; invalidation_trace=
                 Immediate {location= Procdesc.get_loc proc_desc; history= ValueHistory.epoch}
             ; access_trace
             ; must_be_valid_reason= snd must_be_valid } ) ;
      Some (LatentInvalidAccess {astate; address; must_be_valid; calling_context= []})
  | ISLErrorSummary {astate} ->
      Some (ISLLatentMemoryError astate)
  | ReportableErrorSummary {astate; diagnostic} -> (
      (*L.debug_dev "REPORTABLE\n";*)
      let is_nullptr_dereference =
        match diagnostic with AccessToInvalidAddress _ -> true | _ -> false
      in
      let is_constant_deref_without_invalidation =
        is_constant_deref_without_invalidation_diagnostic diagnostic
      in
      let is_suppressed =
        is_suppressed tenv proc_desc ~is_nullptr_dereference ~is_constant_deref_without_invalidation
          astate
      in
      let error_trace = Diagnostic.get_trace diagnostic in
      let error_trace_start = Errlog.get_loc_trace_start error_trace in
      let error_trace_end = Errlog.get_loc_trace_end error_trace in
      (* Since summary_of_error_post is modified to keep the state in the abort program, 
         this may confuse the should_report to think that the state is latent, thus we use 
         summary_of_post to filter the unfiltered state and then use that to check whether report
         this issue or not*)
      let summary_result = AbductiveDomain.summary_of_post tenv proc_desc location (astate :> AbductiveDomain.t) in
      let result_state = match summary_result with
      | Sat (Ok summary)
      | Sat (Error (`MemoryLeak (summary, _, _, _)) | Error (`ResourceLeak (summary, _, _, _)))
      | Sat (Error (`RetainCycle (summary, _, _, _, _))) ->
          summary
      | Sat (Error (`PotentialInvalidAccessSummary (summary, addr, trace))) ->
            summary
      | Unsat -> L.debug_dev "UNSAT DETECTED\n"; astate (* Not sure when will this come *)
      in
      match LatentIssue.should_report result_state diagnostic with
      | `ReportNow ->
          (*L.debug_dev "REPORT NOW\n";*)
          if is_suppressed then L.d_printfln "ReportNow suppressed error" ;
          report ~latent:false ~is_suppressed proc_desc err_log astate diagnostic;
          (*L.debug_dev "report: %a \n" AbductiveDomain.pp (astate :> AbductiveDomain.t);*)
          if Diagnostic.aborts_execution diagnostic then 
            Some (AbortProgram {astate; error_trace_start; error_trace_end}) 
          else None
      | `DelayReport latent_issue ->
          (*L.debug_dev "DelayReport\n";*)
          if is_suppressed then L.d_printfln "DelayReport suppressed error" ;
          if Config.pulse_report_latent_issues then
            report_latent_issue ~is_suppressed proc_desc err_log latent_issue astate ;
          Some (LatentAbortProgram {astate; latent_issue}) )


let report_error tenv proc_desc err_log location access_error =
  let open SatUnsat.Import in
  summary_error_of_error tenv proc_desc location access_error
  >>| report_summary_error tenv proc_desc err_log location


let report_errors tenv proc_desc err_log location errors =
  let open SatUnsat.Import in
  List.rev errors
  |> List.fold ~init:(Sat None) ~f:(fun sat_result error ->
         match sat_result with
         | Unsat | Sat (Some _) ->
             sat_result
         | Sat None ->
          (*let _ = (fun () -> match error with
          | AccessResult.ReportableError {astate; _} -> Logging.debug_dev "REPORT STATE: %a \n" AbductiveDomain.pp astate
          |_ -> ();) () in*)
             report_error tenv proc_desc err_log location error )


let report_exec_results tenv proc_desc err_log location results =
  List.filter_map results ~f:(fun exec_result ->
      match PulseResult.to_result exec_result with
      | Ok post ->
        (*L.debug_dev "OK\n";*)
          Some post
      | Error errors -> (
        match report_errors tenv proc_desc err_log location errors with
        | Unsat ->
            L.d_printfln "UNSAT discovered during error reporting" ;
            None
        | Sat None -> (
          match exec_result with
          | Ok _ | FatalError _ ->
              L.die InternalError
                "report_errors returned None but the result was not a recoverable error"
          | Recoverable (exec_state, _) ->
            (*L.debug_dev "Recoverable error\n";*)
              Some exec_state )
        | Sat (Some exec_state) ->
            let state = (exec_state :> ExecutionDomain.t) in
            (*L.debug_dev "Error Evaluated state: %a \n" ExecutionDomain.pp state;*)
            Some (exec_state :> ExecutionDomain.t) ) )


let report_results tenv proc_desc err_log location results =
  let open PulseResult.Let_syntax in
  List.map results ~f:(fun result ->
      let+ astate = result in
      (*L.debug_dev "Evaluated loc: %a \n" Location.pp location;
      L.debug_dev "Evaluated state: %a \n" AbductiveDomain.pp astate;*)
      ExecutionDomain.ContinueProgram astate )
  |> report_exec_results tenv proc_desc err_log location


let report_result tenv proc_desc err_log location result =
  report_results tenv proc_desc err_log location [result]
