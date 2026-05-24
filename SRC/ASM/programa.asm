addi $s0, $zero, 0
addi $s1, $zero, 36
addi $s2, $zero, 72

addi $t0, $zero, 0

LOOP_I:
slti $t1, $t0, 3
beq  $t1, $zero, FIN_I

addi $t2, $zero, 0

LOOP_J:
slti $t3, $t2, 3
beq  $t3, $zero, FIN_J

addi $t4, $zero, 0

LOOP_K:
slti $t5, $t4, 3
beq  $t5, $zero, FIN_K

add $t8, $t4, $t4
add $t8, $t8, $t4

add $t8, $t8, $t2

add $t8, $t8, $t8
add $t8, $t8, $t8

lw $t9, 0($t8)

addi $s3, $zero, 0

addi $t6, $zero, 0

LOOP_L:
slt $t7, $t6, $t9
beq $t7, $zero, FIN_L

add $s4, $t0, $t0
add $s4, $s4, $t0

add $s4, $s4, $t4

add $s4, $s4, $s4
add $s4, $s4, $s4

add $s4, $s0, $s4

lw $s5, 0($s4)

add $s3, $s3, $s5

addi $t6, $t6, 1

j LOOP_L

FIN_L:
nop

add $s6, $t0, $t0
add $s6, $s6, $t0

add $s6, $s6, $t2

add $s6, $s6, $s6
add $s6, $s6, $s6

add $s6, $s2, $s6

lw $s7, 0($s6)

add $s7, $s7, $s3

sw $s7, 0($s6)

addi $t4, $t4, 1

j LOOP_K

FIN_K:
nop

addi $t2, $t2, 1

j LOOP_J

FIN_J:
nop

addi $t0, $t0, 1

j LOOP_I

FIN_I:
nop
