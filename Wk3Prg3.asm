COMMENT /
 Description:
 Copy a String in Reverse Order
	Write a program with a loop and indirect 
	addressing that copies a string from source 
	to target, reversing the character order in 
	the process. 
	Use the following variables:
	source BYTE "This is the source string",0
	target BYTE SIZEOF source DUP('#')
 Creator: Carlos Vazquez
 Date Created: 6 November 2015
/Course: CISS 360A

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	source BYTE "This is the source string",0
	target BYTE SIZEOF source DUP('#')

.code
	main proc

	mov esi, OFFSET source					; index register
	mov edi, SIZEOF target - TYPE target	; points to the last element
	mov ecx, LENGTHOF source				; loop counter

L1:
	mov al, [esi]							; get a character from source
	mov target[edi], al						; store in the target from the last element
	add esi, TYPE source					; move it to the next character.
	sub edi, TYPE target
	loop L1									; keep looping

	
	invoke ExitProcess,0
main endp
end main