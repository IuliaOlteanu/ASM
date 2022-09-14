extern printf
extern scanf

section .data
    printf_fmt_int_newline: db "%d", 10, 0
    arr:                    dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700
    N:                      dd 17
    msj db "%d %d", 0
    msjerror db "nah bro", 10, 0

section .bss
pos1 resd 1
pos2 resd 1

section .text
global main

is_pow2:
    push ebp
    mov ebp, esp

    ; TODO a
    
    mov ebx, [ebp+8]

    mov eax, dword 2

    mov ecx, dword 2

next_pow:

    cmp eax, ebx
    je par
    jg notpar
    mul ecx
    jmp next_pow

par:
    mov eax, dword 0

    jmp stop

notpar:

    mov eax, dword -1  

stop:     

    leave
    ret


sum_interval:
    push ebp
    mov ebp, esp

    ; TODO b

    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
    mov edx, [ebp+16]

    xor eax, eax

    mov esi, ecx

next_number:
    add eax, [ebx+4*esi]
    inc esi
    cmp esi, edx
    jl next_number    

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a
    push 8
    call is_pow2
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push 10
    call is_pow2
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT:
    ; 0
    ; -1

;     ; TODO b
    push dword[N]
    push 0
    push arr
    call sum_interval
    add esp, 12

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push 3
    push 1
    push arr
    call sum_interval
    add esp, 12

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

;     ; OUTPUT:
;     ; 15300
;     ; 500

;     ; TODO c

    push pos2
    push pos1
    push msj
    call scanf
    add esp, 12

    mov esi, [pos1]
    mov edi, [pos2]

    push esi
    push edi

    push dword [pos1]
    call is_pow2
    add esp, 4

    pop edi
    pop esi

    cmp eax, dword -1
    je error

    push esi
    push edi

    push dword [pos2]
    call is_pow2
    add esp, 4

    pop edi
    pop esi

    cmp eax, dword -1
    je error

    push edi
    push esi
    push arr
    call sum_interval
    add esp, 12

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    jmp stophere

error:
    push msjerror
    call printf
    add esp, 4

stophere:    
    xor eax, eax
    leave
    ret
