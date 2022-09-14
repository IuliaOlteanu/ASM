%include "utils/printf32.asm"

section .data
    ; TODO a: Define arr1, arr2 and res arrays.
    arr1 dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    arr2 dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    num dd 10

section .bss
    res resd 10

section .text
    extern printf
global main

main:
    push ebp
    mov ebp, esp

    ; res[0] = arr1[0] + arr2[n - 1]
    ; TODO b: Compute res[0] and res[n-1].
    mov eax, [arr1]
    add eax, [arr2 + 36]
    mov [res], eax

    mov eax, [arr2]
    add eax, [arr1 + 36]
    mov [res + 36], eax




    ; List first and last item in each array.
    PRINTF32 `%d - %d - %d\n\x0`, [arr1], [arr2], [res]
    PRINTF32 `%d - %d - %d\n\x0`, [arr1 + 36], [arr2 + 36], [res + 36]


    ; TODO d: Compute cross sums in res[i].
    mov ecx, [num]
    mov ebx, 0

make_res:
    mov eax, [arr1 + ebx * 4]
    add eax, [arr2 + ecx *4 - 4]
    mov [res + ebx * 4], eax
    add ebx, 1
    loop make_res

    ; TODO c: List arrays.
    mov ecx, [num]

afisare:
    PRINTF32 `arr1[%d] = %d \x0`, ecx, [arr1 + ecx * 4 - 4]
    PRINTF32 `arr2[%d] = %d \x0`, ecx, [arr2 + ecx * 4 - 4]
    PRINTF32 `res[%d] = %d \n\x0`, ecx, [res + ecx * 4 - 4]
    loop afisare



    ; Return 0.    
    xor eax, eax
    leave
    ret