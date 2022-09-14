extern printf
extern scanf
extern malloc

section .data
    size_format_scan db "Insert size", 10, 0
    size_format_print db "Size = %d", 10, 0
    scan_format db "%zu", 0
    array_elem db "arr[%d] = %d", 10, 0
    dim dd 0
    sum_par db "suma = %d", 10, 0

section .bss
    ptr_arr resd 1

section .text
global main

; int *new_array(int len)

new_array:
    enter 0, 0

    mov eax, dword[ebp + 8] ; len
    shl eax, 2 ; 4 * len

    ; malloc(4*len)
    push eax
    call malloc
    add esp, 4

    leave
    ret

; void print_arr(int *arr, int len)
print_arr:
    enter 0, 0

    mov ebx, dword[ebp + 8]
    xor ecx, ecx

for_print:
    push ecx
    mov edx, dword[ebx + ecx * 4]

    push edx
    push ecx
    push array_elem
    call printf
    add esp, 12

    pop ecx
    inc ecx
    cmp ecx, dword[ebp + 12]
    jl for_print

    leave
    ret

; int sum_poz_pare(int *arr, int len)
sum_poz_pare:
    enter 0, 0

    mov ebx, dword[ebp + 8]
    xor ecx, ecx

for_sum:
    add eax, dword[ebx + ecx * 4]
    add ecx, 2
    cmp ecx, dword[ebp + 12]
    jl for_sum

    leave
    ret
main:
    enter 0, 0

    ; afisare text : Insert size
    push size_format_scan
    call printf
    add esp, 4

    ; citire dimensiune
    push dim
    push scan_format
    call scanf
    add esp, 8

    ; afisare dimensiune
    push dword[dim]
    push size_format_print
    call printf
    add esp, 8

    ; creare vector cu elem de la tastatura
    push dword[dim]
    call new_array
    add esp, 4

    mov dword[ptr_arr], eax

    xor ecx, ecx
    sub esp, 4

for_arr:
    pusha
    mov edx, ebp
    sub edx, 4
    ; citire de la tastatura

    push edx
    push scan_format
    call scanf
    add esp, 8

    popa

    mov ebx, dword[ebp - 4]
    mov dword[eax + ecx * 4], ebx
    inc ecx
    cmp ecx, dword[dim]
    jl for_arr

    add esp, 4

    ; afisare vector

    push dword[dim]
    push dword[ptr_arr]
    call print_arr
    add esp, 8

    xor eax, eax
    ; calcul sumei elem de pe poz pare
    push dword[dim]
    push dword[ptr_arr]
    call sum_poz_pare
    add esp, 8

    ; afisare
    push eax
    push sum_par
    call printf
    add esp, 8

    leave
    ret

