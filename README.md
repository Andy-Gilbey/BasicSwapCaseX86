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

This program cannot swap the case of non-alphabetical characters, since the case swapping relies on adding or subtracting a value (32 in ASCII). Applying this operation to non-alphabetical/symbol characters can result in an unexpected outcome in the output.

As the project relies on tools such as NASM and ld, that means they are heavily dependent on the operating system in use and the environment. This project is aimed at Linux environments. Users on other platforms (e.g., Windows or macOS) may encounter difficulties due to the tailoring of the project for this reason.

The -f elf64 flag in the NASM command specifies that the output should be for a 64-bit Linux environment. Users on 32-bit systems may need to adjust this flag and be aware of potential compatibility issues.
