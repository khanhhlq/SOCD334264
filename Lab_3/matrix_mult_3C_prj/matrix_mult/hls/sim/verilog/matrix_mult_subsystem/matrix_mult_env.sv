//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2026.1 (64-bit)
//Tool Version Limit: 2026.06
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`ifndef MATRIX_MULT_ENV__SV                                                                                   
    `define MATRIX_MULT_ENV__SV                                                                               
                                                                                                                    
                                                                                                                    
    class matrix_mult_env extends uvm_env;                                                                          
                                                                                                                    
        matrix_mult_virtual_sequencer matrix_mult_virtual_sqr;                                                      
        matrix_mult_config matrix_mult_cfg;                                                                         
                                                                                                                    
                                                                                                                    
        matrix_mult_reference_model   refm;                                                                         
                                                                                                                    
        matrix_mult_subsystem_monitor subsys_mon;                                                                   
                                                                                                                    
        `uvm_component_utils_begin(matrix_mult_env)                                                                 
        `uvm_field_object (refm, UVM_DEFAULT | UVM_REFERENCE)                                                       
        `uvm_field_object (matrix_mult_virtual_sqr, UVM_DEFAULT | UVM_REFERENCE)                                    
        `uvm_field_object (matrix_mult_cfg        , UVM_DEFAULT)                                                    
        `uvm_component_utils_end                                                                                    
                                                                                                                    
        function new (string name = "matrix_mult_env", uvm_component parent = null);                              
            super.new(name, parent);                                                                                
        endfunction                                                                                                 
                                                                                                                    
        extern virtual function void build_phase(uvm_phase phase);                                                  
        extern virtual function void connect_phase(uvm_phase phase);                                                
        extern virtual task          run_phase(uvm_phase phase);                                                    
                                                                                                                    
    endclass                                                                                                        
                                                                                                                    
    function void matrix_mult_env::build_phase(uvm_phase phase);                                                    
        super.build_phase(phase);                                                                                   
        matrix_mult_cfg = matrix_mult_config::type_id::create("matrix_mult_cfg", this);                           
                                                                                                                    



        refm = matrix_mult_reference_model::type_id::create("refm", this);


        uvm_config_db#(matrix_mult_reference_model)::set(this, "*", "refm", refm);


        `uvm_info(this.get_full_name(), "set reference model by uvm_config_db", UVM_LOW)


        subsys_mon = matrix_mult_subsystem_monitor::type_id::create("subsys_mon", this);


        matrix_mult_virtual_sqr = matrix_mult_virtual_sequencer::type_id::create("matrix_mult_virtual_sqr", this);
        `uvm_info(this.get_full_name(), "build_phase done", UVM_LOW)
    endfunction


    function void matrix_mult_env::connect_phase(uvm_phase phase);
        super.connect_phase(phase);


        refm.matrix_mult_cfg = matrix_mult_cfg;
        `uvm_info(this.get_full_name(), "connect phase done", UVM_LOW)
    endfunction


    task matrix_mult_env::run_phase(uvm_phase phase);
        `uvm_info(this.get_full_name(), "matrix_mult_env is running", UVM_LOW)
    endtask


`endif
