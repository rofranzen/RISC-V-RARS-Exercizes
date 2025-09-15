.data
.align 2

num1: .word 0

str: .asciz "\nThis number is "
pos: .asciz "positive."
negt: .asciz "negative."
zer: .asciz "zero."


.text
.globl main

main:

	li a7, 5
	ecall
	
	# The input is now stored in a0
	
	la t1, num1 # Loads adress to store it in
	sw a0, 0(t1) # Saves the input in t1's adress
	lw t0, 0(t1) # Loads value from adress
	
	#Prints the start of the phrase since it's unchanged
	
	la a0, str
	li a7, 4
	ecall
	
	blt t0, x0, isneg
	bgt t0, x0, ispos
	
	# Jumping to label is uneeded and increases complexity
	# zero output is described below
	
	# Is zero?
	
	la a0, zer
	
	j printandend
	
ispos:
	la a0, pos
	
	j printandend

isneg:
	la a0, negt
	
	j printandend
	
printandend:

	li a7,4
	ecall
	
	j end

end:

	li a7, 10
	ecall
	
	