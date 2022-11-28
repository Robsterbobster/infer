(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd
module F = Format
module L = Logging
open PulseBasicInterface
open PulseDomainInterface
module SummaryPost = PulseSummaryPost

type t = ExecutionDomain.summary list [@@deriving yojson_of]

let pp fmt pre_posts =
  F.open_vbox 0 ;
  F.fprintf fmt "%d pre/post(s)@;" (List.length pre_posts) ;
  List.iteri pre_posts ~f:(fun i (pre_post : ExecutionDomain.summary) ->
      F.fprintf fmt "#%d: @[%a@]@;" i ExecutionDomain.pp (pre_post :> ExecutionDomain.t) ) ;
  F.close_box ()

(* Since error situation is decided here, also return an error label *)
let exec_summary_of_post_common tenv ~continue_program proc_desc err_log location
    (exec_astate : ExecutionDomain.t) : (_ ExecutionDomain.base_t * SummaryPost.label) SatUnsat.t =
  match exec_astate with
  | ExceptionRaised _ ->
      Unsat (* we do not propagate exception interproceduraly yet *)
  | ContinueProgram astate -> (
      let open SatUnsat.Import in
      let+ summary_result = AbductiveDomain.summary_of_post tenv proc_desc location astate in
      match (summary_result : _ result) with
      | Ok astate ->
          continue_program astate, SummaryPost.Ok
      | Error (`RetainCycle (astate, assignment_traces, value, path, location)) ->
          let real_summary = PulseReport.report_summary_error tenv proc_desc err_log
            (ReportableErrorSummary
               {astate; diagnostic= RetainCycle {assignment_traces; value; path; location}} )
          |> Option.value ~default:(ExecutionDomain.ContinueProgram astate)
          in real_summary, SummaryPost.ErrorRetainCycle
      | Error (`MemoryLeak (astate, allocator, allocation_trace, location)) ->
          let real_summary = PulseReport.report_summary_error tenv proc_desc err_log
            (ReportableErrorSummary
               {astate; diagnostic= MemoryLeak {allocator; allocation_trace; location}} )
          |> Option.value ~default:(ExecutionDomain.ContinueProgram astate)
          in real_summary, SummaryPost.ErrorMemoryLeak
      | Error (`ResourceLeak (astate, class_name, allocation_trace, location)) ->
          let real_summary = PulseReport.report_summary_error tenv proc_desc err_log
            (ReportableErrorSummary
               {astate; diagnostic= ResourceLeak {class_name; allocation_trace; location}} )
          |> Option.value ~default:(ExecutionDomain.ContinueProgram astate)
          in real_summary, SummaryPost.ErrorResourceLeak
      | Error
          (`PotentialInvalidAccessSummary
            ((astate : AbductiveDomain.summary), address, must_be_valid) ) -> (
        match
          AbductiveDomain.find_post_cell_opt
            (Decompiler.abstract_value_of_expr address)
            (astate :> AbductiveDomain.t)
          |> Option.bind ~f:(fun (_, attrs) -> Attributes.get_invalid attrs)
        with
        | None ->
            let real_summary = ExecutionDomain.LatentInvalidAccess {astate; address; must_be_valid; calling_context= []}
            in real_summary, SummaryPost.LatentInvalidAccess
        | Some (invalidation, invalidation_trace) ->
            (* NOTE: this probably leads to the error being dropped as the access trace is unlikely to
               contain the reason for invalidation and thus we will filter out the report. TODO:
               figure out if that's a problem. *)
            let real_summary = PulseReport.report_summary_error tenv proc_desc err_log
              (ReportableErrorSummary
                 { diagnostic=
                     AccessToInvalidAddress
                       { calling_context= []
                       ; invalid_address= address
                       ; invalidation
                       ; invalidation_trace
                       ; access_trace= fst must_be_valid
                       ; must_be_valid_reason= snd must_be_valid }
                 ; astate } )
            |> Option.value ~default:(ExecutionDomain.ContinueProgram astate)
            in real_summary, SummaryPost.ErrorInvalidAccess ) )
  (* already a summary but need to reconstruct the variants to make the type system happy :( *)
  | AbortProgram astate ->
      Sat (AbortProgram astate, SummaryPost.AbortProgram)
  | ExitProgram astate ->
      Sat (ExitProgram astate, SummaryPost.ExitProgram)
  | LatentAbortProgram {astate; latent_issue} ->
      Sat (LatentAbortProgram {astate; latent_issue}, SummaryPost.LatentAbortProgram)
  | LatentInvalidAccess {astate; address; must_be_valid; calling_context} ->
      Sat (LatentInvalidAccess {astate; address; must_be_valid; calling_context}, SummaryPost.LatentInvalidAccess)
  | ISLLatentMemoryError astate ->
      Sat (ISLLatentMemoryError astate, SummaryPost.ISLLatentMemoryError)


let force_exit_program tenv proc_desc err_log post exec_state =
  let summary_label = exec_summary_of_post_common tenv proc_desc err_log post exec_state ~continue_program:(fun astate ->
      ExitProgram astate )
  in match summary_label with
    | Unsat -> Unsat
    | Sat inner -> Sat (fst inner)


let write_summary_and_posts_json (posts : ExecutionDomain.t list) summary_labels =
  let ok_states_from_posts = List.map posts ~f:(fun exec_astate ->
    match exec_astate with
    | ContinueProgram astate -> Some astate
    | _                      -> None
  )
  in
  (* Note that, here, ContinueProgram in exec_astate may still have error *)
  let summary_posts = SummaryPost.from_lists_of_states_and_summaries ok_states_from_posts summary_labels in
  let json_summary_posts = [%yojson_of: SummaryPost.t] summary_posts in
  let f_json json_content fname = Yojson.Safe.to_file fname json_content;
    (* Yojson.Safe.to_channel stdout json_content;
    Out_channel.newline stdout;
    Out_channel.flush stdout; *)
  in
  f_json json_summary_posts "summary_posts.json"


let of_posts tenv proc_desc err_log location posts =
  let summary_labels = List.mapi posts ~f:(fun i exec_state ->
      L.d_printfln "Creating spec out of state #%d:@\n%a" i ExecutionDomain.pp exec_state ;
      exec_summary_of_post_common tenv proc_desc err_log location exec_state
        ~continue_program:(fun astate -> ContinueProgram astate)
      |> SatUnsat.sat )
  in
  let () = write_summary_and_posts_json posts summary_labels in
  let filtered_summary_labels = List.filter_map summary_labels ~f:(fun x -> x) in
  List.map filtered_summary_labels ~f:fst


(* let of_posts tenv proc_desc err_log location posts =
  List.filter_mapi posts ~f:(fun i exec_state ->
      L.d_printfln "Creating spec out of state #%d:@\n%a" i ExecutionDomain.pp exec_state ;
      exec_summary_of_post_common tenv proc_desc err_log location exec_state
        ~continue_program:(fun astate -> ContinueProgram astate)
      |> SatUnsat.sat ) *)
