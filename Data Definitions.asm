COMMENT /
 Description:
 Data Definitions
	Write a program that contains a 
	definition of each data type listed 
	in Table 3-2 in Section 3.4. Initialize 
	each variable to a value that is 
	consistent with its data type.
 Creator: Carlos Vazquez
 Date Created: 6 November 2015
/Course: CISS 360A

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	ByteValue	BYTE	'C'
	SByteValue	SBYTE	-128
	WordValue	WORD	65535
	SWordValue	SWORD	-32768
	DWordValue	DWORD	12345687h
	SDWordalue	SDWORD	-12345678
	FWordValue	FWORD	?
	QWordValue	QWORD	1234567812345678h
	TByteValue	TBYTE	800000000000001234h
	Real4Value	REAL4	-1.6
	Real8Value	REAL8	2.5E-259
	Real10Value	REAL10	4.6E+4090

.code
main proc

	
	invoke ExitProcess,0
main endp
end main