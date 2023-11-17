(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd

val checker : PulseSummary.t InterproceduralAnalysis.t -> PulseSummary.t option

val get_autocode_proc_name: SourceFile.t -> Procname.t

val get_autocode_function_procname: unit -> Procname.t