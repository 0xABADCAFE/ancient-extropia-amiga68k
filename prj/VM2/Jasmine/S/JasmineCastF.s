
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineCastF.cpp
	mc68030
	mc68881
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
	XREF	_0dt__JASMINE__T
	XREF	PopRegs__JASMINE__r10P07JASMINEr0jr1j
	XREF	PushRegs__JASMINE__r10P07JASMINEr0jr1j
	XREF	_0dt__LOCK__T
	XREF	_0dt__THREAD__T
	XREF	Run__THREAD__T
	XREF	_0dt__DELAY__T
	XREF	_0ct__DELAY__T
	XREF	Pause__DELAY__TUj
	XREF	Pause__DELAY__TUjUj
	XREF	Abort__DELAY__T
	XREF	UnLink__xCHAINABLE__T
	XREF	_memset
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
	XREF	_TimerBase__MILLICLOCK
	XREF	_current__MILLICLOCK
	XREF	_clockFreq__MILLICLOCK
	XREF	_threadCnt__THREAD
	XREF	_threadsIdle__THREAD
	XREF	_rootThread__THREAD
	XREF	_eaTable__JASMINE_EA
	XREF	_instTable__JASMINE_OP
	XREF	_sysTable__JASMINE_OP
	XREF	_illegalDone__JASMINE
	XREF	_resultString__JASMINE
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

	SECTION ":0",CODE


;void JASMINE_OP::fF64_F32(OP_ARGS)
	XDEF	fF64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L98
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = OP1_32(float32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L100
L99
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L107
L100
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L102
L101
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L107
L102
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L104
L103
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L107
L104
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L105
L106
L107
	fmove.s	(a0),fp0
	fmove.x	fp0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L109
L108
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L110
L109
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L110
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fF32_F64(OP_ARGS)
	XDEF	fF32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L111
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = (float32)(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L113
L112
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L120
L113
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L115
L114
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L120
L115
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L117
L116
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L120
L117
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L124
	moveq	#-1,d0
L124
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L118
L119
L120
	fmove.d	(a0),fp0
	fmove.x	fp0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L122
L121
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L123
L122
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L123
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

	END
