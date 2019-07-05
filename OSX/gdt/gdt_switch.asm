[bits 16]
switch_to_pm:
    cli ; 1. stäng av 
    lgdt [gdt_descriptor]; 2 ladda in GDT
    mov eax, cr0; sätt cpu register pekaren
    or eax, 0x1; 3. set 32-bit mode biten
               ;  i cput
    mov cr0, eax
    jmp CODE_SEG:init_pm ;sätt CS till init_pm

[bits 32]
init_pm: ; nu är det 32 bitars instructioner
    mov ax, DATA_SEG; update DS med pekaren till
                    ; DS
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000; updateran stacken
    mov esp, ebp

    call BEGIN_PM; kalll någon kod för att 
                ; börja nåt

