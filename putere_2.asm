section .data
    pow db "pow : %d", 10, 0
    res db "pow(2, %d) = %d", 10, 0
    scan_format db "%zu", 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    
    ; read and print pow
    sub esp, 4
    push esp
    push scan_format
    call scanf
    add esp, 8

    push dword[esp]
    push pow
    call printf
    add esp, 8

    ; apel functie 
    push dword[esp]
    call pow_2_n
    add esp, 4

    push eax
    push dword[ebp - 4]
    push res
    call printf
    add esp, 8

    add esp, 4
    leave
    ret

pow_2_n:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 8]
    mov eax, 1

    ; 2^0 = 1
    cmp ecx, 0
    je end

calcul:
    shl eax, 1
    loop calcul

end:

    leave
    ret