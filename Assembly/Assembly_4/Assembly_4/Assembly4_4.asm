.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
val1 DWORD 25
.code
main PROC
mov ebx, 5
top: cmp ebx, val1
	JA quit
	add ebx, 5
	sub val1, 1
	jmp top
quit:
	INVOKE ExitProcess, 0
main ENDP
END main