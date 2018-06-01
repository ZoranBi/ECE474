/*********************************************************************
/File Name: fifo.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 5/24/2018
/Last Modified Time: 5/27/2018, 15:13 PST
/Description: save temperature data for temperature average system
**********************************************************************/
module fifo(
  input            wr_clk,   //write clock
  input            rd_clk,   //read clock
  input            reset_n,  //reset async active low
  input            wr,       //write enable
  input            rd,       //read enable
  input      [7:0] data_in,  //data in
  output reg [7:0] data_out, //data out
  output reg       empty,    //empty flag
  output reg       full      //full flag
  );

  parameter DATASIZE = 8; // Memory data word width
  parameter DEPTH = 4; // Number of mem address bits

  reg [2:0] waddr;
  reg [2:0] raddr;
  reg [DATASIZE-1:0] mem [DEPTH-1:0];

always_comb begin
  full = ((raddr[1:0] == waddr[1:0]) && (raddr[2] != waddr[2]))?1'b1:1'b0;
  empty = (raddr== waddr)?1'b1:1'b0;
end

  always_ff @ (posedge wr_clk, negedge reset_n) begin
    if(!reset_n) begin
      waddr <= 3'b0;
    end
    else if(wr && !full) begin
      mem[waddr[1:0]] <= data_in;
      waddr <= waddr + 1;
    end
  end

  always_ff @ (posedge rd_clk, negedge reset_n) begin
    if(!reset_n) begin
      data_out <= 8'bX;
      raddr <= 3'b0;
    end
    else if(rd && !empty) begin
      data_out <= mem[raddr[1:0]];
      raddr <= raddr + 1;
    end
  end
endmodule
