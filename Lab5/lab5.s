.data
	size_input:  .asciiz "\nEnter size (N) of the matrix = "
	each_input:  .asciiz "\nEnter the A("
	matrixA:     .asciiz "Martix A:\n"
	matrixAT:    .asciiz "\nMatrix A Transpose:\n"
	comma:       .asciiz ";"
	equal_to:       .asciiz ") = "
	is_symmetric:   .asciiz "\nMatrix is Symmetric \n"
	not_symmetric:     .asciiz "\nMatrix is not Symmetric \n"
	is_skew_symmetric:   .asciiz "\nMatrix is Skew Symmetric \n"
	not_skew_symmetric:     .asciiz "\nMatrix is not Skew Symmetric \n"
	det:     .asciiz "\nDeterminent of Matrix is = "
	newline:     .asciiz "\n"
	end:         .asciiz "\n\n<--- Kudos, Program has Ended --->"

## 2013169 Varun Kumar

.text
.globl main

main:   li $v0, 4
	la $a0, size_input
	syscall                     # print string
	
	li $v0, 5
	syscall                     # take input, size of matrix A
	
	ble $v0, $zero, exit        # terminate if user gave size as zero -_-
	
	add $t0, $v0, $zero         # store it in t0
	add $s0, $v0, $zero         # store it in s0
	
	addi $t1, $zero, 4          # store a constant 4 in t1
	mult $t0, $t0               # to calc total number of elements
	mflo $t0
	mult $t0, $t1               # size required for array 4*(t0*t0)
	mflo $a0
	
	li $v0, 9
	syscall                     # size allocated
	add $t1, $v0, $zero         # saved the address for matrix A
	add $t4, $v0, $zero
			
	li $v0, 9
	syscall                     # size allocated
	add $t2, $v0, $zero         # saved the address for transpose of matrix A
	add $t5, $v0, $zero
	
	
	
	
	
	addi $s4, $zero, 4
	add $t7, $zero, $zero       # initialize loop counter t7=0
	add $t6, $zero, $zero       # initialize loop counter t7=0
######### Input from the user for Martix A #########  
loop_out_A:
loop_in_A:
	li $v0, 4
	la $a0, each_input
	syscall
	li $v0, 1
	add $a0, $zero, $t7
	syscall
	li $v0, 4
	la $a0, comma
	syscall                     # print comma
	li $v0, 1
	add $a0, $zero, $t6
	syscall
	li $v0, 4
	la $a0, equal_to
	syscall                     # print equal_to
	
	
	li $v0, 5
	syscall
	sw $v0 ($t4)
	
	addi $t4, $t4, 4           # increment the address
	addi $t6, $t6, 1           # increment the inner loop
	blt $t6, $s0, loop_in_A
	
	li $v0, 4
	la $a0, newline
	syscall                     # print equal_to
	
	add $t6, $zero, $zero
	addi $t7, $t7, 1           # increment the outer loop
	blt $t7, $s0, loop_out_A
#####################################################################

	
	
	add $t7, $zero, $zero       # initialize loop counter t7=0
	add $t6, $zero, $zero       # initialize loop counter t6=0
	#add $t4, $t1, $zero
######### Taking Transpose of Martix A #########  
loop_out_AT:
loop_in_AT:
	mult $t6, $s0                          # Inner loop count * N
	mflo $t4
	add $t4, $t4, $t7                      # Adding it to outer loop count
	                                       # j+ i*3
	
	mult $t4, $s4                          # Calc. offset by mult. index by 4
	mflo $t4
	add $t4, $t4, $t1                      # adding offset to the base address
	
	lw $s1, ($t4)                          # load t4's element in s1
	sw $s1 ($t5)                           # store s1 in t5
	                                       # ($t5) = ($t4)
	
	addi $t5, $t5, 4           # increment the address
	addi $t6, $t6, 1           # increment the inner loop
	blt $t6, $s0, loop_in_AT
	
	add $t6, $zero, $zero
	addi $t7, $t7, 1           # increment the outer loop
	blt $t7, $s0, loop_out_AT
#####################################################################



	li $v0, 4
	la $a0, matrixA
	syscall                     # print matrixA
	
	add $t7, $zero, $zero       # initialize loop counter t7=0
	add $t6, $zero, $zero       # initialize loop counter t7=0
	add $t4, $t1, $zero
######### Printing Martix A #########  
loop_out_pA:
loop_in_pA:
	li $v0, 1
	lw $a0, ($t4)
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall                     # print comma
	
	addi $t4, $t4, 4           # increment the address
	addi $t6, $t6, 1           # increment the inner loop
	blt $t6, $s0, loop_in_pA
	
	li $v0, 4
	la $a0, newline
	syscall                    # print newline "\n"
	
	add $t6, $zero, $zero
	addi $t7, $t7, 1           # increment the outer loop
	blt $t7, $s0, loop_out_pA
#####################################################################


	li $v0, 4
	la $a0, matrixAT
	syscall                     # print matrixAT
	
	add $t7, $zero, $zero       # initialize loop counter t7=0
	add $t6, $zero, $zero       # initialize loop counter t7=0
	add $t5, $t2, $zero
######### Printing Martix AT #########  
loop_out_pAT:
loop_in_pAT:
	li $v0, 1
	lw $a0, ($t5)
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall                     # print comma
	
	addi $t5, $t5, 4           # increment the address
	addi $t6, $t6, 1           # increment the inner loop
	blt $t6, $s0, loop_in_pAT
	
	li $v0, 4
	la $a0, newline
	syscall                    # print newline "\n"
	
	add $t6, $zero, $zero
	addi $t7, $t7, 1           # increment the outer loop
	blt $t7, $s0, loop_out_pAT
#####################################################################





#
#
#
# Can be used s5,s6,s7,t8,t9,t7,t6

	addi $s5, $zero, 2 # for equating in branch instruction 
	bne $s0, $s5, det2
	lw $s5, 0($t1)    # as s5 not req now
	lw $s6, 4($t1)
	lw $t8, 8($t1)
	lw $t9, 12($t1)
	mult $s5, $t9
	mflo $t6
	mult $s6, $t8
	mflo $t7
	sub $t7, $t6, $t7
	
	li $v0, 4
	la $a0, det
	syscall                     # print det is
	li $v0, 1
	add $a0, $t7, $zero
	syscall
	li $v0, 4
	la $a0, newline
	syscall                     # print det is	
	
det2:

	add $a0, $zero, $zero # for ultimate sum
	addi $s5, $zero, 3    # For equating in branch instruction
	bne $s0, $s5, det3
	
	lw $s5, 16($t1)    # as s5 not req now
	lw $s6, 20($t1) #
	lw $t8, 28($t1) #
	lw $t9, 32($t1) #
	
	mult $s5, $t9
	mflo $t6
	mult $s6, $t8
	mflo $t7
	sub $t7, $t6, $t7
	
	lw $s5, 0($t1) #
	mult $t7, $s5
	mflo $t7
	add $a0, $a0, $t7
	#
	#
	lw $s5, 12($t1) #
	lw $s6, 20($t1) #
	lw $t8, 24($t1) #
	lw $t9, 32($t1) #
	
	mult $s5, $t9
	mflo $t6
	mult $s6, $t8
	mflo $t7
	sub $t7, $t6, $t7
	
	lw $s5, 4($t1) #
	mult $t7, $s5
	mflo $t7
	sub $a0, $a0, $t7 # SUB not ADD
	#
	#
	lw $s5, 12($t1) #
	lw $s6, 16($t1) #
	lw $t8, 24($t1) #
	lw $t9, 28($t1) #
	
	mult $s5, $t9
	mflo $t6
	mult $s6, $t8
	mflo $t7
	sub $t7, $t6, $t7
	
	lw $s5, 8($t1) #
	mult $t7, $s5
	mflo $t7
	add $a0, $a0, $t7 #	
	#
	#
	
	add $t7, $zero, $a0 # just for the sake of shifting as a0 will be used for string address
	li $v0, 4
	la $a0, det
	syscall                     # print det is
	li $v0, 1
	add $a0, $t7, $zero
	syscall
	li $v0, 4
	la $a0, newline
	syscall                     # print det is	
det3:
	
#
#
#
#


	
	add $t7, $zero, $zero       # initialize loop counter t7=0
	add $t6, $zero, $zero       # initialize loop counter t7=0
	add $t4, $t1, $zero
	add $t5, $t2, $zero
######### Symmetric test #########  
loop_out_s:
loop_in_s:
	lw $s1, ($t4)
	lw $s2 ($t5)
	
	beq $s1, $s2, symmetric   
	j non_symmetric                  # if operand1 =/= operand2 then 
	
symmetric:
	
	addi $t4, $t4, 4           # increment the address
	addi $t5, $t5, 4           # increment the address
	
	addi $t6, $t6, 1           # increment the inner loop
	blt $t6, $s0, loop_in_s
	
	add $t6, $zero, $zero
	addi $t7, $t7, 1           # increment the outer loop
	blt $t7, $s0, loop_out_s
#####################################################################
	li $v0, 4
	la $a0, is_symmetric
	syscall                    # print newline "\n"





skew_symmetric_test:

	add $t7, $zero, $zero       # initialize loop counter t7=0
	add $t6, $zero, $zero       # initialize loop counter t7=0
	add $t4, $t1, $zero
	add $t5, $t2, $zero
	addi $s7, $zero, -1         # for skew test
######### Skew Symmetric Test #########  
loop_out_ss:
loop_in_ss:
	lw $s1, ($t4)
	lw $s2 ($t5)
	
	mult $s2, $s7   # making one operand negative
	mflo $s2
	
	beq $s1, $s2, skew_symmetric
	#addi $s7, $s7, 1      
	j non_skew_symmetric    # if operand1 =/= -operand2 then 
	
skew_symmetric:
	
	addi $t4, $t4, 4           # increment the address
	addi $t5, $t5, 4           # increment the address
	
	addi $t6, $t6, 1           # increment the inner loop
	blt $t6, $s0, loop_in_ss
	
	add $t6, $zero, $zero
	addi $t7, $t7, 1           # increment the outer loop
	blt $t7, $s0, loop_out_ss
#####################################################################
	li $v0, 4
	la $a0, is_skew_symmetric
	syscall                    # print 

exit:	
	li $v0, 10
	syscall                      # exit







non_symmetric:
	li $v0, 4
	la $a0, not_symmetric
	syscall                    # print 
	j skew_symmetric_test

non_skew_symmetric:
	li $v0, 4
	la $a0, not_skew_symmetric
	syscall                    # print 
	j exit
		
