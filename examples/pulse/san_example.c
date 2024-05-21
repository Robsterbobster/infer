#include <stdlib.h>
#include "san_example2.c"

void foo1(){
    int* x = vendor_code(1);
    *x = 1;
}

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

