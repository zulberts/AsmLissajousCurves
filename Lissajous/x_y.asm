section .rodata
half: dd 0.5

section .text
global calculate_x_y

; void calculate_x_y(int height, int width, float t, float a, float b, int *x, int *y)
calculate_x_y:
    push rbp
    mov rbp, rsp
    sub rsp, 64               ; Alokacja miejsca na stosie

    ; Przechowaj argumenty na stosie
    mov dword [rsp-4], edi    ; height jako int
    mov dword [rsp-8], esi    ; width jako int
    movss [rsp-12], xmm0      ; t
    movss [rsp-16], xmm1      ; a
    movss [rsp-20], xmm2      ; b
    mov r8, rdx               ; wskaźnik na x
    mov r9, rcx               ; wskaźnik na y

    ; Konwertuj width i height na float
    cvtsi2ss xmm3, dword [rsp-8]  ; xmm3 = float(width)
    cvtsi2ss xmm4, dword [rsp-4]  ; xmm4 = float(height)

    ; Oblicz a * t
    movss xmm0, [rsp-16]      ; xmm0 = a
    mulss xmm0, [rsp-12]      ; xmm0 = a * t

    ; Oblicz sinus (a * t)
    movss [rsp-24], xmm0      ; Zapisz a * t na stosie
    fld dword [rsp-24]        ; Załaduj a * t do FPU
    fsin                      ; Oblicz sin(a * t)
    fstp dword [rsp-24]       ; Zapisz wynik na stosie
    movss xmm0, [rsp-24]      ; Przenieś wynik do xmm0

    ; Oblicz (width / 2)
    movss xmm5, dword [rel half]  ; xmm5 = 0.5
    mulss xmm3, xmm5          ; xmm3 = width / 2

    ; Oblicz (width / 2) * sin(a * t)
    mulss xmm0, xmm3          ; xmm0 = (width / 2) * sin(a * t)

    ; Oblicz width / 2 + (width / 2) * sin(a * t)
    addss xmm0, xmm3          ; xmm0 = (width / 2) + (width / 2) * sin(a * t)

    ; Konwertuj wynik x na int
    cvttss2si eax, xmm0       ; eax = int(xmm0)
    mov [r8], eax             ; Zapisz wynik x do zmiennej x (przekazanej przez wskaźnik)

    ; Oblicz b * t
    movss xmm1, [rsp-20]      ; xmm1 = b
    mulss xmm1, [rsp-12]      ; xmm1 = b * t

    ; Oblicz sinus (b * t)
    movss [rsp-28], xmm1      ; Zapisz b * t na stosie
    fld dword [rsp-28]        ; Załaduj b * t do FPU
    fsin                      ; Oblicz sin(b * t)
    fstp dword [rsp-28]       ; Zapisz wynik na stosie
    movss xmm1, [rsp-28]      ; Przenieś wynik do xmm1

    ; Oblicz (height / 2)
    mulss xmm4, xmm5          ; xmm4 = height / 2

    ; Oblicz (height / 2) * sin(b * t)
    mulss xmm1, xmm4          ; xmm1 = (height / 2) * sin(b * t)

    ; Oblicz height / 2 + (height / 2) * sin(b * t)
    addss xmm1, xmm4          ; xmm1 = (height / 2) + (height / 2) * sin(b * t)

    ; Konwertuj wynik y na int
    cvttss2si eax, xmm1       ; eax = int(xmm1)
    mov [r9], eax             ; Zapisz wynik y do zmiennej y (przekazanej przez wskaźnik)

    ; Epilog funkcji
    add rsp, 64
    mov rsp, rbp
    pop rbp
    ret
