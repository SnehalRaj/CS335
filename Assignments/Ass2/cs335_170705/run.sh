#!/bin/bash
lex words.l
yacc -d test.y  -Wno
g++  y.tab.c lex.yy.c   -w
./a.out < $1
