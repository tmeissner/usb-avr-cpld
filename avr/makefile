#AVR-GCC Makefile
PROJECT = avrtest
SOURCES = src/avrtest.c
CC = avr-gcc
OBJCOPY = avr-objcopy
MMCU = atmega88

DUMMY_BINARY:=$(shell mkdir -p binary)

CFLAGS = -mmcu=$(MMCU) -Wall -Os -std=gnu99

compile : binary/$(PROJECT).out

binary/$(PROJECT).hex: binary/$(PROJECT).out
	$(OBJCOPY) -j .text -O ihex binary/$(PROJECT).out binary/$(PROJECT).hex

binary/$(PROJECT).out: $(SOURCES)
	$(CC) $(CFLAGS) -I./ -o binary/$(PROJECT).out $(SOURCES)

program: binary/$(PROJECT).hex
	avrdude -p m88 -c buspirate -P /dev/cu.PL2303-003012FA -e -U flash:w:binary/$(PROJECT).hex

clean:
	rm -rf binary/
