/*********************************************************************
/File Name: a5_or_c3.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 5/23/2018
/Last Modified Time: 5/30/2018, 23:43 PST
/Description: temperature average system
**********************************************************************/
module a5_or_c3(
  input            clk_50,
  input            reset_n,
  input      [7:0] header,
  input            header_en,
  output reg [7:0] data_to_fifo,
  output reg       wr_fifo
  );

enum logic [1:0] {
  IDLE = 2'b00,
  SAVE = 2'b01,
  TEST = 2'b11
}cs, ns;

reg [7:0] header_reg;

always @(*) begin
  if (header_en == 1'b1)
    header_reg = header;
end

reg [2:0] cnt = 3'b000;

always_ff @ (posedge clk_50, negedge reset_n) begin
  if(!reset_n)
    cs <= IDLE;
  else
    cs <= ns;
end

always @(*) begin
  unique case (cs)
    IDLE: begin
      if (header_reg == 8'b10100101 || header_reg == 8'b11000011)
        ns <= TEST;
      else
        ns <= IDLE;
    end
    TEST: begin
      if (header_reg == 8'b10100101 || header_reg == 8'b11000011)
        ns <= TEST;
      else if (header_en == 1'b1)
        ns <= SAVE;
    end
    SAVE: begin
      if (cnt == 3'b100)
        ns <= IDLE;
      else if (cnt != 3'b100)
        ns <= TEST;
    end
  endcase
end

always @(*) begin
  case (cs)
    IDLE: begin
      cnt = 3'b000;
      wr_fifo = 1'b0;
    end
    TEST: begin
      wr_fifo = 1'b0;
    end
    SAVE: begin
      wr_fifo = 1'b1;
      data_to_fifo = header_reg;
      cnt = cnt + 1;
    end
  endcase
end

endmodule // a5a5_or_c3
