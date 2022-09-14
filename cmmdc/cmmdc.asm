%include "../utils/printf32.asm"

section .data
    a dd 50
    b dd 20
    vector dd 0
    print_format db "Cmmdc: ", 0
    print_afisare db "%d ", 10, 0

section .text
extern printf
extern malloc
global main

; int double(int a)
double:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    mov ecx, 2
    mul ecx

    leave
    ret

main:
    lea ecx, [esp + 4]
    and esp, -16
    push dword[ecx - 4]

    push ebp
    mov ebp, esp
    push esi
    push ebx
    push ecx
    sub esp, 24

    ; v = malloc(40)
    push 40
    call malloc
    add esp, 16
    mov edx, 2
    ; v[i] = 2 * i

parcurgere:
    mov dword[eax + edx * 2], edx
    add edx, 2
    cmp edx, 22
    jne parcurgere
    lea ebx, [eax + 4]
    lea esi, [eax + 44]

afisare:
    sub esp, 8
    push dword[ebx]
    add ebx, 4
    push print_afisare
    call printf
    add esp, 16
    cmp ebx, esi
    jne afisare

    lea esp, [ebp - 12]
    xor eax, eax
    pop ecx
    pop ebx
    pop esi
    pop ebp
    lea esp, [ecx - 4]

    

;     mov eax, dword[a] ; eax = 12
;     mov ebx, dword[b] ; edx = 6

; comparare:   
;     cmp ebx, 0 ; eax - ebx
;     je  end
;     xor edx, edx
;     div ebx
;     mov eax, ebx
;     mov ebx, edx
;     jmp comparare

; end:
;     mov edx, eax

;     PRINTF32 `%s\x0`, print_format
;     PRINTF32 `%u\n\x0`, edx


    ;mov esp, ebp
    ;pop ebp

    ret