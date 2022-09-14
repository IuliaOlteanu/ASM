section .rodata
    scan_format db "%c", 0
    string db "Ana are mere", 0
    print_ch db "Caracter : %c", 10, 0
    print_sir db "%s", 10, 0

section .data
    ch_de_gasit db 0
    
section .text
    extern scanf
    extern printf

global main

main:
    push ebp
    mov ebp, esp
    
    ; afisare sir
    push string
    push print_sir
    call printf
    add esp, 8

    ; citire caracterul de gasit in sir
    push ch_de_gasit
    push scan_format
    call scanf
    add esp, 8

    ; afisare
    push dword[ch_de_gasit]
    push print_ch
    call printf
    add esp, 8

    ;apel functie strchr
    push dword[ch_de_gasit]
    push string
    call strchr
    add esp, 8

    ; afisare rezultat functie strchr
    push eax
    push print_sir
    call printf
    add esp, 8

    leave
    ret

; char *strchr(char *sir, char c)
strchr:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    xor edx, edx
    xor ecx, ecx
cautare:
    mov dl, byte[eax+ ecx]; sir[ecx]

    cmp edx, 0
    je negasit

    ;cmp sir[ecx],c
    cmp edx, ebx
    je gasit

    inc ecx
    jmp cautare

negasit:
    mov eax, 0
    jmp end

gasit:
    add eax, ecx

end:
    leave
    ret
