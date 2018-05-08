
; Storm C Compiler
; Developer:eXtropia/eXtropiaOld/prj/xDAC/codec.cpp
	mc68030
	mc68881
	XREF	Save__AIFF__TPCc
	XREF	Load__AIFF__TPCc
	XREF	_0dt__XDACCODEC__T
	XREF	Decode__XDACCODEC__TPCcR03PCM
	XREF	Encode__XDACCODEC__TPCcR03PCMs
	XREF	ReadBody__XDAC__TR05XSFIO
	XREF	WriteBody__XDAC__TR05XSFIO
	XREF	_0dt__XDACENCODE__T
	XREF	Set__XDACENCODE__TR03PCMsss
	XREF	FreeSpace__XDACENCODE__T
	XREF	Delete__xPCM__T
	XREF	ReadBody__xPCM__TR05XSFIO
	XREF	WriteBody__xPCM__TR05XSFIO
	XREF	Delete__PCM__Ts
	XREF	New__PCM__Tjjj
	XREF	SaveRaw16__PCM__TPCc
	XREF	LoadRaw16__PCM__TPCcUss
	XREF	Data__PCM__T
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
	XREF	_0dt__LOCK__T
	XREF	_0dt__THREAD__T
	XREF	Run__THREAD__T
	XREF	_0dt__DELAY__T
	XREF	_0ct__DELAY__T
	XREF	Pause__DELAY__TUj
	XREF	Pause__DELAY__TUjUj
	XREF	Abort__DELAY__T
	XREF	UnLink__xCHAINABLE__T
	XREF	Free__MEM__Pv
	XREF	Done__xBASELIB_
	XREF	Init__xBASELIB_
	XREF	_stricmp
	XREF	_system
	XREF	_atoi
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
	XREF	_fpuPrecision__CPU
	XREF	_cpuNames__CPU
	XREF	_TimerBase__MILLICLOCK
	XREF	_current__MILLICLOCK
	XREF	_clockFreq__MILLICLOCK
	XREF	_threadCnt__THREAD
	XREF	_threadsIdle__THREAD
	XREF	_rootThread__THREAD
	XREF	_AHIBase
	XREF	_AHIport__xAUDIO
	XREF	_AHImain__xAUDIO
	XREF	_flags__xAUDIO
	XREF	_KeymapBase
	XREF	_useCount__xKEY
	XREF	_sigXSF__XSFHEAD
	XREF	_fileMarker__XSFOBJ
	XREF	_rawSig__PCM

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "main__iPPc:0",CODE


;int main(int argc, char* argv[])
	XDEF	main__iPPc
main__iPPc
	XREF	sym_handlers
L114	EQU	-$A8
	link	a5,#L114
	movem.l	d2-d5/a2/a3/a6,-(a7)
	movem.l	$8(a5),d2/a2
L75
;	if (xBASELIB::Init()!=OK)
	jsr	Init__xBASELIB_
	tst.l	d0
	beq.b	L77
L76
;		puts("Fatal error initialising");
	move.l	#L59,-(a7)
	jsr	_puts
	addq.w	#4,a7
	moveq	#$A,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L77
;	char*		aiffName	= GetCLIParm(argc, argv, "-snd");
	move.l	#L60,-(a7)
	move.l	a2,-(a7)
	move.l	d2,-(a7)
	jsr	GetCLIParm__iPPcPCc
	add.w	#$C,a7
	move.l	d0,a6
;	char*		fsize			= GetCLIParm(argc, argv, "-fsize");
	move.l	#L61,-(a7)
	move.l	a2,-(a7)
	move.l	d2,-(a7)
	jsr	GetCLIParm__iPPcPCc
	add.w	#$C,a7
	move.l	d0,-$8(a5)
;	char*		brate			= GetCLIParm(argc, argv, "-brate");
	move.l	#L62,-(a7)
	move.l	a2,-(a7)
	move.l	d2,-(a7)
	jsr	GetCLIParm__iPPcPCc
	add.w	#$C,a7
	move.l	d0,-$C(a5)
;	char*		xDacName	= GetCLIParm(argc, argv, "-xdac");
	move.l	#L63,-(a7)
	move.l	a2,-(a7)
	move.l	d2,-(a7)
	jsr	GetCLIParm__iPPcPCc
	add.w	#$C,a7
	move.l	d0,a3
;	bool		encode		= GetCLISwitch(argc, argv, "-encode");
	move.l	#L64,-(a7)
	move.l	a2,-(a7)
	move.l	d2,-(a7)
	jsr	GetCLISwitch__iPPcPCc
	add.w	#$C,a7
	move.w	d0,d5
;	sint32 frameSize = (fsize) ? Clamp(atoi(fsize), 64, 1024) : 256;
	tst.l	-$8(a5)
	beq.b	L85
L78
	move.l	#$400,d3
	moveq	#$40,d2
	move.l	-$8(a5),-(a7)
	jsr	_atoi
	addq.w	#4,a7
	cmp.l	d2,d0
	bge.b	L80
L79
	move.l	d2,d3
	bra.b	L84
L80
	cmp.l	d3,d0
	ble.b	L82
L81
	bra.b	L83
L82
	move.l	d0,d3
L83
L84
	bra.b	L86
L85
	move.l	#$100,d3
L86
;	sint32 bitRate = (brate) ? Clamp(atoi(brate), 2, 5) : 4;
	tst.l	-$C(a5)
	beq.b	L94
L87
	moveq	#5,d4
	moveq	#2,d2
	move.l	-$C(a5),-(a7)
	jsr	_atoi
	addq.w	#4,a7
	cmp.l	d2,d0
	bge.b	L89
L88
	bra.b	L93
L89
	cmp.l	d4,d0
	ble.b	L91
L90
	move.l	d4,d2
	bra.b	L92
L91
	move.l	d0,d2
L92
L93
	bra.b	L95
L94
	moveq	#4,d2
L95
;	if (!aiffName || ! xDacName)
	cmp.w	#0,a6
	beq.b	L97
L96
	cmp.w	#0,a3
	bne.b	L98
L97
;		puts("Usage : codec -xdac <name> -snd <name> [-encode [-fsize <f
	move.l	#L65,-(a7)
	jsr	_puts
	addq.w	#4,a7
	bra	L113
L98
;		AIFF			wave;
	move.l	#_0virttab__04AIFF__04AIFF,-$1E(a5)
	lea	-$2E(a5),a0
	move.l	sym_handlers,a1
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$8(a0)
	lea	-$9C(a5),a2
	move.l	a0,-(a2)
	move.l	#_0dt__PCM__T,-(a2)
	move.l	sym_handlers,-(a2)
	move.l	a2,sym_handlers
	move.l	a1,sym_handlers
	lea	-$2E(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__AIFF__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;		XDACCODEC	xdac;
	lea	-$82(a5),a0
	move.l	sym_handlers,a1
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$8(a0)
	clr.l	$C(a0)
	clr.w	$2C(a0)
	lea	-$90(a5),a2
	move.l	a0,-(a2)
	move.l	#_0dt__XDACENCODE__T,-(a2)
	move.l	sym_handlers,-(a2)
	move.l	a2,sym_handlers
	move.l	a1,sym_handlers
	lea	-$82(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__XDACCODEC__T,-(a1)
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;		if (encode)
	tst.w	d5
	beq	L109
L99
;			puts("Encode PCM to xDAC");
	move.l	#L66,-(a7)
	jsr	_puts
	addq.w	#4,a7
;			if (wave.Load(aiffName)==OK)
	move.l	a6,-(a7)
	pea	-$2E(a5)
	jsr	Load__AIFF__TPCc
	addq.w	#$8,a7
	tst.l	d0
	bne.b	L107
L100
;				if (xdac.Set(wave, frameSize, bitRate)==OK)
	clr.w	-(a7)
	move.w	d2,-(a7)
	move.w	d3,-(a7)
	pea	-$2E(a5)
	pea	-$82(a5)
	jsr	Set__XDACENCODE__TR03PCMsss
	add.w	#$E,a7
	tst.l	d0
	bne.b	L105
L101
;					if (xdac.Encode(xDacName, wave)==OK)
	clr.w	-(a7)
	pea	-$2E(a5)
	move.l	a3,-(a7)
	pea	-$82(a5)
	jsr	Encode__XDACCODEC__TPCcR03PCMs
	add.w	#$E,a7
	tst.l	d0
	bne.b	L103
L102
;						puts("Encode complete");
	move.l	#L67,-(a7)
	jsr	_puts
	addq.w	#4,a7
	bra.b	L104
L103
;						puts("Error encoding");
	move.l	#L68,-(a7)
	jsr	_puts
	addq.w	#4,a7
L104
	bra.b	L106
L105
;					puts("Unable to initialise frame");
	move.l	#L69,-(a7)
	jsr	_puts
	addq.w	#4,a7
L106
	bra.b	L108
L107
;				puts("Unable to load source pcm file");
	move.l	#L70,-(a7)
	jsr	_puts
	addq.w	#4,a7
L108
	bra.b	L112
L109
;			puts("Decode xDAC to PCM");
	move.l	#L71,-(a7)
	jsr	_puts
	addq.w	#4,a7
;			if (xdac.Decode(xDacName, wave)==OK)
	pea	-$2E(a5)
	move.l	a3,-(a7)
	pea	-$82(a5)
	jsr	Decode__XDACCODEC__TPCcR03PCM
	add.w	#$C,a7
	tst.l	d0
	bne.b	L111
L110
;				printf("Decode complete\nWriting AIFF...");
	move.l	#L72,-(a7)
	jsr	_printf
	addq.w	#4,a7
;				wave.Save(aiffName);
	move.l	a6,-(a7)
	pea	-$2E(a5)
	jsr	Save__AIFF__TPCc
	addq.w	#$8,a7
;				puts("done");
	move.l	#L73,-(a7)
	jsr	_puts
	addq.w	#4,a7
	bra.b	L112
L111
;				puts("Error decoding");
	move.l	#L74,-(a7)
	jsr	_puts
	addq.w	#4,a7
L112
;		wave.Delete();
	move.w	#1,-(a7)
	pea	-$2E(a5)
	jsr	Delete__PCM__Ts
	addq.w	#6,a7
;		xdac.Delete();
	lea	-$82(a5),a2
	move.l	a2,-(a7)
	jsr	FreeSpace__XDACENCODE__T
	addq.w	#4,a7
	clr.w	$2C(a2)
	clr.l	$8(a2)
	lea	-$8E(a5),a0
	XREF	lib_destruct_a0
	jsr	lib_destruct_a0
	lea	-$3A(a5),a0
	jsr	lib_destruct_a0
L113
;	xBASELIB::Done();
	jsr	Done__xBASELIB_
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

L62
	dc.b	'-brate',0
L64
	dc.b	'-encode',0
L61
	dc.b	'-fsize',0
L60
	dc.b	'-snd',0
L63
	dc.b	'-xdac',0
L72
	dc.b	'Decode complete',$A,'Writing AIFF...',0
L71
	dc.b	'Decode xDAC to PCM',0
L66
	dc.b	'Encode PCM to xDAC',0
L67
	dc.b	'Encode complete',0
L74
	dc.b	'Error decoding',0
L68
	dc.b	'Error encoding',0
L59
	dc.b	'Fatal error initialising',0
L69
	dc.b	'Unable to initialise frame',0
L70
	dc.b	'Unable to load source pcm file',0
L65
	dc.b	'Usage : codec -xdac <name> -snd <name> [-encode [-fsize <frame s'
	dc.b	'ize>] [-brate <bit rate>]]',0
L73
	dc.b	'done',0

	SECTION "GetCLIParm__iPPcPCc:0",CODE


;char* GetCLIParm(int argc, char** argv, const char* arg)
	XDEF	GetCLIParm__iPPcPCc
GetCLIParm__iPPcPCc
L122	EQU	-4
	link	a5,#L122
	movem.l	d2/d3/a2/a3,-(a7)
	movem.l	$8(a5),d3/a2/a3
L115
;	for (int i=0;
	moveq	#0,d2
	bra.b	L120
L116
;		if (0 == stricmp(argv[i], arg))
	move.l	a3,-(a7)
	move.l	0(a2,d2.l*4),-(a7)
	jsr	_stricmp
	addq.w	#$8,a7
	tst.l	d0
	bne.b	L119
L117
;			if (++i<argc)
	addq.l	#1,d2
	cmp.l	d3,d2
	bge.b	L119
L118
	move.l	0(a2,d2.l*4),d0
	movem.l	(a7)+,d2/d3/a2/a3
	unlk	a5
	rts
L119
	addq.l	#1,d2
L120
	cmp.l	d3,d2
	blt.b	L116
L121
;				return 
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a3
	unlk	a5
	rts

	SECTION "GetCLISwitch__iPPcPCc:0",CODE


;bool GetCLISwitch(int argc, char** argv, const char* arg)
	XDEF	GetCLISwitch__iPPcPCc
GetCLISwitch__iPPcPCc
L129	EQU	-4
	link	a5,#L129
	movem.l	d2/d3/a2/a3,-(a7)
	movem.l	$8(a5),d3/a2/a3
L123
;	for (int i=0;
	moveq	#0,d2
	bra.b	L127
L124
;		if (0 == stricmp(argv[i], arg))
	move.l	a3,-(a7)
	move.l	0(a2,d2.l*4),-(a7)
	jsr	_stricmp
	addq.w	#$8,a7
	tst.l	d0
	bne.b	L126
L125
	moveq	#1,d0
	movem.l	(a7)+,d2/d3/a2/a3
	unlk	a5
	rts
L126
	addq.l	#1,d2
L127
	cmp.l	d3,d2
	blt.b	L124
L128
;			return 
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a3
	unlk	a5
	rts

	SECTION "_0dt__PCM__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__PCM__T
_0dt__PCM__T
L131	EQU	0
	link	a5,#L131
	move.l	$8(a5),a0
L130
	move.l	a0,-(a7)
	jsr	Free__PCM__T
	addq.w	#4,a7
	unlk	a5
	rts

	SECTION "_0dt__AIFF__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__AIFF__T
_0dt__AIFF__T
L133	EQU	0
	link	a5,#L133
	move.l	$8(a5),a0
L132
	move.l	a0,-(a7)
	jsr	Free__PCM__T
	addq.w	#4,a7
	unlk	a5
	rts

	SECTION "_0virttab__04AIFF__04AIFF:0",CODE

	XDEF	_0virttab__04AIFF__04AIFF
_0virttab__04AIFF__04AIFF
	dc.l	$14,0
	dc.l	_0dt__AIFF__T,0
	dc.l	Save__AIFF__TPCc,0
	dc.l	Load__AIFF__TPCc,0
	dc.l	$14,0
	dc.l	_0dt__AIFF__T,0
	dc.l	Save__AIFF__TPCc,0
	dc.l	Load__AIFF__TPCc,0

	END
