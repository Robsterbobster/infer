#include <stdlib.h>


int* vendor(int value);
/*
int* vendor(int value){
  if (value > 0){
    return NULL;
  }else{
    int* ptr = malloc(sizeof(int*));
    if (ptr != NULL){
      *ptr = 10;
    }
    return ptr;
  }
}

int client(int* ptr){
  *ptr = 123;
  free(ptr);
}

int client0(){
  int *ptr = NULL;
  *ptr = 1;
  free(ptr);
}
*/

int client(int* ptr){
  *ptr = 123;
  free(ptr);
}

int main(void)
{
  int x = rand();
  int* p;
  p = vendor(x);
  client(p);
}