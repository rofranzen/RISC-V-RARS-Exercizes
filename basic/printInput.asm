.data
.align 2
prompt: .asciz "Enter a string: "
input: .space 100
.text
.globl main

main:
	la a0, prompt
	li a7, 4
	ecall
	
	j inputstr
	j printinput
	
	j end


inputstr:
	li a7, 8
	la a0, input
	li a1, 100 #max ammount of chars
	ecall

printinput:
	li a7, 4
	la a0, input
	ecall

end:
	li a7, 10
	ecall