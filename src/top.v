module top (clk,rst);
input clk,rst;

wire [7:0]addr;
wire [5:0]inst ;


initial begin
$dumpfile ("test.vcd");
$dumpvars (0,top);
end

instr_mem counter_rom(
    .address(addr),
    .instruction(inst)
);

ezm_cpu cpu(
     .clk(clk),
     .rst(rst),
     .in_i(inst),
     .out_o(addr)
);
endmodule