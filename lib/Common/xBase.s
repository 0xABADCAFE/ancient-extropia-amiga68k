
; Storm C Compiler
; extropialib:lib/Common/xBase.cpp
	mc68030
	mc68881
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
	XREF	Done__sysBASELIB_
	XREF	Init__sysBASELIB_
	XREF	_toupper
	XREF	_tolower
	XREF	_strcpy
	XREF	_stricmp
	XREF	_system
	XREF	_vsprintf
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
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
	XREF	_basefield__ios
	XREF	_adjustfield__ios
	XREF	_floatfield__ios
	XREF	_aNextBit__ios
	XREF	_aNextWord__ios
	XREF	_cin
	XREF	_cout
	XREF	_cerr
	XREF	_clog

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_st:2",BSS

	XDEF	_st
_st
	ds.b	512

	SECTION "_gxSt:2",BSS

	XDEF	_gxSt
_gxSt
	ds.b	256

	SECTION "_xbSt:0",CODE


	XDEF	_INIT_8_xBase_cpp__xbSt
_INIT_8_xBase_cpp__xbSt
L40
	clr.l	_xbSt+$2000
	rts

	SECTION "_xbSt:2",BSS

	XDEF	_xbSt
_xbSt
	ds.b	8196

	SECTION "F__Pce:0",CODE


;char *F(char *format,...)
	XDEF	F__Pce
F__Pce
L44	EQU	-$8
	link	a5,#L44
	move.l	a2,-(a7)
L41
;  char *s = xbSt;
	move.l	#_xbSt,a0
	addq.l	#1,$2000(a0)
	move.l	$2000(a0),d0
	cmp.l	#$1F,d0
	bls.b	L43
L42
	clr.l	$2000(a0)
L43
	move.l	$2000(a0),d0
	asl.l	#$8,d0
	lea	0(a0,d0.l),a2
;  va_start(arglist,format)
	lea	$8(a5),a0
	move.l	a0,d0
	addq.l	#4,d0
;  vsprintf(s,format,arglist);
	move.l	d0,-(a7)
	move.l	$8(a5),-(a7)
	move.l	a2,-(a7)
	jsr	_vsprintf
	add.w	#$C,a7
;  return s;
	move.l	a2,d0
	move.l	(a7)+,a2
	unlk	a5
	rts

	SECTION "Upper__PCc:0",CODE


;char *Upper(const char*st)
	XDEF	Upper__PCc
Upper__PCc
	movem.l	d2/a2/a3,-(a7)
	move.l	$10(a7),a2
L45
;  char *s = xbSt;
	move.l	#_xbSt,a0
	addq.l	#1,$2000(a0)
	move.l	$2000(a0),d0
	cmp.l	#$1F,d0
	bls.b	L47
L46
	clr.l	$2000(a0)
L47
	move.l	$2000(a0),d0
	asl.l	#$8,d0
	add.l	a0,d0
	move.l	d0,a3
;  sint32  i=0;
	moveq	#0,d2
;  while(st[i] && i<xbSt.MaxLen())
	bra.b	L49
L48
;    s[i] = toupper(st[i]);
	move.b	0(a2,d2.l),d0
	extb.l	d0
	move.l	d0,-(a7)
	jsr	_toupper
	addq.w	#4,a7
	move.b	d0,0(a3,d2.l)
;    i++;
	addq.l	#1,d2
L49
	tst.b	0(a2,d2.l)
	beq.b	L51
L50
	cmp.l	#$FF,d2
	blo.b	L48
L51
;  s[i]=0;
	clr.b	0(a3,d2.l)
;  return s;
	move.l	a3,d0
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "Lower__PCc:0",CODE


;char *Lower(const char*st)
	XDEF	Lower__PCc
Lower__PCc
	movem.l	d2/a2/a3,-(a7)
	move.l	$10(a7),a2
L52
;  char *s = xbSt;
	move.l	#_xbSt,a0
	addq.l	#1,$2000(a0)
	move.l	$2000(a0),d0
	cmp.l	#$1F,d0
	bls.b	L54
L53
	clr.l	$2000(a0)
L54
	move.l	$2000(a0),d0
	asl.l	#$8,d0
	add.l	a0,d0
	move.l	d0,a3
;  sint32  i=0;
	moveq	#0,d2
;  while(st[i] && i<xbSt.MaxLen())
	bra.b	L56
L55
;    s[i] = tolower(st[i]);
	move.b	0(a2,d2.l),d0
	extb.l	d0
	move.l	d0,-(a7)
	jsr	_tolower
	addq.w	#4,a7
	move.b	d0,0(a3,d2.l)
;    i++;
	addq.l	#1,d2
L56
	tst.b	0(a2,d2.l)
	beq.b	L58
L57
	cmp.l	#$FF,d2
	blo.b	L55
L58
;  s[i]=0;
	clr.b	0(a3,d2.l)
;  return s;
	move.l	a3,d0
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "FC__Pce:0",CODE


;char *FC(char *format,...)
	XDEF	FC__Pce
FC__Pce
L60	EQU	-4
	link	a5,#L60
L59
;  va_start(arglist,format)
	lea	$8(a5),a0
	move.l	a0,d0
	addq.l	#4,d0
;  vsprintf(st,format,arglist);
	move.l	d0,-(a7)
	move.l	$8(a5),-(a7)
	move.l	#_st,-(a7)
	jsr	_vsprintf
	add.w	#$C,a7
;  strcpy(format,st);
	move.l	#_st,-(a7)
	move.l	$8(a5),-(a7)
	jsr	_strcpy
	addq.w	#$8,a7
;  return format;
	move.l	$8(a5),d0
	unlk	a5
	rts

	SECTION "_numStartArgs__xBASELIB:1",DATA

	XDEF	_numStartArgs__xBASELIB
_numStartArgs__xBASELIB
	dc.l	0

	SECTION "_startArgs__xBASELIB:1",DATA

	XDEF	_startArgs__xBASELIB
_startArgs__xBASELIB
	dc.l	0

	SECTION "Init__xBASELIB_:0",CODE


;sint32 xBASELIB::Init()
	XDEF	Init__xBASELIB_
Init__xBASELIB_
L69	EQU	-$138
	link	a5,#L69
	movem.l	d2-d4/a2,-(a7)
L63
;  sint32 result = sysBASELIB::Init();
	jsr	Init__sysBASELIB_
;  if(result!=OK)
	tst.l	d0
	beq.b	L65
L64
;    return result;
	movem.l	(a7)+,d2-d4/a2
	unlk	a5
	rts
L65
;  char *s[] = { gxSt[1], gxSt[2], gxSt[0] };
	lea	-$10(a5),a0
	move.l	#_gxSt,a2
	lea	$20(a2),a1
	move.l	a1,(a0)+
	move.l	#_gxSt,a2
	lea	$40(a2),a1
	move.l	a1,(a0)+
	move.l	#_gxSt,(a0)
;  sint32  p=13
	moveq	#$D,d1
;  sint32  p=13, i=0;
	moveq	#0,d0
;  sint32  o[][24] = { { 70,18,13,-7,-10,13,-78,57,-24,25,-17,-6,6,
	lea	-$138(a5),a0
	move.l	#$46,(a0)+
	move.l	#$12,(a0)+
	move.l	#$D,(a0)+
	move.l	#-7,(a0)+
	move.l	#-$A,(a0)+
	move.l	#$D,(a0)+
	move.l	#-$4E,(a0)+
	move.l	#$39,(a0)+
	move.l	#-$18,(a0)+
	move.l	#$19,(a0)+
	move.l	#-$11,(a0)+
	move.l	#-6,(a0)+
	move.l	#6,(a0)+
	move.l	#-$49,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	#-$8,(a0)+
	move.l	#-4,(a0)+
	clr.l	(a0)+
	move.l	#1,(a0)+
	move.l	#-$41,(a0)+
	move.l	#-$2B,(a0)+
	move.l	#$48,(a0)+
	move.l	#$1C,(a0)+
	move.l	#$31,(a0)+
	move.l	#$9,(a0)+
	move.l	#$1F,(a0)+
	move.l	#$26,(a0)+
	move.l	#$23,(a0)+
	move.l	#$6C,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	#$1A,(a0)+
	move.l	#-$9,(a0)+
	move.l	#2,(a0)+
	move.l	#6,(a0)+
	move.l	#$4F,(a0)+
	move.l	#$2D,(a0)+
	move.l	#1,(a0)+
	move.l	#-$14,(a0)+
	move.l	#-$52,(a0)+
	move.l	#-$10,(a0)+
	move.l	#$C,(a0)+
	move.l	#$C,(a0)+
	move.l	#-$8,(a0)+
	move.l	#-3,(a0)+
	move.l	#$6F,(a0)+
	move.l	#$73,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
;  while(i<24)
	bra.b	L67
L66
;    *s[2]++ =(uint8)((*s[1]++ =(uint8)((p=*s[0]++ =(uint8)(p+o[0
	lea	-$138(a5),a0
	add.l	0(a0,d0.l*4),d1
	lea	-$10(a5),a2
	move.l	(a2),a1
	lea	1(a1),a0
	move.l	a0,(a2)
	move.b	d1,(a1)
	extb.l	d1
	lea	-$138(a5),a0
	lea	$60(a0),a0
	move.l	0(a0,d0.l*4),d2
	add.l	d1,d2
	lea	-$10(a5),a0
	lea	4(a0),a2
	move.l	(a2),a1
	lea	1(a1),a0
	move.l	a0,(a2)
	move.b	d2,(a1)
	extb.l	d2
	lea	-$138(a5),a0
	move.l	d0,d3
	addq.l	#1,d0
	lea	$C0(a0),a0
	add.l	0(a0,d3.l*4),d2
	lea	-$10(a5),a0
	lea	$8(a0),a2
	move.l	(a2),a1
	lea	1(a1),a0
	move.l	a0,(a2)
	move.b	d2,(a1)
L67
	cmp.l	#$18,d0
	blt.b	L66
L68
;  return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2
	unlk	a5
	rts

	SECTION "Init__xBASELIB__iPPc:0",CODE


;sint32 xBASELIB::Init(int argn, char** argv)
	XDEF	Init__xBASELIB__iPPc
Init__xBASELIB__iPPc
	movem.l	d2/a2,-(a7)
	movem.l	$C(a7),d2/a2
L70
;	sint32 r = xBASELIB::Init();
	jsr	Init__xBASELIB_
;	if (r==OK)
	tst.l	d0
	bne.b	L72
L71
;		numStartArgs = argn;
	move.l	d2,_numStartArgs__xBASELIB
;		startArgs = argv;
	move.l	a2,_startArgs__xBASELIB
L72
;	return r;
	movem.l	(a7)+,d2/a2
	rts

	SECTION "Done__xBASELIB_:0",CODE


;void xBASELIB::Done()
	XDEF	Done__xBASELIB_
Done__xBASELIB_
L73
;  sysBASELIB::Done();
	jsr	Done__sysBASELIB_
	rts

	SECTION "Arg__xBASELIB__PCc:0",CODE


;char* xBASELIB::Arg(const char* s)
	XDEF	Arg__xBASELIB__PCc
Arg__xBASELIB__PCc
	movem.l	d2/a2,-(a7)
	move.l	$C(a7),a2
L74
;	for (int i=0;
	moveq	#0,d2
	bra.b	L79
L75
;		if (!stricmp(startArgs[i], s))
	move.l	a2,-(a7)
	move.l	_startArgs__xBASELIB,a1
	move.l	0(a1,d2.l*4),-(a7)
	jsr	_stricmp
	addq.w	#$8,a7
	tst.l	d0
	bne.b	L78
L76
;			if (++i<numStartArgs)
	addq.l	#1,d2
	cmp.l	_numStartArgs__xBASELIB,d2
	bge.b	L78
L77
;				return startArgs[i];
	move.l	_startArgs__xBASELIB,a1
	move.l	0(a1,d2.l*4),d0
	movem.l	(a7)+,d2/a2
	rts
L78
	addq.l	#1,d2
L79
	cmp.l	_numStartArgs__xBASELIB,d2
	blt.b	L75
L80
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts

	END
