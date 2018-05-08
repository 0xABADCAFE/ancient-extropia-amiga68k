
;//////////////////////////////////////////////////////////////////////////////
;//
;//  VM_ShArith.asm
;//  
;//  EXTREME WARNING
;//
;//  All handcoded VMCORE methods use the full register space of the
;//  68K CPU. Do not use any handcoded methods in conjunction with the
;//  standard VMCORE::Execute() method - critical registers will be trashed!!
;//
;//////////////////////////////////////////////////////////////////////////////

	INCDIR  "Extropialib:prj/VM2/Optim2/ASM"
	INCLUDE "VM.inc"

	XDEF	fAND_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fAND_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fAND_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fAND_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fOR_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fOR_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fOR_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fOR_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fXOR_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fXOR_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fXOR_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fXOR_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fINV_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fINV_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fINV_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fINV_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHL_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHL_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHL_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHL_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHR_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHR_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHR_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHR_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip


;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO LOP.x op, sizeof(x)
;//
;//  x = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		LOP
	move.l	OFS_instPtr(a2),a4
	moveq		#\2,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		LOP_OP1_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		LOP_DONE_OP1\@

LOP_OP1_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

LOP_DONE_OP1\@
	move.\0	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		LOP_OP2_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		LOP_DONE_OP2\@

LOP_OP2_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

LOP_DONE_OP2\@
	\1.\0		(a0),d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		LOP_OP3_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		LOP_DONE_OP3\@

LOP_OP3_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

LOP_DONE_OP3\@
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM


;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO XOR.x sizeof(x)
;//
;//  x = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		XOR
	move.l	OFS_instPtr(a2),a4
	moveq		#\1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		XOR_OP1_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		XOR_DONE_OP1\@

XOR_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

XOR_DONE_OP1\@
	move.\0	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		XOR_OP2_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		XOR_DONE_OP2\@

XOR_OP2_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

XOR_DONE_OP2\@
	move.\0	(a0),d3
	eor.\0	d3,d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		XOR_OP3_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		XOR_DONE_OP3\@

XOR_OP3_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

XOR_DONE_OP3\@
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM


;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO SHFT.x l/r sizeof(x)
;//
;//  x = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		SHFT
	move.l	OFS_instPtr(a2),a4
	moveq		#\2,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHFT_OP1_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHFT_DONE_OP1\@

SHFT_OP1_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

SHFT_DONE_OP1\@
	move.\0	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHFT_OP2_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHFT_DONE_OP2\@

SHFT_OP2_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

SHFT_DONE_OP2\@
	move.\0	(a0),d3
	ls\1.\0	d3,d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHFT_OP3_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHFT_DONE_OP3\@

SHFT_OP3_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

SHFT_DONE_OP3\@
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM


;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO NOT_INT.x sizeof(x)
;//
;//  x = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		NOT_INT
	move.l	OFS_instPtr(a2),a4
	moveq		#\1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		NOT_INT_OP1_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		NOT_INT_DONE_OP1\@

NOT_INT_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

NOT_INT_DONE_OP1\@
	move.\0	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		NOT_INT_OP2_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		NOT_INT_DONE_OP2\@

NOT_INT_OP2_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

NOT_INT_DONE_OP2\@
	not.\0	d2
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM


	SECTION ":0",CODE


;//  void VMCORE::AND_X8(CMDARGS)
fAND_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	LOP.b	and,1
	rts

;//  void VMCORE::AND_X16(CMDARGS)
fAND_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	LOP.w	and,2
	rts

;//  void VMCORE::AND_X32(CMDARGS)
fAND_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	LOP.l	and,4
	rts

;//  void VMCORE::AND_X64(CMDARGS)
fAND_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		AND_X64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		AND_X64_DONE_OP1

AND_X64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

AND_X64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		AND_X64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		AND_X64_DONE_OP2

AND_X64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

AND_X64_DONE_OP2
	and.l		(a0),d2
	and.l		4(a0),d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		AND_X64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		AND_X64_DONE_OP3

AND_X64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

AND_X64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

;//  void VMCORE::OR_X8(CMDARGS)
fOR_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	LOP.b	or,1
	rts

;//  void VMCORE::OR_X16(CMDARGS)
fOR_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	LOP.w	or,2
	rts

;//  void VMCORE::OR_X32(CMDARGS)
fOR_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	LOP.l	or,4
	rts

;//  void VMCORE::OR_X64(CMDARGS)
fOR_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		OR_X64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		OR_X64_DONE_OP1

OR_X64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

OR_X64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		OR_X64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		OR_X64_DONE_OP2

OR_X64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

OR_X64_DONE_OP2
	or.l		(a0),d2
	or.l		4(a0),d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		OR_X64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		OR_X64_DONE_OP3

OR_X64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

OR_X64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//  void VMCORE::XOR_X8(CMDARGS)
fXOR_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	XOR.b	1
	rts

;//  void VMCORE::XOR_X16(CMDARGS)
fXOR_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	XOR.w	2
	rts

;//  void VMCORE::XOR_X32(CMDARGS)
fXOR_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	XOR.l	4
	rts

;//  void VMCORE::XOR_X64(CMDARGS)
fXOR_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		XOR_X64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		XOR_X64_DONE_OP1

XOR_X64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

XOR_X64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		XOR_X64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		XOR_X64_DONE_OP2

XOR_X64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

XOR_X64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	eor.l		d0,d2
	eor.l		d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		XOR_X64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		XOR_X64_DONE_OP3

XOR_X64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

XOR_X64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//  void VMCORE::INV_X8(CMDARGS)
fINV_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	NOT.b	1
	rts
	
;//  void VMCORE::INV_X16(CMDARGS)
fINV_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	NOT.w	2
	rts

;//  void VMCORE::INV_X32(CMDARGS)
fINV_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	NOT.l	4
	rts

;//  void VMCORE::INV_X64(CMDARGS)
fINV_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		INV_X64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		INV_X64_DONE_OP1

INV_X64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

INV_X64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	not.l		d2
	not.l		d3

	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		INV_X64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		INV_X64_DONE_OP2

INV_X64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

INV_X64_DONE_OP2
	move.l	d2, (a0)
	move.l	d3, 4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//  void VMCORE::SHL_X8(CMDARGS)
fSHL_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SHFT.b	l,1
	rts

;//  void VMCORE::SHL_X16(CMDARGS)
fSHL_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SHFT.w	l,2
	rts

;//  void VMCORE::SHL_X32(CMDARGS)
fSHL_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SHFT.l	l,4
	rts

;//  void VMCORE::SHL_X64(CMDARGS)
fSHL_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHL_X64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHL_X64_DONE_OP1

SHL_X64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHL_X64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHL_X64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHL_X64_DONE_OP2

SHL_X64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHL_X64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	exg		d0,d2
	exg		d1,d3
	jsr		lib_64bit_shl	;// d0/d1 = d0/d1 << d2/d3
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHL_X64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHL_X64_DONE_OP3

SHL_X64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHL_X64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//  void VMCORE::SHR_X8(CMDARGS)
fSHR_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SHFT.b	r,1
	rts

;//  void VMCORE::SHR_X16(CMDARGS)
fSHR_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SHFT.w	r,2
	rts

;//  void VMCORE::SHR_X32(CMDARGS)
fSHR_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SHFT.l	r,4
	rts

;//  void VMCORE::SHR_X64(CMDARGS)
fSHR_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHR_X64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_X64_DONE_OP1

SHR_X64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHR_X64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHR_X64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_X64_DONE_OP2

SHR_X64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHR_X64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	exg		d0,d2
	exg		d1,d3
	jsr		lib_64bit_shr	;// d0/d1 = d0/d1 >> d2/d3
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHR_X64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_X64_DONE_OP3

SHR_X64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHR_X64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

	END
