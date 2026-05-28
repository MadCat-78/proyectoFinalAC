module DPTR(
	input [31:0] instr,
	output [31:0] result 
);
	wire [5:0] op;
	wire [5:0] func;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd;

	assign op = instr[31:26];
	assign rs = instr[25:21];
	assign rt = instr[20:16];
	assign rd = instr[15:11];
	assign func = instr[5:0];

	wire RegWrite;
	wire MemToRead;
	wire MemToWrite;
	wire MemToReg;
	wire [2:0] ALUop;
	wire [2:0] ALUctrl_out;

	UCtrl CU(
		.OP(op),
		.RegWrite(RegWrite),
		.ALUop(ALUop),
		.MemToRead(MemToRead),
		.MemToWrite(MemToWrite),
		.MemToReg(MemToReg)
	);

	ALUctrl ALUCTRL(
		.func(func),
		.ALUop(ALUop),
		.ctrl(ALUctrl_out)
	);

	wire [31:0] RD1;
	wire [31:0] RD2;
	wire [31:0] WD;

	BR RF(
		.WE(RegWrite),
		.AR1(rs),
		.AR2(rt),
		.AW(rd),
		.DW(WD),
		.DR1(RD1),
		.DR2(RD2)
	);

	wire [31:0] ALUout;

	ALU alu(
		.a(RD1),
		.b(RD2),
		.ctrl(ALUctrl_out),
		.res(ALUout),
		.zero()
	);

	wire [31:0] MemData;

	Mem MEM(
		.MemToRead(MemToRead),
		.MemToWrite(MemToWrite),
		.address(ALUout[7:0]),
		.dataWrite(RD2),
		.readData(MemData)
	);

	MUX2a1 mux_wb(
		.A(ALUout),
		.B(MemData),
		.sel(MemToReg),
		.Y(WD)
	);

	assign result = ALUout;
endmodule
































































