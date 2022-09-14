%include "../utils/printf32.asm"
section .data
    a dd 0
    b dw 0
    scanf_format db "%zu", 0
    printf_format db "Numar : %d", 10, 0

section .text
    global main
    extern printf
    extern scanf

main:
    push ebp
    mov ebp, esp

    ; citire nr a
    push a
    push scanf_format
    call scanf
    add esp, 8

    ; afisare nr 
    push dword[a]
    push printf_format
    call printf
    add esp, 8

    ; citire nr b
    push b
    push scanf_format
    call scanf
    add esp, 8

    ; afisare nr 
    push word[b]
    push printf_format
    call printf
    add esp, 8

    ; a % b (dword % word)
    xor eax, eax
    mov edx, dword[a]
    mov ax, dx
    shr edx, 16
    mov bx, word[b]
    div ebx
    PRINTF32 `cat : %hx\n\x0`, eax
    PRINTF32 `restul : %hx\n\x0`, edx


;     ; verificare daca nr este prim
;     push dword[n]
;     call isPrime
;     add esp, 4

;     ; afisare rez
;     cmp eax, 0
;     je afisare_neprim
;     jne afisare_prim
    

; afisare_neprim:
;     PRINTF32 `nr neprim\n\x0`
;     jmp end
; afisare_prim:
;     PRINTF32 `nr prim\n\x0`
;     jmp end
end:
    leave
    ret

; int isPrime(int n)
isPrime:
    push ebp
    mov ebp, esp

    mov eax, 1
    mov edx, [ebp+8]
    cmp edx, 2
    je done
    cmp edx, 3
    je done
    cmp edx, 1
    je not_prime

    ;eax / 2
    mov edx, 0
    mov eax, [ebp+8]
    mov ebx, dword 2
    div ebx
    mov ebx, eax
    mov edx, 0

    mov eax, [ebp+8]
    mov ecx, 2

    inc ebx

loop:
    div ecx
    cmp edx, 0
    je not_prime
    inc ecx
    mov eax, [ebp+8]
    xor edx, edx
    cmp ecx, ebx
    jne loop
    
    mov eax, 1
    jmp done
    
not_prime:
    mov eax, 0
    jmp done
    
done:
    leave
    ret