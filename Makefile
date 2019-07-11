ASMFLAGS=-gstabs+

hexagame: hexagame.s
	as $(ASMFLAGS) -o c__i32tox.o c__i32tox.s
	ld -o c__i32tox c__i32tox.o -e _starttest
	as $(ASMFLAGS) -o c__i32tobin.o c__i32tobin.s
	ld -o c__i32tobin c__i32tobin.o
	as -o hexagame.o $(ASMFLAGS) hexagame.s
	ld -o hexagame hexagame.o c__i32tobin.o c__i32tox.o -e _startok

clean:
	rm *.o

