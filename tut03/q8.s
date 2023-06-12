#// A short program that reverses an array by swapping elements.

#define N_SIZE 10
#define N_SIZE_M_1 N_SIZE - 1
#define N_SIZE_D_2 N_SIZE / 2

#include <stdio.h>

#int main(void) {
#    int i;
#    int numbers[N_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

#    i = 0;
#    while (i < N_SIZE_D_2) {
#        int x = numbers[i];
#        int y = numbers[N_SIZE_M_1 - i];

#        numbers[i] = y;
#        numbers[N_SIZE_M_1 - i] = x;

#        i++;
#    }
#}

N_SIZE = 10
N_SIZE_M_1 = N_SIZE - 1
N_SIZE_D_2 = N_SIZE / 2



	.text
main:
	# int i in $t0
	li 	$t0, 0				# i = 0
while_i_lt_N_SIZE_D_2:
while_i_lt_N_SIZE_D_2__cond:
	bge	$t0, N_SIZE_D_2, while_i_lt_N_SIZE_D_2__end	# while (i < N_SIZE_D_2)
while_i_lt_N_SIZE_D_2__body:
	# int x in $t1
	# int y in $t2

	# offset1 in $t3
	mul	$t3, $t0, 4			# offset = $t0 * 4 <-> &numbers[i] - &numbers[0];
	lw	$t1, numbers($t3)		# int x = numbers[i];

	# offset2 in $t4
	sub	$t4, N_SIZE_M_1, $t0		# offset = N_SIZE_M_1 - i;
	mul	$t4, $t4, 4			# offset = &numbers[N_SIZE_M_1 - i] - &numbers[0];
	lw	$t2, numbers($t4)		# int y = numbers[N_SIZE_M_1 - i];


	sw	$t2, numbers($t3)		# numbers[i] = y;
	sw	$t1, numbers($t4)		# numbers[N_SIZE_M_1 - i] = x;


	addi	$t0, $t0, 1			# i++;
	j 	while_i_lt_N_SIZE_D_2__cond	# goto while_i_lt_N_SIZE_D_2__body
while_i_lt_N_SIZE_D_2__end:
	li 	$t0, 0					# i = 0

while_i_lt_n_size_print__init:
while_i_lt_n_size_print__cond:
	bge	$t0, N_SIZE, while_i_lt_n_size_print__end	# while (i < N_SIZE)
while_i_lt_n_size_print__body:
	mul	$t1, $t0, 4				# $t1 = &numbers[i] - &numbers[0]


	lw	$a0, numbers($t1)			# $a0 = numbers[i]
	li	$v0, 1
	syscall						# printf("%d", numbers[i]);

	li	$a0, '\n'
	li	$v0, 11
	syscall						# printf("%c", '\n');

	addi	$t0, $t0, 1				# i++;
	j 	while_i_lt_n_size_print__cond
while_i_lt_n_size_print__end:


	li 	$v0, 0
	jr 	$ra					# return 0;

	.data
numbers:
	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9	# int numbers[N_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};