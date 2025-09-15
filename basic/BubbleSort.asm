.data
.align 2

array: .word 8, 4, 2, 5, 8, 9, 1
max: .word 7
.text
.globl main

main:
	
	# Gets the main variables so it doesn't have to keep acessing memory
	
	la s1, array
	lw s2, max
	
	#max - 1
	li t0, 1
	sub s3, s2, t0
	
	# int = 4 bytes
	li s4, 4

	# int i = 0
	li s0, 0

outer_loop:
	
	# If i < max-1, with i starting at 0
	bge s0, s3, end_loop
	
	li s5, 0 # j = 0
	
	j inner_loop

add_i_count:
	
	# Only happens at the end of an loop
	addi s0, s0, 1
	
	j outer_loop

inner_loop:

	# j < max-1-i
	sub t0, s3, s0
	bge s5, t0, add_i_count
	
	
	addi t0, s5, 0 # Index of what we want
	mul t0, t0, s4 # Multiplies by offset
	
	add t0, s1, t0 # Finds the adress by base + offset
	lw t1, 0(t0)
	
	add t3, t0, s4 # Adds offset to go to next one
	lw t2, 0(t3)
	
	# if this larger than that
	bgt t1, t2, inicio_se
	
	# auto goes to add_j_cont

add_j_cont:
	
	addi s5, s5, 1
	
	j inner_loop

inicio_se:

	# sw value, offset(adress dest)
	sw t1, 0(t3)
	sw t2, 0(t0)
	
	j add_j_cont

end_loop:

	# First word of array, probably will be simpler to access
	add t0, x0, s1
	
	# i = 0, since it will start by adding
	li s0, -1

print_array:
	
	#i++
	addi s0, s0, 1
	
	# i < max
	bge s0, s2, end
	
	lw a0, 0(t0)
	add t0, t0, s4
	
	li a7, 1
	ecall
	
	j print_array
					
end:
	
	li a7, 10
	ecall
	