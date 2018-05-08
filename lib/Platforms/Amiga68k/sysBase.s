
; Storm C Compiler
; Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/sysBase.cpp
	mc68030
	mc68881
	XREF	_system
	XREF	_vsprintf
	XREF	_sprintf
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_st
	XREF	_gxSt
	XREF	_numStartArgs__xBASELIB
	XREF	_startArgs__xBASELIB
	XREF	_SysBase
	XREF	_TimerBase
	XREF	_DOSBase
	XREF	_PowerPCBase
	XREF	_main__sysBASELIB
	XREF	_maxAllocs__MEM

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_IntuitionBase:1",DATA

	XDEF	_IntuitionBase
_IntuitionBase
	dc.l	0

	SECTION "_allocated__MEM:1",DATA

	XDEF	_allocated__MEM
_allocated__MEM
	dc.l	0

	SECTION "_totSize__MEM:1",DATA

	XDEF	_totSize__MEM
_totSize__MEM
	dc.l	0

	SECTION "_nextFree__MEM:1",DATA

	XDEF	_nextFree__MEM
_nextFree__MEM
	dc.l	0

	SECTION "_cnt__MEM:1",DATA

	XDEF	_cnt__MEM
_cnt__MEM
	dc.l	0

	SECTION "Alloc__MEM__UisE:0",CODE


;void* MEM::Alloc(size_t len, bool zero, MEM::ALIGNTYPE align)
	XDEF	Alloc__MEM__UisE
Alloc__MEM__UisE
	movem.l	d2-d4/a2/a6,-(a7)
	move.l	$1E(a7),d0
	move.w	$1C(a7),d1
	move.l	$18(a7),d4
L83
;	if (!allocated || cnt == MAXALLOCS) 
	tst.l	_allocated__MEM
	beq.b	L85
L84
	move.l	_cnt__MEM,d2
	cmp.l	#$200,d2
	bne.b	L86
L85
;	if (!allocated || cnt == MAXAL
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L86
;	uint32 alignLen = ((uint32)align<8) ? 0 : align;
	cmp.l	#$8,d0
	bhs.b	L88
L87
	moveq	#0,d3
	bra.b	L89
L88
	move.l	d0,d3
L89
;	void* r = AllocVec((len+(alignLen<<1)), (zero?MEMF_PUBLIC|MEMF_CLE
	tst.w	d1
	beq.b	L91
L90
	move.l	#$10001,d1
	bra.b	L92
L91
	moveq	#1,d1
L92
	move.l	d3,d0
	moveq	#1,d2
	asl.l	d2,d0
	add.l	d4,d0
	move.l	_SysBase,a6
	jsr	-$2AC(a6)
	move.l	d0,a0
;	if (r)
	cmp.w	#0,a0
	beq	L100
L93
;		sint32 index = nextFree;
	move.l	_nextFree__MEM,d2
;		allocated[index].real = r;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a2
	move.l	a0,0(a2,d0.l)
;		if (alignLen)
	tst.l	d3
	beq.b	L95
L94
;			uint32 mask = alignLen-1;
	move.l	d3,d0
	subq.l	#1,d0
;			allocated[index].address	= (void*)((mask+(uint32)r) & ~mask);
	move.l	d0,d1
	add.l	a0,d1
	not.l	d0
	and.l	d0,d1
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	d1,4(a1,d0.l)
	bra.b	L96
L95
;			allocated[index].address = r;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a2
	move.l	a0,4(a2,d0.l)
L96
;		allocated[index].owner		= FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	d2,d1
	asl.l	#4,d1
	move.l	_allocated__MEM,a1
	move.l	d0,$8(a1,d1.l)
;		allocated[index].size			= len;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	d4,$C(a1,d0.l)
;		totSize += len;
	add.l	d4,_totSize__MEM
;		cnt++;
	addq.l	#1,_cnt__MEM
;		while (allocated[nextFree].address != 0)
	bra.b	L98
L97
;			nextFree++;
	addq.l	#1,_nextFree__MEM
L98
	move.l	_nextFree__MEM,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	4(a1,d0.l),a0
	cmp.w	#0,a0
	bne.b	L97
L99
;		return allocated[index].address;
	asl.l	#4,d2
	move.l	_allocated__MEM,a1
	move.l	4(a1,d2.l),d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L100
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts

	SECTION "Free__MEM__Pv:0",CODE


;void MEM::Free(void* ptr)
	XDEF	Free__MEM__Pv
Free__MEM__Pv
	movem.l	d2/a2/a6,-(a7)
	move.l	$10(a7),a1
L105
;	if (!allocated)	
	tst.l	_allocated__MEM
	bne.b	L107
L106
;	if (!allocated)	return;
	movem.l	(a7)+,d2/a2/a6
	rts
L107
;	if (ptr)
	cmp.w	#0,a1
	beq	L119
L108
;		sint32 index=-1
	moveq	#-1,d2
;		sint32 index=-1, found=0;
	moveq	#0,d0
;		while((found==0) && (index<MAXALLOCS))
	bra.b	L110
L109
;			found = (ptr==allocated[++index].address);
	addq.l	#1,d2
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a2
	move.l	a1,d1
	cmp.l	4(a2,d0.l),d1
	seq	d1
	and.l	#1,d1
	move.l	d1,d0
L110
	tst.l	d0
	bne.b	L112
L111
	cmp.l	#$200,d2
	blt.b	L109
L112
;		if (!found)
	tst.l	d0
	bne.b	L114
L113
;			sysBASELIB::MessageBox("Debug", "Proceed", "MEM::F
	move.l	#L101,-(a7)
	move.l	#L102,-(a7)
	move.l	#L103,-(a7)
	jsr	MessageBox__sysBASELIB__PcPcPce
	add.w	#$C,a7
;			return;
	movem.l	(a7)+,d2/a2/a6
	rts
L114
;		if (!allocated[index].real)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	tst.l	0(a1,d0.l)
	bne.b	L116
L115
;			return;
	movem.l	(a7)+,d2/a2/a6
	rts
L116
;		FreeVec(allocated[index].real);
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	_SysBase,a6
	move.l	0(a1,d0.l),a1
	jsr	-$2B2(a6)
;		totSize -= allocated[index].size;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	_totSize__MEM,d1
	sub.l	$C(a1,d0.l),d1
	move.l	d1,_totSize__MEM
;		allocated[index].real			= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	clr.l	0(a1,d0.l)
;		allocated[index].address	= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	clr.l	4(a1,d0.l)
;		allocated[index].owner		= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	clr.l	$8(a1,d0.l)
;		allocated[index].size			= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	clr.l	$C(a1,d0.l)
;		cnt--;
	subq.l	#1,_cnt__MEM
;		if (index < nextFree)
	cmp.l	_nextFree__MEM,d2
	bge.b	L118
L117
;			nextFree = index;
	move.l	d2,_nextFree__MEM
L118
;		return;
	movem.l	(a7)+,d2/a2/a6
	rts
L119
;		sysBASELIB::MessageBox("Debug", "Proceed", "MEM::Fre
	move.l	#L104,-(a7)
	move.l	#L102,-(a7)
	move.l	#L103,-(a7)
	jsr	MessageBox__sysBASELIB__PcPcPce
	add.w	#$C,a7
	movem.l	(a7)+,d2/a2/a6
	rts

L103
	dc.b	'Debug',0
L101
	dc.b	'MEM::Free()',$A,'Address not recognised',0
L104
	dc.b	'MEM::Free()',$A,'Attempt to free null address',0
L102
	dc.b	'Proceed',0

	SECTION "DebugInfo__MEM_:0",CODE


;void MEM::DebugInfo()
	XDEF	DebugInfo__MEM_
DebugInfo__MEM_
L137	EQU	-$24
	link	a5,#L137
	movem.l	d2-d4/a2/a3/a6,-(a7)
L126
;	if (!allocated)
	tst.l	_allocated__MEM
	bne.b	L128
L127
;		return;
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L128
;	sint32 c=sprintf(sysBASELIB::MsgBuf(), "MEM Statistics\nsysBASE::s
	pea	$2800.w
	move.l	#L120,-(a7)
	move.l	_msgbuff__sysBASELIB,a0
	move.l	a0,-(a7)
	jsr	_sprintf
	add.w	#$C,a7
	move.l	d0,d3
;	for (sint32 i=0
	moveq	#0,d2
;	for (sint32 i=0, l=0
;	for (sint32 i=0, l=0, b=0;
	moveq	#0,d4
	bra.b	L132
L129
;		if (allocated[i].address)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	tst.l	4(a1,d0.l)
	beq.b	L131
L130
;			l = sprintf(sysBASELIB::MsgBuf()+c, "Block %d : 0x%p <%d> [%d]
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	$C(a1,d0.l),-(a7)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	4(a1,d0.l),d0
	move.l	d2,d1
	asl.l	#4,d1
	move.l	_allocated__MEM,a1
	sub.l	0(a1,d1.l),d0
	move.l	d0,-(a7)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	4(a1,d0.l),-(a7)
	move.l	d4,-(a7)
	move.l	#L121,-(a7)
	move.l	_msgbuff__sysBASELIB,a0
	pea	0(a0,d3.l)
	jsr	_sprintf
	add.w	#$18,a7
;			b++;
	addq.l	#1,d4
;			c+=l;
	add.l	d0,d3
L131
	addq.l	#1,d2
L132
	cmp.l	#$200,d2
	bge.b	L134
L133
	cmp.l	#$400,d3
	blt	L129
L134
;	if ((b+1) < cnt)
	addq.l	#1,d4
	cmp.l	_cnt__MEM,d4
	bge.b	L136
L135
;		l = sprintf(sysBASELIB::MsgBuf()+c, "\n<List Truncated>\n");
	move.l	#L122,-(a7)
	move.l	_msgbuff__sysBASELIB,a0
	pea	0(a0,d3.l)
	jsr	_sprintf
	addq.w	#$8,a7
;		c+= l;
	add.l	d0,d3
L136
;	sprintf(sysBASELIB::MsgBuf()+c, "\nTotal %d / %d block(s), %d byte
	move.l	_totSize__MEM,d0
	add.l	#$2000,d0
	add.l	#$800,d0
	move.l	d0,-(a7)
	pea	$200.w
	move.l	_cnt__MEM,-(a7)
	move.l	#L123,-(a7)
	move.l	_msgbuff__sysBASELIB,a0
	pea	0(a0,d3.l)
	jsr	_sprintf
	add.w	#$14,a7
;	EasyStruct mb = {sizeof(EasyStruct),0,"Debug Info", sys
	lea	-$24(a5),a0
	move.l	#$14,(a0)+
	clr.l	(a0)+
	move.l	#L124,(a0)+
	move.l	_msgbuff__sysBASELIB,a1
	move.l	a1,(a0)+
	move.l	#L125,(a0)
;	EasyRequest(0, &mb, 0);
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	lea	-$24(a5),a1
	sub.l	a2,a2
	move.l	a7,a3
	jsr	-$24C(a6)
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts

L122
	dc.b	$A,'<List Truncated>',$A,0
L123
	dc.b	$A,'Total %d / %d block(s), %d bytes',0
L121
	dc.b	'Block %d : 0x%p <%d> [%d]',$A,0
L124
	dc.b	'Debug Info',0
L120
	dc.b	'MEM Statistics',$A,'sysBASE::sysData %d bytes',$A,$A,0
L125
	dc.b	'Proceed',0

	SECTION "FreeAll__MEM_:0",CODE


;void MEM::FreeAll()
	XDEF	FreeAll__MEM_
FreeAll__MEM_
	movem.l	d2-d4/a6,-(a7)
L141
;	if (!allocated)
	tst.l	_allocated__MEM
	bne.b	L143
L142
;		return;
	movem.l	(a7)+,d2-d4/a6
	rts
L143
;	sint32 freed = 0
	moveq	#0,d3
;	sint32 freed = 0, size=0;
	moveq	#0,d4
;	for (rsint32 i=0;
	moveq	#0,d2
	bra	L147
L144
;		if (allocated[i].real)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	tst.l	0(a1,d0.l)
	beq	L146
L145
;			FreeVec(allocated[i].real);
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	_SysBase,a6
	move.l	0(a1,d0.l),a1
	jsr	-$2B2(a6)
;			totSize -= allocated[i].size;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	_totSize__MEM,d1
	sub.l	$C(a1,d0.l),d1
	move.l	d1,_totSize__MEM
;			size += allocated[i].size;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	add.l	$C(a1,d0.l),d4
;			allocated[i].real			= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	clr.l	0(a1,d0.l)
;			allocated[i].address	= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	clr.l	4(a1,d0.l)
;			allocated[i].size			= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	clr.l	$C(a1,d0.l)
;			allocated[i].owner 		= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	clr.l	$8(a1,d0.l)
;			freed++;
	addq.l	#1,d3
;			cnt--;
	subq.l	#1,_cnt__MEM
L146
	addq.l	#1,d2
L147
	cmp.l	#$200,d2
	blt	L144
L148
;//  MEM::Move() : always attempts to use 
	tst.l	d3
	beq.b	L150
L149
;		sysBASELIB::MessageBox("Debug Info","Proceed","MEM::
	move.l	d4,-(a7)
	move.l	d3,-(a7)
	move.l	#L138,-(a7)
	move.l	#L139,-(a7)
	move.l	#L140,-(a7)
	jsr	MessageBox__sysBASELIB__PcPcPce
	add.w	#$14,a7
L150
;	allocated = 0;
	clr.l	_allocated__MEM
	movem.l	(a7)+,d2-d4/a6
	rts

L140
	dc.b	'Debug Info',0
L138
	dc.b	'MEM::FreeAll()',$A,'Released %d block(s)',$A,'totalling %d bytes',$A
	dc.b	0
L139
	dc.b	'Proceed',0

	SECTION "Copy__MEM__r8Pvr9Pvr0Ui:0",CODE


;void* MEM::Copy(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t
	XDEF	Copy__MEM__r8Pvr9Pvr0Ui
Copy__MEM__r8Pvr9Pvr0Ui
	movem.l	d2/a2/a6,-(a7)
	move.l	a0,a2
	move.l	a1,a0
L151
;	if (((uint32)dst|(uint32)src|(uint32)len)&3UL)
	move.l	a2,d1
	move.l	a0,d2
	or.l	d2,d1
	or.l	d0,d1
	and.l	#3,d1
	beq.b	L153
L152
;		CopyMem(src, dst, len);
	move.l	_SysBase,a6
	move.l	a2,a1
	jsr	-$270(a6)
	bra.b	L154
L153
;		CopyMemQuick(src, dst, len);
	move.l	_SysBase,a6
	move.l	a2,a1
	jsr	-$276(a6)
L154
;	return dst;
	move.l	a2,d0
	movem.l	(a7)+,d2/a2/a6
	rts

	SECTION "Set__MEM__r8Pvr0ir1Ui:0",CODE


;void* MEM::Set(REGP(0) void* dst, REGI(0) int c, REGI(1) size_t len)
	XDEF	Set__MEM__r8Pvr0ir1Ui
Set__MEM__r8Pvr0ir1Ui
	movem.l	d2-d4/a2,-(a7)
L155
;	c &= 0x000000FF;
	and.l	#$FF,d0
;	ruint8* d = (uint8*)dst;
	move.l	a0,a1
;	switch ((uint32)d & 3UL)
	move.l	a1,d2
	and.l	#3,d2
	cmp.l	#2,d2
	beq.b	L157
	bhi.b	L167
	cmp.l	#1,d2
	beq.b	L156
	bra.b	L159
L167
	cmp.l	#3,d2
	beq.b	L158
	bra.b	L159
;		
L156
;		case 1:		*(d++) = *(d++) = *(d++) = c;
	move.b	d0,d2
	move.b	d2,(a1)+
	move.b	d2,(a1)+
	move.b	d2,(a1)+
; len-=3;
	subq.l	#3,d1
; 
	bra.b	L159
L157
;		case 2:		*(d++) = *(d++) = c;
	move.b	d0,d2
	move.b	d2,(a1)+
	move.b	d2,(a1)+
; len-=2;
	subq.l	#2,d1
; 
	bra.b	L159
L158
;		case 3:		*(d++) = c;
	move.b	d0,(a1)+
; len--;
	subq.l	#1,d1
; 
L159
;	switch (len & 3UL)
	move.l	d1,d2
	and.l	#3,d2
	cmp.l	#2,d2
	beq.b	L161
	bhi.b	L168
	cmp.l	#1,d2
	beq.b	L162
	bra.b	L163
L168
	cmp.l	#3,d2
	beq.b	L160
	bra.b	L163
;		
L160
;		case 3: *(d+len-3) = *(d+len-2) = *(d+len-1) = c;
	move.b	d0,d2
	lea	0(a1,d1.l),a2
	move.b	d2,-(a2)
	lea	0(a1,d1.l),a2
	move.b	d2,-2(a2)
	lea	0(a1,d1.l),a2
	move.b	d2,-3(a2)
;b
	bra.b	L163
L161
;		case 2: *(d+len-2) = *(d+len-1) = c;
	move.b	d0,d2
	lea	0(a1,d1.l),a2
	move.b	d2,-(a2)
	lea	0(a1,d1.l),a2
	move.b	d2,-2(a2)
;b
	bra.b	L163
L162
;		case 1: *(d+len-1) = c;
	lea	0(a1,d1.l),a2
	move.b	d0,-(a2)
;b
L163
;	ruint32 v = (c<<24) | (c<<16) | (c<<8) | c;
	move.l	d0,d2
	moveq	#$18,d3
	asl.l	d3,d2
	move.l	d0,d3
	moveq	#$10,d4
	asl.l	d4,d3
	or.l	d3,d2
	move.l	d0,d3
	moveq	#$8,d4
	asl.l	d4,d3
	or.l	d3,d2
	or.l	d0,d2
;	rsint32 i = (len>>2)+1;
	moveq	#2,d0
	lsr.l	d0,d1
	addq.l	#1,d1
;	while (--i)
	bra.b	L165
L164
;		*(((uint32*)d)++) = v;
	move.l	d2,(a1)+
L165
	subq.l	#1,d1
	tst.l	d1
	bne.b	L164
L166
;	return dst;
	move.l	a0,d0
	movem.l	(a7)+,d2-d4/a2
	rts

	SECTION "Zero__MEM__r8Pvr0Ui:0",CODE


;void* MEM::Zero(REGP(0) void* dst, REGI(0) size_t len)
	XDEF	Zero__MEM__r8Pvr0Ui
Zero__MEM__r8Pvr0Ui
	movem.l	d2/a2,-(a7)
L169
;	ruint8* d = (uint8*)dst;
	move.l	a0,a1
;	switch ((uint32)d & 3UL)
	move.l	a1,d1
	and.l	#3,d1
	cmp.l	#2,d1
	beq.b	L171
	bhi.b	L181
	cmp.l	#1,d1
	beq.b	L170
	bra.b	L173
L181
	cmp.l	#3,d1
	beq.b	L172
	bra.b	L173
;		
L170
;		case 1:		*(d++) = *(d++) = *(d++) = 0;
	clr.b	(a1)+
	clr.b	(a1)+
	clr.b	(a1)+
; len-=3;
	subq.l	#3,d0
; 
	bra.b	L173
L171
;		case 2:		*(d++) = *(d++) = 0;
	clr.b	(a1)+
	clr.b	(a1)+
; len-=2;
	subq.l	#2,d0
; 
	bra.b	L173
L172
;		case 3:		*(d++) = 0;
	clr.b	(a1)+
; len--;
	subq.l	#1,d0
; 
L173
;	switch (len & 3UL)
	move.l	d0,d1
	and.l	#3,d1
	cmp.l	#2,d1
	beq.b	L175
	bhi.b	L182
	cmp.l	#1,d1
	beq.b	L176
	bra.b	L177
L182
	cmp.l	#3,d1
	beq.b	L174
	bra.b	L177
;		
L174
;		case 3: *(d+len-3) = *(d+len-2) = *(d+len-1) = 0;
	lea	0(a1,d0.l),a2
	clr.b	-(a2)
	lea	0(a1,d0.l),a2
	clr.b	-2(a2)
	lea	0(a1,d0.l),a2
	clr.b	-3(a2)
;b
	bra.b	L177
L175
;		case 2: *(d+len-2) = *(d+len-1) = 0;
	lea	0(a1,d0.l),a2
	clr.b	-(a2)
	lea	0(a1,d0.l),a2
	clr.b	-2(a2)
;b
	bra.b	L177
L176
;		case 1: *(d+len-1) = 0;
	lea	0(a1,d0.l),a2
	clr.b	-(a2)
;b
L177
;	rsint32 i = (len>>2)+1;
	moveq	#2,d1
	lsr.l	d1,d0
	addq.l	#1,d0
;	while (--i)
	bra.b	L179
L178
;		*(((uint32*)d)++) = 0UL;
	clr.l	(a1)+
L179
	subq.l	#1,d0
	tst.l	d0
	bne.b	L178
L180
;	return dst;
	move.l	a0,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "Move__MEM__r8Pvr9Pvr0Ui:0",CODE


;void* MEM::Move(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t
	XDEF	Move__MEM__r8Pvr9Pvr0Ui
Move__MEM__r8Pvr9Pvr0Ui
	movem.l	d2-d4/a2/a3,-(a7)
L183
;	if (dst==src) 
	cmp.l	a1,a0
	bne.b	L185
L184
;	if (dst==src) return dst;
	move.l	a0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L185
;	if ((uint8*)dst>(uint8*)src)
	cmp.l	a1,a0
	bls	L218
L186
;		if (len<=((uint8*)dst-(uint8*)src))
	move.l	a0,d1
	sub.l	a1,d1
	cmp.l	d1,d0
	bhi.b	L188
L187
;			return Copy(dst, src, len);
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L188
;		if (((uint32)dst|(uint32)src)&1UL)
	move.l	a0,d1
	move.l	a1,d2
	or.l	d2,d1
	and.l	#1,d1
	beq.b	L193
L189
;			ruint8* s = (uint8*)src+len;
	lea	0(a1,d0.l),a2
;			ruint8* d = (uint8*)dst+len;
	lea	0(a0,d0.l),a1
;			rsint32 n = len+1;
	addq.l	#1,d0
;			while(--n)
	bra.b	L191
L190
;				*(--d) = *(--s);
	move.b	-(a2),-(a1)
L191
	subq.l	#1,d0
	tst.l	d0
	bne.b	L190
L192
;			return dst;
	move.l	a0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L193
;			uint32 copyGap = (uint8*)dst-(uint8*)src;
	move.l	a0,d3
	sub.l	a1,d3
;			if (copyGap>7)
	cmp.l	#7,d3
	bls.b	L203
L194
;				copyGap &= (!3UL);
	moveq	#0,d3
;				rsint32 n = len;
;				ruint32 *s = (uint32*)src
;				ruint32 *s = (uint32*)src, *d = (
	move.l	a0,a2
;				while(n>copyGap)
	bra.b	L199
L195
;					rsint32 i=1+(copyGap>>2);
	move.l	d3,d1
	moveq	#2,d2
	lsr.l	d2,d1
	addq.l	#1,d1
;					while (--i)
	bra.b	L197
L196
;						*d++ = *s++;
	move.l	(a1)+,(a2)+
L197
	subq.l	#1,d1
	tst.l	d1
	bne.b	L196
L198
;					n-=copyGap;
	sub.l	d3,d0
L199
	cmp.l	d3,d0
	bhi.b	L195
L200
;				if (n) // if remaining data, must be < copyGap thus not over
	tst.l	d0
	beq.b	L202
L201
;					return Copy(d, s, n);
	move.l	a2,a0
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L202
;				return dst;
	move.l	a0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L203
;			else if (copyGap>3)
	cmp.l	#3,d3
	bls.b	L212
L204
;				rsint32 n = len;
;				ruint32 *s = (uint32*)src
;				ruint32 *s = (uint32*)src, *d = (
	move.l	a0,a2
;				while(n>4)
	bra.b	L206
L205
;					*d++ = *s++;
	move.l	(a1)+,(a2)+
;					n-=4;
	subq.l	#4,d0
L206
	cmp.l	#4,d0
	bgt.b	L205
L207
;				if (n) // 1 - 3 bytes left
	tst.l	d0
	beq.b	L211
L208
;					n++;
	addq.l	#1,d0
;					while(--n)
	bra.b	L210
L209
;						*(((uint8*)d)++) = *(((uint8*)s)++);
	move.b	(a1)+,(a2)+
L210
	subq.l	#1,d0
	tst.l	d0
	bne.b	L209
L211
;				return dst;
	move.l	a0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L212
;				rsint32 n = len;
;				ruint16 *s = (uint16*)src
;				ruint16 *s = (uint16*)src, *d = (
	move.l	a0,a2
;				while(n>2)
	bra.b	L214
L213
;					*d++ = *s++;
	move.w	(a1)+,(a2)+
;					n-=2;
	subq.l	#2,d0
L214
	cmp.l	#2,d0
	bgt.b	L213
L215
;				if (n) // 1 byte left
	tst.l	d0
	beq.b	L217
L216
;					*(((uint8*)d)++) = *(((uint8*)s)++);
	move.b	(a1),(a2)
L217
;				return dst;
	move.l	a0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L218
;		return Copy(dst, src, len);
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
	movem.l	(a7)+,d2-d4/a2/a3
	rts

	SECTION "_sysData__sysBASELIB:1",DATA

	XDEF	_sysData__sysBASELIB
_sysData__sysBASELIB
	dc.l	0

	SECTION "_msgbuff__sysBASELIB:1",DATA

	XDEF	_msgbuff__sysBASELIB
_msgbuff__sysBASELIB
	dc.l	0

	SECTION "Init__sysBASELIB_:0",CODE


;sint32 sysBASELIB::Init()
	XDEF	Init__sysBASELIB_
Init__sysBASELIB_
	move.l	a6,-(a7)
L222
;	IntuitionBase = (INTUITIONBASE*)OpenLibrary("intuition.library", 4
	move.l	_SysBase,a6
	moveq	#$28,d0
	move.l	#L221,a1
	jsr	-$228(a6)
	move.l	d0,_IntuitionBase
;	if (IntuitionBase == 0)
	move.l	_IntuitionBase,a0
	cmp.w	#0,a0
	bne.b	L224
L223
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts
L224
;	sysData = AllocVec((MAXALLOCS*sizeof(MEMINFO))+MESSAGEBUFFSIZE, ME
	move.l	_SysBase,a6
	move.l	#$2800,d0
	move.l	#$10001,d1
	jsr	-$2AC(a6)
	move.l	d0,_sysData__sysBASELIB
;	if (sysData == 0)
	move.l	_sysData__sysBASELIB,a0
	cmp.w	#0,a0
	bne.b	L226
L225
;		CloseLibrary((LIBRARY*)IntuitionBase);
	move.l	_IntuitionBase,a1
	move.l	_SysBase,a6
	jsr	-$19E(a6)
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	move.l	(a7)+,a6
	rts
L226
;	MEM::allocated = (MEMINFO*)sysData;
	move.l	_sysData__sysBASELIB,_allocated__MEM
;	msgbuff = (char*)((uint32)sysData+(MAXALLOCS*sizeof(MEMINFO)));
	move.l	_sysData__sysBASELIB,d0
	add.l	#$2000,d0
	move.l	d0,_msgbuff__sysBASELIB
;  return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

L221
	dc.b	'intuition.library',0

	SECTION "Done__sysBASELIB_:0",CODE


;void sysBASELIB::Done()
	XDEF	Done__sysBASELIB_
Done__sysBASELIB_
	move.l	a6,-(a7)
L227
;	MEM::FreeAll();
	jsr	FreeAll__MEM_
;	if (sysData)
	tst.l	_sysData__sysBASELIB
	beq.b	L229
L228
;		FreeVec(sysData);
	move.l	_sysData__sysBASELIB,a1
	move.l	_SysBase,a6
	jsr	-$2B2(a6)
;		sysData = 0;
	clr.l	_sysData__sysBASELIB
;		msgbuff = 0;
	clr.l	_msgbuff__sysBASELIB
L229
;	if (IntuitionBase)
	tst.l	_IntuitionBase
	beq.b	L231
L230
;		CloseLibrary((LIBRARY*)IntuitionBase);
	move.l	_IntuitionBase,a1
	move.l	_SysBase,a6
	jsr	-$19E(a6)
L231
;	IntuitionBase = 0;
	clr.l	_IntuitionBase
	move.l	(a7)+,a6
	rts

	SECTION "MessageBox__sysBASELIB__PcPcPce:0",CODE


;sint32 sysBASELIB::MessageBox(char* title, char* opts, char* body,..
	XDEF	MessageBox__sysBASELIB__PcPcPce
MessageBox__sysBASELIB__PcPcPce
L233	EQU	-$18
	link	a5,#L233
	movem.l	d2/a2/a3/a6,-(a7)
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L232
;	va_start(arglist,body)
	lea	$10(a5),a0
	move.l	a0,d2
	addq.l	#4,d2
;	vsprintf(msgbuff,body,arglist);
	move.l	d2,-(a7)
	move.l	$10(a5),-(a7)
	move.l	_msgbuff__sysBASELIB,-(a7)
	jsr	_vsprintf
	add.w	#$C,a7
;	EasyStruct mb = {sizeof(EasyStruct),0,title, msgbuff, o
	lea	-$18(a5),a0
	move.l	#$14,(a0)+
	clr.l	(a0)+
	move.l	a3,(a0)+
	move.l	_msgbuff__sysBASELIB,(a0)+
	move.l	a2,(a0)
;	return EasyRequest(0, &mb, 0, arglist);
	move.l	d2,-(a7)
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	lea	-$18(a5),a1
	sub.l	a2,a2
	move.l	a7,a3
	jsr	-$24C(a6)
	addq.w	#4,a7
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts

	SECTION "OpenDebugFile__sysBASELIB__Pc:0",CODE


;void sysBASELIB::OpenDebugFile(char *name)
	XDEF	OpenDebugFile__sysBASELIB__Pc
OpenDebugFile__sysBASELIB__Pc
	move.l	4(a7),a0
L236
;	sprintf(msgbuff,"Run >NIL: %s \"%s\" ", xFILE_VIEWER_APP, name);
	move.l	a0,-(a7)
	move.l	#L234,-(a7)
	move.l	#L235,-(a7)
	move.l	_msgbuff__sysBASELIB,-(a7)
	jsr	_sprintf
	add.w	#$10,a7
;	RunAsyncProgram(msgbuff);
	move.l	_msgbuff__sysBASELIB,a0
	move.l	a0,-(a7)
	jsr	_system
	addq.w	#4,a7
	rts

L235
	dc.b	'Run >NIL: %s ',$22,'%s',$22,' ',0
L234
	dc.b	'SYS:Utilities/Multiview',0

	END
