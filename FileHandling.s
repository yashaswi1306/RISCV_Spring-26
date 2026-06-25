.section .data
yes:.string "Yes\n"
no:.string "No\n"
txtfile:.string "input.txt"
read_r: .string "r"

.section .text
.global main


main:
addi sp,sp,-32
sd ra,0(sp)
sd s2,24(sp)
#index i
sd s3,16(sp)
#len
sd s4,8(sp)
#file

la a0,txtfile # a0=input.txt
la a1,read_r # a1=r
call fopen #fopen(a0,a1)
mv s4,a0 #f=fopen(a0,a1), so f stored in s4

mv a0,s4
li a1,0 # file end + offset jab krenge toh offset will be 0
li a2,2 #end of file is used with 2, 0 for beginning and 1 for current
call fseek #seeks fileend
mv a0,s4   

call ftell
mv s3,a0 #so s3 shws file_len. Cursor at end, s3 with len
addi t0,s3,-1
mv a0,s4
mv a1,t0
li a2,0
call fseek

mv a0,s4
call fgetc
li t1,10
bne t1,a0,start

addi s3,s3,-1
start:

mv a0,s4
li a2,0
li a1,0
call fseek

li s2,0
li t2,1
ble s3,t2,true

l1:
srli t2,s3,1 #t2=s3/2
blt t2,s2,true  #while(l<r)

mv a0,s4
mv a1,s2 #offset
li a2,0 #seek from beginning oif file
call fseek 
mv a0,s4
call fgetc 
mv t0,a0 #t0=char at idx I from beginning

#repeat for char from end
mv a0,s4 
addi t1,s2,1
addi s2,s2,1
neg t1,t1 
mv a1,t1 #offset= -(i+1) 
li a2,2    
call fseek #so fseek gest end of file – (i+1)

mv a0,s4        
call fgetc     

mv t1,a0    

bne t1,t0,false 
j l1

true:
la a0,yes
call printf 
j done             
false:
la a0,no    
call printf
j done

    
done:

ld s2,24(sp)    
ld s3,16(sp)
ld ra,0(sp)       
ld s4,8(sp)       
addi sp,sp,32     
ret                 
