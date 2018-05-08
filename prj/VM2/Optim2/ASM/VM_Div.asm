
;//////////////////////////////////////////////////////////////////////////////
;//
;//  VM_Div.asm
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
	
	XDEF	fDIV_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fDIV_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fDIV_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fDIV_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fDIV_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fDIV_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOD_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOD_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOD_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOD_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOD_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOD_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SECTION ":0",CODE


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

;//void VMCORE::DIV_I8(CMDARGS)

	CNOP	0,8

fDIV_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I8_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I8_DONE_OP1

DIV_I8_OP1_REG_DIRECT
	lea		7(a2,d5.l*8),a0

DIV_I8_DONE_OP1
	move.b	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I8_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I8_DONE_OP2

DIV_I8_OP2_REG_DIRECT
	lea		7(a2,d5.l*8),a0

DIV_I8_DONE_OP2
	move.b	(a0),d3
	bne		DIV_I8_DENOM_OK
	move.l	#-1,OFS_exitReg(a2)
	rts

DIV_I8_DENOM_OK
	extb.l	d3
	extb.l	d2
	divs		d3,d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I8_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I8_DONE_OP3

DIV_I8_OP3_REG_DIRECT
	lea		7(a2,d5.l*8),a0

DIV_I8_DONE_OP3
	move.b	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts



;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::DIV_I16(CMDARGS)

	CNOP	0,8

fDIV_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#2,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I16_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I16_DONE_OP1

DIV_I16_OP1_REG_DIRECT
	lea		6(a2,d5.l*8),a0

DIV_I16_DONE_OP1
	move.w	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I16_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I16_DONE_OP2

DIV_I16_OP2_REG_DIRECT
	lea		6(a2,d5.l*8),a0

DIV_I16_DONE_OP2
	move.w	(a0),d3
	bne		DIV_I16_DENOM_OK
	move.l	#-1,OFS_exitReg(a2)
	rts

DIV_I16_DENOM_OK
	ext.l		d3
	ext.l		d2
	divs		d3,d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I16_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I16_DONE_OP3

DIV_I16_OP3_REG_DIRECT
	lea		6(a2,d5.l*8),a0

DIV_I16_DONE_OP3
	move.w	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::DIV_I32(CMDARGS)

	CNOP	0,8

fDIV_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#4,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I32_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I32_DONE_OP1

DIV_I32_OP1_REG_DIRECT
	lea		4(a2,d5.l*8),a0

DIV_I32_DONE_OP1
	move.l	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I32_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I32_DONE_OP2

DIV_I32_OP2_REG_DIRECT
	lea		4(a2,d5.l*8),a0

DIV_I32_DONE_OP2
	move.l	(a0),d3
	bne		DIV_I32_DENOM_OK
	move.l	#-1,OFS_exitReg(a2)
	rts

DIV_I32_DENOM_OK
	divsl.l	d3,d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I32_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I32_DONE_OP3

DIV_I32_OP3_REG_DIRECT
	lea		4(a2,d5.l*8),a0

DIV_I32_DONE_OP3
	move.l	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::DIV_I64(CMDARGS)

	CNOP	0,8

fDIV_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I64_DONE_OP1

DIV_I64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

DIV_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I64_DONE_OP2

DIV_I64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

DIV_I64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d0,d4
	or.l		d1,d4
	bne.b		DIV_I64_DENOM_OK
	move.l	#-1,OFS_exitReg(a2)
	rts
	
DIV_I64_DENOM_OK	
	exg		d0,d2
	exg		d1,d3
	jsr		SDiv64	; // d0/d1 = d0/d1 / d2/d3
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_I64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_I64_DONE_OP3

DIV_I64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

DIV_I64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::DIV_F32(CMDARGS)

	CNOP	0,8

fDIV_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#4,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_F32_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_F32_DONE_OP1

DIV_F32_OP1_REG_DIRECT
	lea		4(a2,d5.l*8),a0

DIV_F32_DONE_OP1
	fmove.s	(a0),fp0
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_F32_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_F32_DONE_OP2

DIV_F32_OP2_REG_DIRECT
	lea		4(a2,d5.l*8),a0

DIV_F32_DONE_OP2
	fmove.s	(a0),fp1
	;bne		DIV_F32_DENOM_OK
	;move.l	#-1,OFS_exitReg(a2)
	;rts

DIV_F32_DENOM_OK
	fdiv.s	fp1,fp0
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_F32_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_F32_DONE_OP3

DIV_F32_OP3_REG_DIRECT
	lea		4(a2,d5.l*8),a0

DIV_F32_DONE_OP3
	fmove.s	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::DIV_F64(CMDARGS)

	CNOP	0,8

fDIV_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_F64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_F64_DONE_OP1

DIV_F64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

DIV_F64_DONE_OP1
	fmove.d	(a0),fp0
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_F64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_F64_DONE_OP2

DIV_F64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

DIV_F64_DONE_OP2
	fmove.d	(a0),fp1
	;bne		DIV_F64_DENOM_OK
	;move.l	#-1,OFS_exitReg(a2)
	;rts

DIV_F64_DENOM_OK
	fdiv.d	fp1,fp0
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		DIV_F64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		DIV_F64_DONE_OP3

DIV_F64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

DIV_F64_DONE_OP3
	fmove.d	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MOD_I8(CMDARGS)

	CNOP	0,8

fMOD_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I8_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I8_DONE_OP1

MOD_I8_OP1_REG_DIRECT
	lea		7(a2,d5.l*8),a0

MOD_I8_DONE_OP1
	move.b	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I8_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I8_DONE_OP2

MOD_I8_OP2_REG_DIRECT
	lea		7(a2,d5.l*8),a0

MOD_I8_DONE_OP2
	move.b	(a0),d3
	bne		MOD_I8_DENOM_OK
	move.l	#-1,OFS_exitReg(a2)
	rts

MOD_I8_DENOM_OK
	extb.l	d3
	extb.l	d2
	divs		d3,d2
	swap		d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I8_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I8_DONE_OP3

MOD_I8_OP3_REG_DIRECT
	lea		7(a2,d5.l*8),a0

MOD_I8_DONE_OP3
	move.b	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MOD_I16(CMDARGS)

	CNOP	0,8

fMOD_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#2,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I16_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I16_DONE_OP1

MOD_I16_OP1_REG_DIRECT
	lea		6(a2,d5.l*8),a0

MOD_I16_DONE_OP1
	move.w	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I16_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I16_DONE_OP2

MOD_I16_OP2_REG_DIRECT
	lea		6(a2,d5.l*8),a0

MOD_I16_DONE_OP2
	move.w	(a0),d3
	bne		MOD_I16_DENOM_OK
	move.l	#-1,OFS_exitReg(a2)
	rts

MOD_I16_DENOM_OK
	ext.l		d3
	ext.l		d2
	divs		d3,d2
	swap d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I16_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I16_DONE_OP3

MOD_I16_OP3_REG_DIRECT
	lea		6(a2,d5.l*8),a0

MOD_I16_DONE_OP3
	move.w	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MOD_I32(CMDARGS)

	CNOP	0,8

fMOD_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#4,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I32_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I32_DONE_OP1

MOD_I32_OP1_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MOD_I32_DONE_OP1
	move.l	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I32_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I32_DONE_OP2

MOD_I32_OP2_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MOD_I32_DONE_OP2
	move.l	(a0),d3
	bne		MOD_I32_DENOM_OK
	move.l	#-1,OFS_exitReg(a2)
	rts

MOD_I32_DENOM_OK
	divsl.l	d3,d2:d0
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I32_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I32_DONE_OP3

MOD_I32_OP3_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MOD_I32_DONE_OP3
	move.l	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts



;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MOD_I64(CMDARGS)

	CNOP	0,8

fMOD_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I64_DONE_OP1

MOD_I64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

MOD_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I64_DONE_OP2

MOD_I64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

MOD_I64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d0,d4
	or.l		d1,d4
	bne.b		MOD_I64_DENOM_OK
	move.l	#-1,OFS_exitReg(a2)
	rts
	
MOD_I64_DENOM_OK	
	exg		d0,d2
	exg		d1,d3
	jsr		SMod64	; // d0/d1 = d0/d1 % d2/d3
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_I64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_I64_DONE_OP3

MOD_I64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

MOD_I64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MOD_F32(CMDARGS)

	CNOP	0,8

fMOD_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#4,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_F32_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_F32_DONE_OP1

MOD_F32_OP1_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MOD_F32_DONE_OP1
	fmove.s	(a0),fp0
	fmove.d	fp0,-(a7)
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_F32_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_F32_DONE_OP2

MOD_F32_OP2_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MOD_F32_DONE_OP2
	fmove.s	(a0),fp0
	fmove.d	fp0,-(a7)

	jsr		_fmod__r
	add.w		#$10,a7	

	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_F32_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_F32_DONE_OP3

MOD_F32_OP3_REG_DIRECT
	lea		4(a2,d5.l*8),a0

MOD_F32_DONE_OP3
	fmove.s	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::MOD_F64(CMDARGS)

	CNOP	0,8

fMOD_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_F64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_F64_DONE_OP1

MOD_F64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

MOD_F64_DONE_OP1
	;fmove.d	(a0),fp0
	;fmove.d	fp0,-(a7)
	
	move.l	4(a0),-(a7)
	move.l	(a0),-(a7)
	
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_F64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_F64_DONE_OP2

MOD_F64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

MOD_F64_DONE_OP2
	;fmove.d	(a0),fp1
	;fmove.d	fp0,-(a7)

	move.l	4(a0),-(a7)
	move.l	(a0),-(a7)
	
	jsr		_fmod__r
	add.w		#$10,a7	

	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOD_F64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOD_F64_DONE_OP3

MOD_F64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

MOD_F64_DONE_OP3
	fmove.d	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

