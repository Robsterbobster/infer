#include <stdlib.h>
#include "slre.h"
#define MAX_BRANCHES 100
#define MAX_BRACKETS 100

int match(){
  char* re = NULL;
  return foo(re);
}

int foo(const char *re){
  int i = random();
  if (i > 5){
    return 0;
  }else{
    return strlen(re);
  }
}


