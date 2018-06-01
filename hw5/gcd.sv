/*********************************************************************
/File Name: gcd.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 5/12/2018
/Last Modified Time: 5/13/2018
/Description: Main file of the design for gcd(Greatest Common Divisor)
**********************************************************************/
module gcd(
  input      [31:0] a_in,     //operand a
  input      [31:0] b_in,     //operand b
  input             start,    //validates the input data
  input             reset_n,  //reset
  input             clk,      //clock
  output reg [31:0] result,   //output of GCD engine
  output reg        done      //validates output value
  );

  logic      [31:0] reg_a;    //create register for data a
  logic      [31:0] reg_b;    //create register for data b
  logic             a_lt_b;   //create signal to determine if a is less than b
  logic             b_zero;   //create signal to tell if b is equal to zero

  assign a_lt_b = (reg_a < reg_b);    //determine signal according to values of a and b
  assign b_zero = (reg_b == 0);       //determine signal based on b
  assign done = (!a_lt_b && b_zero);  //tell the process is done or not

//combination logic to compute the value of result.
//Result is reseted if detect reset signal
//Result is equal to the value of reg_a when the process done
  always_comb begin
    if(!reset_n)
      result <= 32'bX;
    else if(done)
      result <= reg_a;
  end

//sequential logic to determine the value of reg_a
//reg_a is reseted when reset
//reg_a loads when start
//reg_a equal to the substraction of reg_a and reg_b when b is not 0 and a not less than b
//reg_a swap with reg_b if a is less than 0
  always_ff @ (posedge clk, negedge reset_n) begin
    if(!reset_n)
      reg_a <= 32'bX;
    else if(start)
      reg_a <= a_in;
    else if(!b_zero && !a_lt_b)
      reg_a <= reg_a - reg_b;
    else if(a_lt_b)
      reg_a <= reg_b;
  end

//sequential logic to determine the value of reg_a
//reg_b is reseted when reset
//reg_b loads when start
//reg_b equal to reg_b when b is not 0 and a not less than b
//reg_b swap with reg_a if a is less than 0
  always_ff @ (posedge clk, negedge reset_n) begin
    if(!reset_n)
      reg_b <= 32'bX;
    else if(start)
      reg_b <= b_in;
    else if(!b_zero && !a_lt_b)
      reg_b <= reg_b;
    else if(a_lt_b)
      reg_b <= reg_a;
  end

endmodule
