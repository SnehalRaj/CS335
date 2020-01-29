/*lex program to count number of words*/
%{ 
#include<bits/stdc++.h>
using namespace std;
unordered_map <string,int>  keyword;
unordered_map <string,int>  identifier;
unordered_map <string,int>  literal;
unordered_map <string,int>  separator;
unordered_map <string,int>  optor;

%} 
  

%option yylineno

Underscores \_[\_]*

Keyword "abstract"|"continue"|"for"|"new"|"switch"|"assert"|"default"|"if"|"package"|"synchronized"|"boolean"|"do"|"goto"|"private"|"this"|"break"|"double"|"implements"|"protected"|"throw"|"byte"|"else"|"import"|"public"|"throws"|"case"|"enum"|"instanceof"|"return"|"transient"|"catch"|"extends"|"int"|"short"|"try"|"char"|"final"|"interface"|"static"|"void"|"class"|"finally"|"long"|"strictfp"|"volatile"|"const"|"float"|"native"|"super"|"while" 


BooleanLiteral true|false
NullLiteral null


Digit [0-9]
NonZeroDigit 1|2|3|4|5|6|7|8|9
JavaLetter [a-zA-Z]
JavaLetterOrDigit [A-Za-z0-9\_\$]
IdentifierChars {JavaLetter}{JavaLetterOrDigit}*
Identifier {IdentifierChars}

BinaryDigit 0|1
BinaryDigitOrUnderscore \_|{BinaryDigit}
BinaryDigitsAndUnderscores {BinaryDigitOrUnderscore}{BinaryDigitOrUnderscore}*
BinaryDigits {BinaryDigit}|{BinaryDigit}{BinaryDigitsAndUnderscores}?{BinaryDigit}
BinaryNumeral 0B{BinaryDigits}|0b{BinaryDigits}

OctalDigit 7|6|5|4|3|2|1|0
OctalDigitOrUnderscore \_|{OctalDigit}
OctalDigitsAndUnderscores {OctalDigitOrUnderscore}{OctalDigitOrUnderscore}*
OctalDigits {OctalDigit}|{OctalDigit}{OctalDigitsAndUnderscores}?{OctalDigit}
OctalNumeral 0{Underscores}{OctalDigits}0{OctalDigits}

HexDigit 0|1|2|3|4|5|6|7|8|9|A|a|B|b|C|c|D|d|E|e|F|f
HexDigitOrUnderscore \_|{HexDigit}
HexDigitsAndUnderscores {HexDigitOrUnderscore}{HexDigitOrUnderscore}*
HexDigits {HexDigit}|{HexDigit}{HexDigitsAndUnderscores}?{HexDigit}
HexNumeral 0x{HexDigits}|0X{HexDigits}

DigitOrUnderscore \_|{Digit}
DigitsAndUnderscores {DigitOrUnderscore}{DigitOrUnderscore}*
Digits {Digit}|{Digit}{DigitsAndUnderscores}?{Digit}
DecimalNumeral 0|{NonZeroDigit}{Digits}?|{NonZeroDigit}{Underscores}{Digits}

IntegerTypeSuffix l|L
DecimalIntegerLiteral {DecimalNumeral}{IntegerTypeSuffix}?
HexIntegerLiteral {HexNumeral}{IntegerTypeSuffix}?
OctalIntegerLiteral {OctalNumeral}{IntegerTypeSuffix}?
BinaryIntegerLiteral {BinaryNumeral}{IntegerTypeSuffix}?

IntegerLiteral {DecimalIntegerLiteral}|{HexIntegerLiteral}|{OctalIntegerLiteral}|{BinaryIntegerLiteral}


FloatTypeSuffix f|F|d|D
Sign \+|-
SignedInteger {Sign}?{Digits}
ExponentIndicator e|E
ExponentPart {ExponentIndicator}{SignedInteger}
DecimalFloatingPointLiteral {Digits}\.{Digits}?{ExponentPart}?{FloatTypeSuffix}?|\.{Digits}{ExponentPart}?{FloatTypeSuffix}?|{Digits}{ExponentPart}{FloatTypeSuffix}?|{Digits}{ExponentPart}?{FloatTypeSuffix}


BinaryExponentIndicator p|P
BinaryExponent {BinaryExponentIndicator}{SignedInteger}
HexSignificand {HexNumeral}\.?|0x{HexDigits}?\.{HexDigits}|0X{HexDigits}?\.{HexDigits}
HexadecimalFloatingPointLiteral {HexSignificand}{BinaryExponent}{FloatTypeSuffix}?

FloatingPointLiteral {DecimalFloatingPointLiteral}|{HexadecimalFloatingPointLiteral}

SingleCharacter [^\\\n\'\r]

ZeroToThree 0|1|2|3
OctalEscape \\{OctalDigit}|\\{OctalDigit}{OctalDigit}|\\{ZeroToThree}{OctalDigit}{OctalDigit}

EscapeSequence \\b|\\t|\\n|\\f|\\r|\\["]|\\'|\\\\|{OctalEscape}

CharacterLiteral \'{SingleCharacter}\'|\'{EscapeSequence}\'

StringCharacter [^\\\"\n\r]|{EscapeSequence}

StringLiteral \"{StringCharacter}*\"

Literal {IntegerLiteral}|{FloatingPointLiteral}|{BooleanLiteral}|{CharacterLiteral}|{StringLiteral}|{NullLiteral}

Separator "("|")"|"{"|"}"|"["|"]"|";"|","|"..."|"."|"::"|@



Operator ">>>="|">>>"|">>="|">>"|"<<="|"<<"|"%="|"%"|"^="|"^"|"|="|"||"|"|"|"&="|"&&"|"&"|"/="|"/"|"*="|"*"|"-="|"--"|"+="|"++"|"->"|"-"|"+"|"!="|"<="|">="|"=="|":"|"?"|"~"|"!"|"<"|">"|"="

Token {Identifier}|{Keyword}|{Literal}|{Separator}|{Operator}

LineTerminator \n|\r|[\r][\n]
WhiteSpace \40|\11|\f|{LineTerminator}


InputCharacter [^\n\r]

EndOfLineComment \/\/{InputCharacter}*
StarComment (\*+([^*/]|[\r\n]))
TraditionalComment \/\*([^*]|[\r\n]|{StarComment})*\*+\/
Comment {TraditionalComment}|{EndOfLineComment}

InputElement {WhiteSpace}|{Comment}|{Token}

Input {InputElement}*[^\32]?


/* Rules Section*/
%% 
{Keyword} {
string k= yytext;
if(keyword.find(k)==keyword.end())
  keyword.insert( pair<string,int>(k,1));
else
  keyword[k]++;
}

{Operator} {
string o= yytext;
if(optor.find(o)==optor.end())
  optor.insert( pair<string,int>(o,1));
else
  optor[o]++;
}

{Separator} {
string sep= yytext;
if(separator.find(sep)==separator.end())
  separator.insert( pair<string,int>(sep,1));
else
  separator[sep]++;
}

{Literal} {
string l= yytext;
if(literal.find(l)==literal.end())
  literal.insert( pair<string,int>(l,1));
else
  literal[l]++;
}



{Identifier} {
string i= yytext;
if(identifier.find(i)==identifier.end())
  identifier.insert( pair<string,int>(i,1));
else
  identifier[i]++;
}

{WhiteSpace} {;}
{Comment} {;}
. {cerr<<"Error on line no. "<<yylineno<<" due to invalid char(s) "<<yytext<<endl;}
[A-Za-z0-9\_\$]* {cerr<<"Error on line no. "<<yylineno<<" due to invalid char(s) "<<yytext<<endl;}

%% 
  
int yywrap(void){}
int main() 
{    
    // The function that starts the analysis 
    yylex();
	cout<<"Lexeme,Token,Count"<<endl; 
  for(auto i = keyword.begin();i!=keyword.end();i++)
    cout<<i->first<<","<<"Keyword"<<","<<i->second<<endl;

  for(auto i = optor.begin();i!=optor.end();i++)
    cout<<i->first<<","<<"Operator"<<","<<i->second<<endl;

  for(auto i = literal.begin();i!=literal.end();i++)
    cout<<i->first<<","<<"Literal"<<","<<i->second<<endl;

  for(auto i = identifier.begin();i!=identifier.end();i++)
    cout<<i->first<<","<<"Identifier"<<","<<i->second<<endl;

  for(auto i = separator.begin();i!=separator.end();i++)
    cout<<i->first<<","<<"Separator"<<","<<i->second<<endl;
    return 0; 
} 