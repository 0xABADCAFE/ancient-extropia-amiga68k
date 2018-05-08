;//****************************************************************************//
;//**                                                                        **//
;//**  File:          Int64Arith.asm ($NAME=Int64Arith.asm)                  **//
;//**                                                                        **//
;//**  Description:   JASMINE code execution routines, MC68040+              **//
;//**  Comment(s):    64 bit Integer arithmetic operations                   **//
;//**                                                                        **//
;//**  First Started: 2002-08-04                                             **//
;//**  Last Updated:  2002-08-24                                             **//
;//**                                                                        **//
;//**  Author(s):     Karl Churchill                                         **//
;//**                                                                        **//
;//**  Copyright:     (C)1998-2002, eXtropia Studios                         **//
;//**                 Serkan YAZICI, Karl Churchill                          **//
;//**                 All Rights Reserved.                                   **//
;//**                                                                        **//
;//****************************************************************************//

	INCDIR  "Extropialib:prj/VM2/Jasmine/M680x0"
	INCLUDE "Jasmine.i"

	XDEF	fADD_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSUB_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fMUL_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fDIV_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fMOD_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fMUL_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fDIV_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fMOD_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fNEG_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSHL_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSHR_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	;// re use arithmetic shift left for logical given that func is same
	XDEF	fSHL_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//////////////////////////////////////////////////////////////////////////////

	SECTION ":0",CODE

;void JASMINE_OP::fADD_I64(OP_ARGS);

	CNOP	0,8
fADD_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		ADD_I64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		ADD_I64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		ADD_I64_OP1_SMALL_LITERAL

ADD_I64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_I64_DONE_OP1

ADD_I64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		ADD_I64_DONE_OP1

ADD_I64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		ADD_I64_DONE_OP1

ADD_I64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
ADD_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		ADD_I64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		ADD_I64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		ADD_I64_OP2_SMALL_LITERAL

ADD_I64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_I64_DONE_OP2

ADD_I64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		ADD_I64_DONE_OP2

ADD_I64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		ADD_I64_DONE_OP2

ADD_I64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
ADD_I64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	jsr		Add64	; // d0/d1 = d0/d1 + d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		ADD_I64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		ADD_I64_OP3_REG_INDIRECT

ADD_I64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

ADD_I64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
ADD_I64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fSUB_I64(OP_ARGS);

	CNOP	0,8
fSUB_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SUB_I64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SUB_I64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		SUB_I64_OP1_SMALL_LITERAL

SUB_I64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_I64_DONE_OP1

SUB_I64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		SUB_I64_DONE_OP1

SUB_I64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		SUB_I64_DONE_OP1

SUB_I64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
SUB_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SUB_I64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SUB_I64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		SUB_I64_OP2_SMALL_LITERAL

SUB_I64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_I64_DONE_OP2

SUB_I64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		SUB_I64_DONE_OP2

SUB_I64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		SUB_I64_DONE_OP2

SUB_I64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
SUB_I64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	exg		d0,d2
	exg		d1,d3
	jsr		Sub64	; // d0/d1 = d0/d1 - d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SUB_I64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SUB_I64_OP3_REG_INDIRECT

SUB_I64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

SUB_I64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
SUB_I64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fMUL_I64(OP_ARGS);

	CNOP	0,8
fMUL_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MUL_S64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MUL_S64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		MUL_S64_OP1_SMALL_LITERAL

MUL_S64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_S64_DONE_OP1

MUL_S64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		MUL_S64_DONE_OP1

MUL_S64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		MUL_S64_DONE_OP1

MUL_S64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
MUL_S64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MUL_S64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MUL_S64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		MUL_S64_OP2_SMALL_LITERAL

MUL_S64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_S64_DONE_OP2

MUL_S64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		MUL_S64_DONE_OP2

MUL_S64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		MUL_S64_DONE_OP2

MUL_S64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
MUL_S64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	jsr		SMult64	; // d0/d1 = d0/d1 * d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MUL_S64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MUL_S64_OP3_REG_INDIRECT

MUL_S64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

MUL_S64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
MUL_S64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fDIV_I64(OP_ARGS);

	CNOP	0,8
fDIV_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		DIV_S64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		DIV_S64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		DIV_S64_OP1_SMALL_LITERAL

DIV_S64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_S64_DONE_OP1

DIV_S64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		DIV_S64_DONE_OP1

DIV_S64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		DIV_S64_DONE_OP1

DIV_S64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
DIV_S64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		DIV_S64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		DIV_S64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		DIV_S64_OP2_SMALL_LITERAL

DIV_S64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_S64_DONE_OP2

DIV_S64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		DIV_S64_DONE_OP2

DIV_S64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		DIV_S64_DONE_OP2

DIV_S64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
DIV_S64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d0,d4
	or.l		d1,d4
	bne.b		DIV_S64_DENOMINATOR_VALID

	move.l	#JASMINE_MATH_DIVBYZERO, JASMINE_exitReg(a2)
	rts
	
DIV_S64_DENOMINATOR_VALID
	exg		d0,d2
	exg		d1,d3
	jsr		SDiv64	; // d0/d1 = d0/d1 / d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		DIV_S64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		DIV_S64_OP3_REG_INDIRECT

DIV_S64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

DIV_S64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
DIV_S64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fMOD_I64(OP_ARGS);

	CNOP	0,8
fMOD_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MOD_S64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MOD_S64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		MOD_S64_OP1_SMALL_LITERAL

MOD_S64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_S64_DONE_OP1

MOD_S64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		MOD_S64_DONE_OP1

MOD_S64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		MOD_S64_DONE_OP1

MOD_S64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
MOD_S64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MOD_S64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MOD_S64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		MOD_S64_OP2_SMALL_LITERAL

MOD_S64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_S64_DONE_OP2

MOD_S64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		MOD_S64_DONE_OP2

MOD_S64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		MOD_S64_DONE_OP2

MOD_S64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
MOD_S64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d0,d4
	or.l		d1,d4
	bne.b		MOD_S64_DENOMINATOR_VALID

	move.l	#JASMINE_MATH_DIVBYZERO, JASMINE_exitReg(a2)
	rts
	
MOD_S64_DENOMINATOR_VALID
	exg		d0,d2
	exg		d1,d3
	jsr		SMod64	; // d0/d1 = d0/d1 % d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MOD_S64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MOD_S64_OP3_REG_INDIRECT

MOD_S64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

MOD_S64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
MOD_S64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fMUL_U64(OP_ARGS);

	CNOP	0,8
fMUL_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MUL_U64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MUL_U64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		MUL_U64_OP1_SMALL_LITERAL

MUL_U64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_U64_DONE_OP1

MUL_U64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		MUL_U64_DONE_OP1

MUL_U64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		MUL_U64_DONE_OP1

MUL_U64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
MUL_U64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MUL_U64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MUL_U64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		MUL_U64_OP2_SMALL_LITERAL

MUL_U64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_U64_DONE_OP2

MUL_U64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		MUL_U64_DONE_OP2

MUL_U64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		MUL_U64_DONE_OP2

MUL_U64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
MUL_U64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	jsr		UMult64	; // d0/d1 = d0/d1 * d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MUL_U64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MUL_U64_OP3_REG_INDIRECT

MUL_U64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

MUL_U64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
MUL_U64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fDIV_U64(OP_ARGS);

	CNOP	0,8
fDIV_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		DIV_U64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		DIV_U64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		DIV_U64_OP1_SMALL_LITERAL

DIV_U64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_U64_DONE_OP1

DIV_U64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		DIV_U64_DONE_OP1

DIV_U64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		DIV_U64_DONE_OP1

DIV_U64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
DIV_U64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		DIV_U64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		DIV_U64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		DIV_U64_OP2_SMALL_LITERAL

DIV_U64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_U64_DONE_OP2

DIV_U64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		DIV_U64_DONE_OP2

DIV_U64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		DIV_U64_DONE_OP2

DIV_U64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
DIV_U64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d0,d4
	or.l		d1,d4
	bne.b		DIV_U64_DENOMINATOR_VALID

	move.l	#JASMINE_MATH_DIVBYZERO, JASMINE_exitReg(a2)
	rts
	
DIV_U64_DENOMINATOR_VALID
	exg		d0,d2
	exg		d1,d3
	jsr		UDiv64	; // d0/d1 = d0/d1 / d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		DIV_U64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		DIV_U64_OP3_REG_INDIRECT

DIV_U64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

DIV_U64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
DIV_U64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fMOD_U64(OP_ARGS);

	CNOP	0,8
fMOD_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MOD_U64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MOD_U64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		MOD_U64_OP1_SMALL_LITERAL

MOD_U64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_U64_DONE_OP1

MOD_U64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		MOD_U64_DONE_OP1

MOD_U64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		MOD_U64_DONE_OP1

MOD_U64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
MOD_U64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MOD_U64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MOD_U64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		MOD_U64_OP2_SMALL_LITERAL

MOD_U64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_U64_DONE_OP2

MOD_U64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		MOD_U64_DONE_OP2

MOD_U64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		MOD_U64_DONE_OP2

MOD_U64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
MOD_U64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d0,d4
	or.l		d1,d4
	bne.b		MOD_U64_DENOMINATOR_VALID

	move.l	#JASMINE_MATH_DIVBYZERO, JASMINE_exitReg(a2)
	rts
	
MOD_U64_DENOMINATOR_VALID
	exg		d0,d2
	exg		d1,d3
	jsr		UMod64	; // d0/d1 = d0/d1 % d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		MOD_U64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		MOD_U64_OP3_REG_INDIRECT

MOD_U64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

MOD_U64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
MOD_U64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fNEG_I64(OP_ARGS);

	CNOP	0,8
fNEG_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		NEG_I64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		NEG_I64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		NEG_I64_OP1_SMALL_LITERAL

NEG_I64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		NEG_I64_DONE_OP1

NEG_I64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		NEG_I64_DONE_OP1

NEG_I64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		NEG_I64_DONE_OP1

NEG_I64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
NEG_I64_DONE_OP1
	move.l	(a0),d0
	move.l	4(a0),d1
	jsr		Neg64;
	move.l	d0,d2
	move.l	d1,d3

	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		NEG_I64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		NEG_I64_OP2_REG_INDIRECT

NEG_I64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

NEG_I64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
NEG_I64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fSHL_I64(OP_ARGS);
;void JASMINE_OP::fSHL_X64(OP_ARGS);

	CNOP	0,8
fSHL_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHL_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SHL_S64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SHL_S64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		SHL_S64_OP1_SMALL_LITERAL

SHL_S64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHL_S64_DONE_OP1

SHL_S64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		SHL_S64_DONE_OP1

SHL_S64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		SHL_S64_DONE_OP1

SHL_S64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
SHL_S64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SHL_S64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SHL_S64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		SHL_S64_OP2_SMALL_LITERAL

SHL_S64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHL_S64_DONE_OP2

SHL_S64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		SHL_S64_DONE_OP2

SHL_S64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		SHL_S64_DONE_OP2

SHL_S64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
SHL_S64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	exg		d0,d2
	exg		d1,d3
	jsr		lib_64bit_shl	; // d0/d1 = d0/d1 << d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SHL_S64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SHL_S64_OP3_REG_INDIRECT

SHL_S64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

SHL_S64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
SHL_S64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fSHR_I64(OP_ARGS);

	CNOP	0,8
fSHR_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SHR_S64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SHR_S64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		SHR_S64_OP1_SMALL_LITERAL

SHR_S64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_S64_DONE_OP1

SHR_S64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		SHR_S64_DONE_OP1

SHR_S64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		SHR_S64_DONE_OP1

SHR_S64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
SHR_S64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SHR_S64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SHR_S64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		SHR_S64_OP2_SMALL_LITERAL

SHR_S64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_S64_DONE_OP2

SHR_S64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		SHR_S64_DONE_OP2

SHR_S64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		SHR_S64_DONE_OP2

SHR_S64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
SHR_S64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	exg		d0,d2
	exg		d1,d3
	jsr		lib_64bit_shrS	; // d0/d1 = d0/d1 >> d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SHR_S64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SHR_S64_OP3_REG_INDIRECT

SHR_S64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

SHR_S64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
SHR_S64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts


;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////

