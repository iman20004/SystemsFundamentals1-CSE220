# Simulate game04.txt - results in a loss
.data
filename: .asciiz "/Users/imanali/Desktop/games/game04.txt"
### Deck ###
# Garbage values
deck: .word 19159058 60556872
### Board ###
# Garbage values
.data
.align 2
board:
.word card_list541949 card_list144045 card_list109868 card_list386926 card_list597883 card_list284952 card_list255055 card_list337702 card_list45115 
# column #7
.align 2
card_list337702:
.word 213147  # list's size
.word 929558 # address of list's head
# column #2
.align 2
card_list109868:
.word 360261  # list's size
.word 524417 # address of list's head
# column #0
.align 2
card_list541949:
.word 340637  # list's size
.word 913724 # address of list's head
# column #5
.align 2
card_list284952:
.word 356601  # list's size
.word 97368 # address of list's head
# column #1
.align 2
card_list144045:
.word 539723  # list's size
.word 583615 # address of list's head
# column #4
.align 2
card_list597883:
.word 235830  # list's size
.word 936833 # address of list's head
# column #6
.align 2
card_list255055:
.word 974983  # list's size
.word 530896 # address of list's head
# column #3
.align 2
card_list386926:
.word 571954  # list's size
.word 761609 # address of list's head
# column #8
.align 2
card_list45115:
.word 277400  # list's size
.word 417512 # address of list's head
# Garbage values
moves: .ascii "f3rXNtgppaRqx6x4hpG6taZeSVTrfXQSHPYHzpx2v6D3NnJBFceYXd1gg5EzmH1SHTVa6JUQn9wU5ji9S24KkN3LPSt2qe783Cb3fr2GeqAQUZQDvhiDQiYN6I7MNtIVJ5u4FOP37K8skmXoYPDuefE43pCzpSytuIW6IT8rQ4JLJUbUHgCRiiE4Bi9QDU9h34riZpfgN91L7sviu7RBsfp63KVd4HzxBX0Ocq32osDQInDenn3RkG3Rtiulsfzw0pA8U0CWkasGNa2ToCBk0sttX9XdU5p4Coa2cxs1j4B51VQ14KemWD1kb0Jjhjl9YJ2J6I1Had4fpD8EQ089X1HGwlSA3Fgb2SMqn5OyMOvVGKbIllm5sYlFbz2iuNFY5IDUs1jZhXoZLESu4e4nxQUbntF99QAcW2WT05M0W89EDon2yhKJMywgPmmcoHX1P2ZXH7VmlqAsWQVRlLgatJqBQfauQzA04PK2wKt9DX9Fyj9VXl8f6BRfxn5UdS21a6AlMP77g"


.text
.globl main
main:
li $s0, 0
li $s1, 1
li $s2, 2
li $s3, 3
li $s4, 4
li $s5, 5
li $s6, 6
li $s7, 7



la $a0, filename
la $a1, board
la $a2, deck
la $a3, moves
jal simulate_game

# Write code to check the correctness of your code!
move $t3, $v0
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
li $a0, '\n'
li $v0, 11
syscall

li $a0, 'D'
li $v0, 11
syscall
li $a0, 'e'
li $v0, 11
syscall
li $a0, 'c'
li $v0, 11
syscall
li $a0, 'k'
li $v0, 11
syscall
li $a0, 0x20
li $v0, 11
syscall
la $a1, deck
lw $a0, 0($a1)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
lw $a2, 4($a1)

li $t7, 0
printing_rem:
beqz $a2, print_moves

lw $t4, 0($a2)
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

lw $t1, 4($a2)
move $a2, $t1
li $a0, 0x2D
li $v0, 11
syscall
addi $t7, $t7, 1
li $t0, 9
beq $t7, $t0, newline
b printing_rem

newline:
li $a0, '\n'
li $v0, 11
syscall
li $t7, 0
b printing_rem


print_moves:
li $a0, '\n'
li $v0, 11
syscall

li $a0, 'M'
li $v0, 11
syscall
li $a0, 'o'
li $v0, 11
syscall
li $a0, 'v'
li $v0, 11
syscall
li $a0, 'e'
li $v0, 11
syscall
li $a0, 's'
li $v0, 11
syscall
li $a0, '\n'
li $v0, 11
syscall

la $t0, moves
li $t6, 0
moves_loop:
beq $t6, $t3, print_board
addi $t6, $t6, 1
lw $a0, 0($t0)
li $v0, 1
syscall

addi $t0, $t0, 4
li $a0, 0x20
li $v0, 11
syscall
j moves_loop

print_board:
li $a0, '\n'
li $v0, 11
syscall
li $a0, '\n'
li $v0, 11
syscall
li $a0, 'B'
li $v0, 11
syscall
li $a0, 'o'
li $v0, 11
syscall
li $a0, 'a'
li $v0, 11
syscall
li $a0, 'r'
li $v0, 11
syscall
li $a0, 'd'
li $v0, 11
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
