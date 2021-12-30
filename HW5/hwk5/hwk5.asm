# Iman Ali
# imaali
# 112204305

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

.text

init_list:
   li $t0, 0
   sw $t0, 0($a0)
   sw $t0, 4($a0)

   jr $ra

append_card:
   addi $sp, $sp, -12
   sw $ra, 0($sp)
   sw $s0, 4($sp)
   sw $s1, 8($sp)
   
   move $s0, $a0
   move $s1, $a1
   
   li $a0, 8
   li $v0, 9
   syscall
   
   sw $s1, 0($v0)			# save card num
   li $t0, 0
   sw $t0, 4($v0)			# save next as null-term
   
   lw $t0, 0($s0)
   addi $t2, $t0, 1
   sw $t2, 0($s0)
   beqz $t0, empty_list
   lw $t1, 4($s0)
   
   finding_last:
   lw $t2, 4($t1)
   beqz $t2, append_here
   move $t1, $t2
   b finding_last
   
   append_here:
   sw $v0, 4($t1)
   b exit_append
   
   empty_list:
   sw $v0, 4($s0)
   
   exit_append:
   lw $ra, 0($sp)
   lw $s0, 4($sp)
   lw $s1, 8($sp)
   addi $sp, $sp, 12
   jr $ra

create_deck:
   li $a0, 8
   li $v0, 9
   syscall
   
   addi $sp, $sp, -16
   sw $ra, 0($sp)
   sw $s0, 4($sp)
   sw $s1, 8($sp)
   sw $s2, 12($sp)
   
   move $s0, $v0
   move $a0, $s0
   jal init_list
   
   li $s2, 80
   
   li $s1, 0x00645330
   move $a1, $s1
   move $a0, $s0
   jal append_card
   addi $s2, $s2, -1
   addi $s1, $s1, 1
   
   adding_loop:
   	beqz $s2, exit_create
        move $a1, $s1
        move $a0, $s0
        jal append_card
        addi $s2, $s2, -1
   	li $t1, 0x00645339
   	beq $s1, $t1, start_again
   	addi $s1, $s1, 1
   	b adding_loop
   	
   
   start_again:
   li $s1, 0x00645330
   b adding_loop
   
   exit_create:
   move $v0, $s0
   lw $ra, 0($sp)
   lw $s0, 4($sp)
   lw $s1, 8($sp)
   lw $s2, 12($sp)
   addi $sp, $sp, 16
   jr $ra

deal_starting_cards:
   addi $sp, $sp, -28
   sw $ra, 0($sp)
   sw $s0, 4($sp)
   sw $s1, 8($sp)
   sw $s2, 12($sp)
   sw $s3, 16($sp)
   sw $s4, 20($sp)
   sw $s5, 24($sp)
   
   
   move $s0, $a0		# start addr of board
   move $s1, $a0		# start addr of board
   
   move $s2, $a1		# start addr of deck
   addi $t0, $s2, 4		# addr of addr of head of deck
   lw $s3, 0($t0)		# $s3 has addr of head
   	
   li $s4, 0
   li $s5, 0
   		
   deal_down:
   	li $t0, 35
   	beq $s5, $t0, deal_up
   	lw $t0, 0($s3)		# $t0 has num of card
   	lw $t1, 4($s3)		# $t1 has addr of next card
   	move $s3, $t1
   
   	lw $a0, 0($s1)		# appropraite col of board
   	move $a1, $t0		# top card in deck
   	jal append_card
   	addi $s4, $s4, 1
   	li $t0, 9
   	beq $s4, $t0, wrap_around
   	addi $s1, $s1, 4
   	addi $s5, $s5, 1
   	j deal_down

   	wrap_around:
   	move $s1, $s0
   	li $s4, 0
   	addi $s5, $s5, 1
   	j deal_down
   	
   deal_up:
   	li $s4, 8
   	li $s5, 0
   	loop_up:
   	li $t0, 9
   	beq $s5, $t0, exit_deal
   	lw $t0, 0($s3)		# $t0 has num of card
   	lw $t1, 4($s3)		# $t1 has addr of next card
   	move $s3, $t1
   	
   	lw $a0, 0($s1)		# appropraite col of board
   	move $a1, $t0
   	li $t0, 0xFFFF
   	and $a1, $a1, $t0
   	li $t6, 0x75
   	sll $t6, $t6, 16
   	or $a1, $a1, $t6
   	jal append_card
   	addi $s4, $s4, 1
   	li $t0, 9
   	beq $s4, $t0, wrap_around2
   	addi $s1, $s1, 4
   	addi $s5, $s5, 1
   	j loop_up
   
   wrap_around2:
   	move $s1, $s0
   	li $s4, 0
   	addi $s5, $s5, 1
   	j loop_up
   			
   exit_deal:
   li $t0, 36
   sw $t0, 0($s2)
   sw $s3, 4($s2)
   lw $ra, 0($sp)
   lw $s0, 4($sp)
   lw $s1, 8($sp)
   lw $s2, 12($sp)
   lw $s3, 16($sp)
   lw $s4, 20($sp)
   lw $s5, 24($sp)
   addi $sp, $sp, 28
   jr $ra

get_card:
    lw $t0, 0($a0)
    beqz $t0, invalid_index
    bge $a1, $t0, invalid_index
    bltz $a1, invalid_index
    
    li $t1, 0
    lw $t2, 4($a0)
    loop_get:
    	beq $t1, $a1, found_index
    	lw $t3, 4($t2)
    	move $t2, $t3
    	addi $t1, $t1, 1
    	j loop_get
    	
    found_index:
    	lw $v1, 0($t2)
    	li $v0, 1
    	li $t4, 0xFF0000
    	and $t4, $v1, $t4
    	srl $t4, $t4, 16
    	li $t5, 0x75
    	beq $t4, $t5, face_up_case
    	j exit_get_card
    	
    face_up_case:
    addi $v0, $v0, 1
    j exit_get_card
    
    invalid_index:
    li $v0, -1
    li $v1, -1
    
    exit_get_card:
    jr $ra

check_move:
    addi $sp, $sp, -36
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    sw $s6, 28($sp)
    sw $s7, 32($sp)
    
    
    li $s0, 0				# initalize final ans
    move $s1, $a0			# s1 has board
    move $s2, $a1			# s2 has deck
    move $s3, $a2			# s3 has move


    li $t0, 0x01000000
    beq $a2, $t0, success_one		# valid deal move
    li $t0, 0xFF000000
    and $t1, $a2, $t0
    srl $t1, $t1, 24
    li $t0, 1
    beq $t0, $t1, error_one
    li $t0, 0
    beq $t0, $t1, normal_move_par
    j error_one
   	
    success_one:
    li $s0, 1
    lw $t0, 0($a1)			# empty deck?
    beqz $t0, error_two
    li $t2, 0
    li $t3, 9
    empty_board_cols:
        beq $t2, $t3, exit_check_move
    	lw $t0, 0($a0)
    	lw $t1, 0($t0)
    	beqz $t1, error_two
    	addi $a0, $a0, 4
    	addi $t2, $t2, 1
    	j empty_board_cols
  
   
    normal_move_par:
    	# error_three check
    	li $t0, 0xFF
    	and $t1, $a2, $t0		# $t1 donor col
    	bltz $t1, error_three
    	li $t0, 8
    	bgt $t1, $t0, error_three
    	
    	li $t0, 0xFF0000
    	and $t2, $a2, $t0		
    	srl $t2, $t2, 16		# $t2 recipient col
   	bltz $t2, error_three
   	li $t0, 8
    	bgt $t2, $t0, error_three
    	
    	# error_four check
    	li $t0, 0xFF00
    	and $t3, $a2, $t0
    	srl $t3, $t3, 8			# $t3 has donor row index
    	move $s4, $t3			# s4 has donor row index
    	
    	bltz $t3, error_four
    	li $t5, 4
    	mul $t5, $t5, $t1
    	add $t4, $a0, $t5		
    	lw $t5, 0($t4)
    	move $s5, $t5			# s5 has starting addr of donor col list
    	lw $t6, 0($t5)
    	bge $t3, $t6, error_four
    	
    	# error_five check
    	beq $t1, $t2, error_five
    	
    	# error_six check
    	move $a0, $s5 
    	move $a1, $t3
    	jal get_card
    	li $t0, 1
    	beq $v0, $t0, error_six
    	
    	# error_seven check
    	lw $s0, 0($s5)		# size of donor col
    	addi $s0, $s0, -1
    	beq $s4, $s0, next_cond
    	
    	move $a0, $s5
    	move $a1, $s4
    	jal get_card
    	li $t0, 0xFF
    	and $s7, $v1, $t0
    	
    	move $s6, $s4
    	addi $s6, $s6, 1
    	
    	consec_check:
    	bgt $s6, $s0, next_cond
    	move $a0, $s5
    	move $a1, $s6
    	jal get_card
    	li $t0, 0xFF
    	and $t1, $v1, $t0
    	addi $s7, $s7, -1
    	bne $s7, $t1, error_seven
	move $s7, $t1
    	addi $s6, $s6, 1
    	j consec_check
    	
    next_cond:
    #check recipient col
    li $t0, 0xFF0000
    and $t2, $a2, $t0		
    srl $t2, $t2, 16
    li $t5, 4
    mul $t5, $t5, $t2
    add $t4, $s1, $t5		
    lw $t5, 0($t4)
    lw $t6, 0($t5)
    beqz $t6, success_two
    
    #error_eight check
    last_recipient:
    	lw $t0, 4($t5)
    	beqz $t0, found_last
    	move $t5, $t0
    	j last_recipient
    	
    found_last:
    	lw $t0, 0($t5)
    	li $t1, 0xFF
    	and $t0, $t0, $t1
    	move $s6, $t0
    	
    	move $a0, $s5
    	move $a1, $s4
    	jal get_card
    	li $t1, 0xFF
    	and $t0, $v1, $t1
    	addi $s6, $s6, -1
    	bne $s6, $t0, error_eight
    
   success_three:
    	li $s0, 3
   	j exit_check_move		
    				
   success_two:
    	li $s0, 2
   	j exit_check_move
    			
   error_one:
   	li $s0, -1
   	j exit_check_move
    
   error_two:
   	li $s0, -2
   	j exit_check_move
   	
   error_three:
   	li $s0, -3
   	j exit_check_move		
    	
   error_four:
   	li $s0, -4
   	j exit_check_move
    
   error_five:
   	li $s0, -5
   	j exit_check_move
   	
   error_six:
   	li $s0, -6
   	j exit_check_move
   	
   error_seven:
  	li $s0, -7
   	j exit_check_move
   	
   error_eight:
  	li $s0, -8
   	j exit_check_move
   
   exit_check_move:
    move $v0, $s0
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    lw $s6, 28($sp)
    lw $s7, 32($sp)
    
    addi $sp, $sp, 36
    jr $ra

clear_full_straight:
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    
    bltz $a1, invalid_col
    li $t0, 8
    bgt $a1, $t0, invalid_col
    
    li $t0, 4
    mul $t0, $t0, $a1
    add $t1, $a0, $t0 
    
    lw $t0, 0($t1)		# $t0 adr of col
    move $s0, $t0		# $s0 adr of col
    lw $t1, 0($t0)		# $t1 size of col
    li $t2, 10
    blt $t1, $t2, fewer_than_ten
    
    li $t7, 0
    lw $t2, 4($t0)		# $t2 has addr of head
    find_nine:
    	beq $t7, $t1, minus_three
    	lw $t5, 0($t2)		# $t5 has num
    	lw $t6, 4($t2)
    	move $t2, $t6
    	addi $t7, $t7, 1
    	li $t3, 0xFF
    	and $t3, $t3, $t5
    	li $t4, 0x39
    	beq $t4, $t3, found_nine
    	b find_nine
    
    found_nine:
        li $t3, 0xFF0000
        and $t3, $t3, $t5
        srl $t3, $t3, 16
        li $t4, 0x75
        bne $t3, $t4, find_nine
    
    
    	move $s1, $t7		# $s1 has index of card 8
    	li $s2, 0x38
    
    	full_straight:
    	li $t0, 0x30
    	sub $t0, $s2, $t0
    	bltz $t0, clear_out
    	move $a0, $s0
    	move $a1, $s1 
    	jal get_card
    	li $t0, 2
    	bne $t0, $v0, minus_three
    	li $t0, 0xFF
    	and $t0, $t0, $v1
    	bne $t0, $s2, minus_three
    	addi $s1, $s1, 1
    	addi $s2, $s2, -1
    	j full_straight
    
    
    clear_out:
    	move $a0, $s0
    	move $a1, $s1 
    	jal get_card
    	li $t0, -1
    	bne $v0, $t0, minus_three
    	
    
    	move $s1, $s0
    	lw $t0, 0($s0)
    	li $t1, 10
    	beq $t1, $t0, case_two
    	sub $t0, $t0, $t1
    	
    	li $t1, 0
    	new_top:
    		beq $t1, $t0, case_one 
    		lw $t2, 4($s0)
    		move $s0, $t2
    		addi $t1, $t1, 1
    		j new_top
    
    case_one:
    sw $t0, 0($s1)
    li $t0, 0
    sw $t0, 4($s0)
    # new stuff here
    lw $t0, 0($s0)
    li $t1, 0xFFFF
    and $t1, $t1, $t0
    li $t0, 0x750000
    or $t0, $t0, $t1
    sw $t0, 0($s0)
    
    li $v0, 1
    j exit_clear
   
    case_two:
    li $t0, 0
    sw $t0, 0($s0)
    sw $t0, 4($s0)
    li $v0, 2
    j exit_clear
    
    minus_three:
    li $v0, -3
    j exit_clear
    
    fewer_than_ten:
    li $v0, -2
    j exit_clear
    
    invalid_col:
    li $v0, -1
    j exit_clear

    exit_clear:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    addi $sp, $sp, 16
    jr $ra

deal_move:
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    
    move $s0, $a0
    move $s1, $a1
    lw $t0, 4($s1)
    move $s3, $t0
    
    li $s2, 9
    dealing_loop:
    	lw $t2, 0($s3)
    	li $t0, 0xFFFF
    	and $t2, $t2, $t0
    	li $t0, 0x75
    	sll $t0, $t0, 16
    	or $t2, $t2, $t0
    	
    	lw $t1, 0($s0)
    	move $a0, $t1
    	move $a1, $t2
    	jal append_card
    	lw $t2, 4($s3)
    	move $s3, $t2
    	addi $s2, $s2, -1
    	addi $s0, $s0, 4
    	beqz $s2, deal_size
    	j dealing_loop
    
    deal_size:
    	lw $t0, 0($s1)
    	addi $t0, $t0, -9
    	sw $t0, 0($s1)
    	sw $s3, 4($s1)
    
    exit_deal_move:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    addi $sp, $sp, 20
    jr $ra

move_card:
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    
    move $s0, $a0			# $s0 has board 
    move $s1, $a1			# $s1 has deck
    move $s2, $a2			# $s2 has move
    
    jal check_move
    blez $v0, illegal_move
    li $t0, 1
    beq $t0, $v0, deal_move_card
    li $t0, 2
    beq $t0, $v0, empty_recip
    li $t0, 3
    beq $t0, $v0, nonempty_recip
    
    deal_move_card:
    move $a0, $s0
    move $a1, $s1
    jal deal_move

    li $s3, 8
    remove_full:
    bltz $s3, done_deal
    move $a0, $s0
    move $a1, $s3
    jal clear_full_straight
    addi $s3, $s3, -1
    j remove_full
    
    empty_recip:
    li $t0, 0xFF00
    and $t1, $s2, $t0
    srl $t1, $t1, 8
    li $t0, 0
    beq $t1, $t0, all_to_empty
    # moving sum to empty
    li $t4, 0xFF0000
    and $t5, $s2, $t4
    srl $t5, $t5, 16
    li $t4, 4
    mul $t4, $t4, $t5
    add $t5, $s0, $t4
    lw $t4, 0($t5)		# t4 recep col list
    
    li $t0, 0xFF
    and $t1, $s2, $t0
    li $t0, 4
    mul $t0, $t0, $t1
    add $t1, $s0, $t0
    lw $t0, 0($t1)		# t0 donor col	
    
    li $t1, 0xFF00
    and $t1, $s2, $t1
    srl $t1, $t1, 8
    
    lw $t3, 0($t0)
    sub $t3, $t3, $t1
    sw $t3, 0($t4)
    
    lw $t6, 0($t0)
    sub $t3, $t6, $t1
    sub $t6, $t6, $t3
    sw $t6, 0($t0)
    
    addi $t1, $t1, -1
    li $t3, 0
    new_top_donor: 
    lw $t5, 4($t0)
    beq $t3, $t1, found_top_donor
    move $t0, $t5
    addi $t3, $t3, 1
    j new_top_donor
    
    found_top_donor:
    lw $t7, 4($t5)
    sw $t7, 4($t4)
    
    lw $t6, 0($t5)
    li $t3, 0xFFFF
    and $t3, $t3, $t6
    li $t6, 0x75
    sll $t6, $t6, 16
    or $t6, $t6, $t3
    sw $t6, 0($t5)
    li $t6, 0
    sw $t6, 4($t5)
    j removing_full_str
    
    nonempty_recip:
    li $t0, 0xFF00
    and $t1, $s2, $t0
    srl $t1, $t1, 8
    li $t0, 0
    beq $t1, $t0, all_to_nonempty
    # moving sum to nonempty
    li $t4, 0xFF0000
    and $t5, $s2, $t4
    srl $t5, $t5, 16
    li $t4, 4
    mul $t4, $t4, $t5
    add $t5, $s0, $t4
    lw $t4, 0($t5)		# t4 recep col list
    
    li $t0, 0xFF
    and $t1, $s2, $t0
    li $t0, 4
    mul $t0, $t0, $t1
    add $t1, $s0, $t0
    lw $t0, 0($t1)
    
    li $t1, 0xFF00
    and $t1, $s2, $t1
    srl $t1, $t1, 8
    
    lw $t3, 0($t0)
    sub $t3, $t3, $t1
    lw $t5, 0($t4)
    add $t5, $t5, $t3
    sw $t5, 0($t4)

    lw $t6, 0($t0)
    sub $t3, $t6, $t1
    sub $t6, $t6, $t3
    sw $t6, 0($t0)

    addi $t1, $t1, -1
    li $t3, 0
    new_top_donor2: 
    lw $t5, 4($t0)
    beq $t3, $t1, found_top_donor2
    move $t0, $t5
    addi $t3, $t3, 1
    j new_top_donor2

    found_top_donor2:
    lw $t7, 4($t5)
    lw $t6, 0($t5)
    li $t3, 0xFFFF
    and $t3, $t3, $t6
    li $t6, 0x75
    sll $t6, $t6, 16
    or $t6, $t6, $t3
    sw $t6, 0($t5)
    li $t6, 0
    sw $t6, 4($t5)
    
    # work here to find last of recp
    
    new_recip:
    lw $t0, 4($t4)
    beqz $t0, found_new_recip
    move $t4, $t0
    j new_recip
    
    found_new_recip:
    sw $t7, 4($t4)
    j removing_full_str
  
  
    all_to_empty:
    li $t0, 0xFF
    and $t1, $s2, $t0
    li $t0, 4
    mul $t0, $t0, $t1
    add $t1, $s0, $t0
    lw $t0, 0($t1)		# addr of donor col
    
    li $t4, 0xFF0000
    and $t5, $s2, $t4
    srl $t5, $t5, 16
    li $t4, 4
    mul $t4, $t4, $t5
    add $t5, $s0, $t4
    lw $t4, 0($t5)
    sw $t0, 0($t5)		
    sw $t4, 0($t1)
    j removing_full_str
    
    all_to_nonempty:
    li $t4, 0xFF0000
    and $t5, $s2, $t4
    srl $t5, $t5, 16
    li $t4, 4
    mul $t4, $t4, $t5
    add $t5, $s0, $t4
    lw $t4, 0($t5)		# addr of recp col
    lw $t7, 0($t4) 		# size of recp col
 
    li $t0, 0xFF
    and $t1, $s2, $t0
    li $t0, 4
    mul $t0, $t0, $t1
    add $t1, $s0, $t0
    lw $t0, 0($t1)		# addr of donor col
    lw $t3, 0($t0)		# num cards moving
    add $t7, $t7, $t3
    sw $t7, 0($t4)
    li $t3, 0
    sw $t3, 0($t0)
    lw $t6, 4($t0)		# addr of donor head
    li $t2, 0
    sw $t2, 4($t0)
    
    top_recip:
    lw $t5, 4($t4)
    beqz $t5, found_top_recip
    move $t4, $t5
    j top_recip
    
    found_top_recip:
    sw $t6, 4($t4)
    j removing_full_str
    	
    
    removing_full_str:
    li $t4, 0xFF0000
    and $t5, $s2, $t4
    srl $t5, $t5, 16
    move $a0, $s0
    move $a1, $t5
    jal clear_full_straight
    j done_deal

    done_deal:
    li $v0, 1
    j exit_move

    illegal_move:
    li $v0, -1
    j exit_move

    exit_move:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    addi $sp, $sp, 20
    jr $ra

load_game:
    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    
    move $s0, $a1		# s0 has board
    move $s1, $a2		# s1 has deck
    move $s2, $a3		# s2 has moves
    
    li $a1, 0
    li $v0, 13
    syscall
    bltz $v0, file_not_found
    move $s3, $v0		# s3 has file discriptor
    
    move $a0, $s1
    jal init_list
    
    read_deck:
    	move $a0, $s3
    	addi $sp, $sp, -4
    	move $a1, $sp
    	li $a2, 1
    	li $v0, 14
    	syscall
    	lb $t0, 0($sp)
    	addi $sp, $sp, 4
    	li $t1, 0x0A
    	beq $t0, $t1, read_moves_start
        li $t1, 0x30
        blt $t0, $t1, read_deck
        li $t1, 0x39
        bgt $t0, $t1, read_deck
        j store_in_deck 
    
    store_in_deck:
    	li $t1, 0x645300
    	or $t0, $t0, $t1
    	move $a0, $s1
    	move $a1, $t0
    	jal append_card
    	j read_deck
    
    
    read_moves_start:
    li $s1, 0
    read_moves:
    	move $a0, $s3
    	addi $sp, $sp, -4
    	move $a1, $sp
    	li $a2, 4
    	li $v0, 14
    	syscall
    	lw $t0, 0($sp)
    	addi $sp, $sp, 4
    	li $t1, 0xFF
    	and $t1, $t1, $t0
    	li $t2, 0x30
    	sub $t1, $t1, $t2
    	li $t3, 0xFF00
    	and $t3, $t3, $t0
    	srl $t3, $t3, 8
    	sub $t3, $t3, $t2
    	sll $t3, $t3, 8
    	or $t1, $t1, $t3
    	li $t3, 0xFF0000
    	and $t3, $t3, $t0
    	srl $t3, $t3, 16
    	sub $t3, $t3, $t2
    	sll $t3, $t3, 16
    	or $t1, $t1, $t3
    	li $t3, 0xFF000000
    	and $t3, $t3, $t0
    	srl $t3, $t3, 24
    	sub $t3, $t3, $t2
    	sll $t3, $t3, 24
    	or $t1, $t1, $t3
    	
    	
    	sw $t1, 0($s2)
    	addi $s2, $s2, 4
    	addi $s1, $s1, 1
    	move $a0, $s3
    	addi $sp, $sp, -4
    	move $a1, $sp
    	li $a2, 1
    	li $v0, 14
    	syscall
    	lb $t0, 0($sp)
    	li $t1, 0x0A
    	addi $sp, $sp, 4
    	beq $t0, $t1, initing_board
    	j read_moves
    	
    	
    initing_board:	
    	li $s2, 8
    	move $s4, $s0
    	loop_board_init:
    	bltz $s2, read_board
    	lw $a0, 0($s4)
    	jal init_list
    	addi $s2, $s2, -1
    	addi $s4, $s4, 4
    	j loop_board_init
    
    read_board:
    	move $s4, $s0
    	read_board_loop:
    	move $a0, $s3
    	addi $sp, $sp, -4
    	move $a1, $sp
    	li $a2, 1
    	li $v0, 14
    	syscall
    	lb $t0, 0($sp)
    	addi $sp, $sp, 4
    	li $t1, 0x20
    	beq $t0, $t1, next_column
    	li $t1, 0x0A
    	beq $t0, $t1, next_row
    	j load_face
    
    load_face:
    	move $a0, $s3
    	addi $sp, $sp, -4
    	move $a1, $sp
    	li $a2, 1
    	li $v0, 14
    	syscall
    	lb $t2, 0($sp)
    	addi $sp, $sp, 4
    	j store_board_rows
    		
    				
    next_column:
    	move $a0, $s3
    	addi $sp, $sp, -4
    	move $a1, $sp
    	li $a2, 1
    	li $v0, 14
    	syscall
    	addi $sp, $sp, 4
    	addi $s4, $s4, 4
    	j read_board_loop
    	
    store_board_rows:
    	li $t1, 0x5300
    	or $t0, $t0, $t1
    	sll $t2, $t2, 16
    	or $t0, $t0, $t2
    	lw $a0, 0($s4)
    	move $a1, $t0
    	jal append_card
    	addi $s4, $s4, 4
    	j read_board_loop
    
    next_row:
    	beqz $v0, finalizing
    	move $s4, $s0
    	j read_board_loop		
    	
    finalizing:
    	move $a0, $s3
    	li $v0, 16
    	syscall
    	li $v0, 1
    	move $v1, $s1
    	j exit_load
    
    file_not_found:
    li $v0, 16
    move $a0, $s3
    syscall
    li $v0, -1			
    li $v1, -1
    j exit_load
    
    exit_load:
    	lw $ra, 0($sp)
    	lw $s0, 4($sp)
    	lw $s1, 8($sp)
    	lw $s2, 12($sp)
    	lw $s3, 16($sp)	
    	lw $s4, 20($sp)
    	addi $sp, $sp, 24
   	jr $ra

simulate_game:
    addi $sp, $sp, -36
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12 ($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24 ($sp)
    sw $s6, 28 ($sp)
    sw $s7, 32 ($sp)
    
    move $s0, $a1		# s0 has board
    move $s1, $a2		# s1 has deck
    move $s2, $a3		# s2 has moves[]
    
    jal load_game
    li $t0, -1
    beq $v0, $t0, invalid_simulate
    move $s3, $v1		# s3 has num moves
    
    li $s5, 0	
    
    move $s6, $s0
    move $s7, $s6
    li $s4, 0
    exceuting_moves:
    	move $a0, $s0
    	move $a1, $s1
    	lw $a2, 0($s2)
    	jal move_card
    	addi $s4, $s4, 1
    	li $t0, -1
    	beq $v0, $t0, invalid_dec
    	addi $s5, $s5, 1
    	won_or_not:
    	lw $t0, 0($s1)
    	bnez $t0, continue_moves
    	li $t0, 8
    	empty_board:
    	beqz $t0, won_game
    	addi $t0, $t0, -1
    	lw $t1, 0($s6)
    	lw $t2, 0($t1)
    	bnez $t2, continue_moves
    	addi $s6, $s6, 4
    	b empty_board
    	
    	continue_moves:
    	move $s6, $s7
    	addi $s2, $s2, 4
    	beq $s4, $s3, game_lost
    	j exceuting_moves

    invalid_dec:
    	addi $s2, $s2, 4
    	beq $s4, $s3, game_lost
	j exceuting_moves
	
    game_lost:
    	move $v0, $s5
    	li $v1, -2
    	j exit_simulate

    won_game:
   	move $v0, $s5
    	li $v1, 1
    	j exit_simulate

    invalid_simulate:
    li $v0, -1
    li $v1, -1

    exit_simulate:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12 ($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24 ($sp)
    lw $s6, 28 ($sp)
    lw $s7, 32 ($sp)
    addi $sp, $sp, 36
    jr $ra

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
