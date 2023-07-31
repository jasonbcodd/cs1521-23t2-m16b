#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

int main(int argc, char **argv) {

    for (int i = 1; i < argc; i++) {
        struct stat info;
        stat(argv[i], &info);

        if (info.st_mode & S_IWOTH) {
            printf("removing public write from %s\n", argv[i]);
            info.st_mode &= ~S_IWOTH;
            chmod(argv[i], info.st_mode);
        } else {
            printf("%s is not publically writable\n", argv[i]);
        }

    }

    return 0;
}