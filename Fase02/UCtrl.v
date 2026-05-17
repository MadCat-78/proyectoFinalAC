module UCtrl(
	input [5:0]OP,
	output reg RegWrite,
	output reg [2:0]ALUop,
	output reg MemToRead,
	output reg MemToWrite,
	output reg MemToReg,
	output reg ALUSrc,
	output reg RegDst,
	output reg Branch
);
always @* begin

	RegWrite  = 0;
	ALUop     = 3'b000;
	MemToRead = 0;
	MemToWrite= 0;
	MemToReg  = 0;
	ALUSrc    = 0;
	RegDst    = 0;
	Branch     = 0;

	case(OP)

		// R-TYPE
		6'b000000: begin
			RegWrite = 1;
			RegDst = 1;
			ALUSrc = 0;
			ALUop = 3'b010;
		end

		// ADDI
		6'b001000: begin
			RegWrite = 1;
			RegDst = 0;
			ALUSrc = 1;
			ALUop = 3'b010;
		end

		// ANDI
		6'b001100: begin
			RegWrite = 1;
			RegDst = 0;
			ALUSrc = 1;
			ALUop = 3'b000;
		end

		// ORI
		6'b001101: begin
			RegWrite = 1;
			RegDst = 0;
			ALUSrc = 1;
			ALUop = 3'b001;
		end

		// SLTI
		6'b001010: begin
			RegWrite = 1;
			RegDst = 0;
			ALUSrc = 1;
			ALUop = 3'b111;
		end

		// LW
		6'b100011: begin
			RegWrite = 1;
			RegDst = 0;
			ALUSrc = 1;
			MemToRead = 1;
			MemToReg = 1;
			ALUop = 3'b010;
		end

		// SW
		6'b101011: begin
			ALUSrc = 1;
			MemToWrite = 1;
			ALUop = 3'b010;
		end

		// BEQ
		6'b000100: begin
			Branch = 1;
			ALUop = 3'b110;
		end

	endcase
end
endmodule
