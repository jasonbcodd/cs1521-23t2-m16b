#include <stdio.h>
#include <string.h>

int arr[] ={1,2,3,4,5,6,7};

int main(int argc, char **argv) {
    int firstElem = arr[1];
    printf("argc=%d\n", argc);
    for (int i = 0; i < argc; i++) {
        for (int j = 0; j < strlen(argv[i]); j++) {
            printf("%c\n", argv[i][j]);
        }

    }

    return 0;
}


// 1, 2, 3, 4, 5, 6, 7

