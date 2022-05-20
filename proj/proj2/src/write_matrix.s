.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
# - If you receive an fopen error or eof,
#   this function terminates the program with error code 89
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 90
# - If you receive an fwrite error or eof,
#   this function terminates the program with error code 92
# ==============================================================================
write_matrix:
	#Prologue	
	addi sp,sp,-32	
	sw s0,0(sp)
	sw s1,4(sp)
	sw s2,8(sp)
	sw s3,12(sp)
	sw s4,16(sp)
	sw s5,20(sp)
	sw s6,24(sp)
	sw ra,28(sp)
	
	mv s0,a0
	mv s1,a1	
	mv s3,a2
	mv s4,a3

	#fopne	
	mv a1,s0	
	li a2,1
	jal fopen
	blt a0,x0,call_exit0
	mv s2,a0
	
	#fwrite to rows
	addi sp,sp,-4
	sw s3,0(sp)
	mv a1,s2
	mv a2,sp
	li a3,1
	li a4,4
	jal fwrite
	blt a0,x0,call_exit1
	
	#fwrite to columns
	sw s4,0(sp)
	mv a1,s2
	mv a2,sp
	li a3,1
	li a4,4
	jal fwrite 
	blt a0,x0,call_exit1
	addi sp,sp,4

	li s5,0
	mul s6,s3,s4

loop_start:
	slli t0,s5,2
	add t0,s1,t0
	mv a1,s2
	mv a2,t0
	mv a3,s6	
	li a4,4
	jal fwrite
 	blt a0,x0,call_exit1	
	add s5,s5,a0	
	bne s5,s6,loop_start

	#fclose
	mv a1,s2
	jal fclose
	blt a0,x0,call_exit2

	#Epilogue
	lw s0,0(sp)
        lw s1,4(sp)
        lw s2,8(sp)
        lw s3,12(sp)
        lw s4,16(sp)
        lw s5,20(sp)
        lw s6,24(sp)
        lw ra,28(sp)
	addi sp,sp,32
	
	ret


call_exit0:
	li a1,89
	call exit2	

call_exit1:
	li a1,92
	call exit2

call_exit2:
	li a1,90
	call exit2



