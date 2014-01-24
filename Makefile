SRC=main.wl

all: program.o
	ld program.o /usr/lib/crt1.o /usr/lib/crti.o /usr/lib/crtn.o -lc -lm -lSDL -lSDL_mixer -lSDL_image -o program -dynamic-linker /lib64/ld-linux-x86-64.so.2

program.ll: main.wl
	wlc main.wl 2> program.ll

program.o: program.ll
	llc program.ll --filetype=obj -o program.o -O0
