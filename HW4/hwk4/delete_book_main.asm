.data
empty: .asciiz "empty"
deleted: .asciiz "deleted"

isbn: .asciiz "9780802122550"
books:
.align 2
.word 7 7 68
# Book struct start
.align 2
.ascii "9780553214830\0"
.ascii "The Declaration of Indep\0"
.ascii "Founding Fathers\0\0\0\0\0\0\0\0\0"
.word 0
# Book struct start
.align 2
.ascii "9780446695660\0"
.ascii "Double Whammy\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "Carl Hiaasen\0\0\0\0\0\0\0\0\0\0\0\0\0"
.word 0
# Book struct start
.align 2
.ascii "9780060855900\0"
.ascii "Equal Rites (Discworld, \0"
.ascii "Terry Pratchett\0\0\0\0\0\0\0\0\0\0"
.word 0
# Book struct start
.align 2
.ascii "9780345527780\0"
.ascii "Wicked Business (Lizzy &\0"
.ascii "Janet Evanovich\0\0\0\0\0\0\0\0\0\0"
.word 0
# Book struct start
.align 2
.ascii "9788433914260\0"
.ascii "Hollywood\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "Charles Bukowski\0\0\0\0\0\0\0\0\0"
.word 0
# Book struct start
.align 2
.ascii "9780312577220\0"
.ascii "Fly Away (Firefly Lane, \0"
.ascii "Kristin Hannah\0\0\0\0\0\0\0\0\0\0\0"
.word 0
# Book struct start
.align 2
.ascii "9781620610090\0"
.ascii "Opal (Lux, #3)\0\0\0\0\0\0\0\0\0\0\0"
.ascii "Jennifer L. Armentrout\0\0\0"
.word 0



.text
.globl main
main:
li $s0, 14
li $s1, 15
li $s2, 16
li $s3, 17
li $s4, 18
li $s5, 19
li $s6, 20
li $s7, 21



la $a0, books
la $a1, isbn
jal delete_book

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

la $a1, books
li $t1, 0
li $t7, 0

lw $t5, 4($a1)
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

