section .data
    scan_format db "%zu", 0
    print_a db "Num a = %d", 10, 0
    print_b db "Num b = %d", 10, 0
    print_rez db "cmmmdc(%d, %d) = %d", 10, 0

section .text
    extern scanf
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ;read numbers a and b
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

    ;print numbers a and b
    push dword [ebp - 4]
    push print_a
    call printf
    add esp, 8

    push dword [ebp - 8]
    push print_b
    call printf
    add esp, 8

    ; apel functie cmmmdc(a,b)
    push dword[ebp - 8]
    push dword[ebp - 4]
    call cmmmdc
    add esp, 8

    ; afisare rez
    push eax
    push dword[ebp - 8]
    push dword[ebp - 4]
    push print_rez
    call printf
    add esp, 16
    
    add esp, 8
    leave
    ret

;int cmmmdc(int a, int b)

cmmmdc:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]

    ; b = 0 => cmmmdc(a,0) = a
    cmp ebx, 0
    je end

    ; cmmmdc(b, a % b)
    xor edx, edx
    div ebx
    mov ebx, [ebp + 12] ; b
    push edx
    push ebx
    call cmmmdc
    add esp, 8

end:
    leave
    ret