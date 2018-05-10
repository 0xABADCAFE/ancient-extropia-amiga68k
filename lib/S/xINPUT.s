
; Storm C Compiler
; Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/IOLib/xINPUT.cpp
	mc68030
	mc68881
	XREF	Close__xFILEIO__T
	XREF	Write__xFILEIO__TPvUiUi
	XREF	Read__xFILEIO__TPvUiUi
	XREF	Open__xFILEIO__TPCcjj
	XREF	SendPacket__xFILEIO__TPv
	XREF	WaitPacket__xFILEIO__T
	XREF	InputQueued__xINPUT__T
	XREF	Idle__xINPUT__T
	XREF	ExitEvent__xINPUT__T
	XREF	MouseEvent__xINPUT__Tjjj
	XREF	ApplyInputModification__xINPUT__T
	XREF	KeyEvent__xKEY__Tjsj
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
	XREF	_KeymapBase

	SECTION "_0ct__streampos__T:0",CODE

	rts

	SECTION "_KeyMapBase:1",DATA

	XDEF	_KeyMapBase
_KeyMapBase
	dc.l	0

	SECTION "_useCount__xKEY:1",DATA

	XDEF	_useCount__xKEY
_useCount__xKEY
	dc.l	0

	SECTION "_0ct__xKEY__T:0",CODE


;xKEY::xKEY()
	XDEF	_0ct__xKEY__T
_0ct__xKEY__T
	movem.l	d2/a6,-(a7)
L48
;	if (0 == useCount++)
	move.l	_useCount__xKEY,d0
	addq.l	#1,_useCount__xKEY
	tst.l	d0
	bne.b	L51
L49
;		KeyMapBase = OpenLibrary("keymap.library", 37);
	move.l	_SysBase,a6
	moveq	#$25,d0
	move.l	#L47,a1
	jsr	-$228(a6)
	move.l	d0,_KeyMapBase
;		if (!KeyMapBase)
	tst.l	_KeyMapBase
	bne.b	L51
L50
;			useCount = 0;
	clr.l	_useCount__xKEY
L51
	movem.l	(a7)+,d2/a6
	rts

L47
	dc.b	'keymap.library',0

	SECTION "_0dt__xKEY__T:0",CODE


;xKEY::~xKEY()
	XDEF	_0dt__xKEY__T
_0dt__xKEY__T
	move.l	a6,-(a7)
L52
;	if (--useCount == 0)
	subq.l	#1,_useCount__xKEY
	tst.l	_useCount__xKEY
	bne.b	L55
L53
;		if (KeyMapBase)
	tst.l	_KeyMapBase
	beq.b	L55
L54
;			CloseLibrary(KeyMapBase);
	move.l	_KeyMapBase,a1
	move.l	_SysBase,a6
	jsr	-$19E(a6)
;			KeyMapBase = NOTSET;
	clr.l	_KeyMapBase
L55
;	if (useCount<0)
	tst.l	_useCount__xKEY
	bpl.b	L57
L56
;		useCount = 0;
	clr.l	_useCount__xKEY
L57
	move.l	(a7)+,a6
	rts

	SECTION "KeyToChar__xKEY__P12IntuiMessage:0",CODE


;sint32	xKEY::KeyToChar(IntuiMessage* m)
	XDEF	KeyToChar__xKEY__P12IntuiMessage
KeyToChar__xKEY__P12IntuiMessage
L63	EQU	-$18
	link	a5,#L63
	movem.l	a2/a6,-(a7)
	move.l	$8(a5),a1
L59
;	if (!m || ((m->Code & 0x7F) > SPACE))
	cmp.w	#0,a1
	beq.b	L61
L60
	moveq	#0,d0
	move.w	$18(a1),d0
	and.l	#$7F,d0
	cmp.l	#$40,d0
	ble.b	L62
L61
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	unlk	a5
	rts
L62
;		InputEvent	inputEvent = {
	lea	-$16(a5),a0
	clr.l	(a0)+
	move.b	#1,(a0)+
	clr.b	(a0)+
	move.w	$18(a1),(a0)+
	move.w	$1A(a1),(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
;		inputEvent.ie_EventAddress = *((uint8**)(m->IAddress));
	move.l	$1C(a1),a0
	move.l	(a0),-$C(a5)
;		char mapped[2] = "";
	move.l	#L58,a1
	lea	-$18(a5),a0
	move.b	(a1),(a0)
;		MapRawKey(&inputEvent, mapped, 2, NULL);
	move.l	_KeymapBase,a6
	moveq	#2,d1
	lea	-$16(a5),a0
	lea	-$18(a5),a1
	sub.l	a2,a2
	jsr	-$2A(a6)
	move.b	-$18(a5),d0
	extb.l	d0
	movem.l	(a7)+,a2/a6
	unlk	a5
	rts

L58
	dc.b	0

	END
