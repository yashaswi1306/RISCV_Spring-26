.global bits
bits:
addi sp,sp,-16
sd ra,0(sp)
mv a4,a0
mv a5,a1
li a2,0
li a3,0
# so a4 if arr[0], a5 is n, a3 is sum and a2 is index 

l1:
bge a2,a5,fin
slli a6,a2,3
add a6,a4,a6
ld a7,0(a6)
#since each byte is 8 bits
j addforeach

addforeach:
beqz a7, l2
andi a6,a7,1
add a3,a3,a6
srli a7,a7,1
j addforeach

l2:
addi a2,a2,1
j l1

fin:
mv a0,a3
ld ra,0(sp)
addi sp,sp,16
jr ra
