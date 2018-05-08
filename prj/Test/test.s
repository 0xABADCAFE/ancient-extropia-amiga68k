
; Storm C Compiler
; Mendoza:Extropia/eXtropia/prj/Test/test.cpp
	mc68030
	mc68881
	XREF	_Normalize
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
	XREF	Elapsed__MILLICLOCK__T
	XREF	UnLink__xCHAINABLE__T
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__Uiss
	XREF	Done__xBASELIB_
	XREF	Init__xBASELIB_
	XREF	_system
	XREF	_printf
	XREF	_puts
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

	SECTION "_funky:1",DATA

	XDEF	_funky
_funky
	dc.l	$12345678

	SECTION "main_:0",CODE


;int main()
	XDEF	main_
main_
L35	EQU	-$2C
	link	a5,#L35
	movem.l	d2/a6,-(a7)
L27
;	if (xBASELIB::Init()!=OK)
	jsr	Init__xBASELIB_
	tst.l	d0
	beq.b	L29
L28
;		puts("Base Library initialization failed");
	move.l	#L21,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		return 10;
	moveq	#$A,d0
	movem.l	(a7)+,d2/a6
	unlk	a5
	rts
L29
;	if (!sysBASELIB::PPCAvailable())
	tst.l	_PowerPCBase
	sne	d0
	and.l	#1,d0
	tst.w	d0
	bne.b	L31
L30
;		puts("PowerPC not available");
	move.l	#L22,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		xBASELIB::Done();
	jsr	Done__xBASELIB_
;		return 10;
	moveq	#$A,d0
	movem.l	(a7)+,d2/a6
	unlk	a5
	rts
L31
;	sint16* p = (sint16*)MEM::Alloc(1024*1024*sizeof(sint16), false, t
	move.w	#1,-(a7)
	clr.w	-(a7)
	move.l	#$200000,-(a7)
	jsr	Alloc__MEM__Uiss
	addq.w	#$8,a7
	move.l	d0,-4(a5)
;	if (p)
	tst.l	-4(a5)
	beq	L33
L32
;		MILLICLOCK t;
	lea	-$C(a5),a0
	move.l	a0,-$2C(a5)
	move.l	#_current__MILLICLOCK,a0
	move.l	_TimerBase,a6
	jsr	-$3C(a6)
	move.l	d0,_clockFreq__MILLICLOCK
	lea	_current__MILLICLOCK,a0
	move.l	a0,a1
	move.l	-$2C(a5),a0
	move.l	(a1),(a0)
	move.l	4(a1),4(a0)
;		printf("Testing 68K...\n");
	move.l	#L23,-(a7)
	jsr	_printf
	addq.w	#4,a7
;		t.Set();
	lea	-$C(a5),a0
	move.l	a0,-$24(a5)
	move.l	#_current__MILLICLOCK,a0
	move.l	_TimerBase,a6
	jsr	-$3C(a6)
	lea	_current__MILLICLOCK,a0
	move.l	a0,a1
	move.l	-$24(a5),a0
	move.l	(a1),(a0)
	move.l	4(a1),4(a0)
;		Normalize68K(p,1024*1024);
	move.l	#$100000,-(a7)
	move.l	-4(a5),-(a7)
	jsr	Normalize68K__Psj
	addq.w	#$8,a7
;		time68k = t.Elapsed();
	lea	-$C(a5),a0
	move.l	a0,-(a7)
	jsr	Elapsed__MILLICLOCK__T
	addq.w	#4,a7
	move.l	d0,d2
;		printf("Took %ld ms\nTesting PPC...\n", time68k);
	move.l	d2,-(a7)
	move.l	#L24,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;		t.Set();
	lea	-$C(a5),a0
	move.l	a0,-$28(a5)
	move.l	#_current__MILLICLOCK,a0
	move.l	_TimerBase,a6
	jsr	-$3C(a6)
	lea	_current__MILLICLOCK,a0
	move.l	a0,a1
	move.l	-$28(a5),a0
	move.l	(a1),(a0)
	move.l	4(a1),4(a0)
;		Normalize(p,1024*1024);
	move.l	-4(a5),d0
	move.l	#$100000,d1
	jsr	_Normalize
;		timePPC = t.Elapsed();
	lea	-$C(a5),a0
	move.l	a0,-(a7)
	jsr	Elapsed__MILLICLOCK__T
	addq.w	#4,a7
;		printf("Took %ld ms, gain %5.2lf\n", timePPC, (float64)time68k/(
	fmove.l	d2,fp0
	fmove.l	d0,fp1
	fdiv.x	fp1,fp0
	fmove.d	fp0,-(a7)
	move.l	d0,-(a7)
	move.l	#L25,-(a7)
	jsr	_printf
	add.w	#$10,a7
;		MEM::Free(p);
	move.l	-4(a5),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
	lea	-$C(a5),a0
	bra.b	L34
L33
;		puts("Allocation failed");
	move.l	#L26,-(a7)
	jsr	_puts
	addq.w	#4,a7
L34
;	xBASELIB::Done();
	jsr	Done__xBASELIB_
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a6
	unlk	a5
	rts

L26
	dc.b	'Allocation failed',0
L21
	dc.b	'Base Library initialization failed',0
L22
	dc.b	'PowerPC not available',0
L23
	dc.b	'Testing 68K...',$A,0
L24
	dc.b	'Took %ld ms',$A,'Testing PPC...',$A,0
L25
	dc.b	'Took %ld ms, gain %5.2lf',$A,0

	SECTION "Normalize68K__Psj:0",CODE


;void Normalize68K(sint16 *p, sint32 num)
	XDEF	Normalize68K__Psj
Normalize68K__Psj
	movem.l	d2-d5/a2,-(a7)
	fmovem.x fp2,-(a7)
	move.l	$28(a7),d3
	move.l	$24(a7),a2
L36
;	rsint32 peak = 0;
	moveq	#0,d1
;	for (t=p, i=0;
	move.l	a2,a0
	moveq	#0,d0
	bra.b	L41
L37
;		rsint16 tmp = *t++;
	move.l	a0,a1
	addq.w	#2,a0
	move.w	(a1),d2
;		if ((tmp<(-peak)) || (tmp>peak))
	move.w	d2,d5
	ext.l	d5
	move.l	d1,d4
	neg.l	d4
	cmp.l	d4,d5
	blt.b	L39
L38
	move.w	d2,d4
	ext.l	d4
	cmp.l	d1,d4
	ble.b	L40
L39
;			peak = tmp;
	move.w	d2,d1
	ext.l	d1
L40
	addq.l	#1,d0
L41
	cmp.l	d3,d0
	blt.b	L37
L42
;	if (peak)
	tst.l	d1
	beq.b	L49
L43
;		rfloat32 factor = 32768.0 / (float32)((peak<0) ? -peak : peak);
	tst.l	d1
	bpl.b	L45
L44
	neg.l	d1
L45
L46
	fmove.l	d1,fp0
	fmove.d	#$.40E00000.00000000,fp1
	fdiv.x	fp0,fp1
	fmove.x	fp1,fp0
	fmove.x	fp0,fp1
;		for (t=p, i=0;
	move.l	a2,a0
	moveq	#0,d0
	bra.b	L48
L47
;			*t = (sint16)((float32)(*t) * factor);
	move.w	(a0),d1
	ext.l	d1
	fmove.l	d1,fp0
	fmul.x	fp1,fp0
	fmove.l	fp0,d1
	move.w	d1,(a0)
	addq.l	#1,d0
	addq.w	#2,a0
L48
	cmp.l	d3,d0
	blt.b	L47
L49
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d5/a2
	rts

	END
