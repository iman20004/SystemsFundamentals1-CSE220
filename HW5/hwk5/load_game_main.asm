
# Load game02.txt
.data
filename: .asciiz "/Users/imanali/Desktop/games/game04\ copy.txt"
# Garbage values
deck: .word 49752558 84042193
# Garbage values
.data
.align 2
board:
.word card_list601262 card_list492090 card_list806140 card_list547011 card_list216912 card_list669785 card_list848653 card_list417583 card_list677543 
# column #3
.align 2
card_list547011:
.word 319918  # list's size
.word 360147 # address of list's head
# column #7
.align 2
card_list417583:
.word 330578  # list's size
.word 13158 # address of list's head
# column #1
.align 2
card_list492090:
.word 500091  # list's size
.word 278210 # address of list's head
# column #5
.align 2
card_list669785:
.word 861167  # list's size
.word 638481 # address of list's head
# column #8
.align 2
card_list677543:
.word 936317  # list's size
.word 806648 # address of list's head
# column #4
.align 2
card_list216912:
.word 840431  # list's size
.word 506422 # address of list's head
# column #0
.align 2
card_list601262:
.word 955411  # list's size
.word 451557 # address of list's head
# column #6
.align 2
card_list848653:
.word 552679  # list's size
.word 592251 # address of list's head
# column #2
.align 2
card_list806140:
.word 878537  # list's size
.word 38529 # address of list's head
# Garbage values
moves: .ascii "GWaPsfyUlNuC3gUM9VImzORemnUwBXEsP4JIkybqUbW65ORkXmxlgiTMgrh56exd6qxiqAfNqHYJ3hQIh6vsZZO3WQtC9paf1hNg7XC1y0745w8Rl05iyaAnp6aZAiZ2flIrAkX4y0te3bhYKzrKdORITm4ttMJYQvbQjts49mBnFcBe3ZZjkQdJo51eCL9mzKT03BTI8xe813nfCc8I7tSbnRcj2PHgTd1AZU4ENyvQlPQzBQRgfcnjQZPiYTQLtxGATqsA2lIH2Q7Jf27a4LMTjHWM8QMgD6PpOZ0JEbxsZWDxPVs1IWKLPYvmkcxdLgFZxWAQl5gQNeoKyiGRTgW7F7HWo4OYHFvu8MO2AY55WPrvRElpgUT1dSHTXjx7cijZPkRRzVZlXJ4pG8PlXFGQaEjrwRGOCoeBV24EzudOB3ASfuCDahcTwxuXpSJSR6JEUX0LSvQocliPCm0R1EBO1aw8P7ir97wItRewnYdhJiHaMFGAzTFeZmlwovSAVFhzewG8ygmqfShxlmf3eB0PP6C7UB8C"




.text
.globl main
main:
li $s0, 10
li $s1, 11
li $s2, 12
li $s3, 13
li $s4, 14
li $s5, 15
li $s6, 16
li $s7, 17


la $a0, filename
la $a1, board
la $a2, deck
la $a3, moves
jal load_game

# Write code to check the correctness of your code!
move $a0, $v0
li $v0, 1
syscall
li $a0, 0x20
li $v0, 11
syscall
move $t3, $v1
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
