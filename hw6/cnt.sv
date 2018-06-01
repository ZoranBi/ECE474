/*********************************************************************
/File Name: cnt.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 5/25/2018
/Last Modified Time: 5/27/2018, 15:13 PST
/Description: counter for averager and gives ram address.
**********************************************************************/
module cnt(
  input             clk_2,
  input             reset_n,
  input             avg_done,
  output reg [10:0] ram_addr
  );

always_ff @ (posedge clk_2, negedge reset_n) begin
  if (!reset_n) begin
    ram_addr <= 10'h7FF;
  end
  else if (avg_done == 1'b1) begin
    ram_addr <= ram_addr - 1;
  end
end

endmodule
