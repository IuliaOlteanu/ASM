
section .data
    vector dd 10, 29, 31, 5, 100
    len dd 5
    sir db "elem minim = %d", 10, 0

section .text
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    mov ecx, [len]
    mov eax, [vector]
min_elem:
    mov edx, [vector + 4 * ecx - 4]
    cmp eax, edx
    jl end
    mov eax, edx
end:
    loop min_elem

    push eax
    push sir
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret
