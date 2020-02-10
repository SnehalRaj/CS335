#!/bin/bash
lex words.l
yacc -d diss.y
gcc lex.yy.c y.tab.c -w
./a.out < test.txt
