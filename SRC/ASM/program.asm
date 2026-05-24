addi $s0,$zero,0
addi $s1,$zero,36
addi $s2,$zero,72
nop
nop

addi $t0,$zero,0
nop
nop

LOOP_I:
slti $t1,$t0,3
nop
nop
beq $t1,$zero,FIN_I
nop
nop

addi $t2,$zero,0
nop
nop

LOOP_J:
slti $t3,$t2,3
nop
nop
beq $t3,$zero,FIN_J
nop
nop

addi $t4,$zero,0
nop
nop

LOOP_K:
slti $t5,$t4,3
nop
nop
beq $t5,$zero,FIN_K
nop
nop

add $t8,$t4,$t4
nop
nop
add $t8,$t8,$t4
nop
nop
add $t8,$t8,$t2
nop
nop
add $t8,$t8,$t8
nop
nop
add $t8,$t8,$t8
nop
nop
add $t8,$t8,$s1
nop
nop

lw $t9,0($t8)
nop
nop
nop

addi $s3,$zero,0
nop
nop

addi $t6,$zero,0
nop
nop

LOOP_L:
slt $t7,$t6,$t9
nop
nop
beq $t7,$zero,FIN_L
nop
nop

add $s4,$t0,$t0
nop
nop
add $s4,$s4,$t0
nop
nop
add $s4,$s4,$t4
nop
nop
add $s4,$s4,$s4
nop
nop
add $s4,$s4,$s4
nop
nop
add $s4,$s0,$s4
nop
nop

lw $s5,0($s4)
nop
nop
nop

add $s3,$s3,$s5
nop
nop

addi $t6,$t6,1
nop
nop

j LOOP_L
nop
nop

FIN_L:
nop

add $s6,$t0,$t0
nop
nop
add $s6,$s6,$t0
nop
nop
add $s6,$s6,$t2
nop
nop
add $s6,$s6,$s6
nop
nop
add $s6,$s6,$s6
nop
nop
add $s6,$s2,$s6
nop
nop

lw $s7,0($s6)
nop
nop
nop

add $s7,$s7,$s3
nop
nop

sw $s7,0($s6)
nop
nop

addi $t4,$t4,1
nop
nop

j LOOP_K
nop
nop

FIN_K:
nop

addi $t2,$t2,1
nop
nop

j LOOP_J
nop
nop

FIN_J:
nop

addi $t0,$t0,1
nop
nop

j LOOP_I
nop
nop

FIN_I:
nop
nop
nop
