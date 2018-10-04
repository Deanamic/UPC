	
	li $s0,2 # X
	li $s1,8 # Y

	li $t0,1
	sllv $t0,$t0,$s0
	addiu $t0,$t0,-1
	xor $s1,$s1,$t0
