#include "symbol_table.h"

struct symbol symbol_table[MAX_SYMBOLS];
int symbol_count = 0;

int lookup_symbol(char* name) {
    for(int i = 0; i < symbol_count; i++) {
        if(strcmp(symbol_table[i].name, name) == 0) {
            return i;
        }
    }
    return -1;
}

void add_symbol(char* name, int value) {
    int idx = lookup_symbol(name);
    if(idx == -1) {
        if(symbol_count >= MAX_SYMBOLS) {
            fprintf(stderr, "Symbol table full!\n");
            exit(1);
        }
        symbol_table[symbol_count].name = strdup(name);
        symbol_table[symbol_count].value = value;
        symbol_table[symbol_count].initialized = 1;
        symbol_count++;
    } else {
        symbol_table[idx].value = value;
        symbol_table[idx].initialized = 1;
    }
}

int get_value(char* name) {
    int idx = lookup_symbol(name);
    if(idx == -1) {
        fprintf(stderr, "Undefined variable: %s\n", name);
        exit(1);
    }
    if(!symbol_table[idx].initialized) {
        fprintf(stderr, "Uninitialized variable: %s\n", name);
        exit(1);
    }
    return symbol_table[idx].value;
}

void set_value(char* name, int value) {
    add_symbol(name, value);
}