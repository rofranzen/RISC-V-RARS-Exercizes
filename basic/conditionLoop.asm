.data
.align 2

num1: .word 0

prompt: .asciz "This program will tell you if a number is pos or neg. Press 0 to exit."

str: .asciz "This number is "
pos: .asciz "positive.\n"
negt: .asciz "negative.\n"

.text
.globl main

main:

	la a0, prompt
	li a7, 4
	ecall
	
	# int i setting not needed for this one
	
	j inner_loop
	
inner_loop:
	
	# Read number
	li a7, 5
	ecall
	
	# The input is now stored in a0
	
	
	la t1, num1 # Loads adress to store it in
	sw a0, 0(t1) # Saves the input in t1's adress
	lw t3, 0(t1) # Loads value from adress
	
	beq t3, x0, end #ends if a0 = 0
	
	j inst
	
inst:

	#Prints the start of the phrase since it's unchanged
	
	la a0, str
	li a7, 4
	ecall
	
	blt t3, x0, isneg
	bgt t3, x0, ispos
	
	j end
	
ispos:
	la a0, pos
	
	j printandend

isneg:
	la a0, negt
	
	j printandend
	
printandend:

	li a7,4
	ecall
	
	j inner_loop

end:

	li a7, 10
	ecall
	
	