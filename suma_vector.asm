section .rodata
    vect1 dd 1, 2, 3, 4, 5, 6
    vect2 dd 7, 8, 9, 10
    len1 dd 6
    len2 dd 4
    format_scan db "%zu", 0
    format_print db "Pos = %d", 10, 0

section .data
    print_sum db "Sum = %d", 10, 0
    sum dd 0

section .text
    extern printf
    extern scanf

global main

    ; int sum(int pos)
sum_vectors:
    push ebp
    mov ebp, esp

    mov eax, 0 ; sum
    mov ebx, vect1 ; v1
    mov ecx, [ebp+8] ; pos

sum_vect1:
    mov edx, [ebx+ecx*4]
    add eax, edx
    add ecx, 1
    cmp ecx, [len1]
    jne sum_vect1

    mov ecx, [ebp+8]
    mov ebx, vect2 ; v2
sum_vect2:
    mov edx, [ebx+ecx*4]
    add eax, edx
    sub ecx, 1
    cmp ecx, 0
    jge sum_vect2


    leave
    ret

main:
    push ebp
    mov ebp, esp
    sub esp, 4
    
    ; read and print input (pos)
    ;----------------------;
    lea eax, [ebp-4]
    push eax
    push format_scan
    call scanf
    add esp, 8

    push dword[ebp-4]
    push format_print
    call printf
    add esp, 8
    ;----------------------;


    ; call sum(int pos)
    ;----------------------;
    push dword[ebp-4]
    call sum_vectors
    add esp, 4

    push eax
    push print_sum
    call printf
    add esp, 8
    ;----------------------;

    add esp, 4
    leave
    ret