.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 58
# =======================================================
dot:

    # Prologue
	li t6,1
	blt a2,t6,exit_call1
	blt a4,t6,exit_call2
	blt a3,t6,exit_call2
	mv t5,x0
loop_start:
	beqz a2,loop_end
	lw t0,0(a0)
	lw t1,0(a1)
	slli t2,a3,2
	slli t3,a4,2
	mul t4,t0,t1
	add t5,t5,t4
	add a0,a0,t2
	add a1,a1,t3
	addi a2,a2,-1
	j loop_start

exit_call1:
	li a1,57
	call exit2
exit_call2:
	li a1,58
	call exit2

loop_end:
	mv a0,t5

    # Epilogue


    ret
