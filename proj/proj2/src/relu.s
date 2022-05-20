.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# ==============================================================================
relu:
    # Prologue
	addi sp,sp,-28
	sw a0,0(sp)
	sw a1,4(sp)
	sw t0,8(sp)
	sw t1,12(sp)
	sw ra,16(sp)
	sw s0,20(sp)
	sw s1,24(sp)

	bnez a0,loop_start
	li a1,57
	call exit2
loop_start:
	mv t0,x0
	mv t1,a1
	mv s1,a0

loop_continue:
	beqz t1,loop_end
	slli s0,t0,2
	add a0,s1,s0	
	jal ra,abs
	addi t1,t1,-1
	addi t0,t0,1
	j loop_continue 

loop_end:
	
    # Epilogue
	lw a0,0(sp)
	lw a1,4(sp)	
	lw t0,8(sp)
	lw t1,12(sp)
	lw ra,16(sp)	
	lw s0,20(sp)
	lw s1,24(sp)
	addi sp,sp,28
	jr ra
abs:
	addi sp,sp,-8
	sw s0,0(sp)
	sw s1,4(sp)
	lw s0,0(a0)
	bge s0,x0,done
	add s0,x0,x0
done:
	sw s0,0(a0)
	lw s0,0(sp)
	lw s1,4(sp)
        addi sp,sp,8
	jr ra
