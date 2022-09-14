section .data
    scan_format db "%zu", 0
    print_num db "Num = %d", 10, 0
    print_fact db "%d! = %d", 10, 0

section .text
    extern scanf
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ;read number
    sub esp, 4
    lea eax, [ebp - 4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    ;print number
    push dword [ebp - 4]
    push print_num
    call printf
    add esp, 8

    ;calculate fact(a)
    push dword [ebp - 4]
    call rec_fact
    add esp, 4

    push eax
    push dword [ebp - 4]
    push print_fact
    call printf
    add esp, 12

    add esp, 4

    leave
    ret

    ;int rec_fact(int a)
rec_fact:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ;a
    
    ;case: 0! = 1
    cmp eax, 0
    je end_fact

    ;call rec_fact(a-1)
    dec eax
    push eax
    call rec_fact
    add esp, 4

    ;return a * fact(a-1)
    mov ebx, [ebp + 8] ;a
    mul ebx
    jmp done_rec_fact

end_fact:
    mov eax, 1

done_rec_fact:

    leave
    ret