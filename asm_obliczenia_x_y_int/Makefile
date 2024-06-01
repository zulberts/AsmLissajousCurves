# Makefile

CC = g++
ASM = nasm

CFLAGS = -m64 -Wall -fPIE
LDFLAGS = -m64 -fPIE
ASMFLAGS = -f elf64

all: calculate_x_y

calculate_x_y: main.o x_y.o
	$(CC) $(LDFLAGS) -o $@ main.o x_y.o

main.o: main.cpp
	$(CC) $(CFLAGS) -c $<

x_y.o: x_y.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f *.o calculate_x_y

.PHONY: all clean
