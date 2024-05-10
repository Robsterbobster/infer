#include <stdlib.h>

void set (int* p, int val){
    /*int* result = (int*)malloc(sizeof(int));
    if (val > 5){
        *p = val;
    }
    if (result != NULL)
        *result = 1;*/
    p = (int*)malloc(sizeof(int));
    //return result;
}

/*
int* vendor (int v){
    return NULL;
}

void foo1(){
    int* x = vendor(1);
    *x = 1;
}
*/
/*void foo (){
    int* x = (int*)malloc(sizeof(int));
    int y = rand();
    free(x);
    set(x, y);
    //int* z = set(x, y);
    //int a = *z;
    free(x);
    //free(z);
}*/

