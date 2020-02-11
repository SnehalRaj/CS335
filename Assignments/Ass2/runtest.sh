#!/bin/bash
lex words.l
yacc -d test.y
g++  y.tab.c lex.yy.c   -w
./a.out < test.txt
