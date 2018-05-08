
; Storm C Compiler
; extropialib:lib/Common/xUtility/Pool.cpp
	mc68030
	mc68881
	XREF	Copy__MEM__r8Pvr9Pvr0Ui
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__UisE
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

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_0ct__POOL_LT__TUjUj:0",CODE


;POOL_LT::POOL_LT(uint32 entries, uint32 typeSize) 
	XDEF	_0ct__POOL_LT__TUjUj
_0ct__POOL_LT__TUjUj
	move.l	d2,-(a7)
	movem.l	$C(a7),d0/d1
	move.l	$8(a7),a0
L133
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
	clr.l	$20(a0)
;	Create(entries, typeSize);
	move.l	d1,-(a7)
	move.l	d0,-(a7)
	move.l	a0,-(a7)
	jsr	Create__POOL_LT__TUjUj
	add.w	#$C,a7
	move.l	(a7)+,d2
	rts

	SECTION "_0dt__POOL_LT__T:0",CODE


;POOL_LT::~POOL_LT()
	XDEF	_0dt__POOL_LT__T
_0dt__POOL_LT__T
	move.l	4(a7),a0
L134
;	Delete(true);
	clr.w	-(a7)
	move.w	#1,-(a7)
	move.l	a0,-(a7)
	jsr	Delete__POOL_LT__Tss
	addq.w	#$8,a7
	rts

	SECTION "ExamineBlock__POOL_LT__TUj:0",CODE


;uint32 POOL_LT::ExamineBlock(uint32 location)
	XDEF	ExamineBlock__POOL_LT__TUj
ExamineBlock__POOL_LT__TUj
	movem.l	d2/d3,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),a0
L135
;	sint32 i = location
	move.l	d0,d1
;	sint32 i = location, endOfBlock = 0
	moveq	#0,d2
;	sint32 i = location, endOfBlo
	moveq	#1,d0
;	while (i < size && !endOfBlock)
	bra.b	L140
L136
;		i++;
	addq.l	#1,d1
;		if (lengthTable[i] || allocTable[i]) // end of this block marked
	move.l	$20(a0),a1
	tst.l	0(a1,d1.l*4)
	bne.b	L138
L137
	move.l	$18(a0),a1
	tst.l	0(a1,d1.l*4)
	beq.b	L139
L138
;			endOfBlock = length;
	move.l	d0,d2
	bra.b	L140
L139
;			length++;
	addq.l	#1,d0
L140
	cmp.l	4(a0),d1
	bhs.b	L142
L141
	tst.l	d2
	beq.b	L136
L142
;	return length;
	movem.l	(a7)+,d2/d3
	rts

	SECTION "TestConsistency__POOL_LT__Ts:0",CODE


;sint32 POOL_LT::TestConsistency(bool strict)
	XDEF	TestConsistency__POOL_LT__Ts
TestConsistency__POOL_LT__Ts
	movem.l	d2-d5/a2,-(a7)
	move.l	$18(a7),a2
L143
;	sint32 mismatches = 0
	moveq	#0,d5
;	sint32 mismatches = 0, i = 0
	moveq	#0,d2
;	sint32 mismatches = 0, i = 0, blockE
	moveq	#0,d4
;		sint32 lastPos = 0;
	moveq	#0,d3
;		while (i < size)
	bra.b	L152
L144
;			uint32 sizeBuff = lengthTable[i];
	move.l	$20(a2),a0
	move.l	0(a0,d2.l*4),d0
;			if (!sizeBuff)
	bne.b	L146
L145
;				blockErrs++;
	addq.l	#1,d4
;				sizeBuff = ExamineBlock(lastPos);
	move.l	d3,-(a7)
	move.l	a2,-(a7)
	jsr	ExamineBlock__POOL_LT__TUj
	addq.w	#$8,a7
;				lengthTable[lastPos] = sizeBuff;
	move.l	$20(a2),a0
	move.l	d0,0(a0,d3.l*4)
;				i = lastPos + sizeBuff;
	move.l	d3,d2
	add.l	d0,d2
L146
;			if (allocTable[i] && (*(allocTable[i]) != &pool[i*tSize]))
	move.l	$18(a2),a0
	tst.l	0(a0,d2.l*4)
	beq.b	L149
L147
	move.l	$18(a2),a0
	move.l	0(a0,d2.l*4),a0
	move.l	(a0),a1
	move.l	$C(a2),d1
	mulu.l	d2,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	cmp.l	a0,a1
	beq.b	L149
L148
;				mismatches++;
	addq.l	#1,d5
L149
;			if (i + sizeBuff > size)
	move.l	d2,d3
	add.l	d0,d3
	cmp.l	4(a2),d3
	bls.b	L151
L150
;				blockErrs++;
	addq.l	#1,d4
;				sizeBuff = ExamineBlock(i);
	move.l	d2,-(a7)
	move.l	a2,-(a7)
	jsr	ExamineBlock__POOL_LT__TUj
	addq.w	#$8,a7
;				lengthTable[i] = sizeBuff;
	move.l	$20(a2),a0
	move.l	d0,0(a0,d2.l*4)
L151
;			lastPos = i;
	move.l	d2,d3
;			i += sizeBuff;
	add.l	d0,d2
L152
	cmp.l	4(a2),d2
	blo.b	L144
L153
;	return mismatches;
	move.l	d5,d0
	movem.l	(a7)+,d2-d5/a2
	rts

	SECTION "Create__POOL_LT__TUjUj:0",CODE


;sint32 POOL_LT::Create(uint32 s, uint32 t)
	XDEF	Create__POOL_LT__TUjUj
Create__POOL_LT__TUjUj
	movem.l	d2/d3/a2,-(a7)
	move.l	$18(a7),d1
	move.l	$14(a7),d2
	move.l	$10(a7),a2
L154
;	if (pool)
	tst.l	$1C(a2)
	beq.b	L156
L155
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L156
;	tSize = t/2 + (t & 1);
	move.l	d1,d0
	moveq	#1,d3
	lsr.l	d3,d0
	and.l	#1,d1
	add.l	d1,d0
	move.l	d0,$C(a2)
;	rawSize = tSize*s;
	move.l	$C(a2),d0
	mulu.l	d2,d0
	move.l	d0,$8(a2)
;	uint32 allocationSize = s + s + (rawSize/2) + (rawSize & 1);
	move.l	d2,d0
	add.l	d2,d0
	move.l	$8(a2),d1
	moveq	#1,d3
	lsr.l	d3,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	and.l	#1,d1
	add.l	d1,d0
;	data = (uint32*)MEM::Alloc(allocationSize*sizeof(uint32), true);
	clr.l	-(a7)
	move.w	#1,-(a7)
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,(a2)
;	if (!data)
	tst.l	(a2)
	bne.b	L158
L157
;		Init();
	move.l	a2,a0
	clr.l	$20(a0)
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L158
;	allocTable = (uint16***)&data[0];
	move.l	(a2),a0
	move.l	a0,$18(a2)
;	lengthTable  = (uint32*)&data[s];
	move.l	(a2),a0
	lea	0(a0,d2.l*4),a0
	move.l	a0,$20(a2)
;	pool			 = (uint16*)&data[2*s];
	move.l	d2,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	(a2),a0
	lea	0(a0,d0.l*4),a0
	move.l	a0,$1C(a2)
;	size          = s;
	move.l	d2,4(a2)
;	totalFree			= size;
	move.l	4(a2),d0
	move.l	d0,$14(a2)
;	nextFree			= 0;
	clr.l	$10(a2)
;	lengthTable[0]  = size;
	move.l	$20(a2),a0
	move.l	4(a2),(a0)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "Delete__POOL_LT__Tss:0",CODE


;sint32 POOL_LT::Delete(bool force, bool update)
	XDEF	Delete__POOL_LT__Tss
Delete__POOL_LT__Tss
	movem.l	d2-d4/a2/a3,-(a7)
	move.w	$1E(a7),d2
	move.w	$1C(a7),d3
	move.l	$18(a7),a2
L159
;	sint32 inUse =  size - totalFree;
	move.l	4(a2),d0
	sub.l	$14(a2),d0
;	if (!force)
	tst.w	d3
	bne.b	L163
L160
;		if (inUse)
	tst.l	d0
	beq.b	L162
L161
;			return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L162
	bra.b	L174
L163
;		if (data && inUse && update)
	tst.l	(a2)
	beq.b	L174
L164
	tst.l	d0
	beq.b	L174
L165
	tst.w	d2
	beq.b	L174
L166
;			sint32 p = 0;
	moveq	#0,d3
;			for (sint32 i=0;
	moveq	#0,d0
	bra.b	L173
L167
;				if (IsInPool(*(allocTable[i])))
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	move.l	(a0),a1
	move.l	a2,a0
	moveq	#0,d2
	cmp.l	$1C(a0),a1
	blo.b	L170
L168
	move.l	$8(a0),d1
	subq.l	#1,d1
	move.l	$1C(a0),a3
	lea	0(a3,d1.l*2),a0
	cmp.l	a0,a1
	bhs.b	L170
L169
	moveq	#1,d2
L170
	tst.l	d2
	beq.b	L172
L171
;					*(allocTable[i]) = 0;
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	clr.l	(a0)
L172
;				p++;
	addq.l	#1,d3
	addq.l	#1,d0
L173
	cmp.l	4(a2),d0
	blo.b	L167
L174
;	if (data)
	tst.l	(a2)
	beq.b	L176
L175
;		MEM::Free(data);
	move.l	(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		Init();
	move.l	a2,a0
	clr.l	$20(a0)
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
L176
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts

	SECTION "Resize__POOL_LT__Tj:0",CODE


;sint32 POOL_LT::Resize(sint32 s)
	XDEF	Resize__POOL_LT__Tj
Resize__POOL_LT__Tj
L191	EQU	-$24
	link	a5,#L191
	movem.l	d2-d6/a2/a3/a6,-(a7)
	move.l	$C(a5),d4
	move.l	$8(a5),a2
L177
;	if (size == s)
	move.l	4(a2),d0
	cmp.l	d4,d0
	bne.b	L179
L178
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L179
;	if (s > (size - totalFree))
	move.l	4(a2),d0
	sub.l	$14(a2),d0
	cmp.l	d0,d4
	bls	L190
L180
;		if (TestConsistency())
	clr.w	-(a7)
	move.l	a2,-(a7)
	jsr	TestConsistency__POOL_LT__Ts
	addq.w	#6,a7
	tst.l	d0
	beq.b	L182
L181
;			return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L182
;		uint32 newRawSize = s*tSize;
	move.l	d4,d5
	mulu.l	$C(a2),d5
;		uint32 allocationSize = s + s + (newRawSize/2) + (newRawSize & 1)
	move.l	d4,d0
	add.l	d4,d0
	move.l	d5,d1
	moveq	#1,d2
	lsr.l	d2,d1
	add.l	d1,d0
	move.l	d5,d1
	and.l	#1,d1
	add.l	d1,d0
;		uint32* newData = (uint32*)MEM::Alloc(allocationSize*sizeof(uint
	clr.l	-(a7)
	move.w	#1,-(a7)
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,-$C(a5)
;		if (!newData)
	tst.l	-$C(a5)
	bne.b	L184
L183
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L184
;		uint16***	newAllocTable = (uint16***)&newData[0];
	move.l	-$C(a5),-$10(a5)
;		uint32*		newASizeData  = (uint32*)&newData[s];
	move.l	d4,d0
	asl.l	#2,d0
	add.l	-$C(a5),d0
	move.l	d0,-$14(a5)
;		uint16*		newPool				= (uint16*)&newData[2*s];
	move.l	d4,d0
	moveq	#1,d1
	asl.l	d1,d0
	asl.l	#2,d0
	add.l	-$C(a5),d0
	move.l	d0,a6
;		rsint32 i = 0
	moveq	#0,d2
;		rsint32 i = 0, j = 0;
	moveq	#0,d3
;		while (i <size)
	bra.b	L188
L185
;			if (allocTable[i])
	move.l	$18(a2),a0
	tst.l	0(a0,d2.l*4)
	beq.b	L187
L186
;				newAllocTable[j]	= allocTable[i];
	move.l	$18(a2),a0
	move.l	0(a0,d2.l*4),a1
	move.l	-$10(a5),a3
	move.l	a1,0(a3,d3.l*4)
;				newASizeData[j]		= lengthTable[i];
	move.l	$20(a2),a0
	move.l	0(a0,d2.l*4),d0
	move.l	-$14(a5),a1
	move.l	d0,0(a1,d3.l*4)
;				MEM::Copy(&newPool[j*tSize], &pool[i*tSize], lengthTabl
	move.l	$20(a2),a0
	move.l	0(a0,d2.l*4),d0
	mulu.l	$C(a2),d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$C(a2),d1
	mulu.l	d2,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	$C(a2),d1
	mulu.l	d3,d1
	lea	0(a6,d1.l*2),a0
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
;				j += lengthTable[i];
	move.l	$20(a2),a0
	add.l	0(a0,d2.l*4),d3
L187
;			i += lengthTable[i];
	move.l	$20(a2),a0
	move.l	d2,d0
	add.l	0(a0,d2.l*4),d0
	move.l	d0,d2
L188
	cmp.l	4(a2),d2
	blo.b	L185
L189
;		MEM::Free(data);
	move.l	(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		data				= newData;
	move.l	-$C(a5),(a2)
;		lengthTable		= newASizeData;
	move.l	-$14(a5),$20(a2)
;		pool				= newPool;
	move.l	a6,$1C(a2)
;		allocTable	= newAllocTable;
	move.l	-$10(a5),$18(a2)
;		totalFree += (s - size);
	move.l	d4,d1
	sub.l	4(a2),d1
	add.l	d1,$14(a2)
;		size			= s;
	move.l	d4,4(a2)
;		rawSize		= newRawSize;
	move.l	d5,$8(a2)
;		nextFree	= size - totalFree;
	move.l	4(a2),d0
	sub.l	$14(a2),d0
	move.l	d0,$10(a2)
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L190
;	return ERR_RESIZE_TO_SMALL;
	move.l	#-$3800005,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "Defrag__POOL_LT__T:0",CODE


;sint32 POOL_LT::Defrag()
	XDEF	Defrag__POOL_LT__T
Defrag__POOL_LT__T
	movem.l	d2-d7/a2,-(a7)
	move.l	$20(a7),a2
L192
;	if (TestConsistency())
	clr.w	-(a7)
	move.l	a2,-(a7)
	jsr	TestConsistency__POOL_LT__Ts
	addq.w	#6,a7
	tst.l	d0
	beq.b	L194
L193
;		return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d7/a2
	rts
L194
;	sint32 c = nextFree;
	move.l	$10(a2),d7
;	sint32 s = c+lengthTable[c];
	move.l	d7,d0
	move.l	$20(a2),a0
	move.l	d7,d4
	add.l	0(a0,d0.l*4),d4
;	while (s < size)
	bra	L205
L195
;		rsint32 sizeBuff = lengthTable[s];
	move.l	$20(a2),a0
	move.l	0(a0,d4.l*4),d5
;		if (allocTable[s])
	move.l	$18(a2),a0
	tst.l	0(a0,d4.l*4)
	beq	L204
L196
;			lengthTable[c]  = sizeBuff;
	move.l	d7,d0
	move.l	$20(a2),a0
	move.l	d5,0(a0,d0.l*4)
;			allocTable[c] = allocTable[s];
	move.l	$18(a2),a0
	move.l	0(a0,d4.l*4),a1
	move.l	d7,d0
	move.l	$18(a2),a0
	move.l	a1,0(a0,d0.l*4)
;			lengthTable[s]  = 0;
	move.l	$20(a2),a0
	clr.l	0(a0,d4.l*4)
;			allocTable[s] = 0;
	move.l	$18(a2),a0
	clr.l	0(a0,d4.l*4)
;			*(allocTable[c]) = &pool[c*tSize];
	move.l	$C(a2),d0
	mulu.l	d7,d0
	move.l	$1C(a2),a0
	lea	0(a0,d0.l*2),a1
	move.l	d7,d0
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	move.l	a1,(a0)
;			if (s-c > sizeBuff)
	move.l	d4,d0
	sub.l	d7,d0
	cmp.l	d5,d0
	ble.b	L198
L197
;				MEM::Copy(&pool[c*tSize], &pool[s*tSize], sizeBuff*tSiz
	move.l	$C(a2),d0
	mulu.l	d5,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$C(a2),d1
	mulu.l	d4,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	$C(a2),d1
	mulu.l	d7,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
	bra	L203
L198
;				register sint32 t = 0
	moveq	#0,d2
;				register sint32 t = 0, max = s-c;
	move.l	d4,d3
	sub.l	d7,d3
;				while (t < sizeBuff)
	bra	L202
L199
;					MEM::Copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], max
	move.l	$C(a2),d0
	mulu.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d4,d1
	add.l	d2,d1
	mulu.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	d7,d1
	add.l	d2,d1
	mulu.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
;					if (t + max > sizeBuff)
	move.l	d2,d0
	add.l	d3,d0
	cmp.l	d5,d0
	ble.b	L201
L200
;						max = sizeBuff-t;
	move.l	d5,d3
	sub.l	d2,d3
;						t += max;
	add.l	d3,d2
;						MEM::Copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], m
	move.l	$C(a2),d0
	mulu.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d4,d1
	add.l	d2,d1
	mulu.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	d7,d1
	add.l	d2,d1
	mulu.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
L201
;					t += max;
	add.l	d3,d2
L202
	cmp.l	d5,d2
	blt	L199
L203
;			c += sizeBuff;
	move.l	d7,d0
	add.l	d5,d0
	move.l	d0,d7
L204
;		s += sizeBuff;
	add.l	d5,d4
L205
	cmp.l	4(a2),d4
	blo	L195
L206
;	nextFree = c;
	move.l	d7,$10(a2)
;	lengthTable[nextFree] = totalFree;
	move.l	$10(a2),d0
	move.l	$20(a2),a0
	move.l	$14(a2),0(a0,d0.l*4)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "NewT__POOL_LT__TPv:0",CODE


;sint32 POOL_LT::NewT(void* vt)
	XDEF	NewT__POOL_LT__TPv
NewT__POOL_LT__TPv
	movem.l	d2/a2,-(a7)
	movem.l	$C(a7),a0/a1
L207
;	ruint16** t = (uint16**)vt;
;	if (*(t) != 0)
	move.l	(a1),a2
	cmp.w	#0,a2
	beq.b	L209
L208
;		return ERR_PTR_USED;
	move.l	#-$3020003,d0
	movem.l	(a7)+,d2/a2
	rts
L209
;	if (totalFree)
	tst.l	$14(a0)
	beq	L219
L210
;		uint32 sizeBuff = lengthTable[nextFree];
	move.l	$10(a0),d0
	move.l	$20(a0),a2
	move.l	0(a2,d0.l*4),d1
;		allocTable[nextFree] = t;
	move.l	$10(a0),d0
	move.l	$18(a0),a2
	move.l	a1,0(a2,d0.l*4)
;		lengthTable[nextFree] = 1;
	move.l	$10(a0),d0
	move.l	$20(a0),a2
	move.l	#1,0(a2,d0.l*4)
;		*(t) = &pool[nextFree*tSize];
	move.l	$10(a0),d0
	mulu.l	$C(a0),d0
	move.l	$1C(a0),a2
	lea	0(a2,d0.l*2),a2
	move.l	a2,(a1)
;		totalFree--;
	subq.l	#1,$14(a0)
;		if (totalFree)
	tst.l	$14(a0)
	beq.b	L218
L211
;			if (--sizeBuff) // sizeBuff > 1 == --sizeBuff > 0
	subq.l	#1,d1
	tst.l	d1
	beq.b	L213
L212
;				lengthTable[++nextFree] = sizeBuff;
	move.l	$20(a0),a1
	move.l	$10(a0),d0
	addq.l	#1,d0
	move.l	d0,$10(a0)
	move.l	d1,0(a1,d0.l*4)
;				return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L213
;			rsint32 i = nextFree+1;
	move.l	$10(a0),d0
	addq.l	#1,d0
;			while ((i < size) && allocTable[i]) // i < size just a precaut
	bra.b	L215
L214
;				i += lengthTable[i];
	move.l	$20(a0),a1
	move.l	d0,d1
	add.l	0(a1,d0.l*4),d1
	move.l	d1,d0
L215
	cmp.l	4(a0),d0
	bhs.b	L217
L216
	move.l	$18(a0),a1
	tst.l	0(a1,d0.l*4)
	bne.b	L214
L217
;			nextFree = i;
	move.l	d0,$10(a0)
;			return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L218
;		nextFree = -1;
	move.l	#-1,$10(a0)
;		return WRN_RSC_EXHAUSTED;
	move.l	#-$2050006,d0
	movem.l	(a7)+,d2/a2
	rts
L219
;	return ERR_RSC_EXHAUSTED;
	move.l	#-$3050006,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "NewT__POOL_LT__TPvj:0",CODE


;sint32 POOL_LT::NewT(void* vt, sint32 s)
	XDEF	NewT__POOL_LT__TPvj
NewT__POOL_LT__TPvj
	movem.l	d2-d4/a2,-(a7)
	move.l	$1C(a7),d2
	move.l	$14(a7),a0
	move.l	$18(a7),a1
L220
;	ruint16** t = (uint16**)vt;
	move.l	a1,a2
;	if (*(t) != 0) // already in use, possibly external
	move.l	(a2),a1
	cmp.w	#0,a1
	beq.b	L222
L221
;		return ERR_PTR_USED;
	move.l	#-$3020003,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L222
;	if (totalFree < s)
	move.l	$14(a0),d0
	cmp.l	d2,d0
	bge.b	L224
L223
;		return ERR_NEW_ALLOC_TO_BIG;
	move.l	#-$3800006,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L224
;	rsint32 i = nextFree
	move.l	$10(a0),d0
;	rsint32 i = nextFree, found = -1;
	moveq	#-1,d1
;	while ((i < size) && (found < 0))
	bra.b	L229
L225
;		if (allocTable[i] == 0 && lengthTable[i] >= s)
	move.l	$18(a0),a1
	move.l	0(a1,d0.l*4),a1
	cmp.w	#0,a1
	bne.b	L228
L226
	move.l	$20(a0),a1
	move.l	0(a1,d0.l*4),d3
	cmp.l	d2,d3
	blo.b	L228
L227
;			found = i;
	move.l	d0,d1
	bra.b	L229
L228
;			i += lengthTable[i];
	move.l	$20(a0),a1
	move.l	d0,d3
	add.l	0(a1,d0.l*4),d3
	move.l	d3,d0
L229
	cmp.l	4(a0),d0
	bhs.b	L231
L230
	tst.l	d1
	bmi.b	L225
L231
;	if (found < 0)
	tst.l	d1
	bpl.b	L234
L232
;		if (Defrag());
	move.l	a0,-(a7)
	jsr	Defrag__POOL_LT__T
	addq.w	#4,a7
L233
;			return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L234
;	uint32 sizeBuff = lengthTable[found];
	move.l	$20(a0),a1
	move.l	0(a1,d1.l*4),d0
;	if (s < sizeBuff)
	cmp.l	d0,d2
	bhs.b	L236
L235
;		lengthTable[found] = s;
	move.l	$20(a0),a1
	move.l	d2,0(a1,d1.l*4)
;		lengthTable[found+s] = sizeBuff - s;
	sub.l	d2,d0
	move.l	d1,d3
	add.l	d2,d3
	move.l	$20(a0),a1
	move.l	d0,0(a1,d3.l*4)
L236
;	allocTable[found] = t;
	move.l	$18(a0),a1
	move.l	a2,0(a1,d1.l*4)
;	*(t) = &pool[found*tSize];
	move.l	$C(a0),d0
	mulu.l	d1,d0
	move.l	$1C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.l	a1,(a2)
;	totalFree -= s;
	sub.l	d2,$14(a0)
;	if (totalFree)
	tst.l	$14(a0)
	beq.b	L244
L237
;		if (nextFree == found)
	move.l	$10(a0),d0
	cmp.l	d1,d0
	bne.b	L243
L238
;			i = found+s;
	move.l	d1,d0
	add.l	d2,d0
;			while ((i < size) && allocTable[i])
	bra.b	L240
L239
;				i += lengthTable[i];
	move.l	$20(a0),a1
	move.l	d0,d1
	add.l	0(a1,d0.l*4),d1
	move.l	d1,d0
L240
	cmp.l	4(a0),d0
	bhs.b	L242
L241
	move.l	$18(a0),a1
	tst.l	0(a1,d0.l*4)
	bne.b	L239
L242
;			nextFree = i;
	move.l	d0,$10(a0)
L243
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L244
;	nextFree = -1;
	move.l	#-1,$10(a0)
;	return WRN_RSC_EXHAUSTED;
	move.l	#-$2050006,d0
	movem.l	(a7)+,d2-d4/a2
	rts

	SECTION "FreeT__POOL_LT__TPv:0",CODE


;sint32 POOL_LT::FreeT(void* vt)
	XDEF	FreeT__POOL_LT__TPv
FreeT__POOL_LT__TPv
	movem.l	d2-d5/a2-a4,-(a7)
	movem.l	$20(a7),a0/a1
L245
;	ruint16** t = (uint16**)vt;
;	if (*(t) == 0)
	move.l	(a1),a2
	cmp.w	#0,a2
	bne.b	L247
L246
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L247
;	if (!IsInPool(*(t)))
	move.l	(a1),a3
	move.l	a0,a2
	moveq	#0,d1
	cmp.l	$1C(a2),a3
	blo.b	L250
L248
	move.l	$8(a2),d0
	subq.l	#1,d0
	move.l	$1C(a2),a4
	lea	0(a4,d0.l*2),a2
	cmp.l	a2,a3
	bhs.b	L250
L249
	moveq	#1,d1
L250
	tst.l	d1
	bne.b	L252
L251
;		return ERR_PTR_RANGE;
	move.l	#-$3020004,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L252
;	rsint32 found = -1;
;		ruint32 p = (uint32)(*(t) - pool);
	move.l	(a1),d0
	sub.l	$1C(a0),d0
	moveq	#1,d1
	asr.l	d1,d0
;		found = p/tSize;
	move.l	d0,d2
	divul.l	$C(a0),d2
;		if (!allocTable[found])
	move.l	$18(a0),a2
	tst.l	0(a2,d2.l*4)
	bne.b	L254
L253
;			return ERR_PTR_INCONSISTENT;
	move.l	#-$3020005,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L254
;	sint32 result = OK;
	moveq	#0,d0
;	*(t) = 0;
	clr.l	(a1)
;	allocTable[found] = 0;
	move.l	$18(a0),a1
	clr.l	0(a1,d2.l*4)
;	ruint32 sizeBuff = lengthTable[found];
	move.l	$20(a0),a1
	move.l	0(a1,d2.l*4),d5
;	totalFree += sizeBuff;
	add.l	d5,$14(a0)
;	if (found + sizeBuff < size)	// first make sure were not already a
	move.l	d2,d3
	add.l	d5,d3
	cmp.l	4(a0),d3
	bhs.b	L257
L255
;		uint32 next = found + sizeBuff;
	move.l	d2,d1
	add.l	d5,d1
;		if (allocTable[next] == 0)
	move.l	$18(a0),a1
	move.l	0(a1,d1.l*4),a1
	cmp.w	#0,a1
	bne.b	L257
L256
;			sizeBuff += lengthTable[next];
	move.l	$20(a0),a1
	add.l	0(a1,d1.l*4),d5
;			lengthTable[next] = 0;
	move.l	$20(a0),a1
	clr.l	0(a1,d1.l*4)
;			lengthTable[found] = sizeBuff;
	move.l	$20(a0),a1
	move.l	d5,0(a1,d2.l*4)
L257
;	if (found == 0 || found < nextFree || nextFree == -1)
	tst.l	d2
	beq.b	L260
L258
	cmp.l	$10(a0),d2
	blt.b	L260
L259
	move.l	$10(a0),d1
	cmp.l	#-1,d1
	bne.b	L261
L260
;		nextFree = found;
	move.l	d2,$10(a0)
;		return result;
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L261
;		rsint32 prev = -1;
	moveq	#-1,d3
;		rsint32 i = nextFree;
	move.l	$10(a0),d1
;		while (i < found)
	bra.b	L266
L262
;			if (allocTable[i]==0)
	move.l	$18(a0),a1
	move.l	0(a1,d1.l*4),a1
	cmp.w	#0,a1
	bne.b	L264
L263
;				prev = i;
	move.l	d1,d3
	bra.b	L265
L264
;				prev = -1;
	moveq	#-1,d3
L265
;			i += lengthTable[i];
	move.l	$20(a0),a1
	move.l	d1,d4
	add.l	0(a1,d1.l*4),d4
	move.l	d4,d1
L266
	cmp.l	d2,d1
	blt.b	L262
L267
;		if (prev >= 0)
	tst.l	d3
	bmi.b	L269
L268
;			lengthTable[prev] += sizeBuff;
	move.l	$20(a0),a1
	lea	0(a1,d3.l*4),a1
	add.l	d5,(a1)
;			lengthTable[found] = 0;
	move.l	$20(a0),a0
	clr.l	0(a0,d2.l*4)
L269
;	return result;
	movem.l	(a7)+,d2-d5/a2-a4
	rts

	SECTION "_0ct__POOL_ST__TUsUj:0",CODE


;POOL_ST::POOL_ST(uint16 entries, uint32 typeSize) 
	XDEF	_0ct__POOL_ST__TUsUj
_0ct__POOL_ST__TUsUj
	move.l	d2,-(a7)
	move.w	$C(a7),d0
	move.l	$E(a7),d1
	move.l	$8(a7),a0
L270
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
	clr.l	$20(a0)
;	Create(entries, typeSize);
	move.l	d1,-(a7)
	move.w	d0,-(a7)
	move.l	a0,-(a7)
	jsr	Create__POOL_ST__TUsUj
	add.w	#$A,a7
	move.l	(a7)+,d2
	rts

	SECTION "_0dt__POOL_ST__T:0",CODE


;POOL_ST::~POOL_ST()
	XDEF	_0dt__POOL_ST__T
_0dt__POOL_ST__T
	move.l	4(a7),a0
L271
;	Delete (true);
	clr.w	-(a7)
	move.w	#1,-(a7)
	move.l	a0,-(a7)
	jsr	Delete__POOL_ST__Tss
	addq.w	#$8,a7
	rts

	SECTION "ExamineBlock__POOL_ST__TUj:0",CODE


;uint32 POOL_ST::ExamineBlock(uint32 location)
	XDEF	ExamineBlock__POOL_ST__TUj
ExamineBlock__POOL_ST__TUj
	movem.l	d2/d3,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),a0
L272
;	uint32 i = location
	move.l	d0,d1
;	uint32 i = location, endOfBlock = 0
	moveq	#0,d2
;	uint32 i = location, endOfBlo
	moveq	#1,d0
;	while (i < size && !endOfBlock)
	bra.b	L277
L273
;		i++;
	addq.l	#1,d1
;		if (lengthTable[i] || allocTable[i])
	move.l	$20(a0),a1
	tst.w	0(a1,d1.l*2)
	bne.b	L275
L274
	move.l	$18(a0),a1
	tst.l	0(a1,d1.l*4)
	beq.b	L276
L275
;			endOfBlock = length;
	move.l	d0,d2
	bra.b	L277
L276
;			length++;
	addq.l	#1,d0
L277
	cmp.l	4(a0),d1
	bhs.b	L279
L278
	tst.l	d2
	beq.b	L273
L279
;	return length;
	movem.l	(a7)+,d2/d3
	rts

	SECTION "TestConsistency__POOL_ST__Ts:0",CODE


;sint32 POOL_ST::TestConsistency(bool strict)
	XDEF	TestConsistency__POOL_ST__Ts
TestConsistency__POOL_ST__Ts
	movem.l	d2-d5/a2,-(a7)
	move.l	$18(a7),a2
L280
;	sint32 mismatches = 0
	moveq	#0,d5
;	sint32 mismatches = 0, i = 0
	moveq	#0,d2
;	sint32 mismatches = 0, i = 0, blockE
	moveq	#0,d4
;		sint32 lastPos = 0;
	moveq	#0,d3
;		while (i < size)
	bra.b	L289
L281
;			uint32 sizeBuff = lengthTable[i];
	move.l	$20(a2),a0
	moveq	#0,d0
	move.w	0(a0,d2.l*2),d0
;			if (!sizeBuff)
	tst.l	d0
	bne.b	L283
L282
;				blockErrs++;
	addq.l	#1,d4
;				sizeBuff = ExamineBlock(lastPos);
	move.l	d3,-(a7)
	move.l	a2,-(a7)
	jsr	ExamineBlock__POOL_ST__TUj
	addq.w	#$8,a7
;				lengthTable[lastPos] = sizeBuff;
	move.l	$20(a2),a0
	move.w	d0,0(a0,d3.l*2)
;				i = lastPos + sizeBuff;
	move.l	d3,d2
	add.l	d0,d2
L283
;			if (allocTable[i] && (*(allocTable[i]) != &pool[i*tSize]))
	move.l	$18(a2),a0
	tst.l	0(a0,d2.l*4)
	beq.b	L286
L284
	move.l	$18(a2),a0
	move.l	0(a0,d2.l*4),a0
	move.l	(a0),a1
	move.l	$C(a2),d1
	mulu.l	d2,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	cmp.l	a0,a1
	beq.b	L286
L285
;				mismatches++;
	addq.l	#1,d5
L286
;			if (i + sizeBuff > size)
	move.l	d2,d3
	add.l	d0,d3
	cmp.l	4(a2),d3
	bls.b	L288
L287
;				blockErrs++;
	addq.l	#1,d4
;				sizeBuff = ExamineBlock(i);
	move.l	d2,-(a7)
	move.l	a2,-(a7)
	jsr	ExamineBlock__POOL_ST__TUj
	addq.w	#$8,a7
;				lengthTable[i] = sizeBuff;
	move.l	$20(a2),a0
	move.w	d0,0(a0,d2.l*2)
L288
;			lastPos = i;
	move.l	d2,d3
;			i += sizeBuff;
	add.l	d0,d2
L289
	cmp.l	4(a2),d2
	blo	L281
L290
;	return mismatches;
	move.l	d5,d0
	movem.l	(a7)+,d2-d5/a2
	rts

	SECTION "Create__POOL_ST__TUsUj:0",CODE


;sint32 POOL_ST::Create(uint16 s, uint32 t)
	XDEF	Create__POOL_ST__TUsUj
Create__POOL_ST__TUsUj
	movem.l	d2/d3/a2,-(a7)
	move.l	$16(a7),d1
	move.w	$14(a7),d2
	move.l	$10(a7),a2
L291
;	if (pool)
	tst.l	$1C(a2)
	beq.b	L293
L292
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L293
;	tSize = t/2 + (t & 1);
	move.l	d1,d0
	moveq	#1,d3
	lsr.l	d3,d0
	and.l	#1,d1
	add.l	d1,d0
	move.l	d0,$C(a2)
;	rawSize = tSize*s;
	moveq	#0,d1
	move.w	d2,d1
	move.l	$C(a2),d0
	mulu.l	d1,d0
	move.l	d0,$8(a2)
;	uint32 allocationSize = s + (s/2) + (s & 1) + (rawSize/2) + (rawSi
	moveq	#0,d0
	move.w	d2,d0
	moveq	#0,d1
	move.w	d2,d1
	moveq	#1,d3
	lsr.w	d3,d1
	add.l	d1,d0
	moveq	#0,d1
	move.w	d2,d1
	and.l	#1,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	moveq	#1,d3
	lsr.l	d3,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	and.l	#1,d1
	add.l	d1,d0
;	data = (uint32*)MEM::Alloc(allocationSize*sizeof(uint32), true);
	clr.l	-(a7)
	move.w	#1,-(a7)
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,(a2)
;	if (!data)
	tst.l	(a2)
	bne.b	L295
L294
;		Init();
	move.l	a2,a0
	clr.l	$20(a0)
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L295
;	allocTable = (uint16***)&data[0];
	move.l	(a2),a0
	move.l	a0,$18(a2)
;	lengthTable  = (uint16*)&data[s];
	moveq	#0,d0
	move.w	d2,d0
	move.l	(a2),a0
	lea	0(a0,d0.l*4),a0
	move.l	a0,$20(a2)
;	pool			 = (uint16*)&data[s + (s/2) + (s&1)];
	moveq	#0,d0
	move.w	d2,d0
	moveq	#0,d1
	move.w	d2,d1
	moveq	#1,d3
	lsr.w	d3,d1
	add.l	d1,d0
	moveq	#0,d1
	move.w	d2,d1
	and.l	#1,d1
	add.l	d1,d0
	move.l	(a2),a0
	lea	0(a0,d0.l*4),a0
	move.l	a0,$1C(a2)
;	size          = s;
	moveq	#0,d0
	move.w	d2,d0
	move.l	d0,4(a2)
;	totalFree			= size;
	move.l	4(a2),d0
	move.l	d0,$14(a2)
;	nextFree			= 0;
	clr.l	$10(a2)
;	lengthTable[0]  = size;
	move.l	$20(a2),a0
	move.w	6(a2),(a0)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "Delete__POOL_ST__Tss:0",CODE


;sint32 POOL_ST::Delete(bool force, bool update)
	XDEF	Delete__POOL_ST__Tss
Delete__POOL_ST__Tss
	movem.l	d2-d4/a2/a3,-(a7)
	move.w	$1E(a7),d2
	move.w	$1C(a7),d3
	move.l	$18(a7),a2
L296
;	sint32 inUse =  size - totalFree;
	move.l	4(a2),d0
	sub.l	$14(a2),d0
;	if (!force)
	tst.w	d3
	bne.b	L300
L297
;		if (inUse)
	tst.l	d0
	beq.b	L299
L298
;			return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L299
	bra.b	L311
L300
;		if (data && inUse && update)
	tst.l	(a2)
	beq.b	L311
L301
	tst.l	d0
	beq.b	L311
L302
	tst.w	d2
	beq.b	L311
L303
;			sint32 p = 0;
	moveq	#0,d3
;			for (sint32 i=0;
	moveq	#0,d0
	bra.b	L310
L304
;				if (IsInPool(*(allocTable[i])))
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	move.l	(a0),a1
	move.l	a2,a0
	moveq	#0,d2
	cmp.l	$1C(a0),a1
	blo.b	L307
L305
	move.l	$8(a0),d1
	subq.l	#1,d1
	move.l	$1C(a0),a3
	lea	0(a3,d1.l*2),a0
	cmp.l	a0,a1
	bhs.b	L307
L306
	moveq	#1,d2
L307
	tst.l	d2
	beq.b	L309
L308
;					*(allocTable[i]) = 0;
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	clr.l	(a0)
L309
;				p++;
	addq.l	#1,d3
	addq.l	#1,d0
L310
	cmp.l	4(a2),d0
	blo.b	L304
L311
;	if (data)
	tst.l	(a2)
	beq.b	L313
L312
;		MEM::Free(data);
	move.l	(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		Init();
	move.l	a2,a0
	clr.l	$20(a0)
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
L313
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts

	SECTION "Resize__POOL_ST__TUs:0",CODE


;sint32 POOL_ST::Resize(uint16 s)
	XDEF	Resize__POOL_ST__TUs
Resize__POOL_ST__TUs
L328	EQU	-$24
	link	a5,#L328
	movem.l	d2-d6/a2/a3/a6,-(a7)
	move.w	$C(a5),d4
	move.l	$8(a5),a2
L314
;			if (--sizeBuff)
	moveq	#0,d0
	move.w	d4,d0
	move.l	4(a2),d1
	cmp.l	d0,d1
	bne.b	L316
L315
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L316
;	if (s > (size - totalFree))
	moveq	#0,d2
	move.w	d4,d2
	move.l	4(a2),d0
	sub.l	$14(a2),d0
	cmp.l	d0,d2
	bls	L327
L317
;		if (TestConsistency())
	clr.w	-(a7)
	move.l	a2,-(a7)
	jsr	TestConsistency__POOL_ST__Ts
	addq.w	#6,a7
	tst.l	d0
	beq.b	L319
L318
;			return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L319
;		uint32 newRawSize = s*tSize;
	moveq	#0,d5
	move.w	d4,d5
	mulu.l	$C(a2),d5
;		uint32 allocationSize = s + (s/2) + (s & 1) + (rawSize/2) + (raw
	moveq	#0,d0
	move.w	d4,d0
	moveq	#0,d1
	move.w	d4,d1
	moveq	#1,d2
	lsr.w	d2,d1
	add.l	d1,d0
	moveq	#0,d1
	move.w	d4,d1
	and.l	#1,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	moveq	#1,d2
	lsr.l	d2,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	and.l	#1,d1
	add.l	d1,d0
;		uint32* newData = (uint32*)MEM::Alloc(allocationSize*sizeof(uint
	clr.l	-(a7)
	move.w	#1,-(a7)
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,-$C(a5)
;		if (!newData)
	tst.l	-$C(a5)
	bne.b	L321
L320
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L321
;		uint16***	newAllocTable = (uint16***)&newData[0];
	move.l	-$C(a5),-$10(a5)
;		uint16*		newASizeData  = (uint16*)&newData[s];
	moveq	#0,d0
	move.w	d4,d0
	asl.l	#2,d0
	add.l	-$C(a5),d0
	move.l	d0,-$14(a5)
;		uint16*		newPool				= (uint16*)&newData[s + (s/2 + s&1)];
	moveq	#0,d1
	move.w	d4,d1
	moveq	#0,d0
	move.w	d4,d0
	moveq	#1,d2
	lsr.w	d2,d0
	moveq	#0,d2
	move.w	d4,d2
	add.l	d2,d0
	and.l	#1,d0
	add.l	d0,d1
	move.l	d1,d0
	asl.l	#2,d0
	add.l	-$C(a5),d0
	move.l	d0,a6
;		rsint32 i = 0
	moveq	#0,d2
;		rsint32 i = 0, j = 0;
	moveq	#0,d3
;		while (i <size)
	bra.b	L325
L322
;			if (allocTable[i])
	move.l	$18(a2),a0
	tst.l	0(a0,d2.l*4)
	beq.b	L324
L323
;				newAllocTable[j]	= allocTable[i];
	move.l	$18(a2),a0
	move.l	0(a0,d2.l*4),a1
	move.l	-$10(a5),a3
	move.l	a1,0(a3,d3.l*4)
;				newASizeData[j]		= lengthTable[i];
	move.l	$20(a2),a0
	move.w	0(a0,d2.l*2),d0
	move.l	-$14(a5),a1
	move.w	d0,0(a1,d3.l*2)
;				MEM::Copy(&newPool[j*tSize], &pool[i*tSize], lengthTabl
	move.l	$20(a2),a0
	moveq	#0,d0
	move.w	0(a0,d2.l*2),d0
	mulu.l	$C(a2),d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$C(a2),d1
	mulu.l	d2,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	$C(a2),d1
	mulu.l	d3,d1
	lea	0(a6,d1.l*2),a0
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
;				j += lengthTable[i];
	move.l	$20(a2),a0
	moveq	#0,d0
	move.w	0(a0,d2.l*2),d0
	add.l	d0,d3
L324
;			i += lengthTable[i];
	move.l	$20(a2),a0
	moveq	#0,d0
	move.w	0(a0,d2.l*2),d0
	add.l	d0,d2
L325
	cmp.l	4(a2),d2
	blo	L322
L326
;		MEM::Free(data);
	move.l	(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		data				= newData;
	move.l	-$C(a5),(a2)
;		lengthTable	= newASizeData;
	move.l	-$14(a5),$20(a2)
;		pool				= newPool;
	move.l	a6,$1C(a2)
;		allocTable	= newAllocTable;
	move.l	-$10(a5),$18(a2)
;		totalFree += (s - size);
	moveq	#0,d1
	move.w	d4,d1
	sub.l	4(a2),d1
	add.l	d1,$14(a2)
;		size			= s;
	moveq	#0,d0
	move.w	d4,d0
	move.l	d0,4(a2)
;		rawSize		= newRawSize;
	move.l	d5,$8(a2)
;		nextFree	= size - totalFree;
	move.l	4(a2),d0
	sub.l	$14(a2),d0
	move.l	d0,$10(a2)
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L327
;	return ERR_RESIZE_TO_SMALL;
	move.l	#-$3800005,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "Defrag__POOL_ST__T:0",CODE


;sint32 POOL_ST::Defrag()
	XDEF	Defrag__POOL_ST__T
Defrag__POOL_ST__T
	movem.l	d2-d7/a2,-(a7)
	move.l	$20(a7),a2
L329
;	if (TestConsistency())
	clr.w	-(a7)
	move.l	a2,-(a7)
	jsr	TestConsistency__POOL_ST__Ts
	addq.w	#6,a7
	tst.l	d0
	beq.b	L331
L330
;		return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d7/a2
	rts
L331
;	sint32 c = nextFree;
	move.l	$10(a2),d7
;	sint32 s = c+lengthTable[c];
	move.l	d7,d0
	move.l	$20(a2),a0
	move.w	0(a0,d0.l*2),d0
	and.l	#$FFFF,d0
	move.l	d7,d4
	add.l	d0,d4
;	while (s < size)
	bra	L342
L332
;		rsint32 sizeBuff = lengthTable[s];
	move.l	$20(a2),a0
	moveq	#0,d5
	move.w	0(a0,d4.l*2),d5
;		if (allocTable[s])
	move.l	$18(a2),a0
	tst.l	0(a0,d4.l*4)
	beq	L341
L333
;			lengthTable[c]  = sizeBuff;
	move.l	d7,d1
	move.l	$20(a2),a0
	move.w	d5,0(a0,d1.l*2)
;			allocTable[c] = allocTable[s];
	move.l	$18(a2),a0
	move.l	0(a0,d4.l*4),a1
	move.l	d7,d0
	move.l	$18(a2),a0
	move.l	a1,0(a0,d0.l*4)
;			lengthTable[s]  = 0;
	move.l	$20(a2),a0
	clr.w	0(a0,d4.l*2)
;			allocTable[s] = 0;
	move.l	$18(a2),a0
	clr.l	0(a0,d4.l*4)
;			*(allocTable[c]) = &pool[c*tSize];
	move.l	$C(a2),d0
	mulu.l	d7,d0
	move.l	$1C(a2),a0
	lea	0(a0,d0.l*2),a1
	move.l	d7,d0
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	move.l	a1,(a0)
;			if (s-c > sizeBuff)
	move.l	d4,d0
	sub.l	d7,d0
	cmp.l	d5,d0
	ble.b	L335
L334
;				MEM::Copy(&pool[c*tSize], &pool[s*tSize], sizeBuff*tSiz
	move.l	$C(a2),d0
	mulu.l	d5,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$C(a2),d1
	mulu.l	d4,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	$C(a2),d1
	mulu.l	d7,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
	bra	L340
L335
;				rsint32 t = 0
	moveq	#0,d2
;				rsint32 t = 0, max = s-c;
	move.l	d4,d3
	sub.l	d7,d3
;				while (t < sizeBuff)
	bra	L339
L336
;					MEM::Copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], max
	move.l	$C(a2),d0
	mulu.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d4,d1
	add.l	d2,d1
	mulu.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	d7,d1
	add.l	d2,d1
	mulu.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
;					if (t + max > sizeBuff)
	move.l	d2,d0
	add.l	d3,d0
	cmp.l	d5,d0
	ble.b	L338
L337
;						max = sizeBuff-t;
	move.l	d5,d3
	sub.l	d2,d3
;						t += max;
	add.l	d3,d2
;						MEM::Copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], m
	move.l	$C(a2),d0
	mulu.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d4,d1
	add.l	d2,d1
	mulu.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	d7,d1
	add.l	d2,d1
	mulu.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
L338
;					t += max;
	add.l	d3,d2
L339
	cmp.l	d5,d2
	blt	L336
L340
;			c += sizeBuff;
	move.l	d7,d0
	add.l	d5,d0
	move.l	d0,d7
L341
;		s += sizeBuff;
	add.l	d5,d4
L342
	cmp.l	4(a2),d4
	blo	L332
L343
;	nextFree = c;
	move.l	d7,$10(a2)
;	lengthTable[nextFree] = totalFree;
	move.l	$10(a2),d0
	move.l	$20(a2),a0
	move.w	$16(a2),0(a0,d0.l*2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "NewT__POOL_ST__TPv:0",CODE


;sint32 POOL_ST::NewT(void* vt)
	XDEF	NewT__POOL_ST__TPv
NewT__POOL_ST__TPv
	movem.l	d2/a2,-(a7)
	movem.l	$C(a7),a0/a1
L344
;	ruint16** t = (uint16**)vt;
;	if (*(t) != 0)
	move.l	(a1),a2
	cmp.w	#0,a2
	beq.b	L346
L345
;		return ERR_PTR_USED;
	move.l	#-$3020003,d0
	movem.l	(a7)+,d2/a2
	rts
L346
;	if (totalFree)
	tst.l	$14(a0)
	beq	L356
L347
;		uint32 sizeBuff = lengthTable[nextFree];
	move.l	$10(a0),d0
	move.l	$20(a0),a2
	move.w	0(a2,d0.l*2),d0
	and.l	#$FFFF,d0
;		allocTable[nextFree] = t;
	move.l	$10(a0),d1
	move.l	$18(a0),a2
	move.l	a1,0(a2,d1.l*4)
;		lengthTable[nextFree] = 1;
	move.l	$10(a0),d1
	move.l	$20(a0),a2
	move.w	#1,0(a2,d1.l*2)
;		*(t) = &pool[nextFree*tSize];
	move.l	$10(a0),d1
	mulu.l	$C(a0),d1
	move.l	$1C(a0),a2
	lea	0(a2,d1.l*2),a2
	move.l	a2,(a1)
;		totalFree--;
	subq.l	#1,$14(a0)
;		if (totalFree)
	tst.l	$14(a0)
	beq.b	L355
L348
;			if (--sizeBuff)
	subq.l	#1,d0
	tst.l	d0
	beq.b	L350
L349
;				lengthTable[++nextFree] = sizeBuff;
	move.w	d0,d1
	move.l	$20(a0),a1
	move.l	$10(a0),d0
	addq.l	#1,d0
	move.l	d0,$10(a0)
	move.w	d1,0(a1,d0.l*2)
;				return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L350
;			rsint32 i = nextFree+1;
	move.l	$10(a0),d0
	addq.l	#1,d0
;			while ((i < size) && allocTable[i])
	bra.b	L352
L351
;				i += lengthTable[i];
	move.l	$20(a0),a1
	moveq	#0,d1
	move.w	0(a1,d0.l*2),d1
	add.l	d1,d0
L352
	cmp.l	4(a0),d0
	bhs.b	L354
L353
	move.l	$18(a0),a1
	tst.l	0(a1,d0.l*4)
	bne.b	L351
L354
;			nextFree = i;
	move.l	d0,$10(a0)
;			return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L355
;		nextFree = -1;
	move.l	#-1,$10(a0)
;		return WRN_RSC_EXHAUSTED;
	move.l	#-$2050006,d0
	movem.l	(a7)+,d2/a2
	rts
L356
;	return ERR_RSC_EXHAUSTED;
	move.l	#-$3050006,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "NewT__POOL_ST__TPvUs:0",CODE


;sint32 POOL_ST::NewT(void* vt, uint16 s)
	XDEF	NewT__POOL_ST__TPvUs
NewT__POOL_ST__TPvUs
	movem.l	d2-d4/a2/a3,-(a7)
	move.w	$20(a7),d2
	move.l	$1C(a7),a0
	move.l	$18(a7),a2
L357
;	ruint16** t = (uint16**)vt;
	move.l	a0,a3
;	if (*(t) != 0)
	move.l	a3,a1
	move.l	(a1),a0
	cmp.w	#0,a0
	beq.b	L359
L358
;		return ERR_PTR_USED;
	move.l	#-$3020003,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L359
;	if (totalFree < s)
	moveq	#0,d0
	move.w	d2,d0
	move.l	$14(a2),d1
	cmp.l	d0,d1
	bge.b	L361
L360
;		return ERR_NEW_ALLOC_TO_BIG;
	move.l	#-$3800006,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L361
;	rsint32 i = nextFree
	move.l	$10(a2),d0
;	rsint32 i = nextFree, found = -1;
	moveq	#-1,d1
;	while ((i < size) && (found < 0))
	bra.b	L366
L362
;		if (allocTable[i] == 0 && lengthTable[i] >= s)
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	cmp.w	#0,a0
	bne.b	L365
L363
	move.l	$20(a2),a0
	move.w	0(a0,d0.l*2),d3
	cmp.w	d2,d3
	blo.b	L365
L364
;			found = i;
	move.l	d0,d1
	bra.b	L366
L365
;			i += lengthTable[i];
	move.l	$20(a2),a0
	moveq	#0,d3
	move.w	0(a0,d0.l*2),d3
	add.l	d3,d0
L366
	cmp.l	4(a2),d0
	bhs.b	L368
L367
	tst.l	d1
	bmi.b	L362
L368
;	if (found < 0)
	tst.l	d1
	bpl.b	L372
L369
;		if (Defrag())
	move.l	a2,-(a7)
	jsr	Defrag__POOL_ST__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L371
L370
;			return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L371
;		found = nextFree;
	move.l	$10(a2),d1
L372
;	uint32 sizeBuff = lengthTable[found];
	move.l	$20(a2),a0
	moveq	#0,d0
	move.w	0(a0,d1.l*2),d0
;	if (s < sizeBuff)
	moveq	#0,d3
	move.w	d2,d3
	cmp.l	d0,d3
	bhs.b	L374
L373
;		lengthTable[found] = s;
	move.l	$20(a2),a0
	move.w	d2,0(a0,d1.l*2)
;		lengthTable[found+s] = sizeBuff - s;
	moveq	#0,d3
	move.w	d2,d3
	sub.l	d3,d0
	move.w	d0,d3
	moveq	#0,d0
	move.w	d2,d0
	add.l	d1,d0
	move.l	$20(a2),a0
	move.w	d3,0(a0,d0.l*2)
L374
;	allocTable[found] = t;
	move.l	$18(a2),a0
	move.l	a3,0(a0,d1.l*4)
;	*(t) = &pool[found*tSize];
	move.l	$C(a2),d0
	mulu.l	d1,d0
	move.l	$1C(a2),a0
	lea	0(a0,d0.l*2),a0
	move.l	a3,a1
	move.l	a0,(a1)
;	totalFree -= s;
	moveq	#0,d3
	move.w	d2,d3
	sub.l	d3,$14(a2)
;	if (totalFree)
	tst.l	$14(a2)
	beq.b	L382
L375
;		if (nextFree == found)
	move.l	$10(a2),d0
	cmp.l	d1,d0
	bne.b	L381
L376
;			i = found+s;
	moveq	#0,d0
	move.w	d2,d0
	add.l	d1,d0
;			while ((i < size) && allocTable[i])
	bra.b	L378
L377
;				i += lengthTable[i];
	move.l	$20(a2),a0
	moveq	#0,d1
	move.w	0(a0,d0.l*2),d1
	add.l	d1,d0
L378
	cmp.l	4(a2),d0
	bhs.b	L380
L379
	move.l	$18(a2),a0
	tst.l	0(a0,d0.l*4)
	bne.b	L377
L380
;			nextFree = i;
	move.l	d0,$10(a2)
L381
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L382
;	nextFree = -1;
	move.l	#-1,$10(a2)
;	return WRN_RSC_EXHAUSTED;
	move.l	#-$2050006,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts

	SECTION "FreeT__POOL_ST__TPv:0",CODE


;sint32 POOL_ST::FreeT(void* vt)
	XDEF	FreeT__POOL_ST__TPv
FreeT__POOL_ST__TPv
	movem.l	d2-d5/a2-a4,-(a7)
	movem.l	$20(a7),a0/a1
L383
;	ruint16** t = (uint16**)vt;
;	if (*(t) == 0)
	move.l	(a1),a2
	cmp.w	#0,a2
	bne.b	L385
L384
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L385
;	if (!IsInPool(*(t)))
	move.l	(a1),a3
	move.l	a0,a2
	moveq	#0,d1
	cmp.l	$1C(a2),a3
	blo.b	L388
L386
	move.l	$8(a2),d0
	subq.l	#1,d0
	move.l	$1C(a2),a4
	lea	0(a4,d0.l*2),a2
	cmp.l	a2,a3
	bhs.b	L388
L387
	moveq	#1,d1
L388
	tst.l	d1
	bne.b	L390
L389
;		return ERR_PTR_RANGE;
	move.l	#-$3020004,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L390
;	rsint32 found = -1;
;		ruint32 p = (uint32)(*(t) - pool);
	move.l	(a1),d0
	sub.l	$1C(a0),d0
	moveq	#1,d1
	asr.l	d1,d0
;		found = p/tSize;
	move.l	d0,d2
	divul.l	$C(a0),d2
;		if (!allocTable[found])
	move.l	$18(a0),a2
	tst.l	0(a2,d2.l*4)
	bne.b	L392
L391
;			return ERR_PTR_INCONSISTENT;
	move.l	#-$3020005,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L392
;	sint32 result = OK;
	moveq	#0,d0
;	*(t) = 0;
	clr.l	(a1)
;	allocTable[found] = 0;
	move.l	$18(a0),a1
	clr.l	0(a1,d2.l*4)
;	ruint32 sizeBuff = lengthTable[found];
	move.l	$20(a0),a1
	moveq	#0,d5
	move.w	0(a1,d2.l*2),d5
;	totalFree += sizeBuff;
	add.l	d5,$14(a0)
;	if (found + sizeBuff < size)
	move.l	d2,d3
	add.l	d5,d3
	cmp.l	4(a0),d3
	bhs.b	L395
L393
;		uint32 next = found + sizeBuff;
	move.l	d2,d1
	add.l	d5,d1
;		if (allocTable[next] == 0)
	move.l	$18(a0),a1
	move.l	0(a1,d1.l*4),a1
	cmp.w	#0,a1
	bne.b	L395
L394
;			sizeBuff += lengthTable[next];
	move.l	$20(a0),a1
	moveq	#0,d3
	move.w	0(a1,d1.l*2),d3
	add.l	d3,d5
;			lengthTable[next] = 0;
	move.l	$20(a0),a1
	clr.w	0(a1,d1.l*2)
;			lengthTable[found] = sizeBuff;
	move.l	$20(a0),a1
	move.w	d5,0(a1,d2.l*2)
L395
;	if (found == 0 || found < nextFree || nextFree == -1)
	tst.l	d2
	beq.b	L398
L396
	cmp.l	$10(a0),d2
	blt.b	L398
L397
	move.l	$10(a0),d1
	cmp.l	#-1,d1
	bne.b	L399
L398
;		nextFree = found;
	move.l	d2,$10(a0)
;		return result;
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L399
;		rsint32 prev = -1;
	moveq	#-1,d3
;		rsint32 i = nextFree;
	move.l	$10(a0),d1
;		while (i < found)
	bra.b	L404
L400
;			if (allocTable[i]==0)
	move.l	$18(a0),a1
	move.l	0(a1,d1.l*4),a1
	cmp.w	#0,a1
	bne.b	L402
L401
;				prev = i;
	move.l	d1,d3
	bra.b	L403
L402
;				prev = -1;
	moveq	#-1,d3
L403
;			i += lengthTable[i];
	move.l	$20(a0),a1
	moveq	#0,d4
	move.w	0(a1,d1.l*2),d4
	add.l	d4,d1
L404
	cmp.l	d2,d1
	blt.b	L400
L405
;		if (prev >= 0)
	tst.l	d3
	bmi.b	L407
L406
;			lengthTable[prev] += sizeBuff;
	move.l	$20(a0),a1
	lea	0(a1,d3.l*2),a1
	add.w	d5,(a1)
;			lengthTable[found] = 0;
	move.l	$20(a0),a0
	clr.w	0(a0,d2.l*2)
L407
;	return result;
	movem.l	(a7)+,d2-d5/a2-a4
	rts

	END
