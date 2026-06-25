.data
input: .string "%s"
str: .space 10009
output: .string "%d\n"

.text
.global main
main:
addi sp,sp,-16
sd ra,0(sp)
la a0,input
la a1,str
call scanf

la a2,str
la a3,str

li a7,1
#a7 is flag
l1:

lbu a5,0(a2)
beqz a5,next
addi a2,a2,1
j l1

next:
addi a2,a2,-1
#now a2 is last char
#a3 is the first char

l2:
blt a2,a3,fin
lbu a5,0(a2)
lbu a6,0(a3)
bne a5,a6,flag
addi a2,a2,-1
addi a3,a3,1
j l2


flag:
addi a7,a7,-1
j fin

fin:
la a0,output
mv a1,a7
call printf
ld ra,0(sp)
addi sp,sp,16
ret











