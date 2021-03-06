INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
DifferentInputs PROTO, num1: DWORD, num2: DWORD, num3: DWORD
.data
n1 DWORD 34
n2 DWORD 123
n3 DWORD 156
n4 DWORD 233
n5 DWORD 123

.code
main PROC
INVOKE DifferentInputs, n1, n2, n3

INVOKE DifferentInputs, n1, n2, n4

INVOKE DifferentInputs, n1, n2, n5

INVOKE DifferentInputs, n1, n4, n3

INVOKE DifferentInputs, n1, n5, n3

INVOKE ExitProcess, 0
main ENDP
;-------------------------------------------
DifferentInputs PROC, 
		num1: DWORD, 
		num2: DWORD, 
		num3: DWORD
;-------------------------------------------
mov eax, num1
mov ebx, num2
mov edx, num3
cmp eax, ebx
je match
cmp eax, edx
je match
cmp ebx, edx
je match
mov eax, 0
ret
match:
mov eax, 1
ret
DifferentInputs ENDP
;-------------------------------------------
END main