INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
;Encryption_func PROTO, keyAd: PTR SBYTE, keyLen: BYTE,  strAd: PTR BYTE, strLen: BYTE
.data
key SBYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
string BYTE "Hello World I Love You"
count WORD 0
.code
main PROC
	mov edx, OFFSET string
	call WriteString
	call Crlf
	push OFFSET key
	push LENGTHOF key
	push OFFSET string
	push LENGTHOF string
	;---------
	call ENCRYPT
	call Crlf
	L2:
	INVOKE ExitProcess, 0
main ENDP
;-----------------------------------
ENCRYPT PROC
	enter 0, 0
	mov esi, [ebp + 20]
	mov ebx, [ebp + 16]
	mov edx, [ebp + 12]
	mov ecx, [ebp + 8]
	mov eax, 0
stringL:
	push ecx
	push ebx
		mov ebx, 0
		mov bx, count
		cmp SBYTE PTR [esi + ebx], 0
		jg pos
			mov cl, SBYTE PTR [esi + eax]
			neg cl
			rol BYTE PTR [edx + ebx], cl
			jmp top
		pos:
			mov cl, SBYTE PTR [esi + eax]
			ror BYTE PTR [edx + ebx], cl
	top:
	push eax
		mov al, BYTE PTR [edx + ebx]
		call WriteChar
		pop eax
	pop ebx
	pop ecx
	inc count
	inc eax
	cmp bx, count
	ja cont
	add bx, bx
	mov eax, 0
	cont:
loop stringL
	leave
	ret
ENCRYPT ENDP
END main