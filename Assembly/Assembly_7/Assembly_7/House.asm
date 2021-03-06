INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
.data
;-----------TRIANGLE----------------
TrianglePos DWORD ?
topCoord COORD <16,5>
hHeap HANDLE ?
temp DWORD 1
byteCount DWORD 2

;-----------BOX---------------------
boxTop BYTE 0C9h, 14 DUP(0CDh), 0BBh
boxMid BYTE 0BAh, 14 Dup(0FFh), 0BAh
boxBot BYTE 0C8h, 14 DUP(0CDh), 0BCh
top COORD <9,13>
botCoord COORD <9,21>

;-----------WINDOW-------------------
wTop BYTE 0C9h, 0CBh, 0BBh
wBot BYTE 0C8h, 0CAh, 0BCh
wTopCrd COORD <12,15>

;----------CHIMNEY--------------------
cTop BYTE 0C9h, 0BBh
cMid BYTE 0BAh, 0BAh
cBot BYTE 0BAh
cTopCrd COORD <21, 6>
;------------DOOR---------------------
dTop BYTE 0C9h, 0CBh, 0BBh
dMid BYTE 0CCh, 0CEh, 0B9h
dBot BYTE 0C8h, 0CAh, 0BCh
dTopCrd COORD <17, 19>
;-----------SHARED DATA---------------
myHandle DWORD ?
outputCount DWORD ?
.code
;-------------MAIN-----------------------
main PROC
INVOKE GetstdHandle, STD_OUTPUT_HANDLE
mov myHandle, eax

;B-----------------------------BOX----------------------------------------B

;------------TOP OF BOX-----------------
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET boxTop, 16, top, OFFSET outputCount

;------------MIDDLE OF BOX--------------
mov ecx, 8
MID:
	inc top.Y
	push ecx
	INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET boxMid, 16, top, OFFSET outputCount
	pop ecx
loop MID
;------------BOTTOM OF BOX--------------
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET boxBot, 16, botCoord, OFFSET outputCount
;B------------------------------------------------------------------------B

;T----------------------------TRIANGLE------------------------------------T
mov ecx, 8
;---------DRAW TRIANGLE USING HEAP---------
TRIANGLE:
push ecx
INVOKE GetProcessHeap
.IF eax == NULL ; cannot get handle
jmp quit
.ELSE
mov hHeap,eax ; handle is OK
.ENDIF

INVOKE HeapAlloc, hHeap, HEAP_ZERO_MEMORY, 20
.IF eax == NULL
jmp quit
.ELSE
mov TrianglePos,eax
.ENDIF

;---------UPDATE TRIANGLEPOS AND topCOORD------------
mov esi, TrianglePos
mov BYTE PTR [esi], 2Fh
add esi, temp
mov BYTE PTR [esi], 5Ch

INVOKE WriteConsoleOutputCharacter, myHandle, TrianglePos, byteCount, topCoord, OFFSET outputCount
dec topCoord.X
inc topCoord.Y

add temp, 2
add byteCount, 2

INVOKE HeapFree, hHeap, 0, TrianglePos
pop ecx
dec ecx
jne TRIANGLE
;T-------------------------------------------------------------------------T

;W-------------------------------WINDOWS-----------------------------------W
mov ecx, 2
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET wTop, 3, wTopCrd, OFFSET outputCount
inc wTopCrd.Y
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET wBot, 3, wTopCrd, OFFSET outputCount
add wTopCrd.X, 7
dec wTopCrd.Y
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET wTop, 3, wTopCrd, OFFSET outputCount
inc wTopCrd.Y
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET wBot, 3, wTopCrd, OFFSET outputCount
;W-------------------------------------------------------------------------W


;D--------------------------------DOOR-------------------------------------D
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET dTop, 3, dTopCrd, OFFSET outputCount
inc dTopCrd.Y
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET dMid, 3, dTopCrd, OFFSET outputCount
inc dTopCrd.Y
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET dBot, 3, dTopCrd, OFFSET outputCount
;D-------------------------------------------------------------------------D

;C-------------------------------CHIMNEY-----------------------------------C
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET cTop, 2, CTopCrd, OFFSET outputCount
mov ecx, 2
inc cTopCrd.Y
CHIMNEY:
push ecx
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET cMid, 2, CTopCrd, OFFSET outputCount
inc cTopCrd.Y
pop ecx
loop CHIMNEY
inc cTopCrd.X
INVOKE WriteConsoleOutputCharacter, myHandle, OFFSET cMid, 1, CTopCrd, OFFSET outputCount

quit:
INVOKE ExitProcess, 0
main ENDP
END main