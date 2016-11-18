#include "mbedtls/aes.h"
#include "mbedtls/des.h"
#include "mbedtls/rsa.h"

int main(int argc, char *argv[])
{
  int result = mbedtls_aes_self_test(1);
  result &= mbedtls_des_self_test(1);
  result &= mbedtls_rsa_self_test(1);
  return result;
}
