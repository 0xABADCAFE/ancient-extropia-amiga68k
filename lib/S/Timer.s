
; Storm C Compiler
; extropialib:lib/Platforms/Amiga68k/ServiceLib/Timer.cpp
	mc68030
	mc68881
	XREF	_0dt__LOCK__T
	XREF	_0dt__THREAD__T
	XREF	Run__THREAD__T
	XREF	UnLink__xCHAINABLE__T
	XREF	_DeleteExtIO
	XREF	_CreateExtIO
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
	XREF	_threadCnt__THREAD
	XREF	_threadsIdle__THREAD
	XREF	_rootThread__THREAD

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_TimerBase__MILLICLOCK:0",CODE


	XDEF	_INIT_8_Timer_cpp__TimerBase__MILLICLOCK
_INIT_8_Timer_cpp__TimerBase__MILLICLOCK
	move.l	a6,-(a7)
L23
;Device*		MILLICLOCK::TimerBase = TimerBase = (Device*)::FindNa
	move.l	_SysBase,a1
	lea	$15E(a1),a0
	move.l	_SysBase,a6
	move.l	#L22,a1
	jsr	-$114(a6)
	move.l	d0,_TimerBase__MILLICLOCK
	move.l	(a7)+,a6
	rts

L22
	dc.b	'timer.device',0

	SECTION "_TimerBase__MILLICLOCK:1",DATA

	XDEF	_TimerBase__MILLICLOCK
_TimerBase__MILLICLOCK
	ds.l	1

	SECTION "_current__MILLICLOCK:2",BSS

	XDEF	_current__MILLICLOCK
_current__MILLICLOCK
	ds.l	2

	SECTION "_clockFreq__MILLICLOCK:1",DATA

	XDEF	_clockFreq__MILLICLOCK
_clockFreq__MILLICLOCK
	dc.l	0

	SECTION "Elapsed__MILLICLOCK__T:0",CODE


;uint32 MILLICLOCK::Elapsed()
	XDEF	Elapsed__MILLICLOCK__T
Elapsed__MILLICLOCK__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L25
;	::ReadEClock(&current);
	move.l	_TimerBase,a6
	move.l	#_current__MILLICLOCK,a0
	jsr	-$3C(a6)
;	if (current.ev_hi == mark.ev_hi)
	move.l	_current__MILLICLOCK,d1
	move.l	a2,a0
	cmp.l	(a0),d1
	bne.b	L27
L26
;		ticks = current.ev_lo - mark.ev_lo;
	move.l	_current__MILLICLOCK+4,d0
	move.l	a2,a0
	sub.l	4(a0),d0
	bra.b	L28
L27
;		ticks = 0xFFFFFFFF-mark.ev_lo + current.ev_lo;
	move.l	a2,a0
	moveq	#-1,d0
	sub.l	4(a0),d0
	move.l	_current__MILLICLOCK+4,d1
	add.l	d1,d0
L28
;	return (1000*ticks)/clockFreq;
	mulu.l	#$3E8,d0
	divul.l	_clockFreq__MILLICLOCK,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "_0ct__DELAY__T:0",CODE


;DELAY::DELAY() 
	XDEF	_0ct__DELAY__T
_0ct__DELAY__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L30
	move.l	a2,a0
	clr.l	$8(a0)
	move.l	a2,a0
	clr.l	$C(a0)
;	if ( !(timerPort = ::CreateMsgPort()) )
	move.l	_SysBase,a6
	jsr	-$29A(a6)
	move.l	a2,a1
	move.l	d0,(a1)
	bne.b	L32
L31
;		flags |= PORT_FAIL;
	move.l	a2,a0
	move.l	$C(a0),d0
	or.l	#1,d0
	move.l	a2,a0
	move.l	d0,$C(a0)
;		return;
	movem.l	(a7)+,a2/a6
	rts
L32
;	timerSignal = 1<<timerPort->mp_SigBit;
	move.l	a2,a1
	move.l	(a1),a0
	moveq	#0,d0
	move.b	$F(a0),d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	a2,a0
	move.l	d1,$8(a0)
;	if ( !(timerIO = ::CreateExtIO(timerPort, sizeof(timerequest))) )
	pea	$28.w
	move.l	a2,a1
	move.l	(a1),-(a7)
	jsr	_CreateExtIO
	addq.w	#$8,a7
	move.l	a2,a1
	move.l	d0,4(a1)
	bne.b	L34
L33
;		flags |= IORQ_FAIL;
	move.l	a2,a0
	move.l	$C(a0),d0
	or.l	#2,d0
	move.l	a2,a0
	move.l	d0,$C(a0)
;		return;
	movem.l	(a7)+,a2/a6
	rts
L34
;	if (::OpenDevice(TIMERNAME, UNIT_MICROHZ, timerIO, 0)!=0)
	move.l	a2,a0
	move.l	4(a0),a1
	move.l	_SysBase,a6
	moveq	#0,d0
	moveq	#0,d1
	move.l	#L29,a0
	jsr	-$1BC(a6)
	ext.w	d0
	tst.w	d0
	beq.b	L36
L35
;		flags |= OPDV_FAIL;
	move.l	a2,a0
	move.l	$C(a0),d0
	or.l	#4,d0
	move.l	a2,a0
	move.l	d0,$C(a0)
;		return;
	movem.l	(a7)+,a2/a6
	rts
L36
	movem.l	(a7)+,a2/a6
	rts

L29
	dc.b	'timer.device',0

	SECTION "_0dt__DELAY__T:0",CODE


;DELAY::~DELAY()
	XDEF	_0dt__DELAY__T
_0dt__DELAY__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L37
;	if (timerIO)
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L41
L38
;		if (flags & IORQ_USED)
	move.l	a2,a0
	move.l	$C(a0),d0
	and.l	#$8,d0
	beq.b	L40
L39
;			::AbortIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1E0(a6)
;			::WaitIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1DA(a6)
;			::SetSignal(0, timerSignal);
	move.l	a2,a0
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	$8(a0),d1
	jsr	-$132(a6)
L40
;		::CloseDevice(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1C2(a6)
;		::DeleteExtIO(timerIO);
	move.l	a2,a1
	move.l	4(a1),-(a7)
	jsr	_DeleteExtIO
	addq.w	#4,a7
L41
;	if (timerPort)
	move.l	a2,a1
	tst.l	(a1)
	beq.b	L43
L42
;		::DeleteMsgPort(timerPort);
	move.l	a2,a1
	move.l	_SysBase,a6
	move.l	(a1),a0
	jsr	-$2A0(a6)
L43
	movem.l	(a7)+,a2/a6
	rts

	SECTION "Abort__DELAY__T:0",CODE


;void DELAY::Abort()
	XDEF	Abort__DELAY__T
Abort__DELAY__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L44
;	if (timerIO && (flags & IORQ_USED))
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L47
L45
	move.l	a2,a0
	move.l	$C(a0),d0
	and.l	#$8,d0
	beq.b	L47
L46
;		::AbortIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1E0(a6)
;		::WaitIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1DA(a6)
;		::SetSignal(0, timerSignal);
	move.l	a2,a0
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	$8(a0),d1
	jsr	-$132(a6)
L47
	movem.l	(a7)+,a2/a6
	rts

	SECTION "Pause__DELAY__TUjUj:0",CODE


;sysSIGNAL DELAY::Pause(uint32 millis, sysSIGNAL trigger)
	XDEF	Pause__DELAY__TUjUj
Pause__DELAY__TUjUj
	movem.l	d2/d3/a2/a6,-(a7)
	movem.l	$18(a7),d2/d3
	move.l	$14(a7),a2
L48
;	if (!(millis|trigger))
	move.l	d2,d0
	or.l	d3,d0
	bne.b	L50
L49
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L50
;	Abort();
	move.l	a2,-(a7)
	jsr	Abort__DELAY__T
	addq.w	#4,a7
;	if (millis)
	tst.l	d2
	beq.b	L52
L51
;		timerReq->tr_node.io_Command	= TR_ADDREQUEST;
	move.l	a2,a1
	move.l	4(a1),a0
	move.w	#$9,$1C(a0)
;		timerReq->tr_time.tv_secs			= (millis/1000);
	move.l	d2,d0
	divul.l	#$3E8,d0
	move.l	a2,a1
	move.l	4(a1),a0
	move.l	d0,$20(a0)
;		timerReq->tr_time.tv_micro		= 1000*(millis%1000);
	divul.l	#$3E8,d0:d2
	mulu.l	#$3E8,d0
	move.l	a2,a1
	move.l	4(a1),a0
	move.l	d0,$24(a0)
;		::SendIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1CE(a6)
;		flags |= IORQ_USED;
	move.l	a2,a0
	move.l	$C(a0),d0
	or.l	#$8,d0
	move.l	a2,a0
	move.l	d0,$C(a0)
;		flags &= ~IORQ_4EVR;
	move.l	a2,a0
	move.l	$C(a0),d0
	and.l	#-$11,d0
	move.l	a2,a0
	move.l	d0,$C(a0)
	bra.b	L53
L52
;		flags |= IORQ_4EVR;
	move.l	a2,a0
	move.l	$C(a0),d0
	or.l	#$10,d0
	move.l	a2,a0
	move.l	d0,$C(a0)
L53
;	return ::Wait(timerSignal|trigger);
	move.l	a2,a0
	move.l	$8(a0),d0
	or.l	d3,d0
	move.l	_SysBase,a6
	jsr	-$13E(a6)
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "Pause__DELAY__TUj:0",CODE


;sysSIGNAL DELAY::Pause(sysSIGNAL trigger)
	XDEF	Pause__DELAY__TUj
Pause__DELAY__TUj
	movem.l	d2/a2/a6,-(a7)
	move.l	$14(a7),d2
	move.l	$10(a7),a2
L54
;	if (trigger)
	tst.l	d2
	beq.b	L60
L55
;		if (timerIO && (flags & IORQ_USED))
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L60
L56
	move.l	a2,a0
	move.l	$C(a0),d0
	and.l	#$8,d0
	beq.b	L60
L57
;		if (::CheckIO(timerIO)==0)
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1D4(a6)
	move.l	d0,a0
	cmp.w	#0,a0
	bne.b	L59
L58
;			return ::Wait(trigger|timerSignal);
	move.l	a2,a0
	move.l	$8(a0),d0
	or.l	d2,d0
	move.l	_SysBase,a6
	jsr	-$13E(a6)
	movem.l	(a7)+,d2/a2/a6
	rts
L59
;			return timerSignal;
	move.l	a2,a0
	move.l	$8(a0),d0
	movem.l	(a7)+,d2/a2/a6
	rts
L60
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a6
	rts

	END
