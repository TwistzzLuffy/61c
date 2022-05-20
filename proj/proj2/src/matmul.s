.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 59
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 59
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 59
# =======================================================
matmul:

	li t0,1
	blt a1,t0,call_exit
	blt a2,t0,call_exit
	blt a4,t0,call_exit
	blt a5,t0,call_exit
	bne a2,a4,call_exit
    # Error checks

	addi sp,sp,-44
	sw s0,0(sp)
	sw s1,4(sp)
	sw s2,8(sp)
	sw s3,12(sp)
	sw s4,16(sp)
	sw s5,20(sp)
	sw s6,24(sp)
	sw s7,28(sp)
	sw s8,32(sp)
	sw s9,36(sp)
	sw s10,40(sp)

    # Prologue

	mv s0,a0
	mv s1,a3
	mv s3,a1
	mv s5,x0
	mv s8,x0
outer_loop_start:
	beqz s3,outer_loop_end
	mv s2,a5
	mv s9,x0
	mv s10,x0

inner_loop_start:
	beqz s2,inner_loop_end

#save
	addi sp,sp,-32
	sw a0,0(sp)
	sw a1,4(sp)
	sw a2,8(sp)
	sw a3,12(sp)
	sw a4,16(sp)
	sw a5,20(sp)
	sw a6,24(sp)
	sw ra,28(sp)
	li a3,1
	mv a4,a5
	mv a1,s1
	#mv a0,s0
	jal ra,dot
	mv s7,a0
#recover
	lw a0,0(sp)
	lw a1,4(sp)
	lw a2,8(sp)
	lw a3,12(sp)
	lw a4,16(sp)
	lw a5,20(sp)
	lw a6,24(sp)	
	lw ra,28(sp)
	addi sp,sp,32
	add s6,a6,s8
	sw s7,0(s6)
	addi s5,s5,1
	slli s8,s5,2
	addi s10,s10,1
	slli s9,s10,2	
	addi s2,s2,-1
	add s1,a3,s9	
	j inner_loop_start

inner_loop_end:
	addi s3,s3,-1
	slli s2,a2,2	
	add a0,a0,s2
	add s1,a3,x0
	j outer_loop_start



outer_loop_end:
        lw s0,0(sp)
        lw s1,4(sp)
        lw s2,8(sp)
        lw s3,12(sp)
        lw s4,16(sp)
	lw s5,20(sp)
	lw s6,24(sp)
	lw s7,28(sp)
	lw s8,32(sp)
	lw s9,36(sp)
	lw s10,40(sp)
	addi sp,sp,44
    # Epilogue
	ret
call_exit:
	li a1,59
	call exit2
