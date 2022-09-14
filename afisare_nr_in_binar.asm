section .data
    print_n db "Numar : %d", 10, 0
    print_bit db "%d", 0
    scan_format db "%zu", 0
    print_newline db 10, 0
    print_space db " "
    
section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    push ebx

    ;read and print number
    sub esp, 4
    mov eax, esp
    push eax
    push scan_format
    call scanf
    add esp, 8

    push dword[esp]
    push print_n
    call printf
    add esp, 8

    push dword[esp]
    call show_bit
    add esp, 4

    add esp, 4
    leave
    ret

; void show_bit(int n)
show_bit:
    push ebp
    mov ebp, esp
    
    mov ecx, 32
    mov ebx, 1
    shl ebx, 31

print:
    mov edx, [ebp + 8]
    and edx, ebx

    ;eddx 1 sau 0
    cmp edx, 0
    je bit_0
    mov edx, 1
    jmp bit_1
bit_0:
    mov edx, 0

bit_1:    
    ;save ebx, ecx
    push ebx
    push ecx

    ;print bit
    push edx
    push print_bit
    call printf
    add esp, 8

    

    ;restore ebx, ecx
    pop ecx
    pop ebx

    shr ebx, 1
    loop print

    push print_newline
    call printf
    add esp, 4

    leave
    ret