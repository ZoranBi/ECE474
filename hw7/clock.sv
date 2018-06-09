/*********************************************************************
/File Name: clock.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 6/04/2018
/Last Modified Time: 6/8/2018, 05:12 PST
/Description: Digital clock with output for 7 segment digit LED display
**********************************************************************/
module clock (
  input             reset_n,             //reset pin
  input             clk_1sec,            //1 sec clock
  input             clk_1ms,             //1 mili sec clock
  input             mil_time,            //mil time pin
  output reg [7:0]  segment_data,        // output 7 segment data
  output reg [2:0]  digit_select         // digit select
  );

//create register for hr and mins
reg [4:0] hrs  = 5'b00000;
reg [4:0] hrs_out = 5'b00000;
reg [5:0] mins = 6'b000000;
reg [5:0] secs = 6'b000000;

wire [3:0] data_sel_dec;
reg [1:0] cnt;
reg [3:0] hrs_h;
reg [3:0] hrs_l;
reg [3:0] mins_h;
reg [3:0] mins_l;

//military time
always_ff @ (posedge clk_1sec, negedge reset_n) begin
  if (!reset_n) begin
    hrs <= 5'b00000;
    mins <= 6'b000000;
    secs <= 6'b000000;
  end
  else begin
    if(secs == 6'd59) begin
      secs <= 6'd0;
      if (mins == 6'd59) begin
        mins <= 6'd0;
        if (hrs == 5'd23)
          hrs <= 5'd0;
        else if (hrs != 5'd23)
          hrs <= hrs + 1;
      end
      else if (mins != 6'd59)
        mins <= mins + 1;
    end
    else if (secs != 6'd59)
      secs <= secs + 1;
  end//end else
end

//convert from mil time to 12 hours time
always_comb begin
  if (mil_time == 0)
    hrs_out = hrs % 12;
  else if(mil_time == 1)
    hrs_out = hrs;
  if (hrs_out == 5'd0 && mil_time == 0)
    hrs_out = 5'd12;
end

sep_to_twe sep_to_twe_0(
  .hrs(hrs_out),
  .mins(mins),
  .hrsH(hrs_h),
  .hrsL(hrs_l),
  .minsH(mins_h),
  .minsL(mins_l)
  );

selector selector_0(
  .clk_1ms(clk_1ms),
  .reset_n(reset_n),
  .hrs_h(hrs_h),
  .hrs_l(hrs_l),
  .mins_h(mins_h),
  .mins_l(mins_l),
  .cnt(cnt),
  .data_out(data_sel_dec)
  );

decoder decoder_0(
  .hrs(hrs),
  .mil_time(mil_time),
  .data_in(data_sel_dec),
  .cnt(cnt),
  .segment_data(segment_data),
  .digit_select(digit_select)
  );


endmodule //clock
