.data
.align 2
input1: .space 100
cpy: .space 100
.text
.globl main

main:
	
	li a7, 8
	la a0, input1
	li a1, 100 # max ammount of chars
	ecall
	
	la s0, input1
	la s1, cpy
	
strcpy:
	
	# This will also copy the \n, so careful.
	
	lb t0, 0(s0) # needs to be lb, extracts char from adress
	
	beq t0,x0, print # is t0 = byte 0
	
	# Saves char on cpy
	sb t0,0(s1) 
	addi s1, s1, 1

	addi s0, s0, 1 #adress++, char takes 1 byte.
	
	j strcpy
	

print:
	
	la a0, cpy
	li a7, 4
	ecall
	
end:
	
	li a7, 10
	ecall
