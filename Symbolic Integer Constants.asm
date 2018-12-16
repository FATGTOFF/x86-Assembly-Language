COMMENT /
 Description:
Symbolic Integer Constants
Write a program that defines symbolic 
constants for all seven days of the week. 
Create an array variable that uses the 
symbols as initializers.
 Creator: Carlos Vazquez
 Date Created: 6 November 2015
/Course: CISS 360A

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	MONDAY = 1
	TUESDAY = 2
	WEDNESDAY = 3
	THURSDAY = 4
	FRIDAY = 5
	SATURDAY = 6
	SUNDAY = 7

	weekdays BYTE MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY

.code
main proc

	mov	ah,MONDAY
	mov ah,TUESDAY
	mov ah,WEDNESDAY
	mov ah,THURSDAY
	mov	ah,FRIDAY
	mov	ah,SATURDAY
	mov	ah,SUNDAY
		
	invoke ExitProcess,0
main endp
end main