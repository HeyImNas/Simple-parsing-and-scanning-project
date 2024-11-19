/* parser.y */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

void yyerror(const char *s);
extern int yylex();
extern char* yytext;
%}

%union {
    int num;
    char* id;
    int val;
}

%token <num> NUMBER
%token <id> ID
%token ASSIGN READ WRITE
%token PLUS MINUS MULT DIV
%token LPAREN RPAREN
%token ENDMARK

%type <val> expr
%type <val> term
%type <val> factor
%type <val> term_tail
%type <val> fact_tail

%%

program: stmt_list ENDMARK
    { printf("Program execution completed.\n"); }
    ;

stmt_list: stmt stmt_list
    | /* empty */
    ;

stmt: ID ASSIGN expr
    { 
        set_value($1, $3);
        printf("%s = %d\n", $1, $3);
        free($1);
    }
    | READ ID
    { 
        int value;
        printf("Enter value for %s: ", $2);
        scanf("%d", &value);
        set_value($2, value);
        free($2);
    }
    | WRITE expr
    { 
        printf("Output: %d\n", $2);
    }
    ;

expr: term term_tail
    { 
        $$ = $1 + $2;
    }
    ;

term_tail: add_op term term_tail
    { 
        if($<val>1 == PLUS) 
            $$ = $2 + $3;
        else 
            $$ = -$2 + $3;
    }
    | /* empty */
    { 
        $$ = 0;
    }
    ;

term: factor fact_tail
    { 
        $$ = $1 * $2;
        if($2 == 0) $$ = $1;
    }
    ;

fact_tail: mult_op factor fact_tail
    { 
        if($<val>1 == MULT)
            $$ = $2 * $3;
        else {
            if($2 == 0) {
                yyerror("Division by zero");
                exit(1);
            }
            $$ = 1 / $2 * $3;
            if($3 == 0) $$ = 1 / $2;
        }
    }
    | /* empty */
    { 
        $$ = 1;
    }
    ;

factor: LPAREN expr RPAREN
    { 
        $$ = $2;
    }
    | ID
    { 
        $$ = get_value($1);
        free($1);
    }
    | NUMBER
    { 
        $$ = $1;
    }
    ;

add_op: PLUS
    { 
        $<val>$ = PLUS;
    }
    | MINUS
    { 
        $<val>$ = MINUS;
    }
    ;

mult_op: MULT
    { 
        $<val>$ = MULT;
    }
    | DIV
    { 
        $<val>$ = DIV;
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parser error: %s\n", s);
}

int main() {
    printf("Enter your program (end with $$):\n");
    yyparse();
    return 0;
}