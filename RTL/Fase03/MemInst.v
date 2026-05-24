module MemInst(

	input [31:0] address,
	output reg [31:0] instruction

);

reg [31:0] mem[0:255];

integer i;

initial begin

	for(i = 0; i < 256; i = i + 1)
		mem[i] = 32'd0;

	$readmemb("instrucciones.txt", mem);

end

always @* begin

	instruction = mem[address >> 2];

end

endmodule
