#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst_n", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_AWVALID", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_AWREADY", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_slv0_AWADDR", 6, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_WVALID", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_WREADY", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_slv0_WDATA", 32, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_WSTRB", 4, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_ARVALID", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_ARREADY", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_slv0_ARADDR", 6, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_RVALID", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_slv0_RREADY", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_RDATA", 32, hls_out, -1, "", "", 1),
	Port_Property("s_axi_slv0_RRESP", 2, hls_out, -1, "", "", 1),
	Port_Property("s_axi_slv0_BVALID", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_slv0_BREADY", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_slv0_BRESP", 2, hls_out, -1, "", "", 1),
};
const char* HLS_Design_Meta::dut_name = "nco";
