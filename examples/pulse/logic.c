#include <stdlib.h>

void set (int p1, int p2, int p3){
    int* x;
    int f = 10;
    if (p1 > 0 && p2 > 0){
        good();
    }else{
        if (p3 > 0){
            x = malloc(sizeof(int*));
            *x = f;
            free(x);
        }else{
            good();
        }
    }
}

int good(){
    return 0;
}

void foo (){
    set(0,1,1);
}

