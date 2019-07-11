# hexagame -- playing with assembly and hexadecimal digits

This is an educational project I made when I was studying the assembly language.  It's a game:  Enter the hexadecimal digit matching the four-digit binary pattern randomly displayed by the program, or vice-versa.  Give no answer to quit.

The game is designed to learn binary patterns and hexadecimal digits.

Here a sample session:

```
[bruno]$ ./hexagame
What is the binary pattern for [6]? 0110
You're ok.
What is the hexa code for [1011]? B
You're ok.
What is the hexa code for [0001]? 1
You're ok.
What is the hexa code for [0111]? F
You're wrong. Try again: 7
You're ok.
What is the binary pattern for [E]? 1110
You're ok.
What is the hexa code for [0011]? 
[bruno]$ 
```

## Getting Started

Execute the `hexagame` file:

```
./hexagame
```

You may want to compile from source (in assembly), assuming you have `make`:

```
make
make clean
```

Note that the last time I have done this was with a Pentium...


## Authors


Bruno Oberle.  Please contact me at [boberle.com](http://boberle.com).

See my other projects at [boberle.com](http://boberle.com)!


## License

Copyright 2010 Bruno Oberle

This program comes with ABSOLUTELY NO WARRANTY.

