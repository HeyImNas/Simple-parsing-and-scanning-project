# Simple parsing and scanning project
 Programming languages project for a simple parsing and scanning program

## Purpose of the Program

The program is designed to parse a basic language that supports variable assignment, arithmetic expressions, reading inputs, and writing outputs. It checks whether the input code adheres to the syntax defined in the Bison grammar and outputs a success message if the parsing is completed without errors.
Key Features and Syntax

This language supports the following statements and expressions:

    Variable Assignment (ID := expr):
        Allows assigning a computed value or a number directly to a variable.
        Example: x := 5 or y := x + 3 * 2

    Input/Output:
        READ ID: Reads a value into a variable ID.
        WRITE expr: Outputs the result of evaluating an expression.
        Example: read x or write x + 1

    Arithmetic Expressions:
        Supports basic arithmetic operations:
            Addition and Subtraction (using + and -)
            Multiplication and Division (using * and /)
        Expressions can include numbers, variables, and nested expressions within parentheses.
        Examples: 5 + 3, x * (y + 2)

    Program Structure:
        The program expects a sequence of statements (like assignments or read/write commands).
        Each statement is parsed one by one until there are no more statements in the input.

## Parsing Rules

Here's a summary of the main parsing rules defined in the parser.y file:

    program: The top-level rule, expecting a list of statements (stmt_list). If this list is valid, it outputs Parsing completed successfully..
    stmt_list: A list of statements. It can contain multiple statements or be empty.
    stmt: Each statement can be one of the following:
        ID ASSIGN expr: Assigns the result of an expression to a variable.
        READ ID: Reads input into a variable.
        WRITE expr: Writes the result of an expression to the output.
    expr: Defines an arithmetic expression that consists of terms and optional additional terms.
    term_tail: Allows addition/subtraction of terms.
    term: Represents a term in an expression, which could be followed by more factors.
    fact_tail: Allows multiplication/division of factors.
    factor: A basic element of an expression, which can be a nested expression in parentheses, an identifier (ID), or a number (NUMBER).

## Lexical Analysis (Scanner Rules)

The scanner code in the second part defines how tokens are recognized:

    Keywords: Recognizes keywords like program, read, and write.
    Numbers: [0-9]+ matches integer numbers and converts them into NUMBER tokens.
    Identifiers: [a-zA-Z_][a-zA-Z0-9_]* matches variable names and converts them into ID tokens.
    Operators:
        + and - are recognized as ADD_OP.
        * and / are recognized as MULT_OP.
        := represents the assignment operator (ASSIGN).
    Parentheses: Recognizes ( and ) for grouping expressions.
    Whitespace: [ \t\n]+ is ignored.
    Other Characters: Returns any unmatched character as-is (useful for symbols not explicitly handled by the scanner).

## Example of Input Code

Here’s an example of a valid program in this custom language:

> program
> read x
> x := 5 + 3 * 2
> write x


## Expected Output

If the input code follows the syntax, the parser will output:

>Parsing completed successfully.

If there is a syntax error (e.g., missing an operator or using an unrecognized symbol), the yyerror function will be triggered, printing an error message to stderr.
Summary

In essence, this program is a small interpreter that parses statements and expressions in a simple language, verifying correct syntax according to defined rules. It demonstrates how to build a basic parser using Bison and a scanner using Flex (or equivalent lexical analysis). The language is similar to basic scripting languages, focusing on assignment, arithmetic operations, and I/O statements.