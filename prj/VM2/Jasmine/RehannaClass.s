
; Storm C Compiler
; Mendoza:Extropia/eXtropia/prj/VM2/Jasmine/RehannaClass.cpp
	mc68030
	mc68881
	XREF	CallHandler__REHANNA__r12P07REHANNAr8Pv
	XREF	Delete__JASM68K__T
	XREF	Create__JASM68K__Tj
	XREF	_0dt__JASMINEOBJECT__T
	XREF	ReadBody__JASMINEOBJECT__TR05XSFIO
	XREF	WriteBody__JASMINEOBJECT__TR05XSFIO
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
	XREF	UnLink__xCHAINABLE__T
	XREF	ShutDown__xTHREADABLE__T
	XREF	Done__xTHREADABLE__T
	XREF	Init__xTHREADABLE__T
	XREF	_0dt__xLOCKABLE__T
	XREF	Zero__MEM__PvUi
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__Uiss
	XREF	Done__xBASELIB_
	XREF	Init__xBASELIB__iPPc
	XREF	_memset
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
	XREF	_KeymapBase
	XREF	_useCount__xKEY
	XREF	_sigXSF__XSFHEAD
	XREF	_fileMarker__XSFOBJ
	XREF	_XSFIDString__JASMINEOBJECT
	XREF	_XSFFileSig__JASMINEOBJECT
	XREF	_XSFSuperClass__JASMINEOBJECT
	XREF	_XSFSubClass__JASMINEOBJECT
	XREF	_XSFDataFormat__JASMINEOBJECT
	XREF	_XSFFileFormat__JASMINEOBJECT
	XREF	_instTable__JASM68K
	XREF	_sysTable__JASM68K

	SECTION ":0",CODE


;sint32 JASM68K::TranslateFunc(J68K_ARGS)
	XDEF	TranslateFunc__JASM68K__TPUjPUs
TranslateFunc__JASM68K__TPUjPUs
L47
;	return 0;
	moveq	#0,d0
	rts

;sint32 REHANNA::Create(sint32 size, sint32 maxF)
	XDEF	Create__REHANNA__Tjj
Create__REHANNA__Tjj
	movem.l	d2-d4/a2,-(a7)
	move.l	$1C(a7),d2
	move.l	$18(a7),d3
	move.l	$14(a7),a2
L48
;	if (codeHeap || funcList)
	tst.l	$138(a2)
	bne.b	L50
L49
	tst.l	$144(a2)
	beq.b	L51
L50
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L51
;	size = Clamp(size, 4096, 4194304);
	move.l	#$400000,d4
	move.l	#$1000,d1
	move.l	d3,d0
	cmp.l	d1,d0
	bge.b	L53
L52
	move.l	d1,d3
	bra.b	L57
L53
	cmp.l	d4,d0
	ble.b	L55
L54
	move.l	d4,d3
	bra.b	L57
L55
	move.l	d0,d3
L56
L57
;	maxF = Clamp(maxF, 1, 4096);
	move.l	#$1000,d4
	moveq	#1,d1
	move.l	d2,d0
	cmp.l	d1,d0
	bge.b	L59
L58
	move.l	d1,d2
	bra.b	L63
L59
	cmp.l	d4,d0
	ble.b	L61
L60
	move.l	d4,d2
	bra.b	L63
L61
	move.l	d0,d2
L62
L63
;	codeHeap = MEM::Alloc(size);
	clr.w	-(a7)
	move.w	#1,-(a7)
	move.l	d3,-(a7)
	jsr	Alloc__MEM__Uiss
	addq.w	#$8,a7
	move.l	d0,$138(a2)
;	funcList = (TRANSLATED*)MEM::Alloc(maxF*sizeof(TRANSLATED));
	clr.w	-(a7)
	move.w	#1,-(a7)
	move.l	d2,d0
	moveq	#4,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__Uiss
	addq.w	#$8,a7
	move.l	d0,$144(a2)
;	if ((!codeHeap) || (!funcList))
	tst.l	$138(a2)
	beq.b	L65
L64
	tst.l	$144(a2)
	bne.b	L66
L65
;		Delete();
	move.l	a2,-(a7)
	jsr	Delete__REHANNA__T
	addq.w	#4,a7
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L66
;	codeSize = size;
	move.l	d3,$13C(a2)
;	codeUsed = 0;
	clr.l	$140(a2)
;	funcSize = maxF;
	move.l	d2,$148(a2)
;	funcUsed = 0;
	clr.l	$14C(a2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2
	rts

;void REHANNA::Delete()
	XDEF	Delete__REHANNA__T
Delete__REHANNA__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L67
;	if (codeHeap)
	tst.l	$138(a2)
	beq.b	L69
L68
;		MEM::Free(codeHeap);
	move.l	$138(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L69
;	if (funcList)
	tst.l	$144(a2)
	beq.b	L71
L70
;		MEM::Free(funcList);
	move.l	$144(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L71
;	codeHeap = 0;
	clr.l	$138(a2)
;	codeSize = 0;
	clr.l	$13C(a2)
;	codeUsed = 0;
	clr.l	$140(a2)
;	funcList = 0;
	clr.l	$144(a2)
;	funcSize = 0;
	clr.l	$148(a2)
;	funcUsed = 0;
	clr.l	$14C(a2)
	move.l	(a7)+,a2
	rts

;int main(int argc, char** argv)
	XDEF	main__iPPc
main__iPPc
	movem.l	d2/a2,-(a7)
	movem.l	$C(a7),d2/a2
L75
;	if (xBASELIB::Init(argc, argv)!=OK)
	move.l	a2,-(a7)
	move.l	d2,-(a7)
	jsr	Init__xBASELIB__iPPc
	addq.w	#$8,a7
	tst.l	d0
	beq.b	L77
L76
;		puts("Error initializing base library");
	move.l	#L72,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		return 10;
	moveq	#$A,d0
	movem.l	(a7)+,d2/a2
	rts
L77
;	if (argc != 2)
	cmp.l	#2,d2
	beq.b	L79
L78
;		puts("Usage : rehanna <object file>");
	move.l	#L73,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		xBASELIB::Done();
	jsr	Done__xBASELIB_
;		return 5;
	moveq	#5,d0
	movem.l	(a7)+,d2/a2
	rts
L79
;	printf("File : %s\n", argv[1]);
	move.l	4(a2),-(a7)
	move.l	#L74,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;	xBASELIB::Done();
	jsr	Done__xBASELIB_
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts

L72
	dc.b	'Error initializing base library',0
L74
	dc.b	'File : %s',$A,0
L73
	dc.b	'Usage : rehanna <object file>',0

	SECTION "Clamp__jii:0",CODE

	rts

	END
