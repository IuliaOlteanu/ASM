section .data
    myVect dd 1, 2, 3, 4, 5
    length dd 5
    string db "Sum = %d", 10, 0
    
section .text
    extern printf

global main

main:
    push ebp
    mov ebp, esp
    push ebx

    mov ecx, [length]
    mov eax, 0

sum:
    mov edx, dword [myVect + ecx * 4 - 4]
    add eax, edx
    loop sum

    push eax
    push string
    call printf
    add esp, 8

    pop ebx
    xor eax, eax
    leave
    ret