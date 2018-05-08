
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineObject.cpp
	mc68030
	mc68881
	XREF	_0ct__XSFOBJ__TPCcUsUsUcUc
	XREF	_0ct__XSFOBJ__T
	XREF	Set__XSFHEAD__TPCcUcUcUcUc
	XREF	op__equal__XSFHEAD__TR05XSFIO
	XREF	op__equal__XSFHEAD__TR07XSFHEAD
	XREF	op__notEqual__XSFHEAD__TR07XSFHEAD
	XREF	Value__XDATAID__TPCc
	XREF	Close__xFILEIO__T
	XREF	Flush__xFILEIO__T
	XREF	Write64Swap__xFILEIO__TPvUi
	XREF	Write32Swap__xFILEIO__TPvUi
	XREF	Write16Swap__xFILEIO__TPvUi
	XREF	Write__xFILEIO__TPvUiUi
	XREF	Read64Swap__xFILEIO__TPvUi
	XREF	Read32Swap__xFILEIO__TPvUi
	XREF	Read16Swap__xFILEIO__TPvUi
	XREF	Read__xFILEIO__TPvUiUi
	XREF	Tell__xFILEIO__T
	XREF	Seek__xFILEIO__Tjj
	XREF	Open__xFILEIO__TPCcjj
	XREF	SendPacket__xFILEIO__TPv
	XREF	WaitPacket__xFILEIO__T
	XREF	InputQueued__xINPUT__T
	XREF	Idle__xINPUT__T
	XREF	ExitEvent__xINPUT__T
	XREF	MouseEvent__xINPUT__Tjjj
	XREF	ApplyInputModification__xINPUT__T
	XREF	_0dt__xKEY__T
	XREF	_0ct__xKEY__T
	XREF	KeyEvent__xKEY__Tjsj
	XREF	_memset
	XREF	_strncpy
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
	XREF	_KeymapBase
	XREF	_useCount__xKEY
	XREF	_sigXSF__XSFHEAD
	XREF	_fileMarker__XSFOBJ

	SECTION ":0",CODE


;JASMINEOBJECT::JASMINEOBJECT() 
	XDEF	_0ct__JASMINEOBJECT__T
_0ct__JASMINEOBJECT__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L68
	clr.b	-(a7)
	move.b	#1,-(a7)
	clr.w	-(a7)
	clr.w	-(a7)
	move.l	_XSFIDString__JASMINEOBJECT,-(a7)
	move.l	a2,-(a7)
	jsr	_0ct__XSFOBJ__TPCcUsUsUcUc
	add.w	#$10,a7
	lea	$20(a2),a0
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$8(a0)
	clr.l	$C(a0)
	clr.l	$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
	clr.l	$20(a0)
	clr.l	$24(a0)
	clr.l	$28(a0)
	clr.l	$2C(a0)
	clr.l	$30(a0)
	move.l	#$BABECAFE,$34(a0)
	lea	$58(a2),a0
	clr.w	(a0)
	clr.w	2(a0)
	pea	$20.w
	clr.l	-(a7)
	pea	$5C(a2)
	jsr	_memset
	add.w	#$C,a7
	clr.l	$80(a2)
	clr.l	$84(a2)
	clr.l	$88(a2)
;	RawSize(sizeof(shared32)+sizeof(shared16)+sizeof(shared8));
	move.l	#$5C,$C(a2)
	move.l	(a7)+,a2
	rts

;JASMINEOBJECT::~JASMINEOBJECT()
	XDEF	_0dt__JASMINEOBJECT__T
_0dt__JASMINEOBJECT__T
	move.l	4(a7),a0
L69
;	Free();
	move.l	a0,-(a7)
	jsr	Free__JASMINEOBJECT__T
	addq.w	#4,a7
	rts

;void	JASMINEOBJECT::Free()
	XDEF	Free__JASMINEOBJECT__T
Free__JASMINEOBJECT__T
	movem.l	d2/a2/a3,-(a7)
	move.l	$10(a7),a3
L70
;	if (funcTab)
	move.l	a3,a1
	tst.l	$7C(a1)
	beq.b	L77
L71
;		delete[] funcTab;
	move.l	a3,a1
	move.l	$7C(a1),a0
	cmp.w	#0,a0
	beq.b	L80
L72
	move.l	a0,a2
	XREF	blocksize_a2_d2
	jsr	blocksize_a2_d2
	bra.b	L74
L73
	add.w	#$10,a2
L74
	sub.l	#$10,d2
	bpl.b	L73
L75
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L76
	bra.b	L80
L77
;	else if (code)
	move.l	a3,a1
	tst.l	$80(a1)
	beq.b	L80
L78
;		delete[] code;
	move.l	a3,a1
	move.l	$80(a1),a0
	cmp.w	#0,a0
	beq.b	L80
L79
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L80
;	if (constData)
	move.l	a3,a1
	tst.l	$88(a1)
	beq.b	L83
L81
;		delete[] constData;
	move.l	a3,a1
	move.l	$88(a1),a0
	cmp.w	#0,a0
	beq.b	L83
L82
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L83
;	if (wrtblData)
	move.l	a3,a1
	tst.l	$84(a1)
	beq.b	L86
L84
;		delete[] wrtblData;
	move.l	a3,a1
	move.l	$84(a1),a0
	cmp.w	#0,a0
	beq.b	L86
L85
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L86
;	funcTab = 0;
	move.l	a3,a1
	clr.l	$7C(a1)
;	code = 0;
	move.l	a3,a1
	clr.l	$80(a1)
;	wrtblData = 0;
	move.l	a3,a1
	clr.l	$84(a1)
;	constData = 0;
	move.l	a3,a1
	clr.l	$88(a1)
;	RawSize(sizeof(shared32));
	move.l	#$38,$C(a3)
	movem.l	(a7)+,d2/a2/a3
	rts

;sint32 JASMINEOBJECT::ReadBody(XSFIO& f)
	XDEF	ReadBody__JASMINEOBJECT__TR05XSFIO
ReadBody__JASMINEOBJECT__TR05XSFIO
	movem.l	a2/a3,-(a7)
	movem.l	$C(a7),a2/a3
L87
;	Free();
	move.l	a2,-(a7)
	jsr	Free__JASMINEOBJECT__T
	addq.w	#4,a7
;	f.Read32(&shared32, sizeof(shared32)/sizeof(uint32));
	pea	$E.w
	pea	$20(a2)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	f.Read16(&shared16, sizeof(shared16)/sizeof(uint16));
	pea	2.w
	pea	$58(a2)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$84(a0),d0
	move.l	d0,-(a7)
	move.l	$80(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	f.Read8(&shared8, 	sizeof(shared8));
	pea	$20.w
	pea	$5C(a2)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$8C(a0),d0
	move.l	d0,-(a7)
	move.l	$88(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	if (Alloc()!= OK)
	move.l	a2,-(a7)
	jsr	Alloc__JASMINEOBJECT__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L89
L88
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,a2/a3
	rts
L89
;	if (funcTab && shared32.funcTabLen)
	tst.l	$7C(a2)
	beq.b	L92
L90
	tst.l	$20(a2)
	beq.b	L92
L91
;		f.Read32(funcTab, shared32.funcTabLen*(sizeof(JFINFO)/sizeof(uin
	move.l	$20(a2),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	move.l	$7C(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L92
;	if (code && shared32.codeLen)
	tst.l	$80(a2)
	beq.b	L95
L93
	tst.l	$24(a2)
	beq.b	L95
L94
;		f.Read32(code, shared32.codeLen);
	move.l	$24(a2),-(a7)
	move.l	$80(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L95
;	if (wrtblData && shared32.data64Len)
	tst.l	$84(a2)
	beq.b	L98
L96
	tst.l	$28(a2)
	beq.b	L98
L97
;		f.Read64(wrtblData, shared32.data64Len/sizeof(uint64));
	move.l	$28(a2),d0
	moveq	#3,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	$84(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$74(a0),d0
	move.l	d0,-(a7)
	move.l	$70(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L98
;	if (constData && shared32.const64Len)
	tst.l	$88(a2)
	beq.b	L101
L99
	tst.l	$38(a2)
	beq.b	L101
L100
;		f.Read64(constData, shared32.const64Len/sizeof(uint64));
	move.l	$38(a2),d0
	moveq	#3,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	$88(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$74(a0),d0
	move.l	d0,-(a7)
	move.l	$70(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L101
;	if (wrtblData && shared32.data32Len)
	tst.l	$84(a2)
	beq.b	L104
L102
	tst.l	$2C(a2)
	beq.b	L104
L103
;		uint32* p = (uint32*)((uint8*)wrtblData + shared32.data64Len);
	move.l	$28(a2),d0
	move.l	$84(a2),a1
	add.l	d0,a1
;		f.Read32(p, shared32.data32Len/sizeof(uint32));
	move.l	$2C(a2),d0
	moveq	#2,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L104
;	if (constData && shared32.const32Len)
	tst.l	$88(a2)
	beq.b	L107
L105
	tst.l	$3C(a2)
	beq.b	L107
L106
;		uint32* p = (uint32*)((uint8*)constData + shared32.const64Len);
	move.l	$38(a2),d0
	move.l	$88(a2),a1
	add.l	d0,a1
;		f.Read32(p, shared32.const32Len/sizeof(uint32));
	move.l	$3C(a2),d0
	moveq	#2,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L107
;	if (wrtblData && shared32.data16Len)
	tst.l	$84(a2)
	beq.b	L110
L108
	tst.l	$30(a2)
	beq.b	L110
L109
;		uint16* p = (uint16*)((uint8*)wrtblData + shared32.data64Len + s
	move.l	$28(a2),d0
	move.l	$84(a2),a1
	add.l	d0,a1
	move.l	$2C(a2),d0
	add.l	d0,a1
;		f.Read16(p, shared32.data16Len/sizeof(uint16));
	move.l	$30(a2),d0
	moveq	#1,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$84(a0),d0
	move.l	d0,-(a7)
	move.l	$80(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L110
;	if (constData && shared32.const16Len)
	tst.l	$88(a2)
	beq.b	L113
L111
	tst.l	$40(a2)
	beq.b	L113
L112
;		uint16* p = (uint16*)((uint8*)constData + shared32.data64Len + s
	move.l	$28(a2),d0
	move.l	$88(a2),a1
	add.l	d0,a1
	move.l	$2C(a2),d0
	add.l	d0,a1
;		f.Read16(p, shared32.const16Len/sizeof(uint16));
	move.l	$40(a2),d0
	moveq	#1,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$84(a0),d0
	move.l	d0,-(a7)
	move.l	$80(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L113
;	if (wrtblData && shared32.data8Len)
	tst.l	$84(a2)
	beq.b	L116
L114
	tst.l	$34(a2)
	beq.b	L116
L115
;		uint8* p = ((uint8*)wrtblData + shared32.data64Len + shared32.da
	move.l	$28(a2),d0
	move.l	$84(a2),a1
	add.l	d0,a1
	move.l	$2C(a2),d0
	add.l	d0,a1
	move.l	$30(a2),d0
	add.l	d0,a1
;		f.Read8(p, shared32.data8Len);
	move.l	$34(a2),-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$8C(a0),d0
	move.l	d0,-(a7)
	move.l	$88(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L116
;	if (constData && shared32.const8Len)
	tst.l	$88(a2)
	beq.b	L119
L117
	tst.l	$44(a2)
	beq.b	L119
L118
;		uint8* p = ((uint8*)constData + shared32.const64Len + shared32.c
	move.l	$38(a2),d0
	move.l	$88(a2),a1
	add.l	d0,a1
	move.l	$3C(a2),d0
	add.l	d0,a1
	move.l	$40(a2),d0
	add.l	d0,a1
;		f.Read8(p, shared32.const8Len);
	move.l	$44(a2),-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$8C(a0),d0
	move.l	d0,-(a7)
	move.l	$88(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L119
;	return RawSize();
	move.l	$C(a2),d0
	movem.l	(a7)+,a2/a3
	rts

;sint32 JASMINEOBJECT::WriteBody(XSFIO& f)
	XDEF	WriteBody__JASMINEOBJECT__TR05XSFIO
WriteBody__JASMINEOBJECT__TR05XSFIO
	movem.l	a2/a3,-(a7)
	movem.l	$C(a7),a2/a3
L120
;	f.Write32(&shared32,	sizeof(shared32)/sizeof(uint32));
	pea	$E.w
	pea	$20(a2)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	f.Write16(&shared16,	sizeof(shared16)/sizeof(uint16));
	pea	2.w
	pea	$58(a2)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	f.Write8(&shared8,		sizeof(shared8));
	pea	$20.w
	pea	$5C(a2)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	if (funcTab)
	tst.l	$7C(a2)
	beq.b	L122
L121
;		f.Write32(funcTab, shared32.funcTabLen*(sizeof(JFINFO)/sizeof(ui
	move.l	$20(a2),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	move.l	$7C(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L122
;	if (code)
	tst.l	$80(a2)
	beq.b	L124
L123
;		f.Write32(code, shared32.codeLen);
	move.l	$24(a2),-(a7)
	move.l	$80(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L124
;	if (wrtblData && shared32.data64Len)
	tst.l	$84(a2)
	beq.b	L127
L125
	tst.l	$28(a2)
	beq.b	L127
L126
;		f.Write64(wrtblData, shared32.data64Len/sizeof(uint64));
	move.l	$28(a2),d0
	moveq	#3,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	$84(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$54(a0),d0
	move.l	d0,-(a7)
	move.l	$50(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L127
;	if (constData && shared32.const64Len)
	tst.l	$88(a2)
	beq.b	L130
L128
	tst.l	$38(a2)
	beq.b	L130
L129
;		f.Write64(constData, shared32.const64Len/sizeof(uint64));
	move.l	$38(a2),d0
	moveq	#3,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	$88(a2),-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$54(a0),d0
	move.l	d0,-(a7)
	move.l	$50(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L130
;	if (wrtblData && shared32.data32Len)
	tst.l	$84(a2)
	beq.b	L133
L131
	tst.l	$2C(a2)
	beq.b	L133
L132
;		uint32* p = (uint32*)((uint8*)wrtblData + shared32.data64Len);
	move.l	$28(a2),d0
	move.l	$84(a2),a1
	add.l	d0,a1
;		f.Write32(p, shared32.data32Len/sizeof(uint32));
	move.l	$2C(a2),d0
	moveq	#2,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L133
;	if (constData && shared32.const32Len)
	tst.l	$88(a2)
	beq.b	L136
L134
	tst.l	$3C(a2)
	beq.b	L136
L135
;		uint32* p = (uint32*)((uint8*)constData + shared32.const64Len);
	move.l	$38(a2),d0
	move.l	$88(a2),a1
	add.l	d0,a1
;		f.Write32(p, shared32.const32Len/sizeof(uint32));
	move.l	$3C(a2),d0
	moveq	#2,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L136
;	if (wrtblData && shared32.data16Len)
	tst.l	$84(a2)
	beq	L139
L137
	tst.l	$30(a2)
	beq	L139
L138
;		uint16* p = (uint16*)((uint8*)wrtblData + shared32.data64Len + s
	move.l	$28(a2),d0
	move.l	$84(a2),a1
	add.l	d0,a1
	move.l	$2C(a2),d0
	add.l	d0,a1
;		f.Write16(p, shared32.data16Len/sizeof(uint16));
	move.l	$30(a2),d0
	moveq	#1,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L139
;	if (constData && shared32.const16Len)
	tst.l	$88(a2)
	beq	L142
L140
	tst.l	$40(a2)
	beq	L142
L141
;		uint16* p = (uint16*)((uint8*)constData + shared32.data64Len + s
	move.l	$28(a2),d0
	move.l	$88(a2),a1
	add.l	d0,a1
	move.l	$2C(a2),d0
	add.l	d0,a1
;		f.Write16(p, shared32.const16Len/sizeof(uint16));
	move.l	$40(a2),d0
	moveq	#1,d1
	lsr.l	d1,d0
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L142
;	if (wrtblData && shared32.data8Len)
	tst.l	$84(a2)
	beq	L145
L143
	tst.l	$34(a2)
	beq	L145
L144
;		uint8* p = ((uint8*)wrtblData + shared32.data64Len + shared32.da
	move.l	$28(a2),d0
	move.l	$84(a2),a1
	add.l	d0,a1
	move.l	$2C(a2),d0
	add.l	d0,a1
	move.l	$30(a2),d0
	add.l	d0,a1
;		f.Write8(p, shared32.data8Len);
	move.l	$34(a2),-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L145
;	if (constData && shared32.const8Len)
	tst.l	$88(a2)
	beq	L148
L146
	tst.l	$44(a2)
	beq	L148
L147
;		uint8* p = ((uint8*)constData + shared32.const64Len + shared32.c
	move.l	$38(a2),d0
	move.l	$88(a2),a1
	add.l	d0,a1
	move.l	$3C(a2),d0
	add.l	d0,a1
	move.l	$40(a2),d0
	add.l	d0,a1
;		f.Write8(p, shared32.const8Len);
	move.l	$44(a2),-(a7)
	move.l	a1,-(a7)
	move.l	a3,a1
	move.l	(a1),a0
	move.l	a3,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L148
;	return RawSize();
	move.l	$C(a2),d0
	movem.l	(a7)+,a2/a3
	rts

;sint32 JASMINEOBJECT::Alloc()
	XDEF	Alloc__JASMINEOBJECT__T
Alloc__JASMINEOBJECT__T
	movem.l	d2/d3/a2,-(a7)
	move.l	$10(a7),a2
L149
;	size_t codeTabSize = shared32.funcTabLen*(sizeof(JFINFO)/sizeof(ui
	move.l	$20(a2),d2
	moveq	#2,d0
	asl.l	d0,d2
;	if ((shared32.codeLen+codeTabSize)!=0)
	move.l	$24(a2),d0
	add.l	d2,d0
	beq	L159
L150
;		uint32* space = new uint32[shared32.codeLen+codeTabSize];
	move.l	$24(a2),d0
	add.l	d2,d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	d0,a0
;		if (!space)
	cmp.w	#0,a0
	bne.b	L152
L151
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L152
;		if (codeTabSize)
	tst.l	d2
	beq.b	L154
L153
;			funcTab = (JFINFO*)space;
	move.l	a0,$7C(a2)
	bra.b	L155
L154
;			funcTab = 0;
	clr.l	$7C(a2)
L155
;		if (shared32.codeLen)
	tst.l	$24(a2)
	beq.b	L157
L156
;			code = space + codeTabSize;
	lea	0(a0,d2.l*4),a0
	move.l	a0,$80(a2)
	bra.b	L160
L157
;			code = 0;
	clr.l	$80(a2)
L158
	bra.b	L160
L159
;		code = 0;
	clr.l	$80(a2)
;		funcTab = 0;
	clr.l	$7C(a2)
L160
;	size_t totalSize = sizeof(shared32) + shared32.codeLen*sizeof(uint
	move.l	$24(a2),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,d2
	add.l	#$38,d2
;	size_t dataSize = shared32.data64Len + shared32.data32Len +
	move.l	$28(a2),d0
	add.l	$2C(a2),d0
	add.l	$30(a2),d0
	add.l	$34(a2),d0
;	totalSize += dataSize;
	add.l	d0,d2
;	if (dataSize)
	tst.l	d0
	beq	L167
L161
;		wrtblData = new uint64[dataSize/sizeof(uint64) +
	move.l	d0,d1
	moveq	#3,d3
	lsr.l	d3,d1
	and.l	#7,d0
	beq.b	L163
L162
	moveq	#1,d0
	bra.b	L164
L163
	moveq	#0,d0
L164
	add.l	d0,d1
	move.l	d1,d0
	moveq	#3,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	d0,$84(a2)
;		if (!wrtblData)
	tst.l	$84(a2)
	bne.b	L168
L165
;			Free();
	move.l	a2,-(a7)
	jsr	Free__JASMINEOBJECT__T
	addq.w	#4,a7
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L166
	bra.b	L168
L167
;		wrtblData = 0;
	clr.l	$84(a2)
L168
;	dataSize = shared32.const64Len + shared32.const32Len +
	move.l	$38(a2),d0
	add.l	$3C(a2),d0
	add.l	$40(a2),d0
	add.l	$44(a2),d0
;	totalSize += dataSize;
	add.l	d0,d2
;	if (dataSize)
	tst.l	d0
	beq	L175
L169
;		constData = new uint64[dataSize/sizeof(uint64) +
	move.l	d0,d1
	moveq	#3,d3
	lsr.l	d3,d1
	and.l	#7,d0
	beq.b	L171
L170
	moveq	#1,d0
	bra.b	L172
L171
	moveq	#0,d0
L172
	add.l	d0,d1
	move.l	d1,d0
	moveq	#3,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	d0,$88(a2)
;		if (!constData)
	tst.l	$88(a2)
	bne	L176
L173
;			Free();
	move.l	a2,-(a7)
	jsr	Free__JASMINEOBJECT__T
	addq.w	#4,a7
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L174
	bra.b	L176
L175
;		constData = 0;
	clr.l	$88(a2)
L176
;	RawSize(totalSize);
	move.l	d2,$C(a2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts

;uint32	JASMINEOBJECT::FuncSize()		
	XDEF	FuncSize__JASMINEOBJECT__T
FuncSize__JASMINEOBJECT__T
	move.l	4(a7),a0
L177
; return (shared32.funcTabLen);
	move.l	$20(a0),d0
	rts

;uint32	JASMINEOBJECT::CodeSize()		
	XDEF	CodeSize__JASMINEOBJECT__T
CodeSize__JASMINEOBJECT__T
	move.l	4(a7),a0
L178
; return (shared32.codeLen);
	move.l	$24(a0),d0
	rts

;uint32	JASMINEOBJECT::DataSize()		
	XDEF	DataSize__JASMINEOBJECT__T
DataSize__JASMINEOBJECT__T
	move.l	4(a7),a0
L179
; return (shared32.data64Len+shared32.data32Len+shared32.data16Len+s
	move.l	$28(a0),d0
	add.l	$2C(a0),d0
	add.l	$30(a0),d0
	add.l	$34(a0),d0
	rts

;uint32	JASMINEOBJECT::CnstSize()		
	XDEF	CnstSize__JASMINEOBJECT__T
CnstSize__JASMINEOBJECT__T
	move.l	4(a7),a0
L180
; return (shared32.const64Len+shared32.const32Len+shared32.const16Le
	move.l	$38(a0),d0
	add.l	$3C(a0),d0
	add.l	$40(a0),d0
	add.l	$44(a0),d0
	rts

;JFINFO*	JASMINEOBJECT::Method(uint32 n)
	XDEF	Method__JASMINEOBJECT__TUj
Method__JASMINEOBJECT__TUj
	move.l	$8(a7),d1
	move.l	4(a7),a0
L181
;	if (n > shared32.funcTabLen || !funcTab)
	cmp.l	$20(a0),d1
	bhi.b	L183
L182
	tst.l	$7C(a0)
	bne.b	L184
L183
;		return 0;
	moveq	#0,d0
	rts
L184
;	return &funcTab[n];
	move.l	d1,d0
	asl.l	#4,d0
	add.l	$7C(a0),d0
	rts

;void JASMINEOBJECT::ListMethods()
	XDEF	ListMethods__JASMINEOBJECT__T
ListMethods__JASMINEOBJECT__T
	movem.l	d2/a2,-(a7)
	move.l	$C(a7),a2
L189
;	if (shared32.funcTabLen && funcTab)
	tst.l	$20(a2)
	beq	L195
L190
	tst.l	$7C(a2)
	beq	L195
L191
;		puts("+-------------------------------------+");
	move.l	#L185,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		printf("| %-35s |\n", shared8.progName);
	pea	$5C(a2)
	move.l	#L186,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;		puts("+-------------------------------------+");
	move.l	#L185,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		puts("| Func   Offset Name key   Sign. key  |");
	move.l	#L187,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		for (sint32 i=0;
	moveq	#0,d2
	bra	L193
L192
;			printf("| %4d %8d 0x%08X 0x%08X |\n", i, funcTab[i].offset,
	move.l	d2,d0
	asl.l	#4,d0
	move.l	$7C(a2),a0
	lea	0(a0,d0.l),a0
	move.l	$C(a0),-(a7)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	$7C(a2),a0
	lea	0(a0,d0.l),a0
	move.l	$8(a0),-(a7)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	$7C(a2),a0
	move.l	0(a0,d0.l),-(a7)
	move.l	d2,-(a7)
	move.l	#L188,-(a7)
	jsr	_printf
	add.w	#$14,a7
	addq.l	#1,d2
L193
	cmp.l	$20(a2),d2
	blo.b	L192
L194
;		puts("+-------------------------------------+");
	move.l	#L185,-(a7)
	jsr	_puts
	addq.w	#4,a7
L195
	movem.l	(a7)+,d2/a2
	rts

;JASMINEOBJECT* JASMINEFACTORY::Create(char* n, sint16 v
	XDEF	Create__JASMINEFACTORY__PcssUiUiUiUiUiUiUiUiUiUiUiUiUi
Create__JASMINEFACTORY__PcssUiUiUiUiUiUiUiUiUiUiUiUiUi
L217	EQU	-$8
	link	a5,#L217
	movem.l	d2-d7/a2/a3,-(a7)
	move.l	$18(a5),d2
	move.l	$40(a5),d3
	move.l	$30(a5),d4
	move.l	$2C(a5),d5
	move.l	$28(a5),d6
	move.l	$24(a5),d7
	move.l	$8(a5),a3
L196
;	JASMINEOBJECT* j = new JASMINEOBJECT;
	pea	$8C.w
	jsr	op__new__Ui
	move.l	d0,a2
	addq.w	#4,a7
	cmp.w	#0,a2
	beq	L198
L197
	move.l	#_0virttab__13JASMINEOBJECT__13JASMINEOBJECT,$1C(a2)
	move.l	a2,-(a7)
	jsr	_0ct__JASMINEOBJECT__T
	addq.w	#4,a7
L198
;	if (!j)
	cmp.w	#0,a2
	bne.b	L200
L199
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3
	unlk	a5
	rts
L200
;	j->shared32.funcTabLen		= F;
	move.l	$10(a5),$20(a2)
;	j->shared32.codeLen				= (I&1) ? I+1 : I;
	move.l	$14(a5),d0
	and.l	#1,d0
	beq.b	L203
L201
	addq.l	#1,$14(a5)
L202
L203
	move.l	$14(a5),$24(a2)
;	j->shared32.data64Len			= D64*sizeof(uint64);
	move.l	d7,d0
	moveq	#3,d1
	asl.l	d1,d0
	move.l	d0,$28(a2)
;	j->shared32.data32Len			= D32*sizeof(uint32);
	move.l	d6,d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,$2C(a2)
;	j->shared32.data16Len			= D16*sizeof(uint16);
	move.l	d5,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,$30(a2)
;	j->shared32.data8Len			= D8 + (D8 ? 4 - (D8&3) : 0);
	tst.l	d4
	beq	L205
L204
	move.l	d4,d0
	and.l	#3,d0
	moveq	#4,d1
	sub.l	d0,d1
	move.l	d1,d0
	bra.b	L206
L205
	moveq	#0,d0
L206
	add.l	d0,d4
	move.l	d4,$34(a2)
;	j->shared32.const64Len		= D64*sizeof(uint64);
	move.l	d7,d0
	moveq	#3,d1
	asl.l	d1,d0
	move.l	d0,$38(a2)
;	j->shared32.const32Len		= D32*sizeof(uint32);
	move.l	d6,d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,$3C(a2)
;	j->shared32.const16Len		= D16*sizeof(uint16);
	moveq	#1,d0
	asl.l	d0,d5
	move.l	d5,$40(a2)
;	j->shared32.const8Len			= C8 + (C8 ? 4 - (C8&3) : 0);
	tst.l	d3
	beq	L208
L207
	move.l	d3,d0
	and.l	#3,d0
	moveq	#4,d1
	sub.l	d0,d1
	move.l	d1,d0
	bra.b	L209
L208
	moveq	#0,d0
L209
	add.l	d0,d3
	move.l	d3,$44(a2)
;	if (j->Alloc()==OK)
	move.l	a2,-(a7)
	jsr	Alloc__JASMINEOBJECT__T
	addq.w	#4,a7
	tst.l	d0
	bne	L214
L210
;		j->shared32.stackSize			= S  + (S ? 4 - (S&3) : 0);
	tst.l	d2
	beq	L212
L211
	move.l	d2,d0
	and.l	#3,d0
	moveq	#4,d1
	sub.l	d0,d1
	move.l	d1,d0
	bra	L213
L212
	moveq	#0,d0
L213
	add.l	d0,d2
	move.l	d2,$48(a2)
;		j->shared32.methodSize		= MS;
	move.l	$1C(a5),$4C(a2)
;		j->shared32.regSize				= RS;
	move.l	$20(a5),$50(a2)
;		j->shared16.progVersion		= v;
	move.w	$C(a5),$58(a2)
;		j->shared16.progRevision	= r;
	move.w	$E(a5),$5A(a2)
;		strncpy(j->shared8.progName, n, 31);
	pea	$1F.w
	move.l	a3,-(a7)
	pea	$5C(a2)
	jsr	_strncpy
	add.w	#$C,a7
;		j->shared8.progName[31] = 0;
	lea	$5C(a2),a0
	clr.b	$1F(a0)
;		return j;
	move.l	a2,d0
	movem.l	(a7)+,d2-d7/a2/a3
	unlk	a5
	rts
L214
;	delete j;
	cmp.w	#0,a2
	beq	L216
L215
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$3C(a0),d0
	move.l	d0,-(a7)
	move.l	$38(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	$1C(a2),a0
	move.l	$30(a0),-(a7)
	move.l	$34(a0),d0
	add.l	a2,d0
	move.l	d0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L216
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3
	unlk	a5
	rts

	XDEF	ReadyForRead__XSFOBJ__T
ReadyForRead__XSFOBJ__T
L218
	moveq	#0,d0
	rts

	XDEF	ReadyForWrite__XSFOBJ__T
ReadyForWrite__XSFOBJ__T
L219
	moveq	#0,d0
	rts

L185
	dc.b	'+-------------------------------------+',0
L65
	dc.b	'Extropia Studios Virtual Machine',0
L66
	dc.b	'VMCODE',0
L186
	dc.b	'| %-35s |',$A,0
L188
	dc.b	'| %4d %8d 0x%08X 0x%08X',-$60,'|',$A,0
L187
	dc.b	'| Func   Offset Name key   Sign. key  |',0

	SECTION ":1",DATA

	XDEF	_XSFIDString__JASMINEOBJECT
_XSFIDString__JASMINEOBJECT
	dc.l	L65
	XDEF	_XSFFileSig__JASMINEOBJECT
_XSFFileSig__JASMINEOBJECT
	dc.l	L66
	XDEF	_XSFSuperClass__JASMINEOBJECT
_XSFSuperClass__JASMINEOBJECT
	dc.w	0
	XDEF	_XSFSubClass__JASMINEOBJECT
_XSFSubClass__JASMINEOBJECT
	dc.w	0
	XDEF	_XSFDataFormat__JASMINEOBJECT
_XSFDataFormat__JASMINEOBJECT
	dc.b	2
	XDEF	_XSFFileFormat__JASMINEOBJECT
_XSFFileFormat__JASMINEOBJECT
	dc.b	0

	SECTION "_0virttab__13JASMINEOBJECT__13JASMINEOBJECT:0",CODE

	XDEF	_0virttab__13JASMINEOBJECT__13JASMINEOBJECT
_0virttab__13JASMINEOBJECT__13JASMINEOBJECT
	dc.l	$8C,0
	dc.l	_0dt__JASMINEOBJECT__T,0
	dc.l	ReadBody__JASMINEOBJECT__TR05XSFIO,0
	dc.l	WriteBody__JASMINEOBJECT__TR05XSFIO,0
	dc.l	ReadyForRead__XSFOBJ__T,0
	dc.l	ReadyForWrite__XSFOBJ__T,0
	dc.l	$8C,0
	dc.l	_0dt__JASMINEOBJECT__T,0
	dc.l	ReadBody__JASMINEOBJECT__TR05XSFIO,0
	dc.l	WriteBody__JASMINEOBJECT__TR05XSFIO,0

	END
