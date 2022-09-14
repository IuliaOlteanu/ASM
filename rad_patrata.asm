section .data
    nr dd 0
    string db "Radacina patrata este = %d", 10, 0
    citire db "%zu", 0
    citire_newline db "%zu", 10, 0
    afisare db "Numarul este %d", 10, 0

    
section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    push ebx

    push nr
    push citire
    call scanf
    add esp, 8

    push dword[nr]
    push afisare
    call printf
    add esp, 8

    push dword[nr]
    call radacina
    add esp, 4

    push eax
    push string
    call printf
    add esp, 8

    pop ebx
    xor eax, eax
    leave
    ret


radacina:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor ecx, ecx
rad:
    mov eax, ecx
    xor edx, edx
    mul eax

    cmp eax, ebx ; eax * eax = ebx
    je gasit

    cmp eax, ebx ; eax * eax > ebx && (eax - 1) ^ 2 < ebx
    jg rad_intreaga
    inc ecx
    jmp rad

rad_intreaga:
    dec ecx
    mov eax, ecx
    jmp end

gasit:
    mov eax, ecx

end:
    leave 
    ret