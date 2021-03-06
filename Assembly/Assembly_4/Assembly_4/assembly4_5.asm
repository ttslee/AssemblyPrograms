;---------------------Irvine32.inc------------------
;	Includes all header dependencies/includes
;------------------------------------------------------------
INCLUDE Irvine32.inc
;---------------------------DATA-----------------------------
.data
CaseTable BYTE 'A'		; lookup value
	DWORD Process_A		; address of procedure
	EntrySize = ($ - CaseTable)
	BYTE 'B'
	DWORD Process_B
	BYTE 'C'
	DWORD Process_C
	BYTE 'D'
	DWORD Process_D
	BYTE 'F'
	DWORD Process_F
NumberOfEntries = ($ - CaseTable) / EntrySize

EnTest BYTE "Enter Test Grade:", 0
msgA BYTE "You got an A", 0Dh, 0Ah, 0
msgB BYTE "You got a B", 0Dh, 0Ah, 0
msgC BYTE "You got a C", 0Dh, 0Ah, 0
msgD BYTE "You got a D", 0Dh, 0Ah, 0
msgF BYTE "You got an F", 0Dh, 0Ah, 0

gradeArray BYTE 10 DUP(0)
;---------------------------CODE------------------------------
.code
;---------------------------MAIN------------------------------
main PROC
call randNum		;Fills gradeArray with 10 randomly generated grades
mov ecx, LENGTHOF gradeArray	; loop counter
mov esi, OFFSET gradeArray
L1:
;------------USE THIS FOR USER INPUTTED GRADES-----------
;	mov ebx, OFFSET CaseTable
;	mov edx, OFFSET EnTest
;	call WriteConsole
;	call ReadInt
;--------------------------------------------------------

;-----------RANDOM GENERATED GRADES----------------------
	mov al, [esi]
	mov ebx, OFFSET CaseTable
	call calcGrade
	call WriteInt
;--------------------------------------------------------
	call WriteString			; display message
	add esi, TYPE gradeArray
loop L1							; repeat until ECX = 0
L3:
	INVOKE ExitProcess, 0
main ENDP

;------------------------CALC GRADE PROCEDURE--------------------
;	Calculates grade from user input
;----------------------------------------------------------------
calcGrade PROC
	cmp al, 5ah
	JGE A
	cmp al, 50h
	JGE B
	cmp al, 46h
	JGE gradeC
	cmp al, 3Ch
	JGE D
	jmp F
A:
	call NEAR PTR [ebx + 1] 
	ret
B:
	add ebx, EntrySize
	call NEAR PTR [ebx + 1] 
	ret
gradeC:
	add ebx, EntrySize * 2
	call NEAR PTR [ebx + 1] 
	ret
D:
	add ebx, EntrySize * 3
	call NEAR PTR [ebx + 1] 
	ret
F:
	add ebx, EntrySize * 4
	call NEAR PTR [ebx + 1] 
	ret
calcGrade ENDP

;------------------------CaseTable Procedure Declarations---------------------------
Process_A PROC
	mov edx, OFFSET msgA
    RET
Process_A ENDP

Process_B PROC
	mov edx, OFFSET msgB
    RET
Process_B ENDP
 
Process_C PROC
	mov edx, OFFSET msgC
    RET
Process_C ENDP
 
Process_D PROC
	mov edx, OFFSET msgD
    RET
Process_D ENDP

Process_F PROC
	mov edx, OFFSET msgF
	RET
Process_F ENDP

;------------------------Random Number Generator--------------------------------
randNum PROC
	mov ecx, LENGTHOF gradeArray
	mov eax, 45
	mov esi, OFFSET gradeArray
L1:
	push eax
	mov ebx, 3
	mul ebx
	add eax, 5
	mov ebx, 50
	div ebx
	add edx, 50
	mov [esi], edx
	add esi, TYPE gradeArray
	pop eax
	add eax, 6
	loop L1
	RET
randNum ENDP
;----------------------------END MAIN-------------------------
END main