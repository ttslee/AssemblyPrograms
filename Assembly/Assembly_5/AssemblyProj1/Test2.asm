

INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
WriteScaled PROTO, decOffset: DWORD, numAd: PTR BYTE, numLen: DWORD
.data
DECIMAL_OFFSET DWORD 5
number BYTE "123456789"
;number2 BYTE "56054"
;number3 BYTE "100123456789765"
count DWORD 0
.code
main PROC
	INVOKE WriteScaled, DECIMAL_OFFSET, OFFSET number, LENGTHOF number
	mov edx, OFFSET number
	call WriteString
INVOKE ExitProcess, 0
main ENDP

;-------------------------------------------------
WriteScaled PROC USES eax ebx ecx edx, 
	decOffset: DWORD, 
	numAd: PTR BYTE, 
	numLen: DWORD,
;-------------------------------------------------
mov ebx, decOffset
mov	ecx, numLen
mov edx, numAd
sub ecx, ebx
mov al, BYTE PTR [edx + ecx]		; save character being replaced by a '.'
mov BYTE PTR [edx + ecx], '.'		; Set character decOffset from the right to '.'
push ecx
mov ecx, ebx
pop ebx
shift:
	inc ebx
	push ecx
	mov cl, BYTE PTR [edx + ebx]	; move all characters to the right of the decimal to the next index
	mov BYTE PTR [edx + ebx], al
	mov al, cl
	pop ecx
loop shift
ret
WriteScaled ENDP

END main