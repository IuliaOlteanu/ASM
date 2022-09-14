section .data
    scan_format db "%zu", 0
    print_num db "Numar = %d", 10, 0
    print_nr_biti db "Numar biti de 1 = %d", 10, 0
    print_par db "Numar par de biti", 10, 0
    print_impar db "Numar impar de biti", 10, 0
   
section .text
    extern scanf
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ;read number
    sub esp, 4
    
    lea eax, [ebp - 4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    ;print number
    push dword [ebp - 4]
    push print_num
    call printf
    add esp, 8

    ;apel functie nr_biti_1
    push dword[ebp - 4]
    call nr_biti_1
    add esp, 4

    push eax
    ; afisare nr de biti
    push eax
    push print_nr_biti
    call printf
    add esp, 8

    ;apel functie par_impar
    pop eax
    push eax
    call par_impar
    add esp, 4
   
    add esp, 4
    leave
    ret

;int nr_biti_1(int n)

nr_biti_1:
    push ebp
    mov ebp, esp

    xor eax, eax
    mov ecx, 32
    mov edx, 1

nr:
    mov ebx, [ebp + 8]
    and ebx, edx

    cmp ebx, 0
    je case_0
    inc eax

case_0:
    shl edx, 1
    loop nr     

    leave
    ret

; void par_impar(int nr_biti_de_1)
par_impar:
    push ebp
    mov ebp, esp

    ; nr_biti_de_1 % 2
    mov eax, [ebp + 8]
    mov ebx, 2
    xor edx, edx
    div ebx
    
    cmp edx, 0
    je par
    
    push print_impar
    call printf
    add esp, 4
    jmp end

par:
    push print_par
    call printf
    add esp, 4
end:
    leave
    ret
