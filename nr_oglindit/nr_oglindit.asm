section .data
    num dd 0
    print_num db "Numar : %d", 10, 0
    print_oglindit db "Numar oglindit: %d", 10, 0
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

    ; apel fct oglindit
    push dword[num]
    call oglindit
    add esp, 4

    ; ;afisare rezultat
    push eax
    push print_oglindit
    call printf
    add esp, 12

    leave
    ret

; int oglindit(int n)
oglindit:
    push ebp
    mov ebp, esp

    push esi
    push ebx
    mov ecx, dword[ebp + 8]
    xor eax, eax
    mov esi, 1717986919
    test ecx, ecx
    je end
for:
    lea ebx, [eax + eax * 4]
    mov eax, ecx
    imul esi
    sar edx, 2
    mov eax, ecx
    sar eax, 31
    sub edx, eax
    lea eax, [edx + edx * 4]
    add eax, eax
    sub ecx, eax
    lea eax, [ecx + ebx * 2]
    mov ecx, edx
    test edx, edx
    jne for
end:
    pop ebx
    pop esi
    pop ebp 
    ret
