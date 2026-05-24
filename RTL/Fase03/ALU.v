module ALU(
	input [31:0] a,
	input [31:0] b,
	input [2:0] ctrl,
	output reg [31:0] res,
	output zero
);

always @* begin
	case(ctrl)
		3'b000: res = a & b;
		3'b001: res = a | b;
		3'b010: res = a + b;
		3'b100: res = ~(a | b);
		3'b110: res = a - b;
		3'b111: res = (a < b) ? 32'd1 : 32'd0;
		default: res = 32'd0;
	endcase
end

assign zero = (res == 0);

endmodule
