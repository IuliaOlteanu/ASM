section .rodata
    vect1 dd 1, 2, 3, 4, 5, 6
    len1 dd 6

section .data
    print_sum db "Sum = %d", 10, 0

section .text
    extern printf
    extern scanf

global main


sum_even:
    push ebp
    mov ebp, esp

    mov ecx, [len1]
    sub ecx, 1
    mov eax, 0
parcurgere:
    mov ebx, 2
    mov edx, 0

    push eax
    mov eax, ecx
    push ecx

    div ebx
    pop ecx
    pop eax

    cmp edx, 0
    je add_sum

    sub ecx, 1
    cmp ecx, 0
    jl end
    jmp parcurgere

add_sum:
    mov ebx, vect1
    add eax, [ebx+ecx*4]
    xor ebx, ebx
    sub ecx, 1
    cmp ecx, 0
    jl end
    jmp parcurgere

end:

    leave
    ret

main:
    push ebp
    mov ebp, esp

    call sum_even

    push eax
    push print_sum
    call printf
    add esp, 8

    leave
    ret