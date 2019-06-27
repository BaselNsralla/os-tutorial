; laddar dh sectorer från dl in i ES:BX
disk_load:
    pusha
    push dx

    mov ah, 0x02;  parameter till read
    mov al, dh ; hur många sectorer
    mov cl, 0x02 ; vilken sector nummer
    mov ch, 0x00 ; cylinder nummer

    mov dh, 0x00; dh <- huvud nummer (0x0...0xF)

    int 0x13
    jc disk_error

    pop dx

    cmp al, dh; se till att retur värdet är
              ; samma som antal lästa sectorer
    
    jne sectors_error

    popa
    ret

disk_error:
    mov bx, DISK_ERROR_A
    call print
    call print_nl
    mov dh, ah ; error koden i ag till dh
    call print_hex; dh har nu error koden som
                  ; parameter till print_hex

    jmp disk_loop


disk_loop:
 jmp $
 
sectors_error:
    mov bx, SECTORS_ERROR_A
    call print ; bx är parametern till print

DISK_ERROR_A: db "Disk read error", 0
SECTORS_ERROR_A: db "Incorrect number of sectors read", 0 