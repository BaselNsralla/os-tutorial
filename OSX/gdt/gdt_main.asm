[org 0x7c00] ; bootloader offset
    mov bp, 0x9000; sätter stacken
    mov sp, bp
    
    mov bx, MSG_REAL_MODE
    call print
    
    call switch_to_pm

    jmp $

%include "../bios_print/print.asm"
%include "gdt.asm"
%include "../32_bit_print/32bit_print.asm"
%include "gdt_switch.asm"


[bits 32]

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm_loop
    jmp $

MSG_REAL_MODE db "AHAAH NU BÖRJAR DET", 0
MSG_PROT_MODE db "NU ÄR minnet skyddat läge", 0

; bootsector identifiring

times 510-($-$$) db 0
dw 0xaa55