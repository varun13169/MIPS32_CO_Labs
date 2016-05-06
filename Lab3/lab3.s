############# Varun13169 ##################

.data
	Input:  .asciiz "\nEnter N "
	Output_Iterative:  .asciiz "\nNth term computed iteratively   "
	iterartive_stack:  .asciiz "\nMaximum Stack size = "
	Output_Recursive:  .asciiz "\nNth term computed recursively   "
	recursive_stack:  .asciiz "\nMaximum Stack size = "
	wrong_input:      .asciiz "\n Enter correct input"
	end:         .asciiz "\n\n<--- Kudos, Program has Ended --->"


.text
.globl main
main:   addi $t0, $zero, 2
	
	li $v0, 4
	la $a0, Input
	syscall                  # Prints the input line                
	
	li $v0, 5
	syscall                   
	add $t1, $v0, $zero        # Takes the input and store it in t1
	
	ble $t1, $zero, input      # branch if input is less than zero; for the loop
good_input:
	addi $t2, $zero, 0         # Initialization
	addi $t3, $zero, 1
	
	
	addi $t7,$zero, 2     
	sub $t4, $t1, $t3
	ble $t1, $t7, direct_answer
	
	
fib_iterative:
	add $t4, $t2,$t3
	add $t2, $t3, $zero
	add $t3, $t4, $zero
	
	
	addi $t0, $t0, 1
	bne $t0, $t1, fib_iterative
	

direct_answer:	
	li $v0, 4
	la $a0, Output_Iterative
	syscall                    
	add $a0, $t4, $zero
	li $v0, 1
	syscall                    
	
	
	li $v0, 4
	la $a0, iterartive_stack
	syscall                    
	add $a0, $zero, $zero      # because stack is zero in iterative
	li $v0, 1
	syscall                   
	
	
	addi $t6, $zero, 0         # Initialisation
	addi $t2, $t1, -1          # t2 
	
	add $s0, $zero, $sp        # initial stack pointer value for substraction
	jal fib
	sub $s1, $s0, $s1
	bgt $t1, 2, stack_not_zero
	add $s1, $zero, $zero       # if n is 1 or 2
stack_not_zero:
	li $v0, 4
	la $a0, Output_Recursive
	syscall                    
	add $a0, $t3, $zero
	li $v0, 1
	syscall                    
	li $v0, 4
	la $a0, recursive_stack
	syscall                    
	add $a0, $s1, $zero
	li $v0, 1
	syscall                     
	
	
	
	
	
	
exit:	
	li $v0, 4
	la $a0, end
	syscall                   
	li $v0, 10
	syscall                  


fib:
	bgt $t2, 1, fibo_recursive
	add $t3, $t2, $zero        # For 1 and 0
	jr $ra
	
fibo_recursive:
	addi $sp, $sp, -12   # allocating the stack frame
	sw $ra, 0($sp)       # savinf the return address
	
	sw $t2, 4($sp)       # save n
	addi $t2, $t2, -1    # n-1
	jal fib              # Call function again
	
	lw $t2, 4($sp)       # restore n
	sw $t3, 8($sp)       # saving return value of fib(n-1)
	addi $t2, $t2, -2    # n-2
	
	jal fib
	
	lw $t4, 8($sp)       # saving return value of fib(n-2)
	add $t3, $t3, $t4    # Final return value
	lw $ra, 0($sp)       # restore $ra
	
	bne $t6,$zero, got_stack_size   
	add $s1, $sp, $zero
	addi $t6, $zero, 1
got_stack_size:
	addi $sp, $sp, 12   # tear down the stack frame
	jr $ra


input:
	li $v0, 4
	la $a0, wrong_input
	syscall                     
	li $v0, 5
	syscall                     
	add $t1, $v0, $zero        
	
	ble $t1, $zero, input
	j good_input

