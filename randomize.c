#include <stdlib.h>

int randomize(int a)
{
  int value = rand() % (++a);
  return value;
}
