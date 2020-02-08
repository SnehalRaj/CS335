/*lex program to count number of words*/
%{ 
#include<bits/stdc++.h>
using namespace std;

%} 
  

%option yylineno



/* Rules Section*/
%% 


%% 
  
int yywrap(void){}
int main() 
{    
    // The function that starts the analysis 
    yylex();

    return 0; 
} 