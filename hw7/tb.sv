/*********************************************************************
/File Name: tb.sv
/File Type: Verilog
/Auther: Zongzhe Bi
/Create Time       : 6/04/2018
/Last Modified Time: 6/8/2018, 05:12 PST
/Description: Testbench for Digital clock with output for 7 segment digit LED display
**********************************************************************/
`timescale 1ps / 1ps
module tb ;

integer output_file;
integer i;

parameter SE_CYCLE = 20000;
parameter MS_CYCLE = 20;

reg clk_1sec, clk_1ms, reset_n;
reg mil_time;
reg [7:0] segment_data;
reg [2:0] digit_select;

//clock generation for the clocks
initial begin
  clk_1sec <= 0;
  forever #(SE_CYCLE/2) clk_1sec = ~clk_1sec;
end

initial begin
  clk_1ms <= 0;
  forever #(MS_CYCLE/2) clk_1ms = ~clk_1ms;
end

//release of reset_n relative to two clocks
initial begin
  mil_time = '0;
  reset_n <= 0;
  #(SE_CYCLE) reset_n = 1'b1;
end

clock clock_0(.*);

initial begin
  initialize;
  #(SE_CYCLE * 4);
  WR_TIME_TWELVE(5);
  #(SE_CYCLE * 4);
  WR_TIME_MIL(5);
  $fclose(output_file);
  $finish;
end

task initialize;
  begin
    output_file = $fopen("./output_data", "wb");
    if (output_file == 0) begin
      $display("ERROR : CAN NOT OPEN output_file");
    end
  end
endtask

task WR_TIME_TWELVE(input [7:0] rep);
  begin
    for (i=0; i<rep; i++) begin
      @(negedge clk_1sec);
      mil_time = 1'b0;
      $display ("SWG_DATA: %h, SELECTOR: %h", segment_data, digit_select);
      $fwrite (output_file, "SEG_DATA: %h, SELECTOR: %h\n", segment_data, digit_select);
      #(SE_CYCLE * 17529);//wait for 52 mins
    end
  end
endtask

task WR_TIME_MIL(input [7:0] rep);
  begin
    for (i=0; i<rep; i++) begin
      @(negedge clk_1sec);
      mil_time = 1'b1;
      $display ("SWG_DATA: %h, SELECTOR: %h", segment_data, digit_select);
      $fwrite (output_file, "SEG_DATA: %h, SELECTOR: %h\n", segment_data, digit_select);
      #(SE_CYCLE * 17529);//wait for 52 mins
    end
  end
endtask

endmodule
