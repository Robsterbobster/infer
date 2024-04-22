open! IStd
module F = Format

(* TODO: convert these tags into actual sanitisation handling policy *)
type t = 
| MemoryLeak
| UseAfterFree
| NullPointerDereference
[@@deriving compare, equal, yojson_of]

let pp fmt policy = 
  match policy with
  | MemoryLeak -> F.fprintf fmt "MLHand"
  | UseAfterFree -> F.fprintf fmt "UAFHand"
  | NullPointerDereference -> F.fprintf fmt "NPEHand"

let list_pp fmt property_ls =
  (fun () -> 
    F.fprintf fmt "[";
    List.iter property_ls (fun prop -> pp fmt prop; F.fprintf fmt ";");
    F.fprintf fmt "]";
  ) ()