#include <stdlib.h>

int main(void)
{
    int filter_length;
    int err;
    struct MYSOFA_EASY *easy = NULL;
    easy = mysofa_open(filename, 48000, &filter_length, &err);
    printf("Result: %p err: %d\n", easy, err);
    mysofa_close(easy);
}