#include <stdlib.h>

int good(int* p1){
    //p1 = (int *)malloc(sizeof(int));
    free(p1);
    return p1;
}

void abc(int* p1, int x){
    p1 = (int *)malloc(sizeof(int));
    //x = 1;
    if (p1 != NULL){
        *p1 = 1;
        //x = *p1;
        p1 = good(p1);
        //x = *p1;
    }
    //free(p1);
}

int test(int* p1, int x){
    x = *p1;
}

void set (int* p1){
    return 0;
}

void boo (int* p1, int* p2){
    p1 = p2;
    return 0;
}

void goo(int* p1, int* p2){
    p1 = p2;
    int y = *p2;
}
