[bits 16]
[org 0]

%include "prog.inc"
start:
    stprog
    ssc SYS_CLR
    endprog
