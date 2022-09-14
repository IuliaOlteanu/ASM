%include "utils/printf32.asm"

section .data
    n            dd 7
    format_str   dd "Number: %d", 10, 0
    prime_format dd "isPrime: %d", 10, 0

section .text
    extern fgets
    extern stdin
    extern printf
    extern atoi

global main

;TODO b: Implement stringToNumber
stringToNumber:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]

    push eax
    call atoi
    add esp, 4

    leave
    ret

;TODO c.: Add missing code bits
;TODO c.: Add missing code bits
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

main:
    push ebp
    mov ebp, esp

    push ebx

    ;TODO a.: allocate space on stack and call fgets
    sub esp, 4
    mov eax, ebp
    sub eax, 4 ; eax -> local addres on stack

    push dword [stdin]
    push dword [n]
    push eax
    call fgets
    add esp, 12

    ;TODO b.: call stringToNumber and print it using printf
    mov eax, ebp
    sub eax, 4
    push eax
    call stringToNumber
    add esp, 4

    push eax

    push eax
    push format_str
    call printf
    add esp, 8

    PRINTF32 `\n\x0`

    ;TODO c.: call isPrime and print result

    pop eax
    
    push eax
    call isPrime
    add esp, 4

    push eax
    push prime_format
    call printf
    add esp, 8

    PRINTF32 `\n\x0`
    add esp, 4
    pop ebx

    leave
    ret