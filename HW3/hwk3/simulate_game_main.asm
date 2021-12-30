.data
filename: .asciiz "/Users/imanali/Desktop/hwk3/game08.txt"
directions: .asciiz "DDLLULLUURRURRDRRRURRDDRUR"

apples_length: .word 60

num_moves_to_execute: .word 25

apples: .byte 0 8 4 6 0 4 2 6 1 4 2 11 1 11 3 2 4 10 0 11 2 4 1 8 3 4 1 5 0 10 4 2 1 0 2 0 4 5 0 9 4 0 2 7 4 1 2 5 2 10 0 5 4 7 3 5 2 2 4 3 4 4 4 8 1 2 3 3 0 2 0 3 2 9 4 9 2 3 3 1 0 6 3 6 3 10 0 0 3 9 1 7 3 0 3 7 2 1 0 7 1 9 1 3 2 8 1 1 3 8 1 10 0 1 3 11 1 6 4 11

.align 2

state: .byte 0x05 0x0c 0x2a 0x36 0x77

.asciiz "NwpHO6lB06DyizI7T8RouKDE8mBAkKsWuxlOalCcJtWMmpAoFeazGmXUXK2r"

.text
.globl main
main:
li $s0, 25
li $s1, 24
li $s2, 23
li $s3, 22
li $s4, 21
li $s5, 20
li $s6, 19
li $s7, 18


li $t7, 26
sw $t7, 0($sp)

la $a0, state
la $a1, filename
la $a2, directions
lw $a3, num_moves_to_execute
addi $sp, $sp, -8
la $t0, apples
sw $t0, 0($sp)
lw $t0, apples_length
sw $t0, 4($sp)
li $t0, 123920  # putting garbage in $t0
jal simulate_game
addi $sp, $sp, 8


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

li $a0, 0x20
li $v0, 11
syscall

lw $a0, 0($sp)
li $v0, 1
syscall

li $a0, '\n'
li $v0, 11
syscall

move $a0, $s0
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

move $a0, $s1
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

move $a0, $s2
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

move $a0, $s3
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

move $a0, $s4
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

move $a0, $s5
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

move $a0, $s6
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

move $a0, $s7
li $v0, 1
syscall


li $a0, '\n'
li $v0, 11
syscall


la $a1, state
lb $a0, 0($a1)
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

la $a1, state
lb $a0, 1($a1)
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
