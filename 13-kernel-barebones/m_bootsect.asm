[org 0x7c00]
KERNEL_OFFSET equ 0x1000; här ska vår kernel ligga 
                        ; som ska ladda från disken

  mov [BOOT_DRIVE], dl ; spara boot drivens nummer
  mov bp, 0x9000
  mov sp, bp        ; spara undan

  mov bx, MSG_REAL_MODE
  call print
  call print_nl

  call load_kernel ; ladda up kernel:n
  call switch_to_pm ; switcha till protected mode 
                    ; den kommer göra alla procedurer för 
                    ; att stänga av real mode och 
                    ; en av dem är att ladda gdt
                    ; säga till cpu:n osv

  jmp $

  %include "../05-bootsector-functions-strings/boot_sect_print.asm"
  %include "../05-bootsector-functions-strings/boot_sect_print_hex.asm"
  %include "../07-bootsector-disk/boot_sect_disk.asm"
  %include "../09-32bit-gdt/32bit-gdt.asm"
  %include "../08-32bit-print/32bit-print.asm"
  %include "../10-32bit-enter/32bit-switch.asm"


[bits 16]
load_kernel: ; från disk då
  mov bx, MSG_LOAD_KERNEL
  call print
  call print_nl

  mov bx, KERNEL_OFFSET ; vi ska lägga den i 0x1000

  mov dh, 2
  mov dl, [BOOT_DRIVE]
  call disk_load
  ret

[bits 32] ; vi oppenrear nu på 32 bitar style   
          ; och har access till många addresser
BEGIN_PM:
  mov ebx, MSG_PROT_MODE ; extende bx?
  call print_string_pm
  call KERNEL_OFFSET ; ge control till den laddade kerneln i pm mode
  jmp $

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Landed in 32-bit Protected mode", 0
MSG_LOAD_KERNEL db "LOADING KERNEL INTO MEMORY", 0

times 510 - ($-$$) db 0
dw 0xaa55