;//****************************************************************************//
;//**                                                                        **//
;//**  File:          Flow.asm ($NAME=Flow.asm)                              **//
;//**                                                                        **//
;//**  Description:   JASMINE code execution routines, MC68040+              **//
;//**  Comment(s):    Branch / call routines                                 **//
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
	INCLUDE "Flow.i"

	XDEF	fNOP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fEND__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fLEA__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBRA__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBNEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBNEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBNEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBNEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBNEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBNEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLS_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLS_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLS_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLS_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLS_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLS_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLSEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLSEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLSEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLSEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLSEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBLSEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGREQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGREQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGREQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGREQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGREQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGREQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGR_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGR_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGR_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGR_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGR_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fBGR_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;	XDEF	fCALL__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fRET__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//////////////////////////////////////////////////////////////////////////////

	SECTION ":0",CODE

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fNOP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	addq.l	#4, JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	
	CNOP	0,8
fEND__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	#JASMINE_END_OF_CODE, JASMINE_exitReg(a2)
	rts

	CNOP	0,8
fLEA__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	addq.l	#4, JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

	CNOP	0,8
fBRA__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	CHECKBREAK
;//	move.l	JASMINE_instPtr(a2),a1
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a4
	move.l	a4,JASMINE_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBNEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I b, ne

	CNOP	0,8
fBNEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I w, ne

	CNOP	0,8
fBNEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I l, ne

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBNEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BNEQ_I64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BNEQ_I64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BNEQ_I64_OP1_SMALL_LITERAL

BNEQ_I64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BNEQ_I64_DONE_OP1

BNEQ_I64_OP1_SMALL_LITERAL
	and.b		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BNEQ_I64_DONE_OP1

BNEQ_I64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BNEQ_I64_DONE_OP1

BNEQ_I64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BNEQ_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BNEQ_I64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BNEQ_I64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BNEQ_I64_OP2_SMALL_LITERAL

BNEQ_I64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BNEQ_I64_DONE_OP2

BNEQ_I64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BNEQ_I64_DONE_OP2

BNEQ_I64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BNEQ_I64_DONE_OP2

BNEQ_I64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BNEQ_I64_DONE_OP2
	cmp.l		(a0),d2
	bne.b		BNEQ_I64_TAKE_BRANCH
	cmp.l		4(a0),d3
	bne.b		BNEQ_I64_TAKE_BRANCH
	addq.l	#8,JASMINE_instPtr(a2)
;//	addq		#8,a4
	rts

;//////////////////////////////////////////////////////////////////////////////
	
BNEQ_I64_TAKE_BRANCH	
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a4
	move.l	a4,JASMINE_instPtr(a2)
	rts

	CNOP	0,8
fBNEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F s, ne
	
	CNOP	0,8
fBNEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F d, ne
	
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBLS_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I b, lt

	CNOP	0,8
fBLS_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I w, lt

	CNOP	0,8
fBLS_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I l, lt

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBLS_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BLS_I64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BLS_I64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BLS_I64_OP1_SMALL_LITERAL

BLS_I64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BLS_I64_DONE_OP1

BLS_I64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BLS_I64_DONE_OP1

BLS_I64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BLS_I64_DONE_OP1

BLS_I64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BLS_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BLS_I64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BLS_I64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BLS_I64_OP2_SMALL_LITERAL

BLS_I64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BLS_I64_DONE_OP2

BLS_I64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BLS_I64_DONE_OP2

BLS_I64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BLS_I64_DONE_OP2

BLS_I64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BLS_I64_DONE_OP2
	cmp.l		(a0),d2
	bgt.b		BLS_I64_SKIP_BRANCH
	bne.b		BLS_I64_TAKE_BRANCH
	cmp.l		4(a0),d3
	bhs.b		BLS_I64_SKIP_BRANCH
	
BLS_I64_TAKE_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a4
	move.l	a4,JASMINE_instPtr(a2)
	rts

BLS_I64_SKIP_BRANCH	
	addq.l	#8,JASMINE_instPtr(a2)
;//	addq		#8,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBLS_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F s, lt
	
	CNOP	0,8
fBLS_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F d, lt
	
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBLSEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I b, le

	CNOP	0,8
fBLSEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I w, le

	CNOP	0,8
fBLSEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I l, le


;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBLSEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BLSEQ_I64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BLSEQ_I64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BLSEQ_I64_OP1_SMALL_LITERAL

BLSEQ_I64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BLSEQ_I64_DONE_OP1

BLSEQ_I64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BLSEQ_I64_DONE_OP1

BLSEQ_I64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BLSEQ_I64_DONE_OP1

BLSEQ_I64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BLSEQ_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BLSEQ_I64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BLSEQ_I64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BLSEQ_I64_OP2_SMALL_LITERAL

BLSEQ_I64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BLSEQ_I64_DONE_OP2

BLSEQ_I64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BLSEQ_I64_DONE_OP2

BLSEQ_I64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BLSEQ_I64_DONE_OP2

BLSEQ_I64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BLSEQ_I64_DONE_OP2
	cmp.l		(a0),d2
	bgt.b		BLSEQ_I64_SKIP_BRANCH
	bne.b		BLSEQ_I64_TAKE_BRANCH
	cmp.l		4(a0),d3
	bhi.b		BLSEQ_I64_SKIP_BRANCH
	
BLSEQ_I64_TAKE_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a4
	move.l	a4,JASMINE_instPtr(a2)
	rts

BLSEQ_I64_SKIP_BRANCH	
	addq.l	#8,JASMINE_instPtr(a2)
;//	addq		#8,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBLSEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F s, le
	
	CNOP	0,8
fBLSEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F d, le
	
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I b, eq

	CNOP	0,8
fBEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I w, eq

	CNOP	0,8
fBEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I l, eq

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BEQ_I64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BEQ_I64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BEQ_I64_OP1_SMALL_LITERAL

BEQ_I64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BEQ_I64_DONE_OP1

BEQ_I64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BEQ_I64_DONE_OP1

BEQ_I64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BEQ_I64_DONE_OP1

BEQ_I64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BEQ_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BEQ_I64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BEQ_I64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BEQ_I64_OP2_SMALL_LITERAL

BEQ_I64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BEQ_I64_DONE_OP2

BEQ_I64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BEQ_I64_DONE_OP2

BEQ_I64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BEQ_I64_DONE_OP2

BEQ_I64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BEQ_I64_DONE_OP2
	cmp.l		(a0),d2
	bne.b		BEQ_I64_SKIP_BRANCH
	cmp.l		4(a0),d3
	bne.b		BEQ_I64_SKIP_BRANCH

BEQ_I64_TAKE_BRANCH	
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a4
	move.l	a4,JASMINE_instPtr(a2)
	rts

BEQ_I64_SKIP_BRANCH	
	addq.l	#8,JASMINE_instPtr(a2)
;//	addq		#8,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F s, eq
	
	CNOP	0,8
fBEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F d, eq
	
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBGREQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I b, ge

	CNOP	0,8
fBGREQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I w, ge

	CNOP	0,8
fBGREQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I l, ge


;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBGREQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BGREQ_I64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BGREQ_I64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BGREQ_I64_OP1_SMALL_LITERAL

BGREQ_I64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BGREQ_I64_DONE_OP1

BGREQ_I64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BGREQ_I64_DONE_OP1

BGREQ_I64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BGREQ_I64_DONE_OP1

BGREQ_I64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BGREQ_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BGREQ_I64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BGREQ_I64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BGREQ_I64_OP2_SMALL_LITERAL

BGREQ_I64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BGREQ_I64_DONE_OP2

BGREQ_I64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BGREQ_I64_DONE_OP2

BGREQ_I64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BGREQ_I64_DONE_OP2

BGREQ_I64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BGREQ_I64_DONE_OP2
	cmp.l		(a0),d2
	blt.b		BGREQ_I64_SKIP_BRANCH
	bne.b		BGREQ_I64_TAKE_BRANCH
	cmp.l		4(a0),d3
	blo.b		BGREQ_I64_SKIP_BRANCH
	
BGREQ_I64_TAKE_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a4
	move.l	a4,JASMINE_instPtr(a2)
	rts

BGREQ_I64_SKIP_BRANCH	
	addq.l	#8,JASMINE_instPtr(a2)
;//	addq		#8,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBGREQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F s, ge
	
	CNOP	0,8
fBGREQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F d, ge
	
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBGR_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I b, gt

	CNOP	0,8
fBGR_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I w, gt

	CNOP	0,8
fBGR_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_I l, gt


;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBGR_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BGR_I64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BGR_I64_OP1_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BGR_I64_OP1_SMALL_LITERAL

BGR_I64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BGR_I64_DONE_OP1

BGR_I64_OP1_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_0(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BGR_I64_DONE_OP1

BGR_I64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BGR_I64_DONE_OP1

BGR_I64_OP1_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BGR_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi		BGR_I64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi		BGR_I64_OP2_REG_INDIRECT
	cmp.w		#EA_smallLiteral,d5
	bge		BGR_I64_OP2_SMALL_LITERAL

BGR_I64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		BGR_I64_DONE_OP2

BGR_I64_OP2_SMALL_LITERAL
	and.w		#$1F, d5
	lea		JASMINE_imReg_1(a2),a0
	clr.l		(a0)
	move.l	d5,4(a0)
	bra.b		BGR_I64_DONE_OP2

BGR_I64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	bra.b		BGR_I64_DONE_OP2

BGR_I64_OP2_REG_DIRECT
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	
BGR_I64_DONE_OP2
	cmp.l		(a0),d2
	blt.b		BGR_I64_SKIP_BRANCH
	bne.b		BGR_I64_TAKE_BRANCH
	cmp.l		4(a0),d3
	bls.b		BGR_I64_SKIP_BRANCH
	
BGR_I64_TAKE_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a4
	move.l	a4,JASMINE_instPtr(a2)
	rts

BGR_I64_SKIP_BRANCH	
	addq.l	#8,JASMINE_instPtr(a2)
;//	addq		#8,a4
	rts

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fBGR_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F s, gt
	
	CNOP	0,8
fBGR_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;//	CHECKBREAK
	BR_F d, gt
	
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
