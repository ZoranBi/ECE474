/*********************************************************************
/File Name: decoder.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 6/04/2018
/Last Modified Time: 6/8/2018, 05:12 PST
/Description: Digital clock with output for 7 segment digit LED display
**********************************************************************/
module decoder (
  input      [4:0] hrs,
  input            mil_time,
  input      [3:0] data_in,
  input      [1:0] cnt,
  output reg [7:0] segment_data,
  output reg [2:0] digit_select
  );

reg [6:0] data_out;
//decoder
  always_comb begin
    case (data_in)
      4'b0000: data_out = 7'b0111111; // 0
      4'b0001: data_out = 7'b0000110; // 1
      4'b0010: data_out = 7'b1011011; // 2
      4'b0011: data_out = 7'b1001111; // 3
      4'b0100: data_out = 7'b1100110; // 4
      4'b0101: data_out = 7'b1101101; // 5
      4'b0110: data_out = 7'b1111101; // 6
      4'b0111: data_out = 7'b0100111; // 7
      4'b1000: data_out = 7'b1111111; // 8
      4'b1001: data_out = 7'b1100111; // 9
      4'b1010: data_out = 7'b1110111; // A
      4'b1011: data_out = 7'b1111100; // b
      4'b1100: data_out = 7'b0111001; // c
      4'b1101: data_out = 7'b1011110; // d
      4'b1110: data_out = 7'b1111001; // E
      4'b1111: data_out = 7'b1110001; // F
    endcase
  end


  always @(*) begin
    if (hrs >= 12)
      segment_data = {~mil_time, data_out};
    else if (hrs < 12)
      segment_data = {~mil_time, data_out};
  end

  always_comb begin
    digit_select = {1'b0, cnt};
  end
endmodule //decoder
