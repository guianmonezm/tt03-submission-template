module guianmonezm_ezmcpu (io_in ,io_out);
input [7:0] io_in;
output [7:0] io_out;

ezm_cpu cpu_top(
     .clk(io_in[0]),
     .rst(io_in[1]),
     .in_i(io_in[7:2]),
     .out_o(io_out[7:0])
);

endmodule 

module ezm_cpu(in_i,clk,rst,out_o);
input [5:0] in_i;
input clk,rst;
output [7:0]out_o;


reg [7:0] c=0,pc=0;
reg [7:0] bank[7:0];
reg bflag;
integer i; 

always @(posedge clk)begin 
     if (rst)begin
          for (i=0;i<8;i=i+1)begin
          bank[i] <= 8'b00000000;
          end  
          c <= 8'b0;
          pc<= 8'b00000000;
     end 
     else begin
     if (bflag ==1) begin 
          pc <= pc - c;
          bflag <=0;
     end
     else 
          pc <= pc + 1'b1;
     end

end

always @(posedge clk )begin 
     casex (in_i) 
          6'b1?????: c <= {{3{in_i[4]}},in_i[4:0]}; //load
          6'b011???:if (bank[in_i[2:0]]>c) // value in register greater than accumulator
               bflag <= 1; 
          //conditional branch
          6'b001???: bank[in_i[2:0]] <= c ;//store accumulator 
          6'b010???: c <= (bank[in_i[2:0]] + c);//add
          6'b000001: c<=~c;//negate 
          default: ;
     endcase


end 

assign  out_o = clk ? {pc}:{c};
endmodule