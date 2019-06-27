mov ah, 0x0e; tty mode

mov bp, 0x08000; en address jättelångt ifrån 0x7c00
; eftersom vi inte vet ännu hur mågnga variabler vi
; ska använda ellerhur, när man kompilerar
; då vet man hur många som ska användas

mov sp, bp ; stacken är ju tom

push 'A'
push 'B'
push 'C'

; för att visa hur stacken växer neråt 
; till programmets början
mov al, [0x7ffe]; vilket är 0x8000 - 2
int 0x10

; Försöka komma åt baspekarens värde
mov al, [0x8000]
int 0x10

; recover our characters using the standard procedure
; 'pop' eftersom vi bara kan pusha och popa
; ett helt ord så behöver vi en auxaleri
; register som har flera delar att komma åt
; 2 bytes -> 1 upper bytes + 1 lower bytes

pop bx
mov al, bl
int 0x10 ; prints C

pop bx
mov al, bl
int 0x10; printar B, eftersom vi redan har tty igång

pop bx
mov al, bl
int 0x10; printa A

;datan som poppade från stacken finns inte längre
;eller är räknad som trash, kommer skrivas över m.a.o

mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55