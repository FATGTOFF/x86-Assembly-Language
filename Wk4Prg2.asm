COMMENT /
 Description:
 Random Strings
	Create a procedure that generates 
	a random string of length L, 
	containing all capital letters.
	When calling the procedure, pass 
	the value of L in EAX, and pass 
	a pointer to an array of byte
	that will hold the random string. 
	Write a test program that calls 
	your procedure 20 times and displays
	the strings in the console window. Page 174
 Creator: Carlos Vazquez
 Date Created: 6 November 2015
/Course: CISS 360A

INCLUDE Irvine32.inc

; Create user-defined types.
PBYTE	TYPEDEF	PTR	BYTE

.data
	COUNTPROC = 20					;// This is to be used to display the number of random strings
	L BYTE "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0
	ptr1	PBYTE	L
	programTitle BYTE "Displaying a 27-character length random strings 20 times...", 0

.code
main proc

	mov edx, OFFSET programTitle	;// Notify user what the program will execute
	call WriteString				;// output the information to the console output window
	call Crlf						;// clear one single line
	call Randomize					;// initialize random generator
	call counterCalls				;// call the procedure to call the random string procedure 20 times.

main endp

;------------------------------------------------------------------
; randomString															
; Uses random values to select characters to output random strings
; Recieves: EAX, ECX, ESI, AL to obtain the random value and 
; place it into the element of the string.
; Returns: Random characters of 26 capitalized letters
;-----------------------------------------------------------------
randomString proc

	mov ecx, SIZEOF L				;// set the counter from the size of the L string
	mov esi, ptr1					;// use the pointer to access the data

L1:
	mov eax, [SIZEOF L - 1]			;// set the size of the random range to the number of letters in the L string
	call RandomRange				;// generate random integer
	mov	al, [esi + eax]				;// select the letter of the L string based on the random number
	call WriteChar					;// display the character in the console output.
	loop L1							;// continue to loop
	call Crlf						;// clear the single line
	ret								;// return to the calling procedure.

randomString endp

;------------------------------------------------------------------
; counterCalls															
; This procedure uses a loop to call the randomString procedure
; twenty times.
; Receives: ECX to maintain the loop counter by pushing the initial
; value of twenty and then pop the counter on each loop.
; Returns: The output of the random strings
;-----------------------------------------------------------------
counterCalls proc

	mov ecx, COUNTPROC				;// set the counter to loop the number of procedures calls to perform

L1:	
	push ecx						;// push the counter into the stack
	call randomString				;// call the procedure
	pop ecx							;// pop the counter out of the stack
	loop L1							;// continue to loop

counterCalls endp

invoke ExitProcess,0

end main