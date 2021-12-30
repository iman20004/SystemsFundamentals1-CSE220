.data
filename: .asciiz "/Users/imanali/Desktop/CSE220/HW3/hwk3/game02.txt"
.align 2
state: .byte 0x05 0x0c 0x0e 0x45 0x17
.ascii "XArg153cyIJvv2dkivJvSpka5BXf4MyeauUCg5cfQjiY6bs6BKEqE1cXtvHZsklfnwefnwpofnwepognepognepwocwelcmocmwepnepgbpeojrqcibgpenqeckjcowejvncneoicncnnnnnnnnnoinfiewncoinciorwnvirnviwn"

.text
.globl main
main:

la $a0, state
la $a1, filename
jal load_game

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

la $a1, state
lbu $a0, 0($a1)
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

lbu $a0, 1($a1)
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall


lbu $a0, 2($a1)
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

lbu $a0, 3($a1)
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

lbu $a0, 4($a1)
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

exit:
li $v0, 10
syscall

.include "hwk3.asm"
