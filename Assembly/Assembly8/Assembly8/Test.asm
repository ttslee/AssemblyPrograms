INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
.data

.code
main PROC
call ReadChar

INVOKE ExitProcess, 0
main ENDP
;-------------------------------------------

;-------------------------------------------
END main