%include "utils/printf32.asm"

section .data
    arr1 db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x99, 0x88
    len1 equ $-arr1
    arr2 db 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef
    len2 equ $-arr2
    val1 dd 0xabcdef01
    val2 dd 0x62719012


section .text
    extern printf

global main


main:
    push ebp
    mov ebp, esp


    ; TODO a: Print if sign bit is present or not.
    mov eax, dword [val1] ;1010 1011 1100 1101 1110 1111 0000 0001
    mov ebx, 1  ;0000 0000 0000 0000 0000 0000 0000 0001
    shl ebx, 31 ;1000 0000 0000 0000 0000 0000 0000 0000
    and eax, ebx ;si pe biti 
    shr eax, 31
    PRINTF32 `val1 are bit de semn: %d\n\x0`, eax

    xor eax, eax
    xor ebx, ebx
    mov eax, dword [val2] ;0110 0010 0111 0001 1001 0000 0001 0010
    mov ebx, 1  ;0000 0000 0000 0000 0000 0000 0000 0001
    shl ebx, 31 ;1000 0000 0000 0000 0000 0000 0000 0000
    and eax, ebx ;si pe biti 
    shr eax, 31
    PRINTF32 `val2 are bit de semn: %d\n\x0`, eax

    ; TODO b: Prin number of bits for integer value.
    mov ecx, 32
    mov eax, dword [val2]
    mov edx, 0

nr_biti:
    mov ebx, 1
    and ebx, eax
    cmp ebx, 1
    jne salt
    inc edx

salt:
    shr eax, 1
    loop nr_biti

    PRINTF32 `val2 are %d biti\n\x0`, edx

    ; TODO c: Prin number of bits for array.
    push esi
    mov esi, len1
    mov edx, 0 ;number of bytes

iterate_array:
    mov ecx, 8 ;arr1 - chars array => 8 bytes
    mov al, byte [arr1 + esi - 1]

byte_numbers:
    mov ebx, 1 ;masca
    and ebx, eax
    cmp ebx, 1
    jne loop_byte_numbers
    inc edx

loop_byte_numbers:
    shr eax, 1
    loop byte_numbers

    dec esi
    cmp esi, 0
    jne iterate_array

    PRINTF32 `arr1 are %d biti\n\x0`, edx

    pop esi
    ; Return 0.
    xor eax, eax
    leave
    ret
