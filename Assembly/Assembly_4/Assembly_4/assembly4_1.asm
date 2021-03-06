.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
array SWORD 50 DUP(?)
sentinel SWORD 0FFFFh
.code
main PROC
mov esi,OFFSET array
mov ecx,LENGTHOF array
L1:
	cmp WORD PTR [esi],0 ; check for zero
	jz found
	add esi, TYPE array
	loop L1
found:
	mov si, sentinel
quit:
	INVOKE ExitProcess, 0
main ENDP
END main

;-----------------------To run a different file go to "Properties"(of desired file) and change Item Type to "Microsoft Macro Assembler"--------------------------
;
;						Switch currently bonded macro file to Item Type "Text"
;
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------