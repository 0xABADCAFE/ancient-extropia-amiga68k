;//////////////////////////////////////////////////////////////////////////////
;//
;//  VM_Add.asm
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

	XDEF	fADD_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fADD_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fADD_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fADD_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fADD_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fADD_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO ADD_INT.x sizeof(x)
;//
;//  x = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		ADD_INT
	move.l	OFS_instPtr(a2),a4
	moveq		#\1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		ADD_INT_OP1_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		ADD_INT_OP1_REG_INDIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_INT_DONE_OP1\@

ADD_INT_OP1_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	bra.b		ADD_INT_DONE_OP1\@
	
ADD_INT_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

ADD_INT_DONE_OP1\@
	move.\0	(a0),d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		ADD_INT_OP2_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		ADD_INT_OP2_REG_INDIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_INT_DONE_OP2\@

ADD_INT_OP2_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	bra.b		ADD_INT_DONE_OP2\@

ADD_INT_OP2_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

ADD_INT_DONE_OP2\@
	add.\0	(a0),d2
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		ADD_INT_OP3_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		ADD_INT_OP3_REG_INDIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

ADD_INT_OP3_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts
	
ADD_INT_OP3_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0
	move.\0	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO ADD_FLT.x sizeof(x)
;//
;//  x = s/d
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		ADD_FLT
	move.l	OFS_instPtr(a2),a4
	moveq		#\1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		ADD_FLT_OP1_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		ADD_FLT_OP1_REG_INDIRECT\@
	
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_FLT_DONE_OP1\@

ADD_FLT_OP1_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	bra.b		ADD_FLT_DONE_OP1\@
	
ADD_FLT_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

ADD_FLT_DONE_OP1\@
	fmove.\0	(a0),fp0
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		ADD_FLT_OP2_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		ADD_FLT_OP2_REG_INDIRECT\@

	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_FLT_DONE_OP2\@

ADD_FLT_OP2_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	bra.b		ADD_FLT_DONE_OP2\@

ADD_FLT_OP2_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

ADD_FLT_DONE_OP2\@
	fadd.\0	(a0),fp0
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		ADD_FLT_OP3_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		ADD_FLT_OP3_REG_INDIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_FLT_DONE_OP3\@

ADD_FLT_OP3_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	fmove.\0	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts
	
ADD_FLT_OP3_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

ADD_FLT_DONE_OP3\@
	fmove.\0	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM
	
	SECTION ":0",CODE


;//////////////////////////////////////////////////////////////////////////////

;// void VMCORE::ADD_I8(CMDARGS)
;// OP3(sint8) = OP1(sint8) + OP2(sint8);//

	CNOP	0,8

fADD_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	ADD_INT.b	1
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;// void VMCORE::ADD_I16(CMDARGS)
;// OP3(sint16) = OP1(sint16) + OP2(sint16);//

	CNOP	0,8

fADD_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	ADD_INT.w	2
	
;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;// void VMCORE::ADD_I32(CMDARGS)
;// OP3(sint32) = OP1(sint32) + OP2(sint32);

	CNOP	0,8

fADD_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	ADD_INT.l	4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;// void VMCORE::ADD_I64(CMDARGS)
;// OP3(sint64) = OP1(sint64) + OP2(sint64);

	CNOP	0,8

fADD_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	moveq		#8,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		ADD_I64_OP1_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_I64_DONE_OP1

ADD_I64_OP1_REG_DIRECT
	lea		(a2,d5.l*8),a0

ADD_I64_DONE_OP1
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		ADD_I64_OP2_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_I64_DONE_OP2

ADD_I64_OP2_REG_DIRECT
	lea		(a2,d5.l*8),a0

ADD_I64_DONE_OP2
	move.l	(a0),d0
	move.l	4(a0),d1
	jsr		Add64	; // d0/d1 = d0/d1 + d2/d3
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		ADD_I64_OP3_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		ADD_I64_DONE_OP3

ADD_I64_OP3_REG_DIRECT
	lea		(a2,d5.l*8),a0

ADD_I64_DONE_OP3
	move.l	d2,(a0)
	move.l	d3,4(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

;//void VMCORE::ADD_F32(CMDARGS)

	CNOP	0,8

fADD_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	ADD_FLT.s	4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////


;//void VMCORE::ADD_F64(CMDARGS)

	CNOP	0,8

fADD_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	ADD_FLT.d	8
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

