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
mov ax, 0xb000;不用从显存位置开始
mov gs, ax


mov ah, 0x03 ;
mov bx, 0x00 ;
int 0x10

mov ah, 0x09
mov al, '2'
mov bh, 0
mov bl, 0x03
mov cx, 0x01
int 0x10


; 设置光标的新位置
mov ah, 0x02s
mov bh, 0x00
add dl, 1
INT 0x10

mov ah, 0x09
mov al, '1'
mov bh, 0
mov bl, 0x03
mov cx, 0x01
int 0x10




; 设置光标的新位置
mov ah, 0x02
mov bh, 0x00
add dl, 1
INT 0x10

mov ah, 0x09
mov al, '3'
mov bh, 0
mov bl, 0x03
mov cx, 0x01
int 0x10



; 设置光标的新位置
mov ah, 0x02
mov bh, 0x00
add dl, 1
INT 0x10

mov ah, 0x09
mov al, '0'
mov bh, 0
mov bl, 0x03
mov cx, 0x01
int 0x10



; 设置光标的新位置
mov ah, 0x02
mov bh, 0x00
add dl, 1
INT 0x10

mov ah, 0x09
mov al, '7'
mov bh, 0
mov bl, 0x03
mov cx, 0x01
int 0x10



; 设置光标的新位置
mov ah, 0x02
mov bh, 0x00
add dl, 1
INT 0x10

mov ah, 0x09
mov al, '3'
mov bh, 0
mov bl, 0x03
mov cx, 0x01
int 0x10

; 设置光标的新位置
mov ah, 0x02
mov bh, 0x00
add dl, 1
INT 0x10

mov ah, 0x09
mov al, '8'
mov bh, 0
mov bl, 0x03
mov cx, 0x01
int 0x10

; 设置光标的新位置
mov ah, 0x02
mov bh, 0x00
add dl, 1
INT 0x10

mov ah, 0x09
mov al, '7'
mov bh, 0
mov bl, 0x03
mov cx, 0x01
int 0x10


jmp $ ; 死循环

times 510 - ($ - $$) db 0
db 0x55, 0xaa
