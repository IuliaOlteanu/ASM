extern strlen
extern printf


section .rodata
    test_str db "hell, it's about time1234", 0
    test_chr db "%c", 10, 0
    format db "length = %d", 10, 0

section .text
global main


main:
    push ebp
    mov ebp, esp



    push test_str
    call strlen
    add esp, 4


    push eax
    push format
    call printf
    add esp, 8


    ; TODO a: Implement strlen-like functionality using a RECURSIVE implementation.
    push test_str
    call strlen_rec
    add esp, 4

    push eax
    push format
    call printf
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret

strlen_rec:
    push    ebp
    mov     ebp, esp

    mov     eax, dword [ebp+8]
    mov     al, byte [eax]

    test    al, al ;0 when al = 0
    jne     for_loop
    mov     eax, 0
    jmp     end

for_loop:
    mov     eax, dword [ebp+8]
    add     eax, 1

    push    eax
    call    strlen_rec
    add     esp, 4

    add     eax, 1

end:
    leave
    ret
