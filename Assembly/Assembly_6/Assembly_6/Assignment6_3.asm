INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
StrConcat PROTO, string1: PTR BYTE, string2: PTR BYTE, targetLen: DWORD, sourceLen: DWORD
.data
targetString BYTE "ABCDE", 10 DUP(0)
sourceString BYTE "FGH", 0
.code
main PROC
INVOKE StrConcat, OFFSET targetString, OFFSET sourceString, LENGTHOF targetString, LENGTHOF sourceString
mov edx, OFFSET targetString
call WriteString
call Crlf
INVOKE ExitProcess, 0
main ENDP
;------------------------------------------
StrConcat PROC,
		string1: PTR BYTE,
		string2: PTR BYTE,
		targetLen: DWORD,
		sourceLen: DWORD
;-------------------------------------------
mov edi, string1
mov al, 0						; search for null terminating char
mov ecx, targetLen
cld
repne scasb						; repeat while not equal
jnz quit						; if no null terminating characters were found then we can't concatinate

mov ecx, sourceLen
mov esi, string2
dec edi

concatinate:
	lodsb			; load source character to al
	stosb			; store al in target
loop concatinate

quit:
ret
StrConcat ENDP
END main