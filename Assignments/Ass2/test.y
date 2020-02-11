
%{ 
   /* Definition section */
#include<bits/stdc++.h>
int     yylex();
 void yyerror(char *msg);
%} 


%token WORD WORDS INTERROGATIVE EXCLAMATORY DECLARATIVE WHITESPACE WHITESPACES TITLE CHAPTER SECTION COLON NUM NOTNEWLINES NEWLINE SENTENCESEPARATOR WORDSEPARATOR
%start  dissertation
%union 
{
        int number;
        char *string;
}
%type <string>  WORD SECTION
// %type <string> words
%%

        
dissertation:
        lines whitespaces dissertation
        |
        ;
lines:  titleline
        |
        chapterline
        |
        sectionline
        |
        sentences
        ;
// sentences:
//         NOTNEWLINES sentence NOTNEWLINES sentences
//         |
//         NOTNEWLINES
//         ;
// sentence:
//         EXCLAMATORY
//         |
//         DECLARATIVE
//         |
//         INTERROGATIVE
//         ;
// titleline:
//         NOTNEWLINES TITLE WHITESPACES WORD COLON WHITESPACES WORDS NOTNEWLINES 
//         ;
chapterline:
        notnewlines CHAPTER wordsep NUM wordsep COLON wordsep words
        ;
titleline:
        notnewlines TITLE wordsep COLON wordsep words
        ;
sectionline:
        notnewlines SECTION wordsep NUM wordsep COLON wordsep words
        ;
sentences:
        sentence wordsep sentences
        |
        sentence
        ;
sentence:
        declarative
        |
        interrogative
        |
        exclamatory
        ;
declarative:
        notnewlines words DECLARATIVE
        ;
interrogative:
        notnewlines words INTERROGATIVE
        ;
exclamatory:
        notnewlines words EXCLAMATORY
        ;
words:
        word wordsep words
        |
        word
        ;
word:
        WORD
        |
        NUM
        ;
whitespaces:
        WHITESPACE whitespaces
        |
        ;
wordsep:
        WORDSEPARATOR wordsep
        |
        ;

notnewlines:
        NOTNEWLINES notnewlines
        |
        ;

%%

  
//driver code  
int main() 
 { 
  yyparse();
  return 0; 
 } 
 void yyerror(char *msg) 
 { 
  printf("%s\n",msg); 
  exit(0); 
 } 
  