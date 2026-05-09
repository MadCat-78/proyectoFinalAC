module MUX2a1(
	input [31:0] A,
	input [31:0] B,
	input sel,
	output reg [31:0] Y
);
always @* begin
	if(sel) begin
		Y = B;
	end
	else begin
		Y = A;
	end
end
endmodule
