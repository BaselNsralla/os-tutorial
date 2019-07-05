; the string pointer is inside bx
print:
    pusha

start:
    mov al, [bx]
    cmp al, 0
    je done
    
    add bx, 1 
    mov ah, 0x00e
    int 0x010
    
    jmp start
    
done: 
    popa
    ret

sys_print:
    mov ah, 0x0e
    int 0x10
    ret

print_nl:
    pusha
    mov al, 0x0a
    call sys_print
    mov al, 0x0d
    call sys_print
    
    popa
    ret


