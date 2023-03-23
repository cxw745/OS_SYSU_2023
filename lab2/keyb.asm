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

; 获取光标的初始位置
mov ah, 0x03;
mov bh, 0
int 0x10

;相当于一个无限循环，从键盘读取并且输出
keyb:
;读取键盘的输入（阻塞），读取到的值会保存在al寄存器中
mov ah, 0x10
int 0x16

;输出al寄存器的内容
mov ah,0x09
mov bh,0x00
mov bl,0x03
mov cx,0x01
int 0x10

;移动光标到下一个位置
mov ah, 0x02
mov bh, 0x00
add dl, 1
int 0x10

;跳回循环
jmp keyb;


;死循环
jmp $

times 510 - ($ - $$) db 0
db 0x55, 0xaa
