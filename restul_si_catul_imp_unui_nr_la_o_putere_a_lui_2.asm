section .data
    scan_format db "%zu", 0
    print_num db "Num = %d", 10, 0
    print_2_exp db "Exp = %d", 10, 0
    print_div_rez db "%d / (2 ^ %d) = %d", 10, 0
    print_modulo_rez db "%d % (2 ^ %d) = %d", 10, 0


section .text
    extern scanf
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ;read number and exp 
    sub esp, 8
     lea eax, [ebp - 4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    lea eax, [ebp - 8]
    push eax
    push scan_format
    call scanf
    add esp, 8

    ;print number and exp
    push dword [ebp - 4]
    push print_num
    call printf
    add esp, 8

    push dword[ebp - 8]
    push print_2_exp
    call printf
    add esp, 8

    ; apel functie div_bit
    push dword[ebp - 8]
    push dword[ebp - 4]
    call div_bit
    add esp, 8

    ; afisare rez
    push eax
    push dword[ebp - 8]
    push dword[ebp - 4]
    push print_div_rez
    call printf
    add esp, 16

    ; apel functie modulo_bit
    push dword[ebp - 8]
    push dword[ebp - 4]
    call modulo_bit
    add esp, 8

    ; afisare rez
    push eax
    push dword[ebp - 8]
    push dword[ebp - 4]
    push print_modulo_rez
    call printf
    add esp, 16

    add esp, 8
    leave
    ret

; int div_bit(int a, int exp)
div_bit:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ;a
    mov ecx, [ebp + 12] ;exp

div_2:
    shr eax, 1
    loop div_2

    leave
    ret

; int modulo_bit(int a, int exp)
modulo_bit:
    push ebp
    mov ebp, esp

    mov eax, 1
    mov ecx, [ebp + 12] ;exp

    ; calcul 2^exp
pow_2:
    mov ebx, 2
    mul ebx
    loop pow_2

    ; ebx = 2^exp - 1
    ; eax = a
    ; rez = a & ebx
    mov ebx, eax
    dec ebx
    mov eax, [ebp + 8]
    and eax, ebx

    leave
    ret