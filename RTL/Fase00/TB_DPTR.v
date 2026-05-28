module TB_DPTR;

reg[31:0] instruccion;

wire [31:0] resultado;

DPTR uut (
        .instr(instruccion),
        .result(resultado)
    );

    initial begin
        $monitor("t=%0t instr=%h result=%h", $time, instruccion, resultado);

        instruccion = 32'b000000_00000_00000_0000_00000_000000;
        #10;

        // op=000000, rs=1, rt=2, rd=3, func=100000 (ADD)
        instruccion = 32'b000000_00001_00010_00011_00000_100000;
        #10;

        // Caso 2: otra operación (ejemplo SUB)
        instruccion = 32'b000000_00001_00010_00011_00000_100010;
        #10;

        //Caso 3: AND
        instruccion = 32'b000000_00001_00010_00011_00000_100100;
        #10;

    end

endmodule