; A simpe boot sector program that demonstrates adressing
;section .data
; the_secret:
;    db "X"
   
;cpu lägga koden först sen data
;section .text om du gör de till sectioner så kommer 

mov ah, 0x0e ; vi movar 0x0e parameters till AH som säger att den
             ; är teletype routine printning

; Första försöket
mov al, the_secret
int 0x10 ; printar det här en X ? 

; Andra försöket
mov al, [the_secret]
int 0x10 ; Does this print an X?

; tredje försöket
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10; printar det här X?

; Fjärde försöket
mov al, [0x7c1e]
int 0x10

jmp $
;annars sitter den där den sepciferades som en label
the_secret:
    db "X"


; Padding and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55