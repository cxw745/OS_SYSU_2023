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
mov ax, 0xb000
mov gs, ax

;get init position
mov ah,0x03
mov bh,0x00
mov bl,0x03 ;color
int 0x10

RU:
	cmp dh,0
	je RD
	cmp dl,79
	je LU
	mov ah,0x02
	dec dh
	inc dl
	int 0x10
	call show
	call delay
	jmp RU

RD:
	cmp dh,24
	je RU
	cmp dl,79
	je LD
	mov ah,0x02
	inc dh
	inc dl
	int 0x10
	call show
	call delay
	jmp RD

LU:
	cmp dh,0
	je LD
	cmp dl,0
	je RU
	mov ah,0x02
	dec dh
	dec dl
	int 0x10
	call show
	call delay
	jmp LU


LD:
	cmp dh,24
	je LU
	cmp dl,0
	je RD
	mov ah,0x02
	inc dh
	dec dl
	int 0x10
	call show
	call delay
	jmp LD

delay:
	push bp
	push si
	mov bp,0x00ff
	mov si,0x00ff
	delay2:
	dec bp
	nop
	jnz delay2
	dec si
	cmp si,0    
	jnz delay2
	pop bp
	pop si
	ret

show:
	pushad
	mov ah,0x09
	mov al,'s'
	mov cx,0x01
	int 0x10
	popad
	ret
jmp $ ; 死循环

times 510 - ($ - $$) db 0
db 0x55, 0xaa
