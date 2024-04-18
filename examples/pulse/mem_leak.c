#include <stdlib.h>
#include "mem_leak_usage.c"


void foo (){
  int cond = rand();
  int* x = (int *)malloc(sizeof(int));
  if (x != NULL){
    *x = 2;
    set(x);
    int z = *x;
  }
}