
.global str
str:
addi sp,sp,-16
sd ra,0(sp)

mv a4,a0
mv t3,a0 
#a2 is pointer
li a3,0
#a3 is strlen
li a2,0
#t4 is flag
li t2,1
#t2 is carry
li a6,48
li a7,49
#a6 is 0
li a1,66

len:
lbu a5,0(a4)
#a5 has each char
beqz a5,l2

beq a5,a1,cont
beq a5,a6, cont
beq a5,a7,cont
li a0,-1
j re

cont:
addi a3,a3,1
addi a4,a4,1
j len

l2:
addi a4,a4,-1
lbu a5,0(a4)
beq a5,a1,B0
li a0,-1
j re

B0:
sb a1,0(a4)
j B1

B1:
addi a4,a4,-1
#2nd B 
lbu a5,0(a4)
beq a5,a1,B2
beq a1,a5,B2
#while 1st B not reached.
#sub a5,a5,t1
beq a5,a6,zero
beq a5,a7,one
li a0,-1
j re

zero:

sb a7,0(a4)
li t2,0
j fin

beqz a5,a
sb a7, 0(a4)
j B1
a:
sb a6, 0(a4)
j B1

one:
beqz t2,re

#if carry is 0, no change
# if not okay, then carry remains 1 but now 1->0
sb a6,0(a4)

j B1


f2:
j re

ok:
sb a7,0(a4)
j B1

B2:
#now number is of format B_binary_B so correct.
beqz a2,overwrite
sb a1, 0(a4)
j re

overwrite:
#li t4,1
sb a7,0(a4)
j re


fin:
mv a0,t3
#addi a0,a0,1
#sb t4,0(a0)
#re

re:
ld ra,0(sp)
addi sp,sp,16
jr ra
