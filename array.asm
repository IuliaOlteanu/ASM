%include "utils/printf32.asm"

extern printf
extern strlen

section .data
    num dd 55555123
    str_test db "String for test", 0
    a_array db 1, 2, 3, 4, 5, 6, 11
    len equ $-a_array
    b_array times len dw 0

;;  TODO d: declare byte_array so that PRINT_HEX shows babadac 
    byte_array db 0xac, 0xad, 0xab, 0xb
	
section .text
global main

; TODO b: implement array_reverse
array_reverse:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov ecx, 0

    mov edx, 0
reverse:
    mov dl, byte [eax + ecx]
    cmp dl, 0
    je exit_reverse
    push edx
    inc ecx
    cmp ecx, ebx
    jne reverse
exit_reverse:

    mov ecx, 0
put_array:
    pop edx
    mov [eax + ecx], byte dl
    inc ecx
    cmp ecx, ebx
    jne put_array

    leave
    ret

; TODO c: implement pow_arraypowArray
pow_array:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]  ;a
    mov ecx, [ebp + 12] ;len
    mov edi, [ebp + 16] ;b

loop_pow:
    mov al, byte [esi + ecx - 1]
    mov bl, al
    mul bl
    mov [edi + 2 * ecx - 2], word ax
    loop loop_pow

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ;TODO a: allocate on array of 20 byte elements and initializate it incrementally starting from 'A'
    mov ecx, 0
    sub esp, 24
    mov al, 65

init:
    mov [esp + ecx], byte al
    inc al
    inc ecx
    cmp ecx, 20
    jnz init

    mov ecx, 0
    xor eax, eax
print_array:
    mov al, byte [esp + ecx]
    PRINTF32 `%c\x0`, eax
    inc ecx
    cmp ecx, 20
    jnz print_array

    PRINTF32 `\n\x0`
    ;TODO b: call array_reverse and print reversed array
    PRINTF32 `%s\n\x0`, str_test

    push str_test
    call strlen
    add esp, 4

    push eax
    push str_test
    call array_reverse
    add esp, 8

    PRINTF32 `%s\n\x0`, str_test

    ;TODO c: call pow_array and print the result array
    push b_array
    push len
    push a_array
    call pow_array
    add esp, 12

    mov ecx, len
print_pow:
    mov bx, word [b_array + 2 * ecx - 2]
    PRINTF32 `%hd \x0`, ebx
    loop print_pow
    PRINTF32 `\n\x0`

	;;  TODO d: this print of an uint32_t should print babadac 
	PRINTF32 `%x\n\x0`, [byte_array] 

    xor eax, eax
    leave
    ret
