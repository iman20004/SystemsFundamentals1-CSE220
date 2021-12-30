.data
apples: .byte 3 2 1 4 4 3
apples_length: .word 3
.align 2
state:
.byte 5  # num_rows
.byte 12  # num_cols
.byte 1  # head_row
.byte 5  # head_col
.byte 7  # length
# Game grid:
.asciiz ".............a.#.1..#......#.2..#......#.3..#........4567..."

.text
.globl main
main:
la $a0, state
la $a1, apples
lw $a2, apples_length
jal place_next_apple

# You must write your own code here to check the correctness of the function implementation.
move $a0, $v0
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

move $a0, $v1
li $v0, 1
syscall

li $a0, '\n'
li $v0, 11
syscall

la $a1, state
addi $a1, $a1, 5
move $a0, $a1
li $v0, 4
syscall

li $a0, '\n'
li $v0, 11
syscall

la $a1, apples
printing_loop:
	lbu $a0, 0($a1)
	beqz $a0, exit
	addi $a1, $a1, 1
	li $v0, 1
	syscall
	li $a0, 0x20
	li $v0, 11
	syscall
	j printing_loop

exit:
li $v0, 10
syscall

.include "hwk3.asm"
