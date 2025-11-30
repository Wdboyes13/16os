[bits 16]
[org 0]
%include "prog.inc"
start:
    stprog
    ssc SYS_SHDN
fail:   ; Shouldn't reach hear, but if we do halt the CPU
    cli
    hlt
    jmp $
