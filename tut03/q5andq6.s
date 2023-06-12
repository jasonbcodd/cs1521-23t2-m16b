#// A simple program that will read 10 numbers into an array

#define N_SIZE 10

#include <stdio.h>

#int main(void) {
#    int i;
#    int numbers[N_SIZE] = {0};

#    i = 0;
#    while (i < N_SIZE) {
#        scanf("%d", &numbers[i]);
#        i++;
#    }
#}

#// A simple program that will print 10 numbers from an array

#define N_SIZE 10

#include <stdio.h>

#int main(void) {
#    int i;
#    int numbers[N_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

#    i = 0;
#    while (i < N_SIZE) {
#        printf("%d\n", numbers[i]);
#        i++;
#    }
#}


N_SIZE = 10

	.text
main:
	# int i in $t0


while_i_lt_n_size__init:
	li	$t0, 0					# i = 0
while_i_lt_n_size__cond:
	# if i >= N_SIZE, exit loop
	bge	$t0, N_SIZE, while_i_lt_n_size__end	# while (i < N_SIZE)
while_i_lt_n_size__body:
	li	$v0, 5
	syscall


	mul	$t1, $t0, 4				# $t1 = &numbers[i] - &numbers[0]
	addi	$t1, $t1, 2
	sw	$v0, numbers($t1)

	addi	$t0, $t0, 1				# i++;
	j 	while_i_lt_n_size__cond
while_i_lt_n_size__end:

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



	li	$v0, 0
	jr 	$ra

	.data
numbers:
	.byte 0:40					# int numbers[10] = {0};
