[bits 32] ; går in i 32 bitars skyddat läge

; constanter
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f ; vit färg för tecken

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; ebx addressen för karaktären
    mov ah, WHITE_ON_BLACK

    cmp al, 0; kolla om det är sluyey

    je print_string_pm_done
    mov [edx], ax ; läg in karaktären i minnet med färg attribut
    add ebx, 1 ;nästa bokstav 1 byte
    add edx, 2 ; nästa karaktär objekt ledig plats

    jmp print_string_pm_loop


print_string_pm_done:
    popa
    ret