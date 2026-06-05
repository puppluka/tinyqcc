CC = cc
CFLAGS = -O2 -g -Wall -std=gnu89 -Wno-return-type
TARGET = qcc
OBJS = qcc.o pr_lex.o pr_comp.o cmdlib.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all clean
