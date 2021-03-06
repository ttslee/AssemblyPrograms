INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
.data
myHandle DWORD ?
boxTop BYTE 0C9h, 13 DUP(0CDh), 0BBh
boxMid BYTE 0BAh, 13 Dup(0FFh), 0BAh
boxBot BYTE 0C8h, 13 DUP(0CDh), 0BCh
topCoord COORD <10,13>
midCoord COORD <10,13>
botCoord COORD <10,23>
outputCount DWORD ?
.code
main PROC
INVOKE GetstdHandle, STD_OUTPUT_HANDLE
mov myHandle, eax
;------------DRAW TOP OF BOX-----------------
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET boxTop, 15, topCoord, OFFSET outputCount

;------------LOOP MIDDLE OF BOX--------------
mov ecx, 10
MID:
	inc midCoord.Y
	push ecx
	INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET boxMid, 15, midCoord, OFFSET outputCount
	pop ecx
loop MID
;------------DRAW BOTTOM OF BOX--------------
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET boxBot, 15, botCoord, OFFSET outputCount

INVOKE ExitProcess, 0
main ENDP
;-------------------------------------------

;-------------------------------------------
END main

; '/' = 2Fh
; '\' = 5Ch