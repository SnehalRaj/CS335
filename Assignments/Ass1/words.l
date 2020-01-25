/*lex program to count number of words*/
%{ 
#include<stdio.h> 
#include<string.h> 
int i = 0; 
%} 
  
Underscores _{_}

WORD abstract|continue|for|new|switch|assert|default|if|package|synchronized|boolean|do|goto|private|this|break|double|implements|protected|throw|byte|else|import|public|throws|case|enum|instanceof|return|transient|catch|extends|int|short|try|char|final|interface|static|void|class|finally|long|strictfp|volatile|const|float|native|super|while 
Keyword (?<![a-zA-Z0-9])({WORD})(?![a-zA-Z0-9])

BooleanLiteral true|false
NullLiteral null


Digit [0-9]
NonZeroDigit 1|2|3|4|5|6|7|8|9
JavaLetter [a-zA-Z]
JavaLetterOrDigit [A-Za-z0-9]
IdentifierChars {JavaLetter}{JavaLetterOrDigit}
Identifier {IdentifierChars}

BinaryDigit 0|1
BinaryDigitOrUnderscore {BinaryDigit}|"_"
BinaryDigitsAndUnderscores {BinaryDigitOrUnderscore}{BinaryDigitOrUnderscore}*
BinaryDigits {BinaryDigit}|{BinaryDigit}{BinaryDigitsAndUnderscores}?{BinaryDigit}
BinaryNumeral 0b{BinaryDigits}|0B{BinaryDigits}

OctalDigit 0|1|2|3|4|5|6|7
OctalDigitOrUnderscore {OctalDigit}|"_"
OctalDigitsAndUnderscores {OctalDigitOrUnderscore}{OctalDigitOrUnderscore}*
OctalDigits {OctalDigit}|{OctalDigit}{OctalDigitsAndUnderscores}?{OctalDigit}
OctalNumeral 0{OctalDigits}|0{Underscores}{OctalDigits}

HexDigit 0|1|2|3|4|5|6|7|8|9|A|B|C|D|E|F
HexDigitOrUnderscore {HexDigit}|"_"
HexDigitsAndUnderscores {HexDigitOrUnderscore}{HexDigitOrUnderscore}*
HexDigits {HexDigit}|{HexDigit}{HexDigitsAndUnderscores}?{HexDigit}
HexNumeral 0x{HexDigits} | 0X{HexDigits}

DigitOrUnderscore {Digit}|"_"
DigitsAndUnderscores {DigitOrUnderscore}{DigitOrUnderscore}*
Digits {Digit}|{Digit}{DigitsAndUnderscores}?{Digit}
DecimalNumeral 0|{NonZeroDigit}{Digits}?| {NonZeroDigit}{Underscores}{Digits}

IntegerTypeSuffix l|L
DecimalIntegerLiteral {DecimalNumeral}{IntegerTypeSuffix}?
HexIntegerLiteral {HexNumeral}{IntegerTypeSuffix}?
OctalIntegerLiteral {OctalNumeral}{IntegerTypeSuffix}?
BinaryIntegerLiteral {BinaryNumeral}{IntegerTypeSuffix}?

IntegerLiteral DecimalIntegerLiteral|HexIntegerLiteral|OctalIntegerLiteral|BinaryIntegerLiteral


FloatTypeSuffix f|F|d|D
Sign +|-
SignedInteger {Sign}?{Digits}
ExponentIndicator e|E
ExponentPart {ExponentIndicator}{SignedInteger}
DecimalFloatingPointLiteral {Digits}\.{Digits}?{ExponentPart}?{FloatTypeSuffix}?|\.{Digits}{ExponentPart}?{FloatTypeSuffix}?|{Digits}{ExponentPart}{FloatTypeSuffix}?|{Digits}{ExponentPart}?{FloatTypeSuffix}


BinaryExponentIndicator p|P
BinaryExponent {BinaryExponentIndicator}{SignedInteger}
HexSignificand {HexNumeral}\.?|0x{HexDigits}?\.{HexDigits}|0X{HexDigits}?\.{HexDigits}
HexadecimalFloatingPointLiteral {HexSignificand}{BinaryExponent}{FloatTypeSuffix}?

FloatingPointLiteral DecimalFloatingPointLiteral|HexadecimalFloatingPointLiteral

SingleCharacter [^\\\n\'\r]

ZeroToThree 0|1|2|3
OctalEscape \\{OctalDigit}|\\{OctalDigit}{OctalDigit}|\\{ZeroToThree}{OctalDigit}{OctalDigit}

EscapeSequence \\b|\\t|\\n|\\f|\\r|\\"|\\'|\\\|{OctalEscape}

CharacterLiteral \'{SingleCharacter}\'|\'{EscapeSequence}\'

StringCharacter [^\\\"\n\r]|{EscapeSequence}

StringLiteral \"{StringCharacter}*\"

Literal {IntegerLiteral}|{FloatingPointLiteral}|{BooleanLiteral}|{CharacterLiteral}|{StringLiteral}|{NullLiteral}

Separator "("|")"|"{"|"["|"]"|";"|","|"..."|"."|"::"|@

Operator ">>>="|">>>"|">>="|">>"|"<<="|"<<"|"%="|"%"|"^="|"^"|"|="|"||"|"|"|"&="|"&&"|"&"|"/="|"/"|"*="|"*"|"-="|"--"|"+="|"++"|"->"|"-"|"+"|"!="|"<="|">="|"=="|":"|"?"|"~"|"!"|"<"|">"|"="

Token {Identifier}|{Keyword}|{Literal}|{Separator}|{Operator}

LineTerminator \n|\r|\r\n
WhiteSpace \40|\11|\f|{LineTerminator}


InputCharacter [^\n\r]

EndOfLineComment \/\/{InputCharacter}*
NotStarNotSlash [^\n\r\*\/]|{LineTerminator}
NotStar [^\n\r\*]|{LineTerminator}
CommentTail \*{CommentTailStar}|{NotStar}{CommentTail}
CommentTailStar \/|\*{CommentTailStar}|{NotStarNotSlash}{CommentTail}
TraditionalComment \/\*{CommentTail}
Comment {TraditionalComment}|{EndOfLineComment}

InputElement {WhiteSpace}|{Comment}|{Token}

Input {InputElement}*[^\32]?


/* Rules Section*/
%% 
Input ECHO;
%% 
  
int yywrap(void){}
int main() 
{    
    // The function that starts the analysis 
    yylex(); 
  
    return 0; 
} 