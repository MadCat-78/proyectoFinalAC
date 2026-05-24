module MUX2a1_5bits(
	input [4:0] A,
	input [4:0] B,
	input sel,
	output reg [4:0] Y
);

always @* begin

	if(sel)
		Y = B;
	else
		Y = A;

end

endmodule
