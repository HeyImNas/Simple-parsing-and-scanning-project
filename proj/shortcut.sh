#!/bin/bash
rm -f Compiler lex.yy.c parser.tab.c parser.tab.h *.o
flex scanner.l
bison -d parser.y
gcc -c symbol_table.c
gcc -o Compiler lex.yy.c parser.tab.c symbol_table.o -lfl
