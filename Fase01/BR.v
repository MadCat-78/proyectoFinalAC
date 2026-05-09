module BR(
	input WE,
	input [4:0]AR1,
	input [4:0]AR2,
	input [4:0]AW,
	input [31:0]DW,
	output reg[31:0]DR1,
	output reg[31:0]DR2
);
reg [31:0]mem[0:31];
initial
begin
	$readmemb("bReg.txt",mem);
end
always @*
begin
	DR1=mem[AR1];
	DR2=mem[AR2];
	if(WE)
	begin
		mem[AW]=DW;
	end
end
endmodule
