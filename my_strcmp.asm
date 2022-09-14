section .rodata
    sir1 db "abc", 10, 0
    sir2 db "abb", 10, 0
    print_format db "%s", 10, 0
    print_cmp db "%d", 10, 0


section .text
    extern printf    
    extern scanf

global main

main:
    push ebp
    mov ebp, esp

    ; afisare siruri
    push sir1
    push print_format
    call printf
    add esp, 8

    push sir2
    push print_format
    call printf
    add esp, 8

    ;apel strcmp
    push sir2
    push sir1
    call strcmp
    add esp, 8

    ;afisare
    push eax
    push print_cmp
    call printf
    add esp, 8

    leave
    ret

;int strcmp(char *s1, char *s2)

strcmp:
    push esi
    push ebx
    sub esp, 4
    mov ebx, DWORD[esp+16]
    mov esi, DWORD[esp+20]
    movzx edx, BYTE[ebx]
    movzx ecx, BYTE[esi]
    cmp dl, cl
    jl caz_1
    mov eax, 1
    jg end
    test dl, dl
    jne recursiv

end:
    add esp, 4
    pop ebx
    pop esi
    ret 

recursiv:    
    sub esp, 8
    add esi, 1
    push esi
    add ebx, 1
    push ebx
    call strcmp
    add esp, 16
    jmp end

caz_1:
    mov eax, -1
    jmp end
