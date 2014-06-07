SRC=main.wl matrix.wl sprite.wl owl.wl fireball.wl list.wl bg.wl


proj:
	wlc main.wl -lSDL -lSDL_mixer -lSDL_image -o program

all: program.o
	ld program.o /usr/lib/crt1.o /usr/lib/crti.o /usr/lib/crtn.o -lc -lm -lSDL -lSDL_mixer -lSDL_image -o program -dynamic-linker /lib64/ld-linux-x86-64.so.2

# ALWAYS BUILD, DAMN YOU
.PHONY: program.ll
program.ll: $(SRC)
	wlc main.wl

program.o: program.ll
	llc output.ll --filetype=obj -o program.o -O0

.PHONY: interpret
interpret: program.ll
	lli -load /usr/lib/libSDL-1.2.so.0 -load /usr/lib/libSDL_image.so program.ll

clean:
	rm -f program.o
	rm -f program.ll
	rm -f program
