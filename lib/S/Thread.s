
; Storm C Compiler
; extropialib:lib/Platforms/Amiga68k/ServiceLib/Thread.cpp
	mc68030
	mc68881
	XREF	Run__THREAD__T
	XREF	_0dt__DELAY__T
	XREF	_0ct__DELAY__T
	XREF	Pause__DELAY__TUj
	XREF	Pause__DELAY__TUjUj
	XREF	Abort__DELAY__T
	XREF	UnLink__xCHAINABLE__T
	XREF	_strcpy
	XREF	_system
	XREF	_sprintf
	XREF	op__delete__PvUi
	XREF	op__new__Ui
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

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_0ct__THREAD_MAIN__T:0",CODE


;THREAD_MAIN::THREAD_MAIN() 
	XDEF	_0ct__THREAD_MAIN__T
_0ct__THREAD_MAIN__T
	movem.l	a2/a3,-(a7)
	move.l	$C(a7),a3
L80
	move.l	a3,-(a7)
	jsr	_0ct__THREAD__T
	addq.w	#4,a7
;	internal = (Process*)rootThread;
	move.l	a3,a1
	move.l	_rootThread__THREAD,$8(a1)
;	state = SPAWNED;
	move.l	a3,a0
	move.w	#1,$16(a0)
;	strcpy(name, "THREAD 1");
	move.l	#L79,-(a7)
	pea	$1C(a3)
	jsr	_strcpy
	addq.w	#$8,a7
;	sleeper = new IDLE;
	pea	$18.w
	jsr	op__new__Ui
	move.l	d0,a2
	addq.w	#4,a7
	cmp.w	#0,a2
	beq.b	L82
L81
	move.l	#_0virttab__12IDLE__THREAD__12IDLE__THREAD,$10(a2)
	move.l	a2,-(a7)
	jsr	_0ct__DELAY__T
	addq.w	#4,a7
	clr.l	$14(a2)
L82
	move.l	a3,a0
	move.l	a2,$C(a0)
	movem.l	(a7)+,a2/a3
	rts

L79
	dc.b	'THREAD 1',0

	SECTION "_0dt__THREAD_MAIN__T:0",CODE


;THREAD_MAIN::~THREAD_MAIN()
	XDEF	_0dt__THREAD_MAIN__T
_0dt__THREAD_MAIN__T
	movem.l	a2/a3,-(a7)
	move.l	$C(a7),a3
L83
;	if (sleeper)
	move.l	a3,a1
	tst.l	$C(a1)
	beq.b	L86
L84
;		delete sleeper;
	move.l	a3,a0
	move.l	$C(a0),a2
	cmp.w	#0,a2
	beq.b	L86
L85
	move.l	$10(a2),a0
	move.l	a2,d0
	add.l	$1C(a0),d0
	move.l	d0,-(a7)
	move.l	$18(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	$10(a2),a0
	move.l	$10(a0),-(a7)
	move.l	$14(a0),d0
	add.l	a2,d0
	move.l	d0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L86
;	state = 0;
	move.l	a3,a0
	clr.w	$16(a0)
	move.l	a3,-(a7)
	jsr	_0dt__THREAD__T
	addq.w	#4,a7
	movem.l	(a7)+,a2/a3
	rts

	SECTION "_threadCnt__THREAD:1",DATA

	XDEF	_threadCnt__THREAD
_threadCnt__THREAD
	dc.l	1

	SECTION "_threadsIdle__THREAD:1",DATA

	XDEF	_threadsIdle__THREAD
_threadsIdle__THREAD
	dc.l	0

	SECTION "_rootThread__THREAD:0",CODE


	XDEF	_INIT_8_Thread_cpp__rootThread__THREAD
_INIT_8_Thread_cpp__rootThread__THREAD
	move.l	a6,-(a7)
L89
;Task*		THREAD::rootThread	= ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	d0,_rootThread__THREAD
	move.l	#_0virttab__11THREAD_MAIN__11THREAD_MAIN,_appThread__Main__THREAD_+$2C
	pea	_appThread__Main__THREAD_
	jsr	_0ct__THREAD_MAIN__T
	addq.w	#4,a7
	move.l	(a7)+,a6
	rts

	SECTION "_rootThread__THREAD:1",DATA

	XDEF	_rootThread__THREAD
_rootThread__THREAD
	ds.l	1

	SECTION "_0ct__THREAD__T:0",CODE


;THREAD::THREAD() 
	XDEF	_0ct__THREAD__T
_0ct__THREAD__T
	move.l	4(a7),a0
L90
	move.l	#$58534C54,(a0)
	clr.l	4(a0)
	clr.l	$8(a0)
	clr.l	$C(a0)
	clr.l	$10(a0)
	clr.w	$14(a0)
	clr.w	$16(a0)
	clr.l	$18(a0)
	rts

	SECTION "_0dt__THREAD__T:0",CODE


;THREAD::~THREAD()
	XDEF	_0dt__THREAD__T
_0dt__THREAD__T
	move.l	4(a7),a0
L91
;	Stop();
	move.l	a0,-(a7)
	jsr	Stop__THREAD__T
	addq.w	#4,a7
	rts

	SECTION "Main__THREAD_:0",CODE


	XDEF	_EXIT_8_Thread_cpp_Main__THREAD_
_EXIT_8_Thread_cpp_Main__THREAD_
L92
	move.l	#_appThread__Main__THREAD_,-(a7)
	jsr	_0dt__THREAD_MAIN__T
	addq.w	#4,a7
	rts

;THREAD* THREAD::Main()
	XDEF	Main__THREAD_
Main__THREAD_
L93
;	return &appThread;
	move.l	#_appThread__Main__THREAD_,d0
	rts

	SECTION "Main__THREAD_:1",DATA

_appThread__Main__THREAD_
	ds.b	48

	SECTION "Current__THREAD_:0",CODE


;THREAD* THREAD::Current()
	XDEF	Current__THREAD_
Current__THREAD_
	move.l	a6,-(a7)
L94
;	Task* task = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	d0,a0
;	if (task==rootThread)
	cmp.l	_rootThread__THREAD,a0
	bne.b	L96
L95
;		return Main();
	jsr	Main__THREAD_
	move.l	(a7)+,a6
	rts
L96
;	else if (task)
	cmp.w	#0,a0
	beq.b	L100
L97
;		THREAD* thread = (THREAD*)(task->tc_UserData);
	move.l	$58(a0),a0
;		if (thread && thread->classID == IDTAG)
	cmp.w	#0,a0
	beq.b	L100
L98
	move.l	(a0),d0
	cmp.l	#$58534C54,d0
	bne.b	L100
L99
;			return thread;
	move.l	a0,d0
	move.l	(a7)+,a6
	rts
L100
;	return 0;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

	SECTION "Init__THREAD_:0",CODE


;void THREAD::Init()
	XDEF	Init__THREAD_
Init__THREAD_
	movem.l	a2/a6,-(a7)
L101
;	THREAD *t = Current();
	jsr	Current__THREAD_
	move.l	d0,a2
;	if (t)
	cmp.w	#0,a2
	beq	L107
L102
;		if (!(t->sleeper = new IDLE))
	pea	$18.w
	jsr	op__new__Ui
	move.l	d0,a6
	addq.w	#4,a7
	cmp.w	#0,a6
	beq.b	L104
L103
	move.l	#_0virttab__12IDLE__THREAD__12IDLE__THREAD,$10(a6)
	move.l	a6,-(a7)
	jsr	_0ct__DELAY__T
	addq.w	#4,a7
	clr.l	$14(a6)
L104
	move.l	a2,a0
	move.l	a6,$C(a0)
	cmp.w	#0,a6
	bne.b	L106
L105
;			t->state |= STARTERROR;
	move.l	a2,a0
	move.w	$16(a0),d0
	or.w	#2,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
;			return;
	movem.l	(a7)+,a2/a6
	rts
L106
;		t->state |= SPAWNED;
	move.l	a2,a0
	move.w	$16(a0),d0
	or.w	#1,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
;		::Signal(t->external, (uint32)SIGNAL_SYNC);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$8000,d0
	move.l	4(a0),a1
	jsr	-$144(a6)
;		++threadCnt;
	addq.l	#1,_threadCnt__THREAD
;		retVal = t->Run();
	move.l	a2,a1
	move.l	$2C(a1),a0
	move.l	a2,d0
	add.l	$14(a0),d0
	move.l	d0,-(a7)
	move.l	$10(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	d0,d2
;		--threadCnt;
	subq.l	#1,_threadCnt__THREAD
;		t->state |= COMPLETED;
	move.l	a2,a0
	move.w	$16(a0),d0
	or.w	#4,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
;		return;
	movem.l	(a7)+,a2/a6
	rts
L107
	movem.l	(a7)+,a2/a6
	rts

	SECTION "Done__THREAD_:0",CODE


;void THREAD::Done()
	XDEF	Done__THREAD_
Done__THREAD_
	movem.l	a2/a6,-(a7)
L108
;	THREAD* t = Current();
	jsr	Current__THREAD_
	move.l	d0,a6
;	if (t)
	cmp.w	#0,a6
	beq.b	L114
L109
;		if (t->sleeper)
	tst.l	$C(a6)
	beq.b	L113
L110
;			delete t->sleeper;
	move.l	$C(a6),a2
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L112
L111
	move.l	a2,a1
	move.l	$10(a1),a0
	move.l	a2,d0
	add.l	$1C(a0),d0
	move.l	d0,-(a7)
	move.l	$18(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	a2,a1
	move.l	$10(a1),a0
	move.l	$10(a0),-(a7)
	move.l	$14(a0),d0
	add.l	a2,d0
	move.l	d0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L112
;			t->sleeper = 0;
	clr.l	$C(a6)
L113
;		t->state &= ~SPAWNED;
	and.w	#$FFFE,$16(a6)
;		::Signal(t->external, (uint32)SIGNAL_SYNC);
	move.l	4(a6),a1
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$144(a6)
L114
	movem.l	(a7)+,a2/a6
	rts

	SECTION "GoIdle__THREAD__T:0",CODE


;sint32 THREAD::GoIdle()
	XDEF	GoIdle__THREAD__T
GoIdle__THREAD__T
	movem.l	d2/a2/a3/a6,-(a7)
	move.l	$14(a7),a2
L115
;	if ((Task*)internal!=::FindTask(0))
	move.l	a2,a0
	move.l	$8(a0),a3
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a0
	cmp.l	d0,a0
	beq.b	L117
L116
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L117
;	else if (state & ABORTREQ)
	move.l	a2,a0
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#$40,d0
	beq.b	L119
L118
;		return SLEEPABORTED;
	moveq	#4,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L119
;	sysSIGNAL gotSignals = sleeper->Suspend();
	move.l	a2,a1
	move.l	$C(a1),a0
	move.l	$14(a0),-(a7)
	move.l	a0,-(a7)
	jsr	Pause__DELAY__TUj
	addq.w	#$8,a7
;	if (gotSignals & SIGNAL_REMV)
	move.l	d0,d1
	and.l	#$1000,d1
	beq.b	L121
L120
;		sleeper->Abort();
	move.l	a2,a1
	move.l	$C(a1),-(a7)
	jsr	Abort__DELAY__T
	addq.w	#4,a7
;		state |= SHUTDOWN;
	move.l	a2,a0
	move.w	$16(a0),d0
	or.w	#$8,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
;		return REMOVE;
	moveq	#2,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L121
;	else if (gotSignals & SIGNAL_WAKE)
	move.l	d0,d1
	and.l	#$2000,d1
	beq.b	L123
L122
;		return WAKECALL;
	moveq	#1,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L123
;	else if (gotSignals & sleeper->TimerSignal())
	move.l	a2,a1
	move.l	$C(a1),a0
	and.l	$8(a0),d0
	beq.b	L125
L124
;		return TIMEOUT;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L125
;	else if (gotSignals & sleeper->ReqSignal());
L126
;		return SYSTEMSIGNAL;
	moveq	#3,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts

	SECTION "GoIdle__THREAD__TUjssUj:0",CODE


;sint32 THREAD::GoIdle(uint32 millis, bool abortReq, bool ignoreWake,
	XDEF	GoIdle__THREAD__TUjssUj
GoIdle__THREAD__TUjssUj
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.l	$24(a7),d2
	move.l	$2C(a7),d3
	move.w	$28(a7),d4
	move.w	$2A(a7),d5
	move.l	$20(a7),a2
L127
;	if ((Task*)internal!=::FindTask(0))
	move.l	a2,a0
	move.l	$8(a0),a3
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a0
	cmp.l	d0,a0
	beq.b	L129
L128
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L129
;	if (abortReq)
	tst.w	d4
	beq.b	L131
L130
;		state |= ABORTREQ;
	move.l	a2,a0
	move.w	$16(a0),d0
	or.w	#$40,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
	bra.b	L132
L131
;		state &= ~ABORTREQ;
	move.l	a2,a0
	move.w	$16(a0),d0
	and.w	#$FFBF,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
L132
;	++threadsIdle;
	addq.l	#1,_threadsIdle__THREAD
;	if (ignoreWake)
	tst.w	d5
	beq.b	L134
L133
;		state |= IGNOREWAKE;
	move.l	a2,a0
	move.w	$16(a0),d0
	or.w	#$20,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
;		gotSignals = sleeper->Suspend(millis, trigger|SIGNAL_REMV);
	move.l	d3,d0
	or.l	#$1000,d0
	move.l	a2,a1
	move.l	$C(a1),a0
	move.l	d0,$14(a0)
	move.l	$14(a0),-(a7)
	move.l	d2,-(a7)
	move.l	a0,-(a7)
	jsr	Pause__DELAY__TUjUj
	add.w	#$C,a7
	move.l	d0,d2
	bra.b	L135
L134
;		state &= ~IGNOREWAKE;
	move.l	a2,a0
	move.w	$16(a0),d0
	and.w	#$FFDF,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
;		gotSignals = sleeper->Suspend(millis, trigger|SIGNAL_WAKE|SIGNAL
	move.l	d3,d0
	or.l	#$2000,d0
	or.l	#$1000,d0
	move.l	a2,a1
	move.l	$C(a1),a0
	move.l	d0,$14(a0)
	move.l	$14(a0),-(a7)
	move.l	d2,-(a7)
	move.l	a0,-(a7)
	jsr	Pause__DELAY__TUjUj
	add.w	#$C,a7
	move.l	d0,d2
L135
;	state &= ~(SLEEPING|IGNOREWAKE);
	move.l	a2,a0
	move.w	$16(a0),d0
	and.w	#$FFCF,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
;	--threadsIdle;
	subq.l	#1,_threadsIdle__THREAD
;	if (abortReq)
	tst.w	d4
	beq.b	L137
L136
;	  AbortIdle();
	move.l	a2,a6
	move.l	$C(a6),-(a7)
	jsr	Abort__DELAY__T
	addq.w	#4,a7
	or.w	#$40,$16(a6)
L137
;	if (gotSignals & SIGNAL_REMV)
	move.l	d2,d0
	and.l	#$1000,d0
	beq.b	L139
L138
;		AbortIdle();
	move.l	a2,a6
	move.l	$C(a6),-(a7)
	jsr	Abort__DELAY__T
	addq.w	#4,a7
	or.w	#$40,$16(a6)
;		state |= SHUTDOWN;
	move.l	a2,a0
	move.w	$16(a0),d0
	or.w	#$8,d0
	move.l	a2,a0
	move.w	d0,$16(a0)
;		return REMOVE;
	moveq	#2,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L139
;	else if (gotSignals & SIGNAL_WAKE)
	move.l	d2,d0
	and.l	#$2000,d0
	beq.b	L141
L140
;		return WAKECALL;
	moveq	#1,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L141
;	else if (gotSignals & sleeper->TimerSignal())
	move.l	a2,a1
	move.l	$C(a1),a0
	and.l	$8(a0),d2
	beq.b	L143
L142
;		return TIMEOUT;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L143
;	else if (gotSignals & trigger);
L144
;		return SYSTEMSIGNAL;
	moveq	#3,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts

	SECTION "Start__THREAD__TjUi:0",CODE


;sint32 THREAD::Start(sint32 pri, size_t stk)
	XDEF	Start__THREAD__TjUi
Start__THREAD__TjUi
L170	EQU	-$40
	link	a5,#L170
	movem.l	d2-d4/a2/a3/a6,-(a7)
	movem.l	$C(a5),d3/d4
	move.l	$8(a5),a3
L146
;	if (state & SPAWNED)
	move.l	a3,a0
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#1,d0
	beq.b	L148
L147
;		return ERR_ALREADYRUNNING;
	moveq	#-4,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L148
;	external = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a1
	move.l	d0,4(a1)
;	stackSize = Clamp(stk, STACK_MINIMUM, STACK_MAXIMUM);
	move.l	#$100000,d2
	move.l	#$800,d1
	move.l	d4,d0
	cmp.l	d1,d0
	bhs.b	L150
L149
	move.l	d1,d0
	bra.b	L154
L150
	cmp.l	d2,d0
	bls.b	L152
L151
	move.l	d2,d0
L152
L153
L154
	move.l	a3,a0
	move.l	d0,$10(a0)
;	priority	= Clamp(pri, PRI_MINIMUM, PRI_MAXIMUM);
	moveq	#1,d2
	move.l	#-$80,d1
	move.l	d3,d0
	cmp.l	d1,d0
	bge.b	L156
L155
	move.l	d1,d0
	bra.b	L160
L156
	cmp.l	d2,d0
	ble.b	L158
L157
	move.l	d2,d0
L158
L159
L160
	move.l	a3,a0
	move.w	d0,$14(a0)
;	sprintf(name, "THREAD %d", threadCnt+1);
	move.l	_threadCnt__THREAD,d0
	addq.l	#1,d0
	move.l	d0,-(a7)
	move.l	#L145,-(a7)
	pea	$1C(a3)
	jsr	_sprintf
	add.w	#$C,a7
;	TagItem threadTags[] = {
	lea	-$40(a5),a0
	move.l	#$800003EB,(a0)+
	move.l	#Init__THREAD_,(a0)+
	move.l	#$800003F3,(a0)+
	move.l	a3,a1
	move.l	$10(a1),(a0)+
	move.l	#$800003F5,(a0)+
	move.l	a3,a1
	move.w	$14(a1),d0
	ext.l	d0
	move.l	d0,(a0)+
	move.l	#$800003F4,(a0)+
	lea	$1C(a3),a1
	move.l	a1,(a0)+
	move.l	#$80000400,(a0)+
	move.l	#Done__THREAD_,(a0)+
	move.l	#$800003EA,(a0)+
	clr.l	(a0)+
	move.l	#$800003EF,(a0)+
	move.l	#1,(a0)+
	clr.l	(a0)+
	clr.l	(a0)
;	::Forbid();
	move.l	_SysBase,a6
	jsr	-$84(a6)
;	state = 0;
	move.l	a3,a0
	clr.w	$16(a0)
;	internal = ::CreateNewProc(threadTags);
	lea	-$40(a5),a0
	move.l	_DOSBase,a6
	move.l	a0,d1
	jsr	-$1F2(a6)
	move.l	a3,a1
	move.l	d0,$8(a1)
;	if (!internal)
	move.l	a3,a1
	tst.l	$8(a1)
	bne.b	L162
L161
;		::Permit();
	move.l	_SysBase,a6
	jsr	-$8A(a6)
;		return ERR_STARTUP;
	moveq	#-1,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L162
;		internal->pr_Task.tc_UserData = (void*)this;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	a3,$58(a0)
;	::Permit();
	move.l	_SysBase,a6
	jsr	-$8A(a6)
;	while ((state & (SPAWNED|STARTERROR|COMPLETED))==0)
	bra.b	L164
L163
;		::Wait((uint32)SIGNAL_SYNC);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
L164
	move.l	a3,a0
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#7,d0
	beq.b	L163
L165
;	if (state & STARTERROR)
	move.l	a3,a0
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#2,d0
	beq.b	L167
L166
;		state = 0;
	move.l	a3,a0
	clr.w	$16(a0)
;		return ERR_STARTUP;
	moveq	#-1,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L167
;	if (state & COMPLETED)
	move.l	a3,a0
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#4,d0
	beq.b	L169
L168
;		state = COMPLETED;
	move.l	a3,a0
	move.w	#4,$16(a0)
;		internal = 0;
	move.l	a3,a1
	clr.l	$8(a1)
L169
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts

L145
	dc.b	'THREAD %d',0

	SECTION "Stop__THREAD__T:0",CODE


;sint32 THREAD::Stop()
	XDEF	Stop__THREAD__T
Stop__THREAD__T
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a7),a3
L171
;	if ((Task*)internal == rootThread)
	move.l	a3,a1
	move.l	$8(a1),a0
	cmp.l	_rootThread__THREAD,a0
	bne.b	L173
L172
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L173
;	if (!(state & SPAWNED) || !internal)
	move.l	a3,a0
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#1,d0
	beq.b	L175
L174
	move.l	a3,a1
	tst.l	$8(a1)
	bne.b	L176
L175
;		return ERR_NOTRUNNING;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L176
;	external = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a1
	move.l	d0,4(a1)
;	if ((Task*)internal==external)
	move.l	a3,a0
	move.l	$8(a0),a1
	move.l	a3,a2
	cmp.l	4(a2),a1
	bne.b	L178
L177
;		external = 0;
	move.l	a3,a1
	clr.l	4(a1)
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L178
;	state |= SHUTDOWN;
	move.l	a3,a0
	move.w	$16(a0),d0
	or.w	#$8,d0
	move.l	a3,a0
	move.w	d0,$16(a0)
;	::Signal((Task*)internal, (uint32)SIGNAL_REMV);
	move.l	a3,a0
	move.l	_SysBase,a6
	move.l	#$1000,d0
	move.l	$8(a0),a1
	jsr	-$144(a6)
;	while(state & SPAWNED)
	bra.b	L180
L179
;		::Wait((uint32)SIGNAL_SYNC);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
L180
	move.l	a3,a0
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#1,d0
	bne.b	L179
L181
;	internal = 0;
	move.l	a3,a1
	clr.l	$8(a1)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "Sleep__THREAD__UjssUj:0",CODE


;sint32 THREAD::Sleep(uint32 millis, bool abortReq, bool ignoreWake, 
	XDEF	Sleep__THREAD__UjssUj
Sleep__THREAD__UjssUj
	movem.l	d2-d5,-(a7)
	move.l	$14(a7),d2
	move.w	$18(a7),d3
	move.w	$1A(a7),d4
	move.l	$1C(a7),d5
L182
;	THREAD* t = Current();
	jsr	Current__THREAD_
	move.l	d0,a0
;	if (t)
	cmp.w	#0,a0
	beq.b	L184
L183
;		return t->GoIdle(millis, abortReq, ignoreWake, trigger);
	move.l	d5,-(a7)
	move.w	d4,-(a7)
	move.w	d3,-(a7)
	move.l	d2,-(a7)
	move.l	a0,-(a7)
	jsr	GoIdle__THREAD__TUjssUj
	add.w	#$10,a7
	movem.l	(a7)+,d2-d5
	rts
L184
;	return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,d2-d5
	rts

	SECTION "Sleep__THREAD_:0",CODE


;sint32 THREAD::Sleep()
	XDEF	Sleep__THREAD_
Sleep__THREAD_
L185
;	THREAD* t = Current();
	jsr	Current__THREAD_
	move.l	d0,a0
;	if (t)
	cmp.w	#0,a0
	beq.b	L187
L186
;		return t->GoIdle();
	move.l	a0,-(a7)
	jsr	GoIdle__THREAD__T
	addq.w	#4,a7
	rts
L187
;	return ERR_ACCESS;
	moveq	#-2,d0
	rts

	SECTION "AbortSleep__THREAD_:0",CODE


;void THREAD::AbortSleep()
	XDEF	AbortSleep__THREAD_
AbortSleep__THREAD_
	move.l	a2,-(a7)
L188
;	THREAD* t = Current();
	jsr	Current__THREAD_
	move.l	d0,a0
;	if (t)
	cmp.w	#0,a0
	beq.b	L190
L189
;		t->AbortIdle();
	move.l	a0,a2
	move.l	$C(a2),-(a7)
	jsr	Abort__DELAY__T
	addq.w	#4,a7
	or.w	#$40,$16(a2)
L190
	move.l	(a7)+,a2
	rts

	SECTION "Wake__THREAD__T:0",CODE


;sint32 THREAD::Wake()
	XDEF	Wake__THREAD__T
Wake__THREAD__T
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a7),a2
L191
;	if (!internal || !(state & SPAWNED))
	move.l	a2,a1
	tst.l	$8(a1)
	beq.b	L193
L192
	move.l	a2,a0
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#1,d0
	bne.b	L194
L193
;		return ERR_NOTRUNNING;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L194
;	else if ((Task*)internal==::FindTask(0))
	move.l	a2,a0
	move.l	$8(a0),a3
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a0
	cmp.l	d0,a0
	bne.b	L196
L195
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L196
;	else if (state & IGNOREWAKE)
	move.l	a2,a0
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#$20,d0
	beq.b	L198
L197
;		return ERR_UNWAKEABLE;
	moveq	#-5,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L198
;	::Signal((Task*)internal, SIGNAL_WAKE);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$2000,d0
	move.l	$8(a0),a1
	jsr	-$144(a6)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "TryLock__LOCK__T:0",CODE


;sint32 LOCK::TryLock()
	XDEF	TryLock__LOCK__T
TryLock__LOCK__T
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L199
;	if (destructor)
	tst.l	$32(a0)
	beq.b	L201
L200
;		return DESTROYED;
	moveq	#-3,d0
	move.l	(a7)+,a6
	rts
L201
;	return ::AttemptSemaphore(&lock)!=0 ? OK : ALREADYLOCKED;
	move.l	_SysBase,a6
	jsr	-$240(a6)
	tst.l	d0
	beq.b	L203
L202
	moveq	#0,d0
	bra.b	L204
L203
	moveq	#-1,d0
L204
	move.l	(a7)+,a6
	rts

	SECTION "WaitLock__LOCK__T:0",CODE


;sint32 LOCK::WaitLock()
	XDEF	WaitLock__LOCK__T
WaitLock__LOCK__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L205
;	if (destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	beq.b	L207
L206
;		return DESTROYED;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a6
	rts
L207
;	::ObtainSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$234(a6)
;	if (destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	beq.b	L209
L208
;		return DESTROYED;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a6
	rts
L209
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "TryReadOnlyLock__LOCK__T:0",CODE


;sint32 LOCK::TryReadOnlyLock()
	XDEF	TryReadOnlyLock__LOCK__T
TryReadOnlyLock__LOCK__T
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L210
;	if (destructor)
	tst.l	$32(a0)
	beq.b	L212
L211
;		return DESTROYED;
	moveq	#-3,d0
	move.l	(a7)+,a6
	rts
L212
;	return ::AttemptSemaphore(&lock)!=0 ? OK : ALREADYLOCKED;
	move.l	_SysBase,a6
	jsr	-$240(a6)
	tst.l	d0
	beq.b	L214
L213
	moveq	#0,d0
	bra.b	L215
L214
	moveq	#-1,d0
L215
	move.l	(a7)+,a6
	rts

	SECTION "WaitReadOnlyLock__LOCK__T:0",CODE


;sint32 LOCK::WaitReadOnlyLock()
	XDEF	WaitReadOnlyLock__LOCK__T
WaitReadOnlyLock__LOCK__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L216
;	if (destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	beq.b	L218
L217
;		return DESTROYED;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a6
	rts
L218
;	::ObtainSemaphoreShared(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$2A6(a6)
;	if (destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	beq.b	L220
L219
;		return DESTROYED;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a6
	rts
L220
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "Pending__LOCK__T:0",CODE


;sint32 LOCK::Pending()
	XDEF	Pending__LOCK__T
Pending__LOCK__T
	move.l	4(a7),a0
L221
;	if (destructor)
	tst.l	$32(a0)
	beq.b	L223
L222
;		return DESTROYED;
	moveq	#-3,d0
	rts
L223
;	return lock.ss_NestCount - lock.ss_QueueCount - 1;
	move.w	$E(a0),d0
	ext.l	d0
	move.w	$2C(a0),d1
	ext.l	d1
	sub.l	d1,d0
	subq.l	#1,d0
	rts

	SECTION "FreeLock__LOCK__T:0",CODE


;void LOCK::FreeLock()
	XDEF	FreeLock__LOCK__T
FreeLock__LOCK__T
	move.l	a6,-(a7)
	move.l	$8(a7),a6
L224
;	if (!MyLock()) // some plonker may have called FreeLock() without 
	move.l	a6,-(a7)
	jsr	MyLock__LOCK__T
	addq.w	#4,a7
	tst.w	d0
	bne.b	L227
L225
;		if (destructor) // alternatively the destructor may be at work a
	tst.l	$32(a6)
	beq.b	L227
L226
;			return;
	move.l	(a7)+,a6
	rts
L227
;	if (lock.ss_NestCount>0)
	move.w	$E(a6),d0
	cmp.w	#0,d0
	ble.b	L229
L228
;		::ReleaseSemaphore(&lock);
	move.l	a6,a0
	move.l	_SysBase,a6
	jsr	-$23A(a6)
L229
	move.l	(a7)+,a6
	rts

	SECTION "Locked__LOCK__T:0",CODE


;sint32 LOCK::Locked()
	XDEF	Locked__LOCK__T
Locked__LOCK__T
	move.l	4(a7),a1
L230
;	if (destructor)
	tst.l	$32(a1)
	beq.b	L232
L231
;		return DESTROYED;
	moveq	#-3,d0
	rts
L232
;	return lock.ss_NestCount;
	move.w	$E(a1),d0
	ext.l	d0
	rts

	SECTION "MyLock__LOCK__T:0",CODE


;bool LOCK::MyLock()
	XDEF	MyLock__LOCK__T
MyLock__LOCK__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a1
L233
;	if (destructor)
	tst.l	$32(a1)
	beq.b	L235
L234
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts
L235
;	return lock.ss_Owner == ::FindTask(0);
	move.l	$28(a1),a2
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	cmp.l	a2,d0
	seq	d0
	and.l	#1,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "LockOwner__LOCK__T:0",CODE


;THREAD* LOCK::LockOwner()
	XDEF	LockOwner__LOCK__T
LockOwner__LOCK__T
	move.l	4(a7),a0
L236
;	if (lock.ss_Owner==THREAD::rootThread)
	move.l	$28(a0),a1
	cmp.l	_rootThread__THREAD,a1
	bne.b	L238
L237
;		return THREAD::Main();
	jsr	Main__THREAD_
	rts
L238
;	else if (lock.ss_Owner)
	tst.l	$28(a0)
	beq.b	L242
L239
;		THREAD* thread = (THREAD*)(lock.ss_Owner->tc_UserData);
	move.l	$28(a0),a0
	move.l	$58(a0),a0
;		if (thread && thread->classID == THREAD::IDTAG)
	cmp.w	#0,a0
	beq.b	L242
L240
	move.l	(a0),d0
	cmp.l	#$58534C54,d0
	bne.b	L242
L241
;			return thread;
	move.l	a0,d0
	rts
L242
;	return 0;
	moveq	#0,d0
	rts

	SECTION "_0ct__LOCK__T:0",CODE


;LOCK::LOCK() 
	XDEF	_0ct__LOCK__T
_0ct__LOCK__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L243
	move.l	a2,a1
	clr.l	$32(a1)
;	creator = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a2,a1
	move.l	d0,$2E(a1)
;	::InitSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$22E(a6)
	movem.l	(a7)+,a2/a6
	rts

	SECTION "_0dt__LOCK__T:0",CODE


;LOCK::~LOCK()
	XDEF	_0dt__LOCK__T
_0dt__LOCK__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L244
;	if (!destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	bne.b	L248
L245
;		destructor = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a2,a1
	move.l	d0,$32(a1)
;		::ObtainSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$234(a6)
;		while (lock.ss_NestCount)
	bra.b	L247
L246
;			::ReleaseSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$23A(a6)
L247
	move.l	a2,a0
	tst.w	$E(a0)
	bne.b	L246
L248
	movem.l	(a7)+,a2/a6
	rts

	SECTION "_0dt__IDLE__THREAD__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__IDLE__THREAD__T
_0dt__IDLE__THREAD__T
	move.l	4(a7),a0
L249
	move.l	a0,-(a7)
	jsr	_0dt__DELAY__T
	addq.w	#4,a7
	rts

	SECTION "Run__THREAD_MAIN__T:0",CODE

	CNOP	0,2

	XDEF	Run__THREAD_MAIN__T
Run__THREAD_MAIN__T
L250
	moveq	#-2,d0
	rts

	SECTION "_0virttab__12IDLE__THREAD__12IDLE__THREAD:0",CODE

	XDEF	_0virttab__12IDLE__THREAD__12IDLE__THREAD
_0virttab__12IDLE__THREAD__12IDLE__THREAD
	dc.l	$18,0
	dc.l	_0dt__IDLE__THREAD__T,0
	dc.l	$18,0
	dc.l	_0dt__IDLE__THREAD__T,0

	SECTION "_0virttab__11THREAD_MAIN__11THREAD_MAIN:0",CODE

	XDEF	_0virttab__11THREAD_MAIN__11THREAD_MAIN
_0virttab__11THREAD_MAIN__11THREAD_MAIN
	dc.l	$30,0
	dc.l	_0dt__THREAD_MAIN__T,0
	dc.l	Run__THREAD_MAIN__T,0
	dc.l	$30,0
	dc.l	_0dt__THREAD_MAIN__T,0
	dc.l	Run__THREAD_MAIN__T,0

	END
