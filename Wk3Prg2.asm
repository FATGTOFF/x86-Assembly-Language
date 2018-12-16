COMMENT /
 Description:
 Summing the Gaps between Array Values
	Write a program with a loop and indexed 
	addressing that calculates the sum of all 
	the gaps between successive array elements. 
	The array elements are doublewords, sequenced 
	in nondecreasing order. So, for example, the array 
	{0, 2, 5, 9, 10} has gaps of 2, 3, 4, and 1, whose 
	sum equals 10.
 Creator: Carlos Vazquez
 Date Created: 6 November 2015
/Course: CISS 360A

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	intArray DWORD 0,2,5,9,10
	sum	DWORD ?

.code
	main proc

	mov esi, OFFSET intArray		; Set the address of the intArray
	mov ecx, LENGTHOF intArray		; Initialize the loop counter
	mov	eax, 0
	mov	ebx, 0

L1:									; Beginning of the loop
	mov	eax, [esi]					; Move to the element of the array
	add esi, TYPE intArray			; Go to the next element of the array.
	mov ebx, [esi]					; Move to the next element of the array
	sub ebx, eax					; Substract the 2 elements of the array
	add sum, ebx					; Keep a running total

	loop L1							; Keep looping until the count is 0

	
	invoke ExitProcess,0
main endp
end main