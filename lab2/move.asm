org 0x7c00
[bits 16]
xor ax, ax ; eax = 0
; 初始化段寄存器, 段地址全部设为0
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

; 初始化栈指针
mov sp, 0x7c00
mov ax, 0xb000 ;不从显存地址开始，这里从初始地址开始
mov gs, ax

; 获取光标的位置
mov ah, 0x03;
mov bh, 0;页码，从0开始
INT 0x10

; 设置光标的新位置，也就是移动光标到第五行第五列
mov ah, 0x02
mov bh, 0x00
add dh, 5
add dl, 5
INT 0x10

;死循环
jmp $

times 510 - ($ - $$) db 0
db 0x55, 0xaa
