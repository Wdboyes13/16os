[bits 16]
[org 0]
%include "prog.inc"

start:
    stprog

    ; Load file table into memory
    mov ax,0x2000
    mov gs,ax

    mov si,ls_header
    ssc SYS_WRITE

    mov bx,0
    cld

ls_loop:
    mov al,[gs:bx]
    cmp al,'}'      ; end marker
    je ls_done
    cmp al,0        ; null terminator
    je ls_done

    ; Print filename
    push bx
    call print_filename
    pop bx

ls_skip:
    mov al,[gs:bx]
    inc bx
    cmp al,','
    jne ls_skip

    jmp ls_loop

ls_done:
    endprog

print_filename:
    pusha
    mov bp,sp
    mov bx,[bp+18]

    ;push spaces
    ;call print

pf_loop:
    mov al,[gs:bx]
    cmp al,'{'
    je skip_brace
    cmp al,','
    je pf_done
    cmp al,'}'
    je pf_done
    cmp al,0
    je pf_done

    ; Print character
    mov ah,0x0e
    push bx
    mov bx,0
    mov bl,0x0A
    int 0x10
    pop bx

skip_brace:
    inc bx
    jmp pf_loop

pf_done:
    push nl
    call print
    mov sp,bp
    popa
    ret

print:
    pusha
    mov bp,sp
    mov si,[bp+18]
pcont:
    lodsb
    or al,al
    jz pdne
    mov ah,0x0e
    push bx
    mov bx,0
    mov bl,7
    int 0x10
    pop bx
    jmp pcont
pdne:
    mov sp,bp
    popa
    ret

ls_header db 10,13,"Files:",10,13,0
spaces db "  ",0
nl db 10,13,0

times 512-($-$$) db 0
