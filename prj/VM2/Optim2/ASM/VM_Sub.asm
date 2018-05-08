
;//////////////////////////////////////////////////////////////////////////////
;//
;//  VM_Sub.asm
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

	XDEF	fSUB_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSUB_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSUB_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSUB_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSUB_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fSUB_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO SUB_INT.x sizeof(x)
;//
;//  x = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		SUB_INT
	move.l	OFS_instPtr(a2),a4
	moveq		#\1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SUB_INT_OP1_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_INT_DONE_OP1\@

SUB_INT_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

SUB_INT_DONE_OP1\@
	move.\0	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SUB_INT_OP2_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_INT_DONE_OP2\@

SUB_INT_OP2_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

SUB_INT_DONE_OP2\@
	sub.\0	(a0),d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SUB_INT_OP3_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_INT_DONE_OP3\@

SUB_INT_OP3_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

SUB_INT_DONE_OP3\@
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM


;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO SUB_FLT.x sizeof(x)
;//
;//  x = s/d
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		SUB_FLT
	move.l	OFS_instPtr(a2),a4
	moveq		#\1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SUB_FLT_OP1_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_FLT_DONE_OP1\@

SUB_FLT_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

SUB_FLT_DONE_OP1\@
	fmove.\0	(a0),fp0
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SUB_FLT_OP2_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_FLT_DONE_OP2\@

SUB_FLT_OP2_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

SUB_FLT_DONE_OP2\@
	fsub.\0	(a0),fp0
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SUB_FLT_OP3_REG_DIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_FLT_DONE_OP3\@

SUB_FLT_OP3_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

SUB_FLT_DONE_OP3\@
	fmove.\0	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM

	SECTION ":0",CODE


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

;//void VMCORE::SUB_I8(CMDARGS)

	CNOP	0,8

fSUB_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SUB_INT.b	1
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SUB_I16(CMDARGS)

	CNOP	0,8

fSUB_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SUB_INT.w	2
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SUB_I32(CMDARGS)

	CNOP	0,8

fSUB_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SUB_INT.l	4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SUB_I64(CMDARGS)

	CNOP	0,8

fSUB_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SUB_I64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_I64_DONE_OP1

SUB_I64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

SUB_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SUB_I64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_I64_DONE_OP2

SUB_I64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

SUB_I64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	exg		d0,d2
	exg		d1,d3
	jsr		Sub64	; // d0/d1 = d0/d1 - d2/d3
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SUB_I64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		SUB_I64_DONE_OP3

SUB_I64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

SUB_I64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SUB_F32(CMDARGS)

	CNOP	0,8

fSUB_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SUB_FLT.s	4
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::SUB_F64(CMDARGS)

	CNOP	0,8

fSUB_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SUB_FLT.d	8
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

