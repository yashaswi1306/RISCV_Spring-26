
.global count

count:
addi sp, sp, -16
sd ra,0(sp)
mv a4,a0
li a3,0
l1:
beqz a4,fin
li a5, 1
beq a5,a4,fin
andi a5,a4,1
beqz a5,le
j lo

le:
srai a4,a4,1
addi a3,a3,1
j l1
lo:
add a6,a4,a4
add a4,a4,a6
addi a3,a3,1
addi a4,a4,1
j l1

fin:
mv a0,a3
ld ra,0(sp)
addi sp,sp,16
jr ra

