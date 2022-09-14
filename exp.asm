;f = (a+b)(b+c)(c+d)/(a+b+c+d)

section .data
    var_a dd 4
    var_b dd 4
    var_c dd 4
    var_d dd 4
    string_scan db "Var = %d", 10, 0
    string_print db "Expresie = %d", 10, 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp

    push dword[var_a]
    push dword[var_b]
    call add_2_numbers
    add esp, 8

    push eax

    push dword[var_b]
    push dword[var_c]
    call add_2_numbers
    add esp, 8

    push eax

    push dword[var_d]
    push dword[var_c]
    call add_2_numbers
    add esp, 8

    pop ecx
    pop ebx
    mul ecx
    mul ebx

    push eax

    push dword[var_d]
    push dword[var_c]
    push dword[var_b]
    push dword[var_a]
    call add_4_numbers
    add esp, 16


    mov ecx, eax


    pop eax
    xor edx, edx
     
    div ecx

    push eax
    push string_print
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret

add_2_numbers:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    add eax, ebx

    leave
    ret

add_4_numbers:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov ecx, [ebp + 16]
    mov edx, [ebp + 20]
    add eax, ebx
    add eax, ecx
    add eax, edx

    leave
    ret