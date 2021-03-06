INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

mReadFloatWithMessage MACRO string
push edx
mov edx, OFFSET string
call WriteString
call ReadFloat
pop edx
ENDM

.data
msgX BYTE "Enter real number X: ", 0
msgY BYTE "Enter real number Y: ", 0
msgLow BYTE "X is lower", 0Dh, 0Ah, 0
msgHigh BYTE "Y is lower", 0Dh, 0Ah, 0
.code
main PROC

mReadFloatWithMessage msgX

mReadFloatWithMessage msgY

fcomi ST(0), ST(1)
jb higher

mov edx, OFFSET msgLow
call WriteString
jmp quit

higher:
mov edx, OFFSET msgHigh
call WriteString

quit:
INVOKE ExitProcess, 0
main ENDP
;-------------------------------------------

;-------------------------------------------
END main