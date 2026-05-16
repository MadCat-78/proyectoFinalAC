# Declaración de matrices
A:
.word 1,2,3
.word 4,5,6
.word 7,8,9

B:
.word 9,8,7
.word 6,5,4
.word 3,2,1

addi $s0, $zero, 0  # direccion base de A
addi $s1, $zero, 36 # direccion base de B


addi $t0, $zero, 0     # i = 0
LOOP_I:
slti $t1, $t0, 3      # i < 3 ?
beq  $t1, $zero, FIN_I   # si no, salir

    addi $t2, $zero, 0     # j = 0
    LOOP_J:
    slti $t3, $t2, 3      # j < 3 ?
    beq  $t3, $zero, FIN_J   # si no, salir

        addi $t4, $zero, 0     # k = 0
        LOOP_K:
        slti $t5, $t4, 3      # k < 3 ?
        beq  $t5, $zero, FIN_K   # si no, salir

            addi $t6, $zero, 0     # l = 0
            LOOP_L:
            slti $t7, $t6, 10      # l < 10 ?
            beq  $t7, $zero, FIN_L   # si no, salir

            # cuerpo del for

            addi $t6, $t6, 1       # l++
            j LOOP_L
            FIN_L:
            nop

        addi $t4, $t4, 1       # k++
        j LOOP_K
        FIN_K:
        nop

    addi $t2, $t2, 1       # j++
    j LOOP_J
    FIN_J:
    nop

addi $t0, $t0, 1       # i++
j LOOP_I
FIN_I:
nop