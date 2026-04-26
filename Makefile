CC      ?= cc
CFLAGS  ?= -O3 -Wall -Wextra
PREFIX  ?= bin

.PHONY: all clean

all: $(PREFIX)/clers

$(PREFIX)/clers: src/clers.c
	@mkdir -p $(PREFIX)
	$(CC) $(CFLAGS) -o $@ $< -lm

clean:
	rm -rf $(PREFIX)
