COMMENT /
Description:
Str_concat
Write a procedure named Str_concat 
that concatenates a source string 
to the end of a target string. Sufficient 
space must exist in the target string to 
accommodate the new characters. Pass
pointers to the source and target strings. 
Here is a sample call:
.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0
.code
INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

Creator: Carlos Vazquez
Date Created: 18 December 2015
Course: CISS 360A
/

; Set the standard directives to run the program on 32 bit.
include Irvine32.inc
Str_concat PROTO, target:PTR BYTE, source:PTR BYTE

.data
message1 BYTE "I will display the targetStr", 0
message2 BYTE "I will display the sourceStr", 0
message3 BYTE "I will display the concatenate strings by calling Str_concat", 0
targetStr BYTE "ABCDE",10 dup(0)
sourceStr BYTE "FGH",0

COMMENT /
****************************************************
The main procedure will notify the user the current
targetStr. Then it will notify the user the current
sourceStr. Then it will call the Str_concat procedure
to combine both strings together. Then it will notify
the user the concatenated strings.
/*****************************************************
.code
main proc

  mov edx, OFFSET message1
  call WriteString
  call Crlf
  mov edx, OFFSET targetStr
  call WriteString
  call Crlf

  mov edx, OFFSET message2
  call WriteString
  call Crlf
  mov edx, OFFSET sourceStr
  call WriteString
  call Crlf

  mov edx, OFFSET message3
  call WriteString
  call Crlf
  INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

  mov edx, OFFSET targetStr
  call WriteString
  call Crlf

  exit
main endp


Str_concat PROC, target: PTR BYTE, source: PTR BYTE
COMMENT /
****************************************************
The Str_concat procedure will use the EAX, ECX, ESI,
EDI, EBX registers to move the bytes of the string into
the registers. It will use a loop to increment the EAX
and ESI registers to check the bytes of the strings
to concatenate.
/*****************************************************

  mov eax, 5
  mov ecx, LENGTHOF source
  mov esi, source
  mov edi, target

L1:
  add edi, eax
  mov ebx, [esi]
  mov [edi], ebx
  mov al, 0

  loop L1

  ;mov al, 0

  ret

Str_concat endp

END main