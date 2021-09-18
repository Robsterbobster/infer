(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)
open! IStd
module L = Logging
module F = Format

let debug () =
  if not Config.(global_tenv || procedures || source_files) then
    L.die UserError
      "Expected at least one of '--global-tenv', '--procedures' or '--source_files'.@\n"
  else (
    ( if Config.global_tenv then
      match Tenv.load_global () with
      | None ->
          L.result "No global type environment was found.@."
      | Some tenv ->
          L.result "Global type environment:@\n@[<v>%a@]" Tenv.pp tenv ) ;
    ( if Config.procedures then
      let filter = Lazy.force Filtering.procedures_filter in
      if Config.procedures_summary || Config.procedures_summary_json then
        let f_console_output proc_names =
          let pp_summary fmt proc_name =
            match Summary.OnDisk.get proc_name with
            | None ->
                F.fprintf fmt "No summary found: %a@\n" Procname.pp proc_name
            | Some summary ->
                Summary.pp_text fmt summary
          in
          L.result "%t" (fun fmt -> List.iter proc_names ~f:(pp_summary fmt))
        in
        let json_of_summary proc_name =
          Summary.OnDisk.get proc_name |> Option.map ~f:Summary.yojson_of_t
        in
        let f_json proc_names =
          Yojson.Safe.to_channel stdout (`List (List.filter_map ~f:json_of_summary proc_names)) ;
          Out_channel.newline stdout ;
          Out_channel.flush stdout
        in
        Option.iter
          (Procedures.select_proc_names_interactive ~filter)
          ~f:(if Config.procedures_summary_json then f_json else f_console_output)
      else
        L.result "%a"
          Config.(
            Procedures.pp_all ~filter ~proc_name:procedures_name ~attr_kind:procedures_definedness
              ~source_file:procedures_source_file ~proc_attributes:procedures_attributes
              ~proc_cfg:procedures_cfg)
          () ) ;
    if Config.source_files then (
      let filter = Lazy.force Filtering.source_files_filter in
      L.result "%a"
        (SourceFiles.pp_all ~filter ~type_environment:Config.source_files_type_environment
           ~procedure_names:Config.source_files_procedure_names
           ~freshly_captured:Config.source_files_freshly_captured )
        () ;
      if Config.source_files_cfg then (
        let source_files = SourceFiles.get_all ~filter () in
        List.iter source_files ~f:(fun source_file ->
            (* create directory in captured/ *)
            DB.Results_dir.init ~debug:true source_file ;
            (* collect the CFGs for all the procedures in [source_file] *)
            let proc_names = SourceFiles.proc_names_of_source source_file in
            let cfgs = Procname.Hash.create (List.length proc_names) in
            List.iter proc_names ~f:(fun proc_name ->
                Procdesc.load proc_name
                |> Option.iter ~f:(fun cfg -> Procname.Hash.add cfgs proc_name cfg) ) ;
            (* emit the dot file in captured/... *)
            DotCfg.emit_frontend_cfg source_file cfgs ) ;
        L.result "CFGs written in %s/*/%s@." (ResultsDir.get_path Debug)
          Config.dotty_frontend_output ) ) )


let explore () =
  if (* explore bug traces *)
     Config.html then
    TraceBugs.gen_html_report ~report_json:(ResultsDir.get_path ReportJson)
      ~show_source_context:Config.source_preview ~max_nested_level:Config.max_nesting
      ~report_html_dir:(ResultsDir.get_path ReportHtml)
  else
    TraceBugs.explore ~selector_limit:None ~report_json:(ResultsDir.get_path ReportJson)
      ~report_txt:(ResultsDir.get_path ReportText) ~selected:Config.select
      ~show_source_context:Config.source_preview ~max_nested_level:Config.max_nesting


let help () =
  if
    Config.(
      list_checkers || list_issue_types || Option.is_some write_website
      || (not (List.is_empty help_checker))
      || not (List.is_empty help_issue_type))
  then (
    if Config.list_checkers then Help.list_checkers () ;
    if Config.list_issue_types then Help.list_issue_types () ;
    if not (List.is_empty Config.help_checker) then Help.show_checkers Config.help_checker ;
    if not (List.is_empty Config.help_issue_type) then Help.show_issue_types Config.help_issue_type ;
    Option.iter Config.write_website ~f:(fun website_root -> Help.write_website ~website_root) ;
    () )
  else
    L.result
      "To see Infer's manual, run `infer --help`.@\n\
       To see help about the \"help\" command itself, run `infer help --help`.@\n"


let report () =
  let write_from_json out_path =
    IssuesTest.write_from_json ~json_path:Config.from_json_report ~out_path
      Config.issues_tests_fields
  in
  let write_from_cost_json out_path =
    CostIssuesTest.write_from_json ~json_path:Config.from_json_costs_report ~out_path
      CostIssuesTestField.all_fields
  in
  let write_from_config_impact_json out_path =
    ConfigImpactIssuesTest.write_from_json ~json_path:Config.from_json_config_impact_report
      ~out_path
  in
  match (Config.issues_tests, Config.cost_issues_tests, Config.config_impact_issues_tests) with
  | None, None, None ->
      L.die UserError
        "Expected at least one of '--issues-tests', '--cost-issues-tests' or \
         '--config-impact-issues-tests'.@\n"
  | out_path, cost_out_path, config_impact_out_path ->
      Option.iter out_path ~f:write_from_json ;
      Option.iter cost_out_path ~f:write_from_cost_json ;
      Option.iter config_impact_out_path ~f:write_from_config_impact_json


let report_diff () =
  (* at least one report must be passed in input to compute differential *)
  match
    Config.
      ( report_current
      , report_previous
      , costs_current
      , costs_previous
      , config_impact_current
      , config_impact_previous )
  with
  | None, None, None, None, None, None ->
      L.die UserError
        "Expected at least one argument among '--report-current', '--report-previous', \
         '--costs-current', '--costs-previous', '--config-impact-current', and \
         '--config-impact-previous'\n"
  | _ ->
      ReportDiff.reportdiff ~current_report:Config.report_current
        ~previous_report:Config.report_previous ~current_costs:Config.costs_current
        ~previous_costs:Config.costs_previous ~current_config_impact:Config.config_impact_current
        ~previous_config_impact:Config.config_impact_previous
