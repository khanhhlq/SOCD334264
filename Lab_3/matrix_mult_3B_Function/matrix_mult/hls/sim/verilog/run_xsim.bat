
set PATH=
call C:/AMDDesignTools/2026.1/Vivado/bin/xelab xil_defaultlib.apatb_matrix_mult_top xil_defaultlib.glbl -Oenable_linking_all_libraries -prj matrix_mult.prj -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_12 -L axi_protocol_checker_v1_1_13 -L axis_protocol_checker_v1_1_11 -L axis_protocol_checker_v1_1_12 -L xil_defaultlib -L unisims_ver -L xpm  -L floating_point_v7_1_22 -L floating_point_v7_0_27 --lib "ieee_proposed=./ieee_proposed" -L uvm -relax -i ./svr -i ./axivip -i ./svtb -i ./file_agent -i ./matrix_mult_subsystem  -s matrix_mult 
call C:/AMDDesignTools/2026.1/Vivado/bin/xsim -testplusarg "UVM_VERBOSITY=UVM_NONE" -testplusarg "UVM_TESTNAME=matrix_mult_test_lib" -testplusarg "UVM_TIMEOUT=20000000000000" --noieeewarnings matrix_mult -tclbatch matrix_mult.tcl 

