.data
.align 2
input: .space 100
inv: .space 100
.text
.globl main

main:
	
	li a7,8
	la a0, input
	li a1, 100 #max ammount of chars
	ecall
	
	la s0, input
	la s1, inv
	
length_loop:
	
	# This will also count the \n, so careful.
	
	lb t0, 0(s0) # needs to be lb, extracts char from adress
	
	beq t0,x0, reverse_start # is t0 = byte 0
	
	addi s0, s0, 1 #adress++, char takes 1 byte.
	
	j length_loop
	
reverse_start:
	
	addi s0, s0, -1 #takes out the /0

reverse_loop:

	
	li t1, 1 #the first will take out the /n
	sub s0,s0,t1
	
	lb t0, 0(s0)# Reads last character that is not \n or \0
	
	ble t0, x0, print # less or equal important
	
	sb t0, 0(s1)
	
	addi s1,s1,1 # index++
	
	j reverse_loop
	
	
print:
	
	la a0, inv
	li a7, 4
	ecall
	
end:
	
	li a7, 10
	ecall