
section .data
the_secret: db "X"

section .text
[org 0x7c00]
mov ah, 0x0e

; försök 1
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; försök 2
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; försök 3 wasted

mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10
;; OM du tar bort 3 det häe så blir offseten mindre dumdum

;försök 4

mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $



times 510-($-$$) db 0
dw 0xaa55
