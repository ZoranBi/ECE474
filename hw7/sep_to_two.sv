/*********************************************************************
/File Name: sep_to_two.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 6/04/2018
/Last Modified Time: 6/8/2018, 05:12 PST
/Description: Digital clock with output for 7 segment digit LED display
**********************************************************************/
module sep_to_twe (
  input      [4:0] hrs,
  input      [5:0] mins,
  output reg [3:0] hrsH,
  output reg [3:0] hrsL,
  output reg [3:0] minsH,
  output reg [3:0] minsL
  );

  always @(*) begin
    hrsL = hrs % 10;
    case (hrs - hrsL)
      6'b000000: hrsH = 4'd0;
      6'b001010: hrsH = 4'd1;
      6'b010100: hrsH = 4'd2;
      6'b011110: hrsH = 4'd3;
      6'b101000: hrsH = 4'd4;
      6'b110010: hrsH = 4'd5;
    endcase
  end

  always @(*) begin
    minsL = mins % 10;
    case (mins - minsL)
      6'b000000: minsH = 4'd0;
      6'b001010: minsH = 4'd1;
      6'b010100: minsH = 4'd2;
      6'b011110: minsH = 4'd3;
      6'b101000: minsH = 4'd4;
      6'b110010: minsH = 4'd5;
    endcase
  end
endmodule // sep_to_twe
