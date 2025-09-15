.data
.align 2
input1: .space 100
input2: .space 100
cat: .space 200
.text
.globl main

main:
	
	li a7, 8
	la a0, input1
	li a1, 100 #max ammount of chars
	ecall
	
	li a7, 8
	la a0, input2
	li a1, 100 #max ammount of chars
	ecall
	
	la s0, input1
	la s1, input2
	la s2, cat
	
length_loop:
	
	# This will also count the \n, so careful.
	
	lb t0, 0(s0) # needs to be lb, extracts char from adress
	
	beq t0,x0, cat_start # is t0 = byte 0
	
	# Saves the start on cat
	sb t0,0(s2) 
	addi s2, s2, 1

	addi s0, s0, 1 #adress++, char takes 1 byte.
	
	j length_loop
	
cat_start:
	
	addi s2, s2, -2 # Goes back to the last digit before /n
	# because it will go back to /n on loop

cat_loop:
	
	li t1, 1 # Goes back to /n
	add s2,s2,t1 # Finishes that
	
	lb t0, 0(s1)# Reads first char of input2
	
	beq t0, x0, print # if equals 0 byte
	
	sb t0, 0(s2)
	
	addi s1,s1,1 # index++
	
	j cat_loop
	
	
print:
	
	addi s2,s2,-1
	sb x0, 0(s2)
	
	la a0, cat
	li a7, 4
	ecall
	
end:
	
	li a7, 10
	ecall
