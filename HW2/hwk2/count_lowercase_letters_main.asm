.data
counts: .word -890186 -438641 -817157 612618 -145953 -440997 -774137 758469 889951 834642 -919986 -204919 124497 179267 -303331 -285295 786955 -891155 -665164 -716764 -292806 176422 -299979 471550 -485856 -656536
message: .ascii "The specialization in artificial intelligence and data science emphasizes modern approaches for building intelligent systems using machine learning.\0"
.text
.globl main
main:
	la $a0, counts
	la $a1, message
	jal count_lowercase_letters

	# You must write your own code here to check the correctness of the function implementation.
	
	move $a0, $v0
	li $v0, 1
	syscall

	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $t1, 0
	li $t2, 26
	li $t4, 0x20
	la $a1, counts
	
	printing_loop:
		beq $t1, $t2, exit
		addi $t1, $t1, 1
		lb $t3, 0($a1)
		addi $a1, $a1, 4
		move $a0, $t3
		li $v0, 1
		syscall
		move $a0, $t4
		li $v0, 11
		syscall
		b printing_loop

	exit:
	li $v0, 10
	syscall
	
.include "hwk2.asm"
