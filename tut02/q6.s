#include <stdio.h>

#int main(void) {
#    int x;
#    printf("Enter a number: ");
#    scanf("%d", &x);

#    if (x > 100 && x < 1000) {
#        printf("medium\n");
#    } else {
#        printf("small/big\n");
#    }
#}



#    if (x <= 100 || x >= 1000) {
#	printf("small/big\n");
#        
#    } else {
#        printf("medium\n");
#    }

	.text
main:
	# int x in $t0
	# int y in $t1

	li 	$v0, 4
	la	$a0, prompt		# printf("Enter a number: ");
	syscall

	li 	$v0, 5			# scanf("%d", &x);
	syscall

	move 	$t0, $v0		# x = $v0


if_x_small_big:
	#ble	$t0, 100, if_x_small_big__else
	#bge	$t0, 1000, if_x_small_big__else

	sle	$t1, $t0, 100
	sge	$t2, $t0, 1000
	or	$t1, $t1, $t2
	bnez	$t1, if_x_small_big__else

	li	$v0, 4
	la	$a0, str_medium
	syscall

	b 	if_x_small_big__end
if_x_small_big__else:
	li	$v0, 4
	la	$a0, str_small_big
	syscall
if_x_small_big__end:


	li	$v0, 0
	jr 	$ra			# return 0

	.data

prompt:
	.asciiz "Enter a number: "
str_medium:
	.asciiz "medium\n"

str_small_big:
	.asciiz "small/big\n"