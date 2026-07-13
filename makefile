.DELETE_ON_ERROR:
BINARY = tinyqcc

# Compiles w/ CC, GCC, or TCC
CC ?= cc

CFLAGS = -O2 -g -Wall -std=c99 -MMD -MP
LDLIBS = 

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
DEPS = $(SRCS:.c=.d)

# ------------------------------------------------

# Windows Detection
ifeq ($(OS),Windows_NT)
	RM = del /Q /F
	TARGET = $(BINARY).exe
else
	RM = rm -f
	TARGET = $(BINARY)
endif

# ------------------------------------------------

all: $(TARGET)
	@echo "Build SUCCESS. Removing object/dependency files..."
	-$(RM) $(OBJS) $(DEPS) *.d

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(LDLIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

-include $(DEPS)

clean:
	-$(RM) $(OBJS) $(TARGET)

.PHONY: all clean