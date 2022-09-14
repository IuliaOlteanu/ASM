%include "utils/printf32.asm"

section .data
    num dd 0
    print_elem db "%d ", 0
    print_num db "Numar : %d", 10, 0
    print_cifre db "Numar de cifre : %d", 10, 0
    print_cifre_rec db "Numar de cifre recursiv : %d", 10, 0
    scanf_format db "%zu", 0
    arr dd 0, 1, 12, 345, 6789, 91015
    len dd 6 
    newline db 0xa, 0xd, 0
    new_arr dd 0
    lungime dd 0

section .text
    extern printf
    extern scanf
    extern malloc
    extern free

global main

;void print_arr(int *arr, int len)
print_arr:
    push ebp
    mov ebp, esp

    mov ebx, dword[ebp + 8]
    xor ecx, ecx

for_print:
    push ecx
    
    push dword[ebx + ecx * 4]
    push print_elem
    call printf
    add esp, 8

    pop ecx
    inc ecx
    cmp ecx, dword[ebp + 12]
    jl for_print

    ; afisare newline
    push newline
    call printf
    add esp, 4

    leave
    ret

;int nr_cifre(int n)
nr_cifre:
    push ebp
    mov ebp, esp

    mov eax, dword[ebp + 8] ; n
    xor ecx, ecx

cifre:
    inc ecx

    ; n = n / 10
    mov esi, 10
    xor edx, edx
    div esi

    cmp eax, 0
    je end

    jmp cifre

end:
    mov eax, ecx
    mov esp, ebp
    pop ebp
    ret

; int *new_array(int *arr, int len)
new_array:
    push ebp
    mov ebp, esp

    ; 4 * ebx
    mov ebx, dword[ebp + 12]
    shl ebx, 2
    
    mov dword[lungime], ebx

    push dword[lungime]
    call malloc
    add esp, 4

    mov dword[new_arr], eax
    
    xor ecx, ecx
for_new:
    push ecx
    mov ebx, dword[ebp + 8] ; arr
    push ebx

    push dword[ebx + ecx * 4]
    call nr_cifre
    add esp, 4

    pop ebx
    pop ecx
    mov dword[new_arr + 4 * ecx], eax
    inc ecx
    cmp ecx, dword[ebp + 12]
    jl for_new

end_new:

    mov esp, ebp
    pop ebp
    ret

main:
    push ebp
    mov ebp, esp
    ;push ebx

    ;citire numar 
    push num
    push scanf_format
    call scanf
    add esp, 8

    ;afisare numar
    push dword[num]
    push print_num
    call printf
    add esp, 8

    ; apel nr_cifre(n)
    push dword[num]
    call nr_cifre
    add esp, 4

    ; afisare rez
    push eax
    push print_cifre
    call printf
    add esp, 8

    ; afisare vector arr
    push dword[len]
    push arr
    call print_arr
    add esp, 8

    ; creare nou vector
    push dword[len]
    push arr
    call new_array
    add esp, 8

    ; afisare nou vector
    push dword[len]
    push new_arr
    call print_arr
    add esp, 8

    leave
    ret


  

