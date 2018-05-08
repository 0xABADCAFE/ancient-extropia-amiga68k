
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

	XDEF	fSHL_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHL_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHL_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHL_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHR_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHR_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHR_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSHR_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip


;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO SH_INT.x l/r sizeof(x)
;//
;//  x = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////


	MACRO		SH_INT
	move.l	OFS_instPtr(a2),a4
	moveq		#\2,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SH_INT_OP1_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SH_INT_DONE_OP1\@

SH_INT_OP1_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

SH_INT_DONE_OP1\@
	move.\0	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SH_INT_OP2_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SH_INT_DONE_OP2\@

SH_INT_OP2_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

SH_INT_DONE_OP2\@
	move.\0	(a0),d3
	as\1.\0	d3,d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SH_INT_OP3_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SH_INT_DONE_OP3\@

SH_INT_OP3_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

SH_INT_DONE_OP3\@
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM


	SECTION ":0",CODE


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SHL_I8(CMDARGS)

	CNOP	0,8

fSHL_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SH_INT.b	l,1
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SHL_I16(CMDARGS)

	CNOP	0,8

fSHL_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SH_INT.w	l,2
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SHL_I32(CMDARGS)

	CNOP	0,8

fSHL_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SH_INT.l	l,4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SHL_I64(CMDARGS)

	CNOP	0,8

fSHL_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHL_I64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHL_I64_DONE_OP1

SHL_I64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHL_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHL_I64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHL_I64_DONE_OP2

SHL_I64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHL_I64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	exg		d0,d2
	exg		d1,d3
	jsr		lib_64bit_shl	;// d0/d1 = d0/d1 << d2/d3
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHL_I64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHL_I64_DONE_OP3

SHL_I64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHL_I64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SHR_I8(CMDARGS)

	CNOP	0,8

fSHR_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SH_INT.b	r,1
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SHR_I16(CMDARGS)

	CNOP	0,8

fSHR_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SH_INT.w	r,2
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SHR_I32(CMDARGS)

	CNOP	0,8

fSHR_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SH_INT.l	r,4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SHR_I64(CMDARGS)

	CNOP	0,8

fSHR_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHR_I64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_I64_DONE_OP1

SHR_I64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHR_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHR_I64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_I64_DONE_OP2

SHR_I64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHR_I64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	exg		d0,d2
	exg		d1,d3
	jsr		lib_64bit_shrS	;// d0/d1 = d0/d1 >> d2/d3
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SHR_I64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SHR_I64_DONE_OP3

SHR_I64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

SHR_I64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

