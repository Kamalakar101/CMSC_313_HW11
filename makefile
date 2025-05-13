# Default target: build both
all: ToAscii ToAsciiEC

# Build object files
ToAscii.o: ToAscii.asm
	nasm -f elf32 -g -F dwarf -o ToAscii.o ToAscii.asm

ToAsciiEC.o: ToAsciiEC.asm
	nasm -f elf32 -g -F dwarf -o ToAsciiEC.o ToAsciiEC.asm

# Link executables
ToAscii: ToAscii.o
	ld -m elf_i386 -o ToAscii ToAscii.o

ToAsciiEC: ToAsciiEC.o
	ld -m elf_i386 -o ToAsciiEC ToAsciiEC.o

# Run commands
run: ToAscii
	./ToAscii

runec: ToAsciiEC
	./ToAsciiEC

# Clean up
clean:
	rm -f ToAscii.o ToAscii ToAsciiEC.o ToAsciiEC
