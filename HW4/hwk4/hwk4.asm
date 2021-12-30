# Iman Ali
# imaali
# 112204305

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

.text
memcpy:
    li $t0, 0
    ble $a2, $t0, invalid_n
    
    memcpy_loop:
    	beq $t0, $a2, valid_n
    	lbu $t1, 0($a1)
    	sb $t1, 0($a0)
    	addi $a0, $a0, 1
    	addi $a1, $a1, 1
    	addi $t0, $t0, 1
    	j memcpy_loop

    valid_n:
    move $v0, $a2
    j exit_memcpy

    invalid_n:
    li $v0, -1
    j exit_memcpy

    exit_memcpy:
    jr $ra

strcmp:

    lbu $t0, 0($a0)
    lbu $t1, 0($a1)
    beqz $t0, str1_empty
    beqz $t1, str1_length
    
    compare_strings:
    	bne $t0, $t1, char_diff
    	beqz $t0, identical_strs
    	addi $a0, $a0, 1
    	addi $a1, $a1, 1
    	lbu $t0, 0($a0)
    	lbu $t1, 0($a1)
    	b compare_strings
    	
    char_diff:
    	sub $v0, $t0, $t1
    	j exit_strcmp
    	
    str1_empty:
    	beqz $t1, identical_strs
    	j str2_length
    	
    str1_length:
    	addi $v0, $v0, 1
    	addi $a0, $a0, 1
    	lbu $t0, 0($a0)
    	beqz $t0, exit_strcmp
    	j str1_length
    	
    str2_length:
    	addi $v0, $v0, -1
    	addi $a1, $a1, 1
    	lbu $t1, 0($a1)
    	beqz $t1, exit_strcmp
    	j str2_length
    	
    identical_strs:
    	li $v0, 0
    	j exit_strcmp

    exit_strcmp:
    jr $ra

initialize_hashtable:
    li $t0, 1
    blt $a1, $t0, minus1_case
    blt $a2, $t0, minus1_case
    li $v0, 0
    
    sw $a1, 0($a0)
    addi $a0, $a0, 4
    sw $v0, 0($a0)
    addi $a0, $a0, 4
    sw $a2, 0($a0)
    addi $a0, $a0, 4
    
    li $t1, 0
    mul $t1, $a1, $a2
    li $t0, 0
    init_loop:
    	beq $t0, $t1, exit_initialize 
    	sb $v0, 0($a0)
    	addi $a0, $a0, 1
    	addi $t0, $t0, 1
    	b init_loop
    

    minus1_case:
    	li $v0, -1
    	j exit_initialize

    exit_initialize:
    jr $ra

hash_book:
    lw $t0, 0($a0)
    
    li $t1, 0
    sum_isbn:
    	lbu $t2, 0($a1)
    	beqz $t2, mod_func
    	add $t1, $t1, $t2
    	addi $a1, $a1, 1
    	j sum_isbn
    	
    mod_func:
    	blt $t1, $t0, isbn_remainder
    	sub $t1, $t1, $t0
    	j mod_func
    
    isbn_remainder:
    move $v0, $t1

    exit_hash_book:
    jr $ra

get_book:
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
    
    move $s0, $a0		# hashtable books
    move $s1, $a1		# isbn

    move $a0, $s0
    move $a1, $s1
    jal hash_book
    move $s3, $v0		# first index checked
   
    lw $s7, 8($s0)		# elem size 
    lw $s2, 0($s0)		# capacity
    addi $s5, $s2, -1		# index to start from
    li $t0, 0
    mul $t0, $s3, $s7	
    addi $s0, $s0, 12		# starting address of elements
    move $s6, $s0		# make copy for wrap around
    add $s0, $s0, $t0
    
    li $s4, 0			# num elements checked ($v1)
    probing:
    	lbu $t0, 0($s0)
    	beqz $t0, no_book	# empty
    	li $t1, 0xFF
    	beq $t0, $t1, skip_deleted
    	move $a0, $s1
    	move $a1, $s0
    	jal strcmp
    	addi $s4, $s4, 1
    	beqz $v0, found_target
    	beq $s4, $s2, not_found
    	beq $s3, $s5, wrap_around
    	addi $s3, $s3, 1
    	add $s0, $s0, $s7
    	j probing
    	
    no_book:
    	li $v0, -1
    	addi $s4, $s4, 1
    	move $v1, $s4
    	j exit_get_book
    
   skip_deleted:
   	add $s0, $s0, $s7
   	addi $s4, $s4, 1
   	beq $s3, $s5, wrap_around
    	addi $s3, $s3, 1
   	j probing
   	
   wrap_around:
   	move $s0, $s6
   	li $s3, 0
   	j probing
    		
   found_target:
   	move $v0, $s3
   	move $v1, $s4
   	j exit_get_book
   
   not_found:
   	li $v0, -1
   	move $v1, $s4

    exit_get_book:
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

add_book:
    addi $sp, $sp, -32
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    sw $s6, 28($sp)
    
    
    move $s0, $a0		# hashtable books
    move $s1, $a1		# isbn
    move $s2, $a2		# title 
    move $s3, $a3		# author
    
    lw $t6, 0($s0)		# capacity
    lw $t7, 4($s0)		# size
    beq $t6, $t7, table_full	# checking if table full
    
    move $a0, $s0
    move $a1, $s1
    jal get_book		# checking if book already present
    li $t2, -1
    bne $v0, $t2, exit_add_book
    
    move $a0, $s0
    move $a1, $s1
    jal hash_book
    move $s4, $v0		# value for $v0
    
    addi $s6, $s0, 12
    lw $t0, 8($s0)		# elem size
    mul $v0, $v0, $t0
    add $s6, $s6, $v0		# where to place book
    
    li $s5, 0			# value for $v1
    
    probing_add:
    	lbu $t0, 0($s6)
    	li $t1, 0x39
    	addi $s5, $s5, 1
    	beq $t0, $t1, next_index
    	move $a0, $s6
    	move $a1, $s1
    	li $a2, 13
    	jal memcpy
    	add $s6, $s6, $v0
    	li $t0, '\0'
    	sb $t0, 0($s6)
    	addi $s6, $s6, 1
    	
    	add_title:
    	li $t0, 0
    	title_length:
    		lbu $t1, 0($s2)
    		beqz $t1, found_n
    		addi $s2, $s2, 1
    		addi $t0, $t0, 1
    		j title_length
    		
    	found_n:
    		sub $s2, $s2, $t0
    		li $t1, 24
    		bgt $t0, $t1, only_first24
    		move $a0, $s6
    		move $a1, $s2
    		move $a2, $t0
    		jal memcpy
    		add $s6, $s6, $v0
    		li $t0, 25
    		sub $t0, $t0, $v0
    		li $t1, 0
    		li $t2, '\0'
    		add_terminators:
    			beq $t1, $t0, add_author
    			sb $t2, 0($s6)
    			addi $s6, $s6, 1
    			addi $t1, $t1, 1
    			b add_terminators
    			
    		only_first24:
    			move $a0, $s6
    			move $a1, $s2
    			move $a2, $t1
    			jal memcpy
    			add $s6, $s6, $v0
    			li $t2, '\0'
    			sb $t2, 0($s6)
    			addi $s6, $s6, 1
    			
    	add_author:
    		li $t0, 0
    	author_length:
    		lbu $t1, 0($s3)
    		beqz $t1, found_length
    		addi $s3, $s3, 1
    		addi $t0, $t0, 1
    		j author_length	
    		
    	found_length:
    		sub $s3, $s3, $t0
    		li $t1, 24
    		bgt $t0, $t1, only_first
    		move $a0, $s6
    		move $a1, $s3
    		move $a2, $t0
    		jal memcpy
    		add $s6, $s6, $v0
    		li $t0, 25
    		sub $t0, $t0, $v0
    		li $t1, 0
    		li $t2, '\0'
    		add_terminators2:
    			beq $t1, $t0, times_sold
    			sb $t2, 0($s6)
    			addi $s6, $s6, 1
    			addi $t1, $t1, 1
    			b add_terminators2
    			
    		only_first:
    			move $a0, $s6
    			move $a1, $s3
    			move $a2, $t1
    			jal memcpy
    			add $s6, $s6, $v0
    			li $t2, '\0'
    			sb $t2, 0($s6)
    			addi $s6, $s6, 1
    			
    	times_sold:
    		li $t0, 0
    		sw $t0, 0($s6)
    		
    	success_add:
    		lw $t0, 4($s0)
    		addi $t0, $t0, 1
    		sw $t0, 4($s0)
    		move $v0, $s4
    		move $v1, $s5
    		j exit_add_book
    
    
    next_index:
    	lw $t0, 8($s0)
    	lw $t1, 0($s0)
    	addi $t1, $t1, -1
    	beq $s4, $t1, wrapping
    	add $s6, $s6, $t0
    	addi $s4, $s4, 1
    	j probing_add
    	
    wrapping:
    	move $s6, $s0
    	li $s4, 0
    	j probing_add
    	
    
    table_full:
    	li $v0, -1
    	li $v1, -1
    	j exit_add_book

    exit_add_book:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    lw $s6, 28($sp)
    addi $sp, $sp, 32
    jr $ra

delete_book:	
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    
    move $s0, $a0
    
    move $a0, $s0
    jal get_book
    li $t0, -1
    beq $v0, $t0, no_book_found
    
    addi $t0, $s0, 12
    lw $t1, 8($s0)
    mul $t2, $v0, $t1
    add $t0, $t0, $t2
    
    li $t3, 0
    deleting:
    	beq $t3, $t1, success_deleting
    	li $t4, 0xFF
    	sb $t4, 0($t0)
    	addi $t0, $t0, 1
    	addi $t3, $t3, 1
    	j deleting
    
    success_deleting:
    	lw $t5, 4($s0)
    	addi $t5, $t5, -1
    	sw $t5, 4($s0)
    	j exit_delete_book
    
    no_book_found:
    	li $v0, -1
    	j exit_delete_book

    exit_delete_book:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    addi $sp, $sp, 8
    jr $ra

hash_booksale:
    lw $t0, 0($a0)
    li $t1, 0
    
    sum_isbnsale:
    	lbu $t2, 0($a1)
    	beqz $t2, sum_id
    	add $t1, $t1, $t2
    	addi $a1, $a1, 1
    	j sum_isbnsale
    	
    sum_id:
    	move $t7, $a2
    
    mod_function:
    	li $t3, 10
    	div $t7, $t3
    	mflo $t5
    	mfhi $t6
    	add $t1, $t1, $t6
    	move $t7, $t5
    	beqz $t5, mod_capacity
    	j mod_function
    
    mod_capacity:
    	div $t1, $t0
    	mfhi $v0	 
    
    exit_hash_booksale:
    jr $ra

is_leap_year:
    li $t7, 0
    li $t1, 1582
    blt $a0, $t1, error_case
    
    divisble_by4:
    li $t1, 4 
    div $a0, $t1            	
    mfhi $t1                	
    bne $t1, $0, normal_year  

    century_year:
    li $t1, 100 
    div $a0, $t1           
    mfhi $t1               	
    bne $t1, $0, leap_year
    
    notdivisble_by400:
    li $t1, 400 
    div $a0, $t1           	 
    mfhi $t1               		 
    bne $t1, $0, normal_year
    
    leap_year:
    	beqz $t7, given_leap
    	move $v0, $t7
    	j exit_leap
    
     normal_year:
    	addi $a0, $a0, 1
    	addi $t7, $t7, -1
    	j divisble_by4
    
    error_case:
    	li $v0, 0
    	j exit_leap
 
    given_leap:
    	li $v0, 1
    	j exit_leap

    exit_leap:
    jr $ra

datestring_to_num_days:
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
    li $s2, 0
    li $s5, 0
    

    lb $t0, 0($a0)
    li $t1, '0'
    sub $t0, $t0, $t1
    li $t1, 100
    mul $t0, $t0, $t1
    li $t1, 10
    mul $t0, $t0, $t1
    lb $t1, 1($a0)
    li $t2, '0'
    sub $t1, $t1, $t2
    li $t2, 100
    mul $t1, $t1, $t2
    add $t0, $t0, $t1
    lb $t1, 2($a0)
    li $t2, '0'
    sub $t1, $t1, $t2
    li $t2, 10
    mul $t1, $t1, $t2
    add $t0, $t0, $t1
    lb $t1, 3($a0)
    li $t2, '0'
    sub $t1, $t1, $t2
    add $t0, $t0, $t1
    
    move $s3, $t0
   
    
    lb $t0, 0($a1)
    li $t1, '0'
    sub $t0, $t0, $t1
    li $t1, 100
    mul $t0, $t0, $t1
    li $t1, 10
    mul $t0, $t0, $t1
    lb $t1, 1($a1)
    li $t2, '0'
    sub $t1, $t1, $t2
    li $t2, 100
    mul $t1, $t1, $t2
    add $t0, $t0, $t1
    lb $t1, 2($a1)
    li $t2, '0'
    sub $t1, $t1, $t2
    li $t2, 10
    mul $t1, $t1, $t2
    add $t0, $t0, $t1
    lb $t1, 3($a1)
    li $t2, '0'
    sub $t1, $t1, $t2
    add $t0, $t0, $t1
    
    move $s4, $t0
    
    li $t2, 0
    sub $t3, $s4, $s3
    blt $t3, $t2, wrong_case
    li $t2, 0
    sub $t3, $s4, $s3
    beq $t3, $t2, same_year

    	
    check_months:
   		lb $s6, 5($s0)
    		li $t2, '0'
    		sub $s6, $s6, $t2
    		li $t2, 10
    		mul $s6, $s6, $t2
    		lb $t4, 6($s0)
    		li $t2, '0'
    		sub $t4, $t4, $t2
    		add $s6, $s6, $t4
    		move $s5, $s6
    		
    		li $s7, 13
    		
    	months_loop2:
    		beq $s6, $s7, next_step
    		li $t4, 1
    		beq $s6, $t4, athirty_one
    		li $t4, 2
    		beq $s6, $t4, afebruary
    		li $t4, 3
    		beq $s6, $t4, athirty_one
    		li $t4, 4
    		beq $s6, $t4, athirty
    		li $t4, 5
    		beq $s6, $t4, athirty_one
    		li $t4, 6
    		beq $s6, $t4, athirty
    		li $t4, 7
    		beq $s6, $t4, athirty_one
    		li $t4, 8
    		beq $s6, $t4, athirty_one
    		li $t4, 9
    		beq $s6, $t4, athirty
    		li $t4, 10
    		beq $s6, $t4, athirty_one
    		li $t4, 11
    		beq $s6, $t4, athirty
    		li $t4, 12
    		beq $s6, $t4, athirty_one
    	
    	athirty_one:
    		bne $s5, $s6, continue_loop
    		lb $t0, 8($s0)
    		li $t2, '0'
    		sub $t0, $t0, $t2
    		li $t2, 10
    		mul $t0, $t0, $t2
    		lb $t3, 9($s0)
    		li $t2, '0'
    		sub $t3, $t3, $t2
    		add $t0, $t0, $t3
    		li $t1, 31
    		sub $t1, $t1, $t0
    		add $s2, $s2, $t1
    		sb $t2, 8($s0)
    		sb $t2, 9($s0)
    		addi $s6, $s6, 1
    		j months_loop2
    		
    		continue_loop:
    		addi $s2, $s2, 31
    		addi $s6, $s6, 1
    		j months_loop2 
    		
    	athirty:
    		bne $s5, $s6, continue_loop1
    		lb $t0, 8($s0)
    		li $t2, '0'
    		sub $t0, $t0, $t2
    		li $t2, 10
    		mul $t0, $t0, $t2
    		lb $t3, 9($s0)
    		li $t2, '0'
    		sub $t3, $t3, $t2
    		add $t0, $t0, $t3
    		li $t1, 30
    		sub $t1, $t1, $t0
    		add $s2, $s2, $t1
    		sb $t2, 8($s0)
    		sb $t2, 9($s0)
    		addi $s6, $s6, 1
    		j months_loop2
    		
    		continue_loop1:
    		addi $s2, $s2, 30
    		addi $s6, $s6, 1
    		j months_loop2
    	
    	afebruary:
    		move $a0, $s3
    		jal is_leap_year
    		li $t0, 1
    		beq $v0, $t0, start_leap
    		bne $s5, $s6, continue_loop3
    		lb $t0, 8($s0)
    		li $t2, '0'
    		sub $t0, $t0, $t2
    		li $t2, 10
    		mul $t0, $t0, $t2
    		lb $t3, 9($s0)
    		li $t2, '0'
    		sub $t3, $t3, $t2
    		add $t0, $t0, $t3
    		li $t1, 28
    		sub $t1, $t1, $t0
    		add $s2, $s2, $t1
    		sb $t2, 8($s0)
    		sb $t2, 9($s0)
    		addi $s6, $s6, 1
    		j months_loop2
    		
    		continue_loop3:
    		addi $s2, $s2, 28
    		addi $s6, $s6, 1
    		j months_loop2
    	
    		start_leap:
    		bne $s5, $s6, continue_loop4
    		lb $t0, 8($s0)
    		li $t2, '0'
    		sub $t0, $t0, $t2
    		li $t2, 10
    		mul $t0, $t0, $t2
    		lb $t3, 9($s0)
    		li $t2, '0'
    		sub $t3, $t3, $t2
    		add $t0, $t0, $t3
    		li $t1, 29
    		sub $t1, $t1, $t0
    		add $s2, $s2, $t1
    		sb $t2, 8($s0)
    		sb $t2, 9($s0)
    		addi $s6, $s6, 1
    		j months_loop2
    		
    		continue_loop4:
    		addi $s2, $s2, 29
    		addi $s6, $s6, 1
    		j months_loop2
    
    next_step:
    	sub $t3, $s4, $s3
    	li $s6, 1
    	beq $t3, $s6, check_fromjan		
    	addi $s3, $s3, 1
    									
    check_year:
    	sub $t3, $s4, $s3
    	li $t2, 0
    	beq $t3, $t2, check_fromjan
    	
    	check_leaps:
    		move $a0, $s3
    		jal is_leap_year
    		li $t0, 1
    		beq $v0, $t0, found_leap
    		addi $s2, $s2, 365
    		addi $s3, $s3, 1
    		j check_year
    		
    	found_leap:
    		addi $s2, $s2, 366
    		addi $s3, $s3, 1
    		j check_year	
    	
    	
    same_year:
    	
    	lb $s6, 5($s0)
    	li $t2, '0'
    	sub $s6, $s6, $t2
    	li $t2, 10
    	mul $s6, $s6, $t2
    	lb $t5, 6($s0)
    	li $t2, '0'
    	sub $t5, $t5, $t2
    	add $s6, $s6, $t5
    	
    	check_fromjan:
    	lb $s7, 5($s1)
    	li $t5, '0'
    	sub $s7, $s7, $t5 
    	li $t5, 10
    	mul $s7, $s7, $t5
    	lb $t4, 6($s1)
    	li $t5, '0'
    	sub $t4, $t4, $t5
    	add $s7, $s7, $t4
    	
    	li $t0, 0
    	sub $t1, $s7, $s6
    	blt $t1, $t0, wrong_case
    	
    	
    	months_loop:
    		beq $s6, $s7, check_days
    		li $t4, 1
    		beq $s6, $t4, thirty_one
    		li $t4, 2
    		beq $s6, $t4, february
    		li $t4, 3
    		beq $s6, $t4, thirty_one
    		li $t4, 4
    		beq $s6, $t4, thirty
    		li $t4, 5
    		beq $s6, $t4, thirty_one
    		li $t4, 6
    		beq $s6, $t4, thirty
    		li $t4, 7
    		beq $s6, $t4, thirty_one
    		li $t4, 8
    		beq $s6, $t4, thirty_one
    		li $t4, 9
    		beq $s6, $t4, thirty
    		li $t4, 10
    		beq $s6, $t4, thirty_one
    		li $t4, 11
    		beq $s6, $t4, thirty
    		li $t4, 12
    		beq $s6, $t4, thirty_one
    	
    	thirty_one:
    		addi $s2, $s2, 31
    		addi $s6, $s6, 1
    		
    		j months_loop 
    	thirty:
    		addi $s2, $s2, 30
    		addi $s6, $s6, 1
    		j months_loop
    	
    	february:
    		move $a0, $s4
    		jal is_leap_year
    		li $t0, 1
    		beq $v0, $t0, end_leap
    		addi $s2, $s2, 28
    		addi $s6, $s6, 1
    		j months_loop
    	
    		end_leap:
    		addi $s2, $s2, 29
    		addi $s6, $s6, 1
    		j months_loop
    	
    
    check_days:
    	lb $t0, 8($s0)
    	lb $t1, 8($s1)
    	li $t2, '0'
    	sub $t0, $t0, $t2
    	sub $t1, $t1, $t2
    	li $t2, 10
    	mul $t0, $t0, $t2
    	mul $t1, $t1, $t2
    	lb $t3, 9($s0)
    	lb $t4, 9($s1)
    	li $t2, '0'
    	sub $t3, $t3, $t2
    	add $t0, $t0, $t3
    	sub $t4, $t4, $t2
    	add $t1, $t1, $t4
    	
    	
    	sub $t5, $t1, $t0
    	li $t1, 0
    	blt $t5, $t1, wrong_case
        add $s2, $s2, $t5
        move $v0, $s2
        j exit_datestring
    
    
    wrong_case:
    	li $v0, -1
    	j exit_datestring
    
    exit_datestring:
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

sell_book:
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
    
    move $s0, $a0		# hashtable sales
    move $s1, $a1		# hashtable books
    move $s2, $a2		# isbn
    move $s3, $a3		# customer id
    move $s4, $t0		# sale date
    move $s5, $t1		# sale price
    
    
    lw $t0, 0($s0)		# capacity of sales
    lw $t1, 4($s0)		# size occupied in sales
    beq $t0, $t1, sales_full	# checking if table full
    
    move $a0, $s1
    move $a1, $s2
    jal get_book		# checking if book already present
    li $t2, -1
    beq $v0, $t2, cant_find_book
    
    times_sold_inc:
    addi $t0, $s1, 12
    lw $t1, 8($s1)
    mul $v0, $v0, $t1
    add $t0, $t0, $v0
    addi $t0, $t0, 64
    lw $t2, 0($t0)
    addi $t2, $t2, 1
    sw $t2, 0($t0)
    
    added_sales:
    	lw $t0, 4($s0)
    	addi $t0, $t0, 1
    	sw $t0, 4($s0)
    
    move $a0, $s0
    move $a1, $s2
    move $a2, $s3
    jal hash_booksale
    move $s7, $v0		# value for $v0
   
    lw $t0, 8($s0)		# elem size
    addi $s6, $s0, 12
    mul $v0, $v0, $t0
    add $s6, $s6, $v0		# where to place sale
    
    li $s1, 0			# value for $v1
    
    probing_sell_book:
    	lbu $t0, 0($s6)
    	li $t1, 0x39
    	addi $s1, $s1, 1
    	beq $t0, $t1, inc_index
    	move $a0, $s6
    	move $a1, $s2
    	li $a2, 13
    	jal memcpy
    	add $s6, $s6, $v0
    	li $t0, '\0'
    	sb $t0, 0($s6)
    	addi $s6, $s6, 1
    	
    	add_padding:
    	li $t0, 0
    	sb $t0, 0($s6)
    	addi $s6, $s6, 1
    	sb $t0, 0($s6)
    	addi $s6, $s6, 1
    	
    	add_id:
    	li $t0, 0
    	sw $s3, 0($s6)
    	addi $s6, $s6, 4
    				
    	add_date:
    	addi $sp, $sp, -12
    	li $t0, '1'
	sb $t0, 0($sp)
	li $t0, '6'
	sb $t0, 1($sp)
	li $t0, '0'
	sb $t0, 2($sp)
	li $t0, '0'
	sb $t0, 3($sp)
	li $t0, '-'
	sb $t0, 4($sp)
	li $t0, '0'
	sb $t0, 5($sp)
	li $t0, '1'
	sb $t0, 6($sp)
	li $t0, '-'
	sb $t0, 7($sp)
    	li $t0, '0'
	sb $t0, 8($sp)
	li $t0, '1'
	sb $t0, 9($sp)
	li $t0, '\0'
	sb $t0, 10($sp)
	
	move $a0, $sp
    	move $a1, $s4
    	jal datestring_to_num_days
    	addi $sp, $sp, 12
    	sw $v0, 0($s6)
    	addi $s6, $s6, 4
    	
    	
    	add_price:
    	sw $s5, 0($s6)
    	move $v0, $s7
    	move $v1, $s1
    	j exit_sell_book
    	
    inc_index:
    	lw $t0, 8($s0)
    	lw $t1, 0($s0)
    	addi $t1, $t1, -1
    	beq $s7, $t1, wrapping_around
    	add $s6, $s6, $t0
    	addi $s7, $s7, 1
    	j probing_sell_book
    	
    wrapping_around:
    	addi $s6, $s0, 12
    	li $s7, 0
    	j probing_sell_book
    
    cant_find_book:
    	li $v0, -2
    	li $v1, -2
    	j exit_sell_book
    
    sales_full:
    	li $v0, -1
    	li $v1, -1
   	j exit_sell_book
    
    exit_sell_book:
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

compute_scenario_revenue:
    li $t0, 0			# intialize value for total rev
    
    li $t6, 0			# index of leftmost
    move $t7, $a1
    addi $t7, $t7, -1		# index of rightmost
    
    li $t2, 1
    scenario_loop:
    	beqz $a1, exit_compute
    	
    	li $t1, 32
    	sub $t1, $t1, $a1
    	sllv $t3, $a2, $t1
    	li $t1, 31
    	srlv $t3, $t3, $t1		# $t3 has left most bit
    
    	li $t5, 0
    	beq $t3, $t5, left_most
    	
    right_most:
    	li $t4, 28
    	mul $t4, $t4, $t7
    	add $t5, $a0, $t4
    	addi $t5, $t5, 24
    	lw $t3, 0($t5)
    	
    	mul $t3, $t3, $t2
    	add $t0, $t0, $t3
    	
        addi $t7, $t7, -1
    	
    	addi $a1, $a1, -1
    	addi $t2, $t2, 1
    	j scenario_loop

    left_most:
    	li $t4, 28
    	mul $t4, $t4, $t6
    	add $t5, $a0, $t4
    	addi $t5, $t5, 24
    	lw $t3, 0($t5)
    	
    	mul $t3, $t3, $t2
    	add $t0, $t0, $t3
    
        
        addi $t6, $t6, 1
    	addi $a1, $a1, -1
    	addi $t2, $t2, 1
    	j scenario_loop
    	

    exit_compute:
    move $v0, $t0
    jr $ra

maximize_revenue:
    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)

    move $s0, $a0
    move $s1, $a1
    
    move $t0, $a1
    addi $t0, $t0, -1
    
    li $s3, 2
    sllv $s3, $s3, $t0
    
    
    
    li $s4, 0
    li $s2, 0
    revenue_loop:
    	beq $s2, $s3, get_ans
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal compute_scenario_revenue
	addi $s2, $s2, 1
	bgt $v0, $s4, update_max
	j revenue_loop

    update_max:
    	move $s4, $v0
    	j revenue_loop

    get_ans:
    	move $v0, $s4

    exit_revenue:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    addi $sp, $sp, 24
    jr $ra

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
