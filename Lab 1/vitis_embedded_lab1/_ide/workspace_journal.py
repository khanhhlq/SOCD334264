# 2026-09-25T22:27:16.951974100
import vitis

client = vitis.create_client()
client.set_workspace(path="vitis_embedded_lab1")

platform = client.create_platform_component(name = "first_zynq_platform",hw_design = "$COMPONENT_LOCATION/../../first_zynq_system_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

comp = client.create_app_component(name="led_control_app",platform = "$COMPONENT_LOCATION/../first_zynq_platform/export/first_zynq_platform/first_zynq_platform.xpfm",domain = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="first_zynq_platform")
status = platform.build()

status = platform.build()

comp = client.get_component(name="led_control_app")
comp.build()

status = platform.build()

comp.build()

vitis.dispose()

