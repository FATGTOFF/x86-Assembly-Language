COMMENT /
 Description:
 Data Definitions
	Write a program that uses the 
	variables below and MOV instructions
	to copy the value from
	bigEndian to littleEndian, reversing 
	the order of the bytes. The number’s 
	32-bit value is understood
	to be 12345678 hexadecimal.
	.data
	bigEndian BYTE 12h,34h,56h,78h
	littleEndian DWORD?
 Creator: Carlos Vazquez
 Date Created: 6 November 2015
/Course: CISS 360A

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	bigEndian BYTE 12h,34h,56h,78h
	littleEndian DWORD ?

.code
	main proc

	; store in order from low bytes to high bytes. SECTION 4.3.3
	mov al, BYTE PTR bigEndian + 3
	mov BYTE PTR littleEndian, al

	mov al, BYTE PTR bigEndian + 2
	mov BYTE PTR littleEndian + 1, al

	mov al, BYTE PTR bigEndian + 1
	mov BYTE PTR littleEndian + 2, al

	mov al, BYTE PTR bigEndian
	mov BYTE PTR littleEndian + 3, al

	invoke ExitProcess,0
main endp
end main