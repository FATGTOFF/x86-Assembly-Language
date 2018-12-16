COMMENT /
 Description:
	Filling an array
	Create a procedure that fills an array 
	of doublewords with N random integers, 
	making sure the values fall within the 
	range j...k, inclusive. When calling the 
	procedure, pass a pointer to the array 
	that will hold the data, pass N, and pass 
	the values of j and k. Preserve all register 
	values between calls to the procedure. Write 
	a test program that calls the procedure twice, 
	using different values for j and k. Verify 
	your results using a debugger.
	Creator: Carlos Vazquez
	Date Created : 6 November 2015
/ Course : CISS 360A

INCLUDE Irvine32.inc

TAB = 9														; ASCII code for Tab

; Create user-defined types.
PDWORD TYPEDEF PTR DWORD									; define the pointer to double words

.data
	N = 10													; symbolic constant of number of integers
	promptLowest BYTE "Enter the lowest value: ", 0			; ask the user to input value
	promptHighest BYTE "Enter the highest value: ", 0		; ask the user to input value
	j DWORD ?												; variable to hold the lowest number
	range DWORD ?											; variable to hold the range
	randomNumbers DWORD N DUP (?)							; initialize an array with random numbers								
	arraySize = ($ - randomNumbers) / TYPE randomNumbers	; obtain the size of the array
	ptr1	PDWORD	randomNumbers							; pointer to the array

.code
main proc

	;call Randomize											; call the procedure to seed the random values
	mov esi, ptr1											; use the pointer to access the array							
	mov ecx, arraySize										; set the loop counter to the size of the array
	call Randomize
	call fillArray											; call the procedure to fill the array with random values
	call fillArray											; call the procedure to fill the array with random values

	
invoke ExitProcess,0
main endp

;------------------------------------------------------------------
; fillArray															
;	This procedure ask the user to input the minimum value and the
; the highest value to determine the random value between the lowest
; and highest value (inclusive). This procedure uses a loop to iterate
; each element of the array and a while loop to validate the minimum
; random value is correct.
; Receives: ECX to maintain the loop counter by pushing the initial
; size of the array.
; Returns: The output of the random values
;-----------------------------------------------------------------
fillArray proc

	push ecx												; push the counter into the stack
	mov edx, OFFSET promptLowest
	call WriteString										; ask user for input
	call ReadInt											; obtain the lowest value from the user
	mov j, eax												; save the lowest value into the variable

	mov edx, OFFSET promptHighest							
	call WriteString										; ask user for input
	call ReadInt											; obtain highest value from the user
	sub eax, j												; substract the lowest value from the highest value
	inc eax													; increase one to the range value to become inclusive
	mov range, eax											; save the inclusive range value for the random range

L1:
	mov eax, range											; save the eax register with the inclusive range value
	call RandomRange										; call the procedure to obtain random number
	add eax, j												; add the value j to be inclusive in the random range
	push esi												; save the esi register into the stack
	mov [esi], eax											; save the random value into the element of the array
	call WriteDec											; display the value to the user
	mov al, TAB												; horizontal tab
	call WriteChar											; write the tab
	add esi, TYPE randomNumbers								; move to the next array element
	pop esi													; restore esi register from the stack
	loop L1													; continue to loop

	pop ecx													; pop the counter out of stack to use on the second call of the procedure
	call Crlf												; clear one space of line
	call Crlf												; clear one space of line
	ret														; return to the calling procedure

fillArray	endp

end main