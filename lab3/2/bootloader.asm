org 0x7e00
[bits 16]
mov ax, 0xb800 ;显存的初始位置
mov gs, ax
mov ah, 0x03 ;青色
mov ecx, bootloader_tag_end - bootloader_tag
xor ebx, ebx
mov esi, bootloader_tag ;是循环的次数也是字符串的下标
output_bootloader_tag:
    mov al, [esi] ;要显示的字符
    mov word[gs:bx], ax ;gs存着当前访问的显存地址，将ax写入显存，显示字符
    inc esi	;esi是循环的次数
    add ebx, 2 ;每个字符两个字节，高地址是颜色，低地址是内容
    loop output_bootloader_tag  ;loop的作用是让程序块重复执行，执行的次数以ECX的值为依据，
				;若ECX不等于0则继续跳转到指定标号重新执行，若等于0则不跳转。
jmp $ ;无限循环

bootloader_tag db 'run bootloader_chs 21307387_cxw' ;要显示的内容
bootloader_tag_end: ;这个标识符表示程序结束的地址
