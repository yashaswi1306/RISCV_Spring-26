.section .text

#struct node*make_node(int val)
.global make_node
make_node:
addi sp,sp,-16
sd s2,8(sp)
#make node has int val as argument do dtore that in s2.
sd ra,0(sp)
mv s2,a0 #store the input argument in s2
li a0,24
call malloc
#a0->(pointer to)node*newnode
li t0,0
sw s2,0(a0) #sice value is int so 4 bytes. rest are pointers: 8 bytes so use double word not word
sd t0,8(a0) #newnode->left=NULL;
sd t0,16(a0) #newnode->right=NULL;

ld ra,0(sp)
ld s2,8(sp)
addi sp,sp,16
ret



#struct node*insert(strut node*root,int val)
.global insert

insert:
addi sp,sp,-32
sd ra, 0(sp)
sd s4,16(sp) #int val
sd s2,8(sp) #node*root
mv s2,a0
mv s4,a1

#if(root==NULL)
#{root=createnode(root);}
li t0,0
beq t0,s2,create

lw t1,0(s2) #t0=root->val
beq t1,s4,ret1 #if(root->val==val)return;
bge s4,t1,i_right

i_left:
ld a0,8(s2) #a0=root->left;    
mv a1,s4
call insert
sd a0,8(s2)
j ret1

i_right:
ld a0,16(s2) #a0=root->right;    
mv a1,s4
call insert
sd a0,16(s2)
j ret1

#parent(0(s2))-> left(8(s2))->right(16(s2))

create:
mv a0,s4
call make_node
j ret2

ret1:
mv a0,s2
j ret2

ret2:
ld ra, 0(sp)
ld s4,16(sp) #int val
ld s2,8(sp) #node*root
addi sp,sp,32
ret

#struct node*get(struct node*root, int val)

.global get
get:
li t0,0
beq a0,t0,false #if (root==NULL)return;
lw t1,0(a0)
beq  a1,t1,true
bge a1,t1,right
#sice bst if val<root->val, go left, else right
left:
ld a0,8(a0)
j get

right:
ld a0,16(a0)
j get

true:
ret

#not found so return NULL
false:
li a0,0
ret

#int getAtMost(int val,struct Node*root)

.global getAtMost
getAtMost:
li a2,-1 #(if nt found, return -1)
l1:
li t0,0
beq a1,t0,ret3 #if (root==NULL) return;
lw t1,0(a1) #t1=root->val
ble t1,a0,greater #if val>=root->val
#else, u need smaller values so go left cuz it a bst
ld a1,8(a1)
j l1


greater:
ld a1,16(a1)
mv a2,t1
j l1

ret3:
mv a0,a2
ret

