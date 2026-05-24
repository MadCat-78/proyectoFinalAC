// ============================================================
//  TB_DPTR.v  —  Testbench completo para el datapath pipeline
//
//  Prueba:
//    1. ADDI / instrucciones básicas
//    2. ADD, SUB, AND (R-type)
//    3. SW / LW (memoria de datos)
//    4. BEQ tomado  → flush de IF/ID e ID/EX
//    5. J (jump)    → flush de IF/ID e ID/EX
//
//  Valores esperados al final:
//    $t0 (r8)  = 55   (jump sobreescribe el 10 original)
//    $t1 (r9)  = 20
//    $t2 (r10) = 5
//    $t3 (r11) = 30   (ADD $t0+$t1)
//    $t4 (r12) = 10   (SUB $t1-$t0)
//    $t5 (r13) = 0    (AND $t0&$t1)
//    $s0 (r16) = 10   (LW desde MEM[0])
//    $s1 (r17) = 99   (branch tomado, no 55)
//    MEM[0]    = 10   (SW $t0)
// ============================================================
 
module TB_DPTR;
 reg clk;
 
initial clk = 0;
always #5000 clk = ~clk;   // periodo = 10 ns
 
wire [31:0] result;
 
DPTR uut(
    .clk(clk),
    .result(result)
);
 initial begin
    $monitor("TIME=%0t  PC=%h  INSTR=%b  RESULT=%h",
             $time,
             uut.PC,
             uut.instruction,
             result);
end
 
integer errores;
 
task check;
    input [63:0] nombre;    // hasta 8 chars como string
    input [31:0] got;
    input [31:0] expected;
    begin
        if (got !== expected) begin
            $display("  FALLO  %s : obtenido=%0d  esperado=%0d",
                     nombre, got, expected);
            errores = errores + 1;
        end else begin
            $display("  OK     %s = %0d", nombre, got);
        end
    end
endtask
 
initial begin
 
    errores = 0;
 
    // 39 instrucciones + 5 etapas de pipeline = ~44 ciclos
    // 44 ciclos x 10 ns = 440 ns → usamos 500 ns con margen
    #500000;
 
    $display("");
    $display("============================================");
    $display("  RESULTADOS FINALES");
    $display("============================================");
 
    // --- Registros básicos ---
    check("t0(r8) ", uut.RF.mem[8],  32'd55);  // jump lo sobreescribe
    check("t1(r9) ", uut.RF.mem[9],  32'd20);
    check("t2(r10)", uut.RF.mem[10], 32'd5);
 
    // --- R-type ---
    check("t3(r11)", uut.RF.mem[11], 32'd30);  // ADD 10+20
    check("t4(r12)", uut.RF.mem[12], 32'd10);  // SUB 20-10
    check("t5(r13)", uut.RF.mem[13], 32'd0);   // AND 10&20
 
    // --- Memoria (SW/LW) ---
    check("MEM[0] ", uut.MEM.mem[0], 32'd10);
    check("s0(r16)", uut.RF.mem[16], 32'd10);  // LW
 
    // --- Branch tomado ---
    // $s1 debe ser 99 (destino del branch), NO 55 (instrucción saltada)
    check("s1(r17)", uut.RF.mem[17], 32'd99);
 
    // --- Jump ---
    // $t0 ya fue verificado arriba (debe ser 55, no 77 que era la instrucción saltada)
 
    $display("============================================");
    if (errores == 0)
        $display("  TODOS LOS TESTS PASARON :)");
    else
        $display("  %0d TEST(S) FALLARON", errores);
    $display("============================================");
    $display("");
 
    // Dump final de todos los registros para inspección manual
    $display("--- Banco de registros completo ---");
    $display("  r0  = %0d", uut.RF.mem[0]);
    $display("  r8  ($t0) = %0d", uut.RF.mem[8]);
    $display("  r9  ($t1) = %0d", uut.RF.mem[9]);
    $display("  r10 ($t2) = %0d", uut.RF.mem[10]);
    $display("  r11 ($t3) = %0d", uut.RF.mem[11]);
    $display("  r12 ($t4) = %0d", uut.RF.mem[12]);
    $display("  r13 ($t5) = %0d", uut.RF.mem[13]);
    $display("  r16 ($s0) = %0d", uut.RF.mem[16]);
    $display("  r17 ($s1) = %0d", uut.RF.mem[17]);
    $display("");
    $display("--- Memoria de datos ---");
    $display("  MEM[0] = %0d", uut.MEM.mem[0]);
 
    $finish;
 
end
 
endmodule