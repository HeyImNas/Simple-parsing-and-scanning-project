%{
#include "parser.tab.h"  // To use token definitions from Bison
%}

%%
"program"    { return PROGRAM; }
"read"       { return READ; }
"write"      { return WRITE; }
[0-9]+       { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.id = strdup(yytext); return ID; }
"+"          { return ADD_OP; }
"-"          { return ADD_OP; }
"*"          { return MULT_OP; }
"/"          { return MULT_OP; }
":="         { return ASSIGN; }
"("          { return '('; }
")"          { return ')'; }
[ \t\n]+     ;  // Ignore whitespace
.            { return yytext[0]; }  // Return single characters

%%
