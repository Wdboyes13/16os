[bits 16]
[org 0]

%include "prog.inc"

start:
    stprog

    mov si,help
    ssc SYS_WRITE

    endprog

help db "echo - gets input and prints it back",13,10,"ls - prints files",13,10,"shutdown - shuts down pc",13,10,"hello - example program",13,10,"clear - clears terminal",13,10,"help - prints this message",13,10,0
