; Name: Kamalakar Reddy
; ID: CJ88254
; Section 1430
; Date: 5/12/25
; Description: Converts HEX numbers to their ASCII characters. Ex: 0x3D -> '3D'.

SECTION .data
inputBuf:        db      0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
maskUpNib       db      0xF0
maskLowNib      db      0x0F

SECTION .bss
outputBuf:  resb 80

SECTION .text
global _start

_start:

    xor     esi, esi
    xor     edi, edi

loop_start:
    
    cmp     esi, 8
    jge     loop_end
    
    mov     bl, [inputBuf + esi]
    
    ;Conversion of First Nibble
    mov     al, bl
    and     al, byte [maskUpNib]    ;Masking to isolate nibble
    shr     al, 4   ;Shifts to the right to get the upper half of the byte
    
    ;Converts to ASCII letter if greater than or equal to 10h
    cmp     al, 0xA
    jge     to_letter_first
    
    ;Else: Adds normally to get number
    add     al, 0x30
    jmp     first_done
    
  to_letter_first:
    add     al, 0x37
  first_done:
    mov     [outputBuf + edi], al
    inc     edi
    
    ;Conversion of Second Nibble
    mov     al, bl
    and     al, byte [maskLowNib]    ;Masking to isolate nibble
    
    ;Converts to ASCII letter if greater than or equal to 10h
    cmp     al, 0xA
    jge     to_letter_second
    
    ;Else: Adds normally to get number
    add     al, 0x30
    jmp     second_done
    
  to_letter_second:
    add     al, 0x37
  second_done:
    mov     [outputBuf + edi], al
    inc     edi
    
    ;Adds a space
    mov     byte [outputBuf + edi], 0x20
    inc     edi
    
    inc     esi
    jmp     loop_start 
    
  loop_end:
  
    ;Outputs Buffer
    mov byte [outputBuf + edi], 0x0A ;Adds a newline
    inc edi

    mov     edx, edi
    mov     ecx, outputBuf
    mov     ebx, 1
    mov     eax, 4
    int     80h

    ;Exit Program
    mov     ebx, 0
    mov     eax, 1
    int     80h