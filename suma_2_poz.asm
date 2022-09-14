section .data    
    arr dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400
    pos1 dd 0
    pos2 dd 0
    scan_format db "%zu", 0
    print_pos1 db "Poz1 : %d", 10, 0
    print_pos2 db "Poz2 : %d", 10, 0
    print_rez db "arr[%d] + arr[%d] = %d", 10, 0
    res dd 0

section .text
    extern printf
    extern scanf

global main    

main:
    push ebp
    mov ebp, esp

    ; citire pos1 si pos2 de la tastatura
    push pos1
    push scan_format
    call scanf
    add esp, 8

    push pos2
    push scan_format
    call scanf
    add esp, 8

    ;afisare pos1 si pos2
    push dword[pos1]
    push print_pos1
    call printf
    add esp, 8  

    push dword[pos2]
    push print_pos2
    call printf
    add esp, 8

    xor eax, eax
    ;suma dintre array[pos1] + array[pos2]
    mov ecx, dword[pos1]
    mov edx, dword[pos2]
    mov eax, [arr + ecx * 4 - 4]
    add eax, [arr + edx * 4 - 4]

    push eax
    push dword[pos2]
    push dword[pos1]
    push print_rez
    call printf
    add esp, 16

    xor eax, eax

    leave
    ret