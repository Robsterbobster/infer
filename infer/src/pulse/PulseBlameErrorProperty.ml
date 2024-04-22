open! IStd
module F = Format

(* TODO: convert these tags into actual ISL formulae *)
type t = 
| MemoryLeak
| UseAfterFree
| NullPointerDereference
[@@deriving compare, equal, yojson_of]

let pp fmt property = 
  match property with
  | MemoryLeak -> F.fprintf fmt "MemLeak"
  | UseAfterFree -> F.fprintf fmt "UseAfterFree"
  | NullPointerDereference -> F.fprintf fmt "NPE"

let list_pp fmt property_ls =
  (fun () -> 
    F.fprintf fmt "[";
    List.iter property_ls (fun prop -> pp fmt prop; F.fprintf fmt ";");
    F.fprintf fmt "]";
  ) ()
  