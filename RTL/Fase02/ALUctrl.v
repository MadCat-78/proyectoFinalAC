module ALUctrl(
	input [5:0] func,
	input [2:0] ALUop,
	output reg [2:0] ctrl
);

always @* begin

	case(ALUop)

		// ANDI
		3'b000: ctrl = 3'b000;

		// ORI
		3'b001: ctrl = 3'b001;

		// ADD
		3'b010: ctrl = 3'b010;

		// BEQ SUB
		3'b110: ctrl = 3'b110;

		// SLTI
		3'b111: ctrl = 3'b111;

		// R-TYPE
		3'b011: begin

			case(func)

				6'b100000: ctrl = 3'b010; // ADD
				6'b100010: ctrl = 3'b110; // SUB
				6'b100100: ctrl = 3'b000; // AND
				6'b100101: ctrl = 3'b001; // OR
				6'b100111: ctrl = 3'b100; // NOR
				6'b101010: ctrl = 3'b111; // SLT

				default: ctrl = 3'b000;

			endcase

		end

		default: ctrl = 3'b000;

	endcase

end

endmodule
