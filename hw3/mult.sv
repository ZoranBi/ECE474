module mult(
  input  reset,
  input  clk,
  input  [31:0] a_in,
  input  [31:0] b_in,
  input  start,
  output logic [63:0] product,
  output logic done
  );

  logic [31:0] prod_reg_high;
  logic [31:0] prod_reg_low;
  logic shift;
  logic load;
  logic [31:0] reg_a;

  assign product = {prod_reg_high,prod_reg_low};

  always_ff @(posedge clk, posedge reset) begin
    if(reset) reg_a<=32'b0;
    else if(start) reg_a<=a_in;
    else reg_a<=reg_a;
  end

  always_ff @(posedge clk, posedge reset) begin
    unique if(reset)
      prod_reg_low <=32'b0;
    else if(start) begin
      prod_reg_low <= b_in;
    end
    else if(shift) begin
      prod_reg_low<={prod_reg_high[0],prod_reg_low[31:1]};
    end
    else
      prod_reg_low<=prod_reg_low;
  end

  always_ff @(posedge clk, posedge reset) begin
      unique if(reset) prod_reg_high <=32'b0;
      else if(start) begin
        prod_reg_high <= 32'b0;
      end
      else if(shift) begin
        prod_reg_high <= {1'b0,prod_reg_high[31:1]};
      end
      else if(load) begin
        prod_reg_high <= prod_reg_high + reg_a;
      end
      else begin
        prod_reg_high <=prod_reg_high;
      end
  end

  mult_ctrl mult_ctrl_0(
    .clk(clk),
    .reset(reset),
    .start(start),
    .multiplier_bit0(prod_reg_low[0]),
    .shift(shift),
    .load(load),
    .done(done)
    );

    endmodule
