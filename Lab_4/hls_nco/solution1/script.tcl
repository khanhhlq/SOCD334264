############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project hls_nco
set_top nco
add_files sources/hls_nco/nco.cpp
add_files -tb sources/hls_nco/nco_tb.cpp
open_solution "solution1" -flow_target vivado
set_part {xc7z020clg484-1}
create_clock -period 10 -name default
config_export -format ip_catalog -output D:/Zynq_Book/hls_nco/nco_ip.zip -rtl verilog
#source "./hls_nco/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog -output D:/Zynq_Book/hls_nco/nco_ip.zip
