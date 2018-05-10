
; Storm C Compiler
; extropialib:lib/Platforms/Amiga68k/ServiceLib/ServiceLib.cpp
	mc68030
	mc68881
	XREF	_0dt__LOCK__T
	XREF	_0dt__THREAD__T
	XREF	Run__THREAD__T
	XREF	_0dt__DELAY__T
	XREF	_0ct__DELAY__T
	XREF	Pause__DELAY__TUj
	XREF	Pause__DELAY__TUjUj
	XREF	Abort__DELAY__T
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

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "LinkFront__xCHAINABLE__TP06xCHAIN:0",CODE


;sint32 xCHAINABLE::LinkFront(xCHAIN* c)
	XDEF	LinkFront__xCHAINABLE__TP06xCHAIN
LinkFront__xCHAINABLE__TP06xCHAIN
	movem.l	a2/a3/a6,-(a7)
	move.l	$14(a7),a2
	move.l	$10(a7),a3
L15
;	if (chain)	
	move.l	a3,a1
	tst.l	$8(a1)
	beq.b	L17
L16
;	if (chain)	return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L17
;	if (!c)			
	cmp.w	#0,a2
	bne.b	L19
L18
;	if (!c)			return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L19
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
;	return OK;
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
L20
;	if (chain)	
	move.l	a3,a1
	tst.l	$8(a1)
	beq.b	L22
L21
;	if (chain)	return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L22
;	if (!c)			
	cmp.w	#0,a2
	bne.b	L24
L23
;	if (!c)			return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L24
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
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "LinkBefore__xCHAINABLE__TP06xCHAINP10xCHAINABLE:0",CODE


;sint32 xCHAINABLE::LinkBefore(xCHAIN* c, xCHAINABLE* x)
	XDEF	LinkBefore__xCHAINABLE__TP06xCHAINP10xCHAINABLE
LinkBefore__xCHAINABLE__TP06xCHAINP10xCHAINABLE
L35	EQU	-4
	link	a5,#L35
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a5),a2
	move.l	$C(a5),a3
L25
;	if (chain)					
	move.l	$8(a5),a1
	tst.l	$8(a1)
	beq.b	L27
L26
;	if (chain)					return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L27
;	if (!c || !x)				
	cmp.w	#0,a3
	beq.b	L29
L28
	cmp.w	#0,a2
	bne.b	L30
L29
;	if (!c || !x)				return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L30
;	if (x==this)				
	cmp.l	$8(a5),a2
	bne.b	L32
L31
;	if (x==this)				return ERR_PTR_USED;
	move.l	#-$3020003,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L32
;	if (x->chain != c)	
	move.l	$8(a2),a0
	cmp.l	a3,a0
	beq.b	L34
L33
;	if (x->chain != c)	return ERR_PTR_INCONSISTENT;
	move.l	#-$3020005,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L34
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
;	return OK;
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
L36
;	if (!chain) 
	move.l	a2,a1
	tst.l	$8(a1)
	bne.b	L38
L37
;	if (!chain) return ERR_RSC;
	move.l	#-$3050000,d0
	movem.l	(a7)+,a2/a6
	rts
L38
;	::Remove(CASTNODE(this));
	move.l	_SysBase,a6
	move.l	a2,a1
	jsr	-$FC(a6)
;	chain->items--;
	move.l	a2,a1
	move.l	$8(a1),a0
	subq.l	#1,$C(a0)
; chain = 0;
	move.l	a2,a1
	clr.l	$8(a1)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	END
