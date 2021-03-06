INCLUDE Irvine32.inc
;
ExitProcess PROTO, dwExitCode:DWORD
Encryption_func PROTO, keyAd: PTR SBYTE, keyLen: DWORD,  strAd: PTR BYTE, strLen: DWORD
.data
key SBYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
key1 SBYTE 2, -4, -1, 0, 3, -5, -2, 4, 4, -6
string BYTE "Hello World I Love You"
count WORD 0
.code
main PROC
mov edx, OFFSET string
	call WriteString
	call Crlf
;----------------------FORWARD ENCRYPTION-------------------------
	INVOKE Encryption_func, 
			OFFSET key, LENGTHOF key, OFFSET string, LENGTHOF string
	mov edx, OFFSET string
	call WriteString
	call Crlf
;----------------------BACKWARD ENCRYPTION-------------------------
	INVOKE Encryption_func, 
			OFFSET key1, LENGTHOF key1, OFFSET string, LENGTHOF string
	mov edx, OFFSET string
	call WriteString
	call Crlf
INVOKE ExitProcess, 0
main ENDP

;----------------------------------------
Encryption_func PROC USES eax ebx ecx edx esi, 
		keyAd: PTR SBYTE,
		keyLen: DWORD,	
		strAd: PTR BYTE,
		strLen: DWORD,
;-------------------------------------------
	mov esi, keyAd
	mov ebx, keyLen
	mov edx, strAd
	mov ecx, strLen
	mov eax, 0
	mov count, 0
		stringL:
			push ecx
			push ebx
			mov ebx, 0
			mov bx, count
			mov cl, SBYTE PTR [esi + eax]
			ror BYTE PTR [edx + ebx], cl
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
	mov count, 0
	ret
Encryption_func ENDP
;----------------------------------------------

END main