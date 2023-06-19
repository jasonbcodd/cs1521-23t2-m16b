 #/*
 #* 
 #* nrows:  Number of rows in the matrix
 #* ncols:  Number of columns in the matrix
 #* M:      Matrix M
 #* factor: Scalar factor to multiply by
 #*/
#void change (int nrows, int ncols, int M[nrows][ncols], int factor)
#{
#    for (int row = 0; row < nrows; row++) {
#        for (int col = 0; col < ncols; col++) {
#            M[row][col] = factor * M[row][col];
#        }
#    }
#}
 



	.text
main:
main__prologue:
	begin
	push $ra
main__body:
	li   	$a0, 3
   	li   	$a1, 4
   	la   	$a2, M
   	li   	$a3, 2


  	jal  	change

	li   	$a0, 3
   	li   	$a1, 4
   	la   	$a2, M
	jal 	print_2d_array

main__epi:
	pop $ra
	end


	li 	$v0, 0
	jr 	$ra		# return 0;


change:
change__prologue:
	begin
change__body:
change__for_row__init:
	li 	$t0, 0		# row in $t0
change__for_row__cond:
	bge	$t0, $a0, change__for_row__epi
change__for_row__body:
change__for_col__init:
	li 	$t1, 0		# row in $t1
change__for_col__cond:
	bge	$t1, $a1, change__for_col__epi
change__for_col__body:
	mul	$t2, $t0, $a1	
	add	$t2, $t2, $t1	# $t2 is index offset
	mul	$t2, $t2, 4	# $t2 is address offset
	add	$t2, $a2, $t2	# $t3 = &M[row][col]
	lw	$t3, ($t2)
	mul	$t3, $t3, $a3
	sw	$t3, ($t2)
change__for_col__step:
	addi 	$t1, $t1, 1	# col++
	j change__for_col__cond
change__for_col__epi:
change__for_row__step:
	addi	$t0, $t0, 1	# row++
	j change__for_row__cond
change__for_row__epi:

change__epi:
	end
	jr 	$ra


print_2d_array:
print_2d_array__prologue:
	begin
	push $s0
print_2d_array__body:
	move	$s0, $a0
print_2d_array__for_row__init:
	li 	$t0, 0		# row in $t0
print_2d_array__for_row__cond:
	bge	$t0, $s0, print_2d_array__for_row__epi
print_2d_array__for_row__body:
print_2d_array__for_col__init:
	li 	$t1, 0		# row in $t1
print_2d_array__for_col__cond:
	bge	$t1, $a1, print_2d_array__for_col__epi
print_2d_array__for_col__body:
	mul	$t2, $t0, $a1	
	add	$t2, $t2, $t1	# $t2 is index offset
	mul	$t2, $t2, 4	# $t2 is address offset
	add	$t2, $a2, $t2	# $t3 = &M[row][col]
	lw	$a0, ($t2)
	li	$v0, 1
	syscall
	li	$a0, ','
	li	$v0, 11
	syscall
print_2d_array__for_col__step:
	addi 	$t1, $t1, 1	# col++
	j print_2d_array__for_col__cond
print_2d_array__for_col__epi:
	li	$a0, '\n'
	li	$v0, 11
	syscall
print_2d_array__for_row__step:
	addi	$t0, $t0, 1	# row++
	j print_2d_array__for_row__cond
print_2d_array__for_row__epi:

print_2d_array__epi:
	pop 	$s0
	end
	jr 	$ra
 
   
#Where M is defined as:

    .data
M:  .word 1, 2, 3, 4
    .word 3, 4, 5, 6
    .word 5, 6, 7, 8