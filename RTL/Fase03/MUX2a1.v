module MUX2a1(
	input [31:0] A,
	input [31:0] B,
	input sel,
	output reg [31:0] Y
);

always @* begin

	if(sel)
		Y = B;
	else
		Y = A;

end

endmodule
