# Makefile

CC = g++
ASM = nasm

CFLAGS = -m64 -Wall
ASMFLAGS = -f elf64

all: calculate_sin

calculate_sin: main.o sin.o
	$(CC) $(CFLAGS) -o $@ main.o sin.o

main.o: main.cpp
	$(CC) $(CFLAGS) -c $<

sin.o: sin.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f *.o calculate_sin

.PHONY: all clean
