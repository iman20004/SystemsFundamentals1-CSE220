# Iman Ali
# imaali
# 112204305

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

.text
load_game:
    move $t0, $a0		# $t0 has game state
    move $t1, $a1		# $t1 has filename
    
    move $a0, $t1		# address of file as first arg
    li $a1, 0			# flag as read only
    li $v0, 13			# open file
    syscall
    move $t5, $v0		# make a copy of file descriptor
    bltz $v0, file_not_found	# if negative file descriptor, then exit
    
    addi $sp, $sp, -12		# allocate space on the stack
    sw $s0, 0($sp)		# preserve $s0, $s1, $s2 on stack
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    
    move $s2, $t0		# make another copy of game state in $s2
    addi $s2, $s2, 5		# $s2 is now address of the grid
    
    
    li $s0, 0			# initialize value for final $v0
    li $s1, 0			# initialize value for final $v1
    li $t7, 0			# initliaze value for num rows
    li $t6, 0			# initliaze value for num columns
    
    setup_read:
    	move $a0, $v0		# first arg as file descriptor
    	addi $sp, $sp, -4	# make space for values being read
    	move $a1, $sp		# second arg is input buffer
    	li $a2, 1		# read max 1 char at a time
  
    	
    read_num_rows:
    	li $v0, 14			# read from file
    	syscall
    	lw $t1, 0($sp)			# load first char
    	li $t2, 0x0A			# '\n' in $t2
    	beq $t1, $t2, store_num_rows	# '\n' found, so stop reading
    	li $t2, 0x0D			# '\r' in $t2
    	beq $t1, $t2, read_num_rows	# ignore and read next char '\n'
    	addi $t1, $t1, -48		# convert hex to decimal
    	li $t3, 10			
    	mul $t7, $t7, $t3		# convert to digits place
    	add $t7, $t7, $t1		# add units place
    	j read_num_rows
   
    store_num_rows:
    	sb $t7, 0($t0)			# store num rows in byte 0 of gamestate

    read_col_rows:			# repeat same process for num columns
    	li $v0, 14
    	syscall
    	lw $t1, 0($sp)
    	li $t2, 0x0A
    	beq $t1, $t2, store_col_rows
    	li $t2, 0x0D
    	beq $t1, $t2, read_col_rows
    	addi $t1, $t1, -48
    	li $t3, 10
    	mul $t6, $t6, $t3
    	add $t6, $t6, $t1
    	j read_col_rows
   
    store_col_rows:
    	addi $t0, $t0, 1		# $t6 has num columns
    	sb $t6, 0($t0)
   
   li $t4, 0				# row counter
   li $t3, 0				# column counter
   li $t6, 0x31			        # length	
    load_game_loop:
    	beq $t4, $t7, exit_load_game_loop
    	li $v0, 14
    	syscall
    	lw $t1, 0($sp)
    	li $t2, 0x0A
    	beq $t1, $t2, next_row
    	li $t2, 0x0D
    	beq $t1, $t2, load_game_loop
    	li $t2, 0x2E
    	beq $t1, $t2, next_col
    	li $t2, 'a'
    	beq $t1, $t2, store_apple
    	li $t2, 0x23
    	beq $t1, $t2, store_hash
    	li $t2, 0x31
    	beq $t1, $t2, store_head
    	j update_length
    	
    next_col:
    	addi $t3, $t3, 1
    
    store_into_grid:
    	sb $t1, 0($s2)
    	addi $s2, $s2, 1
    	j load_game_loop
    	
    next_row:
    	addi $t4, $t4, 1
    	li $t3, 0
    	j load_game_loop
    	
    	
    store_apple:
    	li $s0, 1
    	j next_col
    	
    store_hash:
    	addi $s1, $s1, 1
    	j next_col
    	
    store_head:
    	addi $t0, $t0, 1
    	sb $t4, 0($t0)
    	addi $t0, $t0, 1
    	sb $t3, 0($t0)
    	j next_col
    	
    update_length:
    	addi $t6, $t6, 1
    	j next_col
    	
    
    exit_load_game_loop:
    	li $v0, 16
    	move $a0, $t5
    	syscall
    	li $t1, 0
    	sb $t1, 0($s2)
    	addi $t0, $t0, 1
    	addi $t6, $t6, -48
    	sb $t6, 0($t0)
    	move $v0, $s0
    	move $v1, $s1
    	addi $sp, $sp, 4
    	lw $s0, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	addi $sp, $sp, 12
    	j exit_load_game
    
    file_not_found:
    	li $v0, -1			# initialize v1 with file does not exist
    	li $v1, -1

    exit_load_game:
    	jr $ra

get_slot:
     lbu $t0, 0($a0)			# $t0 has num rows
     lbu $t1, 1($a0)			# $t1 has num columns
     li $v0, -1
     
     li $t2, 0
     blt $a1, $t2, exit_get_slot
     blt $a2, $t2, exit_get_slot
     
     addi $t0, $t0, -1
     addi $t1, $t1, -1
     bgt $a1, $t0, exit_get_slot
     bgt $a2, $t1, exit_get_slot
     
     addi $t0, $t0, 1
     addi $t1, $t1, 1
     
     move $t4, $a0
     addi $t4, $t4, 5
     
     li $t2, 0
     li $t6, 0
     row_loop:
     	beq $t2, $a1, col_loop
     	add $t4, $t4, $t1
     	addi $t2, $t2, 1
     	b row_loop
     
     col_loop:
     	beq $t6, $a2, get_char
     	addi $t6, $t6, 1
     	addi $t4, $t4, 1
     	b col_loop
     	
     get_char:
     	lb $t7, 0($t4)
     	move $v0, $t7
     
    exit_get_slot:
    	jr $ra

set_slot:
     lbu $t0, 0($a0)			# $t0 has num rows
     lbu $t1, 1($a0)			# $t1 has num columns
     li $v0, -1
     
     li $t2, 0
     blt $a1, $t2, exit_set_slot
     blt $a2, $t2, exit_set_slot
     
     addi $t0, $t0, -1
     addi $t1, $t1, -1
     bgt $a1, $t0, exit_set_slot
     bgt $a2, $t1, exit_set_slot
     
     addi $t0, $t0, 1
     addi $t1, $t1, 1
     
     move $t4, $a0
     addi $t4, $t4, 5
     
     li $t2, 0
     li $t6, 0
     row_loop1:
     	beq $t2, $a1, col_loop2
     	add $t4, $t4, $t1
     	addi $t2, $t2, 1
     	b row_loop1
     
     col_loop2:
     	beq $t6, $a2, set_char
     	addi $t6, $t6, 1
     	addi $t4, $t4, 1
     	b col_loop2
     	
     set_char:
     	sb $a3, 0($t4)
     	move $v0, $a3
    
     exit_set_slot:
    	jr $ra

place_next_apple:
    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp) 
    sw $s4, 16($sp)
    sw $s5, 20($sp)
    
    move $s1, $a0		# $s1 has game state
    move $s2, $a1		# $s2 has apples array
    move $s3, $a2		# $s3 has apples length
    
    apple_loop:
    	lbu $s4, 0($s2)
    	lbu $s5, 1($s2)
    	addi $s2, $s2, 2
    	li $t0, -1
    	beq $s4, $t0, apple_loop
    	beq $s5, $t0, apple_loop
    	move $a0, $s1
    	move $a1, $s4
    	move $a2, $s5
    	jal get_slot
    	move $t3, $v0
    	li $t4, 0x2E
    	beq $t3, $t4, place_apple
    	j apple_loop
    	
    place_apple:
    	move $a0, $s1
    	move $a1, $s4
    	move $a2, $s5
    	li $a3, 0x61
    	jal set_slot
    	
    update_apples_array:
    	addi $s2, $s2, -2
    	li $t7, -1
    	sb $t7, 0($s2)
    	sb $t7, 1($s2)
    

    exit_apple:
    	move $v0, $s4
    	move $v1, $s5
    	lw $ra, 0($sp)
    	lw $s1, 4($sp)
    	lw $s2, 8($sp)
    	lw $s3, 12($sp) 
    	lw $s4, 16($sp)
    	lw $s5, 20($sp) 
    	addi $sp, $sp, 24
    	jr $ra

find_next_body_part:
    li $v0, -1
    li $v1, -1

    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp) 
    sw $s4, 16($sp)
    sw $s5, 20($sp)
    
    move $s1, $a0			# $s1 has game state
    move $s2, $a1			# $s2 has row num
    move $s3, $a2			# $s3 has col num
    move $s4, $a3			# $s4 has target char
    
    lbu $t0, 0($s1)			# $t0 has num rows
    lbu $t1, 1($s1)			# $t1 has num columns
     
    li $t2, 0
    blt $s2, $t2, exit_next_body
    blt $s3, $t2, exit_next_body
     
    addi $t0, $t0, -1
    addi $t1, $t1, -1
    bgt $s2, $t0, exit_next_body
    bgt $s3, $t1, exit_next_body
    
    addi $s5, $s3, -1
    move $a0, $s1
    move $a1, $s2
    move $a2, $s5
    jal get_slot
    
    beq $v0, $s4, found_target
    
    addi $s5, $s3, 1
    move $a0, $s1
    move $a1, $s2
    move $a2, $s5
    jal get_slot
    
    beq $v0, $s4, found_target
    
    addi $s5, $s2, -1
    move $a0, $s1
    move $a1, $s5
    move $a2, $s3
    jal get_slot
    
    beq $v0, $s4, found_target1
    
    addi $s5, $s2, 1
    move $a0, $s1
    move $a1, $s5
    move $a2, $s3
    jal get_slot
    
    beq $v0, $s4, found_target1
    j target_not_found
    
    found_target:
    	move $v0, $s2
    	move $v1, $s5
    	j exit_next_body
    
    found_target1:
    	move $v0, $s5
    	move $v1, $s3
    	j exit_next_body
    	
    target_not_found:
    	li $v0, -1
    	li $v1, -1
    
    exit_next_body:
    	lw $ra, 0($sp)
    	lw $s1, 4($sp)
   	lw $s2, 8($sp)
    	lw $s3, 12($sp) 
    	lw $s4, 16($sp)
    	lw $s5, 20($sp)
    	addi $sp, $sp, 24
    	jr $ra

slide_body:
    lw $t0, 0($sp)
	
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
   
    move $s0, $a0		# $s0 has game state
    move $s1, $a1		# $s1 has row delta
    move $s2, $a2		# $s2 has col delta
    move $s3, $a3		# $s3 has apples array
    move $s4, $t0		# $s4 has apples length
    
    lbu $s5, 2($s0) 		# snake head row position 
    lbu $s6, 3($s0) 		# snake head col position
    
    add $s1, $s5, $s1
    add $s2, $s6, $s2
    
    move $a0, $s0
    move $a1, $s1
    move $a2, $s2
    jal get_slot
    move $t0, $v0
    
    li $t1, 0x2E
    li $t2, 0x61
    beq $t0, $t1, slide_snake
    beq $t0, $t2, apple_case
    j snake_no_slither
    
    apple_case:
    	move $a0, $s0
    	move $a1, $s3
    	move $a2, $s4
    	jal place_next_apple
    	li $s7, 1
    	j slither_snake
    	
    slide_snake:
    	li $s7, 0
    	j slither_snake
    
    slither_snake:
    	move $a0, $s0
    	move $a1, $s1
    	move $a2, $s2
    	li $a3, 0x31
    	jal set_slot
    	sb $s1, 2($s0)
    	sb $s2, 3($s0)
    	
    	
    	
    	li $s1, 0x32
    	li $s2, 2
    	slide_loop:
    		lbu $t2, 4($s0)
    		bgt $s2, $t2, place_last
    		move $a0, $s0
    		move $a1, $s5
    		move $a2, $s6
    		move $a3, $s1
    		jal find_next_body_part
    		move $s3, $v0
    		move $s4, $v1
    		
    		move $a0, $s0
    		move $a1, $s5
    		move $a2, $s6
    		move $a3, $s1
    		jal set_slot
    		
    		move $s5, $s3
    		move $s6, $s4
    		li $t6, 0x39
    		beq $s1, $t6, alpha_length
    		addi $s1, $s1, 1
    		addi $s2, $s2, 1
    		j slide_loop
    	
    alpha_length:
    	li $s1, 0x41
    	addi $s2, $s2, 1
    	j slide_loop
    	
    place_last:
    	move $a0, $s0
    	move $a1, $s5
    	move $a2, $s6
    	li $a3, 0x2E
    	jal set_slot
    	j exit_slide_body
    	
    
    snake_no_slither:
    li $s7, -1	
    j exit_slide_body

    exit_slide_body:
    move $v0, $s7
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

add_tail_segment:
    addi $sp, $sp, -28
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp) 
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    
    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    move $s3, $a3
    
    lb $s4, 4($s0)
    li $t0, 35
    beq $s4, $t0, couldnt_add
    move $a0, $s0
    move $a1, $s2
    move $a2, $s3
    jal get_slot
    move $s5, $v0
    
    li $t1, 'U'
    li $t2, 'D'
    li $t3, 'L'
    li $t4, 'R'
    beq $s1, $t1, add_up
    beq $s1, $t2, add_down
    beq $s1, $t3, add_left
    beq $s1, $t4, add_right
    b couldnt_add
    
    add_up:
    	li $t0, -1
    	li $t2, 0
    	j add_tail
    	
    add_down:
    	li $t0, 1
    	li $t2, 0
    	j add_tail
    
    add_left:
    	li $t0, 0
    	li $t2, -1
    	j add_tail
    	
    add_right:
    	li $t0, 0
    	li $t2, 1
    	j add_tail
    	
    add_tail:
    	add $s2, $s2, $t0
    	add $s3, $s3, $t2
    	
    	move $a0, $s0
    	move $a1, $s2
    	move $a2, $s3	
    	jal get_slot
    	move $s1, $v0
    	
    	li $t0, 0x2E
    	bne $s1, $t0, couldnt_add
    	
    	addi $s5, $s5, 1
    	move $a0, $s0
    	move $a1, $s2
    	move $a2, $s3
    	move $a3, $s5
    	jal set_slot
    	
    	addi $s4, $s4, 1
    	sb $s4, 4($s0)
    	
    	lb $v0, 4($s0)
    	j exit_add_tail
    
    couldnt_add:
    li $v0, -1
    j exit_add_tail
    
    exit_add_tail:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp) 
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    addi $sp, $sp, 28
    jr $ra

increase_snake_length:
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
    
    move $s0, $a0
    move $s1, $a1
    
    li $t1, 'U'
    li $t2, 'D'
    li $t3, 'L'
    li $t4, 'R'
    beq $s1, $t1, head_moving_up
    beq $s1, $t2, head_moving_down
    beq $s1, $t3, head_moving_left
    beq $s1, $t4, head_moving_right
    b couldnt_increase
    
    head_moving_up:
    	li $s7, 'D'
    	j find_tail
    	
    head_moving_down:
    	li $s7, 'U'
    	j find_tail
    	
    head_moving_left:
    	li $s7, 'R'
    	j find_tail
    	
    head_moving_right:
    	li $s7, 'L'
    	j find_tail
    	
    find_tail:
    	lb $s1, 2($s0)		# head row
    	lb $s2, 3($s0)		# head col
    	li $s6, 0x32
    
    	find_tail_loop:
    		move $a0, $s0
    		move $a1, $s1
    		move $a2, $s2
    		move $a3, $s6
    		jal find_next_body_part
    		li $t6, -1
    		beq $v0, $t6, found_tail
    		move $s1, $v0
    		move $s2, $v1
    		li $t7, 0x39
    		beq $s6, $t7, alpha_chars
    		addi $s6, $s6, 1
    		j find_tail_loop
    		
    	alpha_chars:
    		li $s6, 0x41
    		j find_tail_loop
    
    	found_tail:
    	li $s4, 0
    	li $s5, 4
    	found_tail_loop:
    		beq $s4, $s5, couldnt_increase
    		move $a0, $s0
    		move $a1, $s7
    		move $a2, $s1
    		move $a3, $s2
    		jal add_tail_segment
    		li $t7, -1
    		bne $v0, $t7, exit_inc_length
    		li $t1, 'U'
    		li $t2, 'D'
    		li $t3, 'L'
    		li $t4, 'R'
    		addi $s4, $s4, 1
    		beq $s7, $t1, check_left
    		beq $s7, $t2, check_right
    		beq $s7, $t3, check_down
    		beq $s7, $t4, check_up
    	
    	check_left:
    		li $s7, 'L'
    		j found_tail_loop
    	
    	check_right:
    		li $s7, 'R'
    		j found_tail_loop
    		
    	check_down:
    		li $s7, 'D'
    		j found_tail_loop
    		
    	check_up:
    		li $s7, 'U'
    		j found_tail_loop
    		
    
    couldnt_increase:
    	li $v0, -1
    	j exit_inc_length

    exit_inc_length:
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

move_snake:
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
    
    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    move $s3, $a3
    
    li $t1, 'U'
    li $t2, 'D'
    li $t3, 'L'
    li $t4, 'R'
    beq $s1, $t1, move_up
    beq $s1, $t2, move_down
    beq $s1, $t3, move_left
    beq $s1, $t4, move_right
    b couldnt_move
    
    move_up:
    	li $s4, -1
    	li $s5, 0
    	j snake_sliding
    	
    move_down:
    	li $s4, 1
    	li $s5, 0
    	j snake_sliding
    
    move_left:
    	li $s4, 0
    	li $s5, -1
    	j snake_sliding
    	
    move_right:
    	li $s4, 0
    	li $s5, 1
    	j snake_sliding
    
    snake_sliding:
    	move $a0, $s0
    	move $a1, $s4
    	move $a2, $s5
    	move $a3, $s2
    	addi $sp, $sp, -4
    	sw $s3, 0($sp)
    	jal slide_body
    	addi $sp, $sp, 4
    	li $t7, -1
    	beq $v0, $t7, couldnt_move
    	li $t6, 1
    	beq $v0, $t6, success_apple
    	li $v0, 0
    	li $v1, 1
    	j exit_move_snake
    	
    success_apple:
    	move $a0, $s0
    	move $a1, $s1
    	jal increase_snake_length
    	li $t7, -1
    	beq $v0, $t7, couldnt_move
    	li $v0, 100
    	li $v1, 1
    	j exit_move_snake
    
    couldnt_move:
    li $v0, 0
    li $v1, -1
    j exit_move_snake

    exit_move_snake:
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

simulate_game:
    lw $t0, 0($sp)
    lw $t1, 4($sp)

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
    
    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    move $s3, $a3
    move $s4, $t0
    move $s5, $t1
    
    move $a0, $s0
    move $a1, $s1
    jal load_game
    li $t0, -1
    beq $v0, $t0, couldnt_simulate
    li $t0, 0
    beq $v0, $t0, no_apple
    j continue_simulating
    
    no_apple:
    	move $a0, $s0
    	move $a1, $s4
    	move $a2, $s5
    	jal place_next_apple 
    	j continue_simulating
    	
    continue_simulating:
    	li $s6, 0		# score counter
    	li $s7, 0		# loop counter
    	simulating_loop:
    		beqz $s3, exit_loop 		# checking num moves is not zerp
    		lb $t1, 4($s0)			# length of snake
    		li $t0, 35
    		beq $t1, $t0, exit_loop 	# max length of snake
    		lb $s1, 0($s2)			# direction
    		beqz $s1, exit_loop		# direction = 0
    		j game_loop
   
   	game_loop:
   		move $a0, $s0
   		move $a1, $s1
   		move $a2, $s4
   		move $a3, $s5
   		jal move_snake
   		li $t0, 100
   		beq $v0, $t0, add_score
   		li $t0, -1
   		beq $v1, $t0, exit_loop
   		
   		addi $s3, $s3, -1		# decr num moves
   		addi $s2, $s2, 1		# for next direction
   		addi $s7, $s7, 1
    		j simulating_loop
    	
    add_score:
    	lb $t0, 4($s0)
    	addi $t0, $t0, -1
    	mul $v0, $v0, $t0
    	add $s6, $s6, $v0
    	addi $s3, $s3, -1		# decr num moves
   	addi $s2, $s2, 1		# for next direction
    	addi $s7, $s7, 1
    	j simulating_loop
    
    exit_loop:
    	move $v0, $s7
    	move $v1, $s6
    	j exit_simulate_game
    	
    
    couldnt_simulate:
    	li $v0, -1
    	li $v1, -1
    	j exit_simulate_game 

    exit_simulate_game:
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

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
