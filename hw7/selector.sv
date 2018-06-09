/*********************************************************************
/File Name: selector.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 6/04/2018
/Last Modified Time: 6/8/2018, 05:12 PST
/Description: Digital clock with output for 7 segment digit LED display
**********************************************************************/
module selector (
  input            clk_1ms,
  input            reset_n,
  input      [3:0] hrs_h,
  input      [3:0] hrs_l,
  input      [3:0] mins_h,
  input      [3:0] mins_l,
  output reg [1:0] cnt,
  output reg [3:0] data_out
  );

always_ff @ (posedge clk_1ms, negedge reset_n) begin
  if(!reset_n)
    cnt <= 2'b00;
  else
    cnt <= cnt + 1;
end

always_comb begin
  case (cnt)
    2'b00: data_out = hrs_h;
    2'b01: data_out = hrs_l;
    2'b11: data_out = mins_h;
    2'b10: data_out = mins_l;
  endcase
end
endmodule // selector
