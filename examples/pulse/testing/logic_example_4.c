#include <stdlib.h>

int good(){
    return 0;
}

void set (int p1, int p2, int p3){
    int* x;
    if (p1 > 0 && p2 > 0){
        //error
        x = NULL;
        *x = 1;
    }else{
        if (p3 > 0){
            //error
            x = NULL;
            *x = 1;
        }else{
            good();
        }
    }
}

void foo (){
    int x = 0;
    int y = 2;
    int z = 3;
    set(x, y, z);
}