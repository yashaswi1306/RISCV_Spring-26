
.data
input: .string "%lld"
arr: .space 480
output: .string "%lld\n"

.text

.global main

main:
addi sp,sp,-80
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2, 24(sp)
sd s3, 32(sp)
sd s4, 40(sp)
sd s5,48(sp)
li s3,3

#input n in a0

la a0,input
addi a1,sp,56


call scanf

ld s2,56(sp)

#a2=n
la s0,arr
li s1,0

li s4,0

#a4 is sum
#so t1 is i and t0 has add of arr[0]

l1:

bge s1,s2,fin

slli t2,s1,3
add t3,s0,t2 
mv s5,t3
la a0,input
mv a1,s5
call scanf
ld a6,0(s5)
rem a5,a6,s3
addi s1,s1,1

beqz a5,add3
j l1

add3:
add s4,s4,a6
j l1


fin:

la a0,output
mv a1,s4
call printf
ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
ld s4,40(sp)
ld s5,48(sp)
addi sp,sp,80
ret
















