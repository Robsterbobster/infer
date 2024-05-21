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


void vendor_code(int* x){
    int value;
    if (x != NULL){
        value = *x;
    }
    //do something
}

void foo1(){
    int* p1 = (int*) malloc(sizeof(int));
    int p2[] = {1,2,3};
    vendor_code(p1);
    if (p1 != NULL){
        *p1 = 1;
    }
}


void foo2(){
    int* p1 = (int*) malloc(sizeof(int));
    vendor_code(p1);
    // do something unrelated to p1
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
