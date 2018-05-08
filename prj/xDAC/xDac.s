
; Storm C Compiler
; Developer:eXtropia/eXtropiaOld/prj/xDAC/xDac.cpp
	mc68030
	mc68881
	XREF	DecodeEitherFrames__XDAC__TPsj
	XREF	DecodeAlternFrames__XDAC__TPsj
	XREF	DecodeMergedFrames__XDAC__TPsj
	XREF	DecodeMonoFrames__XDAC__TPsj
	XREF	DecodeMergedStereo__XDAC__TPsj
	XREF	_0dt__XDACENCODE__T
	XREF	Write__XDACENCODE__TR05XSFIO
	XREF	op__Cplusplus__XDACENCODE__Ti
	XREF	First__XDACENCODE__T
	XREF	Set__XDACENCODE__TR03PCMsss
	XREF	FreeSpace__XDACENCODE__T
	XREF	Delete__xPCM__T
	XREF	ReadBody__xPCM__TR05XSFIO
	XREF	WriteBody__xPCM__TR05XSFIO
	XREF	New__PCM__Tjjj
	XREF	SaveRaw16__PCM__TPCc
	XREF	LoadRaw16__PCM__TPCcUss
	XREF	Data__PCM__T
	XREF	Free__PCM__T
	XREF	_0ct__XSFOBJ__TPCcUsUsUcUc
	XREF	_0ct__XSFOBJ__T
	XREF	Read__XSFOBJ__TR05XSFIO
	XREF	Write__XSFOBJ__TR05XSFIO
	XREF	Create__XSFBASIC__TPCcj
	XREF	Open__XSFBASIC__TPCcsjj
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
	XREF	_0dt__LOCK__T
	XREF	_0dt__THREAD__T
	XREF	Run__THREAD__T
	XREF	_0dt__DELAY__T
	XREF	_0ct__DELAY__T
	XREF	Pause__DELAY__TUj
	XREF	Pause__DELAY__TUjUj
	XREF	Abort__DELAY__T
	XREF	UnLink__xCHAINABLE__T
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__UisE
	XREF	_system
	XREF	_abs
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
	XREF	_TimerBase__MILLICLOCK
	XREF	_current__MILLICLOCK
	XREF	_clockFreq__MILLICLOCK
	XREF	_threadCnt__THREAD
	XREF	_threadsIdle__THREAD
	XREF	_rootThread__THREAD
	XREF	_AHIBase
	XREF	_AHIport__xAUDIO
	XREF	_AHImain__xAUDIO
	XREF	_flags__xAUDIO
	XREF	_KeymapBase
	XREF	_useCount__xKEY
	XREF	_sigXSF__XSFHEAD
	XREF	_fileMarker__XSFOBJ
	XREF	_rawSig__PCM

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_xDAC_XSFDesc:1",DATA

	XDEF	_xDAC_XSFDesc
_xDAC_XSFDesc
	dc.b	'eXtropia Delta Audio Compression',0

	SECTION "_0ct__XDAC__T:0",CODE


;XDAC::XDAC() 
	XDEF	_0ct__XDAC__T
_0ct__XDAC__T
	XREF	sym_handlers
L74	EQU	-$C
	link	a5,#L74
	movem.l	a2/a3,-(a7)
	move.l	$8(a5),a2
L73
	move.l	sym_handlers,a3
	clr.b	-(a7)
	move.b	#1,-(a7)
	move.w	#2,-(a7)
	move.w	#$200,-(a7)
	move.l	#_xDAC_XSFDesc,-(a7)
	move.l	a2,-(a7)
	jsr	_0ct__XSFOBJ__TPCcUsUsUcUc
	add.w	#$10,a7
	lea	(a5),a0
	move.l	a2,-(a0)
	move.l	#_0dt__XSFOBJ__T,-(a0)
	move.l	sym_handlers,-(a0)
	move.l	a0,sym_handlers
	lea	$20(a2),a0
	clr.l	(a0)
	clr.w	4(a0)
	clr.w	6(a0)
	clr.w	$8(a0)
	clr.w	$A(a0)
	clr.l	$2C(a2)
	clr.l	$30(a2)
	clr.l	$34(a2)
	clr.l	$38(a2)
;	RawSize(sizeof(shared));
	move.l	#$C,$C(a2)
	move.l	a3,sym_handlers
	movem.l	(a7)+,a2/a3
	unlk	a5
	rts

	SECTION "_0ct__XDAC__TjsUsUsPUsUs:0",CODE


;XDAC::XDAC(sint32 n, sint16 l, uint16 c, uint16 f, uint16* d, 
	XDEF	_0ct__XDAC__TjsUsUsPUsUs
_0ct__XDAC__TjsUsUsPUsUs
L76	EQU	-$C
	link	a5,#L76
	movem.l	d2-d6/a2/a3/a6,-(a7)
	move.w	$12(a5),d2
	move.w	$14(a5),d3
	move.w	$1A(a5),d4
	move.l	$C(a5),d5
	move.w	$10(a5),d6
	move.l	$8(a5),a2
	move.l	$16(a5),a6
L75
	move.l	sym_handlers,a3
	clr.b	-(a7)
	move.b	#1,-(a7)
	move.w	#2,-(a7)
	move.w	#$200,-(a7)
	move.l	#_xDAC_XSFDesc,-(a7)
	move.l	a2,-(a7)
	jsr	_0ct__XSFOBJ__TPCcUsUsUcUc
	add.w	#$10,a7
	lea	(a5),a0
	move.l	a2,-(a0)
	move.l	#_0dt__XSFOBJ__T,-(a0)
	move.l	sym_handlers,-(a0)
	move.l	a0,sym_handlers
	lea	$20(a2),a0
	move.l	d5,(a0)
	move.w	d6,4(a0)
	move.w	d2,6(a0)
	move.w	d3,$8(a0)
	move.w	d4,$A(a0)
	clr.l	$2C(a2)
	move.l	a6,$30(a2)
	clr.l	$34(a2)
	clr.l	$38(a2)
;	RawSize(sizeof(shared));
	move.l	#$C,$C(a2)
	move.l	a3,sym_handlers
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "ReadBody__XDAC__TR05XSFIO:0",CODE


;sint32 XDAC::ReadBody(XSFIO& f)
	XDEF	ReadBody__XDAC__TR05XSFIO
ReadBody__XDAC__TR05XSFIO
L89	EQU	-4
	link	a5,#L89
	movem.l	d2/a2/a3,-(a7)
	movem.l	$8(a5),a2/a3
L77
;	if (ownData)
	tst.l	$2C(a2)
	beq.b	L79
L78
;		MEM::Free(ownData);
	move.l	$2C(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L79
;	sint32 size = RawSize()-sizeof(shared);
	move.l	$C(a2),d2
	sub.l	#$C,d2
;	data=0;
	clr.l	$30(a2)
;	if ( size<=sizeof(shared) )
	cmp.l	#$C,d2
	bgt.b	L81
L80
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L81
;	data = ownData = (uint16*)MEM::Alloc(size);
	clr.l	-(a7)
	clr.w	-(a7)
	move.l	d2,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,$2C(a2)
	move.l	d0,$30(a2)
;	if (!data)
	tst.l	$30(a2)
	bne.b	L83
L82
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L83
;	size/=sizeof(sint16);
	divsl.l	#2,d2
;	f.Read32(&(shared.numFrames),1);
	pea	1.w
	pea	$20(a2)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	f.Read16(&(shared.frameLen), 4);
	pea	4.w
	pea	$24(a2)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$84(a0),d0
	move.l	d0,-(a7)
	move.l	$80(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	if (shared.channels<1 || shared.channels>4)
	tst.w	$26(a2)
	beq.b	L85
L84
	move.w	$26(a2),d0
	cmp.w	#4,d0
	bls.b	L86
L85
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L86
;	if (f.Read16(data, size)!=size)
	move.l	d2,-(a7)
	move.l	$30(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$84(a0),d0
	move.l	d0,-(a7)
	move.l	$80(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	d2,d0
	beq.b	L88
L87
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L88
;	frameNum = 0;
	clr.l	$38(a2)
;	current = data;
	move.l	$30(a2),a0
	move.l	a0,$34(a2)
	move.l	$C(a2),d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts

	SECTION "WriteBody__XDAC__TR05XSFIO:0",CODE


;sint32 XDAC::WriteBody(XSFIO& f)
	XDEF	WriteBody__XDAC__TR05XSFIO
WriteBody__XDAC__TR05XSFIO
L96	EQU	-4
	link	a5,#L96
	movem.l	d2/a2/a3,-(a7)
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L90
;	if (!f.Valid())
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$4C(a0),d0
	move.l	d0,-(a7)
	move.l	$48(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	tst.w	d0
	bne.b	L92
L91
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L92
;	f.Write32(&(shared.numFrames),1);
	pea	1.w
	pea	$20(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	f.Write16(&(shared.frameLen), 4);
	pea	4.w
	pea	$24(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	if (data)
	move.l	a3,a1
	tst.l	$30(a1)
	beq.b	L95
L93
;		sint32 size = (RawSize()-sizeof(shared))/sizeof(sint16);
	move.l	$C(a3),d2
	sub.l	#$C,d2
	moveq	#1,d0
	lsr.l	d0,d2
;		if (f.Write16(data, size)!=size)
	move.l	d2,-(a7)
	move.l	a3,a1
	move.l	$30(a1),-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	d2,d0
	beq.b	L95
L94
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L95
	move.l	$C(a3),d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts

	SECTION "Frame__XDAC__Tj:0",CODE


;sint32 XDAC::Frame(sint32 f)
	XDEF	Frame__XDAC__Tj
Frame__XDAC__Tj
L118	EQU	-$C
	link	a5,#L118
	movem.l	d2-d6/a2/a3,-(a7)
	move.l	$C(a5),d5
	move.l	$8(a5),a3
L97
;	if (!data)
	move.l	a3,a1
	tst.l	$30(a1)
	bne.b	L99
L98
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts
L99
;	if (f==frameNum)
	move.l	a3,a0
	cmp.l	$38(a0),d5
	bne.b	L101
L100
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts
L101
;	f = Clamp(f, 0, shared.numFrames);
	move.l	$20(a3),d2
	moveq	#0,d1
	move.l	d5,d0
	cmp.l	d1,d0
	bge.b	L103
L102
	move.l	d1,d5
	bra.b	L107
L103
	cmp.l	d2,d0
	ble.b	L105
L104
	move.l	d2,d5
	bra.b	L106
L105
	move.l	d0,d5
L106
L107
;	rsint32		scan = f;
	move.l	d5,d3
;	ruint16*	pos = data;
	move.l	a3,a0
	move.l	$30(a0),a2
;		sint32 t = abs(f-frameNum);
	move.l	a3,a0
	move.l	d5,d0
	sub.l	$38(a0),d0
	move.l	d0,-(a7)
	jsr	_abs
	addq.w	#4,a7
;		if (t < scan)
	cmp.l	d3,d0
	bge.b	L109
L108
;			scan = t;
	move.l	d0,d3
;			pos = current;
	move.l	a3,a0
	move.l	$34(a0),a2
L109
;		scan++;
	addq.l	#1,d3
;	while(--scan)
	bra	L116
L110
;		ruint16 c = *pos;
	move.w	(a2),d2
;		if (XDAC_SILENCE(c))
	moveq	#0,d0
	move.w	d2,d0
	and.l	#$8000,d0
	beq.b	L112
L111
;			pos+= XDAC_SLNC_LEN(c);
	moveq	#0,d0
	move.w	d2,d0
	and.l	#$FFF,d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
	bra.b	L116
L112
;			rsint16 spw = (8*sizeof(sint16))/XDAC_BITRATE(c);
	moveq	#0,d0
	move.w	d2,d0
	and.l	#$300,d0
	moveq	#$8,d1
	asr.l	d1,d0
	addq.l	#2,d0
	moveq	#$10,d1
	divul.l	d0,d1
	move.w	d1,d4
;			rsint32 skip = shared.frameLen*shared.channels;
	move.w	$24(a3),d1
	mulu	$26(a3),d1
;			pos += ((skip/spw) + ((skip%spw)?1:0) + XDAC_TABLESIZE(c) + sh
	move.w	d4,d0
	ext.l	d0
	move.l	d1,d6
	divsl.l	d0,d6
	move.l	d6,d0
	ext.l	d4
	divsl.l	d4,d4:d1
	tst.l	d4
	beq.b	L114
L113
	moveq	#1,d1
	bra.b	L115
L114
	moveq	#0,d1
L115
	add.l	d1,d0
	moveq	#0,d1
	move.w	d2,d1
	and.l	#$1F,d1
	addq.l	#1,d1
	add.l	d1,d0
	moveq	#0,d1
	move.w	$26(a3),d1
	add.l	d1,d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
L116
	subq.l	#1,d3
	tst.l	d3
	bne	L110
L117
;	frameNum = f;
	move.l	a3,a0
	move.l	d5,$38(a0)
;	current = pos;
	move.l	a3,a0
	move.l	a2,$34(a0)
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "DecodeFrames__XDAC__TPsjj:0",CODE


;sint32 XDAC::DecodeFrames(sint16* dest, sint32 start, sint32 num)
	XDEF	DecodeFrames__XDAC__TPsjj
DecodeFrames__XDAC__TPsjj
L131	EQU	0
	link	a5,#L131
	movem.l	d2/a2/a3,-(a7)
	movem.l	$10(a5),d0/d2
	movem.l	$8(a5),a2/a3
L119
;	if (!num)		
	tst.l	d2
	bne.b	L121
L120
;	if (!num)		num = shared.numFrames;
	move.l	$20(a2),d2
L121
;	if (start)	
	tst.l	d0
	beq.b	L123
L122
;	if (start)	Frame(start);
	move.l	d0,-(a7)
	move.l	a2,-(a7)
	jsr	Frame__XDAC__Tj
	addq.w	#$8,a7
L123
;	switch (XDAC_G_CHANS(shared.globalOpts))
	moveq	#0,d0
	move.w	$2A(a2),d0
	and.l	#3,d0
	cmp.l	#2,d0
	beq.b	L128
	bgt.b	L132
	cmp.l	#0,d0
	beq.b	L124
	cmp.l	#1,d0
	beq.b	L125
	bra	L130
L132
	cmp.l	#3,d0
	beq.b	L129
	bra	L130
;		
L124
	move.l	d2,-(a7)
	move.l	a3,-(a7)
	move.l	a2,-(a7)
	jsr	DecodeMonoFrames__XDAC__TPsj
	add.w	#$C,a7
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L125
;			if (shared.channels==2)
	move.w	$26(a2),d0
	cmp.w	#2,d0
	bne.b	L127
L126
	move.l	d2,-(a7)
	move.l	a3,-(a7)
	move.l	a2,-(a7)
	jsr	DecodeMergedStereo__XDAC__TPsj
	add.w	#$C,a7
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L127
	move.l	d2,-(a7)
	move.l	a3,-(a7)
	move.l	a2,-(a7)
	jsr	DecodeMergedFrames__XDAC__TPsj
	add.w	#$C,a7
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L128
	move.l	d2,-(a7)
	move.l	a3,-(a7)
	move.l	a2,-(a7)
	jsr	DecodeAlternFrames__XDAC__TPsj
	add.w	#$C,a7
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L129
	move.l	d2,-(a7)
	move.l	a3,-(a7)
	move.l	a2,-(a7)
	jsr	DecodeEitherFrames__XDAC__TPsj
	add.w	#$C,a7
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L130
;			
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts

	SECTION "_0ct__XDACCODEC__Tjj:0",CODE


;XDACCODEC::XDACCODEC(sint32 size, sint32 bits) 
	XDEF	_0ct__XDACCODEC__Tjj
_0ct__XDACCODEC__Tjj
L146	EQU	-$C
	link	a5,#L146
	movem.l	d2/d3/a2,-(a7)
	movem.l	$C(a5),d0/d3
	move.l	$8(a5),a0
L133
	move.l	sym_handlers,a1
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$8(a0)
	clr.l	$C(a0)
	clr.w	$2C(a0)
	lea	(a5),a2
	move.l	a0,-(a2)
	move.l	#_0dt__XDACENCODE__T,-(a2)
	move.l	sym_handlers,-(a2)
	move.l	a2,sym_handlers
;	frameSize	= Clamp(size, 32, 1024);
	move.l	#$400,d2
	moveq	#$20,d1
	cmp.l	d1,d0
	bge.b	L135
L134
	move.l	d1,d0
	bra.b	L139
L135
	cmp.l	d2,d0
	ble.b	L137
L136
	move.l	d2,d0
L137
L138
L139
	move.w	d0,$2C(a0)
;	bitRate		= Clamp(bits, 2, 5);
	moveq	#5,d2
	moveq	#2,d1
	move.l	d3,d0
	cmp.l	d1,d0
	bge.b	L141
L140
	move.l	d1,d0
	bra.b	L145
L141
	cmp.l	d2,d0
	ble.b	L143
L142
	move.l	d2,d0
L143
L144
L145
	move.w	d0,$30(a0)
	move.l	a1,sym_handlers
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts

	SECTION "_0dt__XDACCODEC__T:0",CODE


;XDACCODEC::~XDACCODEC()
	XDEF	_0dt__XDACCODEC__T
_0dt__XDACCODEC__T
L148	EQU	0
	link	a5,#L148
	move.l	$8(a5),a0
L147
;XDACCODEC::~XDACCODEC()
	move.l	a0,-(a7)
	jsr	_0dt__XDACENCODE__T
	addq.w	#4,a7
	unlk	a5
	rts

	SECTION "Encode__XDACCODEC__TPCcR03PCMs:0",CODE


;sint32 XDACCODEC::Encode(const char* file, PCM& pcm, bool fast)
	XDEF	Encode__XDACCODEC__TPCcR03PCMs
Encode__XDACCODEC__TPCcR03PCMs
L182	EQU	-$13C
	link	a5,#L182
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.w	$14(a5),d2
	move.l	$8(a5),a2
L150
;	if (!pcm.Data())
	move.l	$10(a5),-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	bne.b	L152
L151
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L152
;	if (Set(pcm, frameSize, bitRate, fast)!=OK)
	move.w	d2,-(a7)
	move.w	$30(a2),-(a7)
	move.w	$2C(a2),-(a7)
	move.l	$10(a5),-(a7)
	move.l	a2,-(a7)
	jsr	Set__XDACENCODE__TR03PCMsss
	add.w	#$E,a7
	tst.l	d0
	beq.b	L154
L153
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L154
;	XSFBASIC output(XDAC_IDSTRING, XDAC_VERSION, XDAC_REVISIO
	move.l	#_0virttab__08XSFBASIC__08XSFBASIC,-$AE(a5)
	lea	-$AE(a5),a0
	move.l	a0,a6
	move.l	sym_handlers,-$118(a5)
	lea	-$130(a5),a3
	move.l	a6,-(a3)
	move.l	#_0dt__XSFIO__T,-(a3)
	move.l	sym_handlers,-(a3)
	move.l	a3,sym_handlers
	moveq	#4,d4
	add.l	a6,d4
	move.l	d4,a3
	move.l	a3,a1
	move.b	#1,(a1)
	move.l	a3,a1
	clr.b	1(a1)
	clr.b	-(a7)
	move.b	#1,-(a7)
	move.b	#1,-(a7)
	clr.b	-(a7)
	move.l	#L149,-(a7)
	move.l	a3,-(a7)
	jsr	Set__XSFHEAD__TPCcUcUcUcUc
	add.w	#$10,a7
	lea	-$118(a5),a0
	move.l	a3,-(a0)
	move.l	#_0dt__XSFHEAD__T,-(a0)
	move.l	sym_handlers,-(a0)
	move.l	a0,sym_handlers
	lea	$10(a6),a0
	clr.l	(a0)
	clr.l	$96(a0)
	lea	-$124(a5),a1
	move.l	a0,-(a1)
	move.l	#_0dt__xFILEIO__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
	move.l	a6,a0
	clr.l	$AA(a0)
	move.l	-$118(a5),sym_handlers
	lea	-$AE(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__XSFBASIC__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;	output.Create(file);
	pea	$400.w
	move.l	$C(a5),-(a7)
	pea	-$AE(a5)
	jsr	Create__XSFBASIC__TPCcj
	add.w	#$C,a7
;	if (!output.Valid())
	lea	-$AE(a5),a0
	cmp.w	#0,a0
	beq.b	L156
L155
	add.w	#$10,a0
L156
	move.l	$96(a0),d0
	and.l	#$40,d0
	tst.w	d0
	bne.b	L158
L157
	lea	-$BA(a5),a0
	XREF	lib_destruct_a0
	jsr	lib_destruct_a0
	move.l	#-$3040006,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L158
;	sint32 filePos = output.Tell();
	lea	-$AE(a5),a0
	cmp.w	#0,a0
	beq.b	L160
L159
	add.w	#$10,a0
L160
	move.l	a0,-(a7)
	jsr	Tell__xFILEIO__T
	addq.w	#4,a7
	move.l	d0,d3
;	XDAC dummy(1+maxFrame, frameSize, pcm.Channels(), pcm.Frequen
	move.l	#_0virttab__04XDAC__04XDAC,-$DE(a5)
	lea	-$FA(a5),a1
	move.l	$10(a5),a0
	move.w	$C(a0),d0
	cmp.w	#1,d0
	ble.b	L162
L161
	moveq	#1,d0
	bra.b	L163
L162
	moveq	#0,d0
L163
	move.w	d0,-(a7)
	clr.l	-(a7)
	move.l	$10(a5),a0
	moveq	#0,d0
	move.w	$E(a0),d0
	move.w	d0,-(a7)
	move.l	$10(a5),a0
	move.w	$C(a0),-(a7)
	move.w	$2C(a2),-(a7)
	move.l	$20(a2),d0
	addq.l	#1,d0
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	jsr	_0ct__XDAC__TjsUsUsPUsUs
	add.w	#$14,a7
	lea	-$FA(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__XDAC__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;	dummy.Write(output);
	pea	-$AE(a5)
	pea	-$FA(a5)
	jsr	Write__XSFOBJ__TR05XSFIO
	addq.w	#$8,a7
;	sint32 totSize = 0;
	clr.l	-$10A(a5)
;	First();
	move.l	a2,-(a7)
	jsr	First__XDACENCODE__T
	addq.w	#4,a7
;	for (sint32 i=0;
	moveq	#0,d2
	bra.b	L169
L164
;		sint32 size = Write(output);
	pea	-$AE(a5)
	move.l	a2,-(a7)
	jsr	Write__XDACENCODE__TR05XSFIO
	addq.w	#$8,a7
;		if (size<0)
	tst.l	d0
	bpl.b	L168
L165
;			output.Close();
	lea	-$AE(a5),a0
	clr.l	$AA(a0)
	cmp.w	#0,a0
	beq.b	L167
L166
	add.w	#$10,a0
L167
	move.l	a0,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	lea	-$106(a5),a0
	jsr	lib_destruct_a0
	lea	-$BA(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L168
;		totSize += size;
	add.l	d0,-$10A(a5)
;		(*((XDACENCODE*)this))++;
	clr.l	-(a7)
	move.l	a2,-(a7)
	jsr	op__Cplusplus__XDACENCODE__Ti
	addq.w	#$8,a7
	addq.l	#1,d2
L169
	cmp.l	$20(a2),d2
	ble.b	L164
L170
;	totSize *= sizeof(uint16);
	move.l	-$10A(a5),d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,-$10A(a5)
;	totSize += dummy.RawSize();
	move.l	-$10A(a5),d0
	add.l	-$EE(a5),d0
	move.l	d0,-$10A(a5)
;	output.Seek(filePos+XSFOBJ_FILEOFFSET_RAWSIZE, xIOS::START);
	move.l	d3,d0
	add.l	#$10,d0
	lea	-$AE(a5),a0
	move.l	#-1,-(a7)
	move.l	d0,-(a7)
	cmp.w	#0,a0
	beq.b	L172
L171
	add.w	#$10,a0
L172
	move.l	a0,-(a7)
	jsr	Seek__xFILEIO__Tjj
	add.w	#$C,a7
;	output.Write32(&totSize,1);
	moveq	#1,d1
	lea	-$10A(a5),a1
	lea	-$AE(a5),a0
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L176
L173
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L175
L174
	add.w	#$10,a0
L175
	move.l	a0,-(a7)
	jsr	Write32Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L179
L176
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L178
L177
	add.w	#$10,a0
L178
	move.l	d0,-(a7)
	pea	4.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
L179
;	output.Close();
	lea	-$AE(a5),a0
	clr.l	$AA(a0)
	cmp.w	#0,a0
	beq.b	L181
L180
	add.w	#$10,a0
L181
	move.l	a0,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	lea	-$106(a5),a0
	jsr	lib_destruct_a0
	lea	-$BA(a5),a0
	jsr	lib_destruct_a0
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

L149
	dc.b	'xDAC',0

	SECTION "Decode__XDACCODEC__TPCcR03PCM:0",CODE


;sint32 XDACCODEC::Decode(const char* file, PCM& pcm)
	XDEF	Decode__XDACCODEC__TPCcR03PCM
Decode__XDACCODEC__TPCcR03PCM
L198	EQU	-$134
	link	a5,#L198
	movem.l	d2-d4/a2/a3/a6,-(a7)
	move.l	$10(a5),a6
L184
;	if (pcm.Data())
	move.l	a6,-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L186
L185
	move.l	#-$3020003,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L186
;	XSFBASIC input(XDAC_IDSTRING, XDAC_VERSION, XDAC_REVISION
	move.l	#_0virttab__08XSFBASIC__08XSFBASIC,-$AE(a5)
	lea	-$AE(a5),a0
	move.l	a0,a3
	move.l	sym_handlers,-$110(a5)
	lea	-$128(a5),a2
	move.l	a3,-(a2)
	move.l	#_0dt__XSFIO__T,-(a2)
	move.l	sym_handlers,-(a2)
	move.l	a2,sym_handlers
	lea	4(a3),a2
	move.b	#1,(a2)
	clr.b	1(a2)
	clr.b	-(a7)
	move.b	#1,-(a7)
	move.b	#1,-(a7)
	clr.b	-(a7)
	move.l	#L183,-(a7)
	move.l	a2,-(a7)
	jsr	Set__XSFHEAD__TPCcUcUcUcUc
	add.w	#$10,a7
	lea	-$110(a5),a0
	move.l	a2,-(a0)
	move.l	#_0dt__XSFHEAD__T,-(a0)
	move.l	sym_handlers,-(a0)
	move.l	a0,sym_handlers
	lea	$10(a3),a0
	clr.l	(a0)
	clr.l	$96(a0)
	lea	-$11C(a5),a1
	move.l	a0,-(a1)
	move.l	#_0dt__xFILEIO__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
	move.l	a3,a0
	clr.l	$AA(a0)
	move.l	-$110(a5),sym_handlers
	lea	-$AE(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__XSFBASIC__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;	input.Open(file, FALSE, xIOS::READ);
	pea	$400.w
	pea	1.w
	clr.w	-(a7)
	move.l	$C(a5),-(a7)
	pea	-$AE(a5)
	jsr	Open__XSFBASIC__TPCcsjj
	add.w	#$12,a7
;	if (!input.Valid())
	lea	-$AE(a5),a0
	cmp.w	#0,a0
	beq.b	L188
L187
	add.w	#$10,a0
L188
	move.l	$96(a0),d0
	and.l	#$40,d0
	tst.w	d0
	bne.b	L190
L189
	lea	-$BA(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L190
;	XDAC source;
	move.l	#_0virttab__04XDAC__04XDAC,-$DA(a5)
	pea	-$F6(a5)
	jsr	_0ct__XDAC__T
	addq.w	#4,a7
	lea	-$F6(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__XDAC__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;	if (source.Read(input)<0)
	pea	-$AE(a5)
	pea	-$F6(a5)
	jsr	Read__XSFOBJ__TR05XSFIO
	addq.w	#$8,a7
L191
;	input.Close();
	lea	-$AE(a5),a0
	clr.l	$AA(a0)
	cmp.w	#0,a0
	beq.b	L193
L192
	add.w	#$10,a0
L193
	move.l	a0,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
;	sint32 space = source.TotalFrames()*source.FrameLength();
	lea	-$F6(a5),a0
	move.l	$20(a0),d0
	lea	-$F6(a5),a0
	moveq	#0,d1
	move.w	$24(a0),d1
	muls.l	d1,d0
;	if (pcm.New(space, source.Channels(), source.Frequency())!=OK)
	lea	-$F6(a5),a0
	moveq	#0,d1
	move.w	$28(a0),d1
	move.l	d1,-(a7)
	lea	-$F6(a5),a0
	moveq	#0,d1
	move.w	$26(a0),d1
	move.l	d1,-(a7)
	move.l	d0,-(a7)
	move.l	a6,-(a7)
	jsr	New__PCM__Tjjj
	add.w	#$10,a7
	tst.l	d0
	beq.b	L195
L194
	lea	-$102(a5),a0
	jsr	lib_destruct_a0
	lea	-$BA(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L195
;	sint16* destData = pcm.Data();
	move.l	a6,-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	move.l	d0,a0
;	if (!destData)
	cmp.w	#0,a0
	bne.b	L197
L196
	lea	-$102(a5),a0
	jsr	lib_destruct_a0
	lea	-$BA(a5),a0
	jsr	lib_destruct_a0
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L197
;	source.DecodeFrames(destData);
	clr.l	-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$F6(a5)
	jsr	DecodeFrames__XDAC__TPsjj
	add.w	#$10,a7
	lea	-$102(a5),a0
	jsr	lib_destruct_a0
	lea	-$BA(a5),a0
	jsr	lib_destruct_a0
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts

L183
	dc.b	'xDAC',0

	SECTION "_0dt__xFILEIO__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__xFILEIO__T
_0dt__xFILEIO__T
L200	EQU	0
	link	a5,#L200
	move.l	$8(a5),a0
L199
	move.l	a0,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	unlk	a5
	rts

	SECTION "_0dt__XSFIO__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__XSFIO__T
_0dt__XSFIO__T
L202	EQU	0
	link	a5,#L202
L201
	unlk	a5
	rts

	SECTION "_0dt__XSFHEAD__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__XSFHEAD__T
_0dt__XSFHEAD__T
L204	EQU	0
	link	a5,#L204
L203
	unlk	a5
	rts

	SECTION "Read8__XSFBASIC__TPvUi:0",CODE

	CNOP	0,2

	XDEF	Read8__XSFBASIC__TPvUi
Read8__XSFBASIC__TPvUi
L208	EQU	0
	link	a5,#L208
	move.l	$10(a5),d0
	move.l	$8(a5),a0
	move.l	$C(a5),a1
L205
	cmp.w	#0,a0
	beq.b	L207
L206
	add.w	#$10,a0
L207
	move.l	d0,-(a7)
	pea	1.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	unlk	a5
	rts

	SECTION "Read16__XSFBASIC__TPvUi:0",CODE

	CNOP	0,2

	XDEF	Read16__XSFBASIC__TPvUi
Read16__XSFBASIC__TPvUi
L217	EQU	0
	link	a5,#L217
	move.l	d2,-(a7)
	move.l	$10(a5),d1
	move.l	$8(a5),a0
	move.l	$C(a5),a1
L209
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L213
L210
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L212
L211
	add.w	#$10,a0
L212
	move.l	a0,-(a7)
	jsr	Read16Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L216
L213
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L215
L214
	add.w	#$10,a0
L215
	move.l	d0,-(a7)
	pea	2.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
L216
	move.l	(a7)+,d2
	unlk	a5
	rts

	SECTION "Read32__XSFBASIC__TPvUi:0",CODE

	CNOP	0,2

	XDEF	Read32__XSFBASIC__TPvUi
Read32__XSFBASIC__TPvUi
L226	EQU	0
	link	a5,#L226
	move.l	d2,-(a7)
	move.l	$10(a5),d1
	move.l	$8(a5),a0
	move.l	$C(a5),a1
L218
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L222
L219
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L221
L220
	add.w	#$10,a0
L221
	move.l	a0,-(a7)
	jsr	Read32Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L225
L222
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L224
L223
	add.w	#$10,a0
L224
	move.l	d0,-(a7)
	pea	4.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
L225
	move.l	(a7)+,d2
	unlk	a5
	rts

	SECTION "Read64__XSFBASIC__TPvUi:0",CODE

	CNOP	0,2

	XDEF	Read64__XSFBASIC__TPvUi
Read64__XSFBASIC__TPvUi
L235	EQU	0
	link	a5,#L235
	move.l	d2,-(a7)
	move.l	$10(a5),d1
	move.l	$8(a5),a0
	move.l	$C(a5),a1
L227
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L231
L228
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L230
L229
	add.w	#$10,a0
L230
	move.l	a0,-(a7)
	jsr	Read64Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L234
L231
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L233
L232
	add.w	#$10,a0
L233
	move.l	d0,-(a7)
	pea	$8.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
L234
	move.l	(a7)+,d2
	unlk	a5
	rts

	SECTION "Write8__XSFBASIC__TPvUi:0",CODE

	CNOP	0,2

	XDEF	Write8__XSFBASIC__TPvUi
Write8__XSFBASIC__TPvUi
L239	EQU	0
	link	a5,#L239
	move.l	$10(a5),d0
	move.l	$8(a5),a0
	move.l	$C(a5),a1
L236
	cmp.w	#0,a0
	beq.b	L238
L237
	add.w	#$10,a0
L238
	move.l	d0,-(a7)
	pea	1.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	unlk	a5
	rts

	SECTION "Write16__XSFBASIC__TPvUi:0",CODE

	CNOP	0,2

	XDEF	Write16__XSFBASIC__TPvUi
Write16__XSFBASIC__TPvUi
L248	EQU	0
	link	a5,#L248
	move.l	d2,-(a7)
	move.l	$10(a5),d1
	move.l	$8(a5),a0
	move.l	$C(a5),a1
L240
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L244
L241
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L243
L242
	add.w	#$10,a0
L243
	move.l	a0,-(a7)
	jsr	Write16Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L247
L244
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L246
L245
	add.w	#$10,a0
L246
	move.l	d0,-(a7)
	pea	2.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
L247
	move.l	(a7)+,d2
	unlk	a5
	rts

	SECTION "Write32__XSFBASIC__TPvUi:0",CODE

	CNOP	0,2

	XDEF	Write32__XSFBASIC__TPvUi
Write32__XSFBASIC__TPvUi
L257	EQU	0
	link	a5,#L257
	move.l	d2,-(a7)
	move.l	$10(a5),d1
	move.l	$8(a5),a0
	move.l	$C(a5),a1
L249
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L253
L250
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L252
L251
	add.w	#$10,a0
L252
	move.l	a0,-(a7)
	jsr	Write32Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L256
L253
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L255
L254
	add.w	#$10,a0
L255
	move.l	d0,-(a7)
	pea	4.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
L256
	move.l	(a7)+,d2
	unlk	a5
	rts

	SECTION "Write64__XSFBASIC__TPvUi:0",CODE

	CNOP	0,2

	XDEF	Write64__XSFBASIC__TPvUi
Write64__XSFBASIC__TPvUi
L266	EQU	0
	link	a5,#L266
	move.l	d2,-(a7)
	move.l	$10(a5),d1
	move.l	$8(a5),a0
	move.l	$C(a5),a1
L258
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L262
L259
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L261
L260
	add.w	#$10,a0
L261
	move.l	a0,-(a7)
	jsr	Write64Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L265
L262
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L264
L263
	add.w	#$10,a0
L264
	move.l	d0,-(a7)
	pea	$8.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
L265
	move.l	(a7)+,d2
	unlk	a5
	rts

	SECTION "Valid__XSFBASIC__T:0",CODE

	CNOP	0,2

	XDEF	Valid__XSFBASIC__T
Valid__XSFBASIC__T
L270	EQU	0
	link	a5,#L270
	move.l	$8(a5),a0
L267
	cmp.w	#0,a0
	beq.b	L269
L268
	add.w	#$10,a0
L269
	move.l	$96(a0),d0
	and.l	#$40,d0
	unlk	a5
	rts

	SECTION "EndOfFile__XSFBASIC__T:0",CODE

	CNOP	0,2

	XDEF	EndOfFile__XSFBASIC__T
EndOfFile__XSFBASIC__T
L274	EQU	0
	link	a5,#L274
	move.l	$8(a5),a0
L271
	cmp.w	#0,a0
	beq.b	L273
L272
	add.w	#$10,a0
L273
	move.l	$96(a0),d0
	and.l	#$10,d0
	unlk	a5
	rts

	SECTION "StartOfFile__XSFBASIC__T:0",CODE

	CNOP	0,2

	XDEF	StartOfFile__XSFBASIC__T
StartOfFile__XSFBASIC__T
L278	EQU	0
	link	a5,#L278
	move.l	$8(a5),a0
L275
	cmp.w	#0,a0
	beq.b	L277
L276
	add.w	#$10,a0
L277
	move.l	$96(a0),d0
	and.l	#$20,d0
	unlk	a5
	rts

	SECTION "Seek__XSFBASIC__Tjj:0",CODE

	CNOP	0,2

	XDEF	Seek__XSFBASIC__Tjj
Seek__XSFBASIC__Tjj
L282	EQU	0
	link	a5,#L282
	movem.l	$C(a5),d0/d1
	move.l	$8(a5),a0
L279
	move.l	d1,-(a7)
	move.l	d0,-(a7)
	cmp.w	#0,a0
	beq.b	L281
L280
	add.w	#$10,a0
L281
	move.l	a0,-(a7)
	jsr	Seek__xFILEIO__Tjj
	add.w	#$C,a7
	unlk	a5
	rts

	SECTION "Tell__XSFBASIC__T:0",CODE

	CNOP	0,2

	XDEF	Tell__XSFBASIC__T
Tell__XSFBASIC__T
L286	EQU	0
	link	a5,#L286
	move.l	$8(a5),a0
L283
	cmp.w	#0,a0
	beq.b	L285
L284
	add.w	#$10,a0
L285
	move.l	a0,-(a7)
	jsr	Tell__xFILEIO__T
	addq.w	#4,a7
	unlk	a5
	rts

	SECTION "Size__XSFBASIC__T:0",CODE

	CNOP	0,2

	XDEF	Size__XSFBASIC__T
Size__XSFBASIC__T
L293	EQU	0
	link	a5,#L293
	move.l	$8(a5),a0
L287
	cmp.w	#0,a0
	beq.b	L289
L288
	add.w	#$10,a0
L289
	move.l	$96(a0),d0
	and.l	#5,d0
	beq.b	L291
L290
	move.l	4(a0),d0
	bra.b	L292
L291
	move.l	#-$3040000,d0
L292
	unlk	a5
	rts

	SECTION "DataFormat__XSFBASIC__T:0",CODE

	CNOP	0,2

	XDEF	DataFormat__XSFBASIC__T
DataFormat__XSFBASIC__T
L297	EQU	0
	link	a5,#L297
	move.l	$8(a5),a0
L294
	cmp.w	#0,a0
	beq.b	L296
L295
	addq.w	#4,a0
L296
	move.b	$A(a0),d0
	unlk	a5
	rts

	SECTION "FileOptions__XSFBASIC__T:0",CODE

	CNOP	0,2

	XDEF	FileOptions__XSFBASIC__T
FileOptions__XSFBASIC__T
L301	EQU	0
	link	a5,#L301
	move.l	$8(a5),a0
L298
	cmp.w	#0,a0
	beq.b	L300
L299
	addq.w	#4,a0
L300
	move.b	$B(a0),d0
	unlk	a5
	rts

	SECTION "_0dt__XSFBASIC__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__XSFBASIC__T
_0dt__XSFBASIC__T
L305	EQU	-$8
	link	a5,#L305
	move.l	a2,-(a7)
	move.l	$8(a5),a2
L302
	move.l	a2,a0
	clr.l	$AA(a0)
	cmp.w	#0,a0
	beq.b	L304
L303
	add.w	#$10,a0
L304
	move.l	a0,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	pea	$10(a2)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	move.l	(a7)+,a2
	unlk	a5
	rts

	SECTION "ReadyForWrite__XSFOBJ__T:0",CODE

	CNOP	0,2

	XDEF	ReadyForWrite__XSFOBJ__T
ReadyForWrite__XSFOBJ__T
L307	EQU	0
	link	a5,#L307
L306
	moveq	#0,d0
	unlk	a5
	rts

	SECTION "ReadyForRead__XSFOBJ__T:0",CODE

	CNOP	0,2

	XDEF	ReadyForRead__XSFOBJ__T
ReadyForRead__XSFOBJ__T
L309	EQU	0
	link	a5,#L309
L308
	moveq	#0,d0
	unlk	a5
	rts

	SECTION "_0dt__XSFOBJ__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__XSFOBJ__T
_0dt__XSFOBJ__T
L311	EQU	0
	link	a5,#L311
L310
	unlk	a5
	rts

	SECTION "_0dt__XDAC__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__XDAC__T
_0dt__XDAC__T
L315	EQU	-$8
	link	a5,#L315
	move.l	$8(a5),a1
L312
	tst.l	$2C(a1)
	beq.b	L314
L313
	move.l	$2C(a1),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L314
	unlk	a5
	rts

	SECTION "_0virttab__08XSFBASIC__08XSFBASIC:0",CODE

	XDEF	_0virttab__08XSFBASIC__08XSFBASIC
_0virttab__08XSFBASIC__08XSFBASIC
	dc.l	$AE,0
	dc.l	_0dt__XSFBASIC__T,0
	dc.l	FileOptions__XSFBASIC__T,0
	dc.l	DataFormat__XSFBASIC__T,0
	dc.l	Size__XSFBASIC__T,0
	dc.l	Tell__XSFBASIC__T,0
	dc.l	Seek__XSFBASIC__Tjj,0
	dc.l	StartOfFile__XSFBASIC__T,0
	dc.l	EndOfFile__XSFBASIC__T,0
	dc.l	Valid__XSFBASIC__T,0
	dc.l	Write64__XSFBASIC__TPvUi,0
	dc.l	Write32__XSFBASIC__TPvUi,0
	dc.l	Write16__XSFBASIC__TPvUi,0
	dc.l	Write8__XSFBASIC__TPvUi,0
	dc.l	Read64__XSFBASIC__TPvUi,0
	dc.l	Read32__XSFBASIC__TPvUi,0
	dc.l	Read16__XSFBASIC__TPvUi,0
	dc.l	Read8__XSFBASIC__TPvUi,0
	dc.l	$AE,0
	dc.l	_0dt__XSFBASIC__T,0
	dc.l	FileOptions__XSFBASIC__T,0
	dc.l	DataFormat__XSFBASIC__T,0
	dc.l	Size__XSFBASIC__T,0
	dc.l	Tell__XSFBASIC__T,0
	dc.l	Seek__XSFBASIC__Tjj,0
	dc.l	StartOfFile__XSFBASIC__T,0
	dc.l	EndOfFile__XSFBASIC__T,0
	dc.l	Valid__XSFBASIC__T,0
	dc.l	Write64__XSFBASIC__TPvUi,0
	dc.l	Write32__XSFBASIC__TPvUi,0
	dc.l	Write16__XSFBASIC__TPvUi,0
	dc.l	Write8__XSFBASIC__TPvUi,0
	dc.l	Read64__XSFBASIC__TPvUi,0
	dc.l	Read32__XSFBASIC__TPvUi,0
	dc.l	Read16__XSFBASIC__TPvUi,0
	dc.l	Read8__XSFBASIC__TPvUi,0

	SECTION "_0virttab__04XDAC__04XDAC:0",CODE

	XDEF	_0virttab__04XDAC__04XDAC
_0virttab__04XDAC__04XDAC
	dc.l	$3C,0
	dc.l	_0dt__XDAC__T,0
	dc.l	ReadBody__XDAC__TR05XSFIO,0
	dc.l	WriteBody__XDAC__TR05XSFIO,0
	dc.l	ReadyForRead__XSFOBJ__T,0
	dc.l	ReadyForWrite__XSFOBJ__T,0
	dc.l	$3C,0
	dc.l	_0dt__XDAC__T,0
	dc.l	ReadBody__XDAC__TR05XSFIO,0
	dc.l	WriteBody__XDAC__TR05XSFIO,0

	END
