
; --------------------------------
    SYS_READ   equ     0          ; read text from stdin
	SYS_WRITE  equ     1          ; write the text to stdout
	SYS_EXIT   equ     60         ; kill the program
	STDIN      equ     0          ; standard input
	STDOUT     equ     1          ; standard output
; --------------------------------
section .bss
    MaxLength equ     24         ; 24 bytes for user input so max chars then is 24
    UserInput     resb    MaxLength ; buffer for user input
; --------------------------------
section .data
    prompt     db      "Please input some text (max 23 characters): ", 0 ; string to displau fpr user
    prompt_len equ     $ - prompt
    text       db      10, "When swapped you get: ", 0 ; output string when swapcase is finished up
    text_len   equ     $ - text
; --------------------------------
section .text
global _start
; --------------------------------
_start:
    ; Output the prompt
    mov     rdx, prompt_len     ; this is the length which is size of the prompt (24 in this case)
    mov     rsi, prompt         ; point to the prompt
    mov     rdi, STDOUT         
    mov     rax, SYS_WRITE      
    syscall                     ; output prompt

    ; Read user input
    mov     rdx, MaxLength      ; how many chars the user can input (again, 24 in this case)
    mov     rsi, UserInput      
    mov     rdi, STDIN          
    mov     rax, SYS_READ       
    syscall                     ;; readin from the user

    ; prep the input 
    mov     byte [rsi + rax - 1], 0

    ; call swapcase function to swap case
    mov     rdi, UserInput      ; point to userinput
    call    swapcase         ; call the swapcase function

    ; Output the text message
    mov     rdx, text_len       ; length of the output
    mov     rsi, text           ; point to it
    mov     rdi, STDOUT         
    mov     rax, SYS_WRITE      
    syscall                     ; output it

    ; Output the modified UserInput
    mov     rsi, UserInput      ; pointer to swapped UserInput
    mov     rdx, MaxLength      ; the length of it
    mov     rdi, STDOUT         
    mov     rax, SYS_WRITE      
    syscall                     ; perform the system output once again and output it

    ; Exit the program
    xor     rdi, rdi            ; Exit status 0
    mov     rax, SYS_EXIT       ; System call number for exit
    syscall                     ; 

; Function: The swap case function where all the actual action goes
swapcase:
    push rbp                       ; Save the current base pointer on the stack
    mov rbp, rsp                   ; Set the base pointer to the current stack pointer

.loop_start:
    mov al, [rdi]                  ; Load the next char from the string into AL
    test al, al                    ; Check if AL is null
    jz .end                        ; If AL is zero, its over, so jump to the end of function
    cmp al, 'A'                    ; compare AL with A to check if it is an uppercase letter
    jl .skipSwap                   ; jump to skip the swap if AL is less than A its not upper case
    cmp al, 'Z'                    ; compare AL with Z to see if it's within uppercase ascii range
    jle .XORCase                   ; jump to the xor if AL is less than or equal to Z
    cmp al, 'a'                    ; compare AL with a to check if it's a lowercase letter
    jl .skipSwap                   ; jump to the skip if AL is less than a so not a lowercase char
    cmp al, 'z'                    ; compare AL with z to see if its the lowercase range 
    jg .skipSwap                   ;  skip over if AL is greater than z as not lower

.XORCase:
    xor al, 32                     ; XOR by 32, as each uppercase is 32 apart from its lowercase in ASCII, case will be swapped
.skipSwap:
    mov [rdi], al                  ; save the (maybe) modified char back into the string
    add rdi, 1                     ; increment so move to the next character in the string
    jmp .loop_start                ; loop and start over for the next character

.end:
    pop rbp                        ; restore the previous base pointer from the stack
    mov rax, 1                     ; set the return value to 1 to indicate success!!
    ret                            ; return and take the 1 with you.
