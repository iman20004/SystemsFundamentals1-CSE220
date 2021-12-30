# Append an item to a short list
.data
card_num: .word 6570802
.align 2
card_list:
.word 5  # list's size
.word node537691 # address of list's head
node299116:
.word 7689011
.word 0
node411020:
.word 6572086
.word node171407
node537691:
.word 6574898
.word node253109
node171407:
.word 7684917
.word node299116
node253109:
.word 7685168
.word node411020



.text
.globl main
main:
la $a0, card_list
lw $a1, card_num
jal append_card

# Write code to check the correctness of your code!
la $a1, card_list
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
