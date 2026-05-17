module MEM_WB(

	input clk,

	input RegWrite_in,
	input MemToReg_in,

	input [31:0] MemData_in,
	input [31:0] ALUout_in,

	input [4:0] WriteReg_in,

	output reg RegWrite_out,
	output reg MemToReg_out,

	output reg [31:0] MemData_out,
	output reg [31:0] ALUout_out,

	output reg [4:0] WriteReg_out

);

always @(posedge clk) begin

	RegWrite_out <= RegWrite_in;
	MemToReg_out <= MemToReg_in;

	MemData_out <= MemData_in;
	ALUout_out <= ALUout_in;

	WriteReg_out <= WriteReg_in;

end

endmodule
