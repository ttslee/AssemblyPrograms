INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
.data
myHandle DWORD ?
myString BYTE 10 DUP(?), 0
bytesWritten DWORD ?
bytesRead DWORD ?
.code
main PROC

INVOKE GetstdHandle, STD_INPUT_HANDLE
mov myHandle, eax

INVOKE ReadConsole, myHandle, OFFSET myString, 10, OFFSET bytesRead, 0

INVOKE GetstdHandle, STD_OUTPUT_HANDLE
mov myHandle, eax

INVOKE WriteConsole, myHandle, OFFSET myString, LENGTHOF myString, OFFSET bytesWritten, 0


INVOKE ExitProcess, 0
main ENDP
;-------------------------------------------

;-------------------------------------------

;-------------------------------------------
END main