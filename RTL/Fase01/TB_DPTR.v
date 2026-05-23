module TB_DPTR;

reg[31:0] PC;

wire [31:0] resultado;

DPTR uut (
        .PC(PC),
        .result(resultado)
    );

    initial begin
        $monitor("PC=%d result=%h", $time, PC, resultado);

        PC = 0;
        #10;

        PC = 1;
        #10;

        PC = 2;
        #10;

        PC = 3;
        #10;

	PC = 4;
	#10;

	$finish;

    end

endmodule