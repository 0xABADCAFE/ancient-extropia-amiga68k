;//****************************************************************************//
;//**                                                                        **//
;//**  File:          Casts.i ($NAME=Casts.i)                                **//
;//**                                                                        **//
;//**  Description:   type conversion routines                               **//
;//**  Comment(s):                                                           **//
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

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO U2I x y
;//
;//  x = b/w/l
;//  y = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		U2I
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#0,d2
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		U2I_OP1_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		U2I_OP1_REG_INDIRECT\@
	cmp.w		#EA_smallLiteral,d5
	bge.b		U2I_OP1_SMALL_LITERAL\@	

U2I_OP1_EAFUNC\@
	IFC		"\1","b"
	moveq		#1,d7
	ENDC
	IFC		"\1","w"
	moveq		#2,d7
	ENDC
	IFC		"\1","l"
	moveq		#4,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.\1	(a0),d2
	bra.b		U2I_DONE_OP1\@

U2I_OP1_SMALL_LITERAL\@
	and.w		#$1F, d5
	move.\1	d5,d2
	bra.b		U2I_DONE_OP1\@

U2I_OP1_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.\1	(a0),d2
	bra.b		U2I_DONE_OP1\@

U2I_OP1_REG_DIRECT\@
	IFC		"\1","b"
	move.b	JASMINE_gpRegs+7(a2,d5.w*8),d2
	ENDC
	IFC		"\1","w"
	move.w	JASMINE_gpRegs+6(a2,d5.w*8),d2
	ENDC
	IFC		"\1","l"
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d2
	ENDC

U2I_DONE_OP1\@
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		U2I_OP2_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		U2I_OP2_REG_INDIRECT\@

U2I_OP2_EAFUNC\@
	IFC		"\2","b"
	moveq		#1,d7
	ENDC
	IFC		"\2","w"
	moveq		#2,d7
	ENDC
	IFC		"\2","l"
	moveq		#4,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.\2	d2,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts	

U2I_OP2_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.\2	d2,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

U2I_OP2_REG_DIRECT\@
	IFC		"\2","b"
	move.b	d2,JASMINE_gpRegs+7(a2,d5.w*8)
	ENDC
	IFC		"\2","w"
	move.w	d2,JASMINE_gpRegs+6(a2,d5.w*8)
	ENDC
	IFC		"\2","l"
	move.l	d2,JASMINE_gpRegs+4(a2,d5.w*8)
	ENDC
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	ENDM

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO U2F x y
;//
;//  x = b/w/l
;//  y = s/d
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		U2F
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#0,  d2
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		U2F_OP1_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		U2F_OP1_REG_INDIRECT\@
	cmp.w		#EA_smallLiteral,d5
	bge.b		U2F_OP1_SMALL_LITERAL\@	

U2F_OP1_EAFUNC\@
	IFC		"\1","b"
	moveq		#1,d7
	ENDC
	IFC		"\1","w"
	moveq		#2,d7
	ENDC
	IFC		"\1","l"
	moveq		#4,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.\1	(a0),d2
	bra.b		U2F_DONE_OP1\@

U2F_OP1_SMALL_LITERAL\@
	and.w		#$1F, d5
	move.\1	d5,d2
	bra.b		U2F_DONE_OP1\@

U2F_OP1_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.\1	(a0),d2
	bra.b		U2F_DONE_OP1\@

U2F_OP1_REG_DIRECT\@
	IFC		"\1","b"
	move.b	JASMINE_gpRegs+7(a2,d5.w*8),d2
	ENDC
	IFC		"\1","w"
	move.w	JASMINE_gpRegs+6(a2,d5.w*8),d2
	ENDC
	IFC		"\1","l"
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d2
	ENDC

U2F_DONE_OP1\@
	fmove.l	d2,fp0
	IFC		"\1","l"
	;// flags have been set during move.x xx, d2 (well, Z and N anyhow)
	;// that can help us during uint32 -> float conversion to avoid
	;// misinterpreting the uint32 MSB as sign data during fmove.l d2,fp0
	bge.b		U2F_NOSIGN_KLUDGE\@
	fadd.x	#4294967296.0,fp0
U2F_NOSIGN_KLUDGE\@
	ENDC
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		U2F_OP2_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		U2F_OP2_REG_INDIRECT\@

U2F_OP2_EAFUNC\@
	IFC		"\2","s"
	moveq		#4,d7
	ENDC
	IFC		"\2","d"
	moveq		#8,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	fmove.\2	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts	

U2F_OP2_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	fmove.\2	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

U2F_OP2_REG_DIRECT\@
	IFC		"\2","s"
	lea		JASMINE_gpRegs+4(a2,d5.w*8),a0
	ENDC
	IFC		"\2","d"
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	ENDC
	fmove.\2	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	ENDM

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO U642F x
;//
;//  x = s/d
;//
;//////////////////////////////////////////////////////////////////////////////




;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO F2U x y
;//
;//  x = s/d
;//  y = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		F2U
;//	move.l	JASMINE_instPtr(a2),a4

	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		F2U_OP1_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		F2U_OP1_REG_INDIRECT\@

F2U_OP1_EAFUNC\@
	IFC		"\1","s"
	moveq		#4,d7
	ENDC
	IFC		"\1","d"
	moveq		#8,d7
	ENDC

	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	fmove.\1	(a0),fp0
	bra.b		F2U_DONE_OP1\@

F2U_OP1_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	fmove.\1	(a0),fp0
	bra.b		F2U_DONE_OP1\@

F2U_OP1_REG_DIRECT\@
	IFC		"\1","s"
	fmove.s	JASMINE_gpRegs+4(a2,d5.w*8),fp0
	ENDC
	IFC		"\1","d"
	fmove.d	JASMINE_gpRegs(a2,d5.w*8),fp0
	ENDC

F2U_DONE_OP1\@
	IFC		"\2","l"
	fcmp.x	#2147483648.0,fp0
	fblt.w	F2U_NOSIGN_KLUDGE\@
	fsub.x	#2147483648.0,fp0
	fmove.l	fp0,d2
	add.l		#$80000000,d2	
	bra.b		F2U_SIGN_KLUDGE\@
F2U_NOSIGN_KLUDGE\@	
	ENDC
	fmove.l	fp0,d2
	IFC		"\2","l"
F2U_SIGN_KLUDGE\@
	ENDC
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		F2U_OP2_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		F2U_OP2_REG_INDIRECT\@

F2U_OP2_EAFUNC\@
	IFC		"\2","b"
	moveq		#1,d7
	ENDC
	IFC		"\2","w"
	moveq		#2,d7
	ENDC
	IFC		"\2","l"
	moveq		#4,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.\2	d2,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts	

F2U_OP2_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.\2	d2,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

F2U_OP2_REG_DIRECT\@
	IFC		"\2","b"
	move.b	d2,JASMINE_gpRegs+7(a2,d5.w*8)
	ENDC
	IFC		"\2","w"
	move.w	d2,JASMINE_gpRegs+6(a2,d5.w*8)
	ENDC
	IFC		"\2","l"
	move.l	d2,JASMINE_gpRegs+4(a2,d5.w*8)
	ENDC
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	ENDM

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO F2U64 x
;//
;//  x = s/d
;//
;//////////////////////////////////////////////////////////////////////////////


;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO S2I x y
;//
;//  x = b/w/l
;//  y = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		S2I
;//	move.l	JASMINE_instPtr(a2),a4
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		S2I_OP1_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		S2I_OP1_REG_INDIRECT\@
	cmp.w		#EA_smallLiteral,d5
	bge.b		S2I_OP1_SMALL_LITERAL\@	

S2I_OP1_EAFUNC\@
	IFC		"\1","b"
	moveq		#1,d7
	ENDC
	IFC		"\1","w"
	moveq		#2,d7
	ENDC
	IFC		"\1","l"
	moveq		#4,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.\1	(a0),d2
	bra.b		S2I_DONE_OP1\@

S2I_OP1_SMALL_LITERAL\@
	and.w		#$1F, d5
	move.\1	d5,d2
	bra.b		S2I_DONE_OP1\@

S2I_OP1_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.\1	(a0),d2
	bra.b		S2I_DONE_OP1\@

S2I_OP1_REG_DIRECT\@
	IFC		"\1","b"
	move.b	JASMINE_gpRegs+7(a2,d5.w*8),d2
	ENDC
	IFC		"\1","w"
	move.w	JASMINE_gpRegs+6(a2,d5.w*8),d2
	ENDC
	IFC		"\1","l"
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d2
	ENDC

S2I_DONE_OP1\@
	IFC		"\1","b"
	extb.l	d2
	ENDC
	IFC		"\1","w"
	ext.w		d2
	ENDC
	cmp.w		#EA_regDirect,d5
	bmi.b		S2I_OP2_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		S2I_OP2_REG_INDIRECT\@

S2I_OP2_EAFUNC\@
	IFC		"\2","b"
	moveq		#1,d7
	ENDC
	IFC		"\2","w"
	moveq		#2,d7
	ENDC
	IFC		"\2","l"
	moveq		#4,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.\2	d2,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts	

S2I_OP2_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.\2	d2,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

S2I_OP2_REG_DIRECT\@
	IFC		"\2","b"
	move.b	d2,JASMINE_gpRegs+7(a2,d5.w*8)
	ENDC
	IFC		"\2","w"
	move.w	d2,JASMINE_gpRegs+6(a2,d5.w*8)
	ENDC
	IFC		"\2","l"
	move.l	d2,JASMINE_gpRegs+4(a2,d5.w*8)
	ENDC
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	ENDM

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO S2F x y
;//
;//  x = b/w/l
;//  y = s/d
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		S2F
;//	move.l	JASMINE_instPtr(a2),a4
	moveq		#0,  d2
	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		S2F_OP1_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		S2F_OP1_REG_INDIRECT\@
	cmp.w		#EA_smallLiteral,d5
	bge.b		S2F_OP1_SMALL_LITERAL\@	

S2F_OP1_EAFUNC\@
	IFC		"\1","b"
	moveq		#1,d7
	ENDC
	IFC		"\1","w"
	moveq		#2,d7
	ENDC
	IFC		"\1","l"
	moveq		#4,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.\1	(a0),d2
	bra.b		S2F_DONE_OP1\@

S2F_OP1_SMALL_LITERAL\@
	and.w		#$1F, d5
	move.\1	d5,d2
	bra.b		S2F_DONE_OP1\@

S2F_OP1_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.\1	(a0),d2
	bra.b		S2F_DONE_OP1\@

S2F_OP1_REG_DIRECT\@
	IFC		"\1","b"
	move.b	JASMINE_gpRegs+7(a2,d5.w*8),d2
	ENDC
	IFC		"\1","w"
	move.w	JASMINE_gpRegs+6(a2,d5.w*8),d2
	ENDC
	IFC		"\1","l"
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d2
	ENDC

S2F_DONE_OP1\@
	fmove.\1	d2,fp0
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		S2F_OP2_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		S2F_OP2_REG_INDIRECT\@

S2F_OP2_EAFUNC\@
	IFC		"\2","s"
	moveq		#4,d7
	ENDC
	IFC		"\2","d"
	moveq		#8,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	fmove.\2	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts	

S2F_OP2_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	fmove.\2	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

S2F_OP2_REG_DIRECT\@
	IFC		"\2","s"
	lea		JASMINE_gpRegs+4(a2,d5.w*8),a0
	ENDC
	IFC		"\2","d"
	lea		JASMINE_gpRegs(a2,d5.w*8),a0
	ENDC
	fmove.\2	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	ENDM

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MACRO F2S x y
;//
;//  x = s/d
;//  y = b/w/l
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO		F2S
;//	move.l	JASMINE_instPtr(a2),a4

	move.b	1(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		F2S_OP1_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		F2S_OP1_REG_INDIRECT\@

F2S_OP1_EAFUNC\@
	IFC		"\1","s"
	moveq		#4,d7
	ENDC
	IFC		"\1","d"
	moveq		#8,d7
	ENDC

	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	fmove.\1	(a0),fp0
	bra.b		F2S_DONE_OP1\@

F2S_OP1_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	fmove.\1	(a0),fp0
	bra.b		F2S_DONE_OP1\@

F2S_OP1_REG_DIRECT\@
	IFC		"\1","s"
	fmove.s	JASMINE_gpRegs+4(a2,d5.w*8),fp0
	ENDC
	IFC		"\1","d"
	fmove.d	JASMINE_gpRegs(a2,d5.w*8),fp0
	ENDC

F2S_DONE_OP1\@
	fmove.l	fp0,d2
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		F2S_OP2_REG_DIRECT\@
	cmp.w		#EA_regIndirect,d5
	bmi.b		F2S_OP2_REG_INDIRECT\@

F2S_OP2_EAFUNC\@
	IFC		"\2","b"
	moveq		#1,d7
	ENDC
	IFC		"\2","w"
	moveq		#2,d7
	ENDC
	IFC		"\2","l"
	moveq		#4,d7
	ENDC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	move.\2	d2,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts	

F2S_OP2_REG_INDIRECT\@
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.\2	d2,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts

F2S_OP2_REG_DIRECT\@
	IFC		"\2","b"
	move.b	d2,JASMINE_gpRegs+7(a2,d5.w*8)
	ENDC
	IFC		"\2","w"
	move.w	d2,JASMINE_gpRegs+6(a2,d5.w*8)
	ENDC
	IFC		"\2","l"
	move.l	d2,JASMINE_gpRegs+4(a2,d5.w*8)
	ENDC
	addq.l	#4,JASMINE_instPtr(a2)
;//	addq		#4,a4
	rts
	ENDM

