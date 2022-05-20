.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
# - If malloc returns an error,
#   this function terminates the program with error code 88
# - If you receive an fopen error or eof,
#   this function terminates the program with error code 89
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 90
# - If you receive an fread error or eof,
#   this function terminates the program with error code 91
# ==============================================================================
read_matrix:
#	# Prologue
	addi sp,sp,-36
	sw s0,0(sp)
	sw s1,4(sp)
	sw s2,8(sp)
	sw s3,12(sp)
	sw s4,16(sp)
	sw s5,20(sp)
	sw ra,24(sp)  
	sw s6,28(sp)
	sw s7,32(sp)

	mv s0,a0
	li s1,-1   
	mv s3,a1
	mv s4,a2

	#fopen
	mv a1,s0
	li a2,0
	jal ra,fopen
	beq a0,s1,call_exit0
	mv s2,a0

	#fread of rows
	mv a1,s2
	mv a2,s3
	li a3,4
	jal fread
	blt a0,x0,call_exit1
	
	#fread of columns
	mv a1,s2
	mv a2,s4
	li a3,4
	jal fread
	blt a0,x0,call_exit1

	#malloc matrix
	lw t0,0(s3)
	lw t1,0(s4)
	mul t0,t1,t0	
	slli t0,t0,2
	mv a0,t0
	addi sp,sp,-4
	sw t0,0(sp)
	jal malloc
	lw t0,0(sp)
	addi sp,sp,4
	beq a0,x0,call_exit2
	mv s5,a0
	
	mv s7,t0
	li s6,0
	#read matrix
loop_start:
	mv a1,s2	
	mv a2,s5
	add a2,a2,s6
	mv a3,s7
	jal fread
	add s6,a0,s6
	blt s6,s7,loop_start
loop_end:
	mv a1,s2
	jal fclose
	blt a0,x0,call_exit3
	mv t0,s5

	# Epilogue
	lw s0,0(sp)
	lw s1,4(sp)
	lw s2,8(sp)
	lw s3,12(sp)
	lw s4,16(sp)
	lw s5,20(sp)
	lw ra,24(sp)
	lw s6,28(sp)
	lw s7,32(sp)
	addi sp,sp,36
	
	mv a0,t0
	ret

	call_exit0:
	li a1,89
	call exit2
	
	call_exit1:
	li a1,91
	call exit2
	
	call_exit2:
	li a1,88
	call exit2

	call_exit3:
	li a1,90
	call exit2
