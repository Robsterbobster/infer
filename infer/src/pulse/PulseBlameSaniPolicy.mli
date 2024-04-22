open! IStd
module F = Format

type t = 
| MemoryLeak
| UseAfterFree
| NullPointerDereference
[@@deriving compare, equal, yojson_of]

val pp : F.formatter -> t -> unit

val list_pp: F.formatter -> t list -> unit