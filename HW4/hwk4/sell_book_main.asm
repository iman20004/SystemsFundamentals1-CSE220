.data
empty: .asciiz "empty"
deleted: .asciiz "deleted"


isbn: .asciiz "9781416971700"
customer_id: .word 1523
sale_date: .asciiz "2022-10-14"
sale_price: .word 323
books:
.align 2
.word 7 6 68
# Book struct start
.align 2
.ascii "9780345501330\0"
.ascii "Fairy Tail, Vol. 1 (Fair\0"
.ascii "Hiro Mashima, William Fl\0"
.word 3
# empty or deleted entry starts here
.align 2
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
# Book struct start
.align 2
.ascii "9780060855900\0"
.ascii "Equal Rites (Discworld, \0"
.ascii "Terry Pratchett\0\0\0\0\0\0\0\0\0\0"
.word 103
# Book struct start
.align 2
.ascii "9780670032080\0"
.ascii "Financial Peace Revisite\0"
.ascii "Dave Ramsey\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.word 61
# Book struct start
.align 2
.ascii "9780064408330\0"
.ascii "Joey Pigza Swallowed the\0"
.ascii "Jack Gantos\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.word 45
# Book struct start
.align 2
.ascii "9780312577220\0"
.ascii "Fly Away (Firefly Lane, \0"
.ascii "Kristin Hannah\0\0\0\0\0\0\0\0\0\0\0"
.word 814
# Book struct start
.align 2
.ascii "9781416971700\0"
.ascii "Out of My Mind\0\0\0\0\0\0\0\0\0\0\0"
.ascii "Sharon M. Draper\0\0\0\0\0\0\0\0\0"
.word 1

sales:
.align 2
.word 9 9 28
# BookSale struct start
.align 2
.ascii "9780345501330\0"
.byte 0 0
.word 723341
.word 155229
.word 55
# BookSale struct start
.align 2
.ascii "9781416971700\0"
.byte 0 0
.word 2323432
.word 155033
.word 22
# BookSale struct start
.align 2
.ascii "9780060855900\0"
.byte 0 0
.word 920192
.word 158610
.word 61
# BookSale struct start
.align 2
.ascii "9780345501330\0"
.byte 0 0
.word 81321
.word 151269
.word 192
# BookSale struct start
.align 2
.ascii "9780312577220\0"
.byte 0 0
.word 777233
.word 155229
.word 55
# BookSale struct start
.align 2
.ascii "9780312577220\0"
.byte 0 0
.word 2424
.word 151912
.word 125
# BookSale struct start
.align 2
.ascii "9780345501330\0"
.byte 0 0
.word 26234
.word 155229
.word 55
# BookSale struct start
.align 2
.ascii "9780312577220\0"
.byte 0 0
.word 12312
.word 155229
.word 55
# BookSale struct start
.align 2
.ascii "9780064408330\0"
.byte 0 0
.word 73123
.word 155229
.word 55




.text
.globl main
main:
li $s0, 1
li $s1, 2
li $s2, 3
li $s3, 4
li $s4, 5
li $s5, 6
li $s6, 7
li $s7, 8



la $a0,  sales
la $a1,  books
la $a2,  isbn
lw $a3,  customer_id
la $t0,  sale_date
lw $t1,  sale_price
addi $sp, $sp, -8
sw $t0, 0($sp)
sw $t1, 4($sp)
li $t0, 929402 # garbage
li $t1, 6322233 # garbage
jal sell_book

# Write code to check the correctness of your code!
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

la $a1, sales
li $t1, 0
li $t7, 0

lw $t5, 0($a1)
move $a0, $t5
li $v0, 1
syscall 

li $a0, 0x20
li $v0, 11
syscall

lw $t5, 4($a1)
move $a0, $t5
li $v0, 1
syscall 

li $a0, 0x20
li $v0, 11
syscall

lw $t5, 8($a1)
move $a0, $t5
li $v0, 1
syscall 

li $a0, '\n'
li $v0, 11
syscall

lw $t2, 8($a1)
lw $t3, 0($a1)
addi $a1, $a1, 12
printing_loop1:
	beq $t7, $t3, printing_loop2 
	lbu $a0, 0($a1)
	li $t0, 0x39
	beq $a0, $t0, print_sale
	li $t6, 0xFF
	beq $a0, $t6, deleted_case1
	la $a0, empty
	li $v0, 4
	syscall
	add $a1, $a1, $t2
	addi $t1, $t1, 1
	j next_byte1
	
	deleted_case1:
	la $a0, deleted
	li $v0, 4
	syscall
	add $a1, $a1, $t2
	addi $t1, $t1, 1
	j next_byte1

next_byte1:
	li $a0, '\n'
	li $v0, 11 
	syscall
	li $t1, 0
	addi $t7, $t7, 1
	j printing_loop1
	
print_sale:
	li $t0, 0
	li $t1, 13
	print_isbn1:
		beq $t0, $t1, print_padding
		lbu $a0, 0($a1)
		li $t4, 0x30
		sub $a0, $a0, $t4
		li $v0, 1
		syscall 
		addi $a1, $a1, 1
		addi $t0, $t0, 1
		b print_isbn1
		
	print_padding:
		lbu $a0, 0($a1)
		li $v0, 11
		syscall
		li $a0, 0x20
		li $v0, 11
		syscall
		addi $a1, $a1, 1
		lbu $a0, 0($a1)
		li $v0, 1
		syscall
		addi $a1, $a1, 1
		lbu $a0, 0($a1)
		li $v0, 1
		syscall
		addi $a1, $a1, 1
		
		li $a0, 0x20
		li $v0, 11
		syscall
		
		print_id:
		lw $a0, 0($a1)
		li $v0, 1
		syscall
		addi $a1, $a1, 4
		
		li $a0, 0x20
		li $v0, 11
		syscall
		
		print_date:
		lw $a0, 0($a1)
		li $v0, 1
		syscall
		addi $a1, $a1, 4
		
		li $a0, 0x20
		li $v0, 11
		syscall
		
		print_price:
		lw $a0, 0($a1)
		li $v0, 1
		syscall
		addi $a1, $a1, 4
		j next_byte1
		
printing_loop2:
li $a0, '\n'
li $v0, 11
syscall

la $a1, books
li $t1, 0
li $t7, 0

lw $t5, 0($a1)
move $a0, $t5
li $v0, 1
syscall 

li $a0, 0x20
li $v0, 11
syscall

lw $t5, 4($a1)
move $a0, $t5
li $v0, 1
syscall 

li $a0, 0x20
li $v0, 11
syscall

lw $t5, 8($a1)
move $a0, $t5
li $v0, 1
syscall 

li $a0, '\n'
li $v0, 11
syscall

lw $t2, 8($a1)
lw $t3, 0($a1)
addi $a1, $a1, 12
printing_loop:
	beq $t7, $t3, exit
	lbu $a0, 0($a1)
	li $t0, 0x39
	beq $a0, $t0, print_book
	li $t6, 0xFF
	beq $a0, $t6, deleted_case
	la $a0, empty
	li $v0, 4
	syscall
	add $a1, $a1, $t2
	addi $t1, $t1, 1
	j next_byte
	deleted_case:
	la $a0, deleted
	li $v0, 4
	syscall
	add $a1, $a1, $t2
	addi $t1, $t1, 1
	j next_byte
	

next_byte:
	li $a0, '\n'
	li $v0, 11 
	syscall
	li $t1, 0
	addi $t7, $t7, 1
	j printing_loop
	
print_book:
	li $t0, 0
	li $t1, 13
	print_isbn:
		beq $t0, $t1, print_title
		lbu $a0, 0($a1)
		li $t4, 0x30
		sub $a0, $a0, $t4
		li $v0, 1
		syscall 
		addi $a1, $a1, 1
		addi $t0, $t0, 1
		b print_isbn
		
	print_title:
		lbu $a0, 0($a1)
		li $v0, 11
		syscall
		addi $a1, $a1, 1
		
		li $t0, 0
		li $t1, 25
		title_loop:
			beq $t0, $t1, print_author
			lbu $a0, 0($a1)
			li $v0, 11
			syscall 
			addi $a1, $a1, 1
			addi $t0, $t0, 1
			b title_loop
	
	print_author:
		li $t0, 0
		li $t1, 25
		author_loop:
			beq $t0, $t1, print_sold
			lbu $a0, 0($a1)
			li $v0, 11
			syscall 
			addi $a1, $a1, 1
			addi $t0, $t0, 1
			b author_loop
			
	print_sold:
		lw $a0, 0($a1)
		li $v0, 1
		syscall
		addi $a1, $a1, 4
		j next_byte
	
exit:
li $v0, 10
syscall


.include "hwk4.asm"
