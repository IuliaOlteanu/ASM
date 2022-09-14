
section .data
    vector dd 10, 29, 31, 5, 100
    len dd 5
    sir db "elem maxim = %d", 10, 0

section .text
    extern printf

global main
; int max(int array[], int len)

main:
    push ebp
    mov ebp, esp
    push dword[len]
    push vector

    call maxim
    add esp, 8
    
    push eax
    push sir
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret

maxim:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    mov eax, dword[ebx]

small:
    mov edx, [ebx + 4 * ecx - 4]
    cmp eax, edx
    jg small_leave
    mov eax, edx
small_leave:
    loop small

    leave 
    ret