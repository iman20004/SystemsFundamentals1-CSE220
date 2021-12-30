# Deal-move
.data
##### Deck #####
.align 2
deck:
.word 36  # list's size
.word node637399 # address of list's head
node865399:
.word 6574897
.word node755464
node637399:
.word 6574896
.word node326815
node10365:
.word 6574905
.word node372287
node742222:
.word 6574901
.word node415112
node32263:
.word 6574900
.word node411517
node990108:
.word 6574896
.word node950636
node944205:
.word 6574897
.word node849777
node411517:
.word 6574900
.word node278057
node515703:
.word 6574899
.word node32263
node402285:
.word 6574898
.word node621065
node570775:
.word 6574896
.word node402285
node806004:
.word 6574901
.word node124142
node675171:
.word 6574901
.word node10365
node983505:
.word 6574904
.word node546974
node372287:
.word 6574896
.word node983505
node591188:
.word 6574902
.word node902341
node278057:
.word 6574902
.word node668414
node902341:
.word 6574900
.word node290328
node621065:
.word 6574903
.word node45357
node668414:
.word 6574905
.word node187689
node187689:
.word 6574901
.word node509494
node546974:
.word 6574897
.word node591188
node849777:
.word 6574905
.word node675171
node675212:
.word 6574901
.word 0
node326815:
.word 6574903
.word node239383
node239383:
.word 6574900
.word node865399
node290328:
.word 6574904
.word node806004
node509494:
.word 6574902
.word node742222
node124142:
.word 6574904
.word node515703
node415112:
.word 6574905
.word node570775
node640354:
.word 6574905
.word node675212
node950636:
.word 6574899
.word node327089
node327089:
.word 6574899
.word node640354
node755464:
.word 6574898
.word node365701
node365701:
.word 6574897
.word node944205
node45357:
.word 6574903
.word node990108
##### Board #####
.data
.align 2
board:
.word card_list652504 card_list812016 card_list921683 card_list171864 card_list73675 card_list493365 card_list595505 card_list252786 card_list338789 
# column #0
.align 2
card_list652504:
.word 5  # list's size
.word node5197 # address of list's head
node749158:
.word 7689011
.word node12927
node12927:
.word 7689010
.word node564963
node732414:
.word 6574902
.word node749158
node5197:
.word 6574905
.word node732414
node564963:
.word 7689009
.word 0
# column #6
.align 2
card_list595505:
.word 1  # list's size
.word node82472 # address of list's head
node82472:
.word 7689016
.word 0
# column #3
.align 2
card_list171864:
.word 1  # list's size
.word node632686 # address of list's head
node632686:
.word 7689010
.word 0
# column #5
.align 2
card_list493365:
.word 6  # list's size
.word node515666 # address of list's head
node373743:
.word 7689013
.word node706753
node521908:
.word 7689010
.word 0
node618631:
.word 7689014
.word node373743
node706753:
.word 7689012
.word node273844
node515666:
.word 7689015
.word node618631
node273844:
.word 7689011
.word node521908
# column #1
.align 2
card_list812016:
.word 2  # list's size
.word node261157 # address of list's head
node261157:
.word 6574905
.word node737193
node737193:
.word 7689016
.word 0
# column #8
.align 2
card_list338789:
.word 3  # list's size
.word node647750 # address of list's head
node647750:
.word 6574896
.word node96168
node96168:
.word 7689016
.word node537141
node537141:
.word 7689015
.word 0
# column #4
.align 2
card_list73675:
.word 1  # list's size
.word node465042 # address of list's head
node465042:
.word 7689015
.word 0
# column #2
.align 2
card_list921683:
.word 9  # list's size
.word node868784 # address of list's head
node840120:
.word 7689014
.word node18420
node210500:
.word 7689008
.word 0
node18420:
.word 7689013
.word node353166
node353166:
.word 7689012
.word node220143
node868784:
.word 7689016
.word node866872
node870143:
.word 7689009
.word node210500
node866872:
.word 7689015
.word node840120
node220143:
.word 7689011
.word node569665
node569665:
.word 7689010
.word node870143
# column #7
.align 2
card_list252786:
.word 6  # list's size
.word node282115 # address of list's head
node294916:
.word 7689011
.word node800476
node244027:
.word 7689012
.word node294916
node800476:
.word 7689010
.word node718931
node718931:
.word 7689009
.word node80978
node80978:
.word 7689008
.word 0
node282115:
.word 6574902
.word node244027
##### Move #####
move: .word 459778





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

la $a0, board
la $a1, deck
lw $a2, move
jal move_card

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
beq $t0, $t7, printing_deck
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

printing_deck:
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
beqz $a2, exit

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

exit:
li $v0, 10
syscall


.include "hwk5.asm"
