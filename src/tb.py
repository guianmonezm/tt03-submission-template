# test_my_design.py (simple)

# test_my_design.py (extended)

import cocotb
from cocotb.triggers import FallingEdge, Timer

async def generate_clock(dut):
    """Generate clock pulses."""

    for cycle in range(300):
        dut.clk.value = 0
        await Timer(1, units="ns")
        dut.clk.value = 1
        await Timer(1, units="ns")


@cocotb.test()
async def tiny_tapeout_test(dut):
    """Try accessing the design."""
    await cocotb.start(generate_clock(dut))  # run the clock "in the background"
    dut.rst.value = 0
    await Timer(600,units="ns")

    

    

    


