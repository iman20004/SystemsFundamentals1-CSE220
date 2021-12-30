.data
ciphertext_alphabet: .ascii "drfXArg153cyIJvv2dkivJvSpka5BXf4MyeauUCg5cfQjiY6bs6BKEqE1cXtvHZ"
keyphrase: .ascii "I'll have you know that I stubbed my toe last week and only cried for 20 minutes.\0"

.text
.globl main
main:
	la $a0, ciphertext_alphabet
	la $a1, keyphrase
	jal generate_ciphertext_alphabet
	
	# You must write your own code here to check the correctness of the function implementation.
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $t1, 0
	li $t2, 62
	la $t7, ciphertext_alphabet
	
	
	printing_loop:
		beq $t1, $t2, exit
		addi $t1, $t1, 1
		lb $t3, 0($t7)
		addi $t7, $t7, 1
		move $a0, $t3
		li $v0, 11
		syscall
		b printing_loop

	exit:
	li $v0, 10
	syscall
	
.include "hwk2.asm"
