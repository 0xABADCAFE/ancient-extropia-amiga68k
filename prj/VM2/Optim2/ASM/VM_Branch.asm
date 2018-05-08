
;//////////////////////////////////////////////////////////////////////////////
;//
;//  VM_Branch.asm
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

	XDEF	fNOP__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBRK__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fEXIT__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fLEA__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBRA__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBNEQ_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBNEQ_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBNEQ_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBNEQ_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBNEQ_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBNEQ_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLS_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLS_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLS_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLS_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLS_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLS_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLSEQ_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLSEQ_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLSEQ_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLSEQ_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLSEQ_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBLSEQ_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBEQ_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBEQ_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBEQ_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBEQ_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBEQ_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBEQ_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGREQ_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGREQ_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGREQ_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGREQ_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGREQ_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGREQ_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGR_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGR_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGR_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGR_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGR_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fBGR_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fJSR__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fRTS__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

;//////////////////////////////////////////////////////////////////////////////
;//
;//  Conditional branch macros
;//
;//  BRIF_INT.x cc, sizeof(x)
;//  x  = b/w/l
;//  cc = ne, lt, le, eq, ge, gt
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		BRIF_INT
	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5	
	bmi.b		OP1_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		OP1_REG_INDIRECT\@
	
	move.l	(a3,d5.l*4),a0
	moveq		#\2,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		OP1_DONE\@

OP1_REG_INDIRECT\@
	move.l	4(a2,d5.l*8),a0
	tst.\0	(a0)
	b\1.b		BRANCH\@
	addq.l	#8, OFS_instPtr(a2)
	rts
	
OP1_REG_DIRECT\@
	lea		8-\2(a2,d5.l*8),a0

OP1_DONE\@
	tst.\0	(a0)
	b\1.b		BRANCH\@
	addq.l	#8, OFS_instPtr(a2)
	rts

BRANCH\@
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a0
	move.l	a0,OFS_instPtr(a2)
	ENDM

;//////////////////////////////////////////////////////////////////////////////
;//
;//  Conditional branch macros
;//
;//  BRIF_FLT.x cc, sizeof(x)
;//  x  = s/d
;//  cc = ne, lt, le, eq, ge, gt
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		BRIF_FLT
	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5	
	bmi.b		OP1_REG_DIRECT_FLT\@
	
	cmp.b		#EA_regIndirect,d5
	bmi.b		OP1_REG_INDIRECT_FLT\@
	
	move.l	(a3,d5.l*4),a0
	moveq		#\2,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		OP1_DONE_FLT\@

OP1_REG_INDIRECT_FLT\@
	move.l	4(a2,d5.l*8),a0
	ftst.\0	(a0)
	fb\1.b	BRANCH_FLT\@
	addq.l	#8, OFS_instPtr(a2)
	rts

OP1_REG_DIRECT_FLT\@
	lea		8-\2(a2,d5.l*8),a0

OP1_DONE_FLT\@
	ftst.\0	(a0)
	fb\1.b	BRANCH_FLT\@
	addq.l	#8, OFS_instPtr(a2)
	rts

BRANCH_FLT\@
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a0
	move.l	a0,OFS_instPtr(a2)
	ENDM

	SECTION ":0",CODE


;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fNOP(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fNOP__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	addq.l	#4,	OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBRK(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBRK__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	addq.l	#4,	OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fEXIT(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fEXIT__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	#1,OFS_exitReg(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fLEA(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fLEA__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	addq.l	#4,	OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBRA(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBRA__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a1
	move.l	4(a1),d0
	lea		4(a1,d0.l*4),a0
	move.l	a0,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBNEQ_I8(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBNEQ_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.b	ne,1
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBNEQ_I16(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBNEQ_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.w	ne,2
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBNEQ_I32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBNEQ_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.l	ne,4
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBNEQ_I64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBNEQ_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5	
	bmi.b		BNEQ_I64_OP_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	moveq		#8,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		BNEQ_I64_OP_DONE

BNEQ_I64_OP_REG_DIRECT
	lea		(a2,d5.l*8),a0

BNEQ_I64_OP_DONE
	; // if MSW | LSW is non zero then 64-bit word is non zero
	move.l	(a0),	d0
	or.l		4(a0),d0
	bne.b		BNEQ_I64_BRANCH
	addq.l	#8, OFS_instPtr(a2)
	rts

BNEQ_I64_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a0
	move.l	a0,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBNEQ_F32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBNEQ_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.s	ne,4
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBNEQ_F64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBNEQ_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.d	ne,8
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLS_I8(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLS_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.b	lt,1
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLS_I16(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLS_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.w	lt,2
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLS_I32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLS_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.l	lt,4
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLS_I64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLS_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5	
	bmi.b		BLS_I64_OP_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	moveq		#8,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		BLS_I64_OP_DONE

BLS_I64_OP_REG_DIRECT
	lea		(a2,d5.l*8),a0

BLS_I64_OP_DONE
	; // if the MSW is negative, logically the whole 64-bit word is negative
	tst.l		(a0)
	bmi.l		BLS_I64_BRANCH
	addq.l	#8, OFS_instPtr(a2)
	rts

BLS_I64_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a0
	move.l	a0,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLS_F32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLS_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.s	olt,4
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLS_F64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLS_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.d	olt,8
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLSEQ_I8(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLSEQ_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.b	le,1
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLSEQ_I16(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLSEQ_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.w	le,2
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLSEQ_I32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLSEQ_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.l	le,4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLSEQ_I64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLSEQ_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5	
	bmi.b		BLSEQ_I64_OP_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	moveq		#8,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		BLSEQ_I64_OP_DONE

BLSEQ_I64_OP_REG_DIRECT
	lea		(a2,d5.l*8),a0

BLSEQ_I64_OP_DONE
	; // if MSW < 0 -> branch
	; // if MSW == 0 && LSW == 0 -> branch
	tst.l		(a0)
	bmi.b		BLSEQ_I64_BRANCH
	bpl.b		BLSEQ_I64_SKIP
	tst.l		4(a0)
	beq.l		BLSEQ_I64_BRANCH

BLSEQ_I64_SKIP
	addq.l	#8, OFS_instPtr(a2)
	rts

BLSEQ_I64_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a0
	move.l	a0,OFS_instPtr(a2)
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLSEQ_F32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLSEQ_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.s	ole,4
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBLSEQ_F64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBLSEQ_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.d	ole,8
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBEQ_I8(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBEQ_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.b	eq,1
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBEQ_I16(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBEQ_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.w	eq,2	
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBEQ_I32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBEQ_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.l	eq,4
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBEQ_I64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBEQ_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5	
	bmi.b		BEQ_I64_OP_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	moveq		#8,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		BEQ_I64_OP_DONE

BEQ_I64_OP_REG_DIRECT
	lea		(a2,d5.l*8),a0

BEQ_I64_OP_DONE
	; // if MSW | LSW is zero then 64-bit word is zero
	move.l	(a0),	d0
	or.l		4(a0),d0
	beq.b		BEQ_I64_BRANCH
	addq.l	#8, OFS_instPtr(a2)
	rts

BEQ_I64_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a0
	move.l	a0,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBEQ_F32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBEQ_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.s	eq,4
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBEQ_F64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBEQ_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.d	eq,8
	rts
	

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGREQ_I8(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGREQ_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.b	ge,1
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGREQ_I16(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGREQ_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.w	ge,2
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGREQ_I32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGREQ_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.l	ge,4
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGREQ_I64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGREQ_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5	
	bmi.b		BGREQ_I64_OP_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	moveq		#8,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		BGREQ_I64_OP_DONE

BGREQ_I64_OP_REG_DIRECT
	lea		(a2,d5.l*8),a0

BGREQ_I64_OP_DONE
	; // if MSW >= 0 && LSW >= 0 -> branch
	tst.l		(a0)
	bmi.b		BGREQ_I64_SKIP
	tst.l		4(a0)
	bge.l		BGREQ_I64_BRANCH

BGREQ_I64_SKIP
	addq.l	#8, OFS_instPtr(a2)
	rts

BGREQ_I64_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a0
	move.l	a0,OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGREQ_F32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGREQ_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.s	oge,4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGREQ_F64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGREQ_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.d	oge,8
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGR_I8(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGR_I8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.b	gt,1
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGR_I16(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGR_I16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.w	gt,2
	rts
	
;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGR_I32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGR_I32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_INT.l	gt,4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGR_I64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGR_I64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5	
	bmi.b		BGR_I64_OP_REG_DIRECT
	move.l	(a3,d5.l*4),a0
	moveq		#8,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		BGR_I64_OP_DONE

BGR_I64_OP_REG_DIRECT
	lea		(a2,d5.l*8),a0

BGR_I64_OP_DONE
	; // if MSW >= 0 && LSW > 0 -> branch
	tst.l		(a0)
	bmi.b		BGR_I64_SKIP
	tst.l		4(a0)
	bpl.l		BGR_I64_BRANCH

BGR_I64_SKIP
	addq.l	#8, OFS_instPtr(a2)
	rts

BGR_I64_BRANCH
	move.l	4(a4),d0
	lea		4(a4,d0.l*4),a0
	move.l	a0,OFS_instPtr(a2)
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGR_F32(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGR_F32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.s	ogt,4
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fBGR_F64(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fBGR_F64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	BRIF_FLT.d	ogt,8
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fJSR(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8

fJSR__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

;//	OPINIT()
;//	ruint32* dest = POP1(uint32); -> a0
	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,	d5
	bmi.b		JSR_OP_REG_DIRECT
	move.l	(a1,d5.l*4),a0
	moveq		#4,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		JSR_OP_DONE

JSR_OP_REG_DIRECT
	lea		4(a4,d5.l*4),a0
	
JSR_OP_DONE
;// *(This->branchStack++ ->a5) = (++This->instPtr -> a4)
	move.l	OFS_instPtr(a2),a4
	addq.l	#4,a4
	move.l	OFS_branchStack(a2),a5
	addq.l	#4,a5
	move.l	a4,(a5)
	move.l	a5,OFS_branchStack(a2)

;//	This->instPtr = dest 
	move.l	a0,OFS_instPtr(a2)
	rts

	CNOP	0,8

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void VMCORE::fRTS(CMDARGS)
;//
;//////////////////////////////////////////////////////////////////////////////

fRTS__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

;//	This->instPtr = *(--This->branchStack);//
	move.l	OFS_branchStack(a2),d0
	cmp.l		OFS_branchStackBase(a2),d0
	bgt.b		RTS_OK
	move.l	#-1,OFS_exitReg(a2)
	rts
	
RTS_OK	
	move.l	d0,a0
	subq.w	#4,a0
	move.l	a0,OFS_branchStack(a2)
	move.l	(a0),OFS_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////
