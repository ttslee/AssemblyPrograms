.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
.code
main PROC
mov ebx, 25
mov ecx, 25
mov edx, 9
cmp ebx, ecx
JA quit
cmp ecx, edx
JB quit
mov eax, 5
mov edx, 6
quit:
main ENDP
END main
