/*lex program to count number of words*/
%option noyywrap
%{
#include<bits/stdc++.h>
#include "y.tab.h"
int decl=0;
int inter=0;
int excl=0;
int words=0;
%} 
  

Num [0-9]*(\.[0-9]+)?
Word [a-zA-Z0-9]*
Punctuation ","|";"
SentenceSeparator "."|"!"|"?"
WordSeparator " "|","|";"
LineTerminator \n|\r|[\r][\n]
WhiteSpace \40|\11|\f|{LineTerminator}
Notnewline " "|\t
Colon :

/* Rules Section*/
%% 

{Num} {printf("num\n");printf("%s",yytext);return NUM;}
"." { printf("decl\n");decl++;yylval.number = decl;return DECLARATIVE;}
"!" {printf("excl\n"); yylval.number = 1;return EXCLAMATORY;}
"?" { printf("inter\n");yylval.number = 1;return INTERROGATIVE;}
: {printf("colon\n");return COLON;}
Title {printf("title\n");return TITLE;}
Chapter {printf("chapt\n");return CHAPTER;}
Section {printf("sect\n");yylval.string = strdup(yytext);return SECTION;}
{WordSeparator} {printf("wordspe\n");return WORDSEPARATOR;}
{Notnewline} {printf("notnew\n");return NOTNEWLINES;}
{WhiteSpace} {printf("whitesp\n");return WHITESPACE;}
{Word} {printf("word\n");yylval.string = strdup(yytext);return WORD;}
%% 

