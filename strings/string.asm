%include "utils/printf32.asm"
extern malloc
extern fgets
extern stdin
extern printf
extern strlen

section .data
    scanf_str db "%s", 0
    printf_str db "%s", 0
    printf_int db "%d", 0
    newline db 0xa, 0xd, 0

section .bss
    ptr_s resd 1

section .text
global main 

; char *read_str(int len)

read_str:
    enter 0, 0

    ; malloc(len, 1)
    push dword 1
    push dword[ebp + 8]
    call malloc
    add esp, 8

    ;fgets(str, len, stdin)
    push dword[stdin]
    push dword[ebp + 8]
    push eax
    call fgets
    add esp, 12

    leave
    ret

; int vocale(char *str, int len)
; vocale : a, e, i, o, u
; 97, 101, 105, 111, 117
vocale :
    push ebp
    mov ebp, esp

    push esi
    push ebx

    mov esi, dword[ebp + 8]
    mov ebx, dword[ebp + 12]

    xor eax, eax

    test ebx, ebx
    jle end

    xor edx, edx

check:
    movzx ecx, byte[esi + edx]
    cmp cl, 97
    je incr
    
    cmp cl, 101
    je incr
    
    cmp cl, 105
    je incr
        
    cmp cl, 111
    je incr
    
    cmp cl, 117
    jne endss

incr:
    inc eax

endss:
    inc edx
    cmp edx, ebx
    jne check

end:
    pop ebx
    pop esi
    pop ebp
    ret

main:
    enter 0, 0

    ; apel read_str(32)
    push dword 32
    call read_str
    add esp, 4

    mov dword[ptr_s], eax

    ; afisare sir citit
    push dword[ptr_s]
    push printf_str
    call printf
    add esp, 8

    ; strlen(str)
    push dword[ptr_s]
    call strlen
    add esp, 4

    ; apel vocale(str, strlen(str))
    push eax
    push dword[ptr_s]
    call vocale
    add esp, 4

    ; afisare nr de vocale
    push eax
    push printf_int
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 4
    
    leave
    ret