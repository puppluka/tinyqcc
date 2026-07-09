# Compiles w/ CC, GCC, or TCC
CC = cc
CFLAGS = -O2 -g -Wall -std=c99 -Wno-return-type
OBJS = qcc.o pr_lex.o pr_comp.o cmdlib.o

BINARY = tinyqcc

# Windows Detection
ifeq ($(OS),Windows_NT)
	RM = del /Q /F
	TARGET = $(BINARY).exe
else
	RM = rm -f
	TARGET = $(BINARY)
endif


all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	-$(RM) $(OBJS) $(TARGET)

.PHONY: all clean