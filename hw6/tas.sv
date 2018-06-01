/*********************************************************************
/File Name: tas.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 5/23/2018
/Last Modified Time: 5/23/2018, 14:43 PST
/Description: temperature average system
**********************************************************************/
module tas (
       input  clk_50,               // 50Mhz input clock
       input  clk_2,                // 2Mhz input clock
       input  reset_n,              // reset async active low
       input  serial_data,          // serial input data
       input  data_ena,             // serial data enable
       output ram_wr_n,             // write strobe to ram
       output [7:0] ram_data,       // ram data
       output [10:0] ram_addr       // ram address
       );

//create reg for signals
reg  [7:0] shift_reg;                 //register for shift register
reg  [3:0] shift_reg_cnt = 4'b0000;   //shift register counter
reg        shift_out;                 //

wire       wr_header_fifo;
wire [7:0] data_header_fifo;
wire       rd_from_avgr;
wire       rd_fifo_avgr;
wire [7:0] data_fifo_avgr;
wire       flag_rd_fifo;
wire       signal_done;

assign shift_out = (shift_reg_cnt == 4'b1000)?1:0;

//discribe features of shift register
always_ff @ (posedge clk_50, negedge reset_n) begin
  if (!reset_n)
    shift_reg <= 8'b0;
  else begin
    if (data_ena && (shift_reg_cnt != 4'b1000)) begin
      shift_reg <= shift_reg >> 1;
      shift_reg[7] <= serial_data;
      shift_reg_cnt <= shift_reg_cnt + 1;
    end
    else if (shift_reg_cnt == 4'b1000) begin
      shift_reg <= 8'b00000000;
      shift_reg_cnt <= 4'b0000;
    end
  end
end

a5_or_c3 a5_or_c3_0(
  .clk_50(clk_50),
  .reset_n(reset_n),
  .header(shift_reg),
  .header_en(shift_out),
  .data_to_fifo(data_header_fifo),
  .wr_fifo(wr_header_fifo)
  );

fifo fifo_0(
  .wr_clk(clk_50),               //write clock
  .rd_clk(clk_2),                //read clock
  .reset_n(reset_n),             //reset async active low
  .wr(wr_header_fifo),           //write enable
  .rd(rd_from_avgr),             //read enable
  .data_in(data_header_fifo),    //data in
  .full(rd_fifo_avgr),           //full and empty generate signal to control read
  .empty(flag_rd_fifo),          //empty and full generate signal to control read
  .data_out(data_fifo_avgr)      //data out
  );

avgr avgr_0(
  .fifo_to_avgr(data_fifo_avgr),
  .clk_2(clk_2),
  .reset_n(reset_n),
  .rd_fifo(rd_fifo_avgr),
  .dis_rd_fifo(flag_rd_fifo),
  .avging(rd_from_avgr),
  .avg_done(signal_done),
  .ram_wr_n(ram_wr_n),
  .result(ram_data)
  );

cnt cnt_0(
  .clk_2(clk_2),
  .reset_n(reset_n),
  .avg_done(signal_done),
  .ram_addr(ram_addr)
  );

endmodule
