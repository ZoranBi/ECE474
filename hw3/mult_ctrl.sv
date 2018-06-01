module mult_ctrl(
input clk,
input reset,
input start,
input multiplier_bit0,
output logic shift,
output logic load,
output logic done
);

enum logic [1:0]{
	IDLE = 2'b00,
	TEST = 2'b01,
	SHIFT = 2'b10,
	ADD = 2'b11
} ps, ns;

logic [4:0] cnt;

always_ff @(posedge clk, posedge reset) begin
	if(reset) ps <= IDLE;
	else ps <=ns;
end

always_ff @(posedge clk, posedge reset) begin
	if(reset) cnt<=5'b0;
	else if(ps==SHIFT) cnt <= cnt+1;
	else cnt<=cnt;
end

always_comb begin
	unique case(ps)
	IDLE:begin
		if(start) ns=TEST;
		else ns=IDLE;
		shift=1'b0;
		load =1'b0;
		done=1'b0;
	end
	TEST: begin
		if(multiplier_bit0) ns=ADD;
		else ns=SHIFT;
		shift=1'b0;
		load = 1'b0;
	end
	SHIFT: begin
		shift =1'b1;
		load = 1'b0;
		if(cnt==5'b11111) begin
			ns=IDLE;
			done = 1'b1;
		end
		else begin
			ns=TEST;
			done=1'b0;
		end
	end
	ADD:begin
		load = 1'b1;
		shift=1'b0;
		ns=SHIFT;
	end
	endcase
end

endmodule
