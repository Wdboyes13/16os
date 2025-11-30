%define SYS_WRITE 4
%define SYS_READ  5
%define SYS_CLR   9
%define SYS_SHDN  10

syscall_enter:
    ; Stack on entry (from call far):
    ; [SP+4] = caller CS
    ; [SP+2] = caller IP
    ; [SP+0] = (top)

    push ds
    push es
    push cs
    pop ds
    push cs
    pop es

    cmp ax, SYS_WRITE
    je sys_write
    cmp ax, SYS_SHDN
    je sys_shutdown
    cmp ax, SYS_READ
    je sys_read
    cmp ax,SYS_CLR
    je sys_clear
    jmp syscall_return


sys_clear:
    ; Clear screen and reset cursor
    mov ah, 0x00    ; Set video mode (clears screen)
    mov al, 0x03    ; 80x25 text mode
    int 0x10

    ; Reset cursor to top-left
    mov ah, 0x02
    mov bh, 0       ; Page 0
    mov dx, 0       ; Row 0, Col 0
    int 0x10
    jmp syscall_return

sys_read:
    ; SI = pointer to buffer (in caller's segment)
    ; Returns: SI points to null-terminated string
    pop es
    pop ds
    push ds
    push es

    mov di, si
    mov byte [di], 0

sys_read_loop:
    mov ah, 0
    int 16h
    cmp al, 0x0D
    je sys_read_done
    cmp al, 0x08
    je sys_read_backspace

    ; Echo character
    mov ah, 0x0E
    mov bx, 0x0007
    int 0x10

    ; Store character
    stosb
    mov byte [di], 0
    jmp sys_read_loop

sys_read_backspace:
    cmp di, si
    jbe sys_read_loop

    dec di
    mov byte [di], 0

    ; Echo backspace sequence
    mov ah, 0x0E
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    jmp sys_read_loop

sys_read_done:
    ; Add newline
    mov ah, 0x0E
    mov al, 0x0A
    int 0x10
    mov al, 0x0D
    int 0x10
    jmp syscall_return

sys_write:
    ; SI = pointer to string (in caller's segment)
    pop es
    pop ds
    push ds
    push es

syscall_print_loop:
    mov al, [si]
    or al, al
    jz syscall_return
    mov ah, 0x0e
    push bx
    mov bx, 0x0007
    int 0x10
    pop bx
    inc si
    jmp syscall_print_loop

sys_shutdown:
    ; Attempt ACPI shutdown
    mov dx, 0xB004
    mov ax, 0x2000
    out dx, ax

    mov dx, 0x1004
    mov ax, 0x3400
    out dx, ax

    mov dx, 0x604
    mov ax, 0x2000
    out dx, ax

    ; Hang if shutdown failed
    cli
    hlt
    jmp $

syscall_return:
    pop es
    pop ds
    retf  ; Return far - pops IP then CS from stack
