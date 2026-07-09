CC = cc
CFLAGS = -O2 -g -Wall -std=gnu89 -Wno-return-type
OBJS = qcc.o pr_lex.o pr_comp.o cmdlib.o

# Windows Detection
ifeq ($(OS),Windows_NT)
	RM = del /Q /F
	TARGET = qcc.exe
else
	RM = rm -f
	TARGET = qcc
endif


all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	-$(RM) $(OBJS) $(TARGET)

.PHONY: all clean