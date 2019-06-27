[org 0x7c00]


mov bp, 0x8000 ; ta stacken iväg

mov sp, bp

mov bx, 0x9000
mov dh, 2 ; läs 2 sectorer
call disk_load

mov dx, [0x9000] ; hämta dada
call print_hex

call print_nl
mov dx, [0x9000 + 512]
call print_hex

jmp $

%include "../print_hex_my_turn.asm"
%include "../print.asm"
%include "boot_disk.asm"

times 510 - ($-$$) db 0
dw 0xaa55

; boot sector = sector 1, och den har vi definerat
; nu definerer sector 2

times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes