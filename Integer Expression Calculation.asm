COMMENT /
 Description:
 Integer Expression Calculation
 Using the AddTwo program from Section 3.2 as a reference, 
 write a program that calculates the following expression, 
 using registers: A = (A + B) - (C + D). Assign integer 
 values to the EAX, EBX, ECX, and EDX registers.
 Creator: Carlos Vazquez
 Date Created: 6 November 2015
/Course: CISS 360A

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	diff	sdword 0

.code
main proc

	mov	eax,5
	mov ebx,6	
	add eax,ebx

	mov ecx,7
	mov	edx,8
	add ecx, edx
	
	sub eax, ecx
	mov diff, eax
		
	invoke ExitProcess,0
main endp
end main