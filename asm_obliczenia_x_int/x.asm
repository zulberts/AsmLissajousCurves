section .rodata
half: dd 0.5

section .text
global calculate_x

; int calculate_x(int width, float a, float t)
calculate_x:
    push rbp
    mov rbp, rsp
    sub rsp, 32               ; Alokacja miejsca na stosie

    ; Przenieś argumenty na stos
    mov dword [rsp-4], edi    ; width jako int
    movss [rsp-8], xmm0       ; a
    movss [rsp-12], xmm1      ; t

    ; Konwertuj width na float
    cvtsi2ss xmm2, dword [rsp-4] ; xmm2 = float(width)

    ; Oblicz a * t
    movss xmm0, [rsp-8]       ; xmm0 = a
    mulss xmm0, [rsp-12]      ; xmm0 = a * t

    ; Oblicz sinus (a * t)
    movss [rsp-16], xmm0      ; Zapisz a * t na stosie
    fld dword [rsp-16]        ; Załaduj a * t do FPU
    fsin                      ; Oblicz sin(a * t)
    fstp dword [rsp-16]       ; Zapisz wynik na stosie
    movss xmm0, [rsp-16]      ; Przenieś wynik do xmm0

    ; Oblicz (width / 2)
    movss xmm1, xmm2          ; xmm1 = float(width)
    movss xmm3, dword [rel half]  ; xmm3 = 0.5
    mulss xmm1, xmm3          ; xmm1 = width / 2

    ; Oblicz (width / 2) * sin(a * t)
    mulss xmm0, xmm1          ; xmm0 = (width / 2) * sin(a * t)

    ; Oblicz width / 2 + (width / 2) * sin(a * t)
    addss xmm0, xmm1          ; xmm0 = (width / 2) + (width / 2) * sin(a * t)

    ; Konwertuj wynik na int
    cvttss2si eax, xmm0       ; eax = int(xmm0)

    ; Przywróć stos i rejestry
    add rsp, 32
    mov rsp, rbp
    pop rbp
    ret
