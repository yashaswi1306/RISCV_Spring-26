.section .data
newline:.string "\n"       
int:.string "%d"
int_last: .string "%d\n"    
space: .string " "

.section .text

.global main

main:
addi sp,sp,-48
sd s4,0(sp) #stack(min stack like dsa) 
sd s3,8(sp)   #arr
sd s2,16(sp)     #number of elements in array
sd s1,24(sp)  #final
sd ra,40(sp) #ret
sd s0,32(sp)  #stack top
addi s2,a0,-1  #s2=n -1 (cuz the ./a.out is also in total)
addi sp,sp,-8 #malloc shldnt be called before storing the pointer to argv

sd a1,0(sp) 
###to make space for array

slli a0,s2,3 #t1=8*n
call malloc  
mv s3,a0     
###to make space for min stack

slli a0,s2,3
call malloc            
mv s4,a0          

###to make space for ans

 slli a0,s2,3 
call malloc        
mv s1,a0

li s0,-1 #(cuz final for last will be -1.)

ld a1,0(sp)    
addi sp,sp,8  
#got argv from stack

li t0,0
l1:
bge t0,s2,l2 #while(i<n)

addi t1,t0,1  #t1=i+1
slli t1,t1,3 #cuz 8 bytes per int
add t1,a1,t1 #t1=&argv[proper index]   
ld a0,0(t1)

#program name shld be saved which is arg[0]
addi sp,sp,-16
sd a1,8(sp) 
sd t0,0(sp) 
call atoi               
ld a1,8(sp) 
ld t0,0(sp)            
addi sp,sp,16

slli t1,t0,3  #t1=8*i
addi t0,t0,1     
add t1,s3,t1   #pointer to new element of array
sd a0,0(t1)    #store that 

j l1
l2:
li t0,0
minus:
#makes evrything -1
bge t0,s2,nxt1
slli t1,t0,3
li t2,-1
add t1,s1,t1
addi t0,t0,1
sd t2,0(t1)
j minus

nxt1:
addi t0,s2,-1  #i= n-1 to 0
l3_logic:
li t6,0
blt t0,t6,done #i<0
slli t1,t0,3  #t1=i*8
add t1,s3,t1  #t1=&arr[i]
ld t2,0(t1)    #t2=arr[i]
#if stack[top]<arr[i], pop from stack
pop:
blt s0,t6,l4 #pop till stack empty

slli t3,s0,3  #t3=top*8
add t3,s4,t3 #t3=&stack[top]
ld t4,0(t3) #t4=stack[top] 
#that is index of arr
slli t5,t4,3   #t5=stack[top]*8 (cuz if idx =1, value t s3+8)
add t5,s3,t5 
ld t5,0(t5) #t5=arr[stack[top]] 

bgt t5,t2,l4 #arr[stk[top]] <= arr[i], continue;
addi s0,s0,-1  #top--;
j pop


l4:
blt s0,t6,l5
slli t4,s0,3
add t4,s4,t4
ld t4,0(t4) #t4=stack[top]
slli t3,t0,3  #t3=i*8
add t3,s1,t3  #t3=&final[i]
sd t4,0(t3)   #final[i]=stack[top]
j l5

   

l5:
addi s0,s0,1  #top++ 
slli t3,s0,3
add t3,s4,t3
sd t0,0(t3)   #stack[top]=i 

addi t0,t0,-1 #i--
j l3_logic

done:
li t6,0
loop:
bge t6,s2,nxt #while(i<n)
slli t1,t6,3   #t1=8*i
add t1,s1,t1  #t1=&final[i]
ld t1,0(t1) #t1=final[i]

#store i and final[i] 
addi sp,sp,-16
sd t6,8(sp)
sd t1,0(sp)  

bltz t1,print_neg
ld a1,0(sp)
j print_val

print_neg:
li a1,-1

print_val:
la a0,int
call printf

addi t2,s2,-1
beq t6,t2,no_space

la a0,space
call printf

no_space:
ld t6,8(sp)
addi sp,sp,16
addi t6,t6,1
j loop



one:
la a0,int
li a1,-1
call printf
j ret1

last:
bltz t1,one_last
la a0,int_last #%d
ld a1,0(sp)  #t2=final[i]
call printf
j ret1

one_last:
la a0,int_last
li a1,-1
call printf
j ret1

ret1:
ld t6,8(sp)  #t0=i
addi sp,sp,16
addi t6,t6,1 #i++


nxt:
la a0,newline          
call printf

ld s4,0(sp)
ld s3,8(sp)          
ld s2,16(sp)
ld s1,24(sp)          
ld s0,32(sp)           
ld ra,40(sp)           
addi sp,sp,48       
ret          

