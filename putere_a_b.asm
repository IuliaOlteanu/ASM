section .data
    scan_format db "%zu", 0
    print_base db "Base = %d", 10, 0
    print_exp db "Exp = %d", 10, 0
    print_rez db "pow(%d, %d) = %d", 10, 0

section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    
    ; read exp and base
    sub esp, 8

    lea eax, [ebp - 4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    lea eax, [ebp - 8]
    push eax
    push scan_format
    call scanf
    add esp, 8

    ; print exp and base
    push dword[ebp - 4]
    push print_base
    call printf
    add esp, 8

    push dword[ebp - 8]
    push print_exp
    call printf
    add esp, 8

    ;apel functie putere

    push dword[ebp - 8]
    push dword[ebp - 4]
    call putere
    add esp, 8

    ;afisare rezultat
    push eax
    push dword[ebp - 8]
    push dword[ebp - 4]
    push print_rez
    call printf
    add esp, 16

    add esp, 8
    leave
    ret

; int putere(int a, int b)
; a^b

putere:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ; a
    mov ebx, [ebp + 12] ; b

    cmp eax, 0
    je base_0_case

    cmp eax, 1
    je end
    
    ; b = 0 => a^0 = 1
    cmp ebx, 0
    je end

    dec ebx
    push ebx
    push eax
    call putere
    add esp, 8

    mov ebx, [ebp + 8]
    mul ebx
    jmp done

base_0_case:
    mov eax, 0
    jmp done

end:
    mov eax, 1
    jmp done

done:
    leave 
    ret