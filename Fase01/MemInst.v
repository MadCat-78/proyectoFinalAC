module MemInst(
	input [31:0] address,
	output reg [31:0] instruction
);
reg [31:0]mem[0:255];

initial begin
	$readmemb("instrucciones.txt",mem);
end

always @* begin
	instruction = mem[address];
end

endmodule
