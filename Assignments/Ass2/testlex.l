/*lex program to count number of words*/

%{ 
#include<stdio.h> 
#include "y.tab.h" 

int decl=0;
int inter=0;
int excl=0;
int words=0;
%} 
  

Word [a-zA-Z0-9]*


/* Rules Section*/
%% 
{Word} {printf("dddddddddddddddddddd");return WORD;}
%% 
int yywrap(void){}
int main() 
{    
    // The function that starts the analysis 
    
    yylex();
  return 0; 
} 