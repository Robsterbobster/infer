#include <stdlib.h>
#include "san_example2.c"

void foo1(){
    int* x = vendor_code(1);
    *x = 1;
}

