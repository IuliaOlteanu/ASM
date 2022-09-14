extern printf
extern scanf
extern strrchr
extern calloc
extern read
extern free
extern strlen
%include "printf32.asm"

section .rodata
  scanf_str: db "%s", 0
  printf_str: db "%s", 0
  printf_int: db "%d", 0xA, 0xD, 0
  arr dw 23, 24, 25, 26, 27
  len dd 5
  ans dd 0

section .data
    search_char: db 'a'

section .bss
  ptr_s resd 1


section .text
global main

; TODO a: Implementati functia char* read_string(int len) care citeste de la
;         tastatură un sir de caractere alfabetic de lungime maxima len
;         (inclusiv terminatorul de sir) si il stochează intr-o zonă
;         de memorie alocată dinamic pe heap de aceeasi lungime.
;
;         Apelati functia in programul principal si afișați sirul de caractere
;         introdus.
;
;         Hint: Se poate utiliza functia "read" a crărei apel echivalent ı̂n C este
;               read(0, str, 128); pentru a citi un sir de maxim 128 de caractere.
;
;         Observatie: Functiile de biblioteca modifca o parte din registre - CDECL
read_string:
    push ebp
    mov ebp, esp

    mov ebx, dword[ebp + 8] ; len

    ;apel calloc(len, 1)
    push 1
    push ebx
    call calloc
    add esp, 8

    push ebx
    mov ecx, eax

    ;read(0, str, len)
    push eax
    push 0
    call read
    add esp, 8

    mov eax, ecx
    pop ebx

    mov esp, ebp
    pop ebp
    ret

; int is_vovel(char ch)

is_vovel:
    enter 0, 0

    movzx eax, byte[ebp + 8]
    
    cmp al, 101
    je out

    cmp al, 97
    je out

    cmp al, 111
    je out

    cmp al, 105
    je out

    cmp al, 117
    sete al

    movzx eax, al
    lea eax, [eax - 1 + eax]
    leave
    ret

out:
    mov eax, 1
    leave
    ret
    
; replace(char *str)
replace:
    enter 0, 0

    push esi
    push edi

    sub esp, 4
    mov esi, dword[ebp + 8]
    movzx eax, byte[esi]
    test al, al
    je end_replace

    lea ebx, [esi + 1]
    jmp check

for_replace:
    movzx eax, byte[ebx]
    mov esi, ebx
    inc ebx
    test al, al
    je end_replace

check:
    movsx eax, al
    mov dword[esp], eax
    call is_vovel
    
    cmp eax, 1
    jne for_replace

    mov byte[esi], 88
    movzx eax, byte[ebx]
    mov esi, ebx
    inc ebx
    test al, al 
    jne check

end_replace:
    add esp, 4
    pop ebx
    pop esi

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Apelati functia read_string pentru o lungime maxima de 64 de caractere
    ;         si afișați sirul de caractere introdus.
    push 64
    call read_string
    add esp, 4

    mov dword[ptr_s], eax

    push dword[ptr_s]
    push printf_str
    call printf
    add esp, 8
   
    push dword[search_char]
    call is_vovel
    add esp, 4

    push eax
    push printf_int
    call printf
    add esp, 8

    push dword[ptr_s]
    call replace
    add esp, 4

    push dword[ptr_s]
    push printf_str
    call printf
    add esp, 8

    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    xor ecx, ecx

for_ans:
    mov dx, word[arr + ecx * 2]
    mov ax, dx
    shr edx, 16

    mov bx, 23
    div bx

    xor ebx, ebx
    mov bx, dx
    PRINTF32 `rest : %hu\n\x0`, ebx
    ;mov dword[ans + ecx * 2], ebx

    xor edx, edx
    inc ecx
    cmp ecx, 5
    jl for_ans

    ;PRINTF32 `%d\n\x0`, [ans + 2]

    xor eax, eax
    leave
    ret
