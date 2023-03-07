
module instr_mem(
  input [7:0] address,
  output [5:0] instruction
);

reg [5:0] inst;
    always @(*) begin
        case(address)
        //ld r1 = 1 ld r2 = 0
        8'd0:    inst = 6'b000000; //nop      0
		8'd1:	 inst = 6'b100001;  //ld1      33
		8'd2:	 inst = 6'b001001;  //stra r1  9
        8'd3:    inst = 6'b100000; //ld0     32
        8'd4:    inst = 6'b001010; //stra r2 10

        //sum r1+r2 save on r1
        8'd5:    inst = 6'b100000; //ld0     32
        8'd6:    inst = 6'b010001; //add1 // 17
        8'd7:    inst = 6'b010010; //add2    18
        8'd8:    inst = 6'b001001; //stra r1  9

        //sum r1+r2 save on r2
        8'd9:    inst = 6'b100000; //ld0     32
        8'd10:   inst = 6'b010010; //add2    18
        8'd11:   inst = 6'b010001; //add1    17
        8'd12:   inst = 6'b001010; //stra r2 10
        
        //while(1) loop 
        8'd13:   inst = 6'b101100; //ld 11 +1 45
        8'd14:   inst = 6'b001011; //stra r3  11
        8'd15:   inst = 6'b101011; //ld 11    44
        8'd16:   inst = 6'b011011; //br 3     27

		default:	    inst = 6'b000000;
        endcase
    end

assign instruction = inst;
endmodule