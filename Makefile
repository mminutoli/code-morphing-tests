CC=clang
PLUGIN=

.DEFAULT_GOAL := check

%.ll: %.c
	${CC} -emit-llvm -S -I. -o $@ $<

%-morphed.ll: %.ll
	opt -load ${PLUGIN} -static-morphing -S -o $@ $<

test: aes-morphed.ll aesni-morphed.ll \
      des-morphed.ll \
      sha1.c sha256.c sha512.c \
      rsa-morphed.ll md-morphed.ll md_wrap-morphed.ll md5-morphed.ll ripemd160-morphed.ll bignum.c oid-morphed.ll asn1parse-morphed.ll asn1write-morphed.ll pk-morphed.ll pk_wrap-morphed.ll ecdsa-morphed.ll hmac_drbg-morphed.ll ecp.c ecp_curves.c\
      randomize.c main.c
	${CC} -I . -o $@ $^

check: test
	./test

.PHONY: clean

clean:
	rm *.ll test
