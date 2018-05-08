
; Storm C Compiler
; Developer:eXtropia/eXtropiaOld/lib/Platforms/Amiga68k/SoundLib/PCM.cpp
	mc68030
	mc68881
	XREF	_0ct__XSFOBJ__TPCcUsUsUcUc
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
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__UisE
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
	XREF	_AHIBase
	XREF	_AHIport__xAUDIO
	XREF	_AHImain__xAUDIO
	XREF	_flags__xAUDIO
	XREF	_KeymapBase
	XREF	_useCount__xKEY
	XREF	_sigXSF__XSFHEAD
	XREF	_fileMarker__XSFOBJ

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_rawSig__PCM:0",CODE


L110
	dc.b	'Raw16Bit',0

	SECTION "_rawSig__PCM:1",DATA

	XDEF	_rawSig__PCM
_rawSig__PCM
	dc.l	L110

	SECTION "Free__PCM__T:0",CODE


;sint32 PCM::Free()
	XDEF	Free__PCM__T
Free__PCM__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L112
;	if (data)
	tst.l	(a2)
	beq.b	L114
L113
;		MEM::Free(data);
	move.l	(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		data = 0;
	clr.l	(a2)
;		biggest = 0;
	clr.l	$8(a2)
	bra.b	L115
L114
;	return OK;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts
L115
	move.l	(a7)+,a2
	rts

	SECTION "New__PCM__Tjjj:0",CODE


;sint32 PCM::New(sint32 size, sint32 chn, sint32 frq)
	XDEF	New__PCM__Tjjj
New__PCM__Tjjj
	movem.l	d2-d5/a2,-(a7)
	movem.l	$1C(a7),d2/d4/d5
	move.l	$18(a7),a2
L116
;	Channels(chn);
	move.l	d4,d0
	move.l	a2,a0
	moveq	#4,d3
	moveq	#1,d1
	cmp.l	d1,d0
	bge.b	L118
L117
	move.l	d1,d0
	bra.b	L122
L118
	cmp.l	d3,d0
	ble.b	L120
L119
	move.l	d3,d0
L120
L121
L122
	move.w	d0,$C(a0)
;	Frequency(frq);
	move.l	d5,d0
	move.l	a2,a0
	move.l	#$FA00,d3
	move.l	#$113A,d1
	cmp.l	d1,d0
	bge.b	L124
L123
	move.l	d1,d0
	bra.b	L128
L124
	cmp.l	d3,d0
	ble.b	L126
L125
	move.l	d3,d0
L126
L127
L128
	move.w	d0,$E(a0)
;	size*=chn;
	muls.l	d4,d2
;	if (size <= 0)
	cmp.l	#0,d2
	bgt.b	L130
L129
;		return ERR_VALUE_MIN;
	move.l	#-$3010004,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L130
;	if (size > (biggest>>1) && size <= biggest)
	move.l	$8(a2),d0
	moveq	#1,d1
	asr.l	d1,d0
	cmp.l	d0,d2
	ble.b	L133
L131
	cmp.l	$8(a2),d2
	bgt.b	L133
L132
;		numData = size;
	move.l	d2,4(a2)
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L133
;		if (data)
	tst.l	(a2)
	beq.b	L135
L134
;			Free();
	move.l	a2,-(a7)
	jsr	Free__PCM__T
	addq.w	#4,a7
L135
;		numData = size;
	move.l	d2,4(a2)
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2
	rts

	SECTION "Delete__PCM__Ts:0",CODE


;sint32 PCM::Delete(bool f)
	XDEF	Delete__PCM__Ts
Delete__PCM__Ts
	move.l	a2,-(a7)
	move.w	$C(a7),d0
	move.l	$8(a7),a2
L136
;	if (f)
	tst.w	d0
	beq.b	L138
L137
;		Free();
	move.l	a2,-(a7)
	jsr	Free__PCM__T
	addq.w	#4,a7
L138
;	numData = 0;
	clr.l	4(a2)
;	return OK;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts

	SECTION "Data__PCM__T:0",CODE


;sint16* PCM::Data()
	XDEF	Data__PCM__T
Data__PCM__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L139
;	if (numData == 0)
	tst.l	4(a2)
	bne.b	L141
L140
;		return 0;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts
L141
;	if (data == 0)
	move.l	(a2),a0
	cmp.w	#0,a0
	bne.b	L145
L142
;		data = (sint16*)MEM::Alloc(numData*sizeof(sint16), false);
	clr.l	-(a7)
	clr.w	-(a7)
	move.l	4(a2),d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,(a2)
;		if (data)
	tst.l	(a2)
	beq.b	L144
L143
;			biggest = numData;
	move.l	4(a2),d0
	move.l	d0,$8(a2)
	bra.b	L145
L144
;			biggest = 0;
	clr.l	$8(a2)
L145
;	return data;
	move.l	(a2),d0
	move.l	(a7)+,a2
	rts

	SECTION "LoadRaw16__PCM__TPCcUss:0",CODE


;sint32 PCM::LoadRaw16(const char* filename, uint16 freq, sint16 chan)
	XDEF	LoadRaw16__PCM__TPCcUss
LoadRaw16__PCM__TPCcUss
L172	EQU	-$B4
	link	a5,#L172
	movem.l	d2-d4/a2/a3,-(a7)
	move.w	$12(a5),d3
	move.w	$10(a5),d4
	move.l	$C(a5),a1
	move.l	$8(a5),a2
L146
;	xFILEIO src(filename, xFILEIO::READ);
	lea	-$9A(a5),a0
	clr.l	(a0)
	clr.l	$96(a0)
	pea	$400.w
	pea	1.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Open__xFILEIO__TPCcjj
	add.w	#$10,a7
;	if (!src.Valid())
	move.l	-4(a5),d0
	and.l	#$40,d0
	tst.w	d0
	bne.b	L148
L147
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L148
;	sint32 fileSize = src.Size();
	lea	-$9A(a5),a0
	move.l	$96(a0),d0
	and.l	#5,d0
	beq.b	L150
L149
	move.l	4(a0),d2
	bra.b	L151
L150
	move.l	#-$3040000,d2
L151
;	char sig[10] = {0};
	lea	-$A8(a5),a0
	clr.b	(a0)+
	moveq	#$8,d0
L173
	clr.b	(a0)+
	dbra	d0,L173
;	if (src.Read(sig,1,8)<8)
	pea	$8.w
	pea	1.w
	pea	-$A8(a5)
	pea	-$9A(a5)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#$8,d0
	bge.b	L153
L152
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L153
;	if (strncmp(sig,rawSig,8))
	pea	$8.w
	move.l	_rawSig__PCM,-(a7)
	pea	-$A8(a5)
	jsr	_strncmp
	add.w	#$C,a7
	tst.l	d0
	beq.b	L155
L154
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L155
;	Delete();
	move.w	#1,-(a7)
	move.l	a2,-(a7)
	jsr	Delete__PCM__Ts
	addq.w	#6,a7
;	New((fileSize-8)/2);
	pea	$5622.w
	pea	1.w
	subq.l	#$8,d2
	divsl.l	#2,d2
	move.l	d2,-(a7)
	move.l	a2,-(a7)
	jsr	New__PCM__Tjjj
	add.w	#$10,a7
;	void* buf = Data();
	move.l	a2,-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
;	if (!buf)
	tst.l	d0
	bne.b	L157
L156
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L157
;	sint32 len = src.Read16(Data(), numData);
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
	move.l	d0,d2
;	src.Close();
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
;	if (len < numData)
	cmp.l	4(a2),d2
	bge.b	L159
L158
;		numData = len;
	move.l	d2,4(a2)
L159
;	Frequency(freq);
	moveq	#0,d0
	move.w	d4,d0
	move.l	a2,a0
	move.l	#$FA00,d2
	move.l	#$113A,d1
	cmp.l	d1,d0
	bge.b	L161
L160
	move.l	d1,d0
	bra.b	L165
L161
	cmp.l	d2,d0
	ble.b	L163
L162
	move.l	d2,d0
L163
L164
L165
	move.w	d0,$E(a0)
;	Channels(chan);
	move.w	d3,d0
	ext.l	d0
	move.l	a2,a0
	moveq	#4,d2
	moveq	#1,d1
	cmp.l	d1,d0
	bge.b	L167
L166
	move.l	d1,d0
	bra.b	L171
L167
	cmp.l	d2,d0
	ble.b	L169
L168
	move.l	d2,d0
L169
L170
L171
	move.w	d0,$C(a0)
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts

	SECTION "SaveRaw16__PCM__TPCc:0",CODE


;sint32 PCM::SaveRaw16(const char* filename)
	XDEF	SaveRaw16__PCM__TPCc
SaveRaw16__PCM__TPCc
L181	EQU	-$A4
	link	a5,#L181
	movem.l	d2/a2/a3,-(a7)
	move.l	$C(a5),a1
	move.l	$8(a5),a2
L174
;	xFILEIO dst(filename, xFILEIO::WRITE);
	lea	-$9A(a5),a0
	clr.l	(a0)
	clr.l	$96(a0)
	pea	$400.w
	pea	2.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Open__xFILEIO__TPCcjj
	add.w	#$10,a7
;	if (!dst.Valid())
	move.l	-4(a5),d0
	and.l	#$40,d0
	tst.w	d0
	bne.b	L176
L175
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	move.l	#-$3040006,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L176
;	if (dst.Write(rawSig,1,8)!=8)
	pea	$8.w
	pea	1.w
	move.l	_rawSig__PCM,-(a7)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	#$8,d0
	beq.b	L178
L177
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L178
;	void* buf = Data();
	move.l	a2,-(a7)
	jsr	Data__PCM__T
	addq.w	#4,a7
	move.l	d0,a0
;	if (dst.Write16(buf, numData)==numData)
	move.l	a0,a1
	move.l	4(a2),-(a7)
	pea	2.w
	move.l	a1,-(a7)
	pea	-$9A(a5)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	cmp.l	4(a2),d0
	bne.b	L180
L179
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L180
	pea	-$9A(a5)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts

	SECTION "DeBias__PCM__T:0",CODE


;sint32 PCM::DeBias()
	XDEF	DeBias__PCM__T
DeBias__PCM__T
L182
;	return OK;
	moveq	#0,d0
	rts

	SECTION "Normalize__PCM__Tf:0",CODE


;sint32 PCM::Normalize(float32 level)
	XDEF	Normalize__PCM__Tf
Normalize__PCM__Tf
L183
;	return OK;
	moveq	#0,d0
	rts

	SECTION "_0ct__xPCM__T:0",CODE


;xPCM::xPCM() 
	XDEF	_0ct__xPCM__T
_0ct__xPCM__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L185
	clr.b	-(a7)
	move.b	#1,-(a7)
	move.w	#1,-(a7)
	move.w	#$200,-(a7)
	move.l	#L184,-(a7)
	move.l	a2,-(a7)
	jsr	_0ct__XSFOBJ__TPCcUsUsUcUc
	add.w	#$10,a7
	lea	$20(a2),a0
	clr.l	(a0)
	clr.w	4(a0)
	clr.b	6(a0)
	clr.b	7(a0)
	clr.l	$28(a2)
;	RawSize(sizeof(shared));
	move.l	#$8,$C(a2)
	move.l	(a7)+,a2
	rts

L184
	dc.b	'eXtropia PCM audio',0

	SECTION "_0ct__xPCM__TUjjjj:0",CODE


;xPCM::xPCM(uint32 s, sint32 c, sint32 b, sint32 f) 
	XDEF	_0ct__xPCM__TUjjjj
_0ct__xPCM__TUjjjj
	movem.l	d2-d7/a2,-(a7)
	movem.l	$24(a7),d2-d4/d6
	move.l	$20(a7),a2
L187
	clr.b	-(a7)
	move.b	#1,-(a7)
	move.w	#1,-(a7)
	move.w	#$200,-(a7)
	move.l	#L186,-(a7)
	move.l	a2,-(a7)
	jsr	_0ct__XSFOBJ__TPCcUsUsUcUc
	add.w	#$10,a7
	lea	$20(a2),a0
	move.l	d2,(a0)
	move.w	d3,4(a0)
	move.b	d4,6(a0)
	move.b	d6,7(a0)
	clr.l	$28(a2)
	clr.l	$2C(a2)
;	if (s)
	tst.l	d2
	beq.b	L189
L188
;		New(s, c, b, f);
	move.l	d6,-(a7)
	move.l	d4,-(a7)
	move.l	d3,-(a7)
	move.l	d2,-(a7)
	move.l	a2,-(a7)
	jsr	New__xPCM__TUjjjj
	add.w	#$14,a7
L189
;	if (data)
	tst.l	$28(a2)
	beq.b	L191
L190
;		RawSize(sizeof(shared)+size);
	move.l	$2C(a2),d0
	addq.l	#$8,d0
	move.l	d0,$C(a2)
	bra.b	L192
L191
;		RawSize(sizeof(shared));
	move.l	#$8,$C(a2)
L192
	movem.l	(a7)+,d2-d7/a2
	rts

L186
	dc.b	'eXtropia PCM audio',0

	SECTION "New__xPCM__TUjjjj:0",CODE


;sint32 xPCM::New(uint32 s, sint32 c, sint32 b, sint32 f)
	XDEF	New__xPCM__TUjjjj
New__xPCM__TUjjjj
	movem.l	d2-d4/a2,-(a7)
	movem.l	$1C(a7),d2/d4
	move.l	$18(a7),d3
	move.l	$14(a7),a2
L193
;	if (data)
	tst.l	$28(a2)
	beq.b	L195
L194
;		MEM::Free(data);
	move.l	$28(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L195
;	if (b<9)
	cmp.l	#$9,d4
	bge.b	L197
L196
;		size = s*c;
	move.l	d3,d0
	mulu.l	d2,d0
	move.l	d0,$2C(a2)
	bra.b	L200
L197
;	else if (b<17)
	cmp.l	#$11,d4
	bge.b	L199
L198
;		size = s*c*sizeof(sint16);
	move.l	d3,d0
	mulu.l	d2,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,$2C(a2)
	bra.b	L200
L199
;		size = s*c*sizeof(sint32);
	move.l	d3,d0
	mulu.l	d2,d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,$2C(a2)
L200
;	data = MEM::Alloc(size, false);
	clr.l	-(a7)
	clr.w	-(a7)
	move.l	$2C(a2),-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,$28(a2)
;	if (!data)
	tst.l	$28(a2)
	bne.b	L202
L201
;		shared.samples = size = 0;
	clr.l	$2C(a2)
	clr.l	$20(a2)
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L202
;	shared.samples = s;
	move.l	d3,$20(a2)
;	shared.bits = Clamp(b, 8, 32);
	moveq	#$20,d3
	moveq	#$8,d1
	move.l	d4,d0
	cmp.l	d1,d0
	bge.b	L204
L203
	move.l	d1,d0
	bra.b	L208
L204
	cmp.l	d3,d0
	ble.b	L206
L205
	move.l	d3,d0
L206
L207
L208
	move.b	d0,$27(a2)
;	shared.chan = Clamp(c, 1, XPCM_MAXCHANS);
	moveq	#$8,d3
	moveq	#1,d1
	move.l	d2,d0
	cmp.l	d1,d0
	bge.b	L210
L209
	move.l	d1,d0
	bra.b	L214
L210
	cmp.l	d3,d0
	ble.b	L212
L211
	move.l	d3,d0
L212
L213
L214
	move.b	d0,$26(a2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2
	rts

	SECTION "Delete__xPCM__T:0",CODE


;sint32 xPCM::Delete()
	XDEF	Delete__xPCM__T
Delete__xPCM__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L215
;	if (data)
	tst.l	$28(a2)
	beq.b	L217
L216
;		MEM::Free(data);
	move.l	$28(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L217
;	data = 0;
	clr.l	$28(a2)
;	size = 0;
	clr.l	$2C(a2)
;	shared.samples = 0;
	clr.l	$20(a2)
;	return OK;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts

	SECTION "WriteBody__xPCM__TR05XSFIO:0",CODE


;sint32	xPCM::WriteBody(XSFIO& f)
	XDEF	WriteBody__xPCM__TR05XSFIO
WriteBody__xPCM__TR05XSFIO
	movem.l	d2/a2/a3,-(a7)
	move.l	$14(a7),a2
	move.l	$10(a7),a3
L218
;	if ( (f.Write32(&(shared.samples),1)!=1) || (f.Write16(&(shared.fr
	pea	1.w
	pea	$20(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	bne.b	L221
L219
	pea	1.w
	pea	$24(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	bne.b	L221
L220
	pea	2.w
	pea	$26(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#2,d0
	beq.b	L222
L221
;		return ERR_FILE_WRITE;
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/a2/a3
	rts
L222
;	sint32 r=0
;	sint32 r=0, eSize = 1;
	moveq	#1,d2
;	if (shared.bits < 9)
	move.b	$27(a3),d0
	cmp.b	#$9,d0
	bhs.b	L224
L223
;		r = f.Write8(data, shared.samples*shared.chan);
	moveq	#0,d1
	move.b	$26(a3),d1
	move.l	$20(a3),d0
	mulu.l	d1,d0
	move.l	d0,-(a7)
	move.l	a3,a1
	move.l	$28(a1),-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	bra.b	L227
L224
;	else if (shared.bits < 17)
	move.b	$27(a3),d0
	cmp.b	#$11,d0
	bhs.b	L226
L225
;		r = f.Write16(data, shared.samples*shared.chan);
	moveq	#0,d1
	move.b	$26(a3),d1
	move.l	$20(a3),d0
	mulu.l	d1,d0
	move.l	d0,-(a7)
	move.l	a3,a1
	move.l	$28(a1),-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
; eSize = sizeof(sint16);
	moveq	#2,d2
	bra.b	L227
L226
;		r = f.Write32(data, shared.samples*shared.chan);
	moveq	#0,d1
	move.b	$26(a3),d1
	move.l	$20(a3),d0
	mulu.l	d1,d0
	move.l	d0,-(a7)
	move.l	a3,a1
	move.l	$28(a1),-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
; eSize = sizeof(sint32);
	moveq	#4,d2
L227
;	if (r<0)
	tst.l	d0
	bpl.b	L229
L228
;		return r;
	movem.l	(a7)+,d2/a2/a3
	rts
L229
;	return sizeof(shared)+(r*eSize);
	muls.l	d2,d0
	addq.l	#$8,d0
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "ReadBody__xPCM__TR05XSFIO:0",CODE


;sint32	xPCM::ReadBody(XSFIO& f)
	XDEF	ReadBody__xPCM__TR05XSFIO
ReadBody__xPCM__TR05XSFIO
L244	EQU	-$8
	link	a5,#L244
	movem.l	d2/a2/a3,-(a7)
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L230
;		SHARED temp;
	lea	-$8(a5),a0
	clr.l	(a0)
	clr.w	4(a0)
	clr.b	6(a0)
	clr.b	7(a0)
;		if ( (f.Read32(&(temp.samples),1)!=1) || (f.Read16(&(temp.freq),
	pea	1.w
	pea	-$8(a5)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	bne.b	L233
L231
	pea	1.w
	lea	-$8(a5),a0
	pea	4(a0)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$84(a0),d0
	move.l	d0,-(a7)
	move.l	$80(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	bne.b	L233
L232
	pea	2.w
	lea	-$8(a5),a0
	pea	6(a0)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$8C(a0),d0
	move.l	d0,-(a7)
	move.l	$88(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#2,d0
	beq.b	L234
L233
;			return ERR_FILE_READ;
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L234
;		if (New(temp.samples, temp.chan, temp.bits, temp.freq)!=OK)
	moveq	#0,d0
	move.w	-4(a5),d0
	move.l	d0,-(a7)
	moveq	#0,d0
	move.b	-1(a5),d0
	move.l	d0,-(a7)
	moveq	#0,d0
	move.b	-2(a5),d0
	move.l	d0,-(a7)
	move.l	-$8(a5),-(a7)
	move.l	a3,-(a7)
	jsr	New__xPCM__TUjjjj
	add.w	#$14,a7
	tst.l	d0
	beq.b	L236
L235
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L236
;	sint32 r=0
;	sint32 r=0, eSize = 1;
	moveq	#1,d2
;	if (shared.bits < 9)
	move.b	$27(a3),d0
	cmp.b	#$9,d0
	bhs.b	L238
L237
;		r = f.Read8(data, shared.samples*shared.chan);
	moveq	#0,d1
	move.b	$26(a3),d1
	move.l	$20(a3),d0
	mulu.l	d1,d0
	move.l	d0,-(a7)
	move.l	a3,a1
	move.l	$28(a1),-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$8C(a0),d0
	move.l	d0,-(a7)
	move.l	$88(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	bra.b	L241
L238
;	else if (shared.bits < 17)
	move.b	$27(a3),d0
	cmp.b	#$11,d0
	bhs.b	L240
L239
;		r = f.Read16(data, shared.samples*shared.chan);
	moveq	#0,d1
	move.b	$26(a3),d1
	move.l	$20(a3),d0
	mulu.l	d1,d0
	move.l	d0,-(a7)
	move.l	a3,a1
	move.l	$28(a1),-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$84(a0),d0
	move.l	d0,-(a7)
	move.l	$80(a0),a0
	jsr	(a0)
	add.w	#$C,a7
; eSize = sizeof(sint16);
	moveq	#2,d2
	bra.b	L241
L240
;		r = f.Read32(data, shared.samples*shared.chan);
	moveq	#0,d1
	move.b	$26(a3),d1
	move.l	$20(a3),d0
	mulu.l	d1,d0
	move.l	d0,-(a7)
	move.l	a3,a1
	move.l	$28(a1),-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
; eSize = sizeof(sint32);
	moveq	#4,d2
L241
;	if (r<0)
	tst.l	d0
	bpl.b	L243
L242
;		return r;
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L243
;	return sizeof(shared)+(r*eSize);
	muls.l	d2,d0
	addq.l	#$8,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts

	SECTION "DeBias__xPCM__T:0",CODE


;sint32 xPCM::DeBias()
	XDEF	DeBias__xPCM__T
DeBias__xPCM__T
L309	EQU	-$3C
	link	a5,#L309
	movem.l	d2-d4/a2/a3,-(a7)
	move.l	$8(a5),a1
L245
;	if (!data)
	tst.l	$28(a1)
	bne.b	L247
L246
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L247
;	sint32 bias[XPCM_MAXCHANS] = {0};
	lea	-$20(a5),a0
	clr.l	(a0)+
	moveq	#6,d0
L310
	clr.l	(a0)+
	dbra	d0,L310
;	if (shared.bits < 9)
	move.b	$27(a1),d0
	cmp.b	#$9,d0
	bhs	L270
L248
;		rsint8* p = (sint8*)data;
	move.l	$28(a1),a0
;		for (ruint32 s=0;
	moveq	#0,d4
	bra.b	L253
L249
;			rsint32 c=shared.chan;
	moveq	#0,d1
	move.b	$26(a1),d1
; rsint32* b=bias;
	lea	-$20(a5),a2
;			while(c--)
	bra.b	L251
L250
;				*b++ += (sint32)(*p++);
	move.b	(a0)+,d2
	extb.l	d2
	move.l	a2,a3
	addq.w	#4,a2
	add.l	d2,(a3)
L251
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L250
L252
	addq.l	#1,d4
L253
	cmp.l	$20(a1),d4
	blo.b	L249
L254
;		for (s=0;
	moveq	#0,d4
	bra.b	L256
L255
;			bias[s] = (-bias[s])/shared.samples;
	lea	-$20(a5),a0
	move.l	0(a0,d4.l*4),d0
	neg.l	d0
	divul.l	$20(a1),d0
	lea	-$20(a5),a0
	move.l	d0,0(a0,d4.l*4)
	addq.l	#1,d4
L256
	moveq	#0,d0
	move.b	$26(a1),d0
	cmp.l	d0,d4
	blo.b	L255
L257
;		p = (sint8*)data;
	move.l	$28(a1),a0
;		for (s=0;
	moveq	#0,d4
	bra.b	L268
L258
;			rsint32 c=shared.chan;
	moveq	#0,d1
	move.b	$26(a1),d1
; rsint32* b=bias;
	lea	-$20(a5),a2
;			while(c--)
	bra.b	L266
L259
;				rsint32 v = (*p)+(*b++);
	move.b	(a0),d0
	extb.l	d0
	add.l	(a2)+,d0
;				*p++ = Clamp(v, -127, 127);
	moveq	#$7F,d3
	moveq	#-$7F,d2
	cmp.l	d2,d0
	bge.b	L261
L260
	move.l	d2,d0
	bra.b	L265
L261
	cmp.l	d3,d0
	ble.b	L263
L262
	move.l	d3,d0
L263
L264
L265
	move.b	d0,(a0)+
L266
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L259
L267
	addq.l	#1,d4
L268
	cmp.l	$20(a1),d4
	blo.b	L258
L269
	bra	L308
L270
;	else if (shared.bits < 17)
	move.b	$27(a1),d0
	cmp.b	#$11,d0
	bhs	L293
L271
;		rsint16* p = (sint16*)data;
	move.l	$28(a1),a0
;		for (ruint32 s=0;
	moveq	#0,d4
	bra.b	L276
L272
;			rsint32 c=shared.chan;
	moveq	#0,d1
	move.b	$26(a1),d1
; rsint32* b=bias;
	lea	-$20(a5),a2
;			while(c--)
	bra.b	L274
L273
;				*b++ += (sint32)(*p++);
	move.w	(a0)+,d2
	ext.l	d2
	move.l	a2,a3
	addq.w	#4,a2
	add.l	d2,(a3)
L274
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L273
L275
	addq.l	#1,d4
L276
	cmp.l	$20(a1),d4
	blo.b	L272
L277
;		for (s=0;
	moveq	#0,d4
	bra.b	L279
L278
;			bias[s] = (-bias[s])/shared.samples;
	lea	-$20(a5),a0
	move.l	0(a0,d4.l*4),d0
	neg.l	d0
	divul.l	$20(a1),d0
	lea	-$20(a5),a0
	move.l	d0,0(a0,d4.l*4)
	addq.l	#1,d4
L279
	moveq	#0,d0
	move.b	$26(a1),d0
	cmp.l	d0,d4
	blo.b	L278
L280
;		p = (sint16*)data;
	move.l	$28(a1),a0
;		for (s=0;
	moveq	#0,d4
	bra.b	L291
L281
;			rsint32 c=shared.chan;
	moveq	#0,d1
	move.b	$26(a1),d1
; rsint32* b=bias;
	lea	-$20(a5),a2
;			while(c--)
	bra.b	L289
L282
;				rsint32 v = (*p)+(*b++);
	move.w	(a0),d0
	ext.l	d0
	add.l	(a2)+,d0
;				*p++ = Clamp(v, -65535, 65535);
	move.l	#$FFFF,d3
	move.l	#-$FFFF,d2
	cmp.l	d2,d0
	bge.b	L284
L283
	move.l	d2,d0
	bra.b	L288
L284
	cmp.l	d3,d0
	ble.b	L286
L285
	move.l	d3,d0
L286
L287
L288
	move.w	d0,(a0)+
L289
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L282
L290
	addq.l	#1,d4
L291
	cmp.l	$20(a1),d4
	blo.b	L281
L292
	bra	L308
L293
;		rsint32* p = (sint32*)data;
	move.l	$28(a1),a0
;		for (ruint32 s=0;
	moveq	#0,d2
	bra.b	L298
L294
;			rsint32 c=shared.chan;
	moveq	#0,d1
	move.b	$26(a1),d1
; rsint32* b=bias;
	lea	-$20(a5),a2
;			while(c--)
	bra.b	L296
L295
;				*b++ += *p++;
	move.l	a2,a3
	addq.w	#4,a2
	move.l	(a0)+,d0
	add.l	d0,(a3)
L296
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L295
L297
	addq.l	#1,d2
L298
	cmp.l	$20(a1),d2
	blo.b	L294
L299
;		for (s=0;
	moveq	#0,d2
	bra.b	L301
L300
;			bias[s] = (-bias[s])/shared.samples;
	lea	-$20(a5),a0
	move.l	0(a0,d2.l*4),d0
	neg.l	d0
	divul.l	$20(a1),d0
	lea	-$20(a5),a0
	move.l	d0,0(a0,d2.l*4)
	addq.l	#1,d2
L301
	moveq	#0,d0
	move.b	$26(a1),d0
	cmp.l	d0,d2
	blo.b	L300
L302
;		p = (sint32*)data;
	move.l	$28(a1),a0
;		for (s=0;
	moveq	#0,d2
	bra.b	L307
L303
;			rsint32 c=shared.chan;
	moveq	#0,d1
	move.b	$26(a1),d1
; rsint32* b=bias;
	lea	-$20(a5),a2
;			while(c--)
	bra.b	L305
L304
;				rsint32 v = (*p)+(*b++);
	move.l	(a0),d0
	add.l	(a2)+,d0
;				*p++ = v;
	move.l	d0,(a0)+
L305
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L304
L306
	addq.l	#1,d2
L307
	cmp.l	$20(a1),d2
	blo.b	L303
L308
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts

	SECTION "Normalize__xPCM__Tf:0",CODE


;sint32 xPCM::Normalize(float32 level)
	XDEF	Normalize__xPCM__Tf
Normalize__xPCM__Tf
	move.l	4(a7),a0
L311
;	if (!data)
	tst.l	$28(a0)
	bne.b	L313
L312
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	rts
L313
;	return OK;
	moveq	#0,d0
	rts

	END
