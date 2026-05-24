module Mem(

	input clk,

	input MemToRead,
	input MemToWrite,

	input [31:0] address,
	input [31:0] dataWrite,

	output reg [31:0] readData

);

reg [31:0] mem[0:255];

initial begin

	// MATRIZ A
	mem[0] = 1;
	mem[1] = 2;
	mem[2] = 3;

	mem[3] = 4;
	mem[4] = 5;
	mem[5] = 6;

	mem[6] = 7;
	mem[7] = 8;
	mem[8] = 9;

	// MATRIZ B
	mem[9]  = 9;
	mem[10] = 8;
	mem[11] = 7;

	mem[12] = 6;
	mem[13] = 5;
	mem[14] = 4;

	mem[15] = 3;
	mem[16] = 2;
	mem[17] = 1;

	// MATRIZ C
	mem[18] = 0;
	mem[19] = 0;
	mem[20] = 0;
	mem[21] = 0;
	mem[22] = 0;
	mem[23] = 0;
	mem[24] = 0;
	mem[25] = 0;
	mem[26] = 0;

end

// WRITE
always @(posedge clk) begin

	if(MemToWrite)
		mem[address >> 2] <= dataWrite;

end

// READ
always @* begin

	if(MemToRead)
		readData = mem[address >> 2];
	else
		readData = 32'd0;

end

endmodule
