
; Storm C Compiler
; Developer:eXtropia/eXtropiaOld/prj/xDAC/xDacEncode.cpp
	mc68030
	mc68881
	XREF	_0dt__XDACCODEC__T
	XREF	ReadBody__XDAC__TR05XSFIO
	XREF	WriteBody__XDAC__TR05XSFIO
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
	XREF	Elapsed__MILLICLOCK__T
	XREF	UnLink__xCHAINABLE__T
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__UisE
	XREF	_qsort
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

	SECTION "_0ct__XDACENCODE__TR03PCMjss:0",CODE


;XDACENCODE::XDACENCODE(PCM& source, sint32 size, sint16 
	XDEF	_0ct__XDACENCODE__TR03PCMjss
_0ct__XDACENCODE__TR03PCMjss
L183	EQU	0
	link	a5,#L183
	movem.l	d2/d3,-(a7)
	move.l	$10(a5),d0
	move.w	$14(a5),d1
	move.w	$16(a5),d2
	move.l	$8(a5),a0
	move.l	$C(a5),a1
L182
	clr.l	(a0)
	move.l	a1,4(a0)
	clr.l	$8(a0)
	clr.l	$1C(a0)
;	Set(source, size, bits, fast);
	move.w	d2,-(a7)
	move.w	d1,-(a7)
	move.w	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Set__XDACENCODE__TR03PCMsss
	add.w	#$E,a7
	movem.l	(a7)+,d2/d3
	unlk	a5
	rts

	SECTION "_0dt__XDACENCODE__T:0",CODE


;XDACENCODE::~XDACENCODE()
	XDEF	_0dt__XDACENCODE__T
_0dt__XDACENCODE__T
L185	EQU	0
	link	a5,#L185
	move.l	$8(a5),a0
L184
;	FreeSpace();
	move.l	a0,-(a7)
	jsr	FreeSpace__XDACENCODE__T
	addq.w	#4,a7
	unlk	a5
	rts

	SECTION "EncodeBody__XDACENCODE__T:0",CODE


;sint32 XDACENCODE::EncodeBody()
	XDEF	EncodeBody__XDACENCODE__T
EncodeBody__XDACENCODE__T
L240	EQU	-$84
	link	a5,#L240
	movem.l	d2-d7/a2/a3/a6,-(a7)
L186
;	encodeSize = 0;
	move.l	$8(a5),a0
	clr.w	$36(a0)
;	if (!workspace)
	move.l	$8(a5),a1
	tst.l	$C(a1)
	bne.b	L188
L187
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L188
;	if (!(flags & ANALYSED))
	move.l	$8(a5),a0
	move.l	(a0),d0
	and.l	#$8,d0
	bne.b	L190
L189
;		Analyse();
	move.l	$8(a5),-(a7)
	jsr	Analyse__XDACENCODE__T
	addq.w	#4,a7
L190
;	if (flags & ZERO_FRAME)
	move.l	$8(a5),a0
	move.l	(a0),d0
	and.l	#1,d0
	beq.b	L192
L191
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L192
;	sint32 tableSize	= TableSize();
	move.l	$8(a5),a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L194
L193
	move.w	$32(a0),d0
	ext.l	d0
	move.l	d0,-4(a5)
	bra.b	L195
L194
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	d1,-4(a5)
L195
;		sint16*	src				= (waveData->Data())+offset;
	move.l	$8(a5),a1
	move.l	4(a1),-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	move.l	$8(a5),a0
	move.l	$8(a0),d1
	add.l	d1,d1
	add.l	d0,d1
	move.l	d1,a3
;		sint32	prev[4]		= {0};
	lea	-$18(a5),a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
;			for (rsint32 i=0;
	moveq	#0,d0
	bra.b	L197
L196
;				prev[i]=*src++;
	move.w	(a3)+,d1
	ext.l	d1
	lea	-$18(a5),a0
	move.l	d1,0(a0,d0.l*4)
	addq.l	#1,d0
L197
	move.l	$8(a5),a0
	move.w	$2E(a0),d1
	ext.l	d1
	cmp.l	d1,d0
	blt.b	L196
L198
;		sint32		shiftMx	= (8*sizeof(sint16)-encodeRate)-((8*sizeof(sint1
	move.l	$8(a5),a0
	move.w	$34(a0),d0
	ext.l	d0
	moveq	#$10,d1
	sub.l	d0,d1
	move.l	d1,-$1C(a5)
	move.l	$8(a5),a0
	move.w	$34(a0),d0
	ext.l	d0
	moveq	#$10,d1
	divul.l	d0,d0:d1
	tst.l	d0
	beq.b	L200
L199
	moveq	#1,d0
	bra.b	L201
L200
	moveq	#0,d0
L201
	sub.l	d0,-$1C(a5)
;		sint32		shift		= 0;
	clr.l	-$20(a5)
;		uint32		packed	= 0;
	moveq	#0,d7
;		rsint16*	qTable	= Table();
	move.l	$8(a5),a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L203
L202
	move.l	$14(a0),a2
	bra.b	L204
L203
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	lea	0(a1,d1.l*2),a2
L204
;		ruint16*	encoded = Encoded();
	move.l	$8(a5),a1
	move.l	(a1),d0
	and.l	#$8,d0
	beq.b	L212
L205
	move.l	a1,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L207
L206
	move.l	$14(a0),a6
	bra.b	L208
L207
	move.w	$2E(a0),d0
	ext.l	d0
	add.l	d0,d0
	add.l	$C(a0),d0
	move.l	d0,a6
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	move.l	d1,d0
	add.l	d0,d0
	add.l	a6,d0
	move.l	d0,a6
L208
	move.l	a1,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L210
L209
	move.w	$32(a0),d0
	ext.l	d0
	bra.b	L211
L210
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	d1,d0
L211
	add.l	d0,d0
	add.l	a6,d0
	move.l	d0,a6
	bra.b	L213
L212
	sub.l	a6,a6
L213
;		rsint32 i = frameSize;
	move.l	$8(a5),a0
	move.w	$2C(a0),d0
	ext.l	d0
	move.l	d0,-$28(a5)
;		while(--i)
	bra	L227
L214
;			for(rsint32 c=0;
	moveq	#0,d6
	bra	L226
L215
;				sint32 best = -1;
	moveq	#-1,d3
;					sint32 t = (sint32)(*src++)-prev[c];
	move.w	(a3)+,d5
	ext.l	d5
	lea	-$18(a5),a0
	move.l	d6,d0
	sub.l	0(a0,d0.l*4),d5
;					sint32 minT=(1UL<<30);
	move.l	#$40000000,d4
;				  for (rsint32 j=0;
	moveq	#0,d2
	bra.b	L219
L216
;						rsint32 v = abs(qTable[j]-t);
	move.w	0(a2,d2.l*2),d0
	ext.l	d0
	sub.l	d5,d0
	move.l	d0,-(a7)
	jsr	_abs
	addq.w	#4,a7
;		 		  	if (v<minT)
	cmp.l	d4,d0
	bge.b	L218
L217
;			 	  	  minT = v;
	move.l	d0,d4
;			 		    best = j;
	move.l	d2,d3
L218
	addq.l	#1,d2
L219
	cmp.l	-4(a5),d2
	blt.b	L216
L220
;				if (best>=0)
	tst.l	d3
	bmi.b	L224
L221
;					prev[c] += qTable[best];
	move.w	0(a2,d3.l*2),d1
	ext.l	d1
	lea	-$18(a5),a0
	move.l	d6,d0
	lea	0(a0,d0.l*4),a0
	add.l	d1,(a0)
;					packed |= (best)<<shift;
	move.l	-$20(a5),d0
	asl.l	d0,d3
	move.l	d7,d0
	or.l	d3,d0
	move.l	d0,d7
;					shift += encodeRate;
	move.l	$8(a5),a0
	move.w	$34(a0),d0
	ext.l	d0
	add.l	d0,-$20(a5)
;					if (shift>shiftMx)
	move.l	-$20(a5),d0
	cmp.l	-$1C(a5),d0
	ble.b	L223
L222
;						*encoded++ = (uint16)packed;
	move.w	d7,(a6)+
;						shift = packed = 0;
	clr.l	-$20(a5)
	move.l	-$20(a5),d7
L223
	bra.b	L225
L224
	move.l	#-$3010000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L225
	move.l	d6,d0
	addq.l	#1,d0
	move.l	d0,d6
L226
	move.l	$8(a5),a0
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	d6,d1
	cmp.l	d0,d1
	blt	L215
L227
	subq.l	#1,-$28(a5)
	tst.l	-$28(a5)
	bne	L214
L228
;					return 
;		if (shift)
	tst.l	-$20(a5)
	beq.b	L230
L229
;			*encoded++ = (uint16)packed;
	move.w	d7,(a6)+
L230
;		encodeSize = encoded-Encoded();
	move.l	$8(a5),a1
	move.l	(a1),d0
	and.l	#$8,d0
	beq.b	L238
L231
	move.l	a1,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L233
L232
	move.l	$14(a0),a2
	bra.b	L234
L233
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a2
	lea	0(a2,d0.l*2),a2
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	lea	0(a2,d1.l*2),a2
L234
	move.l	a1,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L236
L235
	move.w	$32(a0),d0
	ext.l	d0
	bra.b	L237
L236
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	d1,d0
L237
	lea	0(a2,d0.l*2),a0
	bra.b	L239
L238
	sub.l	a0,a0
L239
	move.l	a6,d0
	sub.l	a0,d0
	moveq	#1,d1
	asr.l	d1,d0
	move.l	$8(a5),a0
	move.w	d0,$36(a0)
;	flags |= ENCODED;
	move.l	$8(a5),a0
	move.l	(a0),d0
	or.l	#$1000000,d0
	move.l	$8(a5),a0
	move.l	d0,(a0)
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "Write__XDACENCODE__TR05XSFIO:0",CODE


;sint32 XDACENCODE::Write(XSFIO& file)
	XDEF	Write__XDACENCODE__TR05XSFIO
Write__XDACENCODE__TR05XSFIO
L273	EQU	-$A
	link	a5,#L273
	movem.l	d2-d4/a2/a3,-(a7)
	movem.l	$8(a5),a2/a3
L241
;	if (!workspace)
	tst.l	$C(a2)
	bne.b	L243
L242
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L243
;	if (file.Valid()==FALSE)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$4C(a0),d0
	move.l	d0,-(a7)
	move.l	$48(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	tst.w	d0
	bne.b	L245
L244
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L245
;	if (!(flags & ENCODED))
	move.l	(a2),d0
	and.l	#$1000000,d0
	bne.b	L248
L246
;		if (EncodeBody()!=OK)
	move.l	a2,-(a7)
	jsr	EncodeBody__XDACENCODE__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L248
L247
	move.l	#-$3010000,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L248
;	if ((flags & ZERO_FRAME) && (++silentFrames<8191) && frameNum<maxF
	move.l	(a2),d0
	and.l	#1,d0
	beq.b	L252
L249
	addq.w	#1,_silentFrames__Write__XDACENCODE__TR05XSFIO
	move.w	_silentFrames__Write__XDACENCODE__TR05XSFIO,d0
	cmp.w	#$1FFF,d0
	bhs.b	L252
L250
	move.l	$24(a2),d1
	cmp.l	$20(a2),d1
	bge.b	L252
L251
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L252
;	sint32 wordsWritten=0;
	moveq	#0,d2
;	if (silentFrames)
	tst.w	_silentFrames__Write__XDACENCODE__TR05XSFIO
	beq.b	L256
L253
;		silentFrames |= XDAC_SILENT;
	or.w	#$8000,_silentFrames__Write__XDACENCODE__TR05XSFIO
;		if (file.Write16(&silentFrames, 1)!=1)
	pea	1.w
	move.l	#_silentFrames__Write__XDACENCODE__TR05XSFIO,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	beq.b	L255
L254
;			silentFrames = 0;
	clr.w	_silentFrames__Write__XDACENCODE__TR05XSFIO
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L255
;		silentFrames = 0;
	clr.w	_silentFrames__Write__XDACENCODE__TR05XSFIO
;		wordsWritten++;
	addq.l	#1,d2
L256
;	uint16 head = (uint16)XDAC_SETBITRATE(encodeRate) | (uint16)XDAC_S
	move.w	$34(a2),d0
	ext.l	d0
	subq.l	#2,d0
	and.l	#3,d0
	moveq	#$8,d1
	asl.l	d1,d0
	moveq	#0,d1
	move.w	d0,d1
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L258
L257
	move.w	$32(a0),d0
	ext.l	d0
	bra.b	L259
L258
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d3
	asl.l	d0,d3
	move.l	d3,d0
L259
	subq.l	#1,d0
	and.l	#$1F,d0
	and.l	#$FFFF,d0
	or.l	d0,d1
	move.w	d1,-6(a5)
;	if (file.Write16(&head, 1)!=1)
	pea	1.w
	pea	-6(a5)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	beq.b	L261
L260
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L261
;		wordsWritten++;
	addq.l	#1,d2
;	if (file.Write16(StartSample(), channels)!=channels)
	move.w	$2E(a2),d0
	ext.l	d0
	move.l	d0,-(a7)
	move.l	$C(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	move.w	$2E(a2),d1
	ext.l	d1
	cmp.l	d1,d0
	beq.b	L263
L262
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L263
;		wordsWritten+=channels;
	move.w	$2E(a2),d0
	ext.l	d0
	add.l	d0,d2
;	sint32 bodySize = encodeSize + TableSize();
	move.w	$36(a2),d3
	ext.l	d3
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L265
L264
	move.w	$32(a0),d0
	ext.l	d0
	bra.b	L266
L265
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	d1,d0
L266
	add.l	d0,d3
	move.l	d3,-(a7)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L268
L267
	move.l	$14(a0),a0
	bra.b	L269
L268
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	lea	0(a1,d1.l*2),a0
L269
	move.l	a0,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	d3,d0
	bne.b	L271
L270
	move.l	d3,d0
	add.l	d2,d0
	bra.b	L272
L271
	move.l	#-$3040005,d0
L272
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts

	SECTION "Write__XDACENCODE__TR05XSFIO:1",DATA

_silentFrames__Write__XDACENCODE__TR05XSFIO
	dc.w	0

	SECTION "GetSpace__XDACENCODE__Tj:0",CODE


;sint32 XDACENCODE::GetSpace(sint32 size)
	XDEF	GetSpace__XDACENCODE__Tj
GetSpace__XDACENCODE__Tj
L287	EQU	-4
	link	a5,#L287
	movem.l	d2/d3/a2,-(a7)
	move.l	$C(a5),d3
	move.l	$8(a5),a2
L274
;	sint32 newSize = 256*((size/256)+((size%256)?1:0));
	move.l	d3,d0
	divsl.l	#$100,d0
	move.l	d3,d1
	divsl.l	#$100,d2:d1
	tst.l	d2
	beq.b	L276
L275
	moveq	#1,d1
	bra.b	L277
L276
	moveq	#0,d1
L277
	add.l	d1,d0
	move.l	d0,d2
	moveq	#$8,d0
	asl.l	d0,d2
;	newSize *= (4*sizeof(sint16));
	moveq	#3,d0
	asl.l	d0,d2
;	if (workspace)
	tst.l	$C(a2)
	beq.b	L283
L278
;		if (newSize != allocSize)
	cmp.l	$1C(a2),d2
	beq.b	L282
L279
;			MEM::Free(workspace);
	move.l	$C(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;			workspace = (sint16*)MEM::Alloc(newSize);
	clr.l	-(a7)
	clr.w	-(a7)
	move.l	d2,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,$C(a2)
;			if (!workspace)
	tst.l	$C(a2)
	bne.b	L281
L280
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts
L281
;			allocSize = newSize;
	move.l	d2,$1C(a2)
L282
	bra.b	L286
L283
;		workspace = (sint16*)MEM::Alloc(newSize);
	clr.l	-(a7)
	clr.w	-(a7)
	move.l	d2,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,$C(a2)
;		if (!workspace)
	tst.l	$C(a2)
	bne.b	L285
L284
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts
L285
;		allocSize = newSize;
	move.l	d2,$1C(a2)
L286
;	qDeltaFreq	= workspace+1*size;
	move.l	$C(a2),a0
	lea	0(a0,d3.l*2),a0
	move.l	a0,$10(a2)
;	uDelta			= workspace+2*size;
	move.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$C(a2),a0
	lea	0(a0,d0.l*2),a0
	move.l	a0,$14(a2)
;	uDeltaFreq	= workspace+3*size;
	move.l	d3,d0
	muls.l	#3,d0
	move.l	$C(a2),a0
	lea	0(a0,d0.l*2),a0
	move.l	a0,$18(a2)
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts

	SECTION "FreeSpace__XDACENCODE__T:0",CODE


;void	XDACENCODE::FreeSpace()
	XDEF	FreeSpace__XDACENCODE__T
FreeSpace__XDACENCODE__T
L291	EQU	0
	link	a5,#L291
	move.l	a2,-(a7)
	move.l	$8(a5),a2
L288
;	if (workspace)
	tst.l	$C(a2)
	beq.b	L290
L289
;		MEM::Free(workspace);
	move.l	$C(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L290
;	allocSize		= 0;
	clr.l	$1C(a2)
;	workspace		= 0;
	clr.l	$C(a2)
;	qDeltaFreq	= 0;
	clr.l	$10(a2)
;	uDelta			= 0;
	clr.l	$14(a2)
;	uDeltaFreq	= 0;
	clr.l	$18(a2)
	move.l	(a7)+,a2
	unlk	a5
	rts

	SECTION "Set__XDACENCODE__TR03PCMsss:0",CODE


;sint32	XDACENCODE::Set(PCM& source, sint16 size, sint16 bits, bool f
	XDEF	Set__XDACENCODE__TR03PCMsss
Set__XDACENCODE__TR03PCMsss
L316	EQU	0
	link	a5,#L316
	movem.l	d2-d5/a2,-(a7)
	move.w	$14(a5),d0
	move.w	$10(a5),d4
	move.w	$12(a5),d5
	move.l	$C(a5),a0
	move.l	$8(a5),a2
L292
;	flags = (fast)? FAST_ENCODE : 0;
	tst.w	d0
	beq.b	L294
L293
	moveq	#$20,d0
	bra.b	L295
L294
	moveq	#0,d0
L295
	move.l	d0,(a2)
;	frameSize = Clamp(size, XDAC_MIN_FRAMELEN, XDAC_MAX_FRAMELEN);
	move.l	#$800,d0
	moveq	#$40,d2
	move.w	d4,d1
	move.w	d1,d3
	ext.l	d3
	cmp.l	d2,d3
	bge.b	L297
L296
	move.l	d2,d0
	bra.b	L301
L297
	move.w	d1,d2
	ext.l	d2
	cmp.l	d0,d2
	ble.b	L299
L298
	bra.b	L300
L299
	move.w	d1,d0
	ext.l	d0
L300
L301
	move.w	d0,$2C(a2)
;	waveData = &source;
	move.l	a0,4(a2)
;	if (GetSpace(frameSize*waveData->Channels())!=OK)
	move.l	4(a2),a0
	move.w	$C(a0),d0
	muls	$2C(a2),d0
	move.l	d0,-(a7)
	move.l	a2,-(a7)
	jsr	GetSpace__XDACENCODE__Tj
	addq.w	#$8,a7
	tst.l	d0
	beq.b	L303
L302
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d5/a2
	unlk	a5
	rts
L303
;	bitRate		= Clamp(bits, 2, 5);
	moveq	#5,d0
	moveq	#2,d2
	move.w	d5,d1
	move.w	d1,d3
	ext.l	d3
	cmp.l	d2,d3
	bge.b	L305
L304
	move.l	d2,d0
	bra.b	L309
L305
	move.w	d1,d2
	ext.l	d2
	cmp.l	d0,d2
	ble.b	L307
L306
	bra.b	L308
L307
	move.w	d1,d0
	ext.l	d0
L308
L309
	move.w	d0,$30(a2)
;	frameNum	= maxFrame = offset = 0;
	clr.l	$8(a2)
	clr.l	$20(a2)
	clr.l	$24(a2)
;	channels	= waveData->Channels();
	move.l	4(a2),a0
	move.w	$C(a0),$2E(a2)
;	minPop		= (sint16)(0.5F + (float32)(channels*(size-1))/(float32)(1
	move.w	$2E(a2),d0
	ext.l	d0
	move.w	d4,d1
	ext.l	d1
	subq.l	#1,d1
	muls.l	d1,d0
	fmove.l	d0,fp0
	move.w	$30(a2),d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	fmove.l	d1,fp1
	fdiv.x	fp1,fp0
	fadd.s	#$.3F000000,fp0
	fmove.l	fp0,d0
	move.w	d0,$3E(a2)
;	if (waveData->Data())
	move.l	4(a2),-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L314
L310
;		maxFrame = (waveData->Length()/frameSize)-1;
	move.l	4(a2),a0
	tst.w	$C(a0)
	bne.b	L312
L311
	moveq	#0,d0
	bra.b	L313
L312
	move.w	$C(a0),d1
	ext.l	d1
	move.l	4(a0),d0
	divsl.l	d1,d0
L313
	move.w	$2C(a2),d1
	ext.l	d1
	divsl.l	d1,d0
	subq.l	#1,d0
	move.l	d0,$20(a2)
	bra.b	L315
L314
;		maxFrame = 0;
	clr.l	$20(a2)
L315
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2
	unlk	a5
	rts

	SECTION "Size__XDACENCODE__Ts:0",CODE


;sint32 XDACENCODE::Size(sint16 size)
	XDEF	Size__XDACENCODE__Ts
Size__XDACENCODE__Ts
L333	EQU	0
	link	a5,#L333
	movem.l	d2/d3/a2,-(a7)
	move.w	$C(a5),d2
	move.l	$8(a5),a2
L317
;	size = Clamp(size, XDAC_MIN_FRAMELEN, XDAC_MAX_FRAMELEN);
	move.l	#$800,d0
	moveq	#$40,d3
	move.w	d2,d1
	move.w	d1,d2
	ext.l	d2
	cmp.l	d3,d2
	bge.b	L319
L318
	move.l	d3,d0
	bra.b	L323
L319
	move.w	d1,d2
	ext.l	d2
	cmp.l	d0,d2
	ble.b	L321
L320
	bra.b	L322
L321
	move.w	d1,d0
	ext.l	d0
L322
L323
	move.w	d0,d2
;	if (size!=frameSize)
	cmp.w	$2C(a2),d2
	beq	L332
L324
;		if (GetSpace(size*channels)==OK)
	move.w	$2E(a2),d0
	muls	d2,d0
	move.l	d0,-(a7)
	move.l	a2,-(a7)
	jsr	GetSpace__XDACENCODE__Tj
	addq.w	#$8,a7
	tst.l	d0
	bne	L331
L325
;			frameSize = size;
	move.w	d2,$2C(a2)
;			minPop		= (sint16)(0.5F + (float32)(channels*(size-1))/(float3
	move.w	$2E(a2),d0
	ext.l	d0
	move.w	d2,d1
	ext.l	d1
	subq.l	#1,d1
	muls.l	d1,d0
	fmove.l	d0,fp0
	move.w	$30(a2),d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	fmove.l	d1,fp1
	fdiv.x	fp1,fp0
	fadd.s	#$.3F000000,fp0
	fmove.l	fp0,d0
	move.w	d0,$3E(a2)
;			if (waveData->Data())
	move.l	4(a2),-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L330
L326
;				maxFrame = (waveData->Length()/frameSize)-1;
	move.l	4(a2),a0
	tst.w	$C(a0)
	bne.b	L328
L327
	moveq	#0,d0
	bra.b	L329
L328
	move.w	$C(a0),d1
	ext.l	d1
	move.l	4(a0),d0
	divsl.l	d1,d0
L329
	move.w	$2C(a2),d1
	ext.l	d1
	divsl.l	d1,d0
	subq.l	#1,d0
	move.l	d0,$20(a2)
	bra.b	L331
L330
;				maxFrame = 0;
	clr.l	$20(a2)
L331
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts
L332
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts

	SECTION "First__XDACENCODE__T:0",CODE


;void XDACENCODE::First()
	XDEF	First__XDACENCODE__T
First__XDACENCODE__T
L335	EQU	0
	link	a5,#L335
	move.l	$8(a5),a0
L334
;	frameNum = 0;
	clr.l	$24(a0)
;	offset = 0;
	clr.l	$8(a0)
;	flags &= ~(ANALYSED|ENCODED|ZERO_FRAME);
	and.l	#-$100000A,(a0)
	unlk	a5
	rts

	SECTION "Last__XDACENCODE__T:0",CODE


;void XDACENCODE::Last()
	XDEF	Last__XDACENCODE__T
Last__XDACENCODE__T
L340	EQU	0
	link	a5,#L340
	move.l	a2,-(a7)
	move.l	$8(a5),a2
L336
;	if (waveData->Data())
	move.l	4(a2),-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L338
L337
;		frameNum = maxFrame;
	move.l	$20(a2),d0
	move.l	d0,$24(a2)
;		offset = maxFrame*frameSize*channels;
	move.w	$2C(a2),d1
	ext.l	d1
	move.l	$20(a2),d0
	muls.l	d1,d0
	move.w	$2E(a2),d1
	ext.l	d1
	muls.l	d1,d0
	move.l	d0,$8(a2)
	bra.b	L339
L338
;		frameNum = 0;
	clr.l	$24(a2)
;		offset = 0;
	clr.l	$8(a2)
L339
;	flags &= ~(ANALYSED|ENCODED|ZERO_FRAME);
	and.l	#-$100000A,(a2)
	move.l	(a7)+,a2
	unlk	a5
	rts

	SECTION "op__Cplusplus__XDACENCODE__Ti:0",CODE


;XDACENCODE&	XDACENCODE::operator++(int)
	XDEF	op__Cplusplus__XDACENCODE__Ti
op__Cplusplus__XDACENCODE__Ti
L347	EQU	0
	link	a5,#L347
	move.l	a2,-(a7)
	move.l	$8(a5),a2
L341
;	if (waveData->Data())
	move.l	4(a2),-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L345
L342
;		if (frameNum < maxFrame) // hack for now
	move.l	$24(a2),d1
	cmp.l	$20(a2),d1
	bge.b	L344
L343
;			frameNum++;
	addq.l	#1,$24(a2)
;			offset += frameSize*channels;
	move.w	$2C(a2),d1
	muls	$2E(a2),d1
	add.l	d1,$8(a2)
;			flags &= ~(ANALYSED|ENCODED|ZERO_FRAME);
	and.l	#-$100000A,(a2)
L344
	bra.b	L346
L345
;		offset = 0;
	clr.l	$8(a2)
L346
	move.l	a2,d0
	move.l	(a7)+,a2
	unlk	a5
	rts

	SECTION "op__minusminus__XDACENCODE__Ti:0",CODE


;XDACENCODE&	XDACENCODE::operator--(int)
	XDEF	op__minusminus__XDACENCODE__Ti
op__minusminus__XDACENCODE__Ti
L354	EQU	0
	link	a5,#L354
	move.l	a2,-(a7)
	move.l	$8(a5),a2
L348
;	if (waveData->Data())
	move.l	4(a2),-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L352
L349
;		if (frameNum>0)
	move.l	$24(a2),d0
	cmp.l	#0,d0
	ble.b	L351
L350
;			frameNum--;
	subq.l	#1,$24(a2)
;			offset -= frameSize*channels;
	move.w	$2C(a2),d1
	muls	$2E(a2),d1
	sub.l	d1,$8(a2)
;			flags &= ~(ANALYSED|ENCODED|ZERO_FRAME);
	and.l	#-$100000A,(a2)
L351
	bra.b	L353
L352
;		offset = 0;
	clr.l	$8(a2)
L353
	move.l	a2,d0
	move.l	(a7)+,a2
	unlk	a5
	rts

	SECTION "TestUpsample__XDACENCODE__T:0",CODE


;sint32 XDACENCODE::TestUpsample()
	XDEF	TestUpsample__XDACENCODE__T
TestUpsample__XDACENCODE__T
L356	EQU	0
	link	a5,#L356
L355
	moveq	#0,d0
	unlk	a5
	rts

	SECTION "FetchData__XDACENCODE__T:0",CODE


;void XDACENCODE::FetchData()
	XDEF	FetchData__XDACENCODE__T
FetchData__XDACENCODE__T
L377	EQU	-$1C
	link	a5,#L377
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.l	$8(a5),a2
L357
;	if (!workspace)	
	tst.l	$C(a2)
	bne.b	L359
L358
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L359
;	sint16* s = (waveData->Data())+offset;
	move.l	4(a2),-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	move.l	$8(a2),d1
	add.l	d1,d1
	add.l	d0,d1
	move.l	d1,a6
;	sint16* d = workspace;
	move.l	$C(a2),a0
;	maxDelta = minDelta = 0;
	clr.w	$44(a2)
	clr.w	$46(a2)
;		for (sint32 i=0;
	moveq	#0,d4
	bra.b	L361
L360
;			*d++ = *s++;
	move.w	(a6)+,(a0)+
	addq.l	#1,d4
L361
	move.w	$2E(a2),d0
	ext.l	d0
	cmp.l	d0,d4
	blt.b	L360
L362
;		for (i=0;
	moveq	#0,d4
	bra.b	L373
L363
;			rsint16*	s2		= s++;
	move.l	a6,a1
	moveq	#2,d0
	add.l	a6,d0
	move.l	d0,a6
;			rsint32		prev	= workspace[i];
	move.l	d4,d0
	add.l	d0,d0
	add.l	$C(a2),d0
	move.l	d0,a3
	move.w	(a3),d2
	ext.l	d2
;			rsint32		j			= frameSize;
	move.w	$2C(a2),d1
	ext.l	d1
;			while(--j)
	bra.b	L371
L364
;				rsint32 t1	= *s2;
	move.w	(a1),d3
	ext.l	d3
; s2 += channels;
	move.w	$2E(a2),d0
	ext.l	d0
	moveq	#1,d5
	asl.l	d5,d0
	add.l	d0,a1
;				rsint32 t2	= t1-prev;
	move.l	d3,d0
	sub.l	d2,d0
;				maxDelta		=	t2<maxDelta ? maxDelta : t2;
	move.w	$46(a2),d2
	ext.l	d2
	cmp.l	d2,d0
	bge.b	L366
L365
	move.w	$46(a2),d2
	ext.l	d2
	bra.b	L367
L366
	move.l	d0,d2
L367
	move.w	d2,$46(a2)
;				minDelta		=	t2>minDelta ? minDelta : t2;
	move.w	$44(a2),d2
	ext.l	d2
	cmp.l	d2,d0
	ble.b	L369
L368
	move.w	$44(a2),d2
	ext.l	d2
	bra.b	L370
L369
	move.l	d0,d2
L370
	move.w	d2,$44(a2)
;				prev = t1;
	move.l	d3,d2
;	*d++ = t2;
	move.w	d0,(a0)+
L371
	subq.l	#1,d1
	tst.l	d1
	bne.b	L364
L372
	addq.l	#1,d4
L373
	move.w	$2E(a2),d0
	ext.l	d0
	cmp.l	d0,d4
	blt.b	L363
L374
;	if (maxDelta==minDelta)
	move.w	$46(a2),d1
	cmp.w	$44(a2),d1
	bne.b	L376
L375
;		flags |= ZERO_FRAME;
	or.l	#1,(a2)
L376
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "CalcDeltaPop__XDACENCODE__T:0",CODE


;void XDACENCODE::CalcDeltaPop()
	XDEF	CalcDeltaPop__XDACENCODE__T
CalcDeltaPop__XDACENCODE__T
L393	EQU	-$18
	link	a5,#L393
	movem.l	d2-d6/a2/a3/a6,-(a7)
	move.l	$8(a5),a2
L378
;	if (!workspace || (flags & ZERO_FRAME))	
	tst.l	$C(a2)
	beq.b	L380
L379
	move.l	(a2),d0
	and.l	#1,d0
	beq.b	L381
L380
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L381
;	sint32		n = channels*(frameSize-1);
	move.w	$2E(a2),d5
	ext.l	d5
	move.w	$2C(a2),d0
	ext.l	d0
	subq.l	#1,d0
	muls.l	d0,d5
;	rsint16*	d = DeltaStream();
	move.l	a2,a0
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	move.l	d1,d0
	add.l	d0,d0
	add.l	a1,d0
	move.l	d0,a6
;	qsort(DeltaStream(), n, sizeof(sint16), compare);
	move.l	#compare__PCvPCv,-(a7)
	pea	2.w
	move.l	d5,-(a7)
	move.l	a2,a0
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	pea	0(a1,d1.l*2)
	jsr	_qsort
	add.w	#$10,a7
;		n = channels*(frameSize-1);
	move.w	$2E(a2),d5
	ext.l	d5
	move.w	$2C(a2),d0
	ext.l	d0
	subq.l	#1,d0
	muls.l	d0,d5
;		uniqueDelta = negPop = zeroPop = posPop = uniqueNeg = uniquePos 
	clr.w	$42(a2)
	clr.w	$40(a2)
	clr.w	$3C(a2)
	clr.w	$3A(a2)
	clr.w	$38(a2)
	clr.w	$32(a2)
;		sint16* ud 		= uDelta;
	move.l	$14(a2),a1
;		sint16* udf		= uDeltaFreq;
	move.l	$18(a2),a0
;		sint32	cnt		= 1;
	moveq	#1,d0
;		sint32	prev	= d[0];
	move.l	a6,a3
	move.w	(a3),d1
	ext.l	d1
;		for (rsint32 i=1;
	moveq	#1,d2
	bra.b	L391
L382
;			rsint16 t = d[i];
	move.l	d2,d3
	add.l	d3,d3
	add.l	a6,d3
	move.l	d3,a3
	move.w	(a3),d4
;			if (t == prev)
	move.w	d4,d3
	ext.l	d3
	cmp.l	d1,d3
	bne.b	L384
L383
;				cnt++;
	addq.l	#1,d0
	bra.b	L390
L384
;				*ud++ 	= prev;
	move.w	d1,(a1)+
;				*udf++	= cnt;
	move.w	d0,(a0)+
;				uniqueDelta++;
	addq.w	#1,$32(a2)
;				if (prev<0)
	tst.l	d1
	bpl.b	L386
L385
;					negPop += cnt;
	move.w	d0,d1
	add.w	d1,$38(a2)
;					uniqueNeg++;
	addq.w	#1,$40(a2)
	bra.b	L389
L386
;				else if (prev==0)
	tst.l	d1
	bne.b	L388
L387
;					zeroPop += cnt;
	move.w	d0,d1
	add.w	d1,$3A(a2)
	bra.b	L389
L388
;					posPop += cnt;
	move.w	d0,d1
	add.w	d1,$3C(a2)
;					uniquePos++;
	addq.w	#1,$42(a2)
L389
;				cnt = 1;
	moveq	#1,d0
;				prev = t;
	move.w	d4,d1
	ext.l	d1
L390
	addq.l	#1,d2
L391
	cmp.l	d5,d2
	ble.b	L382
L392
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "Analyse__XDACENCODE__T:0",CODE


;void	XDACENCODE::Analyse()
	XDEF	Analyse__XDACENCODE__T
Analyse__XDACENCODE__T
L395	EQU	-$20
	link	a5,#L395
	movem.l	d2/d3/a2/a3/a6,-(a7)
	move.l	$8(a5),a2
L394
;	MILLICLOCK t;
	lea	-$8(a5),a0
	move.l	a0,a3
	move.l	_TimerBase,a6
	move.l	#_current__MILLICLOCK,a0
	jsr	-$3C(a6)
	move.l	d0,_clockFreq__MILLICLOCK
	lea	_current__MILLICLOCK,a1
	move.l	a3,a0
	move.l	(a1),(a0)
	move.l	4(a1),4(a0)
	lea	-$8(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__MILLICLOCK__T,-(a1)
	XREF	sym_handlers
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;	FetchData();
	move.l	a2,-(a7)
	jsr	FetchData__XDACENCODE__T
	addq.w	#4,a7
;	sint32 t1 = t.Elapsed();
	pea	-$8(a5)
	jsr	Elapsed__MILLICLOCK__T
	addq.w	#4,a7
	move.l	d0,d2
;	t.Set();
	lea	-$8(a5),a0
	move.l	a0,a3
	move.l	_TimerBase,a6
	move.l	#_current__MILLICLOCK,a0
	jsr	-$3C(a6)
	lea	_current__MILLICLOCK,a1
	move.l	a3,a0
	move.l	(a1),(a0)
	move.l	4(a1),4(a0)
;	CalcDeltaPop();
	move.l	a2,-(a7)
	jsr	CalcDeltaPop__XDACENCODE__T
	addq.w	#4,a7
;	sint32 t2 = t.Elapsed();
	pea	-$8(a5)
	jsr	Elapsed__MILLICLOCK__T
	addq.w	#4,a7
	move.l	d0,d3
;	t.Set();
	lea	-$8(a5),a0
	move.l	a0,a3
	move.l	_TimerBase,a6
	move.l	#_current__MILLICLOCK,a0
	jsr	-$3C(a6)
	lea	_current__MILLICLOCK,a1
	move.l	a3,a0
	move.l	(a1),(a0)
	move.l	4(a1),4(a0)
;	GenTable();
	move.l	a2,-(a7)
	jsr	GenTable__XDACENCODE__T
	addq.w	#4,a7
;	sint32 t3 = t.Elapsed();
	pea	-$8(a5)
	jsr	Elapsed__MILLICLOCK__T
	addq.w	#4,a7
;	evalTime = t1+t2+t3;
	add.l	d3,d2
	add.l	d0,d2
	move.l	a2,a0
	move.l	d2,$28(a0)
;	flags |= ANALYSED;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$8,d0
	move.l	a2,a0
	move.l	d0,(a0)
	lea	-$14(a5),a0
	XREF	lib_destruct_a0
	jsr	lib_destruct_a0
	movem.l	(a7)+,d2/d3/a2/a3/a6
	unlk	a5
	rts

	SECTION "GenTable__XDACENCODE__T:0",CODE


;void	XDACENCODE::GenTable()
	XDEF	GenTable__XDACENCODE__T
GenTable__XDACENCODE__T
L455	EQU	-$1C
	link	a5,#L455
	movem.l	d2-d7,-(a7)
	move.l	$8(a5),a0
L396
;	encodeRate = bitRate;
	move.w	$30(a0),d0
	move.w	d0,$34(a0)
;	if (flags & ZERO_FRAME)
	move.l	(a0),d0
	and.l	#1,d0
	beq.b	L398
L397
	movem.l	(a7)+,d2-d7
	unlk	a5
	rts
L398
;	if (uniqueDelta<=(1<<bitRate))
	move.w	$32(a0),d1
	ext.l	d1
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d2
	asl.l	d0,d2
	cmp.l	d2,d1
	bgt.b	L406
L399
;		flags |= SKIP_QUANT;
	or.l	#2,(a0)
;		sint32 u = uniqueDelta;
	move.w	$32(a0),d1
	ext.l	d1
;		while (u < (1<<(encodeRate-1)))
	bra.b	L401
L400
;			encodeRate--;
	subq.w	#1,$34(a0)
L401
	move.w	$34(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#1,d2
	asl.l	d0,d2
	cmp.l	d2,d1
	blt.b	L400
L402
;		if (minDelta>-127 && maxDelta<128)
	move.w	$44(a0),d0
	cmp.w	#-$7F,d0
	ble.b	L405
L403
	move.w	$46(a0),d0
	cmp.w	#$80,d0
	bge.b	L405
L404
;			flags |= TABLE_8BIT;
	or.l	#$10,(a0)
L405
	movem.l	(a7)+,d2-d7
	unlk	a5
	rts
L406
;		flags &= ~(SKIP_QUANT|TABLE_8BIT);
	and.l	#-$13,(a0)
;	sint32 allocMax		= (1<<bitRate);
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d4
	asl.l	d0,d4
;	sint32 allocZero	= (zeroPop >= minPop);
	move.w	$3A(a0),d2
	cmp.w	$3E(a0),d2
	sge	d2
	and.l	#1,d2
;	sint32 totalPop		= (channels*(frameSize-1))-(allocZero ? zeroPop :
	move.w	$2E(a0),d0
	ext.l	d0
	move.w	$2C(a0),d1
	ext.l	d1
	subq.l	#1,d1
	muls.l	d1,d0
	tst.l	d2
	beq.b	L408
L407
	move.w	$3A(a0),d1
	ext.l	d1
	bra.b	L409
L408
	moveq	#0,d1
L409
	sub.l	d1,d0
;	sint32 allocNeg		= Clamp((sint32)(0.5F+(float32)(negPop*(allocMax-
	move.w	$40(a0),d5
	moveq	#0,d3
	move.w	$38(a0),d1
	ext.l	d1
	move.l	d4,d6
	sub.l	d2,d6
	muls.l	d6,d1
	fmove.l	d1,fp0
	fmove.l	d0,fp1
	fdiv.x	fp1,fp0
	fadd.s	#$.3F000000,fp0
	fmove.l	fp0,d0
	cmp.l	d3,d0
	bge.b	L411
L410
	move.l	d3,d0
	bra.b	L415
L411
	move.w	d5,d1
	ext.l	d1
	cmp.l	d1,d0
	ble.b	L413
L412
	move.w	d5,d0
	ext.l	d0
L413
L414
L415
;	sint32 allocPos		= Clamp((sint32)(allocMax-allocZero-allocNeg), 0,
	move.w	$42(a0),d5
	moveq	#0,d3
	move.l	d4,d1
	sub.l	d2,d1
	sub.l	d0,d1
	cmp.l	d3,d1
	bge.b	L417
L416
	move.l	d3,d1
	bra.b	L421
L417
	move.w	d5,d3
	ext.l	d3
	cmp.l	d3,d1
	ble.b	L419
L418
	move.w	d5,d1
	ext.l	d1
L419
L420
L421
;		sint32 rem = allocMax-(allocPos+allocNeg+allocZero);
	move.l	d1,d3
	add.l	d0,d3
	add.l	d2,d3
	move.l	d4,d5
	sub.l	d3,d5
	move.l	d5,d3
;		if (rem > 0)
	cmp.l	#0,d3
	ble.b	L436
L422
;			bool negIdeal = (allocNeg==uniqueNeg)
	move.w	$40(a0),d4
	ext.l	d4
	cmp.l	d0,d4
	seq	d4
	and.l	#1,d4
	move.w	d4,d5
;			bool negIdeal = (allocN
	move.w	$42(a0),d4
	ext.l	d4
	cmp.l	d1,d4
	seq	d4
	and.l	#1,d4
;			if (negIdeal && posIdeal && !allocZero && zeroPop)
	tst.w	d5
	beq.b	L427
L423
	tst.w	d4
	beq.b	L427
L424
	tst.l	d2
	bne.b	L427
L425
	tst.w	$3A(a0)
	beq.b	L427
L426
;				rem--;
	subq.l	#1,d3
;				allocZero = 1;
	moveq	#1,d2
L427
;			if (rem && negIdeal && !posIdeal)
	tst.l	d3
	beq.b	L431
L428
	tst.w	d5
	beq.b	L431
L429
	tst.w	d4
	bne.b	L431
L430
;				allocPos+=rem;
	add.l	d3,d1
;				rem = 0;
	moveq	#0,d3
L431
;			if (rem && !negIdeal && posIdeal)
	tst.l	d3
	beq.b	L435
L432
	tst.w	d5
	bne.b	L435
L433
	tst.w	d4
	beq.b	L435
L434
;				allocNeg+=rem;
	add.l	d3,d0
L435
	bra.b	L447
L436
;		else if (rem < 0)
	tst.l	d3
	bpl.b	L447
L437
;			while ((allocNeg+allocZero+allocPos)>allocMax)
	bra.b	L441
L438
;				if (allocNeg>allocPos)
	cmp.l	d1,d0
	ble.b	L440
L439
;					allocNeg--;
	subq.l	#1,d0
	bra.b	L441
L440
;					allocPos--;
	subq.l	#1,d1
L441
	move.l	d0,d3
	add.l	d2,d3
	add.l	d1,d3
	cmp.l	d4,d3
	bgt.b	L438
L442
;			while ((allocNeg+allocZero+allocPos)>allocMax)
	bra.b	L446
L443
;				if (allocNeg>allocPos)
	cmp.l	d1,d0
	ble.b	L445
L444
;					allocNeg--;
	subq.l	#1,d0
	bra.b	L446
L445
;					allocPos--;
	subq.l	#1,d1
L446
	move.l	d0,d3
	add.l	d2,d3
	add.l	d1,d3
	cmp.l	d4,d3
	bgt.b	L443
L447
;	if (flags & FORCE_S1)
	move.l	(a0),d3
	and.l	#$10000,d3
	beq.b	L449
L448
;		DeltaModelSerkan1(allocNeg, allocPos, allocZero);
	move.w	d2,-(a7)
	move.w	d1,-(a7)
	move.w	d0,-(a7)
	move.l	a0,-(a7)
	jsr	DeltaModelSerkan1__XDACENCODE__Tsss
	add.w	#$A,a7
	bra.b	L454
L449
;	else if (flags & FORCE_K1)
	move.l	(a0),d3
	and.l	#$20000,d3
	beq.b	L451
L450
;		DeltaModelKarl1(allocNeg, allocPos, allocZero);
	move.w	d2,-(a7)
	move.w	d1,-(a7)
	move.w	d0,-(a7)
	move.l	a0,-(a7)
	jsr	DeltaModelKarl1__XDACENCODE__Tsss
	add.w	#$A,a7
	bra.b	L454
L451
;	else if (uniqueDelta<96)
	move.w	$32(a0),d3
	cmp.w	#$60,d3
	bge.b	L453
L452
;		DeltaModelSerkan1(allocNeg, allocPos, allocZero);
	move.w	d2,-(a7)
	move.w	d1,-(a7)
	move.w	d0,-(a7)
	move.l	a0,-(a7)
	jsr	DeltaModelSerkan1__XDACENCODE__Tsss
	add.w	#$A,a7
	bra.b	L454
L453
;		DeltaModelKarl1(allocNeg, allocPos, allocZero);
	move.w	d2,-(a7)
	move.w	d1,-(a7)
	move.w	d0,-(a7)
	move.l	a0,-(a7)
	jsr	DeltaModelKarl1__XDACENCODE__Tsss
	add.w	#$A,a7
L454
	movem.l	(a7)+,d2-d7
	unlk	a5
	rts

	SECTION "DeltaModelKarl1__XDACENCODE__Tsss:0",CODE


;void	XDACENCODE::DeltaModelKarl1(sint16 allocNeg, sint16 allocPos, b
	XDEF	DeltaModelKarl1__XDACENCODE__Tsss
DeltaModelKarl1__XDACENCODE__Tsss
L485	EQU	-$20
	link	a5,#L485
	movem.l	d2-d7/a2-a4,-(a7)
	move.w	$E(a5),d5
	move.w	$C(a5),d6
	move.l	$8(a5),a4
L456
;	sint32 allocMax = (1<<bitRate);
	move.l	a4,a0
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	d1,-4(a5)
;	rsint16 *dT = Table();
	move.l	a4,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L458
L457
	move.l	$14(a0),a3
	bra.b	L459
L458
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	lea	0(a1,d1.l*2),a3
L459
;	if (allocNeg)
	tst.w	d6
	beq.b	L466
L460
;		rsint16*	uF 		= uDeltaFreq;
	move.l	a4,a1
	move.l	$18(a1),a0
;		rsint16*	uD 		= uDelta;
	move.l	a4,a2
	move.l	$14(a2),a1
;		rsint32		mPop	= negPop/allocNeg;
	move.l	a4,a2
	move.w	$38(a2),d4
	ext.l	d4
	divs	d6,d4
	ext.l	d4
;		rsint32		bias	= /*uniqueDelta>(channels*(frameSize>>1)) ? minDel
	moveq	#0,d7
;		allocNeg++;
	move.w	d6,d0
	addq.w	#1,d0
	move.w	d0,d6
;		while (--allocNeg)
	bra.b	L465
L461
;			rsint32 tPop			= 1;
	moveq	#1,d0
;			rsint32	estimate	= bias;
	move.l	d7,d1
;			while (tPop<mPop)
	bra.b	L463
L462
;				tPop		 += *uF;
	move.w	(a0),d2
	ext.l	d2
	add.l	d2,d0
;				estimate += (*uD++)*(*uF++);
	move.w	(a0)+,d2
	muls	(a1)+,d2
	add.l	d2,d1
L463
	cmp.l	d4,d0
	blt.b	L462
L464
;			*dT++ = (estimate/tPop);
	divsl.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a3)+
L465
	move.w	d6,d0
	subq.w	#1,d0
	move.w	d0,d6
	bne.b	L461
L466
;	if (allocZero)
	tst.w	$10(a5)
	beq.b	L468
L467
;		*dT = 0;
	clr.w	(a3)
L468
;	if (allocPos)
	tst.w	d5
	beq	L478
L469
;		dT = (Table())+allocMax;
	move.l	a4,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L471
L470
	move.l	$14(a0),a0
	bra.b	L472
L471
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	lea	0(a1,d1.l*2),a0
L472
	move.l	-4(a5),d0
	lea	0(a0,d0.l*2),a3
;		rsint16*	uF 			= uDeltaFreq+uniqueDelta;
	move.l	a4,a1
	move.l	$18(a1),a0
	move.l	a4,a1
	move.w	$32(a1),d0
	ext.l	d0
	lea	0(a0,d0.l*2),a0
;		rsint16*	uD 			= uDelta+uniqueDelta-1;
	move.l	a4,a2
	move.l	$14(a2),a1
	move.l	a4,a2
	move.w	$32(a2),d0
	ext.l	d0
	lea	0(a1,d0.l*2),a1
	subq.w	#2,a1
;		rsint32		mPop		= posPop/allocPos;
	move.l	a4,a2
	move.w	$3C(a2),d4
	ext.l	d4
	divs	d5,d4
	ext.l	d4
;		rsint32		bias		= /*uniqueDelta>(channels*(frameSize>>1)) ? maxDe
	moveq	#0,d6
;		allocPos++;
	addq.w	#1,d5
;		while (--allocPos)
	bra.b	L477
L473
;			rsint32 tPop			= 1;
	moveq	#1,d0
;			rsint32	estimate	= bias;
	move.l	d6,d1
;			while (tPop<mPop)
	bra.b	L475
L474
;				tPop		 += *(--uF);
	move.w	-(a0),d2
	ext.l	d2
	add.l	d2,d0
;				estimate += (*uD--)*(*uF);
	move.l	a1,a2
	subq.w	#2,a1
	move.w	(a0),d2
	muls	(a2),d2
	add.l	d2,d1
L475
	cmp.l	d4,d0
	blt.b	L474
L476
;			*(--dT) = (estimate/tPop);
	divsl.l	d0,d1
	move.w	d1,d0
	move.w	d0,-(a3)
L477
	subq.w	#1,d5
	tst.w	d5
	bne.b	L473
L478
;	dT = Table();
	move.l	a4,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L480
L479
	move.l	$14(a0),a3
	bra.b	L481
L480
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	lea	0(a1,d1.l*2),a3
L481
;	if(dT[0]>-127 && dT[allocMax-1]<128)
	move.w	(a3),d0
	cmp.w	#-$7F,d0
	ble.b	L484
L482
	subq.l	#1,-4(a5)
	move.l	-4(a5),d0
	move.w	0(a3,d0.l*2),d0
	cmp.w	#$80,d0
	bge.b	L484
L483
;		flags |= TABLE_8BIT;
	move.l	a4,a0
	move.l	(a0),d0
	or.l	#$10,d0
	move.l	a4,a0
	move.l	d0,(a0)
L484
	movem.l	(a7)+,d2-d7/a2-a4
	unlk	a5
	rts

	SECTION "DeltaModelSerkan1__XDACENCODE__Tsss:0",CODE


;void XDACENCODE::DeltaModelSerkan1(sint16 allocNeg, sint16 allocPos,
	XDEF	DeltaModelSerkan1__XDACENCODE__Tsss
DeltaModelSerkan1__XDACENCODE__Tsss
L530	EQU	-$2C
	link	a5,#L530
	movem.l	d2-d7/a2/a3,-(a7)
	move.l	$8(a5),a2
L486
;	sint32 allocMax = (1<<bitRate);
	move.w	$30(a2),d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	d1,-4(a5)
;	rsint16 *dT = Table();
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L488
L487
	move.l	$14(a0),a1
	bra.b	L489
L488
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	lea	0(a1,d1.l*2),a1
L489
;	rsint16 *dF = qDeltaFreq;
	move.l	$10(a2),a0
;	if (allocNeg)
	tst.w	$C(a5)
	beq	L505
L490
;		sint32 totalPop = uniqueNeg;
	move.w	$40(a2),d3
	ext.l	d3
;		for (rsint32 i = 0;
	moveq	#0,d0
	bra.b	L492
L491
;			dT[i]	= uDelta[i];
	move.l	$14(a2),a3
	move.w	0(a3,d0.l*2),d1
	move.w	d1,0(a1,d0.l*2)
;			dF[i]	= uDeltaFreq[i];
	move.l	$18(a2),a3
	move.w	0(a3,d0.l*2),d1
	move.w	d1,0(a0,d0.l*2)
	addq.l	#1,d0
L492
	move.w	$40(a2),d1
	ext.l	d1
	cmp.l	d1,d0
	blt.b	L491
L493
;		while (totalPop > allocNeg)
	bra	L504
L494
;			sint32 minDif = (1UL<<30)
	move.l	#$40000000,d4
;			sint32 minDif = (1UL<<30), index = 
	moveq	#-1,d7
;			for (i = 0;
	moveq	#0,d0
	bra.b	L498
L495
;				sint32 temp = (dT[i+1]-dT[i])*(dF[i]+dF[i+1]);
	move.l	d0,d1
	addq.l	#1,d1
	move.w	0(a1,d1.l*2),d1
	ext.l	d1
	move.w	0(a1,d0.l*2),d2
	ext.l	d2
	sub.l	d2,d1
	move.w	0(a0,d0.l*2),d2
	ext.l	d2
	move.l	d0,d5
	addq.l	#1,d5
	move.w	0(a0,d5.l*2),d5
	ext.l	d5
	add.l	d5,d2
	muls.l	d2,d1
;				if (temp < minDif)
	cmp.l	d4,d1
	bge.b	L497
L496
;					minDif = temp;
	move.l	d1,d4
;					index = i;
	move.l	d0,d7
L497
	addq.l	#1,d0
L498
	move.l	d3,d1
	subq.l	#1,d1
	cmp.l	d1,d0
	blt.b	L495
L499
;			if (index!=-1)
	move.l	d7,d0
	cmp.l	#-1,d0
	beq.b	L503
L500
;				i = index;
	move.l	d7,d0
;					dT[i] = (dT[i]*dF[i] + dT[i+1]*dF[i+1]) / (dF[i]+dF[i+1]);
	move.w	0(a0,d0.l*2),d1
	muls	0(a1,d0.l*2),d1
	move.l	d0,d2
	addq.l	#1,d2
	move.w	0(a1,d2.l*2),d4
	move.l	d0,d2
	addq.l	#1,d2
	move.w	0(a0,d2.l*2),d2
	muls	d4,d2
	add.l	d2,d1
	move.w	0(a0,d0.l*2),d2
	ext.l	d2
	move.l	d0,d4
	addq.l	#1,d4
	move.w	0(a0,d4.l*2),d4
	ext.l	d4
	add.l	d4,d2
	divsl.l	d2,d1
	move.w	d1,0(a1,d0.l*2)
;					dF[i] += dF[i+1];
	move.l	d0,d1
	addq.l	#1,d1
	lea	0(a0,d0.l*2),a3
	move.w	0(a0,d1.l*2),d0
	add.w	d0,(a3)
;				for (i = index+1;
	move.l	d7,d0
	addq.l	#1,d0
	bra.b	L502
L501
;					dT[i]=dT[i+1];
	move.l	d0,d1
	addq.l	#1,d1
	move.w	0(a1,d1.l*2),0(a1,d0.l*2)
;					dF[i]=dF[i+1];
	move.l	d0,d1
	addq.l	#1,d1
	move.w	0(a0,d1.l*2),0(a0,d0.l*2)
	addq.l	#1,d0
L502
	move.l	d3,d1
	subq.l	#1,d1
	cmp.l	d1,d0
	blt.b	L501
L503
;			totalPop--;
	subq.l	#1,d3
L504
	move.w	$C(a5),d0
	ext.l	d0
	cmp.l	d0,d3
	bgt	L494
L505
;	dT += allocNeg;
	move.w	$C(a5),d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
;	if (allocZero)
	tst.w	$10(a5)
	beq.b	L507
L506
;		*dT++ = 0;
	clr.w	(a1)+
L507
;	if (allocPos)
	tst.w	$E(a5)
	beq	L523
L508
;		sint32 totalPop = uniqueNeg+allocZero;
	move.w	$40(a2),d3
	ext.l	d3
	move.w	$10(a5),d0
	ext.l	d0
	add.l	d0,d3
;		for (rsint32 i=0;
	moveq	#0,d0
	bra.b	L510
L509
;			dT[i]	= uDelta[totalPop];
	move.l	$14(a2),a3
	move.w	0(a3,d3.l*2),d1
	move.w	d1,0(a1,d0.l*2)
;			dF[i]	= uDeltaFreq[totalPop];
	move.l	$18(a2),a3
	move.w	0(a3,d3.l*2),d1
	move.w	d1,0(a0,d0.l*2)
	addq.l	#1,d0
	addq.l	#1,d3
L510
	move.w	$42(a2),d1
	ext.l	d1
	cmp.l	d1,d0
	blt.b	L509
L511
;		totalPop = uniquePos;
	move.w	$42(a2),d3
	ext.l	d3
;		while (totalPop > allocPos)
	bra	L522
L512
;			sint32 minDif = (1UL<<30)
	move.l	#$40000000,d4
;			sint32 minDif = (1UL<<30), index = 
	moveq	#-1,d7
;			for (i=0;
	moveq	#0,d0
	bra.b	L516
L513
;				sint32 temp = (dT[i+1]-dT[i])*(dF[i]+dF[i+1]);
	move.l	d0,d1
	addq.l	#1,d1
	move.w	0(a1,d1.l*2),d1
	ext.l	d1
	move.w	0(a1,d0.l*2),d2
	ext.l	d2
	sub.l	d2,d1
	move.w	0(a0,d0.l*2),d2
	ext.l	d2
	move.l	d0,d5
	addq.l	#1,d5
	move.w	0(a0,d5.l*2),d5
	ext.l	d5
	add.l	d5,d2
	muls.l	d2,d1
;				if (temp < minDif)
	cmp.l	d4,d1
	bge.b	L515
L514
;					minDif = temp;
	move.l	d1,d4
;					index = i;
	move.l	d0,d7
L515
	addq.l	#1,d0
L516
	move.l	d3,d1
	subq.l	#1,d1
	cmp.l	d1,d0
	blt.b	L513
L517
;			if (index!=-1)
	move.l	d7,d0
	cmp.l	#-1,d0
	beq.b	L521
L518
;				i = index;
	move.l	d7,d0
;				dT[i] = (dT[i]*dF[i] + dT[i+1]*dF[i+1]) / (dF[i]+dF[i+1]);
	move.w	0(a0,d0.l*2),d1
	muls	0(a1,d0.l*2),d1
	move.l	d0,d2
	addq.l	#1,d2
	move.w	0(a1,d2.l*2),d4
	move.l	d0,d2
	addq.l	#1,d2
	move.w	0(a0,d2.l*2),d2
	muls	d4,d2
	add.l	d2,d1
	move.w	0(a0,d0.l*2),d2
	ext.l	d2
	move.l	d0,d4
	addq.l	#1,d4
	move.w	0(a0,d4.l*2),d4
	ext.l	d4
	add.l	d4,d2
	divsl.l	d2,d1
	move.w	d1,0(a1,d0.l*2)
;				dF[i] += dF[i+1];
	move.l	d0,d1
	addq.l	#1,d1
	lea	0(a0,d0.l*2),a3
	move.w	0(a0,d1.l*2),d0
	add.w	d0,(a3)
;				for (i = index+1;
	move.l	d7,d0
	addq.l	#1,d0
	bra.b	L520
L519
;					dT[i]=dT[i+1];
	move.l	d0,d1
	addq.l	#1,d1
	move.w	0(a1,d1.l*2),0(a1,d0.l*2)
;					dF[i]=dF[i+1];
	move.l	d0,d1
	addq.l	#1,d1
	move.w	0(a0,d1.l*2),0(a0,d0.l*2)
	addq.l	#1,d0
L520
	move.l	d3,d1
	subq.l	#1,d1
	cmp.l	d1,d0
	blt.b	L519
L521
;			totalPop--;
	subq.l	#1,d3
L522
	move.w	$E(a5),d0
	ext.l	d0
	cmp.l	d0,d3
	bgt	L512
L523
;	dT = Table();
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#2,d0
	beq.b	L525
L524
	move.l	$14(a0),a1
	bra.b	L526
L525
	move.w	$2E(a0),d0
	ext.l	d0
	move.l	$C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.w	$2C(a0),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	lea	0(a1,d1.l*2),a1
L526
;	if(dT[0]>-127 && dT[allocMax-1]<128)
	move.w	(a1),d0
	cmp.w	#-$7F,d0
	ble.b	L529
L527
	subq.l	#1,-4(a5)
	move.l	-4(a5),d0
	move.w	0(a1,d0.l*2),d0
	cmp.w	#$80,d0
	bge.b	L529
L528
;		flags |= TABLE_8BIT;
	or.l	#$10,(a2)
L529
	movem.l	(a7)+,d2-d7/a2/a3
	unlk	a5
	rts

	SECTION "GetApprox__XDACENCODE__Ts:0",CODE


;sint32 XDACENCODE::GetApprox(sint16 d)
	XDEF	GetApprox__XDACENCODE__Ts
GetApprox__XDACENCODE__Ts
L545	EQU	-$18
	link	a5,#L545
	movem.l	d2-d6/a2,-(a7)
	move.w	$C(a5),d6
	move.l	$8(a5),a0
L531
;	sint32 minAbs=(1UL<<30)
	move.l	#$40000000,d3
;	sint32 minAbs=(1UL<<30), index=-1;
	moveq	#-1,d4
;	sint16* qTable = Table();
	move.l	a0,a1
	move.l	(a1),d0
	and.l	#2,d0
	beq.b	L533
L532
	move.l	$14(a1),a2
	bra.b	L534
L533
	move.w	$2E(a1),d0
	ext.l	d0
	move.l	$C(a1),a2
	lea	0(a2,d0.l*2),a2
	move.w	$2C(a1),d0
	ext.l	d0
	subq.l	#1,d0
	moveq	#0,d1
	muls.l	d0,d1
	lea	0(a2,d1.l*2),a2
L534
;	sint32 tableSize = uniqueDelta < (1<<bitRate) ? uniqueDelta : (1<<
	move.w	$32(a0),d1
	ext.l	d1
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d2
	asl.l	d0,d2
	cmp.l	d2,d1
	bge.b	L536
L535
	move.w	$32(a0),d5
	ext.l	d5
	bra.b	L537
L536
	move.w	$30(a0),d0
	ext.l	d0
	moveq	#1,d5
	asl.l	d0,d5
L537
;  for(rsint32 i=0;
	moveq	#0,d2
	bra.b	L541
L538
;		rsint32 v = abs(qTable[i]-d);
	move.w	0(a2,d2.l*2),d0
	ext.l	d0
	move.w	d6,d1
	ext.l	d1
	sub.l	d1,d0
	move.l	d0,-(a7)
	jsr	_abs
	addq.w	#4,a7
; 	  if (v<minAbs)
	cmp.l	d3,d0
	bge.b	L540
L539
; 	    minAbs = v;
	move.l	d0,d3
; 	    index  = i;
	move.l	d2,d4
L540
	addq.l	#1,d2
L541
	cmp.l	d5,d2
	blt.b	L538
L542
;  if (index==-1)
	cmp.l	#-1,d4
	bne.b	L544
L543
	move.l	#-$3010000,d0
	movem.l	(a7)+,d2-d6/a2
	unlk	a5
	rts
L544
	move.l	d4,d0
	movem.l	(a7)+,d2-d6/a2
	unlk	a5
	rts

	SECTION "compare__PCvPCv:0",CODE


;int compare(const void* p1, const void* p2)
	XDEF	compare__PCvPCv
compare__PCvPCv
L552	EQU	0
	link	a5,#L552
	move.l	$C(a5),a0
	move.l	$8(a5),a1
L546
;	rsint16 v1 = *((sint16*)p1);
	move.w	(a1),d1
;	rsint16 v2 = *((sint16*)p2);
	move.w	(a0),d0
;	if (v1==v2)
	cmp.w	d0,d1
	bne.b	L548
L547
	moveq	#0,d0
	unlk	a5
	rts
L548
	cmp.w	d0,d1
	ble.b	L550
L549
	moveq	#1,d0
	bra.b	L551
L550
	moveq	#-1,d0
L551
	unlk	a5
	rts

	SECTION "_0dt__MILLICLOCK__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__MILLICLOCK__T
_0dt__MILLICLOCK__T
L554	EQU	0
	link	a5,#L554
L553
	unlk	a5
	rts

	END
