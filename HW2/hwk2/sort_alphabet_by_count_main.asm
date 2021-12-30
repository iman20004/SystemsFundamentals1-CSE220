.data
sorted_alphabet: .ascii "drfXArg153cyIJvv2dkivJvSpka"
counts: .word 23 26 29 1 20 9 15 30 24 20 23 7 17 15 5 4 17 14 12 24 14 1 0 4 14 6


.text
.globl main
main:
	la $a0, sorted_alphabet
	la $a1, counts
	jal sort_alphabet_by_count
	
	# You must write your own code here to check the correctness of the function implementation.
	li $t4, 0x20
	la $a1, sorted_alphabet
	
	printing_loop:
		lb $t3, 0($a1)
		beqz $t3, exit
		addi $a1, $a1, 1
		move $a0, $t3
		li $v0, 11
		syscall
		b printing_loop

	exit:
	li $v0, 10
	syscall
	
.include "hwk2.asm"
