open! IStd
module F = Format

type t = 
| Client
| Vendor
| Unknown
| Uninitialised
[@@deriving compare, variants, equal, yojson_of]

let pp fmt entity = 
  match entity with
  | Client -> F.fprintf fmt "Client"
  | Vendor -> F.fprintf fmt "Vendor"
  | Unknown -> F.fprintf fmt "Unknown"
  | Uninitialised -> F.fprintf fmt "Uninitialised"