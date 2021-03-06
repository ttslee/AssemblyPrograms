INCLUDE Irvine32.inc
;------------PROTOS-----------------------------------------
ExitProcess PROTO, dwExitCode:DWORD
Discriminant PROTO, nA:REAL8, nB:REAL8, nC:REAL8, disc:PTR REAL8
TwoRealSolutions PROTO, nA:Real8, nB:REAL8, disc:REAL8
TwoImaginarySolutions PROTO, nA:REAL8, nB:REAL8, disc:REAL8
OneRealSolution PROTO, nA:REAL8, nB:REAL8
;-----------MACROS-----------------------------
mReadFloatWithMessage MACRO string
push edx
	mov eax, 16
mov edx, OFFSET string
call WriteString
call ReadFloat
pop edx
ENDM

;---------------DATA-----------------------------
.data
msgA BYTE "Enter A: ", 0
msgB BYTE "Enter B: ", 0
msgC BYTE "Enter C: ", 0
numA REAL8 ?
numB REAL8 ?
numC REAL8 ?
two REAL8 2.0
four REAL8 4.0
zero REAL8 0.0
D REAL8 ?
clean REAL8 ?

twoRealMsg BYTE "The Two Real Solutions are: ", 0
twoImagMsg BYTE "The Two Imag Solutions are: ", 0
oneRealMsg BYTE "The one Real Solution is: ", 0
andBuff BYTE 23 DUP(" "), "and  ", 0
plusBuff BYTE " + ", 0
minusBuff BYTE " - ", 0
imaginary BYTE "*I", 0
msgHigh BYTE "Y is lower", 0Dh, 0Ah, 0

;-----------------MAIN------------------------------
.code
main PROC

mov ecx, 5
Quadratic:
push ecx

mReadFloatWithMessage msgA
fstp numA
mReadFloatWithMessage msgB
fstp numB
mReadFloatWithMessage msgC
fstp numC
;---------DISCRIMINANT-----------
INVOKE Discriminant, numA, numB, numC, OFFSET D
;---------------------------------
fld zero
fld D
fcomi ST(0), ST(1)
jb TWOIMAG
ja TWOREAL
je ONE

TWOIMAG:
fstp clean
INVOKE TwoImaginarySolutions, numA, numB, D
jmp next

TWOREAL:
fstp clean
INVOKE TwoRealSolutions, numA, numB, D
jmp next

ONE:
fstp clean
INVOKE OneRealSolution, numA, numB

next:
pop ecx
dec ecx
jz quit
jmp Quadratic

quit:
INVOKE ExitProcess, 0
main ENDP
;------------------END MAIN------------------------------
;-------------------------------------------
Discriminant PROC, 
		nA:REAL8, 
		nB:REAL8, 
		nC:REAL8,
		disc:PTR REAL8
;-------------------------------------------
mov esi, disc
fld nB
fmul nB
fld nC
fld nA
fmul
fmul four
fsub
fstp REAL8 PTR [esi]
fstp clean
ret
Discriminant ENDP

;------------------TWO REAL SOLUTIONS--------------
TwoRealSolutions PROC, 
		nA:Real8, 
		nB:REAL8, 
		disc:REAL8
;--------------------------------------------------
fld nB
fchs
fld disc
fsqrt
fadd
fld nA
fmul two
fdiv

mov edx, OFFSET twoRealMsg
call WriteString
call WriteFloat
fstp clean

fld nB
fchs
fld disc
fsqrt
fsub
fld nA
fmul two
fdiv 

call crlf
mov edx, OFFSET andBuff
call WriteString
call WriteFloat
fstp clean
call crlf
ret
TwoRealSolutions ENDP

;--------------TWO IMAGINARY SOLUTIONS---------------
TwoImaginarySolutions PROC, 
		nA:REAL8, 
		nB:REAL8, 
		disc:REAL8
;----------------------------------------------------
fld nB							; calculate real part
fchs
fld nA
fdiv

mov edx, OFFSET twoImagMsg
call WriteString				
call WriteFloat					; print real part of solution
mov edx, OFFSET plusBuff
call WriteString

fld disc						; calculate imaginary part
fchs
fsqrt
fld nA
fdiv

call WriteFloat					; print added imaginary part of solution
mov edx, OFFSET imaginary
call WriteString
call crlf

mov edx, OFFSET andBuff
call WriteString			
fstp nA							; pop imaginary part to all ow printing of real
call WriteFloat					; print real part again
mov edx, OFFSET minusBuff
call WriteString

fld nA							; load imaginary into st(0)
call WriteFloat					; print subtracted imaginary part again
mov edx, OFFSET imaginary
call WriteString
call crlf

fstp clean						; clean floating point stack
fstp clean

ret
TwoImaginarySolutions ENDP
;--------------ONE REAL SOLUTION---------------------------
OneRealSolution PROC, 
		nA:REAL8, 
		nB:REAL8
;----------------------------------------------------------
fld nB							; calculate real part
fchs
fld nA
fdiv

mov edx, OFFSET oneRealMsg
call WriteString
call WriteFloat
call crlf

fstp clean
ret
OneRealSolution ENDP


END main