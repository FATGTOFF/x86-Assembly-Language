COMMENT /
 Description:
	Boolean Calculator
	Create a program that functions as a simple boolean 
	calculator for 32-bit integers.  It should display a 
	menu that asks the user to make a selection 
	from the following list:
		1. x AND y
		2. x OR y
		3. NOT x
		4. x XOR y
		5. Exit program
	When the user makes a choice, call a procedure that 
	displays the name of the operation about to be performed. 
	You must implement this procedure using the Table-Driven 
	Selection technique, shown in Section 6.5.4.
	• AND_op: Prompt the user for two hexadecimal 
	integers. AND them together and display the result in hexadecimal.
	• OR_op: Prompt the user for two hexadecimal integers. OR them 
	together and display the result in hexadecimal.
	• NOT_op: Prompt the user for a hexadecimal integer. NOT the 
	integer and display the result in hexadecimal.
	• XOR_op: Prompt the user for two hexadecimal integers. 
	Exclusive-OR them together and display the result in hexadecimal.
	Creator: Carlos Vazquez
	Date Created : 6 November 2015
/ Course : CISS 360A

INCLUDE Irvine32.inc

.data
	CaseTable	BYTE '1'									; lookup value
				DWORD	Procedure_AND						; address of procedure
	EntrySize = ($ - CaseTable)								; substract the offset from the current location counter
				BYTE '2'									; lookup value
				DWORD	Procedure_OR						; address of procedure
				BYTE '3'									; lookup value
				DWORD	Procedure_NOT						; address of procedure
				BYTE '4'									; lookup value
				DWORD	Procedure_XOR						; address of procedure

	NumberOfEntries = ($ - CaseTable) / EntrySize			; calculate the number of entries

															; Choices for the menu to display
	menuTitle BYTE "Boolean Calculator", 0					; menu title
	option1	BYTE "1. x AND y", 0							; option 1 choice
	option2	BYTE "2. x OR y", 0								; option 2 choice
	option3 BYTE "3. NOT x", 0								; option 3 choice
	option4 BYTE "4. x XOR y", 0							; option 4 choice
	option5 BYTE "5. Exit Program", 0						; option 5 choice
	askUser BYTE "Make a choice: ", 0						; ask the user to make a choice
	
	value DWORD ?											; Variable to be used to move among register

															; Define a separate message for each procedure.
	msg1 BYTE "Procedure_AND", 0							; procedure AND
	msg2 BYTE "Procedure_OR", 0								; procedure OR
	msg3 BYTE "Procedure_NOT", 0							; procedure NOT
	msg4 BYTE "Procedure_XOR", 0							; procedure XOR
	
	askChoice	BYTE "Input an hexadecimal integer: ", 0	; ask user to input data
	ansChoice	BYTE "The answer is: ", 0					; display answer to the user

.code
main proc
	
	call displayMenu										; call the procedure to display the meu
	mov ebx, OFFSET CaseTable								; point ebx to the table
	mov ecx, NumberOfEntries								; loop counter
L1:
	cmp al, [ebx]											; match found?
	jne L2													; if no, then continue
	call NEAR PTR [ebx + 1]									; if yes, call  the procedure [page 218]
	call Crlf												; create one empty line
	jmp L3													; jump to exit at L3
L2:
	add ebx, EntrySize										; go to the next option.
	loop L1													; keep looping 
L3:
	exit													; exit the program (same as Invoke Exitprocess, 0)
	
main endp

displayMenu proc

	mov edx, OFFSET menuTitle								; display the menu title
	call WriteString										; output to console application
	call Crlf												; create a single line
	mov edx, OFFSET option1									; display the option 1
	call WriteString										; output to console application
	call Crlf												; create a single line
	mov edx, OFFSET option2									; display the option 2
	call WriteString										; output to console application
	call Crlf												; create a single line
	mov edx, OFFSET option3									; display the option 3
	call WriteString										; output to console application
	call Crlf												; create a single line
	mov edx, OFFSET option4									; display the option 4
	call WriteString										; output to console application
	call Crlf												; create a single line
	mov edx, OFFSET option5									; display the option 5
	call WriteString										; output to console application
	call Crlf												; create a single line
	mov edx, OFFSET askUser									; ask the user to make a choice
	call WriteString										; output it to the console application
	call ReadChar											; obtain the character input from the user
	ret														; return to the calling procedure

displayMenu endp

Procedure_AND proc

	mov edx, OFFSET msg1									; display the user the procedure choice made.
	call WriteString										; output to the console application
	call Crlf												; create a single line
	mov edx, OFFSET askChoice								; ask the user to input a value
	call WriteString										; output to the console application
	call ReadHex											; obtain the hexadecimal input from the user
	mov value, eax											; save the input value into the variable.	
	call WriteString										; output to the console application
	call ReadHex											; obtain the hexadecimal input from the user
	and eax, value											; perform the AND operation among the two values
	mov edx, OFFSET ansChoice								; display the calculated answer
	call WriteString										; output to the console application
	call WriteHex											; output the value in the hexadecimal format
	ret														; return to the calling procedure

Procedure_AND endp

Procedure_OR proc

	mov edx, OFFSET msg2									; display the user the procedure choice made.
	call WriteString										; output to the console application
	call Crlf												; create a single line
	mov edx, OFFSET askChoice								; ask the user to input a value
	call WriteString										; output to the console application
	call ReadHex											; obtain the hexadecimal input from the user
	mov value, eax											; save the input value into the variable.	
	call WriteString										; output to the console application
	call ReadHex											; obtain the hexadecimal input from the user
	or eax, value											; perform the OR operation among the two values
	mov edx, OFFSET ansChoice								; display the calculated answer
	call WriteString										; output to the console application
	call WriteHex											; output the value in the hexadecimal format
	ret														; return to the calling procedure

Procedure_OR endp

Procedure_NOT proc

	mov edx, OFFSET msg3									; display the user the procedure choice made.
	call WriteString										; output to the console application
	call Crlf												; create a single line
	mov edx, OFFSET askChoice								; ask the user to input a value
	call WriteString										; output to the console application
	call ReadHex											; obtain the hexadecimal input from the user
	not eax													; perform the NOT operation among the two values
	mov edx, OFFSET ansChoice								; display the calculated answer
	call WriteString										; output to the console application
	call WriteHex											; output the value in the hexadecimal format
	ret														; return to the calling procedure

Procedure_NOT endp

Procedure_XOR proc

	mov edx, OFFSET msg4									; display the user the procedure choice made.
	call WriteString										; output to the console application
	call Crlf												; create a single line
	mov edx, OFFSET askChoice								; ask the user to input a value
	call WriteString										; output to the console application
	call ReadHex											; obtain the hexadecimal input from the user
	mov value, eax											; save the input value into the variable.	
	call WriteString										; output to the console application
	call ReadHex											; obtain the hexadecimal input from the user
	xor eax, value											; perform the XOR operation among the two values
	mov edx, OFFSET ansChoice								; display the calculated answer
	call WriteString										; output to the console application
	call WriteHex											; output the value in the hexadecimal format
	ret														; return to the calling procedure

Procedure_XOR endp

end main




