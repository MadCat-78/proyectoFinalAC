module ID_EX(

	input clk,

	input RegWrite_in,
	input [2:0] ALUop_in,
	input MemToRead_in,
	input MemToWrite_in,
	input MemToReg_in,
	input ALUSrc_in,
	input RegDst_in,
	input Branch_in,

	input [31:0] PC_in,

	input [31:0] RD1_in,
	input [31:0] RD2_in,
	input [31:0] SignImm_in,

	input [4:0] rs_in,
	input [4:0] rt_in,
	input [4:0] rd_in,

	input [5:0] func_in,

	output reg RegWrite_out,
	output reg [2:0] ALUop_out,
	output reg MemToRead_out,
	output reg MemToWrite_out,
	output reg MemToReg_out,
	output reg ALUSrc_out,
	output reg RegDst_out,
	output reg Branch_out,

	output reg [31:0] PC_out,

	output reg [31:0] RD1_out,
	output reg [31:0] RD2_out,
	output reg [31:0] SignImm_out,

	output reg [4:0] rs_out,
	output reg [4:0] rt_out,
	output reg [4:0] rd_out,

	output reg [5:0] func_out

);

always @(posedge clk) begin

	RegWrite_out  <= RegWrite_in;
	ALUop_out     <= ALUop_in;
	MemToRead_out <= MemToRead_in;
	MemToWrite_out<= MemToWrite_in;
	MemToReg_out  <= MemToReg_in;
	ALUSrc_out    <= ALUSrc_in;
	RegDst_out    <= RegDst_in;
	Branch_out    <= Branch_in;

	PC_out <= PC_in;

	RD1_out <= RD1_in;
	RD2_out <= RD2_in;
	SignImm_out <= SignImm_in;

	rs_out <= rs_in;
	rt_out <= rt_in;
	rd_out <= rd_in;

	func_out <= func_in;

end

endmodule
