mov ah, 0x0e ;tty

jmp end

mov al, [the_secret]
int 0x10 ; funar ej

mov bx, 0x7c0
mov ds, bx

; nu kommer all Data access utgå från
; det som står ds

mov al, [the_secret]
int 0x10

mov al, [es:the_secret]
int 0x10; ser inte bra ut
        ; är inte es 0x000 nu??

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]


end:
    mov bx, 0x7c0 ; remember, the segment is automatically <<4 for you
    mov ds, bx
    ; WARNING: from now on all memory references will be offset by 'ds' implicitly
    mov al, [the_secret]
    int 0x10

jmp $

the_secret:
    db "X"

times 510 - ($-$$) db 0
dw 0xaa55
