
; Storm C Compiler
; Developer:eXtropia/eXtropiaOld/prj/xDAC/xDacDecode.cpp
	mc68030
	mc68881
	XREF	_0dt__XDACCODEC__T
	XREF	ReadBody__XDAC__TR05XSFIO
	XREF	WriteBody__XDAC__TR05XSFIO
	XREF	_0dt__XDACENCODE__T
	XREF	FreeSpace__XDACENCODE__T
	XREF	Delete__xPCM__T
	XREF	ReadBody__xPCM__TR05XSFIO
	XREF	WriteBody__xPCM__TR05XSFIO
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
	XREF	_0dt__LOCK__T
	XREF	_0dt__THREAD__T
	XREF	Run__THREAD__T
	XREF	_0dt__DELAY__T
	XREF	_0ct__DELAY__T
	XREF	Pause__DELAY__TUj
	XREF	Pause__DELAY__TUjUj
	XREF	Abort__DELAY__T
	XREF	UnLink__xCHAINABLE__T
	XREF	Zero__MEM__r8Pvr0Ui
	XREF	Free__MEM__Pv
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

	SECTION "DecodeMergedStereo__XDAC__TPsj:0",CODE


;sint32 XDAC::DecodeMergedStereo(sint16* dest, sint32 num)
	XDEF	DecodeMergedStereo__XDAC__TPsj
DecodeMergedStereo__XDAC__TPsj
L101	EQU	-$28
	link	a5,#L101
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$C(a5),a0
L84
;	rsint16*	d = dest;
	move.l	a0,a6
;	ruint16*	s = current;
	move.l	$8(a5),a0
	move.l	$34(a0),a2
;	rsint32		n = num+1;
	move.l	$10(a5),d0
	addq.l	#1,d0
	move.l	d0,-4(a5)
;	while(--n)
	bra	L99
L85
;		ruint16 c = *s++;
	move.w	(a2)+,d1
;		if (XDAC_SILENCE(c))
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$8000,d0
	beq.b	L89
L86
;			ruint16 f = XDAC_SLNC_LEN(c);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$FFF,d0
	move.w	d0,d3
;			if (f>n)
	moveq	#0,d0
	move.w	d3,d0
	cmp.l	-4(a5),d0
	ble.b	L88
L87
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L88
;			rsint32 len = (shared.frameLen*f)<<1;
	move.l	$8(a5),a1
	move.w	$24(a1),d2
	mulu	d3,d2
	moveq	#1,d0
	asl.l	d0,d2
;			MEM::Zero(d,(len<<1));
	move.l	d2,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	a6,a0
	jsr	Zero__MEM__r8Pvr0Ui
;			d += len;
	move.l	d2,d0
	moveq	#1,d2
	asl.l	d2,d0
	add.l	a6,d0
	move.l	d0,a6
;			n -= (f-1);
	moveq	#0,d0
	move.w	d3,d0
	subq.l	#1,d0
	sub.l	d0,-4(a5)
	bra	L99
L89
;			if (c&XDAC_RESERVED)
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$F0E0,d0
	beq.b	L91
L90
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L91
;			rsint16		bitRate = XDAC_BITRATE(c);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$300,d0
	moveq	#$8,d2
	asr.l	d2,d0
	addq.l	#2,d0
	move.w	d0,-$20(a5)
;			ruint16		mask		= (1<<bitRate)-1;
	move.w	-$20(a5),d0
	ext.l	d0
	moveq	#1,d2
	asl.l	d0,d2
	move.l	d2,d0
	subq.l	#1,d0
	move.w	d0,-$1C(a5)
;			rsint16		shiftMx	= ((8*sizeof(sint16))/bitRate);
	move.w	-$20(a5),d0
	ext.l	d0
	moveq	#$10,d2
	divul.l	d0,d2
	move.w	d2,d7
;			rsint16		shifted	= shiftMx;
	move.w	d7,d0
;			rsint16 	sample1	= *((sint16*)s++);
	move.w	(a2)+,d4
;			rsint16 	sample2	= *((sint16*)s++);
	move.w	(a2)+,d3
;			*d++ 	= 	(sint16)sample1;
	move.w	d4,(a6)+
;			*d++	=		(sint16)sample2;
	move.w	d3,(a6)+
;			rsint16*	qTable	= (sint16*)s;
	move.l	a2,a0
;			s			+=	XDAC_TABLESIZE(c);
	and.l	#$FFFF,d1
	and.l	#$1F,d1
	addq.l	#1,d1
	moveq	#1,d2
	asl.l	d2,d1
	add.l	d1,a2
;			ruint16 packed = *s++;
	move.w	(a2)+,d1
;			rsint16	i = shared.frameLen;
	move.l	$8(a5),a3
	move.w	$24(a3),d5
;			while(--i)
	bra.b	L96
L92
;				sample1 += qTable[(packed & mask)];
	moveq	#0,d2
	move.w	d1,d2
	moveq	#0,d6
	move.w	-$1C(a5),d6
	and.l	d6,d2
	add.w	0(a0,d2.l*2),d4
;				*d++ = sample1;
	move.w	d4,(a6)+
;				packed >>= bitRate;
	move.w	-$20(a5),d2
	lsr.w	d2,d1
;				if (--shifted==0)
	subq.w	#1,d0
	tst.w	d0
	bne.b	L94
L93
;					shifted = shiftMx;
	move.w	d7,d0
;					packed = *s++;
	move.w	(a2)+,d1
L94
;				sample2 += qTable[(packed & mask)];
	moveq	#0,d2
	move.w	d1,d2
	moveq	#0,d6
	move.w	-$1C(a5),d6
	and.l	d6,d2
	add.w	0(a0,d2.l*2),d3
;				*d++ = sample2;
	move.w	d3,(a6)+
;				packed >>= bitRate;
	move.w	-$20(a5),d2
	lsr.w	d2,d1
;				if (--shifted==0)
	subq.w	#1,d0
	tst.w	d0
	bne.b	L96
L95
;					shifted = shiftMx;
	move.w	d7,d0
;					packed = *s++;
	move.w	(a2)+,d1
L96
	subq.w	#1,d5
	tst.w	d5
	bne.b	L92
L97
;			if (shifted==shiftMx)
	cmp.w	d7,d0
	bne.b	L99
L98
;				s--;
	subq.w	#2,a2
L99
	subq.l	#1,-4(a5)
	tst.l	-4(a5)
	bne	L85
L100
;	current = s;
	move.l	$8(a5),a0
	move.l	a2,$34(a0)
;	frameNum += num;
	move.l	$8(a5),a0
	move.l	$38(a0),d0
	add.l	$10(a5),d0
	move.l	$8(a5),a0
	move.l	d0,$38(a0)
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "DecodeMonoFrames__XDAC__TPsj:0",CODE


;sint32 XDAC::DecodeMonoFrames(sint16* dest, sint32 num)
	XDEF	DecodeMonoFrames__XDAC__TPsj
DecodeMonoFrames__XDAC__TPsj
L117	EQU	-$24
	link	a5,#L117
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$C(a5),a0
L102
;	rsint16*	d = dest;
	move.l	a0,a6
;	ruint16*	s = current;
	move.l	$8(a5),a0
	move.l	$34(a0),a2
;	rsint32		n = num+1;
	move.l	$10(a5),d0
	addq.l	#1,d0
	move.l	d0,-4(a5)
;	while(--n)
	bra	L115
L103
;		ruint16 c = *s++;
	move.w	(a2)+,d1
;		if (XDAC_SILENCE(c))
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$8000,d0
	beq.b	L107
L104
;			ruint16 f = XDAC_SLNC_LEN(c);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$FFF,d0
	move.w	d0,d2
;			if (f>n)
	moveq	#0,d0
	move.w	d2,d0
	cmp.l	-4(a5),d0
	ble.b	L106
L105
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L106
;			rsint32 len = shared.frameLen*f;
	move.l	$8(a5),a1
	move.w	$24(a1),d3
	mulu	d2,d3
;			MEM::Zero(d,(len<<1));
	move.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	a6,a0
	jsr	Zero__MEM__r8Pvr0Ui
;			d += len;
	move.l	d3,d0
	moveq	#1,d3
	asl.l	d3,d0
	add.l	a6,d0
	move.l	d0,a6
;			n -= (f-1);
	moveq	#0,d0
	move.w	d2,d0
	subq.l	#1,d0
	sub.l	d0,-4(a5)
	bra	L115
L107
;			if (c&XDAC_RESERVED)
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$F0E0,d0
	beq.b	L109
L108
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L109
;			rsint16		bitRate = XDAC_BITRATE(c);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$300,d0
	moveq	#$8,d2
	asr.l	d2,d0
	addq.l	#2,d0
	move.w	d0,d7
;			ruint16		mask		= (1<<bitRate)-1;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d2
	asl.l	d0,d2
	move.l	d2,d0
	subq.l	#1,d0
	move.w	d0,-$1A(a5)
;			rsint16		shiftMx	= ((8*sizeof(sint16))/bitRate);
	move.w	d7,d0
	ext.l	d0
	moveq	#$10,d2
	divul.l	d0,d2
	move.w	d2,d6
;			rsint16		shifted	= shiftMx;
	move.w	d6,d0
;			rsint16 	sample	= *((sint16*)s++);
	move.w	(a2)+,d3
;			rsint16*	qTable	= (sint16*)s;
	move.l	a2,a1
;			s			+=	XDAC_TABLESIZE(c);
	and.l	#$FFFF,d1
	and.l	#$1F,d1
	addq.l	#1,d1
	moveq	#1,d2
	asl.l	d2,d1
	add.l	d1,a2
;			*d++ 	= 	(sint16)sample;
	move.w	d3,(a6)+
;			ruint16 packed = *s++;
	move.w	(a2)+,d1
;			rsint16	i = shared.frameLen;
	move.l	$8(a5),a3
	move.w	$24(a3),d4
;			while(--i)
	bra.b	L112
L110
;				sample += qTable[(packed & mask)];
	moveq	#0,d2
	move.w	d1,d2
	moveq	#0,d5
	move.w	-$1A(a5),d5
	and.l	d5,d2
	add.w	0(a1,d2.l*2),d3
;				*d++ = sample;
	move.w	d3,(a6)+
;				packed >>= bitRate;
	lsr.w	d7,d1
;				if (--shifted==0)
	subq.w	#1,d0
	tst.w	d0
	bne.b	L112
L111
;					shifted = shiftMx;
	move.w	d6,d0
;					packed = *s++;
	move.w	(a2)+,d1
L112
	subq.w	#1,d4
	tst.w	d4
	bne.b	L110
L113
;			if (shifted==shiftMx)
	cmp.w	d6,d0
	bne.b	L115
L114
;				s--;
	subq.w	#2,a2
L115
	subq.l	#1,-4(a5)
	tst.l	-4(a5)
	bne	L103
L116
;	current = s;
	move.l	$8(a5),a0
	move.l	a2,$34(a0)
;	frameNum += num;
	move.l	$8(a5),a0
	move.l	$38(a0),d0
	add.l	$10(a5),d0
	move.l	$8(a5),a0
	move.l	d0,$38(a0)
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "DecodeMergedFrames__XDAC__TPsj:0",CODE


;sint32 XDAC::DecodeMergedFrames(sint16* dest, sint32 num)
	XDEF	DecodeMergedFrames__XDAC__TPsj
DecodeMergedFrames__XDAC__TPsj
L139	EQU	-$30
	link	a5,#L139
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$C(a5),a0
L118
;	rsint16*	d = dest;
	move.l	a0,a6
;	ruint16*	s	= current;
	move.l	$8(a5),a0
	move.l	$34(a0),a2
;	rsint32	n = num+1;
	move.l	$10(a5),d0
	addq.l	#1,d0
	move.l	d0,-4(a5)
;	while(--n)
	bra	L137
L119
;		ruint16 c = *s++;
	move.w	(a2)+,d3
;		if (XDAC_SILENCE(c))
	moveq	#0,d0
	move.w	d3,d0
	and.l	#$8000,d0
	beq.b	L123
L120
;			ruint16 f = XDAC_SLNC_LEN(c);
	moveq	#0,d0
	move.w	d3,d0
	and.l	#$FFF,d0
	move.w	d0,d3
;			if (f>n)
	moveq	#0,d0
	move.w	d3,d0
	cmp.l	-4(a5),d0
	ble.b	L122
L121
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L122
;			rsint32 len = shared.frameLen*shared.channels*f;
	move.l	$8(a5),a1
	move.w	$24(a1),d1
	move.l	$8(a5),a1
	move.w	d1,d2
	mulu	$26(a1),d2
	moveq	#0,d0
	move.w	d3,d0
	mulu.l	d0,d2
;			MEM::Zero(d,(len<<1));
	move.l	d2,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	a6,a0
	jsr	Zero__MEM__r8Pvr0Ui
;			d += len;
	move.l	d2,d0
	moveq	#1,d2
	asl.l	d2,d0
	add.l	a6,d0
	move.l	d0,a6
;			n -= (f-1);
	moveq	#0,d0
	move.w	d3,d0
	subq.l	#1,d0
	sub.l	d0,-4(a5)
	bra	L137
L123
;			if (c&XDAC_RESERVED)
	moveq	#0,d0
	move.w	d3,d0
	and.l	#$F0E0,d0
	beq.b	L125
L124
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L125
;			for (rsint16 ch=0
	moveq	#0,d0
;			for (rsint16 ch=0, *smp=sample;
	lea	-$10(a5),a0
	bra.b	L127
L126
;				*d++ = *smp++ = *((sint16*)s)++;
	move.w	(a2)+,d1
	move.w	d1,(a0)+
	move.w	d1,(a6)+
	addq.w	#1,d0
L127
	move.w	d0,d2
	ext.l	d2
	move.l	$8(a5),a3
	moveq	#0,d1
	move.w	$26(a3),d1
	cmp.l	d1,d2
	blt.b	L126
L128
;			rsint16		bitRate	= XDAC_BITRATE(c);
	moveq	#0,d0
	move.w	d3,d0
	and.l	#$300,d0
	moveq	#$8,d1
	asr.l	d1,d0
	addq.l	#2,d0
	move.w	d0,d7
;			ruint16		mask		= (1<<bitRate)-1;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	d1,d0
	subq.l	#1,d0
	move.w	d0,-$16(a5)
;			rsint16		shiftMx	= ((8*sizeof(sint16))/bitRate);
	move.w	d7,d0
	ext.l	d0
	moveq	#$10,d1
	divul.l	d0,d1
	move.w	d1,d6
;			rsint16		shifted	= shiftMx;
	move.w	d6,d1
;			rsint16*	qTable	= (sint16*)s;
	move.l	a2,a1
;			s	+=	XDAC_TABLESIZE(c);
	moveq	#0,d0
	move.w	d3,d0
	and.l	#$1F,d0
	addq.l	#1,d0
	moveq	#1,d2
	asl.l	d2,d0
	add.l	d0,a2
;			ruint16		packed	= *s++;
	move.w	(a2)+,d2
;			rsint16		i				= shared.frameLen;
	move.l	$8(a5),a3
	move.w	$24(a3),-$22(a5)
;			while (--i)
	bra.b	L134
L129
;				for(ch=0;
	moveq	#0,d0
	bra.b	L133
L130
;					rsint16 curr = sample[ch] + qTable[(packed&mask)];
	move.w	d0,d3
	ext.l	d3
	lea	-$10(a5),a0
	move.w	0(a0,d3.l*2),d3
	ext.l	d3
	moveq	#0,d4
	move.w	d2,d4
	moveq	#0,d5
	move.w	-$16(a5),d5
	and.l	d5,d4
	move.w	0(a1,d4.l*2),d4
	ext.l	d4
	add.l	d4,d3
;					*d++ = sample[ch] = curr;
	move.w	d0,d4
	ext.l	d4
	lea	-$10(a5),a0
	move.w	d3,0(a0,d4.l*2)
	move.w	d3,(a6)+
;					packed >>= bitRate;
	lsr.w	d7,d2
;					if (--shifted==0)
	subq.w	#1,d1
	tst.w	d1
	bne.b	L132
L131
;						shifted = shiftMx;
	move.w	d6,d1
;						packed = *s++;
	move.w	(a2)+,d2
L132
	addq.w	#1,d0
L133
	move.w	d0,d4
	ext.l	d4
	move.l	$8(a5),a3
	moveq	#0,d3
	move.w	$26(a3),d3
	cmp.l	d3,d4
	blt.b	L130
L134
	subq.w	#1,-$22(a5)
	tst.w	-$22(a5)
	bne.b	L129
L135
;			if (shifted==shiftMx)
	cmp.w	d6,d1
	bne.b	L137
L136
;				s--;
	subq.w	#2,a2
L137
	subq.l	#1,-4(a5)
	tst.l	-4(a5)
	bne	L119
L138
;	current = s;
	move.l	$8(a5),a0
	move.l	a2,$34(a0)
;	frameNum += num;
	move.l	$8(a5),a0
	move.l	$38(a0),d0
	add.l	$10(a5),d0
	move.l	$8(a5),a0
	move.l	d0,$38(a0)
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "DecodeAlternFrames__XDAC__TPsj:0",CODE


;sint32	XDAC::DecodeAlternFrames(sint16* dest, sint32 num)
	XDEF	DecodeAlternFrames__XDAC__TPsj
DecodeAlternFrames__XDAC__TPsj
L156	EQU	-$28
	link	a5,#L156
	movem.l	d2-d7/a2/a3/a6,-(a7)
L140
;	ruint16*	s	= current;
	move.l	$8(a5),a0
	move.l	$34(a0),a2
;	rsint32		n = num+1;
	move.l	$10(a5),d0
	addq.l	#1,d0
	move.l	d0,-4(a5)
;	while(--n)
	bra	L154
L141
;		for (rsint16 ch=0;
	clr.w	-$1E(a5)
	bra	L153
L142
;			rsint16*	d = dest+ch;
	move.w	-$1E(a5),d0
	ext.l	d0
	move.l	$C(a5),a1
	lea	0(a1,d0.l*2),a0
;			ruint16 c = *s++;
	move.w	(a2)+,d1
;			if (XDAC_SILENCE(c))
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$8000,d0
	beq.b	L144
L143
;				MEM::Zero(d,(shared.frameLen<<1));
	move.l	$8(a5),a3
	moveq	#0,d0
	move.w	$24(a3),d0
	moveq	#1,d1
	asl.l	d1,d0
	jsr	Zero__MEM__r8Pvr0Ui
;				d += shared.frameLen;
	bra	L152
L144
;				if (c&XDAC_RESERVED)
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$F0E0,d0
	beq.b	L146
L145
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L146
;				rsint16		bitRate = XDAC_BITRATE(c);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$300,d0
	moveq	#$8,d2
	asr.l	d2,d0
	addq.l	#2,d0
	move.w	d0,d7
;				ruint16		mask		= (1<<bitRate)-1;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d2
	asl.l	d0,d2
	move.l	d2,d0
	subq.l	#1,d0
	move.w	d0,-6(a5)
;				rsint16		shiftMx	= ((8*sizeof(sint16))/bitRate);
	move.w	d7,d0
	ext.l	d0
	moveq	#$10,d2
	divul.l	d0,d2
	move.w	d2,d6
;				rsint16		shifted	= shiftMx;
	move.w	d6,d0
;				rsint16 	sample	= *((sint16*)s++);
	move.w	(a2)+,d3
;				rsint16*	qTable	= (sint16*)s;
	move.l	a2,a6
;				rsint16		ch			= shared.channels;
	move.l	$8(a5),a3
	move.w	$26(a3),-$12(a5)
;				s			+=	XDAC_TABLESIZE(c);
	and.l	#$FFFF,d1
	and.l	#$1F,d1
	addq.l	#1,d1
	moveq	#1,d2
	asl.l	d2,d1
	add.l	d1,a2
;				*d		= 	(sint16)sample;
	move.w	d3,(a0)
;				d			+=	ch;
	move.w	-$12(a5),d1
	ext.l	d1
	moveq	#1,d2
	asl.l	d2,d1
	add.l	d1,a0
;				ruint16 packed = *s++;
	move.w	(a2)+,d1
;				rsint16	i = shared.frameLen;
	move.l	$8(a5),a3
	move.w	$24(a3),d4
;				while(--i)
	bra.b	L149
L147
;					sample += qTable[(packed & mask)];
	moveq	#0,d2
	move.w	d1,d2
	moveq	#0,d5
	move.w	-6(a5),d5
	and.l	d5,d2
	add.w	0(a6,d2.l*2),d3
;					*d	= sample;
	move.w	d3,(a0)
;					d		+= ch;
	move.w	-$12(a5),d2
	ext.l	d2
	moveq	#1,d5
	asl.l	d5,d2
	add.l	d2,a0
;					packed >>= bitRate;
	lsr.w	d7,d1
;					if (--shifted==0)
	subq.w	#1,d0
	tst.w	d0
	bne.b	L149
L148
;						shifted = shiftMx;
	move.w	d6,d0
;						packed = *s++;
	move.w	(a2)+,d1
L149
	subq.w	#1,d4
	tst.w	d4
	bne.b	L147
L150
;				if (shifted==shiftMx)
	cmp.w	d6,d0
	bne.b	L152
L151
;					s--;
	subq.w	#2,a2
L152
	addq.w	#1,-$1E(a5)
L153
	move.w	-$1E(a5),d1
	ext.l	d1
	move.l	$8(a5),a1
	moveq	#0,d0
	move.w	$26(a1),d0
	cmp.l	d0,d1
	blt	L142
L154
	subq.l	#1,-4(a5)
	tst.l	-4(a5)
	bne	L141
L155
;	current = s;
	move.l	$8(a5),a0
	move.l	a2,$34(a0)
;	frameNum += num;
	move.l	$8(a5),a0
	move.l	$38(a0),d0
	add.l	$10(a5),d0
	move.l	$8(a5),a0
	move.l	d0,$38(a0)
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "DecodeEitherFrames__XDAC__TPsj:0",CODE


;sint32	XDAC::DecodeEitherFrames(sint16* dest, sint32 num)
	XDEF	DecodeEitherFrames__XDAC__TPsj
DecodeEitherFrames__XDAC__TPsj
L158	EQU	0
	link	a5,#L158
L157
	move.l	#-$3050000,d0
	unlk	a5
	rts

	END
