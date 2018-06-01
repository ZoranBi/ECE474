/*********************************************************************
/File Name: avgr.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 5/24/2018
/Last Modified Time: 5/30/2018, 23:43 PST
/Description: compute average value for temperature average system
**********************************************************************/
module avgr(
  input  reg [7:0] fifo_to_avgr,
  input            clk_2,
  input            reset_n,
  input            rd_fifo,
  input            dis_rd_fifo,
  output reg       avging,
  output reg       avg_done,
  output reg       ram_wr_n,
  output reg [7:0] result
  );

enum logic [1:0]{
  IDLE = 2'b00,
  WORK = 2'b01,
  DEVI = 2'b10,
  OUTP = 2'b11
}cs, ns;

reg       [8:0] avg = 8'b00000000;
reg       [3:0] cnt = 3'b000;
reg             rd_en;

assign avging = (ns == WORK)?1:0;

always @(*) begin
  if (rd_fifo)
    rd_en = 1'b1;
  else if (dis_rd_fifo)
    rd_en = 1'b0;
end

always_ff @ (posedge clk_2, negedge reset_n) begin
  if (!reset_n)
    cs <= IDLE;
  else
    cs <= ns;
end

always @(*) begin
  case (cs)
    IDLE: begin
      if (rd_en == 1'b1)
        ns = WORK;
      else
        ns = IDLE;
    end
    WORK: begin
      if (cnt == 3'b100)
        ns = DEVI;
      else if (cnt != 3'b100)
        ns = WORK;
    end

    DEVI:
      ns = OUTP;

    OUTP: begin
      ns = IDLE;
    end
  endcase
end

always @(*) begin
  case (cs)
    IDLE: begin
      avg = 8'b00000000;
      cnt = 3'b000;
      ram_wr_n = 1'b0;
      avg_done = 1'b0;
    end
    WORK: begin
      avg = avg[7:0] + fifo_to_avgr;
      cnt = cnt + 1;
    end
    DEVI: begin
      avg = avg >> 2;
    end
    OUTP: begin
      result = avg;
      avg_done = 1'b1;
      ram_wr_n = 1'b1;
    end
  endcase
end

endmodule
