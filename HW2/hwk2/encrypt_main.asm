.data
ciphertext: .ascii "drfXArg153cyIJvv2dkivJvSpka5BXf4MyeauUCg5cfQjiY6bs6BKEqE1cXtvHZEn0MO"
plaintext: .ascii "Q R-S=T:U;V[W]X(Y)Z*\0"
keyphrase: .ascii "abcdef\0"
corpus: .ascii "aaaaaaaaabbbbbbcccccddddeeeefghijk\0"
.text
.globl main
main:
 	la $a0, ciphertext
	la $a1, plaintext
	la $a2, keyphrase
	la $a3, corpus
	li $s0, 699
	li $s1, 700
	li $s2, 701
	li $s3, 702
	li $s4, 703
	li $s5, 704
	li $s6, 705
	li $s7, 706
	jal encrypt
		
	# You must write your own code here to check the correctness of the function implementation.
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	move $a0, $v1
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	move $a0, $s0
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	move $a0, $s1
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	move $a0, $s2
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	move $a0, $s4
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	move $a0, $s5
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	move $a0, $s6
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	move $a0, $s7
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	la $t7, ciphertext
	
	printing_loop:
		lb $t3, 0($t7)
		beqz $t3, exit
		addi $t7, $t7, 1
		move $a0, $t3
		li $v0, 11
		syscall
		b printing_loop

	exit:
	li $v0, 10
	syscall
	
.include "hwk2.asm"
