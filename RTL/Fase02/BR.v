module BR(

	input clk,
	input WE,

	input [4:0] AR1,
	input [4:0] AR2,
	input [4:0] AW,

	input [31:0] DW,

	output reg [31:0] DR1,
	output reg [31:0] DR2

);

reg [31:0] mem[0:31];

initial begin
	$readmemb("bReg.txt", mem);
end

// READ
always @* begin

	DR1 = mem[AR1];
	DR2 = mem[AR2];

end

// WRITE
always @(posedge clk) begin

	if(WE && AW != 0)
		mem[AW] <= DW;

	mem[0] <= 32'd0;

end

endmodule
