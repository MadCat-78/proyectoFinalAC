module Mem(
	input MemToRead,
	input MemToWrite,
	input [31:0] address,
	input [31:0] dataWrite,
	output reg [31:0] readData
);
reg [31:0]mem[0:255];

always @* begin
	if(MemToWrite) begin
		mem[address] = dataWrite;
	end
	if(MemToRead) begin
		readData = mem[address];
	end
	else begin
		readData = 32'd0;
	end
end
endmodule
