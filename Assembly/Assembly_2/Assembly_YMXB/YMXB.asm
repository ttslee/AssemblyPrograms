.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
string EQU <"Hello World!">
.data
val1 DWORD 2000h
val2 DWORD 1000h
sum  DWORD ?
dif  DWORD ?
product DWORD ?
prompt BYTE string
.code
main PROC
; Result 1 calculated and stored in ebx
	mov eax, val1
	mov ebx, val2
	add eax, ebx
	mov sum, eax
	mov eax, val1
	sub eax, ebx
	mov dif, eax
	mov eax, dif
	mov ebx, sum
	mul ebx
	mov ecx, eax
	mov eax, 3
	mov ebx, dif
	mul ebx
	add eax, ecx
	mov ebx, eax
; Result 2 calculated and stored in edx
	mov eax, val2
	mov ecx, 6
	mul ecx
	mov product, eax
	mov eax, product
	add eax, val1
	mov ecx, sum
	div ecx
	mov edx, eax
	INVOKE ExitProcess, 0
main ENDP
END main

