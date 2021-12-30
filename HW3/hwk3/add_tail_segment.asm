.data
direction: .byte 'U'
tail_row: .byte 4
tail_col: .byte 8
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
lbu $a1, direction
lb $a2, tail_row
lb $a3, tail_col
jal add_tail_segment


# You must write your own code here to check the correctness of the function implementation.
move $a0, $v0
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

la $a1, state
lb $a0, 4($a1)
li $v0, 1
syscall

li $a0, '\n'
li $v0, 11
syscall

la $a2, state
addi $a1, $a2, 5
li $t0, 0
li $t4, 0
lbu $t1, 0($a2)
lbu $t2, 1($a2)
game_printing:
	beq $t4, $t1, exit
	beq $t0, $t2, new_row
	lb $a0, 0($a1)
	li $v0, 11
	syscall
	addi $a1, $a1, 1
	addi $t0, $t0, 1
	j game_printing

new_row:
li $a0, '\n'
li $v0, 11
syscall
addi $t4, $t4, 1
li $t0, 0
b game_printing

exit:
li $v0, 10
syscall


.include "hwk3.asm"
