COMMENT /
 Description:
	Chess Board
	Write a program that draws an 8 x 8 chess board, with alternating gray and white squares. You
	can use the SetTextColor and Gotoxy procedures from the Irvine32 library. Avoid the use of global
	variables, and use declared parameters in all procedures. Use short procedures that are
	focused on a single task.
	Creator: Carlos Vazquez
	Date Created : 6 November 2015
/ Course : CISS 360A
INCLUDE Irvine32.inc

; procedure prototypes
SetColor PROTO foreColor:BYTE, backColor:BYTE
DrawColorChar PROTO char:BYTE, foreColor:BYTE, backColor:BYTE
DisplayOddRows PROTO color:BYTE
DisplayEvenRows PROTO color:BYTE

.data
	rowSize WORD 8										
	colSize WORD 8
	numCharsPerSquare WORD 2

.code
main proc
	
	mov dx, 0											; clear dividend, high
	mov ax, rowSize
	mov cx, numCharsPerSquare
	div cx
	movzx ecx, ax

L1:
	invoke DisplayOddRows, gray
	call Crlf
	invoke DisplayEvenRows, gray
	call Crlf
	invoke SetColor, lightGray, black
	loop L1

exit
main endp

DisplayOddRows proc uses ecx,
	color:BYTE
	
	mov dx, 0											; clear dividend, high
	mov ax, colSize
	mov cx, numCharsPerSquare
	div cx
	movzx ecx, ax

L1:
	invoke DrawColorChar, ' ', color, color
	invoke DrawColorChar, ' ', color, color
	invoke DrawColorChar, ' ', white, white
	invoke DrawColorChar, ' ', white, white
	loop L1

	ret

DisplayOddRows endp

DisplayEvenRows proc uses ecx,
	color:BYTE
	
	mov dx, 0											; clear dividend, high
	mov ax, colSize
	mov cx, numCharsPerSquare
	div cx
	movzx ecx, ax

L1:
	invoke DrawColorChar, ' ', white, white
	invoke DrawColorChar, ' ', white, white
	invoke DrawColorChar, ' ', color, color
	invoke DrawColorChar, ' ', color, color
	loop L1

	ret

DisplayEvenRows endp

DrawColorChar proc uses eax,
	char:BYTE, foreColor: BYTE, backColor: BYTE,

	invoke SetColor, foreColor, backColor
	mov al, char
	call WriteChar

	ret
DrawColorChar endp

SetColor proc,
	foreColor:BYTE, backColor:BYTE
	
		movzx eax, backColor
		shl eax, 4
		or al, foreColor
		call SetTextColor
		ret

SetColor endp
end main