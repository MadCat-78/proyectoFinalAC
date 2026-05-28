module UCtrl(
	input [5:0]OP,
	output reg RegWrite,
	output reg [2:0]ALUop,
	output reg MemToRead,
	output reg MemToWrite,
	output reg MemToReg
);
	always @* begin
		RegWrite = 1'b0;
		ALUop = 3'b000;
		MemToRead = 1'b0;
		MemToWrite = 1'b0;
		MemToReg = 1'b0;
		case(OP)
			6'b000000: begin
				RegWrite = 1'b1;
				ALUop = 3'b010;
				MemToRead = 1'b0;
				MemToWrite = 1'b0;
				MemToReg = 1'b0;
			end
		endcase
	end
endmodule
