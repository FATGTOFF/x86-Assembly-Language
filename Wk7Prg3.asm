COMMENT /
 Description:
	FindThrees Procedure
	Create a procedure named FindThrees that returns 1 if an array has three consecutive values of
	3 somewhere in the array. Otherwise, return 0. The procedure’s input parameter list contains a
	pointer to the array and the array’s size. Use the PROC directive with a parameter list when
	declaring the procedure. Preserve all registers (except EAX) that are modified by the procedure.
	Write a test program that calls FindThrees several times with different arrays.
	Creator: Carlos Vazquez
	Date Created : 6 November 2015
/ Course : CISS 360A
INCLUDE Irvine32.inc

FindThrees PROTO, ptrArray: PTR SDWORD, szArray: SDWORD						; create a PROTO declaration for FindThrees
DisplayArray PROTO, ptrArray: PTR SDWORD, szArray: SDWORD					; create a PROTO declaration for FindThrees

.data
	Ex1Array SDWORD 8, 3, 3, 3, 10											; an array of 5 elements
	Ex2Array SDWORD 2, 4, 6, -2, -4, -6, 8, 3, -3, 3						; an array of 10 elements
	Ex3Array SDWORD -7, -6, -5, 5, 3, 3, 3, 3, 9, 3, 3, 3, 3			; an array of 13 elements
	FoundMsg BYTE "The array has three consecutive 3s.",0					; notify found consecutive numbers
	NotFoundMsg BYTE "The array does not contain three consecutive 3s.",0	; notify not found consecutive numbers
	ArrayDisplay BYTE "Array: ", 0											; a string to display the array
	ReturnCode BYTE "Return Code (1 = Found) (0 = Not Found): ", 0			; notify the user the return code

.code
main proc

	mov edx, OFFSET ArrayDisplay											; offset the address of the string
	call WriteString														; display to the console output
	invoke DisplayArray, addr Ex1Array, LENGTHOF Ex1Array					; invoke the DisplayArray procedure with array num 1
	call Crlf																; display a single line

	invoke FindThrees, addr Ex1Array, LENGTHOF Ex1Array						; invoke the FindLargest procedure with array num 1
	call WriteDec															; display a decimal to the console output
	call Crlf																; display a single line

	call Crlf																; display a single line
	mov edx, OFFSET ArrayDisplay											; offset the address of the string
	call WriteString														; display to the console output
	invoke DisplayArray, addr Ex2Array, LENGTHOF Ex2Array					; invoke the DisplayArray procedure with array num 2
	call Crlf																; display a single line

	invoke FindThrees, addr Ex2Array, LENGTHOF Ex2Array						; invoke the FindLargest procedure with array num 2
	call WriteDec															; display a decimal to the console output
	call Crlf																; display a single line

	call Crlf																; display a single line
	mov edx, OFFSET ArrayDisplay											; offset the address of the string
	call WriteString														; display to the console output
	invoke DisplayArray, addr Ex3Array, LENGTHOF Ex3Array					; invoke the DisplayArray procedure with array num 3
	call Crlf																; display a single line

	invoke FindThrees, addr Ex3Array, LENGTHOF Ex3Array						; invoke the FindLargest procedure with array num 3
	call WriteDec															; display a decimal to the console output
	call Crlf																; display a single line

exit

main endp

FindThrees proc uses esi ecx,
	ptrArray: PTR SDWORD,													; points to the array
	szArray: SDWORD															; array size

	mov esi, ptrArray														; address of the array
	mov ecx, szArray														; size of the array
	mov ebx, 0																; set the counter to 0

L1:																			; begin the loop
	mov eax, [esi]															; move the array element
	cmp eax, 3																; compare the element with the number 3
	je CountThrees															; if equal then jump to increase the count
	jne ResetCount															; if not equal jump to reset the count to 0
	add esi, TYPE SDWORD													; point to the next element
	loop L1																	; keep looping

	jmp ReturnToCaller														; jump to the return state

ReturnZero:																	; state to save the register to 0 if not found three number 3s consecutive.
	mov eax, 0																; save the register to 0
	mov edx, OFFSET NotFoundMsg												; offset the address of the string
	call WriteString														; display to the console output
	call Crlf																; display a single line
	jmp ReturnToCaller														; jump to the return state

ReturnOne:																	; state to save the register to 1 if found three number 3s consecutive.
	mov eax, 1																; save the register to 1
	mov edx, OFFSET FoundMsg												; offset the address of the string
	call WriteString														; display to the console output
	call Crlf																; display a single line
	jmp ReturnToCaller														; jump to the return state

CountThrees:																; state to increase the counter if the number three is found.
	inc ebx																	; increment the count
	add esi, TYPE SDWORD													; point to the next element.
	loop L1																	; keep looping
	jmp IdentifyReturnValue													; jump to the state to determine the return value

ResetCount:																	; state to reset the counter to 0
	cmp ebx, 3																; compare the counter with the number 3																
	jge ReturnOne															; if greater or equal than 3, then jump to return the value of 1
	mov ebx, 0																; reset the counter to 0
	add esi, TYPE SDWORD													; point to the next element
	loop L1																	; keep looping
	jmp IdentifyReturnValue													; jump to the state to determine the return value													

IdentifyReturnValue:														; state to determine the return value
	cmp ebx, 3																; compare the counter with the number 3		
	jge ReturnOne															; if greater or equal than 3, then jump to return the value of 1
	jl ReturnZero															; if less than 3, then jump to return the value of 0

ReturnToCaller:																; state to return back to the calling procedure
	mov edx, OFFSET ReturnCode												; offset the address of the string
	call WriteString														; display to the console output
    ret																		; return to the calling procedure

FindThrees	 endp

DisplayArray proc uses eax esi ecx,
	ptrArray: PTR SDWORD,													; points to the array
	szArray: SDWORD															; array size

	mov esi, ptrArray														; address of the array
	mov ecx, szArray														; size of the array

L1:
	mov eax, [esi]															; save the element into the array
	call WriteInt															; display the array element to the console
	mov al, 9																; 9 is the value of TAB
	call WriteChar															; display the TAB between elements
	add esi, TYPE SDWORD													; move to the next element
	loop L1																	; keep looping

	ret																		; return to the calling procedure

DisplayArray endp

end main