COMMENT /
 Description:
 Data Definitions
	Write a program that clears the screen, 
	locates the cursor near the middle of the 
	screen, prompts the user for two integers, 
	adds the integers, and displays their sum.
	Let this new program repeat the same steps 
	three times, using a loop. Clear the screen 
	after each loop iteration. LOOK AT PAGE 174!!!
 Creator: Carlos Vazquez
 Date Created: 6 November 2015
/Course: CISS 360A

INCLUDE Irvine32.inc

.data
	COUNT = 3
	prompt BYTE "Enter a integer: ", 0
	result BYTE "The sum is: ", 0
	sum DWORD ?

.code
	main proc

	mov ecx, COUNT

L1:
	call Clrscr
	mov dh, 12						; row 12
	mov dl, 45						; col 45
	call Gotoxy						; Place the cursor to row 12 col 45
	mov	edx, OFFSET prompt
	call WriteString				; Display the prompt to the user
	call ReadInt					; Obtain the input from the user and place it in eax register.
	mov sum, eax					; Save it in the sum variable

	mov dh, 13						; row 13
	mov dl, 45						; col 45
	call Gotoxy						; Place the cursor one line below than the first one.

	mov	edx, OFFSET prompt
	call WriteString				; Display prompt to the user.
	call ReadInt					; Obtain the input from the user and place it in eax register.
	add eax, sum					; Add the two values.

	mov dh, 14						; row 14
	mov dl, 45						; col 45
	call Gotoxy						; Place the cursor one line below than the second one.

	mov	edx, OFFSET result
	call WriteString				; Display the sum notification to the user
	call WriteInt					; Display the actual sum of the integer value to the user.
	mov eax, 1000					; Place 1 second to the eax register to delay the output screen
	call Delay						; Delay the output by calling the value from the eax register in milliseconds
	loop L1

	call Crlf
	call WaitMsg					; Display "Press any key..." to the user.
	
	invoke ExitProcess,0
main endp
end main