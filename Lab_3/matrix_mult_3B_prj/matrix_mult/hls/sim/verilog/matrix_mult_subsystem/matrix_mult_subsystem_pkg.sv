//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2026.1 (64-bit)
//Tool Version Limit: 2026.06
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`timescale 1ns/1ps 

`ifndef MATRIX_MULT_SUBSYSTEM_PKG__SV          
    `define MATRIX_MULT_SUBSYSTEM_PKG__SV      
                                                     
    package matrix_mult_subsystem_pkg;               
                                                     
        import uvm_pkg::*;                           
        import file_agent_pkg::*;                    
                                                     
        `include "uvm_macros.svh"                  
                                                     
        `include "matrix_mult_config.sv"           
        `include "matrix_mult_reference_model.sv"  
        `include "matrix_mult_scoreboard.sv"       
        `include "matrix_mult_subsystem_monitor.sv"
        `include "matrix_mult_virtual_sequencer.sv"
        `include "matrix_mult_pkg_sequence_lib.sv" 
        `include "matrix_mult_env.sv"              
                                                     
    endpackage                                       
                                                     
`endif                                               
