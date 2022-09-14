%include "../utils/printf32.asm"

%define ARRAY_SIZE    10

section .data
    dword_array dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    print_format1 db "Sum even is ", 0
    print_format2 db "Odd even is ", 0

section .text
extern printf
global main
main:
    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor esi, esi            ; Store even sum in esi.
    xor edi, edi            ; Store odd sum in edi.
next_element:

    ; We need to initialize the dividend (EDX:EAX) to 0:array_element
    xor edx, edx
    mov eax, dword [dword_array + ecx*4 - 4]
    ; Store the divisor (2) in EBX.
    mov ebx, 2
    div ebx

    ; EDX stores remainder. If remainder is 0, number is even, otherwise number is odd.
    test edx, edx
    je add_to_even
    add edi, dword [dword_array + ecx*4 - 4]
    jmp test_end
add_to_even:
    add esi, dword [dword_array + ecx*4 - 4]
    loop next_element
test_end:
    loop next_element ; Decrement ecx, if not zero, go to next element.

    PRINTF32 `%s\x0`, print_format1
    PRINTF32 `%d\n\x0`, esi
    PRINTF32 `%s\x0`, print_format2
    PRINTF32 `%d\n\x0`, edi

    ret
