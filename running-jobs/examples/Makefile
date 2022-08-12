CC = cc
CCFLAGS = -fopenmp -g -O3

all: hello.x

%.x: %.c
	$(CC) $(CCFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -f *.x *.o
