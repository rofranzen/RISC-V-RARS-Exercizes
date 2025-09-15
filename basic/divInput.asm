.data
.align 2
num1: .word 0
num2: .word 0
.text
.globl main

main:
	# reads num 1
	li a7, 5
	ecall
	
	# Now input is stored in a0
	
	la t1, num1 #loads adress of var
	sw a0, 0(t1) #store the input from a0 to t1 in offset 0
	lw t1, 0(t1) # loads word from the adress
	
	# reads num 2
	li a7, 5
	ecall
	
	la t2, num2
	sw a0, 0(t2)
	lw t2, 0(t2)
	
	div a0, t1,t2
	li a7, 1
	ecall
	
	li a7, 10
	ecall
