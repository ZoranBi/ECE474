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

  reg [3:0] waddr;
  reg [3:0] raddr;
  /*
  reg   [7:0] mem0;
  reg   [7:0] mem1;
  reg   [7:0] mem2;
  reg   [7:0] mem3;
  reg   [7:0] mem4;
  reg   [7:0] mem5;
  reg   [7:0] mem6;
  reg   [7:0] mem7;
  */
  reg [7:0] mem [7:0];

assign full = ((raddr[2:0] == waddr[2:0] && raddr[3] != waddr[3]))?1'b1:1'b0;
assign empty = (raddr== waddr)?1'b1:1'b0;

  always_ff @ (posedge wr_clk, negedge reset_n) begin
    if(!reset_n) begin
      waddr <= 4'b0;
      raddr <= 4'b0;
    end
    else if(wr && !full) begin
      /*case(waddr[2:0])
            3'b000: mem0 <= data_in;
            3'b001: mem1 <= data_in;
            3'b010: mem2 <= data_in;
            3'b011: mem3 <= data_in;
            3'b100: mem4 <= data_in;
            3'b101: mem5 <= data_in;
            3'b110: mem6 <= data_in;
            3'b111: mem7 <= data_in;
          endcase*/
      mem[waddr[2:0]] <= data_in;
      waddr <= waddr + 1;
    end
  end

  always_ff @ (posedge rd_clk, negedge reset_n) begin
    if(!reset_n) begin
      data_out <= 8'bX;
      end
    else if(rd && !empty) begin
      data_out <= mem[raddr[2:0]];
      raddr <= raddr + 1;
    end
  end
endmodule
