# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/ezm_cpu.v $(PWD)/fibonacci_rom.v $(PWD)/top.v 
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = ezm_cpu

# MODULE is the basename of the Python test file
MODULE = tb_cpu

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
