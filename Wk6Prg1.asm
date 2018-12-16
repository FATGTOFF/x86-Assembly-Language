COMMENT /
 Description:
	Encryption Using Rotate Operations
	Write a procedure that performs simple encryption by rotating each plaintext byte a varying
	number of positions in different directions. For example, in the following array that represents
	the encryption key, a negative value indicates a rotation to the left and a positive value indicates
	a rotation to the right. The integer in each position indicates the magnitude of the rotation:
	key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
	Your procedure should loop through a plaintext message and align the key to the first 10 bytes of
	the message. Rotate each plaintext byte by the amount indicated by its matching key array value.
	Then, align the key to the next 10 bytes of the message and repeat the process. Write a program
	that tests your encryption procedure by calling it twice, with different data sets.
	Creator: Carlos Vazquez
	Date Created : 6 November 2015
/ Course : CISS 360A

INCLUDE Irvine32.inc

.data
	key1 BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
	keySize = $ - key1
	key2 BYTE -3, -4, 1, 0, -3, 5, 2, -4, -4, 6
	plainText1 BYTE "This is the first secret message, which will be encrypted", 0
	plainText2 BYTE "This is the second secret message, which will be encrypted", 0
	keyCounter BYTE 0


.code
main proc

	mov edx, OFFSET plainText1				; set the string for output
	call WriteString						; output the string to the console
	call Crlf								; clear single line
	mov esi, OFFSET plainText1				; load the register to the beginning of the array
	mov edi, OFFSET key1					; load the register to the beggining of the key
	mov ebx, edi							; save the location of the pointer to the ebx register for reset the location later.
	mov ecx, LENGTHOF plainText1			; save the length of the string to count each one to encrypt
	call encryptMessage						; call the procedure to encrypt
	call WriteString						; display the encryption to the console

	call Crlf								; clear single line
	call Crlf								; clear single line

	mov edx, OFFSET plainText2				; set the string for output
	call WriteString						; output the string to the console
	call Crlf								; clear single line
	mov esi, OFFSET plainText2				; load the register to the beginning of the array
	mov edi, OFFSET key2					; load the register to the beggining of the key
	mov ebx, edi							; save the location of the pointer to the ebx register for reset the location later.
	mov ecx, LENGTHOF plainText2			; save the length of the string to count each one to encrypt
	call encryptMessage						; call the procedure to encrypt
	call WriteString						; display the encryption to the console
	call Crlf								; clear single line

exit
main endp

encryptMessage proc

L1:
	push ecx								; preserve the main counter into the register
	mov cl, BYTE PTR[edi]					; save the key value into the register
	inc edi									; increment to the next array
	ror BYTE PTR[esi], cl					; rotate the key into the single character of the string
	inc esi									; increment to the next string character
	mov eax, edi							; save the location of the next key in the array to the register
	mov keyCounter, al						; save the location of the next key into the memory

	cmp keyCounter, keySize					; compare the number of elements in the key array with the size of the key array
	je resetPtr								; if equal, then go to the expression to reset the pointer
	pop ecx									; release the counter from the register

	cmp BYTE PTR[esi], 0					; check if the string reach the null terminator
	je returnToCaller						; if yes, then return to the calling procedure.

	loop L1									; keep looping
	
	cmp ecx, 0								; check if the ecx register reach 0
	jz returnToCaller						; if zero, then return to the calling procedure

resetPtr:									; expression to reset the key pointer to 0
	mov edi, ebx							; reset the pointer to the original position
	pop ecx									; release the counter from the register
	cmp ecx, 0								; check if the ecx register reach 0								
	jne L1									; continue to loop if the ecx register is not 0
	jmp returnToCaller						; jump to return to the calling procedure

returnToCaller:								; return to the caller expression
	ret										; return to the calling procedure

encryptMessage endp							; end the encrypt message procedure

end main