section .rodata
    scan_format db "%c", 0
    string db "ana are mere", 0
    print_sir db "%s", 10, 0
    format_res db "Rez = %d", 10, 0

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

    ; apel functie litere_mici
    push string
    call litere_mici
    add esp, 4

    ; afisare daca contine sau nu
    push eax
    push format_res
    call printf
    add esp, 8

    leave
    ret

; int litere_mici(char *sir)
litere_mici:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]; sirul
    xor ecx, ecx ; contor
    xor edx, edx
    mov eax, 1

test_chr:
    mov dl, byte[ebx + ecx]
    
    ;sir[ecx] = 0
    cmp edx, 0
    je end
    
    ;sir[ecx] > A
    cmp edx, 65
    jl step

    ;sir[ecx] < Z
    cmp edx, 90
    jl litere_mare

step:
    inc ecx
    jmp test_chr

litere_mare:
    xor eax, eax    

end:
    leave
    ret