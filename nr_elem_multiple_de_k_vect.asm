section .rodata
    vect1 dd 1, 2, 3, 4, 5, 6
    len1 dd 6
    format_scan db "%zu", 0

section .data
    print_nr db "Nr de elemente multiple de %d = %d", 10, 0
    print_num db "k = %d", 10, 0

section .text
    extern printf
    extern scanf

global main
main:
    push ebp
    mov ebp, esp

    ;citire k
    sub esp, 4
    lea eax, [ebp - 4]
    push eax
    push format_scan
    call scanf
    add esp, 8

    ;afisare k
    push dword[ebp - 4]
    push print_num
    call printf
    add esp, 8

    ;apel functie
    push dword[ebp - 4]
    call nr_multiplii_k
    add esp, 4

    ;afisare rezultat
    push eax
    push dword[ebp - 4]
    push print_nr
    call printf
    add esp, 12

    add esp, 4
    leave
    ret

; int nr_multiplii(int k)
nr_multiplii_k:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8] ;k
    mov ecx, [len1]
    xor eax, eax

nr:
    push eax
    mov edx, [vect1 + ecx * 4 - 4]
    mov eax, edx
    xor edx, edx
    div ebx
    pop eax
    cmp edx, 0
    je adaugare_multiplii

    dec ecx
    cmp ecx, 0
    je end
    jmp nr

adaugare_multiplii:
    add eax, 1
    dec ecx
    cmp ecx, 0
    je end
    jmp nr

end:
    leave
    ret    