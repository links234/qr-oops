CC = gcc
CPPFLAGS =
CFLAGS = -Wall -Wextra -g

.PHONY: all clean

all: qr-oops

qr-oops: qr-oops.o

qr-oops.o: qr-oops.c

clean:
	-rm -f *.o *~ qr-oops *.txt
