
; Storm C Compiler
; Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/ServiceLib/xResources.cpp
	mc68030
	mc68881
	XREF	Done__xTHREADABLE__T
	XREF	Init__xTHREADABLE__T
	XREF	Zero__MEM__PvUi
	XREF	_system
	XREF	op__leftshift__ostream__Td
	XREF	op__leftshift__ostream__TUj
	XREF	op__leftshift__ostream__Tj
	XREF	op__leftshift__ostream__TPCc
	XREF	op__leftshift__ostream__Tc
	XREF	opfx__ostream__T
	XREF	read__istream__TPci
	XREF	get__istream__TRc
	XREF	getline__istream__TPcic
	XREF	get__istream__TPcic
	XREF	op__rightshift__istream__TRc
	XREF	op__rightshift__istream__TPc
	XREF	doallocate__streambuf__T
	XREF	xsgetn__streambuf__TPci
	XREF	xsputn__streambuf__TPCci
	XREF	underflow__streambuf__T
	XREF	overflow__streambuf__Ti
	XREF	setbuf__streambuf__TPcUi
	XREF	sputn__streambuf__TPCci
	XREF	_0dt__streambuf__T
	XREF	userword__ios__Ti
	XREF	init__ios__TP09streambuf
	XREF	_strncpy
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_basefield__ios
	XREF	_adjustfield__ios
	XREF	_floatfield__ios
	XREF	_aNextBit__ios
	XREF	_aNextWord__ios
	XREF	_cin
	XREF	_cout
	XREF	_cerr
	XREF	_clog
	XREF	_st
	XREF	_gxSt
	XREF	_errSev__xBASELIB
	XREF	_errTbl__xBASELIB
	XREF	_SysBase
	XREF	_IntuitionBase
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
	XREF	_GfxBase
	XREF	_TimerBase

	SECTION "_0ct__streampos__T:0",CODE

	rts

	SECTION "LinkFront__xCHAINABLE__TP06xCHAIN:0",CODE


;sint32 xCHAINABLE::LinkFront(xCHAIN* c)
	XDEF	LinkFront__xCHAINABLE__TP06xCHAIN
LinkFront__xCHAINABLE__TP06xCHAIN
	movem.l	a2/a3/a6,-(a7)
	move.l	$14(a7),a2
	move.l	$10(a7),a3
L156
;	if (chain)	
	move.l	a3,a1
	tst.l	$8(a1)
	beq.b	L158
L157
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L158
;	if (!c)			
	cmp.w	#0,a2
	bne.b	L160
L159
	move.l	#-$3020002,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L160
;	AddHead(CASTLIST(c), CASTNODE(this));
	move.l	_SysBase,a6
	move.l	a2,a0
	move.l	a3,a1
	jsr	-$F0(a6)
;	c->items++;
	move.l	a2,a0
	move.l	$C(a0),d0
	addq.l	#1,d0
	move.l	a2,a0
	move.l	d0,$C(a0)
;	chain = c;
	move.l	a3,a1
	move.l	a2,$8(a1)
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "LinkEnd__xCHAINABLE__TP06xCHAIN:0",CODE


;sint32 xCHAINABLE::LinkEnd(xCHAIN* c)
	XDEF	LinkEnd__xCHAINABLE__TP06xCHAIN
LinkEnd__xCHAINABLE__TP06xCHAIN
	movem.l	a2/a3/a6,-(a7)
	move.l	$14(a7),a2
	move.l	$10(a7),a3
L161
;	if (chain)	
	move.l	a3,a1
	tst.l	$8(a1)
	beq.b	L163
L162
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L163
;	if (!c)			
	cmp.w	#0,a2
	bne.b	L165
L164
	move.l	#-$3020002,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L165
;	AddTail(CASTLIST(c), CASTNODE(this));
	move.l	_SysBase,a6
	move.l	a2,a0
	move.l	a3,a1
	jsr	-$F6(a6)
;	c->items++;
	move.l	a2,a0
	move.l	$C(a0),d0
	addq.l	#1,d0
	move.l	a2,a0
	move.l	d0,$C(a0)
; chain = c;
	move.l	a3,a1
	move.l	a2,$8(a1)
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "LinkBefore__xCHAINABLE__TP06xCHAINP10xCHAINABLE:0",CODE


;sint32 xCHAINABLE::LinkBefore(xCHAIN* c, xCHAINABLE* x)
	XDEF	LinkBefore__xCHAINABLE__TP06xCHAINP10xCHAINABLE
LinkBefore__xCHAINABLE__TP06xCHAINP10xCHAINABLE
L176	EQU	-4
	link	a5,#L176
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a5),a2
	move.l	$C(a5),a3
L166
;	if (chain)					
	move.l	$8(a5),a1
	tst.l	$8(a1)
	beq.b	L168
L167
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L168
;	if (!c || !x)				
	cmp.w	#0,a3
	beq.b	L170
L169
	cmp.w	#0,a2
	bne.b	L171
L170
	move.l	#-$3020002,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L171
;	if (x==this)				
	cmp.l	$8(a5),a2
	bne.b	L173
L172
	move.l	#-$3020003,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L173
;	if (x->chain != c)	
	move.l	$8(a2),a0
	cmp.l	a3,a0
	beq.b	L175
L174
	move.l	#-$3020005,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L175
;	Insert(CASTLIST(c), CASTNODE(this), CASTNODE(x));
	move.l	_SysBase,a6
	move.l	a3,a0
	move.l	$8(a5),a1
	jsr	-$EA(a6)
;	c->items++;
	move.l	a3,a0
	move.l	$C(a0),d0
	addq.l	#1,d0
	move.l	a3,a0
	move.l	d0,$C(a0)
; chain = c;
	move.l	$8(a5),a1
	move.l	a3,$8(a1)
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts

	SECTION "UnLink__xCHAINABLE__T:0",CODE


;sint32 xCHAINABLE::UnLink()
	XDEF	UnLink__xCHAINABLE__T
UnLink__xCHAINABLE__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L177
;	if (!chain) 
	move.l	a2,a1
	tst.l	$8(a1)
	bne.b	L179
L178
	move.l	#-$3050000,d0
	movem.l	(a7)+,a2/a6
	rts
L179
;	::Remove(CASTNODE(this));
	move.l	_SysBase,a6
	move.l	a2,a1
	jsr	-$FC(a6)
;	chain->items--;
	move.l	a2,a1
	move.l	$8(a1),a0
	subq.l	#1,$C(a0)
; chain = NOTSET;
	move.l	a2,a1
	clr.l	$8(a1)
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "_main__xTHREADABLE:1",DATA

	XDEF	_main__xTHREADABLE
_main__xTHREADABLE
	dc.l	0

	SECTION "_threadCnt__xTHREADABLE:1",DATA

	XDEF	_threadCnt__xTHREADABLE
_threadCnt__xTHREADABLE
	dc.l	1

	SECTION "Access__xTHREADABLE__T:0",CODE


;uint8 xTHREADABLE::Access()
	XDEF	Access__xTHREADABLE__T
Access__xTHREADABLE__T
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a7),a3
L182
;	register Task *t = FindTask(NOTSET);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	d0,a0
;	if (flags & ACTIVE)
	move.l	a3,a1
	move.l	(a1),d0
	and.l	#1,d0
	beq.b	L185
L183
;		if (t==&(thread->pr_Task))
	move.l	a3,a2
	cmp.l	$30(a2),a0
	bne.b	L185
L184
	moveq	#1,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L185
;	if (t==parent)
	move.l	a3,a2
	cmp.l	$34(a2),a0
	bne.b	L187
L186
	moveq	#2,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L187
;	else if (t==sysBASELIB::main)
	cmp.l	_main__sysBASELIB,a0
	bne.b	L189
L188
	moveq	#3,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L189
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "AllowModify__xTHREADABLE__T:0",CODE


;sint32 xTHREADABLE::AllowModify()
	XDEF	AllowModify__xTHREADABLE__T
AllowModify__xTHREADABLE__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L190
;	switch(Access())
	move.l	a2,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	cmp.b	#2,d0
	beq.b	L192
	bhi.b	L199
	cmp.b	#1,d0
	beq.b	L191
	bra.b	L198
L199
	cmp.b	#3,d0
	beq.b	L195
	bra.b	L198
;		
L191
	move.l	#-$3050007,d0
	move.l	(a7)+,a2
	rts
L192
;		case xTHREAD_PARENT:	if (flags & ACTIVE)	
	move.l	(a2),d0
	and.l	#1,d0
	beq.b	L194
L193
	move.l	#-$3050004,d0
	move.l	(a7)+,a2
	rts
L194
	moveq	#0,d0
	move.l	(a7)+,a2
	rts
L195
;		case xTHREAD_MAIN:		if (flags & ACTIVE)	
	move.l	(a2),d0
	and.l	#1,d0
	beq.b	L197
L196
	move.l	#-$3050004,d0
	move.l	(a7)+,a2
	rts
L197
	moveq	#0,d0
	move.l	(a7)+,a2
	rts
L198
	move.l	#-$3050007,d0
	move.l	(a7)+,a2
	rts

	SECTION "Locate__xTHREADABLE_:0",CODE


;xTHREADABLE* xTHREADABLE::Locate()
	XDEF	Locate__xTHREADABLE_
Locate__xTHREADABLE_
	move.l	a6,-(a7)
L200
;	register Task *t = FindTask(NOTSET);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	d0,a0
;	if (t->tc_UserData)
	tst.l	$58(a0)
	beq.b	L203
L201
;		register THREADNODE* i = (THREADNODE*)(t->tc_UserData);
	move.l	$58(a0),a0
;		if (i->id == xTHREAD_IDTAG)
	move.l	(a0),d0
	cmp.l	#$58534C54,d0
	bne.b	L203
L202
	move.l	4(a0),d0
	move.l	(a7)+,a6
	rts
L203
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

	SECTION "Stack__xTHREADABLE__TUj:0",CODE


;sint32 xTHREADABLE::Stack(uint32 size)
	XDEF	Stack__xTHREADABLE__TUj
Stack__xTHREADABLE__TUj
	movem.l	d2/d3/a2,-(a7)
	move.l	$14(a7),d3
	move.l	$10(a7),a2
L204
;	if (AllowModify()==OK)
	move.l	a2,-(a7)
	jsr	AllowModify__xTHREADABLE__T
	addq.w	#4,a7
	tst.l	d0
	bne.b	L212
L205
;		stackSize = ClipInt(size, xTHREAD_MIN_STACK, xTHREAD_MAX_STACK);
	move.l	#$100000,d2
	move.l	#$800,d1
	move.l	d3,d0
	cmp.l	d1,d0
	bge.b	L207
L206
	move.l	d1,d0
	bra.b	L211
L207
	cmp.l	d2,d0
	ble.b	L209
L208
	move.l	d2,d0
L209
L210
L211
	move.l	d0,4(a2)
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L212
	move.l	#-$3050007,d0
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "Priority__xTHREADABLE__Tj:0",CODE


;sint32 xTHREADABLE::Priority(sint32 pri)
	XDEF	Priority__xTHREADABLE__Tj
Priority__xTHREADABLE__Tj
	movem.l	d2/d3/a6,-(a7)
	move.l	$14(a7),d3
	move.l	$10(a7),a6
L213
;	if (Access()!=xTHREAD_UNKNOWN)
	move.l	a6,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	tst.b	d0
	beq.b	L223
L214
;		priority = ClipInt(pri, xTHREAD_MIN_PRI, xTHREAD_MAX_PRI);
	moveq	#2,d2
	move.l	#-$80,d1
	move.l	d3,d0
	cmp.l	d1,d0
	bge.b	L216
L215
	move.l	d1,d0
	bra.b	L220
L216
	cmp.l	d2,d0
	ble.b	L218
L217
	move.l	d2,d0
L218
L219
L220
	move.l	d0,$8(a6)
;		if (flags & ACTIVE)
	move.l	(a6),d0
	and.l	#1,d0
	beq.b	L222
L221
;			SetTaskPri(&thread->pr_Task, priority);
	move.l	$8(a6),d0
	move.l	$30(a6),a1
	move.l	_SysBase,a6
	jsr	-$12C(a6)
L222
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a6
	rts
L223
	move.l	#-$3050007,d0
	movem.l	(a7)+,d2/d3/a6
	rts

	SECTION "WaitForThread__xTHREADABLE__T:0",CODE


;sint32 xTHREADABLE::WaitForThread()
	XDEF	WaitForThread__xTHREADABLE__T
WaitForThread__xTHREADABLE__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L224
;	switch(Access())
	move.l	a2,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	cmp.b	#2,d0
	beq.b	L225
	cmp.b	#3,d0
	beq.b	L231
	bra	L237
;		
L225
;/////////////////
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$1000,d0
	beq.b	L227
L226
	move.l	#-$3050000,d0
	movem.l	(a7)+,a2/a6
	rts
L227
;			flags |= PARENTWAITING;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$4000,d0
	move.l	a2,a0
	move.l	d0,(a0)
;			while (flags & PARENTWAITING)
	bra.b	L229
L228
;				Wait((uint32)SIGNAL_WAIT);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
L229
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$4000,d0
	bne.b	L228
L230
;			
	bra.b	L238
L231
;			if (flags & WAITFORMAIN)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$2000,d0
	beq.b	L233
L232
	move.l	#-$3050000,d0
	movem.l	(a7)+,a2/a6
	rts
L233
;			flags |= MAINWAITING;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$8000,d0
	move.l	a2,a0
	move.l	d0,(a0)
;			while (flags & MAINWAITING)
	bra.b	L235
L234
;				Wait((uint32)SIGNAL_WAIT);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
L235
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$8000,d0
	bne.b	L234
L236
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts
L237
	move.l	#-$3050007,d0
	movem.l	(a7)+,a2/a6
	rts
L238
;			
	movem.l	(a7)+,a2/a6
	rts

	SECTION "AcknowledgeThread__xTHREADABLE__T:0",CODE


;sint32 xTHREADABLE::AcknowledgeThread()
	XDEF	AcknowledgeThread__xTHREADABLE__T
AcknowledgeThread__xTHREADABLE__T
	move.l	a6,-(a7)
	move.l	$8(a7),a6
L239
;	switch(Access())
	move.l	a6,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	cmp.b	#2,d0
	beq.b	L240
	cmp.b	#3,d0
	beq.b	L243
	bra.b	L246
;		
L240
;			if (flags & WAITFORPARENT)
	move.l	(a6),d0
	and.l	#$1000,d0
	beq.b	L242
L241
;				flags &= ~WAITFORPARENT;
	and.l	#-$1001,(a6)
;				Signal(&thread->pr_Task, (uint32)SIGNAL_WAIT);
	move.l	$30(a6),a1
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$144(a6)
	moveq	#0,d0
	move.l	(a7)+,a6
	rts
L242
	move.l	#-$3050000,d0
	move.l	(a7)+,a6
	rts
L243
;			if (flags & (WAITFORMAIN|WAITFORPARENT))
	move.l	(a6),d0
	and.l	#$3000,d0
	beq.b	L245
L244
;				flags &= ~(WAITFORMAIN|WAITFORPARENT);
	and.l	#-$3001,(a6)
;				Signal(&thread->pr_Task, (uint32)SIGNAL_WAIT);
	move.l	$30(a6),a1
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$144(a6)
	moveq	#0,d0
	move.l	(a7)+,a6
	rts
L245
	move.l	#-$3050000,d0
	move.l	(a7)+,a6
	rts
L246
	move.l	#-$3050007,d0
	move.l	(a7)+,a6
	rts

	SECTION "Acknowledge__xTHREADABLE__T:0",CODE


;sint32 xTHREADABLE::Acknowledge()
	XDEF	Acknowledge__xTHREADABLE__T
Acknowledge__xTHREADABLE__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L247
;	if (Access()!=xTHREAD_SELF)
	move.l	a2,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	cmp.b	#1,d0
	beq.b	L249
L248
	move.l	#-$3050007,d0
	movem.l	(a7)+,a2/a6
	rts
L249
;	if (flags & PARENTWAITING)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$4000,d0
	beq.b	L251
L250
;		flags &= ~PARENTWAITING;
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#-$4001,d0
	move.l	a2,a0
	move.l	d0,(a0)
;		Signal(parent, (uint32)SIGNAL_WAIT);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$8000,d0
	move.l	$34(a0),a1
	jsr	-$144(a6)
L251
;	if (flags & MAINWAITING)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$8000,d0
	beq.b	L253
L252
;		flags &= ~MAINWAITING;
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#-$8001,d0
	move.l	a2,a0
	move.l	d0,(a0)
;		Signal(sysBASELIB::main, (uint32)SIGNAL_WAIT);
	move.l	_main__sysBASELIB,a1
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$144(a6)
L253
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "WaitForParent__xTHREADABLE__T:0",CODE


;sint32 xTHREADABLE::WaitForParent()
	XDEF	WaitForParent__xTHREADABLE__T
WaitForParent__xTHREADABLE__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L254
;	if (Access()!=xTHREAD_SELF)
	move.l	a2,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	cmp.b	#1,d0
	beq.b	L256
L255
	move.l	#-$3050007,d0
	movem.l	(a7)+,a2/a6
	rts
L256
;	if (flags & PARENTWAITING)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$4000,d0
	beq.b	L258
L257
	move.l	#-$3050000,d0
	movem.l	(a7)+,a2/a6
	rts
L258
;	flags |= WAITFORPARENT;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$1000,d0
	move.l	a2,a0
	move.l	d0,(a0)
;	while (flags & WAITFORPARENT)
	bra.b	L261
L259
;		Wait((uint32)SIGNAL_WAIT);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
;		if (RemoveReq())
	move.l	(a2),d0
	and.l	#$30000,d0
	sne	d0
	and.l	#1,d0
	tst.w	d0
	beq.b	L261
L260
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts
L261
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$1000,d0
	bne.b	L259
L262
;			return 
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "SignalParent__xTHREADABLE__TUj:0",CODE


;void xTHREADABLE::SignalParent(uint32 signals)
	XDEF	SignalParent__xTHREADABLE__TUj
SignalParent__xTHREADABLE__TUj
	movem.l	d2/a6,-(a7)
	move.l	$10(a7),d2
	move.l	$C(a7),a6
L263
;	if (Access()!=xTHREAD_SELF)
	move.l	a6,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	cmp.b	#1,d0
	beq.b	L265
L264
	movem.l	(a7)+,d2/a6
	rts
L265
;	Signal(parent, signals);
	move.l	$34(a6),a1
	move.l	_SysBase,a6
	move.l	d2,d0
	jsr	-$144(a6)
	movem.l	(a7)+,d2/a6
	rts

	SECTION "SignalThread__xTHREADABLE__TUj:0",CODE


;void xTHREADABLE::SignalThread(uint32 signals)
	XDEF	SignalThread__xTHREADABLE__TUj
SignalThread__xTHREADABLE__TUj
	movem.l	d2/a6,-(a7)
	move.l	$10(a7),d2
	move.l	$C(a7),a6
L266
;	if (Access()!=xTHREAD_PARENT)
	move.l	a6,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	cmp.b	#2,d0
	beq.b	L268
L267
	movem.l	(a7)+,d2/a6
	rts
L268
;	Signal(&thread->pr_Task, signals);
	move.l	$30(a6),a1
	move.l	_SysBase,a6
	move.l	d2,d0
	jsr	-$144(a6)
	movem.l	(a7)+,d2/a6
	rts

	SECTION "Launch__xTHREADABLE__T:0",CODE


;sint32 xTHREADABLE::Launch()
	XDEF	Launch__xTHREADABLE__T
Launch__xTHREADABLE__T
L279	EQU	-$44
	link	a5,#L279
	movem.l	a2/a3/a6,-(a7)
	move.l	$8(a5),a3
L269
;	sint32 r = AllowModify();
	move.l	a3,-(a7)
	jsr	AllowModify__xTHREADABLE__T
	addq.w	#4,a7
;	if (r != OK)
	tst.l	d0
	beq.b	L271
L270
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L271
;	if (stackSize < xTHREAD_MIN_STACK)
	move.l	a3,a0
	move.l	4(a0),d0
	cmp.l	#$800,d0
	bhs.b	L273
L272
	move.l	#-$3050008,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L273
;	TagItem threadTags[] = {
	lea	-$44(a5),a0
	move.l	#$800003EB,(a0)+
	move.l	#Initialise__xTHREADABLE_,(a0)+
	move.l	#$800003F3,(a0)+
	move.l	a3,a1
	move.l	4(a1),(a0)+
	move.l	#$800003F5,(a0)+
	move.l	a3,a1
	move.l	$8(a1),(a0)+
	move.l	#$800003F4,(a0)+
	lea	$10(a3),a1
	move.l	a1,(a0)+
	move.l	#$80000400,(a0)+
	move.l	#Finalise__xTHREADABLE_,(a0)+
	move.l	#$800003EA,(a0)+
	clr.l	(a0)+
	move.l	#$800003EF,(a0)+
	move.l	#1,(a0)+
	clr.l	(a0)+
	clr.l	(a0)
;	Forbid();
	move.l	_SysBase,a6
	jsr	-$84(a6)
;	thread = CreateNewProc(threadTags);
	lea	-$44(a5),a0
	move.l	_DOSBase,a6
	move.l	a0,d1
	jsr	-$1F2(a6)
	move.l	a3,a1
	move.l	d0,$30(a1)
;	if (thread == NOTSET)
	move.l	a3,a1
	move.l	$30(a1),a0
	cmp.w	#0,a0
	bne.b	L275
L274
;		Permit();
	move.l	_SysBase,a6
	jsr	-$8A(a6)
	move.l	#-$3050005,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L275
;		thread->pr_Task.tc_UserData = (void*)&taskHandle;
	move.l	a3,a2
	lea	$40(a3),a1
	move.l	$30(a2),a0
	move.l	a1,$58(a0)
;		thread->pr_Task.tc_ExceptCode = (void*)&Finalise;
	move.l	a3,a1
	move.l	$30(a1),a0
	move.l	#Finalise__xTHREADABLE_,$2A(a0)
;		thread->pr_Task.tc_SigExcept = SIGNAL_EXPT;
	move.l	a3,a1
	move.l	$30(a1),a0
	move.l	#$4000,$1E(a0)
;	Permit();
	move.l	_SysBase,a6
	jsr	-$8A(a6)
;	while (flags & INITCOMPLETED==0)
	bra.b	L277
L276
;		Wait((uint32)SIGNAL_WAIT);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
L277
	move.l	a3,a0
L278
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts

	SECTION "Kill__xTHREADABLE__T:0",CODE


;sint32 xTHREADABLE::Kill()
	XDEF	Kill__xTHREADABLE__T
Kill__xTHREADABLE__T
	movem.l	d2/d3/a2/a6,-(a7)
	move.l	$14(a7),a2
L280
;	sint32 r = Access();
	move.l	a2,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	moveq	#0,d2
	move.b	d0,d2
;	if (r != xTHREAD_PARENT && r != xTHREAD_MAIN)
	cmp.l	#2,d2
	beq.b	L283
L281
	cmp.l	#3,d2
	beq.b	L283
L282
	move.l	#-$3050007,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L283
;	if (flags & ACTIVE)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#1,d0
	beq	L294
L284
;		if (thread)
	move.l	a2,a1
	tst.l	$30(a1)
	beq	L294
L285
;			Forbid();
	move.l	_SysBase,a6
	jsr	-$84(a6)
;			uint32 s = thread->pr_Task.tc_State;
	move.l	a2,a1
	move.l	$30(a1),a0
	moveq	#0,d3
	move.b	$F(a0),d3
;			Permit();
	move.l	_SysBase,a6
	jsr	-$8A(a6)
;			if (s != TS_REMOVED)
	cmp.l	#6,d3
	beq.b	L293
L286
;				if (r==xTHREAD_PARENT)
	cmp.l	#2,d2
	bne.b	L288
L287
;					flags |= PARENTKILLREQ;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$40000,d0
	move.l	a2,a0
	move.l	d0,(a0)
	bra.b	L289
L288
;					flags |= MAINKILLREQ;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$80000,d0
	move.l	a2,a0
	move.l	d0,(a0)
L289
;				Signal(&thread->pr_Task, (uint32)SIGNAL_EXPT);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$4000,d0
	move.l	$30(a0),a1
	jsr	-$144(a6)
;				while (flags & DONECOMPLETED==0)
	bra.b	L291
L290
;					Wait((uint32)SIGNAL_WAIT);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
L291
	move.l	a2,a0
L292
;				Delay(5);
	move.l	_DOSBase,a6
	moveq	#5,d1
	jsr	-$C6(a6)
L293
;			thread = NOTSET;
	move.l	a2,a1
	clr.l	$30(a1)
L294
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "ShutDown__xTHREADABLE__T:0",CODE


;sint32 xTHREADABLE::ShutDown()
	XDEF	ShutDown__xTHREADABLE__T
ShutDown__xTHREADABLE__T
	movem.l	d2/d3/a2/a6,-(a7)
	move.l	$14(a7),a2
L295
;	sint32 r = Access();
	move.l	a2,-(a7)
	jsr	Access__xTHREADABLE__T
	addq.w	#4,a7
	moveq	#0,d2
	move.b	d0,d2
;	if (r != xTHREAD_PARENT && r != xTHREAD_MAIN)
	cmp.l	#2,d2
	beq.b	L298
L296
	cmp.l	#3,d2
	beq.b	L298
L297
	move.l	#-$3050007,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L298
;	if (flags & ACTIVE)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#1,d0
	beq	L310
L299
;		if (thread)
	move.l	a2,a1
	tst.l	$30(a1)
	beq	L310
L300
;			Forbid();
	move.l	_SysBase,a6
	jsr	-$84(a6)
;			uint32 s = thread->pr_Task.tc_State;
	move.l	a2,a1
	move.l	$30(a1),a0
	moveq	#0,d3
	move.b	$F(a0),d3
;			Permit();
	move.l	_SysBase,a6
	jsr	-$8A(a6)
;			if (s != TS_REMOVED)
	cmp.l	#6,d3
	beq.b	L308
L301
;				if (r==xTHREAD_PARENT)
	cmp.l	#2,d2
	bne.b	L303
L302
;					flags |= PARENTREMOVEREQ;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$10000,d0
	move.l	a2,a0
	move.l	d0,(a0)
	bra.b	L304
L303
;					flags |= MAINREMOVEREQ;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$20000,d0
	move.l	a2,a0
	move.l	d0,(a0)
L304
;				Signal(&thread->pr_Task, (uint32)SIGNAL_EXIT);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$1000,d0
	move.l	$30(a0),a1
	jsr	-$144(a6)
;				while (flags & DONECOMPLETED==0)
	bra.b	L306
L305
;					Wait((uint32)SIGNAL_WAIT);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
L306
	move.l	a2,a0
L307
;				Delay(5);
	move.l	_DOSBase,a6
	moveq	#5,d1
	jsr	-$C6(a6)
	bra.b	L309
L308
;				flags &= ~ACTIVE;
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#-2,d0
	move.l	a2,a0
	move.l	d0,(a0)
L309
;			thread = NOTSET;
	move.l	a2,a1
	clr.l	$30(a1)
L310
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "_0ct__xTHREADABLE__TPCcUjjs:0",CODE


;xTHREADABLE::xTHREADABLE(const char *threadName, uint32
	XDEF	_0ct__xTHREADABLE__TPCcUjjs
_0ct__xTHREADABLE__TPCcUjjs
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.w	$30(a7),d3
	move.l	$2C(a7),d4
	move.l	$28(a7),d5
	move.l	$20(a7),a2
	move.l	$24(a7),a3
L311
	move.l	a2,a0
	clr.l	(a0)
	move.l	a2,a0
	clr.l	$C(a0)
	move.l	a2,a1
	clr.l	$30(a1)
	move.l	a2,a1
	clr.l	$34(a1)
;	parent = FindTask(NOTSET);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a2,a1
	move.l	d0,$34(a1)
;	flags |= (parent == sysBASELIB::main) ? PARENTISMAIN : 0;
	move.l	a2,a1
	move.l	$34(a1),a0
	cmp.l	_main__sysBASELIB,a0
	bne.b	L313
L312
	move.l	#$100000,d1
	bra.b	L314
L313
	moveq	#0,d1
L314
	move.l	a2,a0
	move.l	(a0),d0
	or.l	d1,d0
	move.l	a2,a0
	move.l	d0,(a0)
;	if (threadName)
	cmp.w	#0,a3
	beq.b	L316
L315
;		strncpy(name, threadName, 30);
	pea	$1E.w
	move.l	a3,-(a7)
	pea	$10(a2)
	jsr	_strncpy
	add.w	#$C,a7
L316
;	stackSize				= ClipInt(stack, xTHREAD_MIN_STACK, xTHREAD_MAX_STACK)
	move.l	#$100000,d2
	move.l	#$800,d1
	move.l	d5,d0
	cmp.l	d1,d0
	bge.b	L318
L317
	move.l	d1,d0
	bra.b	L322
L318
	cmp.l	d2,d0
	ble.b	L320
L319
	move.l	d2,d0
L320
L321
L322
	move.l	a2,a0
	move.l	d0,4(a0)
;	priority				= ClipInt(pri, xTHREAD_MIN_PRI, xTHREAD_MAX_PRI);
	moveq	#2,d2
	move.l	#-$80,d1
	move.l	d4,d0
	cmp.l	d1,d0
	bge.b	L324
L323
	move.l	d1,d0
	bra.b	L328
L324
	cmp.l	d2,d0
	ble.b	L326
L325
	move.l	d2,d0
L326
L327
L328
	move.l	a2,a0
	move.l	d0,$8(a0)
;	taskHandle.id		= xTHREAD_IDTAG;
	move.l	a2,a0
	move.l	#$58534C54,$40(a0)
;	taskHandle.self = this;
	move.l	a2,a1
	move.l	a2,$44(a1)
;	if (start)
	tst.w	d3
	beq.b	L330
L329
;		Launch();
	move.l	a2,-(a7)
	jsr	Launch__xTHREADABLE__T
	addq.w	#4,a7
L330
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts

	SECTION "Initialise__xTHREADABLE_:0",CODE


;void xTHREADABLE::Initialise()
	XDEF	Initialise__xTHREADABLE_
Initialise__xTHREADABLE_
	movem.l	a2/a6,-(a7)
L331
;	xTHREADABLE* t = Locate();
	jsr	Locate__xTHREADABLE_
	move.l	d0,a2
;	if (t == NOTSET)
	move.l	a2,a0
	cmp.w	#0,a0
	bne.b	L333
L332
	movem.l	(a7)+,a2/a6
	rts
L333
;	t->flags |= ACTIVE|INITCOMPLETED;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$200001,d0
	move.l	a2,a0
	move.l	d0,(a0)
;	Signal(t->parent, (uint32)SIGNAL_WAIT);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$8000,d0
	move.l	$34(a0),a1
	jsr	-$144(a6)
;  t->Init();
	move.l	a2,a1
	move.l	$48(a1),a0
	move.l	a2,d0
	add.l	$C(a0),d0
	move.l	d0,-(a7)
	move.l	$8(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	movem.l	(a7)+,a2/a6
	rts

	SECTION "Finalise__xTHREADABLE_:0",CODE


;void xTHREADABLE::Finalise()
	XDEF	Finalise__xTHREADABLE_
Finalise__xTHREADABLE_
	movem.l	a2/a6,-(a7)
L334
;  xTHREADABLE *t = Locate();
	jsr	Locate__xTHREADABLE_
	move.l	d0,a2
;  if (t == NOTSET)
	move.l	a2,a0
	cmp.w	#0,a0
	bne.b	L336
L335
	movem.l	(a7)+,a2/a6
	rts
L336
;	Forbid();
	move.l	_SysBase,a6
	jsr	-$84(a6)
;		(t->thread)->pr_Task.tc_SigExcept = 0;
	move.l	a2,a1
	move.l	$30(a1),a0
	clr.l	$1E(a0)
;		(t->thread)->pr_Task.tc_ExceptCode = NOTSET;
	move.l	a2,a1
	move.l	$30(a1),a0
	clr.l	$2A(a0)
;	Permit();
	move.l	_SysBase,a6
	jsr	-$8A(a6)
;  t->result	= t->Done();
	move.l	a2,a1
	move.l	$48(a1),a0
	move.l	a2,d0
	add.l	4(a0),d0
	move.l	d0,-(a7)
	move.l	(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	a2,a0
	move.l	d0,$C(a0)
;	t->flags	|= FINISHED|DONECOMPLETED;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$400004,d0
	move.l	a2,a0
	move.l	d0,(a0)
;	t->flags	&= ~ACTIVE;
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#-2,d0
	move.l	a2,a0
	move.l	d0,(a0)
;	if (t->flags & REMOVE)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$30000,d0
	beq	L344
L337
;		t->flags |= REMOVED;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$20,d0
	move.l	a2,a0
	move.l	d0,(a0)
;		if (t->parent == sysBASELIB::main)
	move.l	a2,a1
	move.l	$34(a1),a0
	cmp.l	_main__sysBASELIB,a0
	bne.b	L339
L338
;			Signal(sysBASELIB::main, (uint32)SIGNAL_WAIT);
	move.l	_main__sysBASELIB,a1
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$144(a6)
	bra.b	L343
L339
;			if (t->flags & (PARENTREMOVEREQ | PARENTKILLREQ))
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$50000,d0
	beq.b	L341
L340
;				Signal(t->parent, (uint32)SIGNAL_WAIT);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$8000,d0
	move.l	$34(a0),a1
	jsr	-$144(a6)
L341
;			if (t->flags & (MAINREMOVEREQ | MAINKILLREQ))
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$A0000,d0
	beq.b	L343
L342
;				Signal(sysBASELIB::main, (uint32)SIGNAL_WAIT);
	move.l	_main__sysBASELIB,a1
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$144(a6)
L343
	bra	L352
L344
;	else if (t->flags & KILL)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$C0000,d0
	beq	L352
L345
;		t->flags |= KILLED;
	move.l	a2,a0
	move.l	(a0),d0
	or.l	#$10,d0
	move.l	a2,a0
	move.l	d0,(a0)
;		if (t->parent == sysBASELIB::main)
	move.l	a2,a1
	move.l	$34(a1),a0
	cmp.l	_main__sysBASELIB,a0
	bne.b	L347
L346
;			Signal(sysBASELIB::main, (uint32)SIGNAL_WAIT);
	move.l	_main__sysBASELIB,a1
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$144(a6)
	bra.b	L351
L347
;			if (t->flags & PARENTKILLREQ)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$40000,d0
	beq.b	L349
L348
;				Signal(t->parent, (uint32)SIGNAL_WAIT);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$8000,d0
	move.l	$34(a0),a1
	jsr	-$144(a6)
L349
;			if (t->flags & MAINKILLREQ)
	move.l	a2,a0
	move.l	(a0),d0
	and.l	#$80000,d0
	beq.b	L351
L350
;					Signal(sysBASELIB::main, (uint32)SIGNAL_WAIT);
	move.l	_main__sysBASELIB,a1
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$144(a6)
L351
;		RemTask(NOTSET);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$120(a6)
L352
	movem.l	(a7)+,a2/a6
	rts

	SECTION "WaitLock__xLOCKABLE__T:0",CODE


;sint32 xLOCKABLE::WaitLock()
	XDEF	WaitLock__xLOCKABLE__T
WaitLock__xLOCKABLE__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L353
;	if (destructor)
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L356
L354
;		if (destructor != FindTask(NOTSET));
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
L355
	move.l	#-$3050009,d0
	movem.l	(a7)+,a2/a6
	rts
L356
;	ObtainSemaphore(&lock);
	move.l	_SysBase,a6
	lea	$8(a2),a0
	jsr	-$234(a6)
;	if (destructor)
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L358
L357
;		ReleaseSemaphore(&lock);
	move.l	_SysBase,a6
	lea	$8(a2),a0
	jsr	-$23A(a6)
	move.l	#-$3050009,d0
	movem.l	(a7)+,a2/a6
	rts
L358
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "WaitReadOnlyLock__xLOCKABLE__T:0",CODE


;sint32 xLOCKABLE::WaitReadOnlyLock()
	XDEF	WaitReadOnlyLock__xLOCKABLE__T
WaitReadOnlyLock__xLOCKABLE__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L359
;	if (destructor)
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L361
L360
	move.l	#-$3050009,d0
	movem.l	(a7)+,a2/a6
	rts
L361
;	ObtainSemaphoreShared(&lock);
	move.l	_SysBase,a6
	lea	$8(a2),a0
	jsr	-$2A6(a6)
;	if (destructor)
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L363
L362
;		ReleaseSemaphore(&lock);
	move.l	_SysBase,a6
	lea	$8(a2),a0
	jsr	-$23A(a6)
	move.l	#-$3050009,d0
	movem.l	(a7)+,a2/a6
	rts
L363
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "FreeLock__xLOCKABLE__Ts:0",CODE


;sint32 xLOCKABLE::FreeLock(bool all)
	XDEF	FreeLock__xLOCKABLE__Ts
FreeLock__xLOCKABLE__Ts
	movem.l	d2/d3/a2/a6,-(a7)
	move.w	$18(a7),d3
	move.l	$14(a7),a2
L364
;	if (!MyLock()) // some plonker may have called FreeLock() without 
	move.l	a2,a0
	tst.l	4(a0)
	beq.b	L366
L365
	moveq	#0,d0
	bra.b	L367
L366
	move.l	$30(a0),d2
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	cmp.l	d0,d2
	seq	d2
	and.l	#1,d2
	move.w	d2,d0
L367
	tst.w	d0
	bne.b	L371
L368
;		if (destructor) // alternatively the destructor may be at work a
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L370
L369
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L370
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L371
;	sint32 n = lock.ss_NestCount;
	move.w	$16(a2),d2
	ext.l	d2
;	if (all)
	tst.w	d3
	beq.b	L376
L372
;		while (lock.ss_NestCount)
	bra.b	L374
L373
;			ReleaseSemaphore(&lock);
	move.l	_SysBase,a6
	lea	$8(a2),a0
	jsr	-$23A(a6)
L374
	tst.w	$16(a2)
	bne.b	L373
L375
	move.l	d2,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L376
;	else if (n > 0)
	cmp.l	#0,d2
	ble.b	L378
L377
;		ReleaseSemaphore(&lock);
	move.l	_SysBase,a6
	lea	$8(a2),a0
	jsr	-$23A(a6)
	move.w	$16(a2),d0
	ext.l	d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L378
	move.l	#-$3050006,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "_0dt__xLOCKABLE__T:0",CODE


;xLOCKABLE::~xLOCKABLE()
	XDEF	_0dt__xLOCKABLE__T
_0dt__xLOCKABLE__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L379
;	if (destructor)
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L381
L380
	movem.l	(a7)+,a2/a6
	rts
L381
;	destructor = FindTask(NOTSET);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a2,a1
	move.l	d0,4(a1)
;	WaitLock();
	move.l	a2,-(a7)
	jsr	WaitLock__xLOCKABLE__T
	addq.w	#4,a7
;	FreeLock(TRUE);
	move.w	#1,-(a7)
	move.l	a2,-(a7)
	jsr	FreeLock__xLOCKABLE__Ts
	addq.w	#6,a7
	movem.l	(a7)+,a2/a6
	rts

	SECTION "LockDump__xLOCKABLE__TR07ostream:0",CODE


;void xLOCKABLE::LockDump(ostream& out)
	XDEF	LockDump__xLOCKABLE__TR07ostream
LockDump__xLOCKABLE__TR07ostream
L382
;void xLOCKABLE::LockDump(ostream& out)
	rts

	SECTION "_TimerBase__xTIMABLE:1",DATA

	XDEF	_TimerBase__xTIMABLE
_TimerBase__xTIMABLE
	dc.l	0

	SECTION "_clockFreq__xTIMABLE:1",DATA

	XDEF	_clockFreq__xTIMABLE
_clockFreq__xTIMABLE
	dc.l	0

	SECTION "_current__xTIMABLE:2",BSS

	XDEF	_current__xTIMABLE
_current__xTIMABLE
	ds.l	2

	END
