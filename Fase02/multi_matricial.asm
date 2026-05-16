addi $t0, $zero, 0     # i = 0

LOOP_I:
slti $t1, $t0, 10      # i < 10 ?
beq  $t1, $zero, FIN_I   # si no, salir

    addi $t0, $zero, 0     # i = 0

    LOOP_J:
    slti $t1, $t0, 10      # i < 10 ?
    beq  $t1, $zero, FIN_J   # si no, salir

        addi $t0, $zero, 0     # i = 0

        LOOP_K:
        slti $t1, $t0, 10      # i < 10 ?
        beq  $t1, $zero, FIN_K   # si no, salir

            addi $t0, $zero, 0     # i = 0

            LOOP_L:
            slti $t1, $t0, 10      # i < 10 ?
            beq  $t1, $zero, FIN_L   # si no, salir

            # cuerpo del for

            addi $t0, $t0, 1       # i++
            j LOOP_L

            FIN_L:
            nop

        addi $t0, $t0, 1       # i++
        j LOOP_K

        FIN_K:
        nop

    addi $t0, $t0, 1       # i++
    j LOOP_J

    FIN_J:
    nop

addi $t0, $t0, 1       # i++
j LOOP_I

FIN_I:
nop