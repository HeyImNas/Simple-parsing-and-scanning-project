# Compiler Implementation using Flex and Bison

This project implements a simple compiler using Flex (lexical analyzer) and Bison (parser) based on an LL(1) grammar. The compiler supports basic arithmetic operations, variable assignments, and input/output operations.

## Grammar

The compiler implements the following LL(1) grammar:
```
1. program → stmt_list $$
2. stmt_list → stmt stmt_list | ε
3. stmt → id := expr | read id | write expr
4. expr → term term_tail
5. term_tail → add_op term term_tail | ε
6. term → factor fact_tail
7. fact_tail → mult_op fact fact_tail | ε 
8. factor → ( expr ) | id | number
9. add_op → + | -
10. mult_op → * | /
```

## Project Structure

### 1. `scanner.l` (Flex File)
- Implements the lexical analyzer (scanner)
- Recognizes tokens such as:
  - Numbers
  - Identifiers (variables)
  - Operators (+, -, *, /, :=)
  - Keywords (read, write)
  - Parentheses
  - End marker ($$)
- Converts the input text into a stream of tokens for the parser

### 2. `parser.y` (Bison File)
- Implements the syntactic analyzer (parser)
- Defines grammar rules and their associated actions
- Handles:
  - Expression evaluation
  - Variable assignments
  - Input/output operations
  - Error reporting
- Integrates with the symbol table for variable management

### 3. `symbol_table.h` (Header File)
- Declares the symbol table structure and interface
- Defines:
  - Symbol structure (variable name, value, initialization status)
  - Maximum symbol table size
  - Function prototypes for symbol table operations

### 4. `symbol_table.c` (Implementation File)
- Implements symbol table operations:
  - `lookup_symbol`: Finds a variable in the symbol table
  - `add_symbol`: Adds or updates a variable
  - `get_value`: Retrieves a variable's value
  - `set_value`: Updates a variable's value
- Provides error checking for undefined or uninitialized variables

### 5. `shortcut.sh` (Build Script)
- Shell script to automate the build process
- Performs the following operations:
  1. Cleans up previous build files
  2. Runs flex on scanner.l
  3. Runs bison on parser.y
  4. Compiles symbol_table.c
  5. Links all components to create the final executable

## Why Symbol Tables?

Symbol tables are crucial in compiler design for several reasons:

1. **Variable Management**: They store information about all variables used in the program, including:
   - Variable names
   - Values
   - Initialization status

2. **Scope Handling**: Although this implementation uses a global scope, symbol tables are essential for managing variable scope in more complex compilers.

3. **Error Detection**: They help detect:
   - Undefined variables
   - Uninitialized variables
   - Variable redeclaration (in more complex implementations)

4. **Memory Efficiency**: Symbol tables provide a centralized location for variable information, avoiding redundant storage.

## Building and Running

### Prerequisites
- Flex (Fast Lexical Analyzer)
- Bison (Parser Generator)
- GCC (GNU Compiler Collection)
- Bash shell

### Build Instructions
```bash
chmod +x shortcut.sh  # Make the script executable (only needed once)
./shortcut.sh         # Build the compiler
```

### Running the Compiler
```bash
./Compiler
```

### Example Usage
```
Enter your program (end with $$):
x := 5
y := x + 3
write y
$$
```

Expected output:
```
x = 5
y = 8
Output: 8
Program execution completed.
```

## Features

1. **Arithmetic Operations**
   - Addition (+)
   - Subtraction (-)
   - Multiplication (*)
   - Division (/)

2. **Variable Operations**
   - Assignment (:=)
   - Reading input (read)
   - Writing output (write)

3. **Error Handling**
   - Syntax errors
   - Undefined variables
   - Uninitialized variables
   - Division by zero

## Limitations

1. Only supports integer arithmetic
2. No floating-point numbers
3. No string operations
4. Single global scope
5. Limited error recovery

## Future Improvements

Possible enhancements could include:
1. Support for floating-point numbers
2. Multiple variable scopes
3. More complex control structures (if, while, etc.)
4. Enhanced error recovery
5. Support for strings and arrays
6. Function definitions and calls

## Contributing

Feel free to submit issues and enhancement requests!

## License

[Add your chosen license here]