%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

%}

%union {
    int num;
    char *id;
}

%token <id> ID
%token <num> NUMBER
%token READ WRITE PROGRAM
%token ASSIGN
%token ADD_OP MULT_OP

%start program

%%

program: stmt_list { printf("Parsing completed successfully.\n"); }
       ;

stmt_list: stmt stmt_list
         | /* empty */
         ;

stmt: ID ASSIGN expr
    | READ ID
    | WRITE expr
    ;

expr: term term_tail
    ;

term_tail: ADD_OP term term_tail
         | /* empty */
         ;

term: factor fact_tail
    ;

fact_tail: MULT_OP factor fact_tail
         | /* empty */
         ;

factor: '(' expr ')'
      | ID
      | NUMBER
      ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
