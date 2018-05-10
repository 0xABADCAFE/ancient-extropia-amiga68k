
; Storm C Compiler
; Developer:eXtropia/eXtropiaOld/lib/Platforms/Amiga68k/SoundLib/xAudio.cpp
	mc68030
	mc68881
	XREF	Delete__xPCM__T
	XREF	ReadBody__xPCM__TR05XSFIO
	XREF	WriteBody__xPCM__TR05XSFIO
	XREF	New__PCM__Tjjj
	XREF	SaveRaw16__PCM__TPCc
	XREF	LoadRaw16__PCM__TPCcUss
	XREF	Free__PCM__T
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
	XREF	_KeymapBase
	XREF	_useCount__xKEY
	XREF	_sigXSF__XSFHEAD
	XREF	_fileMarker__XSFOBJ
	XREF	_rawSig__PCM

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_AHIBase:1",DATA

	XDEF	_AHIBase
_AHIBase
	dc.l	0

	SECTION "_AHIport__xAUDIO:1",DATA

	XDEF	_AHIport__xAUDIO
_AHIport__xAUDIO
	dc.l	0

	SECTION "_AHImain__xAUDIO:1",DATA

	XDEF	_AHImain__xAUDIO
_AHImain__xAUDIO
	dc.l	0

	SECTION "_flags__xAUDIO:1",DATA

	XDEF	_flags__xAUDIO
_flags__xAUDIO
	dc.l	0

	SECTION "Init__xAUDIO_:0",CODE


;sint32 xAUDIO::Init()
	XDEF	Init__xAUDIO_
Init__xAUDIO_
	move.l	a6,-(a7)
L39
;	if (!(AHIport = CreateMsgPort()))
	move.l	_SysBase,a6
	jsr	-$29A(a6)
	move.l	d0,_AHIport__xAUDIO
	tst.l	_AHIport__xAUDIO
	bne.b	L41
L40
;		flags |= PORT_ERR;
	or.l	#1,_flags__xAUDIO
;		Done();
	jsr	Done__xAUDIO_
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts
L41
;	if (!(AHImain = (AHIRequest*)CreateIORequest(AHIport, sizeof(AHIRe
	move.l	_AHIport__xAUDIO,a0
	move.l	_SysBase,a6
	moveq	#$50,d0
	jsr	-$28E(a6)
	move.l	d0,_AHImain__xAUDIO
	tst.l	_AHImain__xAUDIO
	bne.b	L43
L42
;		flags |= IOREQ_ERR;
	or.l	#2,_flags__xAUDIO
;		Done();
	jsr	Done__xAUDIO_
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts
L43
;	AHImain->ahir_Version = 4;
	move.l	_AHImain__xAUDIO,a0
	move.w	#4,$30(a0)
;	if (OpenDevice(AHINAME, AHI_NO_UNIT, (IORequest*)AHImain, 0)!=OK)
	move.l	_AHImain__xAUDIO,a1
	move.l	_SysBase,a6
	move.l	#$FF,d0
	moveq	#0,d1
	move.l	#L38,a0
	jsr	-$1BC(a6)
	ext.w	d0
	tst.w	d0
	beq.b	L45
L44
;		flags |= DEVICE_ERR;
	or.l	#4,_flags__xAUDIO
;		Done();
	jsr	Done__xAUDIO_
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts
L45
;	AHIBase = (LIBRARY*) AHImain->ahir_Std.io_Device;
	move.l	_AHImain__xAUDIO,a0
	move.l	$14(a0),_AHIBase
;	return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

L38
	dc.b	'ahi.device',0

	SECTION "Done__xAUDIO_:0",CODE


;sint32 xAUDIO::Done()
	XDEF	Done__xAUDIO_
Done__xAUDIO_
	move.l	a6,-(a7)
L46
;	if (flags & AUDIO_ERR)
L47
;	if (flags & DEVICE_ERR)
	move.l	_flags__xAUDIO,d0
	and.l	#4,d0
	beq.b	L49
L48
;		flags &= ~DEVICE_ERR;
	and.l	#-5,_flags__xAUDIO
	bra.b	L50
L49
;		CloseDevice((IORequest*)AHImain);
	move.l	_AHImain__xAUDIO,a1
	move.l	_SysBase,a6
	jsr	-$1C2(a6)
L50
;	if (flags & IOREQ_ERR)
	move.l	_flags__xAUDIO,d0
	and.l	#2,d0
	beq.b	L52
L51
;		flags &= ~IOREQ_ERR;
	and.l	#-3,_flags__xAUDIO
	bra.b	L53
L52
;		DeleteIORequest((IORequest*)AHImain);
	move.l	_AHImain__xAUDIO,a0
	move.l	_SysBase,a6
	jsr	-$294(a6)
;		AHImain = 0;
	clr.l	_AHImain__xAUDIO
L53
;	if (flags & PORT_ERR)
	move.l	_flags__xAUDIO,d0
	and.l	#1,d0
	beq.b	L55
L54
;		flags &= ~PORT_ERR;
	and.l	#-2,_flags__xAUDIO
	bra.b	L56
L55
;		DeleteMsgPort(AHIport);
	move.l	_AHIport__xAUDIO,a0
	move.l	_SysBase,a6
	jsr	-$2A0(a6)
;		AHIport = 0;
	clr.l	_AHIport__xAUDIO
L56
;	return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

	END
