/*lex program to count number of words*/
%option noyywrap
%{
#include<bits/stdc++.h>
#include "y.tab.h"

int words=0;
%} 
  

Num [0-9]*(\.[0-9]+)?
Word [a-zA-Z0-9]*
Punctuation ","|";"
SentenceSeparator "."|"!"|"?"
WordSeparator " "|","|";"
LineTerminator \n|\r|[\r][\n]
WhiteSpace \40|\11|\f|\v|{LineTerminator}
Notnewline " "|\t
Colon :

/* Rules Section*/
%%
\n|\r|[\r][\n] {return NEWLINE;}
{Num} {yylval.string = yytext; return NUM;}
"." { return DECLARATIVE;}
"!" { return EXCLAMATORY;}
"?" { return INTERROGATIVE;}
: {return COLON;}
Title {return TITLE;}
Chapter {return CHAPTER;}
Section {yylval.string = strdup(yytext);return SECTION;}
{WordSeparator} {return WORDSEPARATOR;}
{Notnewline} {return NOTNEWLINES;}
{WhiteSpace} {return WHITESPACE;}
{Word} {yylval.string = strdup(yytext);return WORD;}

%% 

