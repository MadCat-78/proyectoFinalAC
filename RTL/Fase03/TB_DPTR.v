module TB_DPTR;

reg clk;

wire [31:0] result;

DPTR uut(
	.clk(clk),
	.result(result)
);

initial begin
	clk = 0;
end

always #5 clk = ~clk;

always @(posedge clk) begin

	$display("--------------------------------");

	$display("PC = %h", uut.PC);

	$display("INSTR = %b", uut.instruction);

	$display("ALUOUT = %d", uut.ALUout);

	$display("ZERO = %b", uut.zeroFlag);

end

initial begin

	$monitor(
		"TIME=%0d PC=%h RESULT=%h",
		$time,
		uut.PC,
		result
	);

	#300;

	$display("REGISTERS");
	$display("t0 = %d", uut.RF.mem[8]);
	$display("t1 = %d", uut.RF.mem[9]);
	$display("t2 = %d", uut.RF.mem[10]);
	$display("t3 = %d", uut.RF.mem[11]);
	$display("t4 = %d", uut.RF.mem[12]);

	$display("MEM[0] = %d", uut.MEM.mem[0]);

	
	$display("MATRIZ C");

	$display("%d %d %d",
    		uut.MEM.mem[18],
    		uut.MEM.mem[19],
	    	uut.MEM.mem[20]);

	$display("%d %d %d",
    		uut.MEM.mem[21],
    		uut.MEM.mem[22],
    		uut.MEM.mem[23]);

	$display("%d %d %d",
    		uut.MEM.mem[24],
    		uut.MEM.mem[25],
    		uut.MEM.mem[26]);


	$finish;
end

endmodule