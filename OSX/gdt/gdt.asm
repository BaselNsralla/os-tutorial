gdt_start:
    ; null biten
    dd 0x0 ; 4 bytes dubbel ord på x86
    dd 0x0 ; 4 bytes

; GDT for kod segmentet CS 
; basen ör 0x00000000, med längd = 0xfffff

gdt_code:
    dw 0xffff ; segment längden beskrivet
              ; i 0-15 bitar
    dw 0x0    ; segment basen beskrivet i
              ; 0-15 bitar
    db 0x0    ; segment basen beskrivet i 
              ; 16-24 bitar
    db 10011010b; falggar bekrivet i en byte
    db 11001111b; flagga beskrivet i 
                ; en halv byte + 
                ; segment längden så blir 
                ; det 16-19 bitar
    db 0x0      ; segement basen fortsätter
                ;  i bitar 24-31
                

; Nu beskriver jag kartan för 
; Data segmentet, basen och längden
; är samma som kode, men har lite
; annorlunda flaggor
gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:
; GDT DESKRIPTORN
gdt_descriptor:
    dw gdt_end - gdt_start - 1; (där den börjar men minus 1 ) dvs size
    dd gdt_start ; addressen till starten
                 ; i 32 bitar

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start




