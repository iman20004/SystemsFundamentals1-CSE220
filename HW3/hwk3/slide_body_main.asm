.data
head_row_delta: .byte 1
head_col_delta: .byte 0
apples: .byte 1 7 3 2 1 4 4 3
apples_length: .word 4
.align 2
state:
.byte 8  # num_rows
.byte 14  # num_cols
.byte 7  # head_row
.byte 3  # head_col
.byte 14  # length
# Game grid:
.asciiz "....................##......................#..a.....#........#.........456...........327............189ABCDE..."
 #"....................##......................#..a.....#....#..1234..#..........56...E......##.7..CD.........89AB."

.text
.globl main
main:
la $a0, state
lb $a1, head_row_delta
lb $a2, head_col_delta
la $a3, apples
addi $sp, $sp, -4
lw $t0, apples_length
sw $t0, 0($sp)
li $t0, 7918273    # putting some random garbage in $t0
jal slide_body
addi $sp, $sp, 4


# You must write your own code here to check the correctness of the function implementation.
move $a0, $v0
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

la $a1, state
lb $a0, 2($a1)
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

la $a1, state
lb $a0, 3($a1)
li $v0, 1
syscall

li $a0, '\n'
li $v0, 11
syscall

la $a1, apples
printing_loop:
	lb $a0, 0($a1)
	beqz $a0, print_game
	addi $a1, $a1, 1
	li $v0, 1
	syscall
	li $a0, 0x20
	li $v0, 11
	syscall
	j printing_loop

print_game:
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
