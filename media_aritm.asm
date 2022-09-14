section .data
    size_format_scan db "Size = ", 0
    size_format_print db "Size = %d", 10, 0
    scan_format db "%zu", 0
    array_string_numbers db "Insert %d numbers ", 10, 0
    array_print db "Array: ", 10, 0
    array_print_number db "Array[%d] = %d", 10, 0
    array_mean db "Mean = %d", 10, 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    push ebx

    ;scan size & print size
    sub esp, 4
    lea eax, [esp] ; <=> mov eax, ebp && sub eax, 4
    push eax
    push scan_format
    call scanf
    add esp, 8

    push dword [esp]
    push size_format_print
    call printf
    add esp, 8
    ;------------------------

    ;save on stack elements of array
    push dword [esp]
    push array_string_numbers
    call printf
    add esp, 8

    mov ecx, [esp]
scan_array:
    ;alloc element array[i]
    sub esp, 4
    push ecx

    ;read element array[i]
    lea eax, [esp + 4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    pop ecx
    loop scan_array
    ;----end read array----

    
    ;print array
    lea eax, [esp] ;int *array
    mov ebx, [ebp - 8]  ;size of array
    push eax
    push ebx
    call print_array
    add esp, 8
    ;--------------

    ; sum + print mean
    mov eax, esp ;int *array
    mov ebx, [ebp - 8]  ;size of array
    push eax
    push ebx
    call mean_array
    add esp, 8

    push eax
    push array_mean
    call printf
    add esp, 8

    ; free stack
    mov ecx, [ebp - 8]
free_stack:
    add esp, 4
    loop free_stack

    add esp, 4
    pop ebx
    leave
    ret

    ;void print_array(size n, int *array)
print_array:
    push ebp
    mov ebp, esp

    ;print some text
    push array_print
    call printf
    add esp, 4
    ;---------------

    mov ecx, [ebp + 8]

print:
    mov eax, [ebp + 12]
    push ecx

    ;print array[ecx]
    mov ebx, [eax + ecx * 4 - 4]
    push ebx
    push ecx
    push array_print_number
    call printf
    add esp, 12

    pop ecx
    loop print

    leave
    ret

; int sum(size n, int *v)
mean_array:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 8]
    xor eax, eax

sum_array:
    mov ebx, [ebp + 12]
    mov ebx, [ebx + ecx * 4 - 4]
    add eax, ebx
    loop sum_array

    xor edx, edx
    mov ecx, [ebp + 8]
    div ecx

    leave
    ret