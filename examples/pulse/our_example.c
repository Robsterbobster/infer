#include <stdlib.h>

void set (int** y, int v, int g){
    if (g == 4){
        int* z;
        z = *y;
        *z =  v;
    }
}

void foo (){
    int** x;
    int g;
    g = rand();
    x = malloc(sizeof(int*));
    if(x != NULL){
        *x = malloc(sizeof(int));
        set(x, 1, g);
        free(*x);
    }   
    free(x);
}

