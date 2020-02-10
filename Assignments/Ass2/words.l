/*lex program to count number of words*/
%option noyywrap
%{ 
#include<stdio.h> 
#include "y.tab.h" 
extern int yylval; 
int decl=0;
int inter=0;
int excl=0;
int words=0;
%} 
  

Word [a-zA-Z0-9]*
Punctuation "."|","|"!"|"?"|";"
SentenceSeparator "."|"!"|"?"
WordSeparator " "|","|";"
Words ({Word}({WordSeparator})+)+{Word}?
Declarative {Words}\. 
Exclamatory {Words}\!
Interrogative {Words}\?
LineTerminator \n|\r|[\r][\n]
WhiteSpace \40|\11|\f|{LineTerminator}
WhiteSpaces {WhiteSpace}*
Notnewline " "|\t
Notnewlines {Notnewline}*
Title Title
Chapter Chapter
Section Section
Colon ":"
SectionNum [0-9]*(\.[0-9]+)?

/* Rules Section*/
%% 
{Word} {return WORD;}
{Words} return WORDS;
{Declarative} {decl++; yylval=decl; return DECLARATIVE;}
{Exclamatory} {excl++;yylval=excl; return EXCLAMATORY;}
{Interrogative} {inter++;yylval=inter; return INTERROGATIVE;}
{WhiteSpace} return WHITESPACE;
{WhiteSpaces} return WHITESPACES;
{Title} return TITLE;
{Chapter} return CHAPTER;
{Section} return SECTION;
{Colon} return COLON;
{SectionNum} return SECTIONNUM;
{Notnewlines} return NOTNEWLINES;
%% 

