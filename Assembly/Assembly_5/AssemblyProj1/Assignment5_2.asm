INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
WriteScaled PROTO, decOffset: DWORD, numAd: PTR BYTE, numLen: DWORD, counter:DWORD, terminal: DWORD
.data
DECIMAL_OFFSET DWORD 5
number BYTE "123456789"
number2 BYTE "56054"
number3 BYTE "100123456789765"
count DWORD 0
tVal DWORD 0		;tVal is the decimal point position index
.code
main PROC
	INVOKE WriteScaled, DECIMAL_OFFSET, OFFSET number, LENGTHOF number, count, tVal
	call Crlf
	INVOKE WriteScaled, DECIMAL_OFFSET, OFFSET number2, LENGTHOF number2, count, tVal
	call Crlf
	INVOKE WriteScaled, DECIMAL_OFFSET, OFFSET number3, LENGTHOF number3, count, tVal
	call Crlf
INVOKE ExitProcess, 0
main ENDP

;-------------------------------------------------
WriteScaled PROC USES eax ebx ecx edx, 
	decOffset: DWORD, 
	numAd: PTR BYTE, 
	numLen: DWORD,
	counter: DWORD,
	terminal: DWORD
;-------------------------------------------------
mov ebx, decOffset
mov	ecx, numLen
mov edx, numAd
mov eax, counter
push ecx
sub ecx, ebx
mov terminal, ecx		; set terminal value to the numLen - decOFFSET 
pop ecx

shift:
	push ecx
	cmp eax, terminal
	push eax
	je decimalPoint
	mov al, BYTE PTR [edx + eax]	; move all characters to the right of the decimal to the next index
	call WriteChar
	jmp continue

	decimalPoint:					; When we find the decimal point index, we have to print the character at current index after printing the '.'
		mov al, '.'
		call WriteChar
		pop ecx
		mov al, BYTE PTR [edx + ecx]
		push ecx
	call WriteChar

	continue:
		pop eax
		inc eax
		pop ecx
loop shift
ret
WriteScaled ENDP
;---------------------------------------------------
END main