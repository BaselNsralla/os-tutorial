loop:
    jmp loop

; 510, sista två ska vara aa 55
; kommer köra compile time
times 510-($-$$) db 0 
dw 0xaa55
