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

type mapping = (string * AbstractValue.t) [@@deriving yojson_of, compare]

type mappings = mapping list [@@deriving yojson_of, compare]

type info = string * Location.t [@@deriving yojson_of]

val from_lists_of_summaries : 
  (AbductiveDomain.summary ExecutionDomain.base_t * label) list -> string
  ->  t

val construct_issue_report: Procdesc.t -> Location.t -> string -> string -> AbductiveDomain.summary -> issue_report

val construct_mapping: string -> AbstractValue.t -> mapping

val append_to_mappings: mapping -> mappings -> mappings

val from_formals_actuals_lst: Pvar.t list -> AbstractValue.t list -> mappings

val construct_info : Procname.t -> Location.t -> info