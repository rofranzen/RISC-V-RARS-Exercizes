# program does the following formula:
# 2 * 10 / 5 + (-4) = x

.data
.align 2
num1: .word 2
num2: .word 10
num3: .word 5
num4: .word -3
strn: .asciz ")\n"
strm: .asciz " * "
strd: .asciz " / "
strp: .asciz " + ("
.text
.globl main

main:
	# Loading words here only once will reduce time
	# by acessing less memoory
	lw t1, num1
	lw t2, num2
	lw t3, num3
	lw t4, num4
	
	j shownumbers
	
shownumbers:

	# Add must be used because
	# la = gets adress
	# lw = gets word from adress
	# li = loads immediate number not var
	add a0, t1, x0 # x0 = fixed 0
	li a7, 1
	ecall
	
	la a0, strm # Still needs to be la because its a string
	li a7, 4
	ecall
	
	add a0, t2, x0
	li a7, 1
	ecall
	
	la a0, strd
	li a7, 4
	ecall
	
	add a0, t3, x0
	li a7, 1
	ecall
	
	la a0, strp
	li a7, 4
	ecall
	
	add a0, t4, x0
	li a7, 1
	ecall
	
	la a0, strn
	li a7, 4
	ecall
	
	j count
	
count:

	mul t1, t1,t2
	div t1, t1, t3
	add a0, t1, t4 # doing a0 directly reduces memory cost
	li a7, 1
	ecall
	
	j end
	

end:	
	li a7, 10
	ecall
