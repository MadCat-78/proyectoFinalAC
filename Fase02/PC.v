module pc(
	input clk,
	input [31:0] address,
	output reg [31:0] newAddress
);

initial begin
	newAddress = 0;
end

always @(posedge clk) begin
	newAddress <= address;
end

endmodule
