#include <stdlib.h>
// for more realism, imagine that this function does other things as well
void set(int n, int* p) {
  if (n > 0) {
    p = NULL;
  }
}

void latent(int n, int* p) {
  set_to_null_if_positive(n, p);
  *p = 42; // NULL dereference! but only if n > 0 so no report yet
}

