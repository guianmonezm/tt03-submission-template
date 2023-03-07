# test_my_design.py (simple)

# test_my_design.py (extended)

import cocotb
from cocotb.triggers import FallingEdge, Timer

async def generate_clock(dut):
    """Generate clock pulses."""

    for cycle in range(100):
        dut.clk.value = 1
        await Timer(1, units="ns")
        dut.clk.value = 0
        await Timer(1, units="ns")


@cocotb.test()
async def tiny_tapeout_test(dut):
    """Try accessing the design."""
    await cocotb.start(generate_clock(dut))  # run the clock "in the background"
    dut.rst.value = 0
    dut.in_i.value = 33
    await Timer(1,units="ns")
    print(dut.out_o.value)
    assert(dut.out_o.value==1,"error")
    await Timer(1,units="ns")
    dut.in_i.value = 8
    await Timer(2,units="ns")
    dut.in_i.value = 16
    await Timer(2,units="ns")
    dut.in_i.value = 9
    await Timer(2,units="ns")
    dut.in_i.value = 33
    await Timer(2,units="ns")
    dut.in_i.value = 0
    await Timer(2,units="ns")
    dut.in_i.value = 25
    await Timer(20,units="ns")
    dut.rst.value = 1
    await Timer(2,units="ns")
    assert(dut.out_o.value==0,"error")
    await Timer(20,units="ns")

    

    


