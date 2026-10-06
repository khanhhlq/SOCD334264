# 2026-10-06T16:26:02.136139600
import vitis

client = vitis.create_client()
client.set_workspace(path="Lab_3")

comp = client.create_hls_component(name = "matrix_mult_prj",part = "xc7z020clg484-1",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="matrix_mult_prj")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

cfg = client.get_config_file(path="/d:/SOCD334264/Lab_3/matrix_mult_prj/hls_config.cfg")

cfg.set_value(section="hls", key="syn.compile.pipeline_loops", value="0")

comp.run(operation="CO_SIMULATION")

comp.run(operation="CO_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="CO_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp = client.create_hls_component(name = "matrix_mult_3B_prj",part = "xc7z020clg484-1",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp.run(operation="C_SIMULATION")

comp = client.get_component(name="matrix_mult_3B_prj")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp = client.create_hls_component(name = "matrix_mult_3C_prj",part = "xc7z020clg484-1",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="matrix_mult_3C_prj")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp = client.create_hls_component(name = "matrix_mult_3B_Col",part = "xc7z020clg484-1",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="matrix_mult_3B_Col")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp = client.create_hls_component(name = "matrix_mult_3B_Reshape",part = "xc7z020clg484-1",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="matrix_mult_3B_Reshape")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp = client.create_hls_component(name = "matrix_mult_3B_Function",part = "xc7z020clg484-1",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="matrix_mult_3B_Function")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp = client.create_hls_component(name = "matrix_mult_3B_Function_Reshape",part = "xc7z020clg484-1",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="matrix_mult_3B_Function_Reshape")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp = client.get_component(name="matrix_mult_3B_Col")
comp.run(operation="CO_SIMULATION")

vitis.dispose()

