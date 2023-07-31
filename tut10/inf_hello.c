#include <stdio.h>
#include <stdbool.h>

#include <pthread.h>
#include <libc.h>


void *thread_func(void *data) {
    while (true) {
        printf("%s\n", (char *)data);
        sleep(5);
    }

    return NULL;
}



int main() {

    pthread_t thread;
    pthread_create(&thread, NULL, thread_func, "Hello");

    while(true) {
        printf("there\n");
        sleep(5);
    }

    return 0;
}