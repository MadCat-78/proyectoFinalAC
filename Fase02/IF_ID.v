module IF_ID(

	input clk,

	input [31:0] pc_in,
	input [31:0] instr_in,

	output reg [31:0] pc_out,
	output reg [31:0] instr_out

);

always @(posedge clk) begin

	pc_out <= pc_in;
	instr_out <= instr_in;

end

endmodule
