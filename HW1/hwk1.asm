# Iman Ali
# Imaali
# 112204305

.data
# Command-line arguments
num_args: .word 0
addr_arg0: .word 0
addr_arg1: .word 0
addr_arg2: .word 0
addr_arg3: .word 0
addr_arg4: .word 0
addr_arg5: .word 0
addr_arg6: .word 0
addr_arg7: .word 0
no_args: .asciiz "You must provide at least one command-line argument.\n"

# Output messages
big_bobtail_str: .asciiz "BIG_BOBTAIL\n"
full_house_str: .asciiz "FULL_HOUSE\n"
five_and_dime_str: .asciiz "FIVE_AND_DIME\n"
skeet_str: .asciiz "SKEET\n"
blaze_str: .asciiz "BLAZE\n"
high_card_str: .asciiz "HIGH_CARD\n"

# Error messages
invalid_operation_error: .asciiz "INVALID_OPERATION\n"
invalid_args_error: .asciiz "INVALID_ARGS\n"

# Put your additional .data declarations here, if any.
var1: .byte 0

# Main program starts here
.text
.globl main
main:
    # Do not modify any of the code before the label named "start_coding_here"
    # Begin: save command-line arguments to main memory
    sw $a0, num_args
    beqz $a0, zero_args
    li $t0, 1
    beq $a0, $t0, one_arg
    li $t0, 2
    beq $a0, $t0, two_args
    li $t0, 3
    beq $a0, $t0, three_args
    li $t0, 4
    beq $a0, $t0, four_args
    li $t0, 5
    beq $a0, $t0, five_args
    li $t0, 6
    beq $a0, $t0, six_args
seven_args:
    lw $t0, 24($a1)
    sw $t0, addr_arg6
six_args:
    lw $t0, 20($a1)
    sw $t0, addr_arg5
five_args:
    lw $t0, 16($a1)
    sw $t0, addr_arg4
four_args:
    lw $t0, 12($a1)
    sw $t0, addr_arg3
three_args:
    lw $t0, 8($a1)
    sw $t0, addr_arg2
two_args:
    lw $t0, 4($a1)
    sw $t0, addr_arg1
one_arg:
    lw $t0, 0($a1)
    sw $t0, addr_arg0
    j start_coding_here

zero_args:
    la $a0, no_args
    li $v0, 4
    syscall
    j exit
    # End: save command-line arguments to main memory

start_coding_here:
    # Start the assignment by writing your code here
   
    la $t0, addr_arg0   #load first arg and check if its only one char
    lw $t0, 0($t0)
    lbu $t1, 0($t0)
    li $s1, 0x00
    lbu $s2, 1($t0)
    bne $s2, $s1, give_invalid_operation_error
    
    #compare first arg and send to according branch
   
    li $t2, '1'
    li $t3, '2'
    li $t4, 'S'
    li $t5, 'F'
    li $t6, 'R'
    li $t7, 'P'
    
    beq $t1, $t2, three_inputs
    beq $t1, $t3, three_inputs
    beq $t1, $t4, three_inputs
    beq $t1, $t5, two_inputs
    beq $t1, $t6, seven_inputs
    beq $t1, $t7, two_inputs
    
    j give_invalid_operation_error
    
    
three_inputs:
    #give error if not 3 inputs given
    li $s0, 3 
    bne $a0, $s0, give_invalid_args_error
    
    
    lw $s1, addr_arg1  
    li $s2, 0		#initialize loop counter
    li $s5, 4		#stop loop when all 4 args checked
    
    #check if second arg is 0-9 or A-F
    loop:
    	beq $s2, $s5, check_arg_3
    	lbu $s3, 0($s1)
    	addi $s2, $s2, 1
    	li $s4, '0'
    	blt $s3, $s4, give_invalid_args_error
    	li $s4, '9'
    	ble  $s3, $s4, inc_loop
    	li $s4, 'A'
    	blt $s3, $s4, give_invalid_args_error
    	li $s4, 'G'
    	blt $s3, $s4, inc_loop
    	b give_invalid_args_error
    	
    #go to next character in loop	
    inc_loop:
 	addi $s1, $s1, 1
 	b loop
   
  
   check_arg_3:
   	lw $s1, addr_arg2
   	lbu $s2, 0($s1)
   	li $s3, '3'
   	bgt  $s2, $s3, give_invalid_args_error
   	li $s4, '1'
   	blt  $s2, $s4, give_invalid_args_error
   	
   	beq $s2, $s3, three_something
   	beq $s2, $s4, one_something
   	b send_to_correct_branch
   	
   three_something:
   	lbu $s2, 1($s1)
   	li $s5, '2'
   	bgt $s2, $s5, give_invalid_args_error
   	b send_to_correct_branch
   	
   one_something:
   	lbu $s2, 1($s1)
   	li $s5, '6'
   	blt $s2, $s5, give_invalid_args_error
   	b send_to_correct_branch
   	
    
send_to_correct_branch:
	   
	lw $t1, addr_arg1 	#get the second argument
	li $t6, 48 		#constant for numbers
	li $t7, 55		#constant for alphabets
	li $t4, 0		#intialize final value
	li $t5, 0 		#initalize loop counter
	li $s1, 4		#run loop four times for each char
	li $s2, ':'		#less than colon are integers
	
#storing the loop	
store_loop:
	beq $t5, $s1, pos_or_neg
	lb $t2, 0($t1)
	sll $t4, $t4, 4
	addi $t1, $t1, 1 
	addi $t5, $t5 ,1
	blt $t2, $s2 , num_loop
	b alphabet_loop
	
num_loop:
	sub $t2, $t2, $t6
	add $t4, $t4, $t2
	b store_loop
	
alphabet_loop:
	sub $t2, $t2, $t7
	add $t4, $t4, $t2
	b store_loop
	
pos_or_neg:

	lw $t1, addr_arg1
	lb $t2, 0($t1)
	li $t3, '8'
	blt  $t2, $t3, one_two_ors
	li $s0, 0xFFFF0000
	xor $t4, $t4, $s0
	
one_two_ors:	
	lw $s0, addr_arg0
	lbu $s1, 0($s0)
	li $s2, '1'
    	li $s3, '2'
    	li $s4, 'S'
    		
    	beq $s1, $s2, ones_complement_case
    	beq $s1, $s3, twos_complement_case
    	beq $s1, $s4, signed_case
	
ones_complement_case:
	li $s1, 0xFFFF8000
	and $s3, $t4, $s1
	bne $s3, $s1, twos_complement_case
	addiu $t4, $t4, 1  
	b twos_complement_case
	
signed_case:
	li $s1, 0xFFFF8000
	and $s3, $t4, $s1
	bne $s3, $s1, twos_complement_case #if positive then simply its 2's comp
	not $t4, $t4
	addi $t4, $t4, 1 
	li $s7, 0xFFF8000
	or $t4, $t4, $s7
	b twos_complement_case


twos_complement_case:
	lw $s1, addr_arg2
	lbu $s2, 0($s1)
	addi $s2, $s2, -48
	li $s7, 10
	mul $s2, $s2, $s7
	lbu $s6, 1($s1)
	addi $s6, $s6, -48
	addu  $s2, $s2, $s6
	
	li $s0, 0 #loop counter initialize
	li $t5, 0
	
	
print_loop:
	beq $s0, $s2, print_ans
	addi $s0, $s0, 1
	andi $t0, $t4, 0x1
	sll $t5, $t5, 1
	addu $t5, $t5, $t0
	srl $t4, $t4, 1
	b print_loop
	
print_ans:
	li $s0, 0
	
	print_final:
	beq $s0, $s2, print_newline
	addi $s0, $s0, 1
	andi $t6, $t5, 0x1
	srl $t5, $t5, 1
	li $a0, 0
	move $a0, $t6
	li $v0, 1
	syscall
	b print_final
		
two_inputs:
    li $s0, 2
    bne $a0, $s0, give_invalid_args_error
    
    beq $t1, $t5, decimal_to_binary_case
    beq $t1, $t7, card_game_case
    
seven_inputs:
    li $s0, 7
    bne $a0, $s0, give_invalid_args_error
    
    j r_type_case	


decimal_to_binary_case:
	lw $s1, addr_arg1
	lbu $s2, 0($s1)
	addi $s2, $s2, -48
	li $s7, 100
	mul $s2, $s2, $s7
	lbu $s3, 1($s1)
	addi $s3, $s3, -48
	li $s6, 10
	mul $s3, $s3, $s6
	add $s2, $s2, $s3
	lbu $s4, 2($s1)
	addi $s4, $s4, -48
	add $s2, $s2, $s4
	
	
	lbu $s4, 2($s1)
	li $s0, '0'
	beq $s4, $s0, print_zero
	b print_integerbinary
	
	print_zero:
		li $a0, 0
		li $v0, 1
		syscall 
		b decimal_part
		
	 	
	print_integerbinary:
		li $s0, 0
		li $s5, 0
		li $s1, 32
		li $t0, 0x80000000
		
		findone_loop:
			beq $s0, $s1, decimal_part
			addi $s0, $s0, 1
			and $t1, $s2, $t0
			sll $s2, $s2, 1
			beq $t1, $s5, findone_loop
			
			li $a0, 1
			li $v0, 1
			syscall
			sub $s1, $s1, $s0
			li $t7, 0
			final_loop:
				beq $t7, $s1, decimal_part
				addi $t7, $t7, 1
				and $t6, $s2, $t0
				srl $t6, $t6, 31
				sll $s2, $s2, 1
				li $a0, 0
				add $a0, $t6, $zero
				li $v0, 1
				syscall
				b final_loop
			
	
	decimal_part:
	
		li $a0, '.'
		li $v0, 11
		syscall

		lw $s1, addr_arg1
		lbu $s2, 4($s1)
		addi $s2, $s2, -48
		li $s7, 10000
		mul $s2, $s2, $s7
		
		lbu $s3, 5($s1)
		addi $s3, $s3, -48
		li $s6, 1000
		mul $s3, $s3, $s6
		add $s2, $s2, $s3
		
		lbu $s4, 6($s1)
		addi $s4, $s4, -48
		li $t1, 100
		mul $s4, $s4, $t1
		add $s2, $s2, $s4
		
		lbu $s5, 7($s1)
		addi $s5, $s5, -48
		li $t2, 10
		mul $s5, $s5, $t2
		add $s2, $s2, $s5
		
		lbu $s6, 8($s1)
		addi $s6, $s6, -48
		add $s2, $s2, $s6
		
		
		li $t6, 2
		li $t1, 50000
		li $s7, 0
		li $s6, 5
		
		loop_fractionbinary:
			beq $s7, $s6, print_newline
			addi $s7, $s7, 1
			bge  $s2, $t1, print_1
			b print_0
		
		print_1:
		li $a0, 1
		li $v0, 1
		syscall
		sub $s2, $s2, $t1
		div $t1, $t6
		mflo $t1
		b loop_fractionbinary
		
		print_0:
		li $a0, 0
		li $v0, 1
		syscall
		div $t1, $t6
		mflo $t1
		b loop_fractionbinary
	
	
r_type_case:
	lw $s0, addr_arg2
	lbu $s1, 0($s0)
	li $s2, '3'
	bgt $s1, $s2, give_invalid_args_error
	addi $s1, $s1, -48
	li $s6, 10
	mul $s1, $s1, $s6
	lbu $s7, 0($s0)
	beq $s7, $s2, three_something_case
	b convert_decimal
	
	three_something_case:
		li $s3, '1'
		lbu $s4, 1($s0)
		bgt $s4, $s3, give_invalid_args_error
	
	convert_decimal:
		lbu $s4, 1($s0)
		addi $s4, $s4, -48
		add $t2, $s1, $s4
	
	#t2 contains the rs  
	
	lw $s0, addr_arg3
	lbu $s1, 0($s0)
	li $s2, '3'
	bgt $s1, $s2, give_invalid_args_error
	addi $s1, $s1, -48
	li $s6, 10
	mul $s1, $s1, $s6
	lbu $s7, 0($s0)
	beq $s7, $s2, three_something_case4
	b convert_decimal1
	
	three_something_case4:
		li $s3, '1'
		lbu $s4, 1($s0)
		bgt $s4, $s3, give_invalid_args_error
	
	convert_decimal1:
		lbu $s4, 1($s0)
		addi $s4, $s4, -48
		add $t3, $s1, $s4
	#t3 contains the rt 
	
	lw $s0, addr_arg4
	lbu $s1, 0($s0)
	li $s2, '3'
	bgt $s1, $s2, give_invalid_args_error
	addi $s1, $s1, -48
	li $s6, 10
	mul $s1, $s1, $s6
	lbu $s7, 0($s0)
	beq $s7, $s2, three_something_case1
	b convert_decimal2
	
	three_something_case1:
		li $s3, '1'
		lbu $s4, 1($s0)
		bgt $s4, $s3, give_invalid_args_error
	
	convert_decimal2:
		lbu $s4, 1($s0)
		addi $s4, $s4, -48
		add $t4, $s1, $s4
	#t4 contains the rd
	
	lw $s0, addr_arg5
	lbu $s1, 0($s0)
	addi $s1, $s1, -48
	li $s6, 10
	mul $s1, $s1, $s6
	lbu $s4, 1($s0)
	addi $s4, $s4, -48
	add $t5, $s1, $s4
	#t5 contains the shamt
	
	lw $s0, addr_arg6
	lbu $s1, 0($s0)
	addi $s1, $s1, -48
	li $s6, 10
	mul $s1, $s1, $s6
	lbu $s4, 1($s0)
	addi $s4, $s4, -48
	add $t6, $s1, $s4
	#t6 contains the funct
	
	#t2 contains rs
	#t3 contains rt
	#t4 contains rd
	#t5 contains shamt
	#t6 contains funct
	
	#preserving right most 5 bits for rs, rt, rd and shamt
	li $s1, 0x1F
	and $t2, $t2, $s1 
	and $t3, $t3, $s1
	and $t4, $t4, $s1	
	and $t5, $t5, $s1
	
	sll $t2, $t2, 5
	add $t2, $t2, $t3
	
	sll $t2, $t2, 5
	add $t2, $t2, $t4
	
	sll $t2, $t2, 5
	add $t2, $t2, $t5
	
	sll $t2, $t2, 6
	li $s2, 0x3F
	and $t6, $t6, $s2
	add $t2, $t2, $t6
	
	
	li $a0, 0
	add $a0, $t2, $zero
	li $v0, 34
	syscall
	j print_newline
	
	
card_game_case:
	
	big_bobtail:
		lw $s0, addr_arg1
		li $s6, 0xF0
		lbu $t0, 0($s0)
		and $t0, $t0, $s6
		li $s7, 1
		
		lbu $t1, 1($s0)
		and $t1, $t1, $s6
		
		bne $t0, $t1, start_from2or1
		addi $s7, $s7, 1
		
		li $s1, 0
		li $s2, 3 
		addi $s0, $s0, 2
		
		signcheck_1:
			beq $s1, $s2, checkcounter1
			addi $s1, $s1, 1
			lbu $t3, 0($s0)
			and $t3, $t3, $s6
			addi $s0, $s0, 1
			beq $t3, $t0, incrementcounter1
			b signcheck_1
		
		incrementcounter1:
			addi $s7, $s7, 1
			b signcheck_1
		
		checkcounter1:
			li $s5, 4
			blt $s7, $s5, full_house
			b consecutive_check1
			
		start_from2or1:
		
			lbu $t3, 2($s0)
			and $t3, $t3, $s6
			beq $t3, $t1, start_from2
			bne $t3, $t0, full_house
			move $t1, $t0
			
		start_from2:
			li $s1, 0
			li $s2, 2
			li $s4, 2
			addi $s0, $s0, 3
			
		signcheck_2:
			beq $s1, $s2, checkcounter2
			addi $s1, $s1, 1
			lbu $t3, 0($s0)
			and $t3, $t3, $s6
			addi $s0, $s0, 1
			beq $t3, $t1, incrementcounter2
			b signcheck_2
		
		incrementcounter2:
			addi $s4, $s4, 1
			b signcheck_2
		
		checkcounter2:
			li $s5, 4
			blt $s4, $s5, full_house
			li $s0, 0
		 	li $s1, 4
		 	lw $t0, addr_arg1
		 	lbu $t1, 2($t0)
		 	li $s2, 0xF
		 	li $s3, 0xF0
		 	and $t2, $t1, $s2  #number
		 	and $t3, $t1, $s3  #sign
		 	b consecutive_loop
			
			
		consecutive_check1:
		 	 
		 	li $s0, 0
		 	li $s1, 4
		 	lw $t0, addr_arg1
		 	lbu $t1, 0($t0)
		 	li $s2, 0xF
		 	li $s3, 0xF0
		 	and $t2, $t1, $s2  #number
		 	and $t3, $t1, $s3  #sign
		 consecutive_loop:
		 		beq $s0, $s1, foundmin
		 		addi $s0, $s0, 1
		 		addi $t0, $t0, 1
		 		lbu $t4, 0($t0)
		 		and $t5, $t4, $s3
		 		bne $t5, $t3, consecutive_loop
		 		and $t5, $t4, $s2
		 		blt $t5, $t2, change_min
		 		b consecutive_loop
		 		
		 	change_min:
		 		move $t2, $t5
		 		b consecutive_loop
		 	
		 	foundmin:
		 		li $s1, 0
		 		addi $s1, $t2, 1
		 		li $s2, 0
		 		addi $s2, $t2, 2
		 		li $s3, 0
		 		addi $s3, $t2, 3
		 		
		 		lw $t0, addr_arg1
		 		and $t1, $t1, $s3
		 		
		 		li $s4, 0
		 		li $s5, 3 #or what?
		 		final:
		 			beq $s4, $s5, print_bobtail
		 			addi $s4, $s4, 1
		 			lbu $t3, 0($t0)
		 			addi $t0, $t0, 1
		 			and $t7, $t3, $s3
		 			bne $t1, $s7, final
		 			and $t6, $t3, $s2
		 			beq $t6, $s3, final
		 			beq $t6, $s2, final
		 			beq $t6, $s3, final
		 			b full_house
		 			
		print_bobtail:
			la $a0, big_bobtail_str
   			li $v0, 4
   			syscall 
   			j exit	
		
		
	full_house:
		lw $s0, addr_arg1
		li $s1, 0 
		li $s2, 4
		li $s5, 1 #counter for first rank
		li $t7, 1 #counter for second rank
		lbu $t0, 0($s0)
		li $s6, 0xF
		and $t0, $t0, $s6
			
		full_loop:
			beq $s1, $s2, check_counter1
			addi $s1, $s1, 1
			addi $s0, $s0, 1
			lbu $t1, 0($s0)
			and $t1, $t1, $s6
			beq $t1, $t0, inc_first
			b full_loop
		
		inc_first:
			addi $s5, $s5, 1
			b full_loop
		
		check_counter1:
			li $s7, 3 
			li $s3, 2
			
			beq $s5, $s7, counters
			beq $s5, $s3, counters
			b five_dime
			
		counters:
		
			beq $s5, $s7, finishcounter1
			beq $s5, $s3, finishcounter2
			
			finishcounter1:
			li $s7, 0
			b start_counter2
			
			finishcounter2:
			li $s3, 0
			b start_counter2
			
		start_counter2:	
			li $s1, 0
			li $s2, 3
			lw $s0, addr_arg1
			li $t2, 0
			looping_forcounter2:
				beq $s1, $s2, five_dime
				addi $s0, $s0, 1
				lbu $t1, 0($s0)
				and $t1, $t1, $s6
				bne $t1, $t0, starting_counter2
				addi $s1, $s1, 1
				b looping_forcounter2
				
		starting_counter2:
				beq $s1, $s2, final_checkingcounters
				addi $s1, $s1, 1
				addi $s0, $s0, 1
				lbu $t2, 0($s0)
				and $t2, $t2, $s6
				beq $t1, $t2, inc_second
				b starting_counter2
				
		inc_second:
			addi $t7, $t7, 1
			b starting_counter2
			
				
		final_checkingcounters:
			beq $t7, $s7, print_fullhouse
			beq $t7, $s3, print_fullhouse
			b five_dime
				
			
		print_fullhouse:
			la $a0, full_house_str
   			li $v0, 4
   			syscall 
   			j exit	
		
			
	
	five_dime:
		li $s1, 0
		li $s2, 5
		li $s7, 0xA
		li $s6, 0xF
		lw $s0, addr_arg1
		checkfor10:
			beq $s1, $s2, skeet
			addi $s1, $s1, 1
			lbu $t0, 0($s0)
			addi $s0, $s0, 1
			and $t0, $t0, $s6
			beq $t0, $s7, checkfor5
			b checkfor10
		checkfor5:
		li $s1, 0
		li $s2, 5
		li $s7, 0x5
		li $s6, 0xF
		lw $s0, addr_arg1
			looptocheck5:
			beq $s1, $s2, skeet
			addi $s1, $s1, 1
			lbu $t0, 0($s0)
			addi $s0, $s0, 1
			and $t0, $t0, $s6
			bne $t0, $s7, rangercheck510
			b looptocheck5
		
	rangercheck510:
		li $s6, 0xF
		li $s7, 0xA
		lw $s0, addr_arg1
		li $s1, 0
		li $s2, 5
			
		looplessthan10:
			beq $s1, $s2, greaterthan5
			addi $s1, $s1, 1
			lbu $t0, 0($s0)
			addi $s0, $s0, 1
			and $t0, $t0, $s6
			bgt $t0, $s7, blaze
			b looplessthan10
			
		greaterthan5:
			li $s6, 0xF
			li $s7, 0x5
			lw $s0, addr_arg1
			li $s1, 0
			li $s2, 5
			
		loopgreaterthan5:
			beq $s1, $s2, pairs_check
			addi $s1, $s1, 1
			lbu $t0, 0($s0)
			addi $s0, $s0, 1
			and $t0, $t0, $s6
			blt $t0, $s7, skeet
			b loopgreaterthan5
		
		pairs_check:
		
			lw $s0, addr_arg1
			lbu $t0, 0($s0)
			li $s1, 0
			li $s2, 4
			li $s6, 0xF
			and $t0, $t0, $s6
			check_first:
				beq $s1, $s2, check_second
				addi $s0, $s0, 1
				addi $s1, $s1, 1
				lbu $t1, 0($s0)
				and $t1, $t1, $s6
				beq $t1, $t0, blaze
				b check_first
			check_second:	
			lw $s0, addr_arg1
			lbu $t0, 1($s0)
			addi $s0, $s0, 2
			li $s1, 0
			li $s2, 3
			li $s6, 0xF
			and $t0, $t0, $s6
			check_secondloop:
				beq $s1, $s2, check_third
				addi $s0, $s0, 1
				addi $s1, $s1, 1
				lbu $t1, 0($s0)
				and $t1, $t1, $s6
				beq $t1, $t0, blaze
				b check_secondloop
			check_third:	
			lw $s0, addr_arg1
			lbu $t0, 2($s0)
			addi $s0, $s0, 3
			li $s1, 0
			li $s2, 2
			li $s6, 0xF
			and $t0, $t0, $s6
			check_thirdloop:
				beq $s1, $s2, check_fourth
				addi $s0, $s0, 1
				addi $s1, $s1, 1
				lbu $t1, 0($s0)
				and $t1, $t1, $s6
				beq $t1, $t0, blaze
				b check_thirdloop
			check_fourth:
				lw $s0, addr_arg1
				lbu $t0, 3($s0)
				li $s6, 0xF
				and $t0, $t0, $s6
				lbu $t1, 4($s0)
				and $t1, $t1, $s6
				beq $t1, $t0, blaze
				b print_dime
				
				
		print_dime:
			la $a0, five_and_dime_str
   			li $v0, 4
   			syscall 
   			j exit
	
		
	skeet:
		li $s6, 0xF
		li $s7, 0x9
		lw $s0, addr_arg1
		li $s1, 0
		li $s2, 5
			
		looplessthan:
			beq $s1, $s2, before_2
			addi $s1, $s1, 1
			lbu $t0, 0($s0)
			addi $s0, $s0, 1
			and $t0, $t0, $s6
			bgt $t0, $s7, blaze
			b looplessthan
		
		
		before_2:
		lw $s0, addr_arg1
		li $s1, 0
		li $s2, 5
		li $s7, 0xF
		li $s6, 0x2
		
		loop_for_2:
			beq $s1, $s2, blaze
			addi $s1, $s1, 1
			lbu $t0, 0($s0)
			addi $s0, $s0, 1
			and $t0, $t0, $s7
			beq $t0, $s6, check_doubles2
			b loop_for_2
			
		check_doubles2:
			beq $s1, $s2, loop_b4_5
		 	lbu $t0, 0($s0)
		 	and $t0, $t0, $s7
		 	beq $t0, $s6, blaze
		 	addi $s0, $s0, 1
		 	addi $s1, $s1, 1
		 	j check_doubles2
		 	
		loop_b4_5:
			li $s1, 0
			li $s2, 5
			lw $s0, addr_arg1
			li $s7, 0xF
			li $s6, 0x5
			
		loop_for_5:
			beq $s1, $s2, blaze
			addi $s1, $s1, 1
			lbu $t0, 0($s0)
			addi $s0, $s0, 1
			and $t0, $t0, $s7
			beq $t0, $s6, check_doubles5
			b loop_for_5
			
		check_doubles5:
			beq $s1, $s2, loop_b4_9
		 	lbu $t0, 0($s0)
		 	and $t0, $t0, $s7
		 	beq $t0, $s6, blaze
		 	addi $s0, $s0, 1
		 	addi $s1, $s1, 1
		 	j check_doubles5	
		
		loop_b4_9:
			li $s1, 0
			li $s2, 5
			lw $s0, addr_arg1
			li $s7, 0xF
			li $s6, 0x9
			
		loop_for_9:
			beq $s1, $s2, blaze
			addi $s1, $s1, 1
			lbu $t0, 0($s0)
			addi $s0, $s0, 1
			and $t0, $t0, $s7
			beq $t0, $s6, check_doubles9
			b loop_for_9
			
		check_doubles9:
			beq $s1, $s2, checkdoubles
		 	lbu $t0, 0($s0)
		 	and $t0, $t0, $s7
		 	beq $t0, $s6, blaze
		 	addi $s0, $s0, 1
		 	addi $s1, $s1, 1
		 	j check_doubles9
		
		
		checkdoubles:
			lw $s0, addr_arg1
			li $s1, 0x2
			li $s2, 0x5
			li $s3, 0x9
			li $s6, 0
			li $s7, 5
			li $s5, 0xF
			
			looper:
				beq $s6, $s7, print_skeet
				lbu $t0, 0($s0)
				addi $s0, $s0, 1
				addi $s6, $s6, 1
				and $t0, $t0, $s5
				beq $t0, $s1, looper
				beq $t0, $s2, looper
				beq $t0, $s3, looper
				b check_withlast
				
			check_withlast:
				beq $s6, $s7, print_skeet
				lbu $t1, 0($s0)
				and $t1, $t1, $s5
				beq $t1, $t0, blaze
				addi $s0, $s0, 1
				addi $s6, $s6, 1
				b check_withlast
						
			
		print_skeet:
			la $a0, skeet_str
   			li $v0, 4
   			syscall 
   			j exit
		
	
	blaze:
		li $s1, 0
		li $s2, 4
		
		blaze_loop:
		beq $s1, $s2, print_blaze
		addi $s1, $s1, 1
		lbu $t0, 0($s0)
		addi $s0, $s0, 1
		li $t1, 'K'
		beq $t0, $t1, blaze_loop
		li $t1, 'L'
		beq $t0, $t1, blaze_loop
		li $t1, 'M'
		beq $t0, $t1, blaze_loop
		li $t1, '['
		beq $t0, $t1, blaze_loop
		li $t1, 0x5C
		beq $t0, $t1, blaze_loop
		li $t1, ']'
		beq $t0, $t1, blaze_loop
		li $t1, 'k'
		beq $t0, $t1, blaze_loop
		li $t1, 'l'
		beq $t0, $t1, blaze_loop
		li $t1, 'm'
		beq $t0, $t1, blaze_loop
		li $t1, '{'
		beq $t0, $t1, blaze_loop
		li $t1, '|'
		beq $t0, $t1, blaze_loop
		li $t1, '}'
		beq $t0, $t1, blaze_loop
		j high_card
		
	print_blaze:
		la $a0, blaze_str
   		li $v0, 4
   		syscall 
   		j exit
	
	high_card: 
	   	la $a0, high_card_str
   		li $v0, 4
   		syscall
   		j exit

    
 give_invalid_operation_error:
   la $a0, invalid_operation_error
   li $v0, 4
   syscall
   j exit
    
give_invalid_args_error:
   la $a0, invalid_args_error
   li $v0, 4
   syscall
   j exit
   
print_newline:
	li $a0, '\n'
	li $v0, 11
	syscall

exit:
    li $v0, 10
    syscall
