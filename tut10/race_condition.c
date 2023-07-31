#include <stdio.h>
#include <pthread.h>
#include <stdatomic.h>

int global_total1 = 0;
int global_total2 = 0;
pthread_mutex_t my_mutex1 = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t my_mutex2 = PTHREAD_MUTEX_INITIALIZER;

void *add_5000_to_counter(void *data) {
    for (int i = 0; i < 5000; i++) {
        // sleep for 1 nanosecond
        //nanosleep (&(struct timespec){.tv_nsec = 1}, NULL);

        // increment the global total by 1
        pthread_mutex_lock(&my_mutex1);
        global_total1 = global_total1 + 1;
        pthread_mutex_lock(&my_mutex2);
        global_total2 = global_total2 + 1;
        pthread_mutex_unlock(&my_mutex2);
        pthread_mutex_unlock(&my_mutex1);
    }

    return NULL;
}

void *add_5000_to_counter2(void *data) {
    for (int i = 0; i < 5000; i++) {
        // sleep for 1 nanosecond
        //nanosleep (&(struct timespec){.tv_nsec = 1}, NULL);

        // increment the global total by 1
        pthread_mutex_lock(&my_mutex1);
        global_total2 = global_total2 + 1;

        pthread_mutex_lock(&my_mutex2);
        global_total1 = global_total1 + 1;
        pthread_mutex_unlock(&my_mutex1);
        pthread_mutex_unlock(&my_mutex2);
    }

    return NULL;
}


/*
 *
 * thread1: lw global_total(0) into $t1; $t1 = 0
 * thread1: addi $t1, $t1, 1; $t1 = 1
 * thread2: lw global_total(0) into $t2; $t2 = 0
 * thread2: addi $t2, $t2, 1; $t1
 * thread2: sw $t2, global_total(0)
 * thread1: sw $t1, global_total(0)
 *
 *
 *
 */

int main(void) {
    pthread_t thread1;
    pthread_create(&thread1, NULL, add_5000_to_counter, NULL);

    pthread_t thread2;
    pthread_create(&thread2, NULL, add_5000_to_counter2, NULL);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    // if program works correctly, should print 10000
    printf("Final total: %d\n", global_total1);
    printf("Final total: %d\n", global_total2);
}