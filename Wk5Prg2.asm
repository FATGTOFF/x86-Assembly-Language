COMMENT /
 Description:
	College Registration
	• Recode the logic using CMP and conditional jump instructions (instead of the .IF and
	.ELSEIF directives).
	• Perform range checking on the credits value; it cannot be less than 1 or greater than 30. If an
	invalid entry is discovered, display an appropriate error message.
	• Prompt the user for the grade average and credits values.
	• Display a message that shows the outcome of the evaluation, such as “The student can register”
	or “The student cannot register”.
	Creator: Carlos Vazquez
	Date Created : 6 November 2015
/ Course : CISS 360A

INCLUDE Irvine32.inc

.data
	TRUE = 1
	FALSE = 0
	minGradesInputValue WORD 0								; minimun grade allowed to input
	maxGradesInputValue WORD 400							; maximum grade allowed to input
	minGradesToRegister WORD 250							; minimum grade average to register to college

	minCreditValue WORD 1									; minimum credit allowed to input
	maxCreditValue WORD 30									; maximum credit allowed to input
	minCreditToRegister WORD 12								; minimum credit to register to college

	OkToRegister  BYTE ?									; variable to determine if the student can register or not

	promptGradeAvg	BYTE "Enter the grade average: ", 0
	promptGradesError BYTE "Your input is incorrect. Input must be between 0 and 400.>>> ", 0
	promptCreditsVal BYTE "Enter the credits values: ", 0
	promptCreditError BYTE "Your input is incorrect. Input must be between 1 and 30.>>> ", 0
	promptOKRegister BYTE "The student can register", 0
	promptNotOKRegister BYTE "The student cannot register", 0
	promptNotifyMinReqs BYTE "Both requirements must be met to register [Minimum Grade: 250 and Minimum Credit: 12]", 0

.code
main PROC

	mov OkToRegister, TRUE									; set the variable to true
	mov bl, OkToRegister									; set the register value to true
	mov edx, OFFSET promptNotifyMinReqs						; notify the user of the minimum requirements
	call WriteString										; print the notification on the console output
	call Crlf												; create a single line
	jmp InputGradesValue									; jump to begin to input the values


InputGradesValue:
	mov edx, OFFSET promptGradeAvg							; ask the user to input the grade average
	call WriteString										; display to the console output
	call ReadDec											; input the value from the user
	cmp ax, minGradesInputValue								; compare the user value with the minimum input allowed
	jb ValidateGradesInput									; if the user input is less than allowed, jump to validate
	cmp ax, maxGradesInputValue								; compare the user value with the maximum input allowed
	ja ValidateGradesInput									; if the user input is more than allowed, jump to validate
	cmp ax, minGradesToRegister								; compare the user value with the minimum value grade average to register
	jae InputCreditValue									; if the value meets the minimum requirements, then jump to input the credit
	mov OKToRegister, FALSE									; set the registration variable to false due to not meeting the minimum requirements
	jmp DenyRegistration									; jump to notify the user that the student did not meet the min requirements

InputCreditValue:
	mov edx, OFFSET promptCreditsVal						; ask the user to input the number of credits
	call WriteString										; display the question to the console output
	call ReadDec											; input the value from the user
	cmp ax, minCreditValue									; compare the user value with the minimum input allowed
	jb ValidateCreditInput									; if the user input is less than allowed, jump to validate
	cmp ax, maxCreditValue									; compare the user value with the maximum input allowed
	ja ValidateCreditInput									; if the user input is more than allowed, jump to validate
	cmp ax, minCreditToRegister								; compare the user value with the minimum value college credits to register
	jb DenyRegistration										; if the value is less than the minimum credits to register, then jump deny the registration
	mov OKToRegister, TRUE									; set the registration variable to true due to meeting the minimum requirements
	jmp ApproveRegistration									; jump to notify the user that the student met the min requirements

ValidateGradesInput:
	mov edx, OFFSET promptGradesError						; notify the user the input is not valid
	call WriteString										; display the message to the console output
	call Crlf												; create a single line												
	jmp InputGradesValue									; jump to ask the user to input the value

ValidateCreditInput:
	mov edx, OFFSET promptCreditError						; notify the user the input is not valid
	call WriteString										; display the message to the console output
	call Crlf												; create a single line		
	jmp InputCreditValue									; jump to ask the user to input the value

DenyRegistration:
	mov edx, OFFSET promptNotOKRegister						; notify the user the student cannot register
	call WriteString										; print the notification on the console output
	call Crlf												; create a single line
	mov edx, OFFSET promptNotifyMinReqs						; notify the user of the minimum requirements
	call WriteString										; print the notification on the console output
	jmp ExitProgram											; jump to exit the program

ApproveRegistration:
	mov edx, OFFSET promptOKRegister						; notify the user the student can register
	call WriteString										; print the notification on the console output
	jmp ExitProgram											; jump to exit the program

ExitProgram:
	exit

main endp
end main




