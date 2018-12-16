COMMENT /
 Description:
Color Matrix
	Write a program that displays a
	single character in all possible
	combinations of foreground and
	background colors(16 x 16 = 256).The
	colors are numbered from 0 to 15,
	so you can use a nested loop to
	generate all possible combinations.page 176 and 125
	Creator: Carlos Vazquez
	Date Created : 6 November 2015
	/ Course : CISS 360A

INCLUDE Irvine32.inc

.data
	OUTER_LOOP_COUNT DWORD 16
	INNER_LOOP_COUNT DWORD 16
	singleChar	BYTE "A", 0
	count DWORD 0

.code
main proc

	mov eax, -1								;// Set the eax register to negative one.
	mov ebx, 16
	mov ecx, OUTER_LOOP_COUNT				;// Set the outer loop count

L1:
	mov count, 0
	push ecx								;// Save the outer loop count
	mov ecx, INNER_LOOP_COUNT				;// Set the inner loop count
	inc eax
	push eax
	L2:

		call SetTextColor
		add eax, 16							;// Increase in increment of one to the next color
		;call SetTextColor					;// Set the color
		;inc eax							;// Increase in increment of one to the next color
		mov edx, OFFSET singleChar			;// Returns the initial address from the beginning
		call WriteString					;// Display the character with different colors in the console output

	loop L2									;// Keep looping the inner loop
	pop eax
	pop ecx									;// Restore the outer loop count
	call Crlf								;// Create an empty line after displaying 16 characters per line
loop L1										;// Keep looping the outer loop

	mov eax, 7								;//reset the color to the original state
	call SetTextColor

invoke ExitProcess,0
main endp	
end main