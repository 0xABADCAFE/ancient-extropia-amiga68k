
; Storm C Compiler
; extropialib:lib/Platforms/Amiga68k/BaseLib/Memory.cpp
	mc68030
	mc68881
	XREF	Copy__MEM__r8Pvr9Pvr0Ui
	XREF	MessageBox__sysBASELIB__PcPcPce
	XREF	_system
	XREF	_sprintf
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
	XREF	_maxAllocs__MEM
	XREF	_fpuPrecision__CPU
	XREF	_cpuNames__CPU

	SECTION "Round16__r23d:0",CODE

	rts

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
L56
;	if (!allocated || cnt == MAXALLOCS) 
	tst.l	_allocated__MEM
	beq.b	L58
L57
	move.l	_cnt__MEM,d2
	cmp.l	#$200,d2
	bne.b	L59
L58
;	if (!allocated || cnt == MAXAL
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L59
;	uint32 alignLen = ((uint32)align<8) ? 0 : align;
	cmp.l	#$8,d0
	bhs.b	L61
L60
	moveq	#0,d3
	bra.b	L62
L61
	move.l	d0,d3
L62
;	void* r = AllocVec((len+(alignLen<<1)), (zero?MEMF_PUBLIC|MEMF_CLE
	tst.w	d1
	beq.b	L64
L63
	move.l	#$10001,d1
	bra.b	L65
L64
	moveq	#1,d1
L65
	move.l	d3,d0
	moveq	#1,d2
	asl.l	d2,d0
	add.l	d4,d0
	move.l	_SysBase,a6
	jsr	-$2AC(a6)
	move.l	d0,a0
;	if (r)
	cmp.w	#0,a0
	beq	L73
L66
;		sint32 index = nextFree;
	move.l	_nextFree__MEM,d2
;		allocated[index].real = r;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a2
	move.l	a0,0(a2,d0.l)
;		if (alignLen)
	tst.l	d3
	beq.b	L68
L67
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
	bra.b	L69
L68
;			allocated[index].address = r;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a2
	move.l	a0,4(a2,d0.l)
L69
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
	bra.b	L71
L70
;			nextFree++;
	addq.l	#1,_nextFree__MEM
L71
	move.l	_nextFree__MEM,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	4(a1,d0.l),a0
	cmp.w	#0,a0
	bne.b	L70
L72
;		return allocated[index].address;
	asl.l	#4,d2
	move.l	_allocated__MEM,a1
	move.l	4(a1,d2.l),d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L73
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
L78
;	if (!allocated)	
	tst.l	_allocated__MEM
	bne.b	L80
L79
;	if (!allocated)	return;
	movem.l	(a7)+,d2/a2/a6
	rts
L80
;	if (ptr)
	cmp.w	#0,a1
	beq	L92
L81
;		sint32 index=-1
	moveq	#-1,d2
;		sint32 index=-1, found=0;
	moveq	#0,d0
;		while((found==0) && (index<MAXALLOCS))
	bra.b	L83
L82
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
L83
	tst.l	d0
	bne.b	L85
L84
	cmp.l	#$200,d2
	blt.b	L82
L85
;		if (!found)
	tst.l	d0
	bne.b	L87
L86
;			sysBASELIB::MessageBox("Debug", "Proceed", "MEM::F
	move.l	#L74,-(a7)
	move.l	#L75,-(a7)
	move.l	#L76,-(a7)
	jsr	MessageBox__sysBASELIB__PcPcPce
	add.w	#$C,a7
;			return;
	movem.l	(a7)+,d2/a2/a6
	rts
L87
;		if (!allocated[index].real)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	tst.l	0(a1,d0.l)
	bne.b	L89
L88
;			return;
	movem.l	(a7)+,d2/a2/a6
	rts
L89
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
	bge.b	L91
L90
;			nextFree = index;
	move.l	d2,_nextFree__MEM
L91
;		return;
	movem.l	(a7)+,d2/a2/a6
	rts
L92
;		sysBASELIB::MessageBox("Debug", "Proceed", "MEM::Fre
	move.l	#L77,-(a7)
	move.l	#L75,-(a7)
	move.l	#L76,-(a7)
	jsr	MessageBox__sysBASELIB__PcPcPce
	add.w	#$C,a7
	movem.l	(a7)+,d2/a2/a6
	rts

L76
	dc.b	'Debug',0
L74
	dc.b	'MEM::Free()',$A,'Address not recognised',0
L77
	dc.b	'MEM::Free()',$A,'Attempt to free null address',0
L75
	dc.b	'Proceed',0

	SECTION "DebugInfo__MEM_:0",CODE


;void MEM::DebugInfo()
	XDEF	DebugInfo__MEM_
DebugInfo__MEM_
L110	EQU	-$24
	link	a5,#L110
	movem.l	d2-d4/a2/a3/a6,-(a7)
L99
;	if (!allocated)
	tst.l	_allocated__MEM
	bne.b	L101
L100
;		return;
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L101
;	sint32 c=sprintf(sysBASELIB::MsgBuf(), "MEM Statistics\nsysBASE::s
	pea	$3000.w
	move.l	#L93,-(a7)
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
	bra.b	L105
L102
;		if (allocated[i].address)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	tst.l	4(a1,d0.l)
	beq.b	L104
L103
;			l = sprintf(sysBASELIB::MsgBuf()+c, "Block %d : 0x%08X [%10d]\
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	$C(a1,d0.l),-(a7)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	move.l	4(a1,d0.l),-(a7)
	move.l	d4,-(a7)
	move.l	#L94,-(a7)
	move.l	_msgbuff__sysBASELIB,a0
	pea	0(a0,d3.l)
	jsr	_sprintf
	add.w	#$14,a7
;			b++;
	addq.l	#1,d4
;			c+=l;
	add.l	d0,d3
L104
	addq.l	#1,d2
L105
	cmp.l	#$200,d2
	bge.b	L107
L106
	cmp.l	#$800,d3
	blt.b	L102
L107
;	if ((b+1) < cnt)
	addq.l	#1,d4
	cmp.l	_cnt__MEM,d4
	bge.b	L109
L108
;		l = sprintf(sysBASELIB::MsgBuf()+c, "\n<List Truncated>\n");
	move.l	#L95,-(a7)
	move.l	_msgbuff__sysBASELIB,a0
	pea	0(a0,d3.l)
	jsr	_sprintf
	addq.w	#$8,a7
;		c+= l;
	add.l	d0,d3
L109
;	sprintf(sysBASELIB::MsgBuf()+c, "\nTotal %d / %d block(s), %d byte
	move.l	_totSize__MEM,d0
	add.l	#$2000,d0
	add.l	#$1000,d0
	move.l	d0,-(a7)
	pea	$200.w
	move.l	_cnt__MEM,-(a7)
	move.l	#L96,-(a7)
	move.l	_msgbuff__sysBASELIB,a0
	pea	0(a0,d3.l)
	jsr	_sprintf
	add.w	#$14,a7
;	EasyStruct mb = {sizeof(EasyStruct),0,"Debug Info", sys
	lea	-$24(a5),a0
	move.l	#$14,(a0)+
	clr.l	(a0)+
	move.l	#L97,(a0)+
	move.l	_msgbuff__sysBASELIB,a1
	move.l	a1,(a0)+
	move.l	#L98,(a0)
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

L95
	dc.b	$A,'<List Truncated>',$A,0
L96
	dc.b	$A,'Total %d / %d block(s), %d bytes',0
L94
	dc.b	'Block %d : 0x%08X [%10d]',$A,0
L97
	dc.b	'Debug Info',0
L93
	dc.b	'MEM Statistics',$A,'sysBASE::sysData %d bytes',$A,$A,0
L98
	dc.b	'Proceed',0

	SECTION "FreeAll__MEM_:0",CODE


;void MEM::FreeAll()
	XDEF	FreeAll__MEM_
FreeAll__MEM_
	movem.l	d2-d4/a6,-(a7)
L114
;	if (!allocated)
	tst.l	_allocated__MEM
	bne.b	L116
L115
;		return;
	movem.l	(a7)+,d2-d4/a6
	rts
L116
;	sint32 freed = 0
	moveq	#0,d3
;	sint32 freed = 0, size=0;
	moveq	#0,d4
;	for (rsint32 i=0;
	moveq	#0,d2
	bra	L120
L117
;		if (allocated[i].real)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__MEM,a1
	tst.l	0(a1,d0.l)
	beq	L119
L118
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
L119
	addq.l	#1,d2
L120
	cmp.l	#$200,d2
	blt	L117
L121
;	if (freed)
	tst.l	d3
	beq.b	L123
L122
;		sysBASELIB::MessageBox("Debug Info","Proceed","MEM::
	move.l	d4,-(a7)
	move.l	d3,-(a7)
	move.l	#L111,-(a7)
	move.l	#L112,-(a7)
	move.l	#L113,-(a7)
	jsr	MessageBox__sysBASELIB__PcPcPce
	add.w	#$14,a7
L123
;	allocated = 0;
	clr.l	_allocated__MEM
	movem.l	(a7)+,d2-d4/a6
	rts

L113
	dc.b	'Debug Info',0
L111
	dc.b	'MEM::FreeAll()',$A,'Released %d block(s)',$A,'totalling %d bytes',$A
	dc.b	0
L112
	dc.b	'Proceed',0

	SECTION "Move__MEM__r8Pvr9Pvr0Ui:0",CODE


;void MEM::Move(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t 
	XDEF	Move__MEM__r8Pvr9Pvr0Ui
Move__MEM__r8Pvr9Pvr0Ui
	movem.l	d2-d4/a2,-(a7)
L124
;	if (dst==src) 
	cmp.l	a1,a0
	bne.b	L126
L125
;	if (dst==src) return;
	movem.l	(a7)+,d2-d4/a2
	rts
L126
;	if ((uint8*)dst>(uint8*)src)
	cmp.l	a1,a0
	bls	L159
L127
;		if (len<=((uint8*)dst-(uint8*)src))
	move.l	a0,d1
	sub.l	a1,d1
	cmp.l	d1,d0
	bhi.b	L129
L128
;			Copy(dst, src, len);
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
;			return;
	movem.l	(a7)+,d2-d4/a2
	rts
L129
;		if (((uint32)dst|(uint32)src)&1UL)
	move.l	a0,d1
	move.l	a1,d2
	or.l	d2,d1
	and.l	#1,d1
	beq.b	L134
L130
;			ruint8* s = (uint8*)src+len;
	add.l	d0,a1
;			ruint8* d = (uint8*)dst+len;
	add.l	d0,a0
;			rsint32 n = len+1;
	addq.l	#1,d0
;			while(--n)
	bra.b	L132
L131
;				*(--d) = *(--s);
	move.b	-(a1),-(a0)
L132
	subq.l	#1,d0
	tst.l	d0
	bne.b	L131
L133
;			return;
	movem.l	(a7)+,d2-d4/a2
	rts
L134
;			uint32 copyGap = (uint8*)dst-(uint8*)src;
	move.l	a0,d3
	sub.l	a1,d3
;			if (copyGap>7)
	cmp.l	#7,d3
	bls.b	L144
L135
;				copyGap &= (!3UL);
	moveq	#0,d3
;				rsint32 n = len;
;				ruint32 *s = (uint32*)src
;				ruint32 *s = (uint32*)src, *d = (
;				while(n>copyGap)
	bra.b	L140
L136
;					rsint32 i=1+(copyGap>>2);
	move.l	d3,d1
	moveq	#2,d2
	lsr.l	d2,d1
	addq.l	#1,d1
;					while (--i)
	bra.b	L138
L137
;						*d++ = *s++;
	move.l	(a1)+,(a0)+
L138
	subq.l	#1,d1
	tst.l	d1
	bne.b	L137
L139
;					n-=copyGap;
	sub.l	d3,d0
L140
	cmp.l	d3,d0
	bhi.b	L136
L141
;				if (n) // if remaining data, must be < copyGap thus not over
	tst.l	d0
	beq.b	L143
L142
;					Copy(d, s, n);
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
L143
;				return;
	movem.l	(a7)+,d2-d4/a2
	rts
L144
;			else if (copyGap>3)
	cmp.l	#3,d3
	bls.b	L153
L145
;				rsint32 n = len;
;				ruint32 *s = (uint32*)src
;				ruint32 *s = (uint32*)src, *d = (
;				while(n>4)
	bra.b	L147
L146
;					*d++ = *s++;
	move.l	(a1)+,(a0)+
;					n-=4;
	subq.l	#4,d0
L147
	cmp.l	#4,d0
	bgt.b	L146
L148
;				if (n) // 1 - 3 bytes left
	tst.l	d0
	beq.b	L152
L149
;					n++;
	addq.l	#1,d0
;					while(--n)
	bra.b	L151
L150
;						*(((uint8*)d)++) = *(((uint8*)s)++);
	move.b	(a1)+,(a0)+
L151
	subq.l	#1,d0
	tst.l	d0
	bne.b	L150
L152
;				return;
	movem.l	(a7)+,d2-d4/a2
	rts
L153
;				rsint32 n = len;
;				ruint16 *s = (uint16*)src
;				ruint16 *s = (uint16*)src, *d = (
;				while(n>2)
	bra.b	L155
L154
;					*d++ = *s++;
	move.w	(a1)+,(a0)+
;					n-=2;
	subq.l	#2,d0
L155
	cmp.l	#2,d0
	bgt.b	L154
L156
;				if (n) // 1 byte left
	tst.l	d0
	beq.b	L158
L157
;					*(((uint8*)d)++) = *(((uint8*)s)++);
	move.b	(a1),(a0)
L158
;				return;
	movem.l	(a7)+,d2-d4/a2
	rts
L159
;		Copy(dst, src, len);
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
	movem.l	(a7)+,d2-d4/a2
	rts

	END
