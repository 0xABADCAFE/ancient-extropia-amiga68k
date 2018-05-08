;//****************************************************************************//
;//** File:         xNumericOptimize.cpp ($NAME=xNumericOptimize.cpp)        **//
;//** Description:  eXtropia Library Base API Source                         **//
;//** Comment(s):   Skeleton to generate XNUM_HAND_OPTIMIZED code            **//
;//** Library:      xUtility                                                 **//
;//** Created:      2001-02-20                                               **//
;//** Updated:      2001-02-26                                               **//
;//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
;//** Note(s):                                                               **//
;//** Copyright:    (C)1996-2001, eXtropia Studios                           **//
;//**               Serkan YAZICI, Karl Churchill                            **//
;//**               All Rights Reserved.                                     **//
;//****************************************************************************//
;// Storm C Compiler
;//Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/HandOptimized/xNumericO.cpp

	mc68040

	XREF	_fmod__r
	XREF	_data__xNUM
	XREF	_arcData__xNUM
	XREF	_eFrac__xNUM
	XREF	_eInt__xNUM

	SECTION "_0ct__streampos__T:0",CODE
	rts


;/////////////////////////////////////////////////////////////////////////
;//
;//  fp0 xNUM::Sin(fp0)
;//
;/////////////////////////////////////////////////////////////////////////
	SECTION "Sin__xNUM___r_r16f:0",CODE
	XDEF	Sin__xNUM___r_r16f
Sin__xNUM___r_r16f
	move.l	d2,-(a7)
	fmovem.x fp2,-(a7)
	fmove.x	fp0,fp2

	move.l	#_data__xNUM,a1

L99
;//	x *= (2*XNUM_DATASIZE/PI);
	fmul.s	#$.4422F983,fp2
;//	ruint32 i = (uint32)x;
	fmove.l	fp2,d1
;//	x -= i;
	fmove.l	d1,fp0
	fsub.x	fp0,fp2
	fmove.s	#$.3F800000,fp0
	fsub.x	fp2,fp0
	move.l	d1,d0
	cmp.l	#$400,d0
	bhs.b	L101

L100
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L108
L101
	cmp.l	#$800,d0
	bhs.b	L103
L102
	move.l	#$800,d2
	sub.l	d0,d2
	move.l	d2,d0
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L108

L103
	cmp.l	#$C00,d0
	bhs.b	L105
L104
	sub.l	#$800,d0
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L108

L105
	cmp.l	#$1000,d0
	bhs.b	L107
L106
	move.l	#$1000,d2
	sub.l	d0,d2
	move.l	d2,d0
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L108

L107
	sub.l	#$1000,d0
	fmove.s	0(a1,d0.l*4),fp1


L108
	fmul.x	fp1,fp0
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$400,d0
	bhs.b	L110
L109
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L117
L110
	cmp.l	#$800,d0
	bhs.b	L112
L111
	move.l	#$800,d1
	sub.l	d0,d1
	move.l	d1,d0
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L117
L112
	cmp.l	#$C00,d0
	bhs.b	L114
L113
	sub.l	#$800,d0
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L117
L114
	cmp.l	#$1000,d0
	bhs.b	L116
L115
	move.l	#$1000,d1
	sub.l	d0,d1
	move.l	d1,d0
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L117
L116
	sub.l	#$1000,d0
	fmove.s	0(a1,d0.l*4),fp1
L117
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmovem.x (a7)+,fp2
	move.l	(a7)+,d2
	rts

;/////////////////////////////////////////////////////////////////////////
;//
;//  fp0 xNUM::Cos(fp0)
;//
;/////////////////////////////////////////////////////////////////////////
	SECTION "Cos__xNUM___r_r16f:0",CODE
	XDEF	Cos__xNUM___r_r16f
Cos__xNUM___r_r16f
	move.l	d2,-(a7)
	fmovem.x fp2,-(a7)
	fmove.x	fp0,fp2
	move.l	#_data__xNUM,a1

L118
;//	x *= (2*XNUM_DATASIZE/PI);
	fmul.s	#$.4422F983,fp2
;//	ruint32 i = (uint32)x;
	fmove.l	fp2,d1
;//	x -= i;
	fmove.l	d1,fp0
	fsub.x	fp0,fp2
	fmove.s	#$.3F800000,fp0
	fsub.x	fp2,fp0
	move.l	d1,d0
	cmp.l	#$400,d0
	bhs.b	L120
L119
	move.l	#$400,d2
	sub.l	d0,d2
	move.l	d2,d0
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L127
L120
	cmp.l	#$800,d0
	bhs.b	L122
L121
	sub.l	#$400,d0
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L127
L122
	cmp.l	#$C00,d0
	bhs.b	L124
L123
	move.l	#$C00,d2
	sub.l	d0,d2
	move.l	d2,d0
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L127
L124
	cmp.l	#$1000,d0
	bhs.b	L126
L125
	sub.l	#$C00,d0
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L127
L126
	move.l	#$1400,d2
	sub.l	d0,d2
	move.l	d2,d0
	fmove.s	0(a1,d0.l*4),fp1
L127
	fmul.x	fp1,fp0
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$400,d0
	bhs.b	L129
L128
	move.l	#$400,d1
	sub.l	d0,d1
	move.l	d1,d0
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L136
L129
	cmp.l	#$800,d0
	bhs.b	L131
L130
	sub.l	#$400,d0
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L136
L131
	cmp.l	#$C00,d0
	bhs.b	L133
L132
	move.l	#$C00,d1
	sub.l	d0,d1
	move.l	d1,d0
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L136
L133
	cmp.l	#$1000,d0
	bhs.b	L135
L134
	sub.l	#$C00,d0
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L136
L135
	move.l	#$1400,d1
	sub.l	d0,d1
	move.l	d1,d0
	fmove.s	0(a1,d0.l*4),fp1
L136
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmovem.x (a7)+,fp2
	move.l	(a7)+,d2
	rts

;/////////////////////////////////////////////////////////////////////////
;//
;//  fp0 xNUM::Tan(fp0)
;//
;/////////////////////////////////////////////////////////////////////////
	SECTION "Tan__xNUM___r_r16f:0",CODE
	XDEF	Tan__xNUM___r_r16f
Tan__xNUM___r_r16f
	move.l	d2,-(a7)
	fmovem.x fp2/fp3,-(a7)
	fmove.x	fp0,fp1

	move.l	#_data__xNUM,a1

L137
;//	x *= (2*XNUM_DATASIZE/PI);
	fmul.s	#$.4422F983,fp1
;//	ruint32 i = (uint32)x;
	fmove.l	fp1,d0
;//	x -= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
;//	if (i<XNUM_DATASIZE)
	cmp.l	#$400,d0
	bhs.b	L139
L138
;//		ruint32 i2 = XNUM_DATASIZE-i;
	move.l	#$400,d1
	sub.l	d0,d1
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts
L139
;//	else if (i<(2*XNUM_DATASIZE))
	cmp.l	#$800,d0
	bhs	L141
L140
;//		ruint32 i2 = i-XNUM_DATASIZE;
	move.l	d0,d1
	sub.l	#$400,d1
;// i = (2*XNUM_DATASIZE)-i;
	move.l	#$800,d2
	sub.l	d0,d2
	move.l	d2,d0
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fneg.s	fp0
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fsub.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts
L141
;//	else if (i<(3*XNUM_DATASIZE))
	cmp.l	#$C00,d0
	bhs.b	L143
L142
;//		ruint32 i2 = (3*XNUM_DATASIZE)-i;
	move.l	#$C00,d1
	sub.l	d0,d1
;// i -= (2*XNUM_DATASIZE);
	sub.l	#$800,d0
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts
L143
;//	else if (i<(4*XNUM_DATASIZE))
	cmp.l	#$1000,d0
	bhs	L145
L144
;//		ruint32 i2 = i-(3*XNUM_DATASIZE);
	move.l	d0,d1
	sub.l	#$C00,d1
;// i = (4*XNUM_DATASIZE)-i;
	move.l	#$1000,d2
	sub.l	d0,d2
	move.l	d2,d0
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fneg.s	fp0
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fsub.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts
L145
;//		ruint32 i2 = (5*XNUM_DATASIZE)-i;
	move.l	#$1400,d1
	sub.l	d0,d1
;// i -= (4*XNUM_DATASIZE);
	sub.l	#$1000,d0
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts

;/////////////////////////////////////////////////////////////////////////
;//
;//  fp0 xNUM::ASin(fp0)
;//
;/////////////////////////////////////////////////////////////////////////
	SECTION "ASin__xNUM___r_r16f:0",CODE
	XDEF	ASin__xNUM___r_r16f
ASin__xNUM___r_r16f
	fmovem.x fp2,-(a7)
	fmove.x	fp0,fp1
	move.l	#_arcData__xNUM,a1

L146
;//	x *= XNUM_DATASIZE;
	fmul.s	#$.44800000,fp1
;	if (x<0F)
	fcmp.s	#$.00000000,fp1
	fboge.b	L148
L147
;//		x = -x;
	fneg.s	fp1
;//		ruint32 i = (x - 0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;//		x -= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fneg.s	fp0
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	fmul.s	0(a1,d0.l*4),fp1
	fsub.x	fp1,fp0
	fmovem.x (a7)+,fp2
	rts
L148
;//		ruint32 i = (x - 0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;//		x	-= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	fmul.s	0(a1,d0.l*4),fp1
	fadd.x	fp1,fp0
	fmovem.x (a7)+,fp2
	rts

;/////////////////////////////////////////////////////////////////////////
;//
;//  fp0 xNUM::ACos(fp0)
;//
;/////////////////////////////////////////////////////////////////////////
	SECTION "ACos__xNUM___r_r16f:0",CODE
	XDEF	ACos__xNUM___r_r16f
ACos__xNUM___r_r16f
	fmovem.x fp2,-(a7)
	fmove.x	fp0,fp1

	move.l	#_arcData__xNUM,a1

L149
;//	x *= XNUM_DATASIZE;
	fmul.s	#$.44800000,fp1
;//	if (x<0F)
	fcmp.s	#$.00000000,fp1
	fboge.b	L151
L150
;//		x = -x;
	fneg.s	fp1
;//		ruint32 i = (x - 0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;//		x -= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fmul.s	0(a1,d0.l*4),fp0
	fadd.d	#$.3FF921FB.60000000,fp0
	addq.l	#1,d0
	fmul.s	0(a1,d0.l*4),fp1
	fadd.x	fp1,fp0
	fmovem.x (a7)+,fp2
	rts
L151
;//		ruint32 i = (x - 0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;//		x	-= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fmul.s	0(a1,d0.l*4),fp0
	fmove.d	#$.3FF921FB.60000000,fp2
	fsub.x	fp0,fp2
	fmove.x	fp2,fp0
	addq.l	#1,d0
	fmul.s	0(a1,d0.l*4),fp1
	fsub.x	fp1,fp0
	fmovem.x (a7)+,fp2
	rts

;/////////////////////////////////////////////////////////////////////////
;//
;//  fp0 xNUM::Exp(fp0)
;//
;/////////////////////////////////////////////////////////////////////////
	SECTION "Exp__xNUM___r_r16f:0",CODE
	XDEF	Exp__xNUM___r_r16f

Exp__xNUM___r_r16f
	move.l	d2,-(a7)
	fmovem.x fp2/fp3,-(a7)
	fmove.x	fp0,fp1
L152
;//	rsint32 i = (x+0.5F);
	fmove.x	fp1,fp0
	fadd.s	#$.3F000000,fp0
	fmove.l	fp0,d1
;//	x -= (i-1);
	move.l	d1,d0
	subq.l	#1,d0
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
;//	x *= XNUM_DATASIZE;
	fmul.s	#$.44800000,fp1
;//	ruint32 i2 = (x-0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;//	x -= i2;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
	add.l	#$58,d1
	move.l	#_eInt__xNUM,a1
	fmove.s	0(a1,d1.l*4),fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	move.l	#_eFrac__xNUM,a1
	fmul.s	0(a1,d0.l*4),fp2
	addq.l	#1,d0
	fmul.s	0(a1,d0.l*4),fp1
	fadd.x	fp1,fp2
	fmul.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts

	END
