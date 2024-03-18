
; --------------------------------
    SYS_READ   equ     0          ; read text from stdin
	SYS_WRITE  equ     1          ; write text to stdout
	SYS_EXIT   equ     60         ; terminate the program
	STDIN      equ     0          ; standard input
	STDOUT     equ     1          ; standard output
; --------------------------------
section .bss
    MaxLength equ     24         ; 24 bytes for user input
    UserInput     resb    MaxLength ; buffer for user input
; --------------------------------
section .data
    prompt     db      "Please input some text (max 23 characters): ", 0
    prompt_len equ     $ - prompt
    text       db      10, "When swapped you get: ", 0
    text_len   equ     $ - text
; --------------------------------
section .text
global _start
; --------------------------------
_start:
    ; Output the prompt
    mov     rdx, prompt_len     ; Length of the prompt
    mov     rsi, prompt         ; Pointer to the prompt string
    mov     rdi, STDOUT         ; File descriptor for stdout
    mov     rax, SYS_WRITE      ; System call number for write
    syscall                     ; Perform system call

    ; Read user input
    mov     rdx, MaxLength      ; Max number of bytes to read
    mov     rsi, UserInput      ; Destination buffer
    mov     rdi, STDIN          ; File descriptor for stdin
    mov     rax, SYS_READ       ; System call number for read
    syscall                     ; Perform system call

    ; Replace newline with null terminator
    mov     byte [rsi + rax - 1], 0

    ; Swap case of characters in UserInput
    mov     rdi, UserInput      ; Pointer to start of UserInput
    call    swapcase         ; Call function to toggle case or "swap case"

    ; Output the text message
    mov     rdx, text_len       ; Length of the text message
    mov     rsi, text           ; Pointer to text message
    mov     rdi, STDOUT         ; File descriptor for stdout
    mov     rax, SYS_WRITE      ; System call number for write
    syscall                     ; Perform system call

    ; Output the modified UserInput
    mov     rsi, UserInput      ; Pointer to modified UserInput
    mov     rdx, MaxLength      ; Max length of the buffer
    mov     rdi, STDOUT         ; File descriptor for stdout
    mov     rax, SYS_WRITE      ; System call number for write
    syscall                     ; Perform system call

    ; Exit the program
    xor     rdi, rdi            ; Exit status 0
    mov     rax, SYS_EXIT       ; System call number for exit
    syscall                     ; Perform system call

; Function: The swap case function where all the actual action goes
swapcase:
.next_char:
    mov     al, [rdi]          ; Load the next character from memory into AL
    cmp     al, 0              ; Compare AL with null terminator (0)
    je      .done              ; If AL is null terminator, jump to done

    ; swap up the case 
    cmp     al, 'A'            ; Check if the character is greater than or equal to 'A' with compare (cmp)
    jl      .check_lowercase   ; If is before 'A' (less than), it might be lowercase or symbol
    cmp     al, 'Z'            ; Compare used here to check if the character is less than or equal to 'Z'
    jg      .check_lowercase   ; Jump greater used here so if it is greater or after 'Z, it's definitley not an uppercase letter

    ; It's an uppercase letter, then swap the case
    xor     al, 32             ; BY xoring 32 here it adds or subtracts 32 depending on what the value was at the start.
    jmp     .store             ; Jump to the label which stores the character

.check_lowercase:
    cmp     al, 'a'            ; Check if the character is greater than or equal to 'a'
    jl      .store             ; If it is less (before 'a'), it's not a letter, so no swap
    cmp     al, 'z'            ; Check if the character is less than or equal to 'z'
    jg      .store             ; If greater and so after z, it's not a lowercase letter

    ; It's a lowercase letter, swap it up
    xor     al, 32             ; BY xoring 32 here it adds or subtracts 32 depending on what the value was at the start.

.store:
    mov     [rdi], al          ; Store the swapped character back into memory
    add     rdi, 1             ; Increment the memory address +1 in RDI to move so it can push forward to the next character
    jmp     .next_char         ; Loop back to process the next character

.done:
    ret                         ; Return from the function