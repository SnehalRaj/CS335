
%{ 
   /* Definition section */
  #include<stdio.h> 
  #include<stdlib.h> 
%} 
  

%token WORD WORDS INTERROGATIVE EXCLAMATORY DECLARATIVE WHITESPACE WHITESPACES TITLE CHAPTER SECTION COLON SECTIONNUM NOTNEWLINES
%start dissertation

%%

        
dissertation:
        titleline WHITESPACES chaptersone
        ;
chaptersone:
        chapter chapters
        ;
chapters:
        chapter chapters
        |
        ;
chapter:
        chapterline WHITESPACES sections
        ;
sections:
        section WHITESPACES sections
        |
        ;
section:
        sectionline WHITESPACES paragraphsone
        ;
paragraphsone:
        paragraph WHITESPACES paragraphs
        ;
paragraphs:
        paragraph WHITESPACES paragraphs
        |
        ;
paragraph:
        sentence NOTNEWLINES sentencesone; 

sentencesone:
        sentence NOTNEWLINES sentences
        ;
sentences:
        sentence NOTNEWLINES sentences
        |
        ;
sentence:
        DECLARATIVE 
        |
        INTERROGATIVE
        |
        EXCLAMATORY
        ;
titleline:
        TITLE WHITESPACES COLON WHITESPACES WORDS
        ;
chapterline:
        CHAPTER WHITESPACES WORD COLON WHITESPACES WORDS
        ;
sectionline:
        SECTION WHITESPACES SECTIONNUM COLON WHITESPACES WORDS
        ;

%%

  
//driver code  
void main() 
 { 
  yyparse(); 
 } 
 void yyerror(char *msg) 
 { 
  printf("%s\n",msg); 
  exit(0); 
 } 
  