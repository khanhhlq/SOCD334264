set SynModuleInfo {
  {SRCNAME matrix_mult MODELNAME matrix_mult RTLNAME matrix_mult IS_TOP 1
    SUBMODULES {
      {MODELNAME matrix_mult_mac_muladd_8s_8s_16s_16_4_1 RTLNAME matrix_mult_mac_muladd_8s_8s_16s_16_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME matrix_mult_flow_control_loop_delay_pipe RTLNAME matrix_mult_flow_control_loop_delay_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME matrix_mult_flow_control_loop_delay_pipe_U}
    }
  }
}
