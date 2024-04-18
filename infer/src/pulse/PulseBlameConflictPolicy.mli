open! IStd
module F = Format

type t = 
| RemoveClient
| RemoveVendor
[@@deriving compare, variants, equal, yojson_of]

val pp : F.formatter -> t -> unit

val list_pp: F.formatter -> t list -> unit