mov ah, 0x0e ;tty mode
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; l is still the char
mov al, '0'
int 0x10
jmp $; jump to current address = infinite loop

;padding to indicate boot loader
times 510 - ($-$$) db 0
dw 0xaa55