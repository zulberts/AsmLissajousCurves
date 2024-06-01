section .text
global calculate_sin

; float calculate_sin(float value)
calculate_sin:
    push rbp
    mov rbp, rsp

    ; Przenieś wartość zmiennoprzecinkową z xmm0 do FPU
    movss [rsp-4], xmm0
    fld dword [rsp-4]

    ; Oblicz sinus
    fsin

    ; Przenieś wynik z FPU do xmm0
    fstp dword [rsp-4]
    movss xmm0, dword [rsp-4]

    mov rsp, rbp
    pop rbp
    ret
