open! IStd
module F = Format

(* TODO: convert these tags into actual conflict handling policy *)
type t = 
| Update
[@@deriving compare, equal, yojson_of]

let pp fmt policy = 
  match policy with
  | Update -> F.fprintf fmt "Update"

let list_pp fmt property_ls =
  (fun () -> 
    F.fprintf fmt "[";
    List.iter property_ls (fun prop -> pp fmt prop; F.fprintf fmt ";");
    F.fprintf fmt "]";
  ) ()