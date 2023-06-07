#// Prints the square of a number

#include <stdio.h>

#int main(void) {
#    int x, y;

#    printf("Enter a number: ");
#    scanf("%d", &x);

#    y = x * x;

#    printf("%d\n", y);

#    return 0;
#}


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
	mul	$t1, $t0, $t0		# y = x * x

	li	$v0, 1
	move	$a0, $t1
	syscall				# printf("%d", y);

	li	$v0, 11	
	li	$a0, '\n'
	syscall


	li	$v0, 0
	jr 	$ra			# return 0

	.data

prompt:
	.asciiz "Enter a number: "