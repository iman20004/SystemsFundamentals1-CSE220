.data
str: .ascii "Stony Brook University"

.text
.globl main
main:
	la $a0, str
	jal to_lowercase

	# You must write your own code here to check the correctness of the function implementation.
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall

	la $a0, str
	li $v0, 4
	syscall

	li $v0, 10
	syscall
	
.include "hwk2.asm"	
