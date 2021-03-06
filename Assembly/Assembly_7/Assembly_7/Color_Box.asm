INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
RandomSleep PROTO, sleepSeed:DWORD
.data
;-----------BOX-----------------
boxRow BYTE 10 DUP(0DBh)
boxLen DWORD ($ - boxRow)
attributes WORD 0Fh,0Eh,0Dh,0Ch,0Bh,0Ah,9,8,7,6
outputCount DWORD ?
topPos COORD <10, 5>
myHandle DWORD ?
;-------CLEAR SCREEN------------
clrScrnX BYTE 50 DUP(0FFh)
clrLen DWORD ($ - clrScrnX)
clrCoord COORD <0,0>

sleepTime DWORD ?
.code
main PROC

INVOKE GetstdHandle, STD_OUTPUT_HANDLE
mov myHandle, eax
mov ecx, 40

MOVE:
push ecx
;--------------------SLEEP----------------------
INVOKE RandomSleep, 200

;-------------------DRAW BOX--------------------
mov ecx, 6
DRAW:
push ecx
INVOKE WriteConsoleOutputAttribute, myHandle, OFFSET attributes, boxLen, topPos, ADDR outputCount
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET boxRow, boxLen, topPos, OFFSET outputCount
inc topPos.Y
pop ecx
loop DRAW

;---------------------SHIFT BOX----------------
call Randomize
mov eax, 40
call RandomRange
mov topPos.X, ax
call Randomize
mov eax, 15
call RandomRange
mov topPos.Y, ax

;-----------------------SLEEP------------------
INVOKE RandomSleep, 2000

;--------------------CLEAR SCREEN--------------
mov ecx, 25
ClearScrn:
push ecx
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET clrScrnX, clrLen, clrCoord, OFFSET outputCount
inc clrCoord.Y
pop ecx
loop ClearScrn
mov clrCoord.Y, 0

pop ecx
dec ecx
cmp ecx, 0
ja MOVE

INVOKE ExitProcess, 0
main ENDP

;-------------------------------------------
RandomSleep PROC, sleepSeed:DWORD
;-------------------------------------------
call Randomize
mov eax, sleepSeed
call RandomRange
pushad
INVOKE Sleep, eax
popad
ret
RandomSleep ENDP
;-------------------------------------------

END main