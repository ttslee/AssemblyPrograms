INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
.data
m DWORD 5
x DWORD 5
.code
main PROC
	mov ax, 0Ah
	call mul44
	INVOKE ExitProcess, 0
main ENDP

;--------------------------------
mul44 PROC
	push eax
	shl ax, 5		;multiply by 32
	mov bx, ax
	pop eax
	push eax
	shl ax, 2		;multiply by 4
	add bx, ax
	pop eax
	shl ax, 3		;multiply by 8
	add bx, ax
	mov ax, bx
	ret
mul44 ENDP
;--------------------------------

END main

