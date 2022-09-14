%include "../utils/printf32.asm"

%define ARRAY_SIZE    10

section .data
    dividend1 db 91
    divisor1 db 27
    dividend2 dd 67254
    divisor2 dw 1349
    dividend3 dd 67254
    divisor3 dw 1349


    print_cat db "Catul este ", 0
    print_rest db "Restul este ", 0

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    xor eax, eax

    ; dividend1 / divisor1
    ; dividend1 = deimpartit
    ; divisor1 = impartitor
    mov al, byte[dividend1]
    mov bl, byte[divisor1]
    div bl

    ;afisare
    ; catul este in al
    ; restul este in ah
    PRINTF32 `%s\x0`, print_cat
    xor ebx, ebx
    mov bl, al
    PRINTF32 `%hhu\n\x0`, ebx
    xor ebx, ebx
    mov bl, ah
    PRINTF32 `%s\x0`, print_rest
    PRINTF32 `%hhu\n\x0`, ebx
    
    xor eax, eax
    xor ebx, ebx
    xor edx, edx

    ; dividend2 / divisor2
    mov edx, dword[dividend2 + 2]
    mov ax, word[dividend2]
    add bx, word[divisor2]
    div bx

    ;afisare
    ;catul este in ax
    ;restul este in dx
    PRINTF32 `%s\x0`, print_cat
    xor ebx, ebx
    mov bx, ax
    PRINTF32 `%hu\n\x0`, ebx
    xor ebx, ebx
    mov bx, dx
    PRINTF32 `%s\x0`, print_rest
    PRINTF32 `%hu\n\x0`, ebx

    xor eax, eax
    xor ebx, ebx
    xor edx, edx

    leave
    ret
