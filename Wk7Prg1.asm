COMMENT /
 Description:
	FindLargest Procedure
	Create a procedure named FindLargest that receives two parameters: a pointer to a signed
	doubleword array, and a count of the array’s length. The procedure must return the value of
	the largest array member in EAX. Use the PROC directive with a parameter list when declaring
	the procedure. Preserve all registers (except EAX) that are modified by the procedure.
	Write a test program that calls FindLargest and passes three different arrays of different
	lengths. Be sure to include negative values in your arrays. Create a PROTO declaration for
	FindLargest.
	Creator: Carlos Vazquez
	Date Created : 6 November 2015
/ Course : CISS 360A
INCLUDE Irvine32.inc

FindLargest PROTO, 	ptrArray: PTR SDWORD, szArray: SDWORD						; Create a PROTO declaration for FindLargest
DisplayArray PROTO, ptrArray: PTR SDWORD, szArray: SDWORD						; Create a PROTO declaration for DisplayArray

.data

	Ex1Array SDWORD -8, -5, -3, -7, -10											; An array of 5 elements
	Ex2Array SDWORD 2, 4, 6, -2, -4, -6, 8, -10, -8, 20							; An array of 10 elements
	Ex3Array SDWORD -7, -6, -5, 5, 44, 7, -8, 8, 9,-9, 11, -11, 43				; An array of 13 elements
	LargestValue BYTE "The highest value in the array is: ", 0					; A string to notify the user the highest value
	ArrayDisplay BYTE "Array: ", 0												; A string to display the array

.code
main proc

	mov edx, OFFSET ArrayDisplay												; offset the address of the string
	call WriteString															; display to the console output
	invoke DisplayArray, addr Ex1Array, LENGTHOF Ex1Array						; invoke the DisplayArray procedure with array num 1
	call Crlf																	; display a single line

	mov edx, OFFSET LargestValue												; offset the address of the string
	call WriteString															; display to the console output
	invoke FindLargest, addr Ex1Array, LENGTHOF Ex1Array						; invoke the FindLargest procedure with array num 1
	call WriteInt																; display the highest value stored in the eax register
	call Crlf																	; display a single line
	call Crlf																	; display a single line

	mov edx, OFFSET ArrayDisplay												; offset the address of the string
	call WriteString															; display to the console output
	invoke DisplayArray, addr Ex2Array, LENGTHOF Ex2Array						; invoke the DisplayArray procedure with array num 2
	call Crlf																	; display a single line

	mov edx, OFFSET LargestValue												; offset the address of the string
	call WriteString															; display to the console output
	invoke FindLargest, addr Ex2Array, LENGTHOF Ex2Array						; invoke the FindLargest procedure with array num 2
	call WriteInt																; display the highest value stored in the eax register
	call Crlf																	; display a single line
	call Crlf																	; display a single line

	mov edx, OFFSET ArrayDisplay												; offset the address of the string
	call WriteString															; display to the console output
	invoke DisplayArray, addr Ex3Array, LENGTHOF Ex3Array						; invoke the DisplayArray procedure with array num 3
	call Crlf																	; display a single line

	mov edx, OFFSET LargestValue												; offset the address of the string
	call WriteString															; display to the console output
	invoke FindLargest, addr Ex3Array, LENGTHOF Ex3Array						; invoke the FindLargest procedure with array num 3
	call WriteInt																; display the highest value stored in the eax register
	call Crlf																	; display a single line
	call Crlf																	; display a single line

exit
main endp

FindLargest proc uses esi ecx,
	ptrArray: PTR SDWORD,														; points to the array
	szArray: SDWORD																; array size

	mov esi, ptrArray															; address of the array
	mov ecx, szArray															; size of the array
	mov eax, [esi]																; save the first array element into the register

L1:																				; begin the loop
	cmp eax, [esi]																; compare the array elements
	jl HighestNum																; if the current element is less than the next element, then jump to the state
	add esi, TYPE SDWORD														; point to the next element
	loop L1																		; keep looping

	jmp ReturnToCaller															; if the counter is 0, then jump to the return state

HighestNum:																		; state to move the next array element into the register
	mov eax, [esi]																; mov the next array element into the register
	jmp L1																		; jmp back to the loop

ReturnToCaller:																	; state to return back to the calling procedure
    ret																			; return to the calling procedure

FindLargest	 ENDP

DisplayArray proc uses eax esi ecx,
	ptrArray: PTR SDWORD,														; points to the array
	szArray: SDWORD																; array size

	mov esi, ptrArray															; address of the array
	mov ecx, szArray															; size of the array

L1:
	mov eax, [esi]																; save the element into the array
	call WriteInt																; display the array element to the console
	mov al, 9																	; 9 is the value of TAB
	call WriteChar																; display the TAB between elements
	add esi, TYPE SDWORD														; move to the next element
	loop L1																		; keep looping

ret																				; return to the calling procedure

DisplayArray endp

end main
