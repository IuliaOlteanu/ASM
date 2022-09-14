section .rodata
    scan_format db"%zu", 0
    print_format db "Numar : %d", 10, 0
    print_index db "Index al bitului maxim de la %d : %d", 10, 0
section .data
    num dd 0

section .text
    extern printf    
    extern scanf

global main

main:
    push ebp
    mov ebp, esp

    ;citire numar
    push num
    push scan_format
    call scanf
    add esp, 8

    ;afisare numar
    push dword[num]
    push print_format
    call printf
    add esp, 8

    ;apel functie
    push dword[num]
    call index_max_bit
    add esp, 4

    ;afisare rezultat
    push eax
    push dword[num]
    push print_index
    call printf
    add esp, 12

    leave
    ret
;int index_max_bit(int nr)
index_max_bit:
    push ebp
    mov ebp, esp

    mov ecx, 32 ; contot
    mov edx, 1  ; masca
    shl edx, 31

gasire_index:
    mov ebx, [ebp + 8]
    and ebx, edx

    cmp ebx, 0
    jne end

    shr edx, 1
    loop gasire_index
end:
    mov eax, ecx
    leave
    ret