TARGET_NAME = hello-world.gb
AS = rgbasm
AFLAGS = -i include
LINKER = rgblink
ROMFIX = rgbfix
RM = rm -fr
SOURCES=$(wildcard src/*.asm)
OBJECTS=$(patsubst src/%.asm, bin/objects/%.asm.o, $(SOURCES))
OUTPUT_PATH=bin
EXECUTABLE=$(OUTPUT_PATH)/$(TARGET_NAME)

all:    build $(EXECUTABLE)

build:
		@mkdir -p $(OUTPUT_PATH)/objects

$(OUTPUT_PATH)/objects/%.asm.o: src/%.asm
		$(AS) $(AFLAGS) -o $@ $<

$(EXECUTABLE): $(OBJECTS)
		$(LINKER) -o $@ $<
		$(ROMFIX) -v -p 0 $@

clean:
		$(RM) $(OUTPUT_PATH)