#include <libetpan/libetpan.h>
#include <stdlib.h>

int main(void)
{
  carray* arr = carray_new(10);
  arr = NULL;
  carray_set_size(arr, 20);
}