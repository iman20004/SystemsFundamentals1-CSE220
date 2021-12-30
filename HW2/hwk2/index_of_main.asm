.data
str: .ascii "Ilhaveyouknwtsbdmcrif20gjpqxzABCDEFGHJKLMNOPQRSTUVWXYZ13456789\0"
ch: .byte '5'
start_index: .word 3

.text
.globl main
main:
	la $a0, str
	lbu $a1, ch
	lw $a2, start_index
	
	li $s1, 98
	li $s2, 43
	li $s3, 56
	li $s4, 33
	jal index_of
	
	# You must write your own code here to check the correctness of the function implementation.
	move $a0, $v0
	li $v0, 1
	syscall
	
	move $a0, $s1
	li $v0, 1
	syscall
	move $a0, $s2
	li $v0, 1
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	move $a0, $s4
	li $v0, 1
	syscall


	li $v0, 10
	syscall
	
.include "hwk2.asm"
