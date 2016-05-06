#####################         VARUN13169        ###########################
###########################################################################
#
# 
# 1) It generate random number by implementing an algorithm and not by syscall.
# 2) Random number has STRICT constraint set, from 1 to 2^16-1(both inclusive)
# 3) My code works on MARS and QTspim, syscall 36,prints unsigned int, is only available in MARS and not in QTspim.
#
#
###########################################################################


.data
	size_input:  .asciiz "\nEnter N (the size of random arrays A and B) = "
	seed_input:  .asciiz "\nEnter the seed for random number = "
	arr1:        .asciiz "Array A: "
	arr2:        .asciiz "Array B: "
	comma:       .asciiz ";"
	mult_sign:   .asciiz "*"
	equalto:     .asciiz " = "
	newline:     .asciiz "\n"
	end:         .asciiz "\n\n<--- Kudos, Program has Ended --->"


.text
.globl main
main:   li $v0, 4
	la $a0, size_input
	syscall                     # print string
	
	li $v0, 5
	syscall                     # take input, size of array
	
	ble $v0, $zero, exit        # terminate if user gave size as zero -_-
	
	add $t0, $v0, $zero         # store it in t0
	addi $t1, $zero, 4          # store a constant 4 in t1
	mult $t0, $t1               # size required for array 4*t0
	
	##########################################################################
	mflo $a0                    # size tranfered in a0, low only
	li $v0, 9
	syscall                     # size allocated	
	add $s0, $v0, $zero         # saved the array 1 address
	add $t2, $s0, $zero         # temporary array 1 address
	
	mflo $a0                    # size tranfered in a0, low only
	li $v0, 9
	syscall                     # size allocated
	add $s1, $v0, $zero         # saved the array 2 address
	add $t3, $s1, $zero         # temporary array 2 address
	#########################################################################
	
	add $t1, $zero, $zero       # initialize loop counter t1=0
	#addi $a1, $zero, 65534      # setting range from 0 to 2^16-2
	
	
	#################### Input for seed ##########################
	li $v0, 4
	la $a0, seed_input
	syscall
	li $v0, 5
	syscall                     # take input, seed
	add $s2, $v0, $zero         # store it in s2
######### Genrate Random number and sore them in both arrays #########  
input:
	
	srl $s3, $s2, 15           # shift seed right 
	xor $s2, $s3, $s2          # xor it
	sll $s3, $s2, 17           # shift seed left
	xor $s2, $s3, $s2          # Xor it
	add $s4, $zero, $s2        # put seed in s4 to put a max. limit
	srl $s4, $s4, 16           # shift right by 16 to put a cap on 2^16-1
	bne $s4, $zero, notZero1   # will add 1 if s4 is 0, to make range from 1 to 2^16-1
	addi $s4, $s4, 1
notZero1:
	sw $s4, ($t2)              # store it in the memory, address in $t2
	
	srl $s3, $s2, 15           # shift seed right 
	xor $s2, $s3, $s2          # xor it
	sll $s3, $s2, 17           # shift seed left
	xor $s2, $s3, $s2          # xor it
	add $s4, $zero, $s2        # put seed in s4 to put a max. limit
	srl $s4, $s4, 16           # shift right by 16 to put a cap on 2^16-1
	bne $s4, $zero, notZero2   # will add 1 if s4 is 0, to make range from 1 to 2^16-1
	addi $s4, $s4, 1
notZero2:
	sw $s4, ($t3)              # store it in the memory, address in $t3
	
	addi $t1, $t1, 1           # increment the counter
	addi $t2, $t2, 4           # increment the address
	addi $t3, $t3, 4           # increment the address
	blt $t1, $t0, input
#####################################################################



########## Initialize for printing array 1 ##########
	add $t1, $zero, $zero
	add $t2, $s0, $zero
	li $v0, 4
	la $a0, arr1
	syscall                     # print string
#####################################################
output_arr1:
	li $v0, 1
	lw $t4, ($t2)
	add $a0, $zero, $t4
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall                     # print string
	
	addi $t1, $t1, 1           # increment the counter
	addi $t2, $t2, 4           # increment the address
	blt $t1, $t0, output_arr1

	li $v0, 4
	la $a0, newline
	syscall                    # print newline "\n"
	

########## Initialize for printing array 2 ##########
	add $t1, $zero, $zero
	add $t3, $s1, $zero
	li $v0, 4
	la $a0, arr2
	syscall                     # print string
#####################################################
output_arr2:
	li $v0, 1
	lw $t5, ($t3)
	add $a0, $zero, $t5
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall                     # print string
	
	addi $t1, $t1, 1           # increment the counter
	addi $t3, $t3, 4           # increment the address
	blt $t1, $t0, output_arr2
	
	li $v0, 4
	la $a0, newline
	syscall                    # print newline "\n"
	
	
	
	




######### Initialize for re-iterating both the arrays for multiplication ##########
	add $t1, $zero, $zero
	add $t2, $s0, $zero
	add $t3, $s1, $zero
###################################################################################
choose_element_mult:
	lw $t4, ($t2)                  
	
	lw $t5, ($t3)
	
	jal multiply
	
	li $v0, 1
	lw $t4, ($t2)
	add $a0, $zero, $t4         # print the operand 1
	syscall
	
	li $v0, 4
	la $a0, mult_sign
	syscall                     # print *
	
	li $v0, 1
	lw $t5, ($t3)
	add $a0, $zero, $t5         # print the operand 1
	syscall
	
	li $v0, 4
	la $a0, equalto
	syscall                     # print =
	
	li $v0, 36
	add $a0, $zero, $t6         # print unsigned integer
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall                    # print newline "\n"
	
	add $t6, $zero, $zero      # initialize $t6 again
	addi $t1, $t1, 1           # increment the counter
	addi $t2, $t2, 4           # increment the address
	addi $t3, $t3, 4           # increment the address
	blt $t1, $t0, choose_element_mult


exit:	
	li $v0, 4
	la $a0, end
	syscall                    # print newline "\n"
	li $v0, 10
	syscall                    # exit


multiply:
	addu $t6, $t6, $t4
	
	sub $t5, $t5, 1
	bne $t5, $zero, multiply
	
	jr $ra
