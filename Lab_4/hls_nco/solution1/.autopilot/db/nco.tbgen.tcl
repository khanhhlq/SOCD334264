set moduleName nco
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_none
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set C_modelName {nco}
set C_modelType { void 0 }
set C_modelArgList {
	{ sine_sample int 16 regular {axi_slave 1}  }
	{ step_size int 16 regular {axi_slave 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "sine_sample", "interface" : "axi_slave", "bundle":"slv0","type":"ap_vld","bitwidth" : 16, "direction" : "WRITEONLY", "offset" : {"out":16}, "offset_end" : {"out":23}} , 
 	{ "Name" : "step_size", "interface" : "axi_slave", "bundle":"slv0","type":"ap_none","bitwidth" : 16, "direction" : "READONLY", "offset" : {"in":32}, "offset_end" : {"in":39}} ]}
# RTL Port declarations: 
set portNum 19
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ s_axi_slv0_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_slv0_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_slv0_AWADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_slv0_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_slv0_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_slv0_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_slv0_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_slv0_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_slv0_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_slv0_ARADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_slv0_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_slv0_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_slv0_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_slv0_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_slv0_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_slv0_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_slv0_BRESP sc_out sc_lv 2 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_slv0_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "slv0", "role": "AWADDR" },"address":[{"name":"step_size","role":"data","value":"32"}] },
	{ "name": "s_axi_slv0_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "AWVALID" } },
	{ "name": "s_axi_slv0_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "AWREADY" } },
	{ "name": "s_axi_slv0_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "WVALID" } },
	{ "name": "s_axi_slv0_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "WREADY" } },
	{ "name": "s_axi_slv0_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "slv0", "role": "WDATA" } },
	{ "name": "s_axi_slv0_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "slv0", "role": "WSTRB" } },
	{ "name": "s_axi_slv0_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "slv0", "role": "ARADDR" },"address":[{"name":"sine_sample","role":"data","value":"16"}, {"name":"sine_sample","role":"valid","value":"20","valid_bit":"0"}] },
	{ "name": "s_axi_slv0_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "ARVALID" } },
	{ "name": "s_axi_slv0_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "ARREADY" } },
	{ "name": "s_axi_slv0_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "RVALID" } },
	{ "name": "s_axi_slv0_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "RREADY" } },
	{ "name": "s_axi_slv0_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "slv0", "role": "RDATA" } },
	{ "name": "s_axi_slv0_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "slv0", "role": "RRESP" } },
	{ "name": "s_axi_slv0_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "BVALID" } },
	{ "name": "s_axi_slv0_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "slv0", "role": "BREADY" } },
	{ "name": "s_axi_slv0_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "slv0", "role": "BRESP" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2"],
		"CDFG" : "nco",
		"Protocol" : "ap_ctrl_none",
		"ControlExist" : "0", "ap_start" : "0", "ap_ready" : "0", "ap_done" : "0", "ap_continue" : "0", "ap_idle" : "0", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "1", "EstimateLatencyMax" : "1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "sine_sample", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "step_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "temp_V", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "sine_lut_V", "Type" : "Memory", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sine_lut_V_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.slv0_s_axi_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	nco {
		sine_sample {Type O LastRead -1 FirstWrite 1}
		step_size {Type I LastRead 0 FirstWrite -1}
		temp_V {Type IO LastRead -1 FirstWrite -1}
		sine_lut_V {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "1"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "2"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
