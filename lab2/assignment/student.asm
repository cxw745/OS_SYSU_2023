; If you meet compile error, try 'sudo apt install gcc-multilib g++-multilib' first
%include "head.include"
; you code here

mov eax,[a1]
mov ebx,[a2]

your_if:
; put your implementation here

cmp eax,12
jl lessthan12

cmp eax,24
jl lessthan24

else:
shl eax,4
mov [if_flag],eax
jmp your_while

lessthan12:
shr eax,1
add eax,1
mov [if_flag],eax
jmp your_while

lessthan24:
mov ecx,24
sub ecx,eax
imul eax,ecx
mov [if_flag],eax
jmp your_while


your_while:
; put your implementation here
cmp dword[a2],12
jl end_include
call my_random
mov ebx,[a2]
mov ecx, [while_flag]
mov byte[ecx + ebx - 12],al;随机数是char，一个字节大小，所以用byte类型，读取eax的低八位al
dec dword[a2]
jmp your_while

end_include:
%include "end.include"

your_function:
; put your implementation here
mov edx,0
loop:
mov ecx,[your_string]
cmp byte[ecx + edx],0
je end

tra:
pushad
mov ecx,dword[ecx + edx]
push ecx
call print_a_char
pop ecx
popad
inc edx
jmp loop

end:
mov ebx,0
mov eax,1
int 80h
