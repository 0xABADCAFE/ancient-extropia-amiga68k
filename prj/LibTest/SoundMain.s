
; Storm C Compiler
; Mendoza:Extropia/eXtropia/prj/LibTest/SoundMain.cpp
	mc68030
	mc68881
	XREF	_0dt__MIXER__T
	XREF	_0ct__MIXER__TUiUjUc
	XREF	GetDMAPos__MIXER__T
	XREF	Run__MIXER__T
	XREF	_0dt__LOCK__T
	XREF	_0dt__THREAD__T
	XREF	Wake__THREAD__T
	XREF	Stop__THREAD__T
	XREF	Start__THREAD__TjUi
	XREF	Run__THREAD__T
	XREF	_0dt__DELAY__T
	XREF	_0ct__DELAY__T
	XREF	Pause__DELAY__TUj
	XREF	Pause__DELAY__TUjUj
	XREF	Abort__DELAY__T
	XREF	UnLink__xCHAINABLE__T
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__Uiss
	XREF	Done__xBASELIB_
	XREF	Init__xBASELIB_
	XREF	_system
	XREF	_printf
	XREF	_puts
	XREF	_getchar
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
	XREF	_TimerBase__MILLICLOCK
	XREF	_current__MILLICLOCK
	XREF	_clockFreq__MILLICLOCK
	XREF	_threadCnt__THREAD
	XREF	_threadsIdle__THREAD
	XREF	_rootThread__THREAD

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "main__iPPc:0",CODE


;int main(int argc, char** argv)
	XDEF	main__iPPc
main__iPPc
	movem.l	d2/a2,-(a7)
L29
;	if (xBASELIB::Init()!=OK)
	jsr	Init__xBASELIB_
	tst.l	d0
	beq.b	L31
L30
;	
;		puts("Error initialising base library");
	move.l	#L24,-(a7)
	jsr	_puts
	addq.w	#4,a7
	moveq	#$A,d0
	movem.l	(a7)+,d2/a2
	rts
L31
;	MIXER *myMixer = new MIXER(16384, 44100, 8);
	pea	$E0.w
	jsr	op__new__Ui
	move.l	d0,a2
	addq.w	#4,a7
	cmp.w	#0,a2
	beq.b	L33
L32
	move.l	#_0virttab__05MIXER__05MIXER,$2C(a2)
	move.b	#$8,-(a7)
	move.l	#$AC44,-(a7)
	pea	$4000.w
	move.l	a2,-(a7)
	jsr	_0ct__MIXER__TUiUjUc
	add.w	#$E,a7
L33
;	if (myMixer)
	cmp.w	#0,a2
	beq	L48
L34
;	
;		puts("Chose method\n1 Start()\n2 Stop()\n3 GetDMAPos()\n4 Quit");
	move.l	#L25,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		bool quit = false;
	moveq	#0,d2
;		while (!quit)
	bra	L45
L35
;		
;			switch (getchar())
	jsr	_getchar
	cmp.l	#$33,d0
	beq	L42
	bgt.b	L49
	cmp.l	#$31,d0
	beq.b	L36
	cmp.l	#$32,d0
	beq.b	L39
	bra	L44
L49
	cmp.l	#$34,d0
	beq	L43
	bra	L44
;			
;				
L36
;					if (myMixer->Start()!=OK)
	pea	$1000.w
	clr.l	-(a7)
	move.l	a2,a0
	move.l	$2C(a0),a1
	move.l	a0,d0
	add.l	$24(a1),d0
	move.l	d0,-(a7)
	move.l	$20(a1),a1
	jsr	(a1)
	add.w	#$C,a7
	tst.l	d0
	beq.b	L38
L37
;						puts("Couldn't Start()");
	move.l	#L26,-(a7)
	jsr	_puts
	addq.w	#4,a7
L38
;					
	bra.b	L45
L39
;					if (myMixer->Stop()!=OK)
	move.l	a2,a0
	move.l	$2C(a0),a1
	move.l	a0,d0
	add.l	$1C(a1),d0
	move.l	d0,-(a7)
	move.l	$18(a1),a1
	jsr	(a1)
	addq.w	#4,a7
	tst.l	d0
	beq.b	L41
L40
;						puts("Couldn't Stop()");
	move.l	#L27,-(a7)
	jsr	_puts
	addq.w	#4,a7
L41
;					
	bra.b	L45
L42
;					printf("pos = %lu\n", myMixer->GetDMAPos());
	move.l	a2,-(a7)
	jsr	GetDMAPos__MIXER__T
	addq.w	#4,a7
	move.l	d0,-(a7)
	move.l	#L28,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;					
	bra.b	L45
L43
;					quit = true;
	moveq	#1,d2
;					
L44
;					
L45
	tst.w	d2
	beq	L35
L46
;		delete myMixer;
	cmp.w	#0,a2
	beq.b	L48
L47
	move.l	$2C(a2),a0
	move.l	a2,d0
	add.l	$3C(a0),d0
	move.l	d0,-(a7)
	move.l	$38(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	$2C(a2),a0
	move.l	$30(a0),-(a7)
	move.l	$34(a0),d0
	add.l	a2,d0
	move.l	d0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L48
;	xBASELIB::Done();
	jsr	Done__xBASELIB_
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts

L25
	dc.b	'Chose method',$A,'1 Start()',$A,'2 Stop()',$A,'3 GetDMAPos()',$A,'4 '
	dc.b	'Quit',0
L26
	dc.b	'Couldn't Start()',0
L27
	dc.b	'Couldn't Stop()',0
L24
	dc.b	'Error initialising base library',0
L28
	dc.b	'pos = %lu',$A,0

	SECTION "_0virttab__05MIXER__05MIXER:0",CODE

	XDEF	_0virttab__05MIXER__05MIXER
_0virttab__05MIXER__05MIXER
	dc.l	$E0,0
	dc.l	_0dt__MIXER__T,0
	dc.l	Wake__THREAD__T,0
	dc.l	Stop__THREAD__T,0
	dc.l	Start__THREAD__TjUi,0
	dc.l	Run__MIXER__T,0
	dc.l	$E0,0
	dc.l	_0dt__MIXER__T,0
	dc.l	Run__MIXER__T,0

	END
