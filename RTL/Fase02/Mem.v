module Mem(

	input clk,

	input MemToRead,
	input MemToWrite,

	input [31:0] address,
	input [31:0] dataWrite,

	output reg [31:0] readData

);

reg [31:0] mem[0:255];

// WRITE
always @(posedge clk) begin

	if(MemToWrite)
		mem[address] <= dataWrite;

end

// READ
always @* begin

	if(MemToRead)
		readData = mem[address];
	else
		readData = 32'd0;

end

endmodule
