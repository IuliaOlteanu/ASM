section .data
    print_n db "Numar : %x", 10, 0
    print_bit db "Al catelea bit : %x", 10, 0
    scan_format db "%zu", 0
    print_new_n db "Noul numar : %x", 10, 0
    
section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    push ebx

    ;citire numar si p 
    ;[ebp + 4] ->n
    ;[ebp + 8] -> p

    sub esp, 8

    ;----n-----
    lea eax, [ebp - 4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    ;----p----
    lea eax, [ebp - 8]
    push eax
    push scan_format
    call scanf
    add esp, 8

    push dword[ebp - 4]
    push print_n
    call printf
    add esp, 8

    push dword[ebp - 8]
    push print_bit
    call printf
    add esp, 8

    ;apel functie change_bit_zero
    push dword[ebp - 8]
    push dword[ebp - 4]
    call change_bit_zero
    add esp, 8

    push eax
    push print_new_n
    call printf
    add esp, 8

    add esp, 8
    leave
    ret

; int change_bit_zero(int n, int p)
change_bit_zero:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ;n
    mov ecx, [ebp + 12] ;p
    mov ebx, 1 ;masca

    cmp ecx, 0
    je make_masc_zero

make_masc_zero:
    shl ebx, 1
    loop make_masc_zero

jmp_make_masc_zero:
    not ebx
    and eax, ebx
    leave
    ret

; pt change_bit_unu se face or eax, ebx la final si fara not