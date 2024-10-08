###Makefile for UVM Testbench -- Router_1x3

SIMULATOR = VCS

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64


RTL= ../rtl/*
work= work #library name
SVTB1= ../tb/router_top.sv
INC = +incdir+../tb +incdir+../test +incdir+../router_write_agent_top +incdir+../router_read_agent_top
SVTB2 = ../test/router_pkg.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"


help:
	@echo ==================================================================================================================
	@echo "! USAGE          --  make target                                                                                 !"
	@echo "! clean          =>  clean the earlier log and intermediate files.                                               !"
	@echo "! sv_cmp         =>  Create library and compile the code.                                                        !"
	@echo "! run_test       =>  clean, compile & run the simulation for router_small_pkt_test in batch mode.               	!"
	@echo "! run_test1      =>  clean, compile & run the simulation for router_medium_pkt_test in batch mode.               !"
	@echo "! run_test2      =>  clean, compile & run the simulation for router_big_pkt_test in batch mode.                  !"
	@echo "! run_test3      =>  clean, compile & run the simulation for router_bad_pkt_test in batch mode.                  !"
	@echo "! view_wave1 =>  To view the waveform of router_small_pkt_test                                                   !"
	@echo "! view_wave2 =>  To view the waveform of router_medium_pkt_test                                                  !"
	@echo "! view_wave3 =>  To view the waveform of router_big_pkt_test                                                     !"
	@echo "! view_wave4 =>  To view the waveform of router_bad_pkt_test                                                     !"
	@echo "! regress    =>  clean, compile and run all testcases in batch mode.                                             !"
	@echo "! report     =>  To merge coverage reports for all testcases and  convert to html format.                        !"
	@echo "! covhtml    =>  To open merged coverage report in html format.                                                  !"
	@echo ====================================================================================================================

clean      : clean_$(SIMULATOR)
sv_cmp     : sv_cmp_$(SIMULATOR)
run_test   : run_test_$(SIMULATOR)
run_test1  : run_test1_$(SIMULATOR)
run_test2  : run_test2_$(SIMULATOR)
run_test3  : run_test3_$(SIMULATOR)
view_wave1 : view_wave1_$(SIMULATOR)
view_wave2 : view_wave2_$(SIMULATOR)
view_wave3 : view_wave3_$(SIMULATOR)
view_wave4 : view_wave4_$(SIMULATOR)
regress    : regress_$(SIMULATOR)
report     : report_$(SIMULATOR)
cov        : cov_$(SIMULATOR)
covhtml    : covhtml_$(SIMULATOR)

# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb  -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test_VCS:   clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave1.fsdb -cm_dir ./mem_cov1 +ntb_random_seed_automatic +UVM_TESTNAME=router_small_pkt_test
	urg -dir mem_cov1.vdb -format both -report urgReport1

run_test1_VCS:
	./simv -a vcs.log +fsdbfile+wave2.fsdb -cm_dir ./mem_cov2 +ntb_random_seed_automatic +UVM_TESTNAME=router_medium_pkt_test
	urg -dir mem_cov2.vdb -format both -report urgReport2

run_test2_VCS:
	./simv -a vcs.log +fsdbfile+wave3.fsdb -cm_dir ./mem_cov3 +ntb_random_seed_automatic +UVM_TESTNAME=router_big_pkt_test
	urg -dir mem_cov3.vdb -format both -report urgReport3

run_test3_VCS:
	./simv -a vcs.log +fsdbfile+wave4.fsdb -cm_dir ./mem_cov4 +ntb_random_seed_automatic +UVM_TESTNAME=router_bad_pkt_test
	urg -dir mem_cov4.vdb -format both -report urgReport4

view_wave1_VCS:
	verdi -ssf wave1.fsdb

view_wave2_VCS:
	verdi -ssf wave2.fsdb

view_wave3_VCS:
	verdi -ssf wave3.fsdb

view_wave4_VCS:
	verdi -ssf wave4.fsdb

report_VCS:
	urg -dir mem_cov1.vdb mem_cov2.vdb mem_cov3.vdb mem_cov4.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_VCS: clean_VCS sv_cmp_VCS run_test_VCS run_test1_VCS run_test2_VCS run_test3_VCS report_VCS

cov_VCS:
	verdi -cov -covdir merged_dir.vdb

covhtml_VCS:
	firefox urgReport/grp*.html &

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb novas* verdi*
	clear

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#
