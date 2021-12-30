# Column contains a straight with no additional cards below
.data
.align 2
col_num: .word 4
##### Board #####
.data
.align 2
board:
.word card_list378165 card_list379418 card_list441201 card_list227116 card_list359697 card_list201820 card_list400949 card_list882509 card_list524786 
# column #6
.align 2
card_list400949:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #7
.align 2
card_list882509:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #2
.align 2
card_list441201:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #8
.align 2
card_list524786:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #0
.align 2
card_list378165:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #3
.align 2
card_list227116:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #1
.align 2
card_list379418:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #5
.align 2
card_list201820:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #4
.align 2
card_list359697:
.word 10  # list's size
.word node278376 # address of list's head
node183374:
.word 7689014
.word node897929
node586186:
.word 7689012
.word node394689
node72519:
.word 7689009
.word node966455
node278376:
.word 7689017
.word node869645
node897929:
.word 7689013
.word node586186
node966455:
.word 7689008
.word 0
node394689:
.word 7689011
.word node386419
node386419:
.word 7689010
.word node72519
node869645:
.word 7689016
.word node969333
node969333:
.word 7689015
.word node183374





.text
.globl main
main:
li $s0, 14
li $s1, 15
li $s2, 16
li $s3, 17
li $s4, 18
li $s5, 19
li $s6, 20
li $s7, 21


la $a0, board
lw $a1, col_num
jal clear_full_straight

# Write code to check the correctness of your code!
move $a0, $v0
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

la $a1, board

li $t0, 0
li $t7, 9
printing_cols:
beq $t0, $t7, exit
move $a0, $t0
li $v0, 1
syscall
addi $t0, $t0, 1
li $a0, ':'
li $v0, 11
syscall
li $a0, 0x20
li $v0, 11
syscall
lw $t1, 0($a1)
addi $a1, $a1, 4
lw $a0, 0($t1)
li $v0, 1
syscall
li $a0, 0x20
li $v0, 11
syscall
lw $t3, 4($t1)
beqz $t3, next_col
print_list:
lw $t4, 0($t3)
li $t6, 0xFF
and $a0, $t4, $t6
li $t6, 0x30
sub $a0, $a0, $t6
li $v0, 1
syscall
li $t6, 0xFF00
and $a0, $t4, $t6
srl $a0, $a0, 8
li $v0, 11
syscall
li $t6, 0xFF0000
and $a0, $t4, $t6
srl $a0, $a0, 16
li $v0, 11
syscall

li $a0, 0x2D
li $v0, 11
syscall
lw $t5, 4($t3)
beqz $t5, next_col
move $t3, $t5
j print_list

next_col:
li $a0, '\n'
li $v0, 11
syscall
j printing_cols



exit:
li $v0, 10
syscall

.include "hwk5.asm"
