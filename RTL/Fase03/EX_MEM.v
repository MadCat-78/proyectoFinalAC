module EX_MEM(

	input clk,

	input RegWrite_in,
	input MemToRead_in,
	input MemToWrite_in,
	input MemToReg_in,
	input Branch_in,

	input zero_in,

	input [31:0] ALUout_in,
	input [31:0] RD2_in,
	input [31:0] branchAddress_in,

	input [4:0] WriteReg_in,

	output reg RegWrite_out,
	output reg MemToRead_out,
	output reg MemToWrite_out,
	output reg MemToReg_out,
	output reg Branch_out,

	output reg zero_out,

	output reg [31:0] ALUout_out,
	output reg [31:0] RD2_out,
	output reg [31:0] branchAddress_out,

	output reg [4:0] WriteReg_out

);

always @(posedge clk) begin

	RegWrite_out <= RegWrite_in;
	MemToRead_out <= MemToRead_in;
	MemToWrite_out <= MemToWrite_in;
	MemToReg_out <= MemToReg_in;
	Branch_out <= Branch_in;

	zero_out <= zero_in;

	ALUout_out <= ALUout_in;
	RD2_out <= RD2_in;
	branchAddress_out <= branchAddress_in;

	WriteReg_out <= WriteReg_in;

end

endmodule
