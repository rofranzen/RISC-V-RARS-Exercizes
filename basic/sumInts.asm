.data
.align 2
str1: .asciz "The result is "
num1: .word 1
num2: .word 43
.text
.globl main

main:
	j printstr1
	j adiciona
	
	j end

printstr1:
	la a0, str1
	li a7, 4
	ecall
	
adiciona:
	la t0, num1
	lw t0, 0(t0)
	
	la t2, num2
	lw t2, 0(t2)
	
	add t1, t0,t2
	
	addi a0, t1, 0
	li a7, 1
	ecall

end:
	li a7,10 #ends program
	ecall