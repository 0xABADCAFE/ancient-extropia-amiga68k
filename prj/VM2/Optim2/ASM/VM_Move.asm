
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

	XDEF	fCLR_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fCLR_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fCLR_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fCLR_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOVE_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOVE_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOVE_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fMOVE_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI8TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI8TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI8TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI8TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI8TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI16TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI16TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI16TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI16TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI32TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI32TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI32TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI64TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI64TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF32TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF64TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF64TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF64TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF64TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF64TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF32TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF32TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF32TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fF32TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI64TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI64TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI64TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI32TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI32TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	XDEF	fI16TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip



;//////////////////////////////////////////////////////////////////////////////
;//
;//  SETZERO.x sizeof(x), 64bit
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		SETZERO
	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		SETZERO_OP1_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		SETZERO_OP1_REG_INDIRECT\@
	move.l	(a3,d5.l*4),a0
	moveq		#\1,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		SETZERO_OP1_DONE\@

SETZERO_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0
	clr.\0	(a0)
	IFC "\2","do64"
	clr.l		4(a0)
	ENDIF
	addq.l	#4, OFS_instPtr(a2)
	rts
	
SETZERO_OP1_REG_INDIRECT\@
	move.l	4(a2,d5.l*8),a0
	clr.\0	(a0)
	IFC "\2","do64"
	clr.l		4(a0)
	ENDIF
	addq.l	#4, OFS_instPtr(a2)
	rts
	
SETZERO_OP1_DONE\@
	clr.\0	(a0)
	IFC "\2","do64"
	clr.l		4(a0)
	ENDIF
	addq.l	#4, OFS_instPtr(a2)
	ENDM



;//////////////////////////////////////////////////////////////////////////////
;//
;//  MOVEX.x sizeof(x), 64bit
;//
;//  x = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		MOVEX
	move.l	OFS_instPtr(a2),a4
	moveq		#\1,d7
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOVEX_OP1_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		MOVEX_OP1_REG_INDIRECT\@
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a5
	bra.b		MOVEX_DONE_OP1\@
	
MOVEX_OP1_REG_INDIRECT\@
	move.l	4(a2,d5.l*8),a5
	bra.b		MOVEX_DONE_OP1\@

MOVEX_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a5
	
MOVEX_DONE_OP1\@
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		MOVEX_OP2_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		MOVEX_OP1_REG_INDIRECT\@	
	move.l	(a3,d5.l*4),a0
	jsr		(a0)
	move.l	d0,a0
	bra.b		MOVEX_DONE_OP2\@

MOVEX_OP2_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0
	move.\0	(a5),(a0)
	IF "\2","do64"
	move.l	4(a5),4(a0)
	ENDIF	
	addq.l	#4,OFS_instPtr(a2)
	rts

MOVEX_OP2_REG_INDIRECT\@
	move.l	4(a2,d5.l*8),a0
	move.\0	(a5),(a0)
	IF "\2","do64"
	move.l	4(a5),4(a0)
	ENDIF	
	addq.l	#4,OFS_instPtr(a2)
	rts

MOVEX_DONE_OP2\@
	move.\0	(a5),(a0)
	IF "\2","do64"
	move.l	4(a5),4(a0)
	ENDIF	
	addq.l	#4,OFS_instPtr(a2)
	ENDM


;//////////////////////////////////////////////////////////////////////////////
;//
;//  UPCAST_INT.x sizeof(x), y, sizeof(y), extcmd
;//
;//  x/y = b/w/l, extcmd = ext/extb
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		UPCAST_INT
	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		UPCAST_INT_OP1_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		UPCAST_INT_OP1_REG_INDIRECT\@
	
	move.l	(a3,d5.l*4),a0
	moveq		#\1,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		UPCAST_INT_DONE_OP1\@

UPCAST_INT_OP1_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0;
	bra.b		UPCAST_INT_DONE_OP1\@

UPCAST_INT_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

UPCAST_INT_DONE_OP1\@
	move.\0	(a0),d2
	\4			d2
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		UPCAST_INT_OP2_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		UPCAST_INT_OP2_REG_INDIRECT\@
	
	move.l	(a3,d5.l*4),a0
	moveq		#\3,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		UPCAST_INT_DONE_OP2\@

UPCAST_INT_OP2_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0;
	move.\2	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts
	
UPCAST_INT_OP2_REG_DIRECT\@
	lea		8-\3(a2,d5.l*8),a0

UPCAST_INT_DONE_OP2\@
	move.\2	d2,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM

;//////////////////////////////////////////////////////////////////////////////
;//
;//  UPCAST_I64.x sizeof(x), extcmd
;//
;//  x = b/w/l, extcmd = ext/extb
;//
;//////////////////////////////////////////////////////////////////////////////


	MACRO		UPCAST_I64
	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		UPCAST_I64_OP1_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		UPCAST_I64_OP1_REG_INDIRECT\@

	move.l	(a3,d5.l*4),a0
	moveq		#\1,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		UPCAST_I64_DONE_OP1\@

UPCAST_I64_OP1_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	bra.b		UPCAST_I64_DONE_OP1\@

UPCAST_I64_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

UPCAST_I64_DONE_OP1\@
	move.\0	(a0),d2
	IFC "\2","none"
	ELSE
	\2			d2
	ENDIF
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		UPCAST_I64_OP2_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		UPCAST_I64_OP2_REG_INDIRECT\@
	
	move.l	(a3,d5.l*4),a0
	moveq		#8,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		UPCAST_I64_DONE_OP2\@

UPCAST_I64_OP2_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	bra.b		UPCAST_I64_DONE_OP2\@
	
UPCAST_I64_OP2_REG_DIRECT\@
	lea		(a2,d5.l*8),a0

UPCAST_I64_DONE_OP2\@
	move.l	d2,(a0)
	bge.b		UPCAST_I64_POSITIVE\@
	move.l	#-1,4(a0)
	bra.b		UPCAST_I64_DONE\@

UPCAST_I64_POSITIVE\@
	clr.l		4(a0)

UPCAST_I64_DONE\@
	addq.l	#4,OFS_instPtr(a2)
	ENDM

;//////////////////////////////////////////////////////////////////////////////
;//
;//  CAST_FLT.x sizeof(x), y, sizeof(y)
;//
;//  x = b/w/l/s, y = s/d
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		CAST_FLT
	move.l	OFS_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		CAST_FLT_OP1_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		CAST_FLT_OP1_REG_INDIRECT\@

	move.l	(a3,d5.l*4),a0
	moveq		#\1,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		CAST_FLT_DONE_OP1\@

CAST_FLT_OP1_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	bra.b		CAST_FLT_DONE_OP1\@

CAST_FLT_OP1_REG_DIRECT\@
	lea		8-\1(a2,d5.l*8),a0

CAST_FLT_DONE_OP1\@
	fmove.\0	(a0),fp0
	move.b	2(a4),d5
	cmp.b		#EA_regDirect,d5
	bmi.b		CAST_FLT_OP2_REG_DIRECT\@
	cmp.b		#EA_regIndirect,d5
	bmi.b		CAST_FLT_OP2_REG_INDIRECT\@

	move.l	(a3,d5.l*4),a0
	moveq		#\3,d7
	jsr		(a0)
	move.l	d0,a0
	bra.b		CAST_FLT_DONE_OP2\@

CAST_FLT_OP2_REG_INDIRECT\@
	move.l	(a2,d5.l*8),a0
	fmove.\2	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	rts
	
CAST_FLT_OP2_REG_DIRECT\@
	lea		8-\3(a2,d5.l*8),a0

CAST_FLT_DONE_OP2\@
	fmove.\2	fp0,(a0)
	addq.l	#4,OFS_instPtr(a2)
	ENDM

	SECTION ":0",CODE


;//void VMCORE::fCLR_X8(CMDARGS)
fCLR_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	SETZERO.b	1,n
	rts

;//void VMCORE::fCLR_X16(CMDARGS)
fCLR_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	SETZERO.w	2,n
	rts
	
;//void VMCORE::fCLR_X32(CMDARGS)
fCLR_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	SETZERO.l	4,n
	rts

;//void VMCORE::fCLR_X64(CMDARGS)
fCLR_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	SETZERO.l	8,do64
	rts

;//void VMCORE::fMOVE_X8(CMDARGS)
fMOVE_X8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	MOVEX.b	1,n
	rts

;//void VMCORE::fMOVE_X16(CMDARGS)
fMOVE_X16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	MOVEX.w	2,n
	rts

;//void VMCORE::fMOVE_X32(CMDARGS)
fMOVE_X32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	MOVEX.l	4,n
	rts

;//void VMCORE::fMOVE_X64(CMDARGS)
fMOVE_X64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	MOVEX.l	8,do64
	rts

;//void VMCORE::fI8TOI16(CMDARGS)
fI8TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	UPCAST_INT.b	1,	w,	2,	ext.w
	rts

;//void VMCORE::fI8TOI32(CMDARGS)
fI8TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	UPCAST_INT.b	1,	l,	4,	extb.l
	rts

;//void VMCORE::fI8TOI64(CMDARGS)
fI8TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	UPCAST_I64.b	1,	extb.l
	rts

;//void VMCORE::fI8TOF32(CMDARGS)
fI8TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.b	1, s,	4
	rts

;//void VMCORE::fI8TOF64(CMDARGS)
fI8TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.b	1,	d,	8
	rts

;//void VMCORE::fI16TOI32(CMDARGS)
fI16TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	UPCAST_INT.w	2,	l,	4,	ext.l
	rts

;//void VMCORE::fI16TOI64(CMDARGS)
fI16TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	UPCAST_I64.w	2,	extb.l
	rts
	
;//void VMCORE::fI16TOF32(CMDARGS)
fI16TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.w	2,	s,	4
	rts

;//void VMCORE::fI16TOF64(CMDARGS)
fI16TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.w	2,	d,	8
	rts

;//void VMCORE::fI32TOI64(CMDARGS)
fI32TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	UPCAST_I64.l	4,	none
	rts

;//void VMCORE::fI32TOF32(CMDARGS)
fI32TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.l	4,	s,	4
	rts

;//void VMCORE::fI32TOF64(CMDARGS)
fI32TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.l	4,	d,	8
	rts

;//void VMCORE::fI64TOF32(CMDARGS)
fI64TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L61
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(float32) = (float32) OP1(sint64);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	move.l	(a0),d0
	move.l	4(a0),d1
	fmove.l	d1,fp2
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	fmove.s	fp2,(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;//void VMCORE::fI64TOF64(CMDARGS)
fI64TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L62
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(float64) = (float64) OP1(sint64);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	move.l	(a0),d0
	move.l	4(a0),d1
	fmove.l	d1,fp2
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	fmove.d	fp2,(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;//void VMCORE::fF32TOF64(CMDARGS)
fF32TOF64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.s	4,	d,	8
	rts
	
;//void VMCORE::fF64TOF32(CMDARGS)
fF64TOF32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.d	8,	s,	4
	rts
	
;//void VMCORE::fF64TOI64(CMDARGS)
fF64TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L66
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(sint64) = (sint64) OP1(float64);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	fmove.d	(a0),fp0
	fmove.l	fp0,d0
	moveq	#0,d2
	move.l	d0,d3
	bpl.b	L67
	moveq	#-1,d2
L67
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;//void VMCORE::fF64TOI32(CMDARGS)
fF64TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.d	8,	l,	4
	rts
	
;//void VMCORE::fF64TOI16(CMDARGS)
fF64TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.d	8,	w,	2
	rts

;//void VMCORE::fF64TOI8(CMDARGS)
fF64TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.d	8,	b,	1
	rts

;//void VMCORE::fF32TOI64(CMDARGS)
fF32TOI64__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L71
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(sint64) = (sint16) OP1(sint16);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	moveq	#0,d2
	move.w	(a0),d3
	ext.l	d3
	bpl.b	L72
	moveq	#-1,d2
L72
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	move.l	d2,(a0)
	move.l	d3,4(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;//void VMCORE::fF32TOI32(CMDARGS)
fF32TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.s	4,	l,	4
	rts
	
;//void VMCORE::fF32TOI16(CMDARGS)
fF32TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.s	4,	w,	2
	rts

;//void VMCORE::fF32TOI8(CMDARGS)
fF32TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip

	CAST_FLT.s	4,	b,	1
	rts
	
;//void VMCORE::fI64TOI32(CMDARGS)
fI64TOI32__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L76
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(sint32) = (sint32) OP1(sint64);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d1,d2
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	move.l	d2,(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;//void VMCORE::fI64TOI16(CMDARGS)
fI64TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L77
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(sint16) = (sint16) OP1(sint64);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	move.l	(a0),d0
	move.l	4(a0),d1
	move.w	d1,d2
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	move.w	d2,(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;//void VMCORE::fI64TOI8(CMDARGS)
fI64TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L78
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(sint8) = (sint8) OP1(sint64);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	move.l	(a0),d0
	move.l	4(a0),d1
	move.b	d1,d2
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	move.b	d2,(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;//void VMCORE::fI32TOI16(CMDARGS)
fI32TOI16__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L79
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(sint16) = (sint16) OP1(sint32);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	move.w	2(a0),d2
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	move.w	d2,(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;//void VMCORE::fI32TOI8(CMDARGS)
fI32TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L80
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(sint8) = (sint8) OP1(sint32);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	move.b	3(a0),d2
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	move.b	d2,(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;//void VMCORE::fI16TOI8(CMDARGS)
fI16TOI8__VMCORE__r10P06VMCOREr11PPFPvr10P06VMCOREr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L81
;//	OPINIT()
	move.l	OFS_instPtr(a2),a3
;//	OP2(sint8) = (sint8) OP1(sint16);//
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	move.b	1(a0),d2
	moveq	#0,d0
	move.b	2(a3),d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	move.b	d2,(a0)
;//	OPDONE();//
	move.l	OFS_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,OFS_instPtr(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

	END
