
; Storm C Compiler
; Developer:eXtropia/eXtropiaOld/prj/xDAC/SoundFormats.cpp
	mc68030
	mc68881
	XREF	_frexp__r
	XREF	_ldexp__r
	XREF	_floor__r
	XREF	Delete__xPCM__T
	XREF	ReadBody__xPCM__TR05XSFIO
	XREF	WriteBody__xPCM__TR05XSFIO
	XREF	Delete__PCM__Ts
	XREF	New__PCM__Tjjj
	XREF	SaveRaw16__PCM__TPCc
	XREF	LoadRaw16__PCM__TPCcUss
	XREF	Data__PCM__T
	XREF	Free__PCM__T
	XREF	_0ct__XSFOBJ__T
	XREF	Set__XSFHEAD__TPCcUcUcUcUc
	XREF	op__equal__XSFHEAD__TR05XSFIO
	XREF	op__equal__XSFHEAD__TR07XSFHEAD
	XREF	op__notEqual__XSFHEAD__TR07XSFHEAD
	XREF	Value__XDATAID__TPCc
	XREF	Close__xFILEIO__T
	XREF	Flush__xFILEIO__T
	XREF	Write64Swap__xFILEIO__TPvUi
	XREF	Write32Swap__xFILEIO__TPvUi
	XREF	Write16Swap__xFILEIO__TPvUi
	XREF	Write__xFILEIO__TPvUiUi
	XREF	Read64Swap__xFILEIO__TPvUi
	XREF	Read32Swap__xFILEIO__TPvUi
	XREF	Read16Swap__xFILEIO__TPvUi
	XREF	Read__xFILEIO__TPvUiUi
	XREF	Tell__xFILEIO__T
	XREF	Seek__xFILEIO__Tjj
	XREF	Open__xFILEIO__TPCcjj
	XREF	SendPacket__xFILEIO__TPv
	XREF	WaitPacket__xFILEIO__T
	XREF	InputQueued__xINPUT__T
	XREF	Idle__xINPUT__T
	XREF	ExitEvent__xINPUT__T
	XREF	MouseEvent__xINPUT__Tjjj
	XREF	ApplyInputModification__xINPUT__T
	XREF	_0dt__xKEY__T
	XREF	_0ct__xKEY__T
	XREF	KeyEvent__xKEY__Tjsj
	XREF	Zero__MEM__r8Pvr0Ui
	XREF	_strncmp
	XREF	_system
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_st
	XREF	_gxSt
	XREF	_numStartArgs__xBASELIB
	XREF	_startArgs__xBASELIB
	XREF	_SysBase
	XREF	_IntuitionBase
	XREF	_TimerBase
	XREF	_DOSBase
	XREF	_PowerPCBase
	XREF	_sysData__sysBASELIB
	XREF	_msgbuff__sysBASELIB
	XREF	_main__sysBASELIB
	XREF	_allocated__MEM
	XREF	_totSize__MEM
	XREF	_nextFree__MEM
	XREF	_cnt__MEM
	XREF	_maxAllocs__MEM
	XREF	_fpuPrecision__CPU
	XREF	_cpuNames__CPU
	XREF	_KeymapBase
	XREF	_useCount__xKEY
	XREF	_AHIBase
	XREF	_AHIport__xAUDIO
	XREF	_AHImain__xAUDIO
	XREF	_flags__xAUDIO
	XREF	_sigXSF__XSFHEAD
	XREF	_fileMarker__XSFOBJ
	XREF	_rawSig__PCM

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "DecodeFreq__AIFF__TPv:0",CODE


;sint32	AIFF::DecodeFreq(void* data)
	XDEF	DecodeFreq__AIFF__TPv
DecodeFreq__AIFF__TPv
L61	EQU	-$18
	link	a5,#L61
	movem.l	d2-d4,-(a7)
	fmovem.x fp2/fp3,-(a7)
	move.l	$C(a5),a0
L47
;	uint8* bytes = (uint8*)data;
;	sint32	expnt		= (((*bytes++) & 0x7F)<<8) | ((*bytes++) & 0xFF);
	moveq	#0,d3
	move.b	(a0)+,d3
	and.l	#$7F,d3
	moveq	#$8,d0
	asl.l	d0,d3
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$FF,d0
	or.l	d0,d3
;	uint32	hiMant	= ((uint32)((*bytes++) & 0xFF)<<24)
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$FF,d0
	moveq	#$18,d1
	asl.l	d1,d0
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$FF,d1
	moveq	#$10,d2
	asl.l	d2,d1
	or.l	d1,d0
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$FF,d1
	moveq	#$8,d2
	asl.l	d2,d1
	or.l	d1,d0
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$FF,d1
	or.l	d1,d0
;	uint32	loMant	= ((uint32)((*bytes++) & 0xFF)<<24)
	moveq	#0,d2
	move.b	(a0)+,d2
	and.l	#$FF,d2
	moveq	#$18,d1
	asl.l	d1,d2
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$FF,d1
	moveq	#$10,d4
	asl.l	d4,d1
	or.l	d1,d2
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$FF,d1
	moveq	#$8,d4
	asl.l	d4,d1
	or.l	d1,d2
	moveq	#0,d1
	move.b	(a0),d1
	and.l	#$FF,d1
	or.l	d1,d2
;	if ((!expnt) && (!hiMant) && (!loMant))
	tst.l	d3
	bne.b	L51
L48
	tst.l	d0
	bne.b	L51
L49
	tst.l	d2
	bne.b	L51
L50
;		f = 0;
	fmove.d	#$.00000000.00000000,fp2
	bra	L54
L51
;		if (expnt == 0x7FFF)
	cmp.l	#$7FFF,d3
	bne.b	L53
L52
;			f = HUGE_VAL;
	fmove.d	#$.7FEFFFFF.FFFFFFF0,fp2
	bra.b	L54
L53
;			expnt -= 16383;
	sub.l	#$3FFF,d3
;			f	=		ldexp(U2F(hiMant), expnt-=31);
	sub.l	#$1F,d3
	move.l	d3,-(a7)
	sub.l	#$7FFFFFFF,d0
	subq.l	#1,d0
	fmove.l	d0,fp0
	fadd.d	#$.41DFFFFF.E0000000,fp0
	fmove.d	fp0,-(a7)
	jsr	_ldexp__r
	add.w	#$C,a7
	fmove.x	fp0,fp2
;			f	+=	ldexp(U2F(loMant), expnt-=32);
	sub.l	#$20,d3
	move.l	d3,-(a7)
	sub.l	#$7FFFFFFF,d2
	subq.l	#1,d2
	fmove.l	d2,fp0
	fadd.d	#$.41DFFFFF.E0000000,fp0
	fmove.d	fp0,-(a7)
	jsr	_ldexp__r
	add.w	#$C,a7
	fadd.x	fp0,fp2
L54
	fmove.d	#$.40EF4000.00000000,fp3
	fmove.d	#$.40B13A00.00000000,fp1
	fmove.x	fp2,fp0
	fcmp.x	fp1,fp0
	fboge.b	L56
L55
	fmove.x	fp1,fp0
	bra.b	L60
L56
	fcmp.x	fp3,fp0
	fbole.b	L58
L57
	fmove.x	fp3,fp0
L58
L59
L60
	fmove.l	fp0,d0
	fmovem.x (a7)+,fp2/fp3
	movem.l	(a7)+,d2-d4
	unlk	a5
	rts

	SECTION "EncodeFreq__AIFF__TPvj:0",CODE


;void	AIFF::EncodeFreq(void* data, sint32 f)
	XDEF	EncodeFreq__AIFF__TPvj
EncodeFreq__AIFF__TPvj
L65	EQU	-$28
	link	a5,#L65
	movem.l	d2/d3/a2,-(a7)
	fmovem.x fp2/fp3,-(a7)
	move.l	$10(a5),d0
	move.l	$C(a5),a2
L62
;	if (f==0)
	tst.l	d0
	bne.b	L64
L63
;		MEM::Zero(data,10);
	moveq	#$A,d0
	move.l	a2,a0
	jsr	Zero__MEM__r8Pvr0Ui
	fmovem.x (a7)+,fp2/fp3
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts
L64
;		float64	frq			= (float64)f;
	fmove.l	d0,fp0
;		int			expnt		= 0;
	clr.l	-$C(a5)
;		float64 fMant		= frexp(frq, &expnt);
	pea	-$C(a5)
	fmove.d	fp0,-(a7)
	jsr	_frexp__r
	add.w	#$C,a7
;		expnt 					+= 16383;
	add.l	#$3FFF,-$C(a5)
;		fMant						= ldexp(fMant, 32);
	pea	$20.w
	fmove.d	fp0,-(a7)
	jsr	_ldexp__r
	add.w	#$C,a7
	fmove.x	fp0,fp2
;		float64	fsMant	= floor(fMant);
	fmove.d	fp2,-(a7)
	jsr	_floor__r
	addq.w	#$8,a7
;		uint32	hiMant	= F2U(fsMant);
	fmove.x	fp0,fp1
	fsub.d	#$.41DFFFFF.E0000000,fp1
	fmove.l	fp1,d2
	add.l	#$7FFFFFFF,d2
	addq.l	#1,d2
;		fMant						= ldexp(fMant - fsMant, 32);
	pea	$20.w
	fsub.x	fp0,fp2
	fmove.d	fp2,-(a7)
	jsr	_ldexp__r
	add.w	#$C,a7
;		fsMant					= floor(fMant);
	fmove.d	fp0,-(a7)
	jsr	_floor__r
	addq.w	#$8,a7
;		uint32	loMant	= F2U(fsMant);
	fsub.d	#$.41DFFFFF.E0000000,fp0
	fmove.l	fp0,d0
	add.l	#$7FFFFFFF,d0
	addq.l	#1,d0
;		sint8*	bytes		= (sint8*)data;
	move.l	a2,a0
;		*bytes++ = (expnt >> 8)		& 0x000000FF;
	move.l	-$C(a5),d1
	moveq	#$8,d3
	asr.l	d3,d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;		*bytes++ = (expnt)				& 0x000000FF;
	move.l	-$C(a5),d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;		*bytes++ = (hiMant >> 24)	& 0x000000FF;
	move.l	d2,d1
	moveq	#$18,d3
	lsr.l	d3,d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;		*bytes++ = (hiMant >> 16)	& 0x000000FF;
	move.l	d2,d1
	moveq	#$10,d3
	lsr.l	d3,d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;		*bytes++ = (hiMant >> 8)	& 0x000000FF;
	move.l	d2,d1
	moveq	#$8,d3
	lsr.l	d3,d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;		*bytes++ = (hiMant)				& 0x000000FF;
	and.l	#$FF,d2
	move.b	d2,d1
	move.b	d1,(a0)+
;		*bytes++ = (loMant >> 24)	& 0x000000FF;
	move.l	d0,d1
	moveq	#$18,d2
	lsr.l	d2,d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;		*bytes++ = (loMant >> 16)	& 0x000000FF;
	move.l	d0,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;		*bytes++ = (loMant >> 8)	& 0x000000FF;
	move.l	d0,d1
	moveq	#$8,d2
	lsr.l	d2,d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;		*bytes   = (loMant)				& 0x000000FF;
	and.l	#$FF,d0
	move.b	d0,(a0)
	fmovem.x (a7)+,fp2/fp3
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts

	SECTION "Load__AIFF__TPCc:0",CODE


;sint32 AIFF::Load(const char* name)
	XDEF	Load__AIFF__TPCc
Load__AIFF__TPCc
L106	EQU	-$D4
	link	a5,#L106
	movem.l	d2/a2/a3,-(a7)
	move.l	$C(a5),a1
	move.l	$8(a5),a2
L70
;	xFILEIO source(name, xIOS::READ);
	lea	-$9A(a5),a0
	clr.l	(a0)
	clr.l	$96(a0)
	pea	$400.w
	pea	1.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Open__xFILEIO__TPCcjj
	add.w	#$10,a7
	lea	-$9A(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__xFILEIO__T,-(a1)
	XREF	sym_handlers
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;	if (!source.Valid())
	move.l	-4(a5),d0
	and.l	#$40,d0
	tst.w	d0
	bne.b	L72
L71
	lea	-$A6(a5),a0
	XREF	lib_destruct_a0
	jsr	lib_destruct_a0
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L72
;	if ( (source.Read8(chunkName, 4)!=4)	||	(strncmp(chunkName, "FORM"
	pea	4.w
	pea	1.w
	pea	-$AA(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#4,d0
	bne	L77
L73
	pea	4.w
	move.l	#L66,-(a7)
	pea	-$AA(a5)
	jsr	_strncmp
	add.w	#$C,a7
	tst.l	d0
	bne.b	L77
L74
	pea	1.w
	pea	4.w
	pea	-$AE(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L77
L75
	pea	4.w
	pea	1.w
	pea	-$AA(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#4,d0
	bne.b	L77
L76
	pea	4.w
	move.l	#L67,-(a7)
	pea	-$AA(a5)
	jsr	_strncmp
	add.w	#$C,a7
	tst.l	d0
	beq.b	L78
L77
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L78
;	if ( (source.Read8(chunkName, 4)!=4)	||	(strncmp(chunkName, "COMM"
	pea	4.w
	pea	1.w
	pea	-$AA(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#4,d0
	bne	L86
L79
	pea	4.w
	move.l	#L68,-(a7)
	pea	-$AA(a5)
	jsr	_strncmp
	add.w	#$C,a7
	tst.l	d0
	bne	L86
L80
	pea	1.w
	pea	4.w
	pea	-$B2(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne	L86
L81
	move.l	-$B2(a5),d0
	cmp.l	#$12,d0
	bne	L86
L82
	pea	1.w
	pea	2.w
	pea	-$B8(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L86
L83
	pea	1.w
	pea	4.w
	pea	-$B6(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L86
L84
	pea	1.w
	pea	2.w
	pea	-$BA(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L86
L85
	pea	$A.w
	pea	1.w
	pea	-$C4(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#$A,d0
	beq.b	L87
L86
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L87
;	if (bitsPerSample!=16)
	move.w	-$BA(a5),d0
	cmp.w	#$10,d0
	beq.b	L89
L88
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L89
;	sint32 frq = DecodeFreq(freq);
	pea	-$C4(a5)
	move.l	a2,-(a7)
	jsr	DecodeFreq__AIFF__TPv
	addq.w	#$8,a7
	move.l	d0,d2
;	if ( (source.Read8(chunkName, 4)!=4)	||	(strncmp(chunkName, "SSND"
	pea	4.w
	pea	1.w
	pea	-$AA(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#4,d0
	bne	L94
L90
	pea	4.w
	move.l	#L69,-(a7)
	pea	-$AA(a5)
	jsr	_strncmp
	add.w	#$C,a7
	tst.l	d0
	bne.b	L94
L91
	pea	1.w
	pea	4.w
	pea	-$B2(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L94
L92
	pea	1.w
	pea	4.w
	pea	-$CC(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L94
L93
	pea	1.w
	pea	4.w
	pea	-$D0(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	beq.b	L95
L94
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L95
;	if (blockSize)
	tst.l	-$D0(a5)
	beq.b	L97
L96
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L97
;	if (offset)
	tst.l	-$CC(a5)
	beq.b	L99
L98
;		source.Seek(offset, xIOS::CURRENT);
	clr.l	-(a7)
	move.l	-$CC(a5),-(a7)
	pea	-$9A(a5)
	jsr	Seek__xFILEIO__Tjj
	add.w	#$C,a7
L99
;	if (Data())
	move.l	a2,-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L101
L100
;		Delete();
	move.w	#1,-(a7)
	move.l	a2,-(a7)
	jsr	Delete__PCM__Ts
	addq.w	#6,a7
L101
;	if (New(samples, chan, frq)!=OK || !Data())
	move.l	d2,-(a7)
	moveq	#0,d0
	move.w	-$B8(a5),d0
	move.l	d0,-(a7)
	move.l	-$B6(a5),-(a7)
	move.l	a2,-(a7)
	jsr	New__PCM__Tjjj
	add.w	#$10,a7
	tst.l	d0
	bne.b	L103
L102
	move.l	a2,-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	bne.b	L104
L103
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L104
;	if (READBIG16(source, Data(), Size())!=Size())
	move.l	4(a2),d2
	move.l	a2,-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	move.l	d2,-(a7)
	pea	2.w
	move.l	d0,-(a7)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
L105
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts

L67
	dc.b	'AIFF',0
L68
	dc.b	'COMM',0
L66
	dc.b	'FORM',0
L69
	dc.b	'SSND',0

	SECTION "Save__AIFF__TPCc:0",CODE


;sint32 AIFF::Save(const char* name)
	XDEF	Save__AIFF__TPCc
Save__AIFF__TPCc
L135	EQU	-$C8
	link	a5,#L135
	movem.l	d2/a2/a3,-(a7)
	movem.l	$8(a5),a2/a3
L111
;	if (!Data())
	move.l	a2,-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	bne.b	L113
L112
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L113
;	xFILEIO dest(name, xIOS::WRITE);
	lea	-$9A(a5),a0
	move.l	a3,a1
	clr.l	(a0)
	clr.l	$96(a0)
	pea	$400.w
	pea	2.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Open__xFILEIO__TPCcjj
	add.w	#$10,a7
	lea	-$9A(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__xFILEIO__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;	if (!dest.Valid())
	move.l	-4(a5),d0
	and.l	#$40,d0
	tst.w	d0
	bne.b	L115
L114
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L115
;	uint32 chunkSize = AIFFHEADSIZE + Size()*sizeof(sint16);
	move.l	4(a2),d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	#$2E,d0
	move.l	d0,-$AA(a5)
;	if ( (dest.Write8("FORM",4)!=4)	||	(WRITEBIG32(dest,&chunkSize,1)!
	pea	4.w
	pea	1.w
	move.l	#L107,-(a7)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#4,d0
	bne.b	L118
L116
	pea	1.w
	pea	4.w
	pea	-$AA(a5)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L118
L117
	pea	4.w
	pea	1.w
	move.l	#L108,-(a7)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#4,d0
	beq.b	L119
L118
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L119
;	chunkSize					= COMMSIZE;
	move.l	#$12,-$AA(a5)
;	uint32 samples		= Length();
	move.l	a2,a0
	tst.w	$C(a0)
	bne.b	L121
L120
	moveq	#0,d0
	bra.b	L122
L121
	move.w	$C(a0),d1
	ext.l	d1
	move.l	4(a0),d0
	divsl.l	d1,d0
L122
	move.l	d0,-$AE(a5)
;	uint16 chan				= Channels();
	move.w	$C(a2),-$B0(a5)
;	uint16 bits				= 16;
	move.w	#$10,-$B2(a5)
;	EncodeFreq(freq, Frequency());
	moveq	#0,d0
	move.w	$E(a2),d0
	move.l	d0,-(a7)
	pea	-$BC(a5)
	move.l	a2,-(a7)
	jsr	EncodeFreq__AIFF__TPvj
	add.w	#$C,a7
;	if ( (dest.Write8("COMM",4)!=4)	||	(WRITEBIG32(dest,&chunkSize,1)!
	pea	4.w
	pea	1.w
	move.l	#L109,-(a7)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#4,d0
	bne	L128
L123
	pea	1.w
	pea	4.w
	pea	-$AA(a5)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne	L128
L124
	pea	1.w
	pea	2.w
	pea	-$B0(a5)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L128
L125
	pea	1.w
	pea	4.w
	pea	-$AE(a5)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L128
L126
	pea	1.w
	pea	2.w
	pea	-$B2(a5)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L128
L127
	pea	$A.w
	pea	1.w
	pea	-$BC(a5)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#$A,d0
	beq.b	L129
L128
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L129
;	chunkSize				= SSNDSIZE + Size()*sizeof(sint16);
	move.l	4(a2),d0
	moveq	#1,d1
	asl.l	d1,d0
	addq.l	#$8,d0
	move.l	d0,-$AA(a5)
;	uint32 dummy[2]	= {0};
	lea	-$C4(a5),a0
	clr.l	(a0)+
	clr.l	(a0)+
;	if ( (dest.Write8("SSND",4)!=4)	||	(WRITEBIG32(dest,&chunkSize,1)!
	pea	4.w
	pea	1.w
	move.l	#L110,-(a7)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#4,d0
	bne.b	L132
L130
	pea	1.w
	pea	4.w
	pea	-$AA(a5)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#1,d0
	bne.b	L132
L131
	pea	2.w
	pea	4.w
	pea	-$C4(a5)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#2,d0
	beq.b	L133
L132
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L133
;	if (WRITEBIG16(dest,Data(),Size())!=Size())
	move.l	4(a2),d2
	move.l	a2,-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	move.l	d2,-(a7)
	pea	2.w
	move.l	d0,-(a7)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
L134
	lea	-$A6(a5),a0
	jsr	lib_destruct_a0
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts

L108
	dc.b	'AIFF',0
L109
	dc.b	'COMM',0
L107
	dc.b	'FORM',0
L110
	dc.b	'SSND',0

	SECTION "_0dt__xFILEIO__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__xFILEIO__T
_0dt__xFILEIO__T
L137	EQU	0
	link	a5,#L137
	move.l	$8(a5),a0
L136
	move.l	a0,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	unlk	a5
	rts

	END
