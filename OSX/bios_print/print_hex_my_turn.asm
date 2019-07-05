; sakerna kommer i dx

print_hex:
    mov cx, 0
    pusha

prepare:
    cmp cx, 4
    je end_hex
    mov ax, dx
    and ax, 0x000f
    add al, 0x30
    cmp al, 0x39
    jle dump_hex
    add al, 7

dump_hex:
    mov bx, HEX_OUT + 5
    sub bx, cx
    mov [bx], al ; nu står det 0x42 eller någon one byter där istället för ascci värdet för 0
    ror dx, 4
    add cx, 1
    jmp prepare

end_hex:
    mov bx, HEX_OUT
    call print
    popa
    ret

; lite data
HEX_OUT:
    db '0x0000', 0