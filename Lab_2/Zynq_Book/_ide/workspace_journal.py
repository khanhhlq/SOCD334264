# 2026-10-01T11:33:26.088535500
import vitis

client = vitis.create_client()
client.set_workspace(path="Zynq_Book")

platform = client.get_component(name="zynq_interrupt_platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../zynq_interrupts/zynq_interrupt_system_wrapper.xsa")

status = platform.build()

status = platform.build()

comp = client.get_component(name="interrupt_counter")
comp.build()

vitis.dispose()

