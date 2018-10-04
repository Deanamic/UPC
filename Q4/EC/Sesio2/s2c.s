.data
	w:			.asciiz	"8754830094826456674949263746929"
	resultat: 	.byte  1
.text
MAIN:
	addiu 	$sp,$sp,-4
	sw 		$ra,0($sp)
	la		$a0,w
	li		$a1,31
	jal 	MODA
	la 		$t0,resultat
	sb 		$v0,0($t0)
	move 	$a0,$v0
	li 		$v0,11
	syscall
	lw 		$ra,0($sp)
	addiu 	$sp,$sp,4
	b		FIN
	
MODA:
	addiu 	$sp,$sp,-64
	sw 		$ra,0($sp)
	sw 		$s0,4($sp)
	sw 		$s1,8($sp)
	sw 		$s2,12($sp)
	sw 		$s3,16($sp)
	sw 		$s4,20($sp)
	addiu	$s4,$sp,24
	move 	$s0,$zero
	move	$s2,$a0
	move	$s3,$a1
	li		$t0,10
FOR:
	bge		$s0,$t0,FIFOR
	sll		$t1,$s0,2
	addu 	$t1,$t1,$s4
	sw		$zero,0($t1)
	addiu	$s0,$s0,1
	b FOR
FIFOR:
	move 	$s1,$zero
	move 	$s0,$zero
FOR2:
	bge		$s0,$s3,FIFOR2
	move 	$a0,$s4
	addu	$t0,$s0,$s2
	lb		$a1,0($t0)
	addiu	$a1,$a1,-48 # '0' = 48
	move 	$a2,$s1
	addiu	$a2,$a2,-48
	jal 	UPDATE
	move	$s1,$v0
	addiu	$s1,$s1,48
	addiu	$s0,$s0,1
	b FOR2
FIFOR2:
	move	$v0,$s1
	lw 		$ra,0($sp)
	lw 		$s0,4($sp)
	lw 		$s1,8($sp)
	lw 		$s2,12($sp)
	lw 		$s3,16($sp)
	lw 		$s4,20($sp)
	addiu 	$sp,$sp,64
	jr 		$ra
	
UPDATE:
	addiu 	$sp,$sp,-16
	sw 		$ra,0($sp)
	sw 		$s0,4($sp)
	sw 		$s1,8($sp)
	sw 		$s2,12($sp)
	move 	$s0,$a0
	move	$s1,$a1
	move	$s2,$a2
	#jal 	nofares
	sll		$t0,$s1,2
	addu	$t0,$t0,$s0
	lw		$t1,0($t0)
	addiu	$t1,$t1,1
	sw		$t1,0($t0)
	sll		$t2,$s2,2
	addu	$t2,$s0,$t2
	lw		$t2,0($t2)
IF:
	ble		$t1,$t2,ELSE
	move	$v0,$s1
	b		FI
ELSE:
	move $v0,$s1
FI:
	lw 		$ra,0($sp)
	lw 		$s0,4($sp)
	lw 		$s1,8($sp)
	lw 		$s2,12($sp)
	addiu 	$sp,$sp,16
	jr	$ra
	
FIN:
	
	
	
	
	
	
