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


test-original: aes.ll aesni.ll \
      des.ll \
      sha1.c sha256.c sha512.c \
      rsa.ll md.ll md_wrap.ll md5.ll ripemd160.ll bignum.c oid.ll asn1parse.ll asn1write.ll pk.ll pk_wrap.ll ecdsa.ll hmac_drbg.ll ecp.c ecp_curves.c\
      randomize.c main.c
	${CC} -I . -o $@ $^

check: test test-original
	./test
	./test-original

.PHONY: clean

clean:
	rm *.ll test
