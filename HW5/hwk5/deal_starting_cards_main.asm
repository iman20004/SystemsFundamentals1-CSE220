# Deal out a deck of shuffled cards
.data
##### Deck #####
.align 2
deck:
.word 80  # list's size
.word node866441 # address of list's head
node549917:
.word 6574904
.word node226924
node443866:
.word 6574896
.word node987388
node669368:
.word 6574898
.word node832443
node427262:
.word 6574901
.word node95554
node583160:
.word 6574903
.word node657684
node158838:
.word 6574899
.word node728832
node40184:
.word 6574897
.word node347861
node849609:
.word 6574904
.word node206149
node100260:
.word 6574899
.word node481892
node982669:
.word 6574898
.word node329869
node489523:
.word 6574896
.word node166575
node436383:
.word 6574897
.word node196313
node832443:
.word 6574905
.word node583160
node170966:
.word 6574903
.word node663403
node424145:
.word 6574902
.word node809755
node431141:
.word 6574901
.word node489523
node934868:
.word 6574905
.word node801484
node987388:
.word 6574904
.word node534918
node801664:
.word 6574898
.word node896123
node896123:
.word 6574905
.word node441787
node245369:
.word 6574900
.word node749766
node273737:
.word 6574904
.word node725010
node749766:
.word 6574902
.word node244346
node711074:
.word 6574905
.word node372183
node686771:
.word 6574902
.word node133439
node71047:
.word 6574900
.word node273737
node775948:
.word 6574899
.word node120144
node866441:
.word 6574904
.word node245369
node414295:
.word 6574901
.word node323796
node767242:
.word 6574903
.word node159085
node174896:
.word 6574900
.word node587504
node196313:
.word 6574899
.word node71047
node696682:
.word 6574900
.word node849609
node527043:
.word 6574904
.word node424145
node133439:
.word 6574896
.word node174896
node478415:
.word 6574898
.word node425784
node372183:
.word 6574898
.word node669368
node95554:
.word 6574905
.word node436383
node728832:
.word 6574901
.word node40184
node657684:
.word 6574901
.word node775948
node760886:
.word 6574905
.word node711074
node500038:
.word 6574904
.word node605181
node17136:
.word 6574898
.word node349416
node765700:
.word 6574899
.word node767242
node425784:
.word 6574897
.word node298441
node481892:
.word 6574904
.word node436286
node159085:
.word 6574903
.word node427262
node245931:
.word 6574901
.word node414295
node846140:
.word 6574896
.word node760886
node120144:
.word 6574900
.word node155237
node725010:
.word 6574903
.word node80102
node329869:
.word 6574898
.word node686771
node155237:
.word 6574902
.word node797368
node436286:
.word 6574899
.word node696682
node618484:
.word 6574900
.word node954556
node35821:
.word 6574903
.word node846140
node801484:
.word 6574902
.word node35821
node954556:
.word 6574896
.word node431141
node298441:
.word 6574900
.word node527043
node809755:
.word 6574905
.word node982669
node206149:
.word 6574902
.word node170966
node768847:
.word 6574896
.word node443866
node797368:
.word 6574896
.word node801664
node880870:
.word 6574901
.word node553306
node184491:
.word 6574897
.word node381978
node349416:
.word 6574899
.word node880870
node587504:
.word 6574898
.word node100260
node80102:
.word 6574896
.word node184491
node441787:
.word 6574899
.word 0
node663403:
.word 6574903
.word node17136
node381978:
.word 6574897
.word node478415
node347861:
.word 6574903
.word node500038
node605181:
.word 6574897
.word node934868
node553306:
.word 6574897
.word node549917
node323796:
.word 6574900
.word node765700
node166575:
.word 6574901
.word node324908
node534918:
.word 6574902
.word node618484
node226924:
.word 6574905
.word node768847
node244346:
.word 6574902
.word node245931
node324908:
.word 6574897
.word node158838
##### Board #####
.data
.align 2
board:
.word card_list405009 card_list777373 card_list700918 card_list471570 card_list776119 card_list701324 card_list449849 card_list29631 card_list340637 
# column #7
.align 2
card_list29631:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #1
.align 2
card_list777373:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #5
.align 2
card_list701324:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #3
.align 2
card_list471570:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #6
.align 2
card_list449849:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #2
.align 2
card_list700918:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #4
.align 2
card_list776119:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #0
.align 2
card_list405009:
.word 0  # list's size
.word 0  # address of list's head (null)
# column #8
.align 2
card_list340637:
.word 0  # list's size
.word 0  # address of list's head (null)



.text
.globl main
main:
la $a0, board
la $a1, deck
jal deal_starting_cards

# Write code to check the correctness of your code!
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
