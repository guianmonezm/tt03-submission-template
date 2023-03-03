module ezm_cpu(in_i,clk,rst,out_o);
input [5:0] in_i;
input clk,rst;
output wire [7:0]out_o;


reg [7:0] c=0,pc=0;
reg [7:0] bank[7:0];
reg bflag,reset,state=0;

reg [2:0] instruction;


integer i; 
reg instruction_flag;


always @(rst)begin 
     if (rst) reset<=1;
     else 
     reset <=0;
end

always @(posedge clk)begin 
     if (reset)begin 
     for (i=0;i<8;i=i+1)begin
     bank[i] <= 8'b0;
     end  
     c <= 8'b0;
     pc<= 8'b0;
     state<=0;
     end 
     else begin

     case (state)
     0:begin
     pc <= pc + 1'b1;

     casex (in_i) 
          6'b1?????: 
          instruction<=3'b001; //load         
          
          6'b011???:
          instruction<=3'b010; //conditional branch
          
          6'b001???:
          instruction<=3'b011;//stra

          6'b010???:
          instruction<=3'b100;//add
          
          6'b000001: 
          instruction<=3'b101;
          default:instruction<=3'b000;
     endcase
     state<=1'b1;
     end 

     1: begin 

     bflag<=0;
     case (instruction) 
          3'b001:begin 
          c <= {{3{in_i[4]}},in_i[4:0]}; //load
          end
          3'b010:begin 
          if (bank[in_i[2:0]]>c) begin // value in register greater than accumulator
          pc <= pc - c;
          end 
          end //conditional branch
          3'b011: begin 
               bank[in_i[2:0]] <= c;
          end  
          3'b100: begin 
          c <= (bank[in_i[2:0]] + c);
          end//add
          3'b101: 
          c<=~c;//negate 
          default:;
     endcase
     state<=1'b0; 
     end
endcase
end
end
assign out_o = state ? {c}:{pc};

endmodule