# Nazwa pliku wykonywalnego
TARGET = lissajous_dobrze

# Kompilator
CC = g++
ASM = nasm

# Flagi kompilatora
CFLAGS = -Wall -std=c++11 -fPIE
ASMFLAGS = -f elf64

# Flagi dla bibliotek Allegro
LDFLAGS = -lallegro -lallegro_primitives -lallegro_font

# Pliki źródłowe
SRC = lissajous.cpp
ASM_SRC = x_y.asm
OBJ = lissajous.o x_y.o

# Reguła domyślna
all: $(TARGET)

# Reguła kompilacji pliku C++
lissajous.o: lissajous.cpp
	$(CC) $(CFLAGS) -c lissajous.cpp -o lissajous.o

# Reguła kompilacji pliku asemblerowego
x_y.o: x_y.asm
	$(ASM) $(ASMFLAGS) x_y.asm -o x_y.o

# Reguła linkowania
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $(TARGET) $(LDFLAGS)

# Reguła czyszczenia
clean:
	rm -f $(TARGET) $(OBJ)

.PHONY: all clean
