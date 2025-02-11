
%{ 
   /* Definition section */
#include<bits/stdc++.h>
#include <string>
using namespace std;
int     yylex();
 void yyerror(char *msg);
 int decl=0;
 int inter=0;
 int excl=0;
 int numwords=0;
 int chapt=0;
 int sect=0;
 int para=0;
 string title;
%} 


%token WORD WORDS INTERROGATIVE EXCLAMATORY DECLARATIVE WHITESPACE WHITESPACES TITLE CHAPTER SECTION COLON NUM NOTNEWLINES NEWLINE SENTENCESEPARATOR WORDSEPARATOR
%start  dissertation
%union 
{
       char* string;
}
%type <string>  WORD SECTION words word NUM endwords NEWLINE titleline wordsep WORDSEPARATOR chapterline sectionline
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
        sentences {para++;}
        |
        NEWLINE
        ;
chapterline:
        notnewlines CHAPTER wordsep NUM wordsep COLON wordsep endwords NEWLINE {chapt++;printf("Chapter %s",$4);}
        ;
titleline:
        notnewlines TITLE wordsep COLON wordsep endwords NEWLINE{printf("Title: %s\nTable of Contents:\n",$6);}
        ;
sectionline:
        notnewlines SECTION wordsep NUM wordsep COLON wordsep endwords NEWLINE {sect++;printf("        Section %s",$4);}
        ;
sentences:
        sentence wordsep sentences
        |
        NEWLINE
        ;
sentence:
        declarative
        |
        interrogative
        |
        exclamatory
        ;
declarative:
        notnewlines words DECLARATIVE{decl++;}
        ;
interrogative:
        notnewlines words INTERROGATIVE{inter++;}
        ;
exclamatory:
        notnewlines words EXCLAMATORY{excl++;}
        ;
endwords:
        word wordsep endwords { char *str = (char*) malloc(strlen($1) +1+strlen($3) + 1);
      strcpy(str, $1);
      strcat(str,  " ");
      strcat(str, $3);
      $$ = str;
    }
        |
        word{ $$ = $1; }
        ;
word:
        WORD
        |
        NUM
        ;
words:
        cntword wordsep words
        |
        cntword
        ;
cntword:
        WORD{numwords++;}
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
  printf("\nNumber of Declarative sentences:%d\n",decl);
  printf("Number of Interrogative sentences:%d\n",inter);
  printf("Number of Exlamatory sentences:%d\n",excl);
  printf("Total number of sentences:%d\n",(decl+inter+excl));
  printf("Number of words:%d\n",numwords);
  printf("Number of Chapters: %d\n",chapt);
  printf("Number of Sections: %d\n",sect);
  printf("Number of Paragraphs: %d\n",para);
  return 0; 
 } 
 void yyerror(char *msg) 
 { 
  printf("%s\n",msg); 
  exit(0); 
 } 
  