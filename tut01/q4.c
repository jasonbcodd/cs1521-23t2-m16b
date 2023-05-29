#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv) {


    if (argc < 2) {
        return 1;
    }

    char *new_string = calloc(sizeof(char), (2 * strlen(argv[1]) + 1));

    for (int i = 0; i < strlen(argv[1]); i++) {
        new_string[i] = argv[1][i];
        new_string[strlen(argv[1]) + i] = argv[1][i];
    }

    new_string[(2 * strlen(argv[1]))] = '\0';

    printf("%s\n", new_string);


    free(new_string);

    return 0;
}