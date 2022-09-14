section .data
    num dd 0
    print_num db "Numar : %d", 10, 0
    print_fact db "%d! : %d", 10, 0
    scanf_format db "%zu", 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp

    ;citire numar 
    push num
    push scanf_format
    call scanf
    add esp, 8

    ;afisare numar
    push dword[num]
    push print_num
    call printf
    add esp, 8

    ; apel fct factorial
    push dword[num]
    call factorial
    add esp, 4

    ; ;afisare rezultat
    push eax
    push dword[num]
    push print_fact
    call printf
    add esp, 12

    leave
    ret

; int factorial(int n)
factorial:

    push ebx
    sub esp, 8
    mov ebx, dword[esp + 16] ; n
    ; caz de baza
    ; 0! = 1
    ; 1! = 1
    mov eax, 1
    cmp ebx, 1
    ja recursiv

    ; n! = n * (n - 1)!
    ; fact(n) = n * fact(n - 1)
end:
    add esp, 8
    pop ebx
    ret

recursiv:
    sub esp, 12
    lea eax, [ebx - 1]
    push eax
    call factorial
    add esp, 16
    imul eax, ebx
    jmp end



