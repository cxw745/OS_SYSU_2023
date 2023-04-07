%include "boot.inc"
;org 0x7e00
[bits 16]


;1.准备GDT，用lgdt指令加载GDTR信息。
BREAK1:
;空描述符
mov dword [GDT_START_ADDRESS+0x00],0x00
mov dword [GDT_START_ADDRESS+0x04],0x00  

;创建描述符，这是一个数据段，对应0~4GB的线性地址空间
mov dword [GDT_START_ADDRESS+0x08],0x0000ffff    ; 基地址为0，段界限为0xFFFFF
mov dword [GDT_START_ADDRESS+0x0c],0x00cf9200    ; 粒度为4KB，存储器段描述符 

;建立保护模式下的堆栈段描述符      
mov dword [GDT_START_ADDRESS+0x10],0x00000000    ; 基地址为0x00000000，界限0x0 
mov dword [GDT_START_ADDRESS+0x14],0x00409600    ; 粒度为1个字节

;建立保护模式下的显存描述符   
mov dword [GDT_START_ADDRESS+0x18],0x80007fff    ; 基地址为0x000B8000，界限0x07FFF 
mov dword [GDT_START_ADDRESS+0x1c],0x0040920b    ; 粒度为字节

;创建保护模式下平坦模式代码段描述符
mov dword [GDT_START_ADDRESS+0x20],0x0000ffff    ; 基地址为0，段界限为0xFFFFF
mov dword [GDT_START_ADDRESS+0x24],0x00cf9800    ; 粒度为4kb，代码段描述符 

;初始化描述符表寄存器GDTR
mov word [pgdt], 39      ;描述符表的界限   
lgdt [pgdt]
      
;2.打开第21根地址线。
BREAK2:
in al,0x92                         ;南桥芯片内的端口 
or al,0000_0010B
out 0x92,al                        ;打开A20

;3.开启cr0的保护模式标志位。
BREAK3:
cli                                ;中断机制尚未工作
mov eax,cr0
or eax,1
mov cr0,eax                        ;设置PE位
 
;4.远跳转，进入保护模式。
BREAK4:
;以下进入保护模式
jmp dword CODE_SELECTOR:protect_mode_begin

;16位的描述符选择子：32位偏移
;清流水线并串行化处理器
[bits 32]           
protect_mode_begin:                              
;初始化各个寄存器
mov eax, DATA_SELECTOR                     ;加载数据段(0..4GB)选择子
mov ds, eax
mov es, eax
mov eax, STACK_SELECTOR
mov ss, eax
mov eax, VIDEO_SELECTOR
mov gs, eax

;在(10,3)处开始显示字符
;起始地址为VIDEO_SELECTOR + (10*80+3)*2

mov ecx, info_end - info
mov ebx, (10*80+3)*2
mov esi, info

mov ah, 0100_0011b
output_info:
    mov al, [esi]
    mov word[gs:ebx], ax
    add ebx, 2
    inc esi
    call change
    loop output_info
jmp $ ; 死循环

change:
    jmp comp
    change1:
        mov ah,0011_0100b
        ret
    change2:
	mov ah,0100_0011b
        ret
    comp:
	cmp ah,0100_0011b
        je change1
        jmp change2

pgdt dw 0
     dd GDT_START_ADDRESS

info db '21307387_cxw'
info_end:
