module Mem(

	input clk,

	input MemToRead,
	input MemToWrite,

	input [31:0] address,
	input [31:0] dataWrite,

	output reg [31:0] readData

);

reg [31:0] mem[0:255];

integer i;

initial begin

	for(i = 0; i < 256; i = i + 1)
		mem[i] = 0;

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

end

// WRITE
always @(posedge clk) begin

	if(MemToWrite) begin

		mem[address >> 2] <= dataWrite;

		$display(
			"WRITE MEM[%d] = %d",
			address >> 2,
			dataWrite
		);

	end

end

// READ
always @* begin

	if(MemToRead)
		readData = mem[address >> 2];
	else
		readData = 32'd0;

end

endmodule
