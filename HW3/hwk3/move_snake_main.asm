.data
filename: .asciiz "/Users/imanali/Desktop/hwk3/game07.txt"
direction: .byte 'Z'
apples: .byte 4 4 2 7 3 5 1 8 1 7 3 11 1 11 0 4
apples_length: .word 8
.align 2
state:
.byte 8  # num_rows
.byte 14  # num_cols
.byte 4  # head_row
.byte 5  # head_col
.byte 14  # length
# Game grid:
.asciiz "....................##......................#..a.....#....#..1234..#..........56...E......##.7..CD.........89AB."


.text
.globl main
main:
la $a0, state
la $a1, filename
jal load_game

la $a0, state
lbu $a1, direction
la $a2, apples
lw $a3, apples_length
jal move_snake

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

la $a1, apples
lw $a2, apples_length
li $t3, 2
mul $a2, $a2, $t3
li $t0, 0
printing_loop:
	beq $t0, $a2, exit1
	lb $a0, 0($a1)
	addi $a1, $a1, 1
	li $v0, 1
	syscall
	li $a0, 0x20
	li $v0, 11
	syscall
	addi $t0, $t0, 1
	j printing_loop

exit1:
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
