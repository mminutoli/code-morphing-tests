#include "polarssl/aes.h"

int main(int argc, char *argv[])
{
  return aes_self_test(1);
}
