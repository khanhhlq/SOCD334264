# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_slv0 {
sine_sample { 
	dir O
	width 16
	depth 1
	mode ap_vld
	offset 16
	offset_end 23
}
step_size { 
	dir I
	width 16
	depth 1
	mode ap_none
	offset 32
	offset_end 39
}
}
dict set axilite_register_dict slv0 $port_slv0


