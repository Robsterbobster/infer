open! IStd
module F = Format
module L = Logging
module IRAttributes = Attributes
open PulseBasicInterface
open PulseDomainInterface
open PulseOperations.Import

type responsible_address = string [@@deriving yojson_of]

type start_end_loc = int * int * responsible_address [@@deriving yojson_of]

type label =
  | Ok of start_end_loc
  | ExitProgram of start_end_loc
  | ErrorRetainCycle of start_end_loc
  | ErrorMemoryLeak of start_end_loc
  | ErrorResourceLeak of start_end_loc
  | AbortProgram of start_end_loc
  | LatentAbortProgram of start_end_loc
  | InvalidAccess of start_end_loc
  | LatentInvalidAccess of start_end_loc
  | ISLLatentMemoryError of start_end_loc
[@@deriving yojson_of]

(* Function name, Location, Issue type, resposible address, summary*)
type issue_report = string * Location.t * string * string * (AbductiveDomain.summary) [@@deriving yojson_of]

type summary_post = label * string * (AbductiveDomain.summary) [@@deriving yojson_of]

type t = summary_post list [@@deriving yojson_of]

type mapping = string * AbstractValue.t [@@deriving yojson_of]

type mappings = mapping list [@@deriving yojson_of]

type info = string * string * int * int [@@deriving yojson_of]

type context = (info * AbductiveDomain.t) [@@deriving yojson_of]

(* From the computed summary with label, construct a structure for dumping information. *)
let construct_summary_post (summary_label : AbductiveDomain.summary ExecutionDomain.base_t * label) (path: string)=
  let summary, label = summary_label in
    (* The meta data in summary is already captured by labels;
        strip those and standardize the format of summary. *)
    match summary with
    | ContinueProgram astate 
    | ExceptionRaised astate
    | ExitProgram astate
    | AbortProgram {astate; _; }
    | LatentAbortProgram {astate; _ }
    | LatentInvalidAccess {astate; _; }
    | ISLLatentMemoryError astate ->
      label, path, astate


let construct_issue_report (proc_desc: (Procdesc.t)) (location: Location.t) (issue_type : string) (responsible_address: string) (summary: AbductiveDomain.summary) = 
  let procname = Procdesc.get_proc_name proc_desc in
  let func_name = Procname.get_method procname in
  (func_name, location, issue_type, responsible_address, summary)

let from_lists_of_summaries summary_labels path=
  let result_list = List.map summary_labels ~f:(fun summary -> construct_summary_post summary path) in
  result_list

let construct_mapping (formal: (Pvar.t)) (actual: (AbstractValue.t)) = (Mangled.to_string (Pvar.get_name formal), actual)

let from_formals_actuals_lst (formals: (Pvar.t list)) (actuals: (AbstractValue.t list))= 
  let result_list = List.map2 formals actuals ~f:construct_mapping in
  match result_list with
  | List.Or_unequal_lengths.Ok lst -> lst
  | List.Or_unequal_lengths.Unequal_lengths -> []  

  
let construct_info (proc_name:(Procname.t)) (file_path:(string)) (line_num: (int)) (column_num: (int)) = Procname.get_method proc_name, file_path, line_num, column_num

let construct_context (proc_name:(Procname.t)) (file_path:(string)) (line_num: (int)) (column_num: (int)) (summary: AbductiveDomain.t)= 
  let info = construct_info proc_name file_path line_num column_num in
  (info, summary)