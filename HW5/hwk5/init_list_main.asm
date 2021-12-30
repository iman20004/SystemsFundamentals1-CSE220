.data
card_list: .word 16832383 14472030  # garbage

.text
.globl main
main:
la $a0, card_list
jal init_list


# Write code to check the correctness of your code!
la $a1, card_list
lw $a0, 0($a1)
li $v0, 1
syscall

li $a0, 0x20
li $v0, 11
syscall

lw $a0, 4($a1)
li $v0, 1
syscall


li $v0, 10
syscall

.include "hwk5.asm"
