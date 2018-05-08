
; Storm C Compiler
; Mendoza:Extropia/eXtropia/prj/LibTest/SoundDevice.cpp
	mc68030
	mc68881
	XREF	_cos__r
	XREF	_sin__r
	XREF	_0dt__LOCK__T
	XREF	_0dt__THREAD__T
	XREF	_0ct__THREAD__T
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
	XREF	_system
	XREF	_sprintf
	XREF	_fprintf
	XREF	_fflush
	XREF	_fclose
	XREF	_fopen
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

	SECTION "_0ct__MIXER__TUiUjUc:0",CODE


;MIXER::MIXER(size_t bs, uint32 f, uint8 ch) 
	XDEF	_0ct__MIXER__TUiUjUc
_0ct__MIXER__TUiUjUc
	XREF	sym_handlers
L58	EQU	-$38
	link	a5,#L58
	movem.l	d2-d4/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4,-(a7)
	movem.l	$C(a5),d2/d4
	move.b	$14(a5),d3
	move.l	$8(a5),a2
L37
	move.l	sym_handlers,a3
	move.l	a2,-(a7)
	jsr	_0ct__THREAD__T
	addq.w	#4,a7
	lea	(a5),a0
	move.l	a2,-(a0)
	move.l	#_0dt__THREAD__T,-(a0)
	move.l	sym_handlers,-(a0)
	move.l	a0,sym_handlers
	move.l	a2,a0
	clr.l	$30(a0)
	moveq	#$48,d0
	add.l	a2,d0
	move.l	d0,-$34(a5)
	moveq	#$48,d0
	add.l	a2,d0
	move.l	d0,-$38(a5)
	move.l	_TimerBase,a6
	move.l	#_current__MILLICLOCK,a0
	jsr	-$3C(a6)
	move.l	d0,_clockFreq__MILLICLOCK
	lea	_current__MILLICLOCK,a1
	move.l	-$38(a5),a0
	move.l	(a1),(a0)
	move.l	4(a1),4(a0)
	lea	-$C(a5),a0
	move.l	-$34(a5),-(a0)
	move.l	#_0dt__MILLICLOCK__T,-(a0)
	move.l	sym_handlers,-(a0)
	move.l	a0,sym_handlers
;	bufferSize = ((bs>>8) + (bs&0x000000FF ? 1:0))<<8;
	move.l	d2,d0
	moveq	#$8,d1
	lsr.l	d1,d0
	and.l	#$FF,d2
	beq.b	L39
L38
	moveq	#1,d1
	bra.b	L40
L39
	moveq	#0,d1
L40
	add.l	d1,d0
	moveq	#$8,d1
	asl.l	d1,d0
	move.l	a2,a0
	move.l	d0,$58(a0)
;	mix = (sint32*)MEM::Alloc(bufferSize*2*sizeof(sint32), true, false)
	clr.w	-(a7)
	move.w	#1,-(a7)
	move.l	a2,a0
	move.l	$58(a0),d0
	moveq	#1,d1
	asl.l	d1,d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__Uiss
	addq.w	#$8,a7
	move.l	a2,a1
	move.l	d0,$50(a1)
;	out = (sint16*)MEM::Alloc(bufferSize*2*sizeof(sint16), true, false)
	clr.w	-(a7)
	move.w	#1,-(a7)
	move.l	a2,a0
	move.l	$58(a0),d0
	moveq	#1,d1
	asl.l	d1,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__Uiss
	addq.w	#$8,a7
	move.l	a2,a1
	move.l	d0,$54(a1)
;	freq = Clamp(f, 4800, 48000);
	move.l	#$BB80,d2
	move.l	#$12C0,d1
	move.l	d4,d0
	cmp.l	d1,d0
	bhs.b	L42
L41
	move.l	d1,d0
	bra.b	L46
L42
	cmp.l	d2,d0
	bls.b	L44
L43
	move.l	d2,d0
L44
L45
L46
	move.l	a2,a0
	move.w	d0,$5C(a0)
;	maxCh = Clamp(ch, 1, 16);
	moveq	#$10,d0
	moveq	#1,d2
	move.b	d3,d1
	moveq	#0,d3
	move.b	d1,d3
	cmp.l	d2,d3
	bge.b	L48
L47
	move.l	d2,d0
	bra.b	L52
L48
	moveq	#0,d2
	move.b	d1,d2
	cmp.l	d0,d2
	ble.b	L50
L49
	bra.b	L51
L50
	moveq	#0,d0
	move.b	d1,d0
L51
L52
	move.l	a2,a0
	move.b	d0,$5E(a0)
;	sprintf(fName,"CON:64/64/320/128/%s/INACTIVE/PLAIN/CLOSE/WAIT/AUTO
	pea	$1C(a2)
	move.l	#L34,-(a7)
	move.l	#_fName___0ct__MIXER__TUiUjUc,-(a7)
	jsr	_sprintf
	add.w	#$C,a7
;	debugOut = fopen(fName, "w");
	move.l	#L35,-(a7)
	move.l	#_fName___0ct__MIXER__TUiUjUc,-(a7)
	jsr	_fopen
	addq.w	#$8,a7
	move.l	a2,a1
	move.l	d0,$44(a1)
;	if (!debugOut)
	move.l	a2,a1
	tst.l	$44(a1)
	bne.b	L54
L53
	move.l	a3,sym_handlers
	fmovem.x (a7)+,fp2/fp3/fp4
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L54
;	fprintf(debugOut, "MIXER : %hu Hz, %hu chan, %lu samp\n", freq, ma
	move.l	a2,a0
	move.l	$58(a0),-(a7)
	move.l	a2,a0
	moveq	#0,d0
	move.b	$5E(a0),d0
	move.l	d0,-(a7)
	move.l	a2,a0
	moveq	#0,d0
	move.w	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	#L36,-(a7)
	move.l	a2,a1
	move.l	$44(a1),-(a7)
	jsr	_fprintf
	add.w	#$14,a7
;	fflush(debugOut);
	move.l	a2,a1
	move.l	$44(a1),-(a7)
	jsr	_fflush
	addq.w	#4,a7
;	float64 x = (256.0*PI) / (float64)(bufferSize<<1);
	move.l	a2,a0
	move.l	$58(a0),d0
	moveq	#1,d1
	asl.l	d1,d0
	fmove.l	d0,fp0
	fmove.d	#$.408921FB.60000000,fp4
	fdiv.x	fp0,fp4
;	float64 p = (2.0*PI) / (float64)(bufferSize<<1);
	move.l	a2,a0
	move.l	$58(a0),d0
	moveq	#1,d1
	asl.l	d1,d0
	fmove.l	d0,fp0
	fmove.d	#$.401921FB.60000000,fp3
	fdiv.x	fp0,fp3
;	for (sint32 i = 0;
	moveq	#0,d2
	bra	L56
L55
;	
;		out[i] = (sint16)(8192.0 * (sin(x*(float64)i)*(1.0+sin(p*(float6
	fmove.l	d2,fp0
	fmul.x	fp4,fp0
	fmove.d	fp0,-(a7)
	jsr	_sin__r
	fmove.x	fp0,fp2
	addq.w	#$8,a7
	fmove.l	d2,fp0
	fmul.x	fp3,fp0
	fmove.d	fp0,-(a7)
	jsr	_sin__r
	addq.w	#$8,a7
	fadd.d	#$.3FF00000.00000000,fp0
	fmul.x	fp0,fp2
	fmove.x	fp2,fp0
	fmul.d	#$.40C00000.00000000,fp0
	fmove.l	fp0,d0
	move.l	a2,a1
	move.l	$54(a1),a0
	move.w	d0,0(a0,d2.l*2)
;		out[i+1] = (sint16)(8192.0 * (cos(x*(float64)i)*(1.0-sin(p*(floa
	fmove.l	d2,fp0
	fmul.x	fp4,fp0
	fmove.d	fp0,-(a7)
	jsr	_cos__r
	fmove.x	fp0,fp2
	addq.w	#$8,a7
	fmove.l	d2,fp0
	fmul.x	fp3,fp0
	fmove.d	fp0,-(a7)
	jsr	_sin__r
	addq.w	#$8,a7
	fmove.d	#$.3FF00000.00000000,fp1
	fsub.x	fp0,fp1
	fmul.x	fp1,fp2
	fmove.x	fp2,fp0
	fmul.d	#$.40C00000.00000000,fp0
	fmove.l	fp0,d0
	move.w	d0,d1
	move.l	a2,a1
	move.l	d2,d0
	addq.l	#1,d0
	move.l	$54(a1),a0
	move.w	d1,0(a0,d0.l*2)
	addq.l	#2,d2
L56
	move.l	a2,a0
	move.l	$58(a0),d0
	moveq	#1,d1
	asl.l	d1,d0
	cmp.l	d0,d2
	blt	L55
L57
	move.l	a3,sym_handlers
	fmovem.x (a7)+,fp2/fp3/fp4
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts

L34
	dc.b	'CON:64/64/320/128/%s/INACTIVE/PLAIN/CLOSE/WAIT/AUTO',0
L36
	dc.b	'MIXER : %hu Hz, %hu chan, %lu samp',$A,0
L35
	dc.b	'w',0

	SECTION "_0ct__MIXER__TUiUjUc:2",BSS

_fName___0ct__MIXER__TUiUjUc
	ds.b	128

	SECTION "_0dt__MIXER__T:0",CODE


;MIXER::~MIXER()
	XDEF	_0dt__MIXER__T
_0dt__MIXER__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L59
;	Stop();
	move.l	a2,-(a7)
	jsr	Stop__THREAD__T
	addq.w	#4,a7
;	if (mix)
	tst.l	$50(a2)
	beq.b	L61
L60
;		MEM::Free(mix);
	move.l	$50(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L61
;	if (out)
	tst.l	$54(a2)
	beq.b	L63
L62
;		MEM::Free(out);
	move.l	$54(a2),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L63
;	if (debugOut)
	tst.l	$44(a2)
	beq.b	L65
L64
;	
;		fclose(debugOut);
	move.l	$44(a2),-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		debugOut = 0;
	clr.l	$44(a2)
L65
	move.l	a2,-(a7)
	jsr	_0dt__THREAD__T
	addq.w	#4,a7
	move.l	(a7)+,a2
	rts

	SECTION "OpenHardware__MIXER__T:0",CODE


;bool MIXER::OpenHardware()
	XDEF	OpenHardware__MIXER__T
OpenHardware__MIXER__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L69
;	flags = 0;
	move.l	a2,a0
	clr.l	$30(a0)
;	if (!(soundPort = ::CreateMsgPort()))
	move.l	_SysBase,a6
	jsr	-$29A(a6)
	move.l	a2,a1
	move.l	d0,$34(a1)
	bne.b	L71
L70
;	
;		flags |= PORT_FAIL;
	move.l	a2,a0
	move.l	$30(a0),d0
	or.l	#1,d0
	move.l	a2,a0
	move.l	d0,$30(a0)
;		goto 
	bra	L77
L71
;	soundSignal = 1<<soundPort->mp_SigBit;
	move.l	a2,a1
	move.l	$34(a1),a0
	moveq	#0,d0
	move.b	$F(a0),d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	a2,a0
	move.l	d1,$40(a0)
;	if (!(soundIO[0].ahi = (AHIRequest*)::CreateIORequest(soundPort, s
	move.l	a2,a1
	move.l	_SysBase,a6
	moveq	#$50,d0
	move.l	$34(a1),a0
	jsr	-$28E(a6)
	move.l	d0,$38(a2)
	bne.b	L73
L72
;	
;		flags |= IORQ_FAIL;
	move.l	a2,a0
	move.l	$30(a0),d0
	or.l	#2,d0
	move.l	a2,a0
	move.l	d0,$30(a0)
;		goto 
	bra.b	L77
L73
;	soundIO[0].ahi->ahir_Version = 4;
	move.l	$38(a2),a0
	move.w	#4,$30(a0)
;	if (::OpenDevice(AHINAME, AHI_DEFAULT_UNIT, soundIO[0].io, 0)!=0)
	move.l	_SysBase,a6
	moveq	#0,d0
	moveq	#0,d1
	move.l	#L66,a0
	move.l	$38(a2),a1
	jsr	-$1BC(a6)
	ext.w	d0
	tst.w	d0
	beq.b	L75
L74
;	
;		flags |= OPDV_FAIL;
	move.l	a2,a0
	move.l	$30(a0),d0
	or.l	#4,d0
	move.l	a2,a0
	move.l	d0,$30(a0)
;		goto 
	bra.b	L77
L75
;	if (debugOut);
L76
;	
;		fprintf(debugOut, "Sound hardware opened\n");
	move.l	#L67,-(a7)
	move.l	a2,a1
	move.l	$44(a1),-(a7)
	jsr	_fprintf
	addq.w	#$8,a7
;		fflush(debugOut);
	move.l	a2,a1
	move.l	$44(a1),-(a7)
	jsr	_fflush
	addq.w	#4,a7
	moveq	#1,d0
	movem.l	(a7)+,a2/a6
	rts
L77
;	if (debugOut);
L78
;	
;		fprintf(debugOut, "Couldn't open sound hardware\n");
	move.l	#L68,-(a7)
	move.l	a2,a1
	move.l	$44(a1),-(a7)
	jsr	_fprintf
	addq.w	#$8,a7
;		fflush(debugOut);
	move.l	a2,a1
	move.l	$44(a1),-(a7)
	jsr	_fflush
	addq.w	#4,a7
;	CloseHardware();
	move.l	a2,-(a7)
	jsr	CloseHardware__MIXER__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

L68
	dc.b	'Couldn't open sound hardware',$A,0
L67
	dc.b	'Sound hardware opened',$A,0
L66
	dc.b	'ahi.device',0

	SECTION "CloseHardware__MIXER__T:0",CODE


;void MIXER::CloseHardware()
	XDEF	CloseHardware__MIXER__T
CloseHardware__MIXER__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L80
;	if (soundIO[0].io)
	tst.l	$38(a2)
	beq.b	L84
L81
;	
;		if (flags & IORQ_USED)
	move.l	a2,a0
	move.l	$30(a0),d0
	and.l	#$8,d0
	beq.b	L83
L82
;		
;			::AbortIO(soundIO[0].io);
	move.l	_SysBase,a6
	move.l	$38(a2),a1
	jsr	-$1E0(a6)
;			::WaitIO(soundIO[0].io);
	move.l	_SysBase,a6
	move.l	$38(a2),a1
	jsr	-$1DA(a6)
;			::SetSignal(0, soundSignal);
	move.l	a2,a0
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	$40(a0),d1
	jsr	-$132(a6)
L83
;		::CloseDevice(soundIO[0].io);
	move.l	_SysBase,a6
	move.l	$38(a2),a1
	jsr	-$1C2(a6)
;		::DeleteIORequest(soundIO[0].io);
	move.l	_SysBase,a6
	move.l	$38(a2),a0
	jsr	-$294(a6)
;		soundIO[0].io = 0;
	clr.l	$38(a2)
L84
;	if (soundPort)
	move.l	a2,a1
	tst.l	$34(a1)
	beq.b	L86
L85
;	
;		::DeleteMsgPort(soundPort);
	move.l	a2,a1
	move.l	_SysBase,a6
	move.l	$34(a1),a0
	jsr	-$2A0(a6)
;		soundPort = 0;
	move.l	a2,a1
	clr.l	$34(a1)
L86
;	soundSignal = 0;
	move.l	a2,a0
	clr.l	$40(a0)
;	if (debugOut);
L87
;	
;		fprintf(debugOut, "Sound hardware closed\n");
	move.l	#L79,-(a7)
	move.l	a2,a1
	move.l	$44(a1),-(a7)
	jsr	_fprintf
	addq.w	#$8,a7
;		fflush(debugOut);
	move.l	a2,a1
	move.l	$44(a1),-(a7)
	jsr	_fflush
	addq.w	#4,a7
	movem.l	(a7)+,a2/a6
	rts

L79
	dc.b	'Sound hardware closed',$A,0

	SECTION "Run__MIXER__T:0",CODE


;sint32 MIXER::Run()
	XDEF	Run__MIXER__T
Run__MIXER__T
	movem.l	d2/a2/a3/a6,-(a7)
	move.l	$14(a7),a3
L89
;	if (!OpenHardware())
	move.l	a3,-(a7)
	jsr	OpenHardware__MIXER__T
	addq.w	#4,a7
	tst.w	d0
	bne.b	L91
L90
;	
	moveq	#-1,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L91
;	sint32 i=0;
	moveq	#0,d2
;	while (!ShutDown())
	bra	L93
L92
;	
;		soundIO[0].std->io_Command								= CMD_WRITE;
	move.l	$38(a3),a0
	move.w	#3,$1C(a0)
;		soundIO[0].std->io_Message.mn_Node.ln_Pri	= 0;
	move.l	$38(a3),a0
	clr.b	$9(a0)
;		soundIO[0].std->io_Length									= bufferSize*2*sizeof(sint16);
	move.l	a3,a0
	move.l	$58(a0),d0
	moveq	#1,d1
	asl.l	d1,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$38(a3),a0
	move.l	d0,$24(a0)
;		soundIO[0].std->io_Data										= out;
	move.l	a3,a0
	move.l	$54(a0),a1
	move.l	$38(a3),a0
	move.l	a1,$28(a0)
;		soundIO[0].ahi->ahir_Type									= AHIST_S16S;
	move.l	$38(a3),a0
	move.l	#3,$3C(a0)
;		soundIO[0].ahi->ahir_Frequency						= freq;
	move.l	a3,a0
	moveq	#0,d0
	move.w	$5C(a0),d0
	move.l	$38(a3),a0
	move.l	d0,$40(a0)
;		soundIO[0].ahi->ahir_Link									= 0;
	move.l	$38(a3),a0
	clr.l	$4C(a0)
;		soundIO[0].ahi->ahir_Volume								= 0x00010000;
	move.l	$38(a3),a0
	move.l	#$10000,$44(a0)
;		soundIO[0].ahi->ahir_Position							= 0x00008000;
	move.l	$38(a3),a0
	move.l	#$8000,$48(a0)
;		::SendIO(soundIO[0].io);
	move.l	_SysBase,a6
	move.l	$38(a3),a1
	jsr	-$1CE(a6)
;		::WaitIO(soundIO[0].io);
	move.l	_SysBase,a6
	move.l	$38(a3),a1
	jsr	-$1DA(a6)
;		++i;
	addq.l	#1,d2
L93
	moveq	#0,d0
	move.w	$16(a3),d0
	and.l	#$8,d0
	cmp.l	#$8,d0
	seq	d0
	and.l	#1,d0
	tst.w	d0
	beq	L92
L94
;	if (debugOut)
	move.l	a3,a1
	tst.l	$44(a1)
	beq.b	L96
L95
;	
;		fprintf(debugOut, "\n\nWrote %ld packets\n", i);
	move.l	d2,-(a7)
	move.l	#L88,-(a7)
	move.l	a3,a1
	move.l	$44(a1),-(a7)
	jsr	_fprintf
	add.w	#$C,a7
;		fflush(debugOut);
	move.l	a3,a1
	move.l	$44(a1),-(a7)
	jsr	_fflush
	addq.w	#4,a7
L96
;	CloseHardware();
	move.l	a3,-(a7)
	jsr	CloseHardware__MIXER__T
	addq.w	#4,a7
	move.l	d2,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts

L88
	dc.b	$A,$A,'Wrote %ld packets',$A,0

	SECTION "Mix__MIXER__T:0",CODE


;void MIXER::Mix()
	XDEF	Mix__MIXER__T
Mix__MIXER__T
L97
;void MIXER::Mix()
	rts

	SECTION "Play__MIXER__TP10DUMMYSOUND:0",CODE


;void MIXER::Play(DUMMYSOUND* s)
	XDEF	Play__MIXER__TP10DUMMYSOUND
Play__MIXER__TP10DUMMYSOUND
L98
;void MIXER::Play(DUMMYSOUND* s)
	rts

	SECTION "GetDMAPos__MIXER__T:0",CODE


;size_t MIXER::GetDMAPos()
	XDEF	GetDMAPos__MIXER__T
GetDMAPos__MIXER__T
	move.l	4(a7),a0
L99
;	if (Started())
	moveq	#0,d0
	move.w	$16(a0),d0
	and.l	#1,d0
	tst.w	d0
	beq.b	L101
L100
	move.l	$38(a0),a0
	move.l	$20(a0),d0
	moveq	#1,d1
	lsr.l	d1,d0
	and.l	#-2,d0
	rts
L101
	moveq	#0,d0
	rts

	SECTION "_0dt__MILLICLOCK__T:0",CODE

	CNOP	0,2

	XDEF	_0dt__MILLICLOCK__T
_0dt__MILLICLOCK__T
L102
	rts

	END
