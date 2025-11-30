[bits 16]
[org 0]

%include "prog.inc"

start:
	stprog

	mov si,arr
	ssc SYS_READ
	mov si,arr
	ssc SYS_WRITE

	endprog

arr  times 50 db 0
