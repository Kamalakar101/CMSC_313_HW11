; Name: Kamalakar Reddy
; ID: CJ88254
; Section 1430
; Date: 5/12/25
; Description: 

SECTION .data
inputBuf:        db      0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
maskUpNib       db 0xF0
maskLowNib      db 0x0F

SECTION .bss
outputBuf:  resb 80

SECTION .text
global _start

_start:

    mov     esi, inputBuf
    mov     al, [esi]
    and     al, maskUpNib
    shr     al, 4
    add     al, 0x30
    mov     [outputBuf], al
    
    mov     edx, 2
    mov     ecx, outputBuf
    mov     ebx, 1
    mov     eax, 4
    int     80h

    ;Exit Program
    mov     ebx, 0
    mov     eax, 1
    int     80h
