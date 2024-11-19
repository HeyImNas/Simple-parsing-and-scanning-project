/* scanner.l - Lexical analyzer */
%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"

void yyerror(const char *s);
%}

%%
[ \t\n]         ; /* Skip whitespace */
[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
":="            { return ASSIGN; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"read"          { return READ; }
"write"         { return WRITE; }
"$$"            { return ENDMARK; }
[a-zA-Z][a-zA-Z0-9]* { 
    yylval.id = strdup(yytext);
    return ID; 
}
.               { printf("Unexpected character: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}