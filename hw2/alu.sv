module alu(
	input				 [7:0] in_a     , //input a
	input        [7:0] in_b     ,  //input b
  input        [3:0] opcode   ,  //opcode input
  output  reg  [7:0] alu_out  ,  //alu output
  output  reg        alu_zero ,  //logic '1' when alu_output [7:0] is all zeros
  output  reg        alu_carry   //indicates a carry out from ALU
);

//Declare all the opcodes in the module as follows.
//Note the use of the prefix "c_" to mark the identifier as a constant.
//The opcodes for the ALU are as follows:

  parameter c_add = 4'h1;           //in_a + in_b
  parameter c_sub = 4'h2;						//in_a - in_b
  parameter c_inc = 4'h3;						//in_a + 1
  parameter c_dec = 4'h4;						//in_a - 1
  parameter c_or  = 4'h5;						//in_a OR in_b
	parameter c_and = 4'h6;						//in_a AND in_b
	parameter c_xor = 4'h7;						//in_a XOR in_b
	parameter c_shr = 4'h8;						//in_a is shifted one place right, zero shifted in
	parameter c_shl = 4'h9;						//in_a is shifted one place left, zero shifted in
	parameter c_onescomp = 4'hA;     //in_a gets "ones complemented"
	parameter c_twoscomp = 4'hB;     //in_a gets "twos complemented"

//create register for result
	reg [8:0] result;

//build cases for opcodes
	always_comb begin
		case (opcode)
			c_add: begin
				result = in_a + in_b;
			end
			c_sub: begin
				result = in_a - in_b;
			end
			c_inc: begin
			 	result = in_a + 1;
			end
			c_dec: begin
				result = in_a - 1;
			end
			c_or : begin
				result = in_a | in_b;
			end
			c_and: begin
				result = in_a & in_b;
			end
			c_xor: begin
				result = in_a ^ in_b;
			end
			c_shr: begin
				result = in_a >> 1;
			end
			c_shl: begin
				result = in_a << 1;
			end
			c_onescomp: begin
				result = ~in_a;
			end
			c_twoscomp: begin
				result = ~in_a + 1;
			end
			default:
				result = 9'bXXXXXXXXX;
		endcase
end

assign alu_out = result[7:0];
assign alu_carry = result[8];
assign alu_zero = (result == 8'b0)?1:0;

endmodule
