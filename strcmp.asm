section .rodata
    string1 db "banana", 0
    string2 db "banana", 0
    print_format db "%s", 10, 0
    print_cmp db "%d", 10, 0

section .text
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ;print strings
    push string1
    push print_format
    call printf
    add esp, 8

    push string2
    push print_format
    call printf
    add esp, 8

    ;print strcmp(string1, string 2)
    push string2
    push string1
    call strcmp
    add esp, 8

    push eax
    push print_cmp
    call printf
    add esp, 8

    leave
    ret

    ;int strcmp(char *string1, char *string2)
strcmp:
    push ebp
    mov ebp, esp

    mov ecx, 0
    mov eax, 0

compare:
    mov ebx, 0
    mov edx, 0

    mov esi, [ebp + 8]
    mov bl, byte [esi + ecx]

    mov edi, [ebp + 12]
    mov dl, byte [edi + ecx]

    cmp ebx, 0
    je string1_end

    cmp edx, 0
    je string2_end

    sub ebx, edx
    cmp ebx, 0
    jne finish_strcmp

    inc ecx
    jmp compare

finish_strcmp:
    mov eax, ebx
    jmp done_strcmp

string2_end:
    cmp ebx, 0
    je string1_and_string2_equal

    mov eax, ebx
    jmp done_strcmp

string1_end:
    cmp edx, 0
    je string1_and_string2_equal
    

    sub eax, edx
    jmp done_strcmp

string1_and_string2_equal:
    mov eax, 0
    jmp done_strcmp

done_strcmp:

    leave
    ret