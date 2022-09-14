%include "utils/printf32.asm"

extern printf

section .data
    num dd 55555123                    
section .text
global main

main:
    push ebp
    mov ebp, esp

    ;TODO a: print least significant 2 bits of the second most significant byte of num
    mov eax, dword [num]
    mov ebx, 1

    shl ebx, 16
    and ebx, eax
    shr ebx, 16
    A
    PRINTF32 `bit 16 = %d\n\x0`, ebx

    mov ebx, 1
    shl ebx, 17
    and ebx, eax
    shr ebx, 17
    
    PRINTF32 `bit 17 = %d\n\x0`, ebx

    ;TODO b: print number of bits set on odd positions
    mov eax, dword [num]
    mov edx, 0 ;number of bytes
    mov ecx, 0 ;contor
    mov ebx, 1 ;masca
numarare:
    test eax, ebx
    jz loop_numarare
    inc edx
loop_numarare:
    add ecx, 2
    shl ebx, 2
    cmp ecx, 32
    jnz numarare

    PRINTF32 `Nr biti poziti pare = %d\n\x0`, edx
    ;TODO c: print number of groups of 3 consecutive bits set

    mov ebx, 7 ;0111
    mov edi, 7
    mov eax, [num]
    mov ecx, 0
    mov edx, 0
group:
    mov edi, ebx
    and edi, eax
    cmp edi, ebx
    jne loop_group
    inc edx
loop_group:
    shl ebx, 1
    inc ecx
    cmp ecx, 30
    jnz group

    PRINTF32 `Nr biti perechi cate 3 = %d\n\x0`, edx

    xor eax, eax
    leave
    ret
