#include <stdlib.h>
/*
int test(int* p1, int x){
    x = *p1;
}

void foo(){
    int x = 10;
    int* a = (int *)malloc(sizeof(int));
    if (a == NULL){test(NULL, x);}
    free(a);
} 
*/


int* vendor_code(int* x){
    int value;
    //foo1: successful deref, x's blame transfered to vendor 
    //foo2: unsuccessful deref, no blame transfer, x's blame is client
    value = *x;
    //do something
    free(x);
    //foo1: x's (resource's) blame is assigned to vendor 
    x = (int*) malloc(sizeof(int));
    assert(x == NULL);
    return x;
}

void foo1(){
    //blame of p1 is assigned to client
    int* p1 = (int*) malloc(sizeof(int));
    assert (p1 != NULL);
    p1 = vendor_code(p1);
    // p1 is null, thus unsuccessful deref, p1's blame remains to vendor
    *p1 = 1;
}

void foo2(){
    //blame of p1 is assigned to client
    int* p1 = (int*) malloc(sizeof(int));
    assert (p1 == NULL);
    p1 = vendor_code(p1);
    *p1 = 1;
}


/*
void foo(int* p1, int x){
    //p1 = (int *)malloc(sizeof(int));
    //x = 1;
    //*p1 = 1;
    //p1 = good(p1);
    if (p1 != NULL){
        //*p1 = 1;
        x = *p1;
        //p1 = good(p1);
        //x = *p1;
    }
    //p1 = NULL;
    //x = *p1;
    //free(p1);
}
*/


/*
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

void goo(){
    test (NULL, 1);
}
*/
