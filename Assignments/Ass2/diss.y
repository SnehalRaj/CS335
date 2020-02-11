
%{ 
   /* Definition section */
#include<bits/stdc++.h>
int     yylex();
 void yyerror(char *msg);
%} 


%token WORD WORDS INTERROGATIVE EXCLAMATORY DECLARATIVE WHITESPACE WHITESPACES TITLE CHAPTER SECTION COLON SECTIONNUM NOTNEWLINES
%start  titleline
%union 
{
        int number;
        char *string;
}
%type <string> titleline WORDS dissertation
%%

        
dissertation:
        lines WHITESPACES dissertation
        |
        ;
lines:
        titleline
        |
        chapterline
        |
        sectionline
        |
        sentences
        ;
sentences:
        NOTNEWLINES sentence NOTNEWLINES sentences
        |
        NOTNEWLINES
        ;
sentence:
        EXCLAMATORY
        |
        DECLARATIVE
        |
        INTERROGATIVE
        ;

titleline:
        NOTNEWLINES TITLE WHITESPACES WORD COLON WHITESPACES WORDS NOTNEWLINES 
        ;
chapterline:
        NOTNEWLINES CHAPTER WHITESPACES WORD COLON WHITESPACES WORDS NOTNEWLINES
        ;
sectionline:
        NOTNEWLINES SECTION NOTNEWLINES SECTIONNUM COLON NOTNEWLINES WORDS NOTNEWLINES
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
  