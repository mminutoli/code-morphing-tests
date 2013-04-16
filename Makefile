CC=clang
PLUGIN=

.DEFAULT_GOAL := check

%.ll: %.c
	${CC} -emit-llvm -S -o $@ $<

%-morphed.ll: %.ll
	opt -load ${PLUGIN} -static-morphing -S -o $@ $<

aes: aes-morphed.ll randomize.c main.c
	${CC} -o $@ $^

check: aes
	./aes

.PHONY: clean

clean:
	rm *.ll aes
