SFLAGS = -S -Og
OFLAGS = -g -c
CFLAGS = -o cal

all: main.o calculator.o
	gcc $(CFLAGS) calculator.o main.o

main.o:	main.s
	gcc $(OFLAGS) main.s

calculator.o: calculator.s
	gcc $(OFLAGS) calculator.s

main.s:	main.c
	gcc $(SFLAGS) main.c

clean:
	rm -f cal *.o
