#!/bin/bash
lex words.l
yacc -d diss.y
g++  y.tab.c lex.yy.c   -w
./a.out < test.txt
