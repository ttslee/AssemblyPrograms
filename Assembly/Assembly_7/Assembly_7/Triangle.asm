INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

.data
myHandle DWORD ?
TrianglePos DWORD ?
topCoord COORD <10,4>
outputCount DWORD ?
hHeap HANDLE ?
temp DWORD 1
byteCount DWORD 2

.code
;-------------MAIN-----------------------
main PROC
INVOKE GetstdHandle, STD_OUTPUT_HANDLE
mov myHandle, eax
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
mov bx, topCoord.X
dec bx
mov topCoord.X, bx
mov bx, topCoord.Y
inc bx
mov topCoord.Y, bx

add temp, 2
add byteCount, 2

INVOKE HeapFree, hHeap, 0, TrianglePos
pop ecx
dec ecx
jne TRIANGLE

quit:
INVOKE ExitProcess, 0
main ENDP
;-------------------------------------------

;-------------------------------------------
COORD STRUCT
X WORD ?
Y WORD ?
COORD ENDS
;-------------------------------------------
END main

; '/' = 2Fh
; '\' = 5Ch

;---------------FIRST ATTEMPT---------------
;mov ecx, byteCount
;update:
;	cmp byteCount, ecx
;	je first
;	cmp ecx, 1
;	je last
;	jmp middle
;	first:
;	mov BYTE PTR [esi], 2Fh
;	loop update
;	last:
;	middle:
;	mov BYTE PTR [esi + %(byteCount - temp)], 0FFh
;loop update

;-------------TESTING WriteConsoleOutputCharacter------------
;mov esi, TrianglePos
;mov BYTE PTR [esi], 0C4h
;INVOKE WriteConsoleOutputCharacter, myHandle, TrianglePos, 1, topCoord, OFFSET outputCount