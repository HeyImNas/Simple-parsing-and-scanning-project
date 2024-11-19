#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SYMBOLS 100

struct symbol {
    char* name;
    int value;
    int initialized;
};

extern struct symbol symbol_table[MAX_SYMBOLS];
extern int symbol_count;

int lookup_symbol(char* name);
void add_symbol(char* name, int value);
int get_value(char* name);
void set_value(char* name, int value);

#endif