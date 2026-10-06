# 2026-09-25T22:17:51.937715800
import vitis

client = vitis.create_client()
client.set_workspace(path="vitis_embedded_lab1")

platform = client.create_platform_component(name = "first_zynq_platform_py",hw_design = "$COMPONENT_LOCATION/../../Lab 1/first_zynq_design/first_zynq_system_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_domain")

