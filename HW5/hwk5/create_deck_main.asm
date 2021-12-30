.text
.globl main
main:
jal create_deck

# Write code to check the correctness of your code!
move $a1, $v0
lw $t0, 0($a1)
move $a0, $t0
li $v0, 1
syscall 

li $a0, '\n'
li $v0, 11
syscall

addi $a1, $a1, 4
lw $a2, 0($a1)
printing_cards:
beqz $a2, exit
lw $a0, 0($a2)
li $v0, 1
syscall
addi $a2, $a2, 4
lw $t1, 0($a2)
move $a2, $t1
li $a0, '\n'
li $v0, 11
syscall
b printing_cards

exit:
li $v0, 10
syscall

.include "hwk5.asm"
