#include <stdlib.h>

void set (int** y, int v){
    int* z;
    z = *y;
    *z =  v;
}

void foo (){
    int** x = malloc(sizeof(int*));
    if(x != NULL){
        //*x = NULL;
        *x = malloc(sizeof(int));
        set(x, 1);
        //free(*x);
    }   
    free(x);
}