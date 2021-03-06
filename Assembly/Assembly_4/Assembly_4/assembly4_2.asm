;Author:		Alexander Martinez
;OS:			Windows 7/10
;Assembler:		MASM
;Class/Assn:	CS16 Assignment 4
;Updated:		10/25/16

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
array SWORD 50 DUP(?)
sentinel SWORD 0ffffh
val1 DWORD 20h
charArray BYTE 'A', 'B', 'C', 'D', 'F'
score WORD 80d

.code
main PROC
; PART ONE
;mov array[60], 10d
mov esi, OFFSET array
mov ecx, LENGTHOF array
L1: 
	cmp WORD PTR [esi] , 0
	jnz NonZero
	add esi, TYPE array
	loop L1
NoneFound:
	mov esi, OFFSET sentinel
Nonzero:
	mov eax, [esi]

; PART TWO   (if ebx <= ecx -> eax=5 && edx=6)
	mov ecx, 10
	mov ebx, 5
	cmp ecx, ebx
	jb false1
	mov eax, 5
	mov edx, 6
false1:

;PART THREE
	mov ebx , 5
	mov ecx, 5
	mov edx, 4
	cmp ecx , ebx
	jb false2
	cmp ecx , edx
	jbe false2
	mov eax , 5	
	mov ebx, 6
false2:

;PART FOUR
mov ebx, 10h
Loopcmp:
	cmp ebx, val1
	ja break
	add ebx , 5
	dec val1
	jmp Loopcmp
break:
	

;PART FIVE
mov esi, OFFSET score
call CalcGrade
mov bx, ax

INVOKE ExitProcess , 0
main ENDP

;--------------------------------------------------------
;--------------------------------------------------------
;Calculate grade based on score from 50-100
;--------------------------------------------------------
;--------------------------------------------------------
CalcGrade PROC
	mov cx, LENGTHOF charArray
	mov ax, 90d
	GradeCheck:
		cmp [esi], ax
		jae Grade
		sub ax, 10d
	loop GradeCheck

	Grade:
		mov di, LENGTHOF charArray
		sub di, cx
		movzx ax, charArray[di]
	ret
CalcGrade ENDP
;--------------------------------------------------------
;--------------------------------------------------------
END main
