#include <stdlib.h>

void set (int** y, int v){
    int* z;
    z = *y;
    *z =  v;
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
void foo (){
    int** x = malloc(sizeof(int*));
    if(x != NULL){
        //*x = NULL;
        *x = malloc(sizeof(int));
        free(*x);
        set(x, 1);
        //free(*x);
    }   
    free(x);
}

