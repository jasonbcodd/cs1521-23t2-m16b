#include <stdio.h>
#include <stdlib.h>
#define BUF_LEN 16

int main(int argc, char **argv) {
    char buf[BUF_LEN];
    int buf_index = 0;

    for (int i = 1; i < argc; i++) {
        FILE *f = fopen(argv[i], "r");
        if (f == NULL) {
            perror(argv[i]);
            return 1;
        }

        int c = 0;

        while (c != EOF) {
            while ((c = fgetc(f)) != EOF) {
                if (c == '\n') break;
                buf[buf_index++] = (char)c;
            }

            buf[buf_index++] = 0;

            long data = strtol(buf, NULL, 16);

            printf("%d, ", (int)(data & 0xFF));
            buf_index = 0;
        }

        fclose(f);
    }
}