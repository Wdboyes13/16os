[bits 16]
[org 0]
%include "prog.inc"

start:
    stprog

    mov si,prpt
    ssc SYS_WRITE

    mov si,tx
    ssc SYS_READ

    mov si,t0
    ssc SYS_WRITE

    mov si,tx
    ssc SYS_WRITE

    mov si,t1
    ssc SYS_WRITE

    endprog

prpt db "Enter your name: ",0
t0 db "Hello, ",0
t1 db "!",13,10,0
tx times 32 db 0
