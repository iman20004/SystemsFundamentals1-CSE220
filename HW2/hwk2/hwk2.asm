# Iman Ali
# Imaali
# 112204305

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

############################## Do not .include any files! #############################

.text
strlen:
     li $v0, 0				# initialize final answer counter
     addi $sp, $sp, -4
     sw $s0, 0($sp)			# save s0 on stack
     
    strlen_loop:
    	lb $t0, 0($a0)			# load current character in t1
    	beqz $t0, exit_strlen		# found null-terminator so exit
    	addi $a0, $a0, 1		# next char
    	addi $v0, $v0, 1		# increment counter
    	j strlen_loop
    	
    exit_strlen:
    	lw $s0, 0($sp)
    	addi $sp, $sp, 4	
    	jr $ra

index_of:
	addi $sp, $sp, -16		# make space on stack for 4 registers
	sw $ra, 0($sp)			# save $ra on stack
	sw $s0, 4($sp)			# save s0 on stack
	sw $s1, 8($sp)			# save s1 on stack
	sw $s2, 12($sp)			# save s2 on stack
	
	move $s0, $a0			# starting address in s0
	move $s1, $a1			# target character in s1
	move $s2, $a2			# starting index in s2
	
	move $a0, $s0
	jal strlen			
	move $t1, $v0			# store length in t1
	
	li $v0, 0			# initalize final answer counter
	
	blt $s2, $zero, minus1_case	# index less than zero, so exit
	bge $s2, $t1, minus1_case       # index out of bounds, so exit
	
    index_of_loop:
	beq $v0, $s2, search_loop	# if current index = starting index
	addi $s0, $s0, 1
	addi $v0, $v0, 1
	b index_of_loop
	
    search_loop:
    	lb $t2, 0($s0)			# get current char
    	beqz $t2, minus1_case 		# target not found, so -1
    	beq $t2, $s1, exit_index_of	# check if current = target, otherwise loop
    	addi $s0, $s0, 1
	addi $v0, $v0, 1
	b search_loop
	
    minus1_case:
    	li $v0, -1			# set the v0 to -1		
    	
    exit_index_of:
    	lw $ra, 0($sp)			# restore ra from stack
	lw $s0, 4($sp)			# restore s0 from stack
	lw $s1, 8($sp)			# restore s1 from stack
	lw $s2, 12($sp)			# restore s2 from stack
	addi $sp, $sp, 16		# deallocate stack space
    	jr $ra

to_lowercase:
    li $v0, 0				# initialize final answer counter
    li $t7, 0x41			# set t7 to 'A'
    li $t6, 0x5B			# set t6 to '['		
    
    lowercase_loop:
    	lb $t1, 0($a0)			# get current char at t1
    	addi $a0, $a0, 1		# next char
    	beqz $t1, exit_lowercase	# null-terminator found, so exit
    	blt $t1, $t7, lowercase_loop	# less than Ascii A-Z
    	blt $t1, $t6, lowercase_conversion # within Ascii A-Z
    	b lowercase_loop
    
    lowercase_conversion:
    	addi $a0, $a0, -1		# go back to current characters index
    	addi $t1, $t1, 0x20		# convert it to lowercase
    	addi $v0, $v0, 1		# increment counter
    	sb $t1, 0($a0)			# write this change to main memory
    	addi $a0, $a0, 1		# next characters index for next run in loop
    	j lowercase_loop
    
    exit_lowercase:
    	jr $ra

generate_ciphertext_alphabet:
    addi $sp, $sp, -8			   # make space on stack
    sw $s0, 0($sp)			   # preserve $s0 contents on stack
    sw $s1, 4($sp)			   # preserve $s1 contents on stack
    move $s0, $a0			   # put cipher address in s0
    move $s1, $a1			   # put keyphrase address in s1			
   
    li $v0, 0				   # initialize final ans
    move $t2, $s0
    li $t0, '\0'			   # load null-terminator in $t0
    sb $t0, 62($t2)			   # load null-term at last index of cipher array
    li $t3, 0				   # initliaze loop counter
    li $t4, 0x30			   # ascii for '0'
    li $t5, 0x39			   # ascii for '9'
    li $t6, 0x41			   # ascii for 'A'
    li $t7, 0x5A			   # ascii for 'Z'
    li $t1, 0x61			   # ascii for 'a'
    li $a2, 0x7A			   # ascii for 'z'

    loop_keyphrase:
    	li $t4, 0x30
    	lb $t0, 0($s1)			   # load current char from keyphrase
    	addi $s1, $s1, 1		   # to next char
    	addi $t3, $t3, 1		   # inc counter
    	beqz $t0, add_lowercase		   # found nullterm so step 3 now
    	blt $t0, $t4, loop_keyphrase	   # check if alphabet or digit
    	ble $t0, $t5, check_duplicate
    	blt $t0, $t6, loop_keyphrase
    	ble $t0, $t7, check_duplicate
    	blt $t0, $t1, loop_keyphrase
    	ble $t0, $a2, check_duplicate
    	
    check_duplicate:
    	li $a1, 1
    	beq $t3, $a1, add_to_cipher        # first char no need to check		
    	move $t2, $s1 			   # move effective address to t2
    	addi $t2, $t2, -2		   # go back two characters
    	addi $t4, $t3, -1			
    	duplicate_loop:
    		beqz $t4, add_to_cipher    # go back in keyphrase until index 0
    		lbu $a3, 0($t2)		   # a3 holds current char comparing to
    		addi $t2, $t2, -1	   # move back in keyphrase
    		addi $t4, $t4, -1	   # dec counter
    		beq $t0, $a3, loop_keyphrase # found duplicate so move on
    		b duplicate_loop	
    		
    add_to_cipher:
    	addi $v0, $v0, 1		   # inc final ans
    	sb $t0, 0($s0)			   # add char to cipher array
    	addi $s0, $s0, 1		   # next index in cipher array
	b loop_keyphrase

    add_lowercase:			   
    	li $t4, 0 			   # initialize loop counter
    	move $t3, $a0			   # make copy of cipher address
    	li $t6, 0x61			   # ascii for 'a'
    	li $t7, 0x7B			   # ascii for '{'
    	check_missinglower:
    		lb $t5, 0($t3)			# load char from cipher
    		addi $t3, $t3, 1		# next char
    		addi $t4, $t4, 1		# inc counter
    		beq $t5, $t6, next_letter	# found duplicate, so next letter
    		beq $t4, $v0, add_lowerletter	# run loop $v0 times
    		b check_missinglower		
	
	add_lowerletter:
		sb $t6, 0($s0)			# append current letter to cipher
		addi $s0, $s0, 1		# next index for next letter
		
	next_letter:
		li $t4, 0			# reinitialize for loop
    		move $t3, $a0			# reinitialize for loop
    		addi $t6, $t6, 1		# next letter
    		beq $t6, $t7, add_uppercase	# loop till 'z'
    		b check_missinglower
    
     add_uppercase:				# same for uppercase
    	li $t4, 0 
    	move $t3, $a0
    	li $t6, 0x41
    	li $t7, 0x5B
    	check_missingupper:
    		lb $t5, 0($t3)
    		addi $t3, $t3, 1
    		addi $t4, $t4, 1
    		beq $t5, $t6, next_upperletter
    		beq $t4, $v0, add_upperletter
    		b check_missingupper
	
	add_upperletter:
		sb $t6, 0($s0)
		addi $s0, $s0, 1
		
	next_upperletter:
		li $t4, 0
    		move $t3, $a0
    		addi $t6, $t6, 1
    		beq $t6, $t7, add_digits
    		b check_missingupper
    		
     add_digits:				# same for digits
    	li $t4, 0 
    	move $t3, $a0
    	li $t6, 0x30
    	li $t7, 0x3A
    	check_missingdigit:
    		lb $t5, 0($t3)
    		addi $t3, $t3, 1
    		addi $t4, $t4, 1
    		beq $t5, $t6, next_digit
    		beq $t4, $v0, add_digit
    		b check_missingdigit
	
	add_digit:
		sb $t6, 0($s0)
		addi $s0, $s0, 1
		
	next_digit:
		li $t4, 0
    		move $t3, $a0
    		addi $t6, $t6, 1
    		beq $t6, $t7, exit_cipher
    		b check_missingdigit
    		
    exit_cipher:
    	lw $s0, 0($sp)			   # restore $s0 from stack
    	lw $s1, 4($sp)			   # restore $s1 from stack
    	addi $sp, $sp, 8		   # deallocate space from stack
    	jr $ra

count_lowercase_letters:
    li $v0, 0				   # initialize final ans
    li $t7, 0x61 			   # set $t7 to 'a'
    li $t6, 0x7A			   # set $t6 to 'z'
    li $t4, 26 				   # number of times to run loop
    li $t3, 0				   # initialize loop counter
    move $t2, $a0	
    
    initialize_cipher:
    	beq $t3, $t4, count_lowercase_loop # loop for 26 times
    	addi $t3, $t3, 1		   # inc loop counter
    	sw $v0, 0($t2)			   # store 0 into current index of array
    	addi $t2, $t2, 4		   # move to next place in array
    	b initialize_cipher
    		
    count_lowercase_loop:
    	lb $t1, 0($a1)			   # load current char of string
    	beqz $t1, exit_count_lowercase	   # found null terminator, so string finished
    	addi $a1, $a1, 1		   # go to next char
    	blt $t1, $t7, count_lowercase_loop # less than Ascii a (not lowercase)
    	bgt $t1, $t6, count_lowercase_loop # greater than Ascii z (not lowercase)
    		
    which_letter:
    	li $t5, 0x61			   # set $t5 to 'a'
    	addi $v0, $v0, 1		   # inc count of lower case
    	move $t2, $a0			   # address of counts in $t2
    	li $t4, 26 			   # reinitialize $t4 and $t3 
    	li $t3, 0
    	
      which_letter_loop:
    	beq $t3, $t4, count_lowercase_loop # run loop 26 times for each alpha
    	beq $t1, $t5, update_counts	   # add into ans array 
    	addi $t5, $t5, 1 		   # next alpha
    	addi $t3, $t3, 1		   # inc counter
    	addi $t2, $t2, 4
    	b which_letter_loop
    
     update_counts:			   
    	lw $a2, 0($t2)			   # load current count of alphabet
    	addi $a2, $a2, 1		   # add one to the old count
    	sw $a2, 0($t2)			   # store word back in its place
    	b count_lowercase_loop
    	
    exit_count_lowercase:
    jr $ra

sort_alphabet_by_count:
    li $t0, '\0'			   # load null-terminator in $t0
    sb $t0, 26($a0)			   # load null-term at last index of sorted alphabet
    li $a3, 0
    
    alphabet_loop:	
    move $t7, $a1
    li $t0, -1				   # initialize max in $t0
    li $t3, 0			   	   # initialize loop counter in $t3
    li $t4, 26
    sorting_loop:
    	beq $t3, $t4, found_max
    	lw $t1, 0($t7)
    	addi $t7, $t7, 4
    	addi $t3, $t3, 1
    	bgt $t1, $t0, set_new_max
    	b sorting_loop
    	
    set_new_max:
    	move $t0, $t1	
    	b sorting_loop
    	
    found_max:
    	li $t3, 0
    	find_index:
    		lw $t5, 0($a1)
    		beq $t5, $t0, remove_currentmax
    		addi $t3, $t3, 1
    		addi $a1, $a1, 4
    		b find_index
    
    remove_currentmax:
    	li $t2, -1
    	sw $t2, 0($a1)
    	li $t1, 0
    	fix_starting_addr:
    		beq $t1, $t3, add_to_ans 
    		addi $a1, $a1, -4
    		addi $t1, $t1, 1
    		b fix_starting_addr
    		
    add_to_ans:	
    	li $t1, 0x61
    	add $t1, $t1, $t3
    	sb $t1, 0($a0)
    	addi $a0, $a0, 1
    	addi $a3, $a3, 1
    	beq $a3, $t4, exit_sort_alphabet_by_count
    	b alphabet_loop
    
    exit_sort_alphabet_by_count:
    jr $ra

generate_plaintext_alphabet:
    li $t0, '\0'			   # load null-terminator in $t0
    sb $t0, 62($a0)			   # load null-term at last index of sorted alphabet
    li $t0, 0x61
    li $t5, 0x7A
    
    plaintext_loop:
    	move $t1, $a1
    	li $t2, 0
    	li $t3, 8
    	generation_loop:
    		beq $t2, $t3, add_once
    		lb $t4, 0($t1)
    		beq $t0, $t4, num_repetion
    		addi $t2, $t2, 1
    		addi $t1, $t1, 1
    		b generation_loop
    	
    	add_once:
    		sb $t0, 0($a0)
    		beq $t0, $t5, exit_plaintext
    		addi $a0, $a0, 1
    		addi $t0, $t0, 1
    		b plaintext_loop
     	
     	num_repetion:
     		li $t6, 0
     		beq $t2, $t6, repeat_9times
     		addi $t6, $t6, 1
     		beq $t2, $t6, repeat_8times
     		addi $t6, $t6, 1
     		beq $t2, $t6, repeat_7times
     		addi $t6, $t6, 1
     		beq $t2, $t6, repeat_6times
     		addi $t6, $t6, 1
     		beq $t2, $t6, repeat_5times
     		addi $t6, $t6, 1
     		beq $t2, $t6, repeat_4times
     		addi $t6, $t6, 1
     		beq $t2, $t6, repeat_3times
     		addi $t6, $t6, 1
     		beq $t2, $t6, repeat_2times
     		
     	
     	repeat_9times:
     		li $t7, 9
     		b repetition	
     	repeat_8times:
     		li $t7, 8
     		b repetition
     	repeat_7times:
     		li $t7, 7
     		b repetition
     	repeat_6times:
     		li $t7, 6
     		b repetition
     	repeat_5times:
     		li $t7, 5
     		b repetition
     	repeat_4times:
     		li $t7, 4
     		b repetition
     	repeat_3times:
     		li $t7, 3
     		b repetition
     	repeat_2times:
     		li $t7, 2
     		b repetition
     		
     	repetition:
     		li $t3, 0
     		repetition_loop:
     			beq $t3, $t7, loop_or_stop
     			sb $t0, 0($a0)
     			addi $a0, $a0, 1
     			addi $t3, $t3, 1
     			b repetition_loop
    	
    	loop_or_stop:
    		beq $t0, $t5, exit_plaintext
    		addi $t0, $t0, 1
    		b plaintext_loop
    	
    exit_plaintext:
    jr $ra

encrypt_letter:
    li $v0, -1				# initialize $v0 to -1
    li $t0, 0x61			# set $t0 to ascii 'a'
    li $t1, 0x7A			# set $t1 to ascii 'z'
    blt $a0, $t0, exit_encrypt_letter	# return -1 if letter not lowercase
    bgt $a0, $t1, exit_encrypt_letter
    li $t7, 0				# initialize a register to hold i
    
    find_i_loop:
    	lb $t0, 0($a2)
    	addi $a2, $a2, 1
    	beq $t0, $a0, find_k
    	addi $t7, $t7, 1
    	b find_i_loop

    find_k:
    	li $t6, 0
    	find_k_loop:
    		lb $t1, 0($a2)
		bne $t1, $a0, find_ans_char_index
		addi $t6, $t6, 1
		addi $a2, $a2, 1
		b find_k_loop

    find_ans_char_index:
    	addi $t6, $t6, 1
    	div $a1, $t6
    	mfhi $t5
    	add $t5, $t5, $t7
    	li $t6, 0
    	
    find_ans_char_loop:
    	beq $t6, $t5, set_final_ans
    	addi $t6, $t6, 1
    	addi $a3, $a3, 1
    	b find_ans_char_loop
    	
    set_final_ans:
    	lb $t7, 0($a3)
    	move $v0, $t7	
    	
    exit_encrypt_letter:
    jr $ra

encrypt:
    addi $sp, $sp, -32			# allocate space on stack
    sw $ra, 0($sp)			# save $ra on stack
    sw $s0, 4($sp)			# save contents of $s0 on stack
    sw $s1, 8($sp)			# save contents of $s1 on stack
    sw $s2, 12($sp)			# save contents of $s2 on stack
    sw $s3, 16($sp)			# save contents of $s3 on stack
    sw $s4, 20($sp)			# save contents of $s4 on stack
    sw $s5, 24($sp)			# save contents of $s5 on stack
    sw $s6, 28($sp)			# save contents of $s6 on stack
    
    move $s0, $a0 			# move ciphertext to s0
    move $s1, $a1			# move plaintext to s1
    move $s2, $a2			# move keyphrase to s2
    move $s3, $a3			# move corpus to s3
    
    move $a0, $s1			# move plaintext into a0
    jal to_lowercase			# call to_lowercase on plaintext
    
    move $a0, $s3			# move corpus into a0
    jal to_lowercase			# call to_lowercase on corpus
    
    addi $sp, $sp, -104			# allocate space on stack for counts
    move $a0, $sp			# $a0 has starting address of counts
    
    move $a1, $s3			# $a1 has corpus
    jal count_lowercase_letters		# call count_lowercase_letters
    
    move $a1, $sp			# $a1 has starting addr of counts for sort_alphabet_by_count argument
    addi $sp, $sp, -28 			# allocate space for lowercase_letters string
    move $a0, $sp			# $a0 has starting address of lower_case letters
  
    jal sort_alphabet_by_count		# call sort_alphabet_by_count
   
    move $a1, $sp			# $a1 has starting addr of lowercase_letters string as argument of generate plaintext
    addi $sp, $sp, -64			# allocate space for plaintext alphabet
    move $a0, $sp			# $a0 has starting address of plaintext alphabet
    
    jal generate_plaintext_alphabet
    
    addi $sp, $sp, -64			# allocate space for ciphertext alphabet
    move $a0, $sp			# a0 has starting address of ciphertext alphabet
    move $a1, $s2			# a1 has keyphrase
    jal generate_ciphertext_alphabet	
    
    li $s3, 0				# counter for encrypted letters
    li $s4, 0				# counter for copied characters
    li $s2, 0				# holds letter index
    move $s5, $sp			# holds ciphertext alphabet address
    addi $sp, $sp, 64 
    move $s6, $sp			# holds plaintext alphabet address
    enrcyption_loop:
    	lb $a0, 0($s1)			# plaintext letter in $a0
    	beqz $a0, exit_encryption
    	li $t1, 0x61			# ascii 'a'
    	li $t2, 0x7A			# ascii 'z'
    	blt $a0, $t1, copy_case		
    	bgt $a0, $t2, copy_case
 	addi $s3, $s3, 1
 	move $a1, $s2			# letter index
    	move $a2, $s6
    	move $a3, $s5
    	jal encrypt_letter
    	sb $v0, 0($s0)
    	addi $s1, $s1, 1
    	addi $s2, $s2, 1
    	addi $s0, $s0, 1
    	b enrcyption_loop
    
    copy_case:
    	addi $s4, $s4, 1
    	sb $a0, 0($s0)
    	addi $s1, $s1, 1
    	addi $s2, $s2, 1
    	addi $s0, $s0, 1
    	b enrcyption_loop
    		
    exit_encryption:
    	move $v0, $s3
    	move $v1, $s4
    	li $t3, '\0'
    	sb $t3, 0($s0)
    	
    	addi $sp, $sp, 64 
    	addi $sp, $sp, 28 
    	addi $sp, $sp, 104
   
    exit_encrypt:
    	lw $ra, 0($sp)			# restore $ra from stack
   	lw $s0, 4($sp)			# restore contents of $s0 from stack
   	lw $s1, 8($sp)			# restore contents of $s1 from stack
   	lw $s2, 12($sp)			# restore contents of $s2 from stack
   	lw $s3, 16($sp)			# restore contents of $s3 from stack
    	lw $s4, 20($sp)	
    	lw $s5, 24($sp)	
    	lw $s6, 28($sp)	
    	addi $sp, $sp, 32		# deallocate space from stack
    	
   	jr $ra

decrypt:
   addi $sp, $sp, 36			# allocate space on stack
    sw $ra, 0($sp)			# save $ra on stack
    sw $s0, 4($sp)			# save contents of $s0 on stack
    sw $s1, 8($sp)			# save contents of $s1 on stack
    sw $s2, 12($sp)			# save contents of $s2 on stack
    sw $s3, 16($sp)			# save contents of $s3 on stack
    sw $s4, 20($sp)			# save contents of $s4 on stack
    sw $s5, 24($sp)			# save contents of $s5 on stack
    sw $s6, 28($sp)			# save contents of $s6 on stack
    sw $s7, 32($sp)			# save contents of $s7 on stack
    
    move $s0, $a0 			# move plaintext to s0
    move $s1, $a1			# move ciphertext to s1
    move $s2, $a2			# move keyphrase to s2
    move $s3, $a3			# move corpus to $s3
    
    move $a0, $s3			# move corpus into a0
    jal to_lowercase			# call to_lowercase on corpus
    
    addi $sp, $sp, -104			# allocate space on stack for counts
    move $a0, $sp			# $a0 has starting address of counts
    
    move $a1, $s3			# $a1 has corpus
    jal count_lowercase_letters		# call count_lowercase_letters
    
    move $a1, $sp			# $a1 has starting addr of counts for sort_alphabet_by_count argument
    addi $sp, $sp, -28 			# allocate space for lowercase_letters string
    move $a0, $sp			# $a0 has starting address of lower_case letters
  
    jal sort_alphabet_by_count		# call sort_alphabet_by_count
   
    move $a1, $sp			# $a1 has starting addr of lowercase_letters string as argument of generate plaintext
    addi $sp, $sp, -64			# allocate space for plaintext alphabet
    move $a0, $sp			# $a0 has starting address of plaintext alphabet
    
    jal generate_plaintext_alphabet
    move $s3, $sp
    
    addi $sp, $sp, -64			# allocate space for ciphertext alphabet
    move $a0, $sp			# a0 has starting address of ciphertext alphabet
    move $a1, $s2			# a1 has keyphrase
    jal generate_ciphertext_alphabet	


    li $s6, 0				# initialize counter for n.o of letters written into plaintext 
    li $s7, 0				# initialize counter for unchanged characters written into plaintext
    move $s2, $sp 			# $s2 contains ciphertext_alphabet
   
     decryption_loop:
    	lb $s4, 0($s1)			# load character from ciphertext in $s4
    	beqz $s4, exit_decryption	# exit when ciphertext finishes
    	li $t1, 0x30			# ascii '0'
    	li $t2, 0x39			# ascii '9'
    	li $t3, 0x41			# ascii 'A'
   	li $t4, 0x5A			# ascii 'Z'
    	li $t5, 0x61			# ascii 'a'
    	li $t6, 0X7A			# ascii 'z'
    	blt $s4, $t1, non_alpha_case	# less than 0 so just copy into plaintext
    	ble $s4, $t2, decryption	# digit value so decrypt
    	blt $s4, $t3, non_alpha_case	# less than A but greater than 9 so just copy
    	ble $s4, $t4, decryption	# uppercase letter so decrypt
    	blt $s4, $t5, non_alpha_case	# less than a but greater than Z so just copy
    	ble $s4, $t6, decryption	# lowercase letter so decrypt
    					# otherwise just copy into plaintext if greater than z
    non_alpha_case:
    	addi $s7, $s7, 1		# incr counter for unchanged copied characters
    	sb $s4, 0($s0)			# store character in plaintext
    	addi $s0, $s0, 1		# next character in ciphertext
    	addi $s1, $s1, 1		# next character in plaintext
    	b decryption_loop		
   
    decryption:
    	move $a0, $s2			# arg 0 as ciphertext_alphabet
    	move $a1, $s4			# arg 1 as target character 
    	li $a2, 0			# arg 2 as 0 for starting index
    	jal index_of			# call index_of
    	move $t1, $v0			# move index answer in $t1
    	move $s5, $s3			# plaintext_alphabet address in $s5
    	add $s5, $s5, $t1		# move to ans index in plaintext_alphabet
    	
    	lb $t6, 0($s5)			# load that character from plaintext_alphabet
    	sb $t6, 0($s0)			# store that character in plaintext
    	addi $s6, $s6, 1		# inc counter for decrpyted charcaters
   	addi $s0, $s0, 1		# next character in ciphertext
    	addi $s1, $s1, 1		# next character in plaintext
    	b decryption_loop
    	
    exit_decryption:
    	move $v0, $s6			# $v0 has number of decrypted chars
    	move $v1, $s7			# $v1 has number of unchanged chars
    	li $t3, '\0'
    	sb $t3, 0($s0)			# null terminate plaintext
    	
    	addi $sp, $sp, 64
    	addi $sp, $sp, 64 		# deallocate space from stack
    	addi $sp, $sp, 28 
    	addi $sp, $sp, 104
  
    
    exit_decrypt:
    	lw $ra, 0($sp)			# restore $ra from stack
   	lw $s0, 4($sp)			# restore contents of $s0 from stack
   	lw $s1, 8($sp)			# restore contents of $s1 from stack
   	lw $s2, 12($sp)			# restore contents of $s2 from stack
   	lw $s3, 16($sp)			# restore contents of $s3 from stack
    	lw $s4, 20($sp)			# restore contents of $s0 from stack
   	lw $s5, 24($sp)			# restore contents of $s1 from stack
   	lw $s6, 28($sp)			# restore contents of $s2 from stack
   	lw $s7, 32($sp)			# restore contents of $s3 from stack
    	
    	addi $sp, $sp, 36		# deallocate space from stack
    	
   	jr $ra

############################## Do not .include any files! #############################

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
