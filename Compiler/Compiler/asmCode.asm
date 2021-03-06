	.386
_STACK	SEGMENT STACK USE16
	DB 3FFEh DUP(?)
TOS	DW ?
_STACK	ENDS
_DATA	SEGMENT 'DATA' USE16
a	DD 0
b	DD 0
_DATA	ENDS
_TEXT	SEGMENT 'CODE' USE16
	ASSUME CS: _TEXT, DS: _DATA
program	PROC NEAR
	PUSH	BP
	MOV	BP, SP
	SUB	SP, 16
	MOV	AX, 0
	MOV	CX, [BP+6]
	MOV	BX, CX
	MOV	DX, [BP+4]
	ADD	BX, DX
	MOV	[BP-2], AX
	MOV	AX, [BP+8]
	CMP	AX, BX
	JG	L5
	JMP	L10
L5:
	MOV	[BP+8], AX
	MOV	AX, CX
	PUSH	AX
	IMUL	DX
	MOV	[BP-6], BX
	MOV	BX, AX
	ADD	BX, 1
	MOV	[BP+6], CX
	MOV	[BP+4], DX
	MOV	DX, [BP+8]
	MOV	CX, DX
	ADD	CX, BX
	MOV	[BP-8], AX
	MOV	AX, CX
	JMP	L11
L10:
	MOV	[BP-6], BX
	MOV	BX, AX
L11:
	MOV	[BP-4], BX
	MOV	[BP-10], BX
	MOV	BX, [BP-2]
	CMP	BX, 100
	JLE	L13
	MOV	[BP-2], BX
	JMP	L17
L13:
	MOV	[BP-12], CX
	MOV	CX, 2
	PUSH	AX
	IMUL	CX
	MOV	[BP+8], DX
	MOV	DX, BX
	ADD	DX, AX
	MOV	BX, DX
	MOV	[BP-2], BX
	POP	AX
	JMP	L11
L17:
	MOV	[BP-4], AX
	MOV	AX, BX
	MOV	SP, BP
	POP	BP
	RET	6
program	ENDP
demo	PROC NEAR
	PUSH	BP
	MOV	BP, SP
	SUB	SP, 4
	MOV	BX, [BP+4]
	MOV	AX, BX
	ADD	AX, 2
	MOV	BX, AX
	MOV	[BP-2], AX
	MOV	AX, BX
	MOV	CX, 2
	PUSH	AX
	IMUL	CX
	MOV	SP, BP
	POP	BP
	RET	2
demo	ENDP
Start:
	MOV	AX, _DATA
	MOV	DS, AX
	CLI
	MOV	AX, _STACK
	MOV	SS, AX
	MOV	SP, Offset TOS
	STI
	PUSH	BP
	MOV	BP, SP
	SUB	SP, 10
	MOV	AX, 3
	MOV	BX, 4
	MOV	CX, 2
	PUSH	AX
	PUSH	BX
	PUSH	CX
	MOV	[BP-2], AX
	CALL	demo
	PUSH	AX
	MOV	[BP-10], AX
	CALL	program
	MOV	DX, AX
	MOV	AX, 4C00h
	INT	21h
_TEXT ENDS
	END Start
