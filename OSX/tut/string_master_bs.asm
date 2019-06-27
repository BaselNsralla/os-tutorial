
section .data:
    db 'hello, swifter', 0 ; 0 will be passed as null byte

cmp ax, 4; if ax = 4
je ax_is_four  ; jumps if cmp ax, 4 är 1, jump equal
jmp else_label ; vanlig jump
jmp end_four_if ;resume the normal flow

ax_is_four:
   ;....
   jmp end_four_if

else_label:
   ;....
   jmp end_four_if ; behövs inte eftersom 
                   ; flödet finns under
end_four_if:
    mov al, 'X'
    ; mov registerX, $ + 2
    jmp print

end_print:
    jmp $

print:
     mov ah, 0x0e
     int 0x10 ; vi antar att al har karaktären
     ; byt program räknaren(instruktion räknaren) till 
     ; innehållet av RegisterX
     jmp end_print

%include "print.asm"
