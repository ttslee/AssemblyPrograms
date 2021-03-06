INCLUDE Irvine32.inc
ExitProcess PROTO, quit: DWORD
.data
.code
main PROC
mov eax, 4000EAh
mov edx, 5h
mov ebx, 100h
div ebx
INVOKE ExitProcess, 0
main ENDP
END main