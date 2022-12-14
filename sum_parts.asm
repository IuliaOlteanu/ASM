extern scanf
extern printf


section .data
    uint_format    db "%zu", 0
    uint_format_newline    db "%zu", 10, 0
    pos1_str    db "Introduceti prima pozitie: ", 0
    pos2_str   db "Introduceti a doua pozitie: ", 0
    sum_str db "Suma este: %zu", 10, 0
    sum_interval_str db "Suma de la pozitia %zu la pozitia %zu este %zu", 10, 0
    arr     dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400
    pos1 dd 0
    pos2 dd 0

section .text
global main


sum:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum() to compute sum for array.
    mov eax, 0
    mov ebx, [ebp + 8]  ;array
    mov ecx, [ebp + 12] ;length

for_sum:
    add eax, [ebx + ecx * 4 - 4]
    loop for_sum
    
    leave
    ret


sum_interval:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum_interval() to compute sum for array between two positions.
    mov eax, 0
    mov ebx, [ebp + 8]  ;array
    mov ecx, [ebp + 12] ;first pos
    mov edx, [ebp + 16] ;last pos
    
for_sum_interval:
    add eax, [ebx + ecx * 4]
    inc ecx
    cmp ecx, edx
    jnz for_sum_interval

    leave
    ret


main:
    push ebp
    mov ebp, esp


    push dword 14
    push arr
    call sum
    add esp, 8

    push eax
    push sum_str
    call printf
    add esp, 8


    ; TODO b: Call sum_interval() and print result.
    push dword 4
    push dword 1
    push arr
    call sum_interval
    add esp, 12

    push eax
    push dword 4
    push dword 1
    push sum_interval_str
    call printf
    add esp, 16

    ; TODO c: Use scanf() to read positions from standard input.
    push pos1_str
    call printf
    add esp, 4

    push pos1
    push uint_format
    call scanf
    add esp, 8

    push pos2_str
    call printf
    add esp, 4

    push pos2
    push uint_format
    call scanf
    add esp, 8

    push dword [pos2]
    push dword [pos1]
    push arr
    call sum_interval
    add esp, 12

    push eax
    push dword [pos2]
    push dword [pos1]
    push sum_interval_str
    call printf
    add esp, 16

    ; Return 0.
    xor eax, eax
    leave
    ret
