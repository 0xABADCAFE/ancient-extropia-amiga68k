
; Storm C Compiler
; Mendoza:Extropia/eXtropia/prj/VM2/Jasmine/JasmineDecode.cpp
	mc68030
	mc68881
	XREF	Signal__THREAD__TUj
	XREF	Sleep__THREAD__TUjUj
	XREF	Remove__THREAD__T
	XREF	Start__THREAD__TjUi
	XREF	Run__THREAD__T
	XREF	UnLink__xCHAINABLE__T
	XREF	ShutDown__xTHREADABLE__T
	XREF	Done__xTHREADABLE__T
	XREF	Init__xTHREADABLE__T
	XREF	_0dt__xLOCKABLE__T
	XREF	Zero__MEM__PvUi
	XREF	MessageBox__sysBASELIB__PcPcPce
	XREF	Done__xBASELIB_
	XREF	Init__xBASELIB_
	XREF	_system
	XREF	_printf
	XREF	_puts
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
	XREF	_TimerBase__xTIMABLE
	XREF	_current__xTIMABLE
	XREF	_clockFreq__xTIMABLE
	XREF	_threadCnt__xTHREADABLE
	XREF	_main__xTHREADABLE
	XREF	_threadCnt__THREAD
	XREF	_threadsIdle__THREAD

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_lock__THREADTEST:1",DATA

	XDEF	_lock__THREADTEST
_lock__THREADTEST
	dc.l	0
	ds.b	42

	SECTION "_cnt__THREADTEST:1",DATA

	XDEF	_cnt__THREADTEST
_cnt__THREADTEST
	dc.l	0

	SECTION "_0ct__THREADTEST__T:0",CODE


;THREADTEST::THREADTEST()
	XDEF	_0ct__THREADTEST__T
_0ct__THREADTEST__T
	XREF	sym_handlers
L39	EQU	-$C
	link	a5,#L39
	movem.l	d2/a2/a6,-(a7)
	move.l	$8(a5),a0
L36
	move.l	sym_handlers,a2
	move.l	#$58534C54,(a0)
	clr.l	4(a0)
	clr.l	$8(a0)
	clr.l	$14(a0)
	clr.w	$18(a0)
	clr.w	$1A(a0)
	clr.l	$1C(a0)
	lea	(a5),a1
	move.l	a0,-(a1)
	move.l	#_0dt__THREAD__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;	if (0==cnt++)
	move.l	_cnt__THREADTEST,d0
	addq.l	#1,_cnt__THREADTEST
	tst.l	d0
	bne.b	L38
L37
;	
;		InitSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	#_lock__THREADTEST,a0
	jsr	-$22E(a6)
;		puts("Semaphore created");
	move.l	#L35,-(a7)
	jsr	_puts
	addq.w	#4,a7
L38
	move.l	a2,sym_handlers
	movem.l	(a7)+,d2/a2/a6
	unlk	a5
	rts

L35
	dc.b	'Semaphore created',0

	SECTION "_0dt__THREADTEST__T:0",CODE


;THREADTEST::~THREADTEST()
	XDEF	_0dt__THREADTEST__T
_0dt__THREADTEST__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L41
;	Remove();
	move.l	a2,-(a7)
	jsr	Remove__THREAD__T
	addq.w	#4,a7
;	if (0==--cnt)
	subq.l	#1,_cnt__THREADTEST
	tst.l	_cnt__THREADTEST
	bne.b	L43
L42
;	
;		puts("Semaphore destroyed");
	move.l	#L40,-(a7)
	jsr	_puts
	addq.w	#4,a7
L43
	pea	(a2)
	jsr	Remove__THREAD__T
	addq.w	#4,a7
	move.l	(a7)+,a2
	rts

L40
	dc.b	'Semaphore destroyed',0

	SECTION "Run__THREADTEST__T:0",CODE


;sint32 THREADTEST::Run()
	XDEF	Run__THREADTEST__T
Run__THREADTEST__T
	movem.l	d2/a2/a6,-(a7)
	move.l	$10(a7),a2
L46
;	sint32 i = 0;
	moveq	#0,d2
;	while(ShutDown()==0)
	bra.b	L50
L47
;	
;		if (AttemptSemaphore(&lock))
	move.l	_SysBase,a6
	move.l	#_lock__THREADTEST,a0
	jsr	-$240(a6)
	tst.l	d0
	beq.b	L49
L48
;		
;			printf("%s i = %d\n", Name(), i);
	move.l	d2,-(a7)
	pea	$20(a2)
	move.l	#L44,-(a7)
	jsr	_printf
	add.w	#$C,a7
;			ReleaseSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	#_lock__THREADTEST,a0
	jsr	-$23A(a6)
L49
;		i++;
	addq.l	#1,d2
;		Sleep(500);
	pea	$1F4.w
	pea	$1000.w
	pea	(a2)
	jsr	Sleep__THREAD__TUjUj
	add.w	#$C,a7
L50
	moveq	#0,d0
	move.w	$1A(a2),d0
	and.l	#$20,d0
	cmp.l	#$20,d0
	seq	d0
	and.l	#1,d0
	tst.w	d0
	beq.b	L47
L51
;	ObtainSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	#_lock__THREADTEST,a0
	jsr	-$234(a6)
;	printf("%s bye!\n", Name());
	pea	$20(a2)
	move.l	#L45,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;	ReleaseSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	#_lock__THREADTEST,a0
	jsr	-$23A(a6)
	move.l	d2,d0
	movem.l	(a7)+,d2/a2/a6
	rts

L45
	dc.b	'%s bye!',$A,0
L44
	dc.b	'%s i = %d',$A,0

	SECTION "main__iPPc:0",CODE


;int main(int argc, char** argv)
	XDEF	main__iPPc
main__iPPc
	move.l	a2,-(a7)
L57
;	if (xBASELIB::Init()!=OK)
	jsr	Init__xBASELIB_
	tst.l	d0
	beq.b	L59
L58
;	
;		puts("Error initializing base library");
	move.l	#L52,-(a7)
	jsr	_puts
	addq.w	#4,a7
	moveq	#$A,d0
	move.l	(a7)+,a2
	rts
L59
;	printf("sizeof THREAD %u\n", sizeof(THREAD));
	pea	$34.w
	move.l	#L53,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;	THREADTEST* t = new THREADTEST;
	pea	$34.w
	jsr	op__new__Ui
	move.l	d0,a2
	addq.w	#4,a7
	cmp.w	#0,a2
	beq.b	L61
L60
	move.l	#_0virttab__10THREADTEST__10THREADTEST,$30(a2)
	move.l	a2,-(a7)
	jsr	_0ct__THREADTEST__T
	addq.w	#4,a7
L61
;	if (t)
	cmp.w	#0,a2
	beq.b	L64
L62
;	
;		t->Start();
	pea	$1000.w
	clr.l	-(a7)
	move.l	a2,-(a7)
	jsr	Start__THREAD__TjUi
	add.w	#$C,a7
;		sysBASELIB::MessageBox("Info", "OK", "Kill that thre
	move.l	#L54,-(a7)
	move.l	#L55,-(a7)
	move.l	#L56,-(a7)
	jsr	MessageBox__sysBASELIB__PcPcPce
	add.w	#$C,a7
;		delete t;
	cmp.w	#0,a2
	beq.b	L64
L63
	move.l	$30(a2),a0
	move.l	a2,d0
	add.l	$24(a0),d0
	move.l	d0,-(a7)
	move.l	$20(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	$30(a2),a0
	move.l	$18(a0),-(a7)
	move.l	$1C(a0),d0
	add.l	a2,d0
	move.l	d0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L64
;	xBASELIB::Done();
	jsr	Done__xBASELIB_
	moveq	#0,d0
	move.l	(a7)+,a2
	rts

L52
	dc.b	'Error initializing base library',0
L56
	dc.b	'Info',0
L54
	dc.b	'Kill that thread',0
L55
	dc.b	'OK',0
L53
	dc.b	'sizeof THREAD %u',$A,0

	SECTION "_0dt__THREAD__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__THREAD__T
_0dt__THREAD__T
	move.l	4(a7),a0
L65
	move.l	a0,-(a7)
	jsr	Remove__THREAD__T
	addq.w	#4,a7
	rts

	SECTION "_0virttab__10THREADTEST__10THREADTEST:0",CODE

	XDEF	_0virttab__10THREADTEST__10THREADTEST
_0virttab__10THREADTEST__10THREADTEST
	dc.l	$34,0
	dc.l	_0dt__THREADTEST__T,0
	dc.l	Run__THREADTEST__T,0
	dc.l	$34,0
	dc.l	_0dt__THREADTEST__T,0
	dc.l	Run__THREADTEST__T,0

	END
