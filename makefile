#A makefile for building the cw2 executable
all: cw2

cw2: cw2.o
	gcc -o cw2 cw2.o

cw2.o: cw2.s
	as -o cw2.o cw2.s

clean:
	rm cw2 cw2.o
