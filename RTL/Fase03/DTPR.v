module DPTR(

	input clk,
	output [31:0] result

);

wire [31:0] PC;
wire [31:0] nextPC;
wire [31:0] PCplus4;

wire flush;

pc PCREG(
	.clk(clk),
	.address(nextPC),
	.newAddress(PC)
);

add32b ADDPC(
	.a(PC),
	.b(32'd4),
	.result(PCplus4)
);


wire [31:0] instruction;

MemInst IM(
	.address(PC),
	.instruction(instruction)
);


wire [31:0] IFID_PC;
wire [31:0] IFID_INSTR;

IF_ID IFID(

	.clk(clk),
	.flush(flush),

	.pc_in(PCplus4),
	.instr_in(instruction),

	.pc_out(IFID_PC),
	.instr_out(IFID_INSTR)

);


wire [5:0] op;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [5:0] func;

assign op   = IFID_INSTR[31:26];
assign rs   = IFID_INSTR[25:21];
assign rt   = IFID_INSTR[20:16];
assign rd   = IFID_INSTR[15:11];
assign func = IFID_INSTR[5:0];


wire RegWrite;
wire [2:0] ALUop;
wire MemToRead;
wire MemToWrite;
wire MemToReg;
wire ALUSrc;
wire RegDst;
wire Branch;
wire Jump;
wire ExtOp;

UCtrl CTRL(

	.OP(op),

	.RegWrite(RegWrite),
	.ALUop(ALUop),
	.MemToRead(MemToRead),
	.MemToWrite(MemToWrite),
	.MemToReg(MemToReg),
	.ALUSrc(ALUSrc),
	.RegDst(RegDst),
	.Branch(Branch),
	.Jump(Jump),
	.ExtOp(ExtOp)

);


wire [31:0] RD1;
wire [31:0] RD2;

wire WB_RegWrite;
wire [31:0] WB_WriteData;
wire [4:0] WB_WriteReg;

BR RF(

	.clk(clk),

	.WE(WB_RegWrite),

	.AR1(rs),
	.AR2(rt),

	.AW(WB_WriteReg),

	.DW(WB_WriteData),

	.DR1(RD1),
	.DR2(RD2)

);


wire [31:0] SignImm;
wire [31:0] ZeroImm;
wire [31:0] ImmExt;

SignExtend SE(
	.in(IFID_INSTR[15:0]),
	.out(SignImm)
);

ZeroExtend ZE(
	.in(IFID_INSTR[15:0]),
	.out(ZeroImm)
);

MUX2a1 EXT_MUX(
	.A(ZeroImm),
	.B(SignImm),
	.sel(ExtOp),
	.Y(ImmExt)
);


wire [31:0] jumpAddress;

assign jumpAddress = {
	IFID_PC[31:28],
	IFID_INSTR[25:0],
	2'b00
};


wire IDEX_RegWrite;
wire [2:0] IDEX_ALUop;
wire IDEX_MemToRead;
wire IDEX_MemToWrite;
wire IDEX_MemToReg;
wire IDEX_ALUSrc;
wire IDEX_RegDst;
wire IDEX_Branch;

wire [31:0] IDEX_PC;

wire [31:0] IDEX_RD1;
wire [31:0] IDEX_RD2;
wire [31:0] IDEX_SignImm;

wire [4:0] IDEX_rs;
wire [4:0] IDEX_rt;
wire [4:0] IDEX_rd;

wire [5:0] IDEX_func;

ID_EX IDEX(

	.clk(clk),
	.flush(flush)

	.RegWrite_in(RegWrite),
	.ALUop_in(ALUop),
	.MemToRead_in(MemToRead),
	.MemToWrite_in(MemToWrite),
	.MemToReg_in(MemToReg),
	.ALUSrc_in(ALUSrc),
	.RegDst_in(RegDst),
	.Branch_in(Branch),

	.PC_in(IFID_PC),

	.RD1_in(RD1),
	.RD2_in(RD2),
	.SignImm_in(ImmExt),

	.rs_in(rs),
	.rt_in(rt),
	.rd_in(rd),

	.func_in(func),

	.RegWrite_out(IDEX_RegWrite),
	.ALUop_out(IDEX_ALUop),
	.MemToRead_out(IDEX_MemToRead),
	.MemToWrite_out(IDEX_MemToWrite),
	.MemToReg_out(IDEX_MemToReg),
	.ALUSrc_out(IDEX_ALUSrc),
	.RegDst_out(IDEX_RegDst),
	.Branch_out(IDEX_Branch),

	.PC_out(IDEX_PC),

	.RD1_out(IDEX_RD1),
	.RD2_out(IDEX_RD2),
	.SignImm_out(IDEX_SignImm),

	.rs_out(IDEX_rs),
	.rt_out(IDEX_rt),
	.rd_out(IDEX_rd),

	.func_out(IDEX_func)

);


wire [31:0] ALUb;

MUX2a1 ALUSRCMUX(
	.A(IDEX_RD2),
	.B(IDEX_SignImm),
	.sel(IDEX_ALUSrc),
	.Y(ALUb)
);


wire [2:0] ALUctrl_out;

ALUctrl ALUCTRL(
	.func(IDEX_func),
	.ALUop(IDEX_ALUop),
	.ctrl(ALUctrl_out)
);


wire [31:0] ALUout;
wire zeroFlag;

ALU alu(
	.a(IDEX_RD1),
	.b(ALUb),
	.ctrl(ALUctrl_out),
	.res(ALUout),
	.zero(zeroFlag)
);


wire [4:0] EX_WriteReg;

MUX2a1_5bits REGDSTMUX(
	.A(IDEX_rt),
	.B(IDEX_rd),
	.sel(IDEX_RegDst),
	.Y(EX_WriteReg)
);


wire [31:0] branchOffset;
wire [31:0] branchAddress;

assign branchOffset = IDEX_SignImm << 2;

add32b BRADD(
	.a(IDEX_PC),
	.b(branchOffset),
	.result(branchAddress)
);


wire EXMEM_RegWrite;
wire EXMEM_MemToRead;
wire EXMEM_MemToWrite;
wire EXMEM_MemToReg;
wire EXMEM_Branch;

wire EXMEM_zero;

wire [31:0] EXMEM_ALUout;
wire [31:0] EXMEM_RD2;
wire [31:0] EXMEM_branchAddress;

wire [4:0] EXMEM_WriteReg;

EX_MEM EXMEM(

	.clk(clk),

	.RegWrite_in(IDEX_RegWrite),
	.MemToRead_in(IDEX_MemToRead),
	.MemToWrite_in(IDEX_MemToWrite),
	.MemToReg_in(IDEX_MemToReg),
	.Branch_in(IDEX_Branch),

	.zero_in(zeroFlag),

	.ALUout_in(ALUout),
	.RD2_in(IDEX_RD2),
	.branchAddress_in(branchAddress),

	.WriteReg_in(EX_WriteReg),

	.RegWrite_out(EXMEM_RegWrite),
	.MemToRead_out(EXMEM_MemToRead),
	.MemToWrite_out(EXMEM_MemToWrite),
	.MemToReg_out(EXMEM_MemToReg),
	.Branch_out(EXMEM_Branch),

	.zero_out(EXMEM_zero),

	.ALUout_out(EXMEM_ALUout),
	.RD2_out(EXMEM_RD2),
	.branchAddress_out(EXMEM_branchAddress),

	.WriteReg_out(EXMEM_WriteReg)

);


wire [31:0] MemData;

Mem MEM(

	.clk(clk),

	.MemToRead(EXMEM_MemToRead),
	.MemToWrite(EXMEM_MemToWrite),

	.address(EXMEM_ALUout),
	.dataWrite(EXMEM_RD2),

	.readData(MemData)

);


wire PCSrc;

assign PCSrc = EXMEM_Branch & EXMEM_zero;


wire [31:0] PCBranch;

MUX2a1 PCMUX1(
	.A(PCplus4),
	.B(EXMEM_branchAddress),
	.sel(PCSrc),
	.Y(PCBranch)
);

MUX2a1 PCMUX2(
	.A(PCBranch),
	.B(jumpAddress),
	.sel(Jump),
	.Y(nextPC)
);


assign flush = PCSrc | Jump;


wire MEMWB_RegWrite;
wire MEMWB_MemToReg;

wire [31:0] MEMWB_MemData;
wire [31:0] MEMWB_ALUout;

wire [4:0] MEMWB_WriteReg;

MEM_WB MEMWB(

	.clk(clk),

	.RegWrite_in(EXMEM_RegWrite),
	.MemToReg_in(EXMEM_MemToReg),

	.MemData_in(MemData),
	.ALUout_in(EXMEM_ALUout),

	.WriteReg_in(EXMEM_WriteReg),

	.RegWrite_out(MEMWB_RegWrite),
	.MemToReg_out(MEMWB_MemToReg),

	.MemData_out(MEMWB_MemData),
	.ALUout_out(MEMWB_ALUout),

	.WriteReg_out(MEMWB_WriteReg)

);


MUX2a1 MEMTOREG(

	.A(MEMWB_ALUout),
	.B(MEMWB_MemData),

	.sel(MEMWB_MemToReg),

	.Y(WB_WriteData)

);

assign WB_RegWrite = MEMWB_RegWrite;
assign WB_WriteReg = MEMWB_WriteReg;

assign result = MEMWB_ALUout;

endmodule
