#include <stdlib.h>
#include "slre.h"

/*
int main(void)
{
  char* bufr = "agfas";
  char* regex = NULL;
  //bufr = malloc(sizeof(char*));
  //regex = malloc(sizeof(char*));
  slre_match(regex, bufr, 5, NULL, 0, 0);
}
*/


int match(char* regex, char* s, int s_len){
  return foo(regex, (int) strlen(regex), s, s_len);
}

int foo(char* regex, int regex_len, char* s, int s_len){
  char re0 = regex[0];
  char s0 = s[0];
  return 0;
}