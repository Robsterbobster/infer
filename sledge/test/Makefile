# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

# additional arguments to pass to clang
CLANG_ARGS?=-O0 -Xclang -disable-O0-optnone

# executable to test
SLEDGE_DBG:=$(CURDIR)/../_build/debug/cli/sledge_cli.exe
SLEDGE_OPT:=$(CURDIR)/../_build/release/cli/sledge_cli.exe

# sledge config file
export SLEDGE_CONFIG:=$(CURDIR)/config

# additional arguments to pass to sledge translate, disassemble, analyze, smt, and report
SLEDGE_T_ARGS?=
SLEDGE_D_ARGS?=
SLEDGE_A_ARGS?=-loop-bound 5 -switch-bound 3 -cct-schedule-points
SLEDGE_S_ARGS?=
SLEDGE_R_ARGS?=
SLEDGE_G_ARGS?=-trace Stop.on_reached_goal

# limits for each test run
TIMEOUT?=300
MEMOUT?=6

sledge_dbg:=./wrap.sh $(TIMEOUT) $(MEMOUT) $(SLEDGE_DBG)
sledge_opt:=./wrap.sh $(TIMEOUT) $(MEMOUT) $(SLEDGE_OPT)

sledge_report:=$(shell \ls -t1 $(CURDIR)/../_build/*/report/sledge_report.exe | head -1)

# read list of disabled tests if EXCLUDE_DISABLED=1
EXCLUDE_DISABLED?=
ifeq ($(EXCLUDE_DISABLED),1)
  grep_disabled:=grep -v -f disabled
else
  grep_disabled:=cat
endif

# parallel args
PARALLEL_ARGS?=--bar

parallel:=parallel $(PARALLEL_ARGS)

# which utilities to use
diff?=patdiff

# select llvm and clang used by opam
export PATH:=$(shell $$(opam var conf-llvm:config) --bindir):$(PATH)

# query llvm-config for compilation flags
C_FLAGS:=$(shell $$(opam var conf-llvm:config) --cflags)
CXX_FLAGS:=$(shell $$(opam var conf-llvm:config) --cxxflags) -fexceptions

# configure sort
export LC_ALL:=C

default: test

llair_intrinsics_h:=$(CURDIR)/../model/llair_intrinsics.h

# compile c to llvm bitcode
%.bc : %.c $(llair_intrinsics)
	clang -g -c -emit-llvm $(C_FLAGS) -include $(llair_intrinsics_h) -Wno-main-return-type $(CLANG_ARGS) -o $@ $<

# compile c++ to llvm bitcode
%.bc : %.cpp
	clang++ -g -c -emit-llvm $(CXX_FLAGS) $(CLANG_ARGS) -o $@ $<

# disassemble bitcode to llvm assembly
%.ll : %.bc
	llvm-dis -show-annotations -o $@ $<

%.bllair : %.bc
	$(SLEDGE_DBG) llvm translate $< -output $@

%.llair %.opt.bc : %.bc
	$(SLEDGE_DBG) llvm disassemble $< -llair-output $*.llair -dump-bitcode $*.opt.bc

%.llair %.opt.bc : %.ll
	$(SLEDGE_DBG) llvm disassemble $< -llair-output $*.llair -dump-bitcode $*.opt.bc

# code to test sledge translate
TranslateCs:=$(shell find -L {,local/}translate -name '*.c' 2>/dev/null)
TranslateCPPs:=$(shell find -L {,local/}translate -name '*.cpp' 2>/dev/null)
TranslateGenBCs:=$(TranslateCs:.c=.bc) $(TranslateCPPs:.cpp=.bc)
TranslateBCs:=$(TranslateGenBCs) $(shell find -L extra/translate -name '*.bc' 2>/dev/null)
TranslateLLs:=$(shell find -L {,local/}translate -name '*.ll' 2>/dev/null)
TranslateTests:=$(TranslateBCs) $(TranslateLLs)
TranslateTests:=$(shell echo $(TranslateTests) | tr ' ' '\n' | $(grep_disabled))

# code to test sledge analyze
AnalyzeCs:=$(shell find -L {,local/}analyze -name '*.c' 2>/dev/null)
AnalyzeCPPs:=$(shell find -L {,local/}analyze -name '*.cpp' 2>/dev/null)
AnalyzeGenBCs:=$(AnalyzeCs:.c=.bc) $(AnalyzeCPPs:.cpp=.bc)
AnalyzeBCs:=$(AnalyzeGenBCs) $(shell find -L extra/analyze -name '*.bc' 2>/dev/null)
AnalyzeLLs:=$(shell find -L {,local/}analyze -name '*.ll' 2>/dev/null)
AnalyzeTests:=$(AnalyzeBCs) $(AnalyzeLLs)
AnalyzeTests:=$(shell echo $(AnalyzeTests) | tr ' ' '\n' | $(grep_disabled))

# code to test sledge analyze in goal-directed mode
GoalCs:=$(shell find -L {,local/}goal -name '*.c' 2>/dev/null)
GoalCPPs:=$(shell find -L {,local/}goal -name '*.cpp' 2>/dev/null)
GoalGenBCs:=$(GoalCs:.c=.bc) $(GoalCPPs:.cpp=.bc)
GoalBCs:=$(GoalGenBCs) $(shell find -L extra/goal -name '*.bc' 2>/dev/null)
GoalTests:=$(shell echo $(GoalGenBCs) | tr ' ' '\n' | $(grep_disabled))

GeneratedBCs:=$(TranslateGenBCs) $(AnalyzeGenBCs) $(GoalGenBCs)

# compile all c/c++ to bc
.PHONY: compile
compile:
	$(MAKE) -j $(GeneratedBCs)
	@if [ -d "extra" ]; then \
	   $(MAKE) sledge=$(SLEDGE_DBG) -C extra compile; \
	 fi

#
# translation (frontend) tests
#

# run sledge llvm translate tests
.PHONY: translate
translate: compile
	-$(parallel) $(sledge_dbg) llvm disassemble $(SLEDGE_D_ARGS) ::: $(TranslateTests)

.PHONY: translate.sexp
translate.sexp:
	find -L {,local/,extra/}translate -not -path 'baseline/*' -name '*.sexp' 2>/dev/null | xargs cat > translate.sexp

baseline/translate.sexp: translate.sexp
	cp translate.sexp $@

translate.html: translate.sexp
	$(sledge_report) html $(SLEDGE_R_ARGS) -baseline baseline/translate.sexp translate.sexp -output $@

translate-status: translate.sexp
	$(sledge_report) status -baseline baseline/translate.sexp translate.sexp | column -ts$$'\t'

#
# analyze (backend) tests
#

# run analyze tests
.PHONY: analyze
analyze: compile
	-$(parallel) --use-cores-instead-of-threads $(sledge_dbg) llvm analyze -trace Report+Control $(SLEDGE_A_ARGS) ::: $(shell $(sledge_report) sort -baseline baseline/analyze.sexp $(AnalyzeTests))

parallel_sledge_opt:=$(parallel) --use-cores-instead-of-threads $(sledge_opt) llvm analyze -append-report $(SLEDGE_A_ARGS) :::

analyze-perf1: compile
	-@$(parallel_sledge_opt) $(shell $(sledge_report) sort -baseline baseline/analyze.sexp $(AnalyzeTests))

analyze-perf3: compile
	-@$(parallel_sledge_opt) $(shell $(sledge_report) sort -baseline baseline/analyze.sexp $(AnalyzeTests) $(AnalyzeTests) $(AnalyzeTests))

analyze-perf5: compile
	-@$(parallel_sledge_opt) $(shell $(sledge_report) sort -baseline baseline/analyze.sexp $(AnalyzeTests) $(AnalyzeTests) $(AnalyzeTests) $(AnalyzeTests) $(AnalyzeTests))

analyze-perf7: compile
	-@$(parallel_sledge_opt) $(shell $(sledge_report) sort -baseline baseline/analyze.sexp $(AnalyzeTests) $(AnalyzeTests) $(AnalyzeTests) $(AnalyzeTests) $(AnalyzeTests) $(AnalyzeTests) $(AnalyzeTests))

# for each `goal/<foo>.c` or `goal/<foo>.cpp`, analyze with goal trace `goal/<foo>.trace`
analyze-goal: compile
	$(foreach test,$(GoalTests), \
	$(sledge_dbg) llvm analyze -goal-trace $(shell cat $(test:.bc=.trace)) $(SLEDGE_A_ARGS) $(SLEDGE_G_ARGS) $(test);)

.PHONY: analyze.sexp
analyze.sexp:
	find -L {,local/,extra/}analyze {,local/,extra/}goal -not -path 'baseline/*' -name '*.sexp' 2>/dev/null | xargs cat > analyze.sexp

baseline/analyze.sexp: analyze.sexp
	cp analyze.sexp $@

analyze.html: analyze.sexp
	$(sledge_report) html $(SLEDGE_R_ARGS) -baseline baseline/analyze.sexp analyze.sexp -output $@

analyze-status: analyze.sexp
	$(sledge_report) status -baseline baseline/analyze.sexp analyze.sexp | column -ts$$'\t' ; exit $${PIPESTATUS[0]}

#
# smt tests
#

SmtTests:=$(shell find smt -name '*.smt2' 2>/dev/null)
SmtTests:=$(shell echo $(SmtTests) | tr ' ' '\n' | $(grep_disabled))

# run sledge smt tests
.PHONY: smt
smt:
	-$(parallel) $(sledge_dbg) smt $(SLEDGE_S_ARGS) ::: $(SmtTests)

parallel_sledge_opt_smt:=$(parallel) --use-cores-instead-of-threads --shuf $(sledge_opt) smt -append-report $(SLEDGE_S_ARGS) :::

smt-perf1:
	-@$(parallel_sledge_opt_smt) $(SmtTests)

smt-perf3:
	-@$(parallel_sledge_opt_smt) $(SmtTests) $(SmtTests) $(SmtTests)

smt-perf5:
	-@$(parallel_sledge_opt_smt) $(SmtTests) $(SmtTests) $(SmtTests) $(SmtTests) $(SmtTests)

smt-perf7:
	-@$(parallel_sledge_opt_smt) $(SmtTests) $(SmtTests) $(SmtTests) $(SmtTests) $(SmtTests) $(SmtTests) $(SmtTests)

.PHONY: smt.sexp
smt.sexp:
	find -L {,local/,extra/}smt -not -path 'baseline/*' -name '*.sexp' 2>/dev/null | xargs cat > smt.sexp

baseline/smt.sexp: smt.sexp
	cp smt.sexp $@

smt.html: smt.sexp
	$(sledge_report) html $(SLEDGE_R_ARGS) -baseline baseline/smt.sexp smt.sexp -output $@

smt-status: smt.sexp
	$(sledge_report) status -baseline baseline/smt.sexp smt.sexp | column -ts$$'\t'

#
# llvm tests
#

# run sledge llvm translate tests
.PHONY: llvm
llvm:
	-find -L llvm -name '*.ll' -or -name '*.bc' 2>/dev/null | $(grep_disabled) | $(parallel) $(sledge_dbg) llvm translate -no-internalize $(SLEDGE_T_ARGS)

.PHONY: llvm.sexp
llvm.sexp:
	find -L {,local/,extra/}llvm -not -path 'baseline/*' -name '*.sexp' 2>/dev/null | xargs cat > llvm.sexp

baseline/llvm.sexp: llvm.sexp
	cp llvm.sexp $@

llvm.html: llvm.sexp
	$(sledge_report) html $(SLEDGE_R_ARGS) -baseline baseline/llvm.sexp llvm.sexp -output $@

llvm-status: llvm.sexp
	$(sledge_report) status -baseline baseline/llvm.sexp llvm.sexp | column -ts$$'\t'

#
# test workflow
#

# report warnings
warnings:
	find -L * -name '*.out' | xargs grep -h "Warning:" | sort

test-translate:
	-rm $(TranslateTests:=.sexp) $(TranslateTests:=.out) $(TranslateTests:=.err) $(TranslateTests:=.bllair) $(TranslateTests:=.llair) 2>/dev/null
	-$(MAKE) --no-print-directory translate
	$(MAKE) --no-print-directory translate-status

test-analyze:
	-rm $(AnalyzeTests:=.sexp) $(AnalyzeTests:=.out) $(AnalyzeTests:=.err) 2>/dev/null
	-$(MAKE) --no-print-directory analyze analyze-goal
	$(MAKE) --no-print-directory analyze-status

test-smt:
	-rm $(SmtTests:=.sexp) $(SmtTests:=.out) $(SmtTests:=.err) 2>/dev/null
	-$(MAKE) --no-print-directory smt
	$(MAKE) --no-print-directory smt-status

test-llvm:
	-find -L {,local/,extra/}llvm \( -name "*.sexp" -or -name "*.out" -or -name '*.err' -or -name '*.bllair' \) -delete 2>/dev/null
	-$(MAKE) --no-print-directory llvm
	$(MAKE) --no-print-directory llvm-status

# run tests and check against expected results
test: test-translate translate.html test-analyze analyze.html

# set current results as new expected results
promote: baseline/translate.sexp baseline/analyze.sexp baseline/smt.sexp baseline/llvm.sexp

# copy the current out and err files to the baseline dir
promote-out:
	find -L * -not -path 'baseline/*' \( -name '*.out' -or -name '*.err' \) | xargs gcp --parents -t baseline

# diff the current out files against the ones in the baseline dir
diff-out:
	$(diff) -mask-uniques -include '.*\.out' baseline -alt-next current .

# diff the current err files against the ones in the baseline dir
diff-err:
	$(diff) -mask-uniques -include '.*\.err' baseline -alt-next current .

# exclude local, extra, and flaky tests from status report
sledge_report_status_stable =\
  $(sledge_report) status $(1).sexp | $(grep_disabled) | sort

# set current status results as new expected status results
internal-promote-status:
	@for kind in translate analyze smt llvm ; do \
	  $(call sledge_report_status_stable,$$kind) \
	  > status/$$kind ; \
	done

# check that current status results match expected results
internal-test-status:
	@for kind in translate analyze smt llvm ; do \
	  $(call sledge_report_status_stable,$$kind) \
	  | diff status/$$kind - ; \
	done | ( ! grep ^ )

promote-status:
	@$(MAKE) --no-print-directory EXCLUDE_DISABLED=1 internal-promote-status

test-status:
	@$(MAKE) --no-print-directory EXCLUDE_DISABLED=1 internal-test-status

# run all tests and check status
ci-test:
	-$(MAKE) --keep-going --jobs PARALLEL_ARGS= EXCLUDE_DISABLED=1 test-translate test-analyze test-smt test-llvm
	$(MAKE) test-status

# remove generated bitcode files
cleanbc:
	rm -f $(GeneratedBCs)

# remove result files
cleanout:
	find -L * \( -not -path 'baseline/*' -name "*.sexp" -or -name "*.out" -or -name '*.err' -or -name '*.bllair' -or -name '*.llair' \) -delete

clean: cleanbc cleanout

AnalyzeHs:=$(shell find -L {,local/}analyze -name '*.h' 2>/dev/null)

fmt:
	clang-format -i $(AnalyzeHs) $(AnalyzeCs) $(AnalyzeCPPs) $(GoalCs) $(GoalCPPs) $(TranslateCs) $(TranslateCPPs)

# print any variable for Makefile debugging
print-%:
	@printf '$($*)'; printf '\n'
