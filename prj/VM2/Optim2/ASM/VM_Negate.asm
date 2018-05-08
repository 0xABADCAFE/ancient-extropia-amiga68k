
;//////////////////////////////////////////////////////////////////////////////
;//
;//  VM_Negate.asm
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

	XDEF	fNEG_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fNEG_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fNEG_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fNEG_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fNEG_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fNEG_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip


;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO NEG_INT.x sizeof(x)
;//
;//  x = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		NEG_INT
	move.l	OFS_instPtr(a2),a4
	moveq		#\1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		NEG_INT_OP1_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		NEG_INT_DONE_OP1\@

NEG_INT_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

NEG_INT_DONE_OP1\@
	move.\0	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		NEG_INT_OP2_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		NEG_INT_DONE_OP2\@

NEG_INT_OP2_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

NEG_INT_DONE_OP2\@
	neg.\0	d2
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM


;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO NEG_FLT.x sizeof(x)
;//
;//  x = s/d
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		NEG_FLT
	move.l	OFS_instPtr(a2),a4
	moveq		#\1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		NEG_FLT_OP1_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		NEG_FLT_DONE_OP1\@

NEG_FLT_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

NEG_FLT_DONE_OP1\@
	fmove.\0	(a0),fp0
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		NEG_FLT_OP2_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		NEG_FLT_DONE_OP2\@

NEG_FLT_OP2_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

NEG_FLT_DONE_OP2\@
	fneg.\0	fp0
	fmove.\0	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM

	SECTION ":0",CODE


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::NEG_I8(CMDARGS)

	CNOP	0,8

fNEG_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	NEG_INT.b	1
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::NEG_I16(CMDARGS)

	CNOP	0,8

fNEG_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	NEG_INT.w	2
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::NEG_I32(CMDARGS)

	CNOP	0,8

fNEG_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	NEG_INT.l	4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::NEG_I64(CMDARGS)

	CNOP	0,8

fNEG_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		NEG_I64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		NEG_I64_DONE_OP1

NEG_I64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

NEG_I64_DONE_OP1
	move.l	(a0),d0
	move.l	4(a0),d1
	jsr		Neg64
	move.l	d0,d2
	move.l	d1,d3
		
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		NEG_I64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		NEG_I64_DONE_OP2

NEG_I64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

NEG_I64_DONE_OP2
	move.l	d2, (a0)
	move.l	d3, 4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::NEG_F32(CMDARGS)

	CNOP	0,8

fNEG_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	NEG_FLT.s	4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::NEG_F64(CMDARGS)

	CNOP	0,8

fNEG_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	NEG_FLT.d	8
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

