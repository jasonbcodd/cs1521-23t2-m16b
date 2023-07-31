#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char **environ;

int main(int argc, char **argv) {
    for (int i = 0; environ[i] != NULL; i++) {
        printf("%s\n", environ[i]);
    }


    char *home_path = getenv("HOME");

    if (home_path == NULL) {
        printf("unable to get home path\n");
        return 1;
    }


    int path_len = strlen(home_path) + 1 + 6 + 1;

    char *diary_path = malloc(path_len * sizeof(char));
    strcpy(diary_path, home_path);
    strcat(diary_path, "/.diary");

    FILE *f = fopen(diary_path, "r");
    if (f == NULL) {
        perror("unable to open file");
        free(diary_path);
        return 1;
    }

    int c;

    while ((c = fgetc(f)) != EOF) {
        fputc(c, stdout);
    }

    int i = 0;
    char c;
    while ((c = diary_path[i++]) != 0) {

    }

    printf("Home path: %s\n", diary_path);


    fclose(f);
    free(diary_path);

    return 0;
}