section .data
    num dd 0
    sum_cifre dd 0
    sum_cifre_print db "Suma : %d", 10, 0
    sum_cifre_recursiv db "Suma recursiv : %d", 10, 0
    print_num db "Numar : %d", 10, 0
    print_cifre db "Numar de cifre : %d", 10, 0
    print_cifre_rec db "Numar de cifre recursiv : %d", 10, 0
    scanf_format db "%zu", 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    push ebx

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

    push dword sum_cifre
    push dword[num]
    call suma_cifre
    add esp, 4

    push dword[sum_cifre]
    push sum_cifre_print
    call printf
    add esp, 8

    pop ebx
    leave
    ret

; int suma(int n)
suma_cifre:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov ecx, 0
s_cifre:
    inc ecx
    ; n = n / 10
    mov esi, 10
    xor edx, edx
    div esi

    add [ebx], edx
    ; if n == 0 -> end
    cmp eax, 0
    je end2
    jmp s_cifre
end2:
    mov eax, ecx
    leave
    ret

  

