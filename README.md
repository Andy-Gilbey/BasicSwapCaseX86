# Swapcase Assembly x86 Program

## Author Name

Andrew Gilbey

## Student Number

C00263656

## Licence Details

This project is licensed under the GPL License - see the [LICENSE.md](LICENSE) file for details.

## Project Description

This project presents an x86 Assembly program which is designed to perform case swapping on input strings, and convert all lowercase letters to uppercase and vice versa. The transformation uses the ASCII character encoding scheme, where, for example, "Hello JOE!" would be converted to "hELLO joe!".

The program utilises the Netwide Assembler (NASM) for assembly on Linux environments. 

## Instructions on Producing an Executable

### Prerequisites

Ensure NASM is installed on your system for assembling the program. 

For Debian-based distributions (Ubuntu, Mint, Kali),  you can install NASM using `apt`:

```bash
    sudo apt update
    sudo apt install nasm
```

### Producing an Executable Steps

1. Open Terminal.
2. Navigate to the project directory.
3. Assemble the program using NASM with the following command 

    ```bash
    nasm -f elf64 swapcase.asm -o swapcase.o
    ```

4. Link the object file to create an executable:

    ```bash
    ld swapcase.o -o swapcase
    ```

5. Make the executable file runnable:

    ```bash
    chmod +x swapcase
    ```

6. Run the program:

    ```bash
    ./swapcase
    ```

## Issues/Notes
### Targeted Linux Environment
This program was specifically designed for Linux enviroments and utilises tools such as the Netwide Assembler (NASM) and linker (ld). Users on other operating systems, such as Windows or macOS, may 
face challenges in executing the project as intended. 

### 64-bit Specific
The -f elf64 flag in the NASM command specifies that the output is targetd for a 64-bit Linux environment. Users on 32-bit systems may need to adjust this flag and be aware of potential compatibility issues.

### Input Edge Cases
This program is designed to accept only 23 characters. If more than 23 are input, the programme will truncate the excess characters.

This program is designed to work exclusively with ASCII characters and does not account for extended ASCII or Unicode characters. Should these characters be used, unexpected output may occur.

### Error Handling
This program is designed to NOT provide feedback if something goes wrong, e.g., if an input is too long.

### Comments
The code actual has been commented on nearly every line, which should paint a clear understanding of operations.

This may help support a user or developer in comprehending the the program.

