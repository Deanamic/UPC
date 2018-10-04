.data
	result: .word	0
	num: 	.byte 	'z'
.text
	li $t0,'a'
	li $t1,'z'
	li $t2,'A'
	li $t3,'Z'
	li $t4,'0'
	li $t5,'9'
	la $t6,num
	la $t7,result
	lbu $t6,0($t6)
AND1:	
	blt $t6,$t0,AND2
	ble $t6,$t1,LLETRA
AND2:
	blt $t6,$t2,IF
	ble $t6,$t3,LLETRA
IF:	
	blt $t6,$t4,ELSE
	ble $t6,$t5,IF2
	b ELSE
LLETRA:
	sw $t6,0($t7)
	b FI
IF2:
	subu $t6,$t6,$t4
	sw $t6,0($t7)
	b FI
ELSE:
	li $t6,-1
	sw $t6,0($t7)
FI:
	
	