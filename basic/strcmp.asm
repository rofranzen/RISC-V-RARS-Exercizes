.data
.align 2
input1: .space 100
input2: .space 100
.text
.globl main

main:
	
	li a7, 8
	la a0, input1
	li a1, 100 # max ammount of chars
	ecall
	
	li a7, 8
	la a0, input2
	li a1, 100 # max ammount of chars
	ecall
	
	la s1, input1
	la s2, input2
	
strcmp:
	
	lb t1, 0(s1) # needs to be lb, extracts char from adress
	lb t2, 0(s2)
	
	sub s0, t1, t2
	
	beq t1,x0, print # if the first ended
	beq t2,x0, print # or the second ended
	
	# Like this so that s0 can be reused on print 
	blt s0, x0, print # If char is lesser on first str
	bgt s0, x0, print # If bigger on first
	
	#adress++, char takes 1 byte
	addi s1, s1, 1
	addi s2, s2, 1
	
	j strcmp
	
print:
	
	addi a0, s0, 0
	li a7, 1
	ecall
	
end:
	
	li a7, 10
	ecall
