open! IStd
module F = Format

type t = 
| Client
| Vendor
| Unknown
| Uninitialised
[@@deriving compare, variants, equal, yojson_of]

val pp : F.formatter -> t -> unit
