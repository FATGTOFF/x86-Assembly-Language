COMMENT /
 Description:
	Prime Numbers
	Write a program that generates all prime numbers between 2 and 1000, using the Sieve of Eratosthenes
	method. You can find many articles that describe the method for finding primes in this
	manner on the Internet. Display all the prime values.
	Creator: Carlos Vazquez
	Date Created : 6 November 2015
/ Course : CISS 360A
INCLUDE Irvine32.inc


FIRST_PRIME = 2
LAST_PRIME = 1000

.data
	sieve BYTE LAST_PRIME DUP (0)

.code
main proc

	mov esi, FIRST_PRIME

COMMENT \
	jmp WhileLoop

WhileLoop:
	cmp sieve[esi], 0
	jne WhileLoop
	call CrossOutMultiples

	inc esi

\

.WHILE ESI < LAST_PRIME
	.IF sieve[esi] == 0
		call CrossOutMultiples
	.ENDIF
	inc ESI
	.ENDW

    call PrintPrimes

exit
main endp

COMMENT / 
************************************************************************
This CrossOutMultiples procedures push two register, the eax and the esi,
to maintain their values. It will copy the value from the esi to the eax.
Then, it will add it to the register. It uses the L1 loop to compare the
esi register to the last prime. If the esi and the last prime number is 
the same, then it will jump to the L2 loop, which will pop the two 
registers, the esi and the eax.
Recieves: None
Returns: None
/***********************************************************************
CrossOutMultiples proc

    push EAX
    push ESI
    mov EAX, ESI
    add ESI, EAX

L1:
    cmp ESI, LAST_PRIME
    ja  L2
    mov sieve[ESI], 1
    add ESI, EAX
    jmp L1

L2:
    pop ESI
    pop EAX
    ret 

CrossOutMultiples	 ENDP

COMMENT / 
************************************************************************
This PrintPrimes procedure copy the value 1 to the esi, the value 0 to
the eax, and the last prime number to the ecx register. This procedure
uses the L1 loop to move the sieve value to the al register. It uses the
if statement to identify if the sieve value has multiple values, if it
doesnt, then it will copy the esi register to the eax and print the value
to the screen.
Recieves: None
Returns: None
/***********************************************************************
PrintPrimes PROC  

    mov esi, 1
    mov eax, 0
    mov ecx, LAST_PRIME

L1:  
     mov al, sieve[ESI]
    .IF al == 0
	   mov EAX, ESI
	   call WriteDec
	   call CRLF
    .ENDIF
    inc ESI
Loop L1

    ret

PrintPrimes ENDP
end main