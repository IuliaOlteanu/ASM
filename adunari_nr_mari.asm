%include "utils/printf32.asm"

section .data
   word_num1 dd 0xff543210
   word_num2 dd 0xff111111
   result_word resd 2
   big_num1 dd 0x22222222, 0x22222222, 0xffffffff
   big_num2 dd 0x22222222, 0x22222222, 0xffffffff
   result_4word resd 4
   num_array1 dd 0x11111111, 0x22222222, 0x33333333, 0x12111211, 0x22232242, 0xff333333, 0xff123456, 0xff123456, 0xff123456
   num_array2 dd 0xffffffff, 0x22922252, 0x33033338, 0x12111211, 0x22232242, 0xff333333, 0xff123456, 0xff123456, 0xff123456
   result_array resd 12
   length dd 3

section .text
   extern printf

global main
main:
    push ebp
    mov ebp, esp

   ;TODO a, b, c: Implement the array sum starting with double word sum incrementally solving subsequent task b and c.
   ;----a----
   mov eax, dword [word_num1]
   mov ebx, dword [word_num2]
   add eax, ebx
   jnc not_carry
   inc dword [result_word]
not_carry:
   mov [result_word + 4], eax

   PRINTF32 `%x\x0`, [result_word + 0]
   PRINTF32 `%x\n\x0`, [result_word + 4]

   ;----b----
   push result_4word
   push big_num2
   push big_num1
   call add_3byte
   add esp, 12

   mov ecx, 0
b_print:
   PRINTF32 `%x \x0`, [result_4word + 4 * ecx]
   inc ecx
   cmp ecx, 4
   jl b_print
   PRINTF32 `\n\x0`

   ;----c----
   mov ecx, 0
c_add:
   mov edi, 12
   mov eax, ecx
   mul edi

   mov esi, num_array1
   add esi, eax

   mov ebx, num_array2
   add ebx, eax

   mov eax, ecx
   mov edi, 16
   mul edi

   mov edx, result_array
   add edx, eax

   push ecx

   push edx
   push ebx
   push esi
   call add_3byte
   add esp, 12

   pop ecx

   inc ecx
   cmp ecx, 4
   jl c_add

   mov ecx, 0

c_print:
   mov eax, ecx
   mov edi, 16
   mul edi
   PRINTF32 `%x \x0`, [result_array + eax]
   PRINTF32 `%x \x0`, [result_array + eax + 4]
   PRINTF32 `%x \x0`, [result_array + eax + 8]
   PRINTF32 `%x\n\x0`, [result_array + eax + 12]
   inc ecx
   cmp ecx, 3
   jl c_print

   leave
   ret


   ;void add_12byte(3byte n1, 3byte n2, 4byte res)
add_3byte:
   push ebp
   mov ebp, esp

   mov edx, 0 ;use for carry
   mov ecx, 3
b_add:
   mov esi, [ebp + 8]
   mov ebx, [ebp + 12]
   mov ebx, [ebx + ecx * 4 - 4]

   mov eax, edx
   mov edx, 0

   add eax, dword [esi + ecx * 4 - 4]
   jnc not_carry_case1
   mov edx, 1
not_carry_case1:

   add eax, ebx
   jnc not_carry_case2
   mov edx, 1
not_carry_case2:

   mov ebx, [ebp + 16]
   mov [ebx + ecx * 4], eax
   loop b_add

   mov ebx, [ebp + 16]
   mov [result_4word], edx

   leave
   ret