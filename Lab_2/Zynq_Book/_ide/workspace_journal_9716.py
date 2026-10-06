# 2026-09-30T19:57:36.596842
import vitis

client = vitis.create_client()
client.set_workspace(path="Zynq_Book")

platform = client.create_platform_component(name = "zynq_interrupt_platform",hw_design = "$COMPONENT_LOCATION/../zynq_interrupts/zynq_interrupt_system_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

platform = client.get_component(name="zynq_interrupt_platform")
status = platform.build()

comp = client.create_app_component(name="interrupt_counter",platform = "$COMPONENT_LOCATION/../zynq_interrupt_platform/export/zynq_interrupt_platform/zynq_interrupt_platform.xpfm",domain = "standalone_ps7_cortexa9_0")

status = platform.build()

comp = client.get_component(name="interrupt_counter")
comp.build()

