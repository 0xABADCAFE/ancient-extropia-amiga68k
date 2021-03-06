
;//////////////////////////////////////////////////////////////////////////////
;//
;//  VM_Mul.asm
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
	
	XDEF	fMUL_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMUL_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMUL_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMUL_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMUL_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMUL_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SECTION ":0",CODE


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

;//void VMCORE::MUL_I8(CMDARGS)

	CNOP	0,8

fMUL_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I8_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I8_DONE_OP1

MUL_I8_OP1_REG_DIRECT
	lea		7(a2,d5.l*8),a0

MUL_I8_DONE_OP1
	move.b	(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I8_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I8_DONE_OP2

MUL_I8_OP2_REG_DIRECT
	lea		7(a2,d5.l*8),a0

MUL_I8_DONE_OP2
	move.b	(a0),d2
	ext.w		d3
	ext.w		d2
	muls		d3,d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I8_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I8_DONE_OP3

MUL_I8_OP3_REG_DIRECT
	lea		7(a2,d5.l*8),a0

MUL_I8_DONE_OP3
	move.b	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MUL_I16(CMDARGS)

	CNOP	0,8

fMUL_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#2,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I16_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I16_DONE_OP1

MUL_I16_OP1_REG_DIRECT
	lea		6(a2,d5.l*8),a0

MUL_I16_DONE_OP1
	move.w	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I16_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I16_DONE_OP2

MUL_I16_OP2_REG_DIRECT
	lea		6(a2,d5.l*8),a0

MUL_I16_DONE_OP2
	muls		(a0),d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I16_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I16_DONE_OP3

MUL_I16_OP3_REG_DIRECT
	lea		6(a2,d5.l*8),a0

MUL_I16_DONE_OP3
	move.w	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MUL_I32(CMDARGS)

	CNOP	0,8

fMUL_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#4,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I32_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I32_DONE_OP1

MUL_I32_OP1_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MUL_I32_DONE_OP1
	move.l	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I32_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I32_DONE_OP2

MUL_I32_OP2_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MUL_I32_DONE_OP2
	muls.l	(a0),d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I32_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I32_DONE_OP3

MUL_I32_OP3_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MUL_I32_DONE_OP3
	move.l	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MUL_I64(CMDARGS)

	CNOP	0,8

fMUL_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I64_DONE_OP1

MUL_I64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

MUL_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I64_DONE_OP2

MUL_I64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

MUL_I64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	jsr		SMult64	; // d0/d1 = d0/d1 * d2/d3
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_I64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_I64_DONE_OP3

MUL_I64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

MUL_I64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MUL_F32(CMDARGS)

	CNOP	0,8

fMUL_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#4,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_F32_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_F32_DONE_OP1

MUL_F32_OP1_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MUL_F32_DONE_OP1
	fmove.s	(a0),fp0
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_F32_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_F32_DONE_OP2

MUL_F32_OP2_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MUL_F32_DONE_OP2
	fmul.s	(a0),fp0
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_F32_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_F32_DONE_OP3

MUL_F32_OP3_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MUL_F32_DONE_OP3
	fmove.s	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MUL_F64(CMDARGS)

	CNOP	0,8

fMUL_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

MUL_F64
	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_F64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_F64_DONE_OP1

MUL_F64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

MUL_F64_DONE_OP1
	fmove.d	(a0),fp0
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_F64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_F64_DONE_OP2

MUL_F64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

MUL_F64_DONE_OP2
	fmul.d	(a0),fp0
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MUL_F64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MUL_F64_DONE_OP3

MUL_F64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

MUL_F64_DONE_OP3
	fmove.d	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

