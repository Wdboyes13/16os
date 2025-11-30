%define SYS_WRITE 4
%define SYS_READ  5
%define SYS_CLR   9
%define SYS_SHDN  10

%macro ssc 1
    mov ax,%1
    call 0x3000:0x0000
%endmacro

%macro endprog 0
    mov ax,0x1000
    mov ds, ax
    mov es, ax
    jmp 0x1000:0
%endmacro

%macro stprog 0
    mov ax,cs
	mov ds,ax
	mov es,ax
%endmacro
