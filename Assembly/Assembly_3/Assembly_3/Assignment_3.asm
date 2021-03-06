; Author: Teo Lee
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
tempW WORD ?
tempB BYTE ?
intArray1 WORD 100, 200, 300, 400, 500, 600
num WORD 000ffffh
intArray2 BYTE 0, 2, 5, 9, 10
newArray2 BYTE 4 DUP(?)
.code
MAIN PROC
mov ax, num
inc al
;jmp Part2
; PART 1 SWAPPING ARRAY MEMBERS OF AN EVEN LENGTH ARRAY
	mov eax, LENGTHOF intArray1
	mov ecx, 3
decL:
	dec eax
		loop decL
	mov ecx, eax
	mov esi, 0
	push esi
swapArray:
	mov ax, intArray1[esi + 2]
	xchg intArray1[esi], ax
	mov intArray1[esi + 2], ax
	add esi, TYPE intArray1 * 2
		loop swapArray
	pop esi
	mov ecx, LENGTHOF intArray1
checkL:
	mov bx, intArray1[esi]
	add esi, 2
		loop checkL
; PART 2 CALCULATES THE SUM OF ALL THE GAPS BETWEEN SUCCESSIVE ARRAY ELEMENTS
Part2::
	mov ecx, LENGTHOF intArray2
	dec ecx
	push esi
	mov edi, OFFSET newArray2
fillArray2:
	mov al, intArray2[esi + TYPE intArray2]
	sub al, intArray2[esi]
	mov [edi], al
	add edi, TYPE intArray2
	inc esi
		loop fillArray2
	mov ecx, LENGTHOF newArray2
	pop esi
	mov eax, 0
calcSum:
	add al, newArray2[esi]
	inc esi
		loop calcSum

	INVOKE ExitProcess, 0
main ENDP
END main