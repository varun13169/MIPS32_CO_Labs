############################### Varun13169 ##################################

.data
	size_input:  .asciiz "\nEnter the size of Array  "
	num_input:   .asciiz "\nElements of Array\n"
	mini:        .asciiz "\nMinimum= "
	maxi:        .asciiz "\nMaximum= "
	summation:   .asciiz "\nSum= "
	


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
	
	mflo $a0                    # size tranfered in a0, low only
	li $v0, 9
	syscall                     # size allocated
	
	add $t5, $v0, $zero         # saved the array address
	add $t6, $v0, $zero
	
	addi $t1, $zero, 1          # initialize loop counter t1=1
	add $t2, $zero, $zero       # initialized for sum
	
	li $v0, 4
	la $a0, num_input
	syscall
	
	################ First input to initialize t3 and t4 #################
	li $v0, 5
	syscall                    # takes the input
	sw $v0, ($t6)              # store it in the memory, address in $t6
	
	add $t2, $t2, $v0          # computes the sum
	
	add $t3, $zero, $v0        # initialized to ckeck maximum
	add $t4, $zero, $v0        # initialized to ckeck minimum
	
	addi $t1, $t1, 1           # increment the counter
	addi $t6, $t6, 4           # increment the address
	######################################################################
	
	bge $t1, $t0, one_input_only    # ends here if user gave size as one

input:
	li $v0, 5
	syscall                    # takes the input
	sw $v0, ($t6)              # store it in the memory, address in $t6
	
	add $t2, $t2, $v0          # computes the sum
	
	ble $v0, $t3, max          # skip swaping if vo<=t3
	add $t3, $zero, $v0	   # change t3 to v0
	
max:    
	ble $t4, $v0, min
	add $t4, $zero, $v0	   # change t4 to v0

min:
	addi $t1, $t1, 1           # increment the counter
	addi $t6, $t6, 4           # increment the address
	ble $t1, $t0, input


one_input_only:	
	li $v0, 4
	la $a0, mini
	syscall
	
	li $v0, 1                    # prints minimum value
	add $a0, $zero, $t4
	syscall
	
	li $v0, 4
	la $a0, maxi
	syscall
	
	li $v0, 1                    # prints maximum value
	add $a0, $zero, $t3
	syscall
	
	
	li $v0, 4
	la $a0, summation
	syscall
	
	li $v0, 1                    # prints the summation
	add $a0, $zero, $t2
	syscall


exit:	
	li $v0, 10
	syscall                      # exit

