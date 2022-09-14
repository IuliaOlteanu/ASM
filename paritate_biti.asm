section .data
    scan_format db "%zu", 0
    print_number db "Numar = %d", 10, 0
    print_rez_par db "Numarul este par", 10, 0
    print_rez_impar db "Numarul este impar", 10, 0


section .text
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp
    
    ; read number
    sub esp, 4

    lea eax, [ebp - 4]
    push eax
    push scan_format
    call scanf
    add esp, 8

    push dword[ebp - 4]
    push print_number
    call printf
    add esp, 8
    
    push dword[ebp - 4]
    call paritate_biti
    add esp, 4

    cmp eax, 1
    je print_par 

    push print_rez_impar
    call printf
    add esp, 4
    jmp done

print_par:
    push print_rez_par
    call printf
    add esp, 4
    jmp end
end:
    add esp, 4
    leave
    ret

; int paritate_bit(int nr)
; 0 / 1
paritate_biti:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, 1

    and eax, ebx
    cmp eax, 1
    je odd
    mov eax, 1
    jmp done

odd:
    mov eax, 0
done:

    leave
    ret