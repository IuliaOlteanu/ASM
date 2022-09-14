section .rodata
    vect1 dd 1, 2, 3, 4, 5, 6
    len1 dd 6
    
section .data
    print_sum db "Sum = %d", 10, 0
    sum dd 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    
    push dword[len1]
    push vect1
    call suma_vector
    add esp, 8

    push eax
    push print_sum
    call printf
    add esp, 8

    leave
    ret

;int suma_vector(int *v, int len)
suma_vector:
    push ebx
    mov edx, DWORD [esp+12]
    mov ebx, DWORD [esp+8]
    test edx, edx
    jle L5
    xor eax, eax
    xor ecx, ecx
L4:
    test al, 1
    jne L3
    add ecx, DWORD [ebx+eax*4]
L3:
    add eax, 1
    cmp edx, eax
    jne L4
    mov eax, ecx
    pop ebx
    ret
L5:
    xor ecx, ecx
    pop ebx
    mov eax, ecx
    ret

