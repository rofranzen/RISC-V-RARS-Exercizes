.data
.align 2
num1: .word 6
num2: .word 5
.text
.globl main

main:
	
	lw t1, num1 # load word from adress
	lw t2, num2
	div a0, t1, t2 # not to t0 because t0 is already a word
	
	# original error:
	# lw a0, t0
	# but t0 is not an adress, it's a word.
	# You can't load a word from a word.
	li a7, 1
	ecall
	
	li a7, 10
	ecall