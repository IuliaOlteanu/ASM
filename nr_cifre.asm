section .data
    num dd 0
    sum_cifre dd 0
    sum_cifre_print db "Suma : %d", 10, 0
    sum_cifre_recursiv db "Suma recursiv : %d", 10, 0
    print_num db "Numar : %d", 10, 0
    print_cifre db "Numar de cifre : %d", 10, 0
    print_cifre_rec db "Numar de cifre recursiv : %d", 10, 0
    scanf_format db "%zu", 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    push ebx

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
    
    push dword[num]
    call nr_cifre
    add esp, 4

    push eax
    push print_cifre
    call printf
    add esp, 8

    push dword sum_cifre
    push dword[num]
    call suma_cifre
    add esp, 4

    push dword[sum_cifre]
    push sum_cifre_print
    call printf
    add esp, 8

    push dword sum_cifre
    push dword[num]
    call rec_sum_digits
    add esp, 4

    push dword[sum_cifre]
    push sum_cifre_recursiv
    call printf
    add esp, 8

    push dword[num]
    call rec_sum_digits
    add esp, 4

    push eax
    push print_cifre_rec
    call printf
    add esp, 8

    pop ebx
    leave
    ret

; int suma(int n)
suma_cifre:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov ecx, 0
s_cifre:
    inc ecx
    ; n = n / 10
    mov esi, 10
    xor edx, edx
    div esi

    add [ebx], edx
    ; if n == 0 -> end
    cmp eax, 0
    je end2
    jmp s_cifre
end2:
    mov eax, ecx
    leave
    ret


; int nr_cifre(int n)
nr_cifre:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ; n
    mov ecx, 0
cifre:
    inc ecx

    ; n = n / 10
    mov esi, 10
    xor edx, edx
    div esi

    ; if n == 0 -> end
    cmp eax, 0
    je end

    jmp cifre

end:
    mov eax, ecx
    leave
    ret

;int rec_num_digits(int a)
rec_num_digits:
    push ebp
    mov ebp, esp

    ;a < 10 ? 1 : 1 + rec_num_digits(a/10)
    mov ebx, [ebp + 8]
    cmp ebx, 10
    jl sum_base_case

    ;a = eax && eax /= 10
    mov eax, ebx
    mov edx, 0
    mov ebx, 10
    div ebx

    ;rec_num_digits(a/10)
    push eax
    call rec_num_digits
    add esp, 4

    ;1 + rec_num_digits(a/10)
    inc eax
    jmp num_done

num_base_case:
    mov eax, 1

num_done:

    leave
    ret

;int rec_sum_digits(int a)
rec_sum_digits:
    push ebp
    mov ebp, esp

    ;a < 10 ? a : a%10 + rec_sum_digits(a/10)
    mov ebx, [ebp + 8]
    cmp ebx, 10
    jl sum_base_case

    ;a = eax && eax /= 10
    mov eax, ebx
    mov edx, 0
    mov ebx, 10
    div ebx

    ;rec_sum_digits(a/10)
    push edx
    push eax
    call rec_sum_digits
    add esp, 4
    pop edx

    ;a%10 + rec_sum_digits(a/10)
    add eax, edx
    jmp sum_done

sum_base_case:
    mov eax, ebx

sum_done:

    leave
    ret
