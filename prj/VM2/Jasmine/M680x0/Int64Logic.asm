;//****************************************************************************//
;//**                                                                        **//
;//**  File:          Int64Logic.asm ($NAME=Int64Logic.asm)                  **//
;//**                                                                        **//
;//**  Description:   JASMINE code execution routines, MC68040+              **//
;//**  Comment(s):    64-bit Integer logic operations                        **//
;//**                                                                        **//
;//**  First Started: 2002-08-04                                             **//
;//**  Last Updated:  2002-09-15                                             **//
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

	XDEF	fAND_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fXOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fINV_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//XDEF	fSHL_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSHR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//////////////////////////////////////////////////////////////////////////////

	SECTION ":0",CODE

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fAND_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		AND_X64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		AND_X64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		AND_X64_OP1_SMALL_LITERAL

AND_X64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	(a0),d2
	move.l	4(a0),d3
	bra.b		AND_X64_DONE_OP1

AND_X64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	moveq		#0,d2
	move.l	d5,d3
	bra.b		AND_X64_DONE_OP1

AND_X64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	bra.b		AND_X64_DONE_OP1

AND_X64_OP1_REG_DIRECT
	move.l	JASMINE_gpRegs(a2,d5.w*8),d2
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d3
	
AND_X64_DONE_OP1
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		AND_X64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		AND_X64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		AND_X64_OP2_SMALL_LITERAL

AND_X64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	and.l		(a0),d2
	and.l		4(a0),d3
	bra.b		AND_X64_DONE_OP2

AND_X64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	and.l		d5,d2
	moveq		#0,d3
	bra.b		AND_X64_DONE_OP2

AND_X64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	and.l		(a0),d2
	and.l		4(a0),d3
	bra.b		AND_X64_DONE_OP2

AND_X64_OP2_REG_DIRECT
	and.l		JASMINE_gpRegs(a2,d5.w*8),d2
	and.l		JASMINE_gpRegs+4(a2,d5.w*8),d3
	
AND_X64_DONE_OP2
	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		AND_X64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		AND_X64_OP3_REG_INDIRECT

AND_X64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

AND_X64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
AND_X64_OP3_REG_DIRECT
	move.l	d2, JASMINE_gpRegs(a2,d5.w*8)
	move.l	d3, JASMINE_gpRegs+4(a2,d5.w*8)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		OR_X64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		OR_X64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		OR_X64_OP1_SMALL_LITERAL

OR_X64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	(a0),d2
	move.l	4(a0),d3
	bra.b		OR_X64_DONE_OP1

OR_X64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	moveq		#0,d2
	move.l	d5,d3
	bra.b		OR_X64_DONE_OP1

OR_X64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	bra.b		OR_X64_DONE_OP1

OR_X64_OP1_REG_DIRECT
	move.l	JASMINE_gpRegs(a2,d5.w*8),d2
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d3
	
OR_X64_DONE_OP1
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		OR_X64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		OR_X64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		OR_X64_OP2_SMALL_LITERAL

OR_X64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	or.l		(a0),d2
	or.l		4(a0),d3
	bra.b		OR_X64_DONE_OP2

OR_X64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	or.l		d5,d2
	bra.b		OR_X64_DONE_OP2

OR_X64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	or.l		(a0),d2
	or.l		4(a0),d3
	bra.b		OR_X64_DONE_OP2

OR_X64_OP2_REG_DIRECT
	or.l		JASMINE_gpRegs(a2,d5.w*8),d2
	or.l		JASMINE_gpRegs+4(a2,d5.w*8),d3
	
OR_X64_DONE_OP2
	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		OR_X64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		OR_X64_OP3_REG_INDIRECT

OR_X64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

OR_X64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
OR_X64_OP3_REG_DIRECT
	move.l	d2, JASMINE_gpRegs(a2,d5.w*8)
	move.l	d3, JASMINE_gpRegs+4(a2,d5.w*8)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fXOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		XOR_X64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		XOR_X64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		XOR_X64_OP1_SMALL_LITERAL

XOR_X64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	(a0),d2
	move.l	4(a0),d3
	bra.b		XOR_X64_DONE_OP1

XOR_X64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	moveq		#0,d2
	move.l	d5,d3
	bra.b		XOR_X64_DONE_OP1

XOR_X64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	bra.b		XOR_X64_DONE_OP1

XOR_X64_OP1_REG_DIRECT
	move.l	JASMINE_gpRegs(a2,d5.w*8),d2
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d3
	
XOR_X64_DONE_OP1
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		XOR_X64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		XOR_X64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		XOR_X64_OP2_SMALL_LITERAL

XOR_X64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	(a0),d0
	move.l	4(a0),d1
	bra.b		XOR_X64_DONE_OP2

XOR_X64_OP2_SMALL_LITERAL
	and.b		#$1F,d5
	moveq		#0,d0
	moveq		#0,d1
	move.b	d5,d1
	bra.b		XOR_X64_DONE_OP2

XOR_X64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	(a0),d0
	move.l	4(a0),d1
	bra.b		XOR_X64_DONE_OP2

XOR_X64_OP2_REG_DIRECT
	move.l	JASMINE_gpRegs(a2,d5.w*8),d0
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d1
	
XOR_X64_DONE_OP2
	eor.l		d0,d2
	eor.l		d1,d3
	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		XOR_X64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		XOR_X64_OP3_REG_INDIRECT

XOR_X64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

XOR_X64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
XOR_X64_OP3_REG_DIRECT
	move.l	d2, JASMINE_gpRegs(a2,d5.w*8)
	move.l	d3, JASMINE_gpRegs+4(a2,d5.w*8)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fINV_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		INV_X64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		INV_X64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		INV_X64_OP1_SMALL_LITERAL

INV_X64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	(a0),d2
	move.l	(a0),d3
	bra.b		INV_X64_DONE_OP1

INV_X64_OP1_SMALL_LITERAL
	moveq		#0,d3
	move.l	d5,d3
	and.l		#$1F, d3
	bra.b		INV_X64_DONE_OP1

INV_X64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	a0,d2
	move.l	4(a0),d3
	bra.b		INV_X64_DONE_OP1

INV_X64_OP1_REG_DIRECT
	move.l	JASMINE_gpRegs(a2,d5.w*8),d2
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d3
	
INV_X64_DONE_OP1
	not.l		d2
	not.l		d3

	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		INV_X64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		INV_X64_OP2_REG_INDIRECT

INV_X64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

INV_X64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
INV_X64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fSHR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SHR_X64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SHR_X64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		SHR_X64_OP1_SMALL_LITERAL

SHR_X64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_X64_DONE_OP1

SHR_X64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		SHR_X64_DONE_OP1

SHR_X64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		SHR_X64_DONE_OP1

SHR_X64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
SHR_X64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SHR_X64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SHR_X64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		SHR_X64_OP2_SMALL_LITERAL

SHR_X64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_X64_DONE_OP2

SHR_X64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		SHR_X64_DONE_OP2

SHR_X64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		SHR_X64_DONE_OP2

SHR_X64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
SHR_X64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	exg		d0,d2
	exg		d1,d3
	jsr		lib_64bit_shr	; // d0/d1 = d0/d1 >> d2/d3
	move.l	d0,d2
	move.l	d1,d3

	move.b	3(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		SHR_X64_OP3_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		SHR_X64_OP3_REG_INDIRECT

SHR_X64_OP3_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

SHR_X64_OP3_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
SHR_X64_OP3_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
