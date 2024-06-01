# Makefile

CC = g++
ASM = nasm

CFLAGS = -m64 -Wall -fPIE
LDFLAGS = -m64 -fPIE
ASMFLAGS = -f elf64

all: calculate_x

calculate_x: main.o x.o
	$(CC) $(LDFLAGS) -o $@ main.o x.o

main.o: main.cpp
	$(CC) $(CFLAGS) -c $<

x.o: x.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f *.o calculate_x

.PHONY: all clean
