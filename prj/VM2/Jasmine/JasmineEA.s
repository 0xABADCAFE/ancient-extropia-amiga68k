
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineEA.cpp
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


;void* JASMINE_EA::fR0(EA_ARGS)		
	XDEF	fR0__JASMINE_EA__r10P07JASMINEr7Ui
fR0__JASMINE_EA__r10P07JASMINEr7Ui
L98
;	return jvm->gpRegs[0].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	add.l	a2,d0
	rts

;void* JASMINE_EA::fR1(EA_ARGS)		
	XDEF	fR1__JASMINE_EA__r10P07JASMINEr7Ui
fR1__JASMINE_EA__r10P07JASMINEr7Ui
L99
;	return jvm->gpRegs[1].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$8(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR2(EA_ARGS)		
	XDEF	fR2__JASMINE_EA__r10P07JASMINEr7Ui
fR2__JASMINE_EA__r10P07JASMINEr7Ui
L100
;	return jvm->gpRegs[2].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$10(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR3(EA_ARGS)		
	XDEF	fR3__JASMINE_EA__r10P07JASMINEr7Ui
fR3__JASMINE_EA__r10P07JASMINEr7Ui
L101
;	return jvm->gpRegs[3].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$18(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR4(EA_ARGS)		
	XDEF	fR4__JASMINE_EA__r10P07JASMINEr7Ui
fR4__JASMINE_EA__r10P07JASMINEr7Ui
L102
;	return jvm->gpRegs[4].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$20(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR5(EA_ARGS)		
	XDEF	fR5__JASMINE_EA__r10P07JASMINEr7Ui
fR5__JASMINE_EA__r10P07JASMINEr7Ui
L103
;	return jvm->gpRegs[5].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$28(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR6(EA_ARGS)		
	XDEF	fR6__JASMINE_EA__r10P07JASMINEr7Ui
fR6__JASMINE_EA__r10P07JASMINEr7Ui
L104
;	return jvm->gpRegs[6].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$30(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR7(EA_ARGS)		
	XDEF	fR7__JASMINE_EA__r10P07JASMINEr7Ui
fR7__JASMINE_EA__r10P07JASMINEr7Ui
L105
;	return jvm->gpRegs[7].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$38(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR8(EA_ARGS)		
	XDEF	fR8__JASMINE_EA__r10P07JASMINEr7Ui
fR8__JASMINE_EA__r10P07JASMINEr7Ui
L106
;	return jvm->gpRegs[8].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$40(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR9(EA_ARGS)		
	XDEF	fR9__JASMINE_EA__r10P07JASMINEr7Ui
fR9__JASMINE_EA__r10P07JASMINEr7Ui
L107
;	return jvm->gpRegs[9].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$48(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR10(EA_ARGS)		
	XDEF	fR10__JASMINE_EA__r10P07JASMINEr7Ui
fR10__JASMINE_EA__r10P07JASMINEr7Ui
L108
;	return jvm->gpRegs[10].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$50(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR11(EA_ARGS)		
	XDEF	fR11__JASMINE_EA__r10P07JASMINEr7Ui
fR11__JASMINE_EA__r10P07JASMINEr7Ui
L109
;	return jvm->gpRegs[11].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$58(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR12(EA_ARGS)		
	XDEF	fR12__JASMINE_EA__r10P07JASMINEr7Ui
fR12__JASMINE_EA__r10P07JASMINEr7Ui
L110
;	return jvm->gpRegs[12].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$60(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR13(EA_ARGS)		
	XDEF	fR13__JASMINE_EA__r10P07JASMINEr7Ui
fR13__JASMINE_EA__r10P07JASMINEr7Ui
L111
;	return jvm->gpRegs[13].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$68(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR14(EA_ARGS)		
	XDEF	fR14__JASMINE_EA__r10P07JASMINEr7Ui
fR14__JASMINE_EA__r10P07JASMINEr7Ui
L112
;	return jvm->gpRegs[14].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$70(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR15(EA_ARGS)		
	XDEF	fR15__JASMINE_EA__r10P07JASMINEr7Ui
fR15__JASMINE_EA__r10P07JASMINEr7Ui
L113
;	return jvm->gpRegs[15].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$78(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR16(EA_ARGS)		
	XDEF	fR16__JASMINE_EA__r10P07JASMINEr7Ui
fR16__JASMINE_EA__r10P07JASMINEr7Ui
L114
;	return jvm->gpRegs[16].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$80(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR17(EA_ARGS)		
	XDEF	fR17__JASMINE_EA__r10P07JASMINEr7Ui
fR17__JASMINE_EA__r10P07JASMINEr7Ui
L115
;	return jvm->gpRegs[17].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$88(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR18(EA_ARGS)		
	XDEF	fR18__JASMINE_EA__r10P07JASMINEr7Ui
fR18__JASMINE_EA__r10P07JASMINEr7Ui
L116
;	return jvm->gpRegs[18].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$90(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR19(EA_ARGS)		
	XDEF	fR19__JASMINE_EA__r10P07JASMINEr7Ui
fR19__JASMINE_EA__r10P07JASMINEr7Ui
L117
;	return jvm->gpRegs[19].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$98(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR20(EA_ARGS)		
	XDEF	fR20__JASMINE_EA__r10P07JASMINEr7Ui
fR20__JASMINE_EA__r10P07JASMINEr7Ui
L118
;	return jvm->gpRegs[20].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$A0(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR21(EA_ARGS)		
	XDEF	fR21__JASMINE_EA__r10P07JASMINEr7Ui
fR21__JASMINE_EA__r10P07JASMINEr7Ui
L119
;	return jvm->gpRegs[21].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$A8(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR22(EA_ARGS)		
	XDEF	fR22__JASMINE_EA__r10P07JASMINEr7Ui
fR22__JASMINE_EA__r10P07JASMINEr7Ui
L120
;	return jvm->gpRegs[22].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$B0(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR23(EA_ARGS)		
	XDEF	fR23__JASMINE_EA__r10P07JASMINEr7Ui
fR23__JASMINE_EA__r10P07JASMINEr7Ui
L121
;	return jvm->gpRegs[23].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$B8(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR24(EA_ARGS)		
	XDEF	fR24__JASMINE_EA__r10P07JASMINEr7Ui
fR24__JASMINE_EA__r10P07JASMINEr7Ui
L122
;	return jvm->gpRegs[24].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$C0(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR25(EA_ARGS)		
	XDEF	fR25__JASMINE_EA__r10P07JASMINEr7Ui
fR25__JASMINE_EA__r10P07JASMINEr7Ui
L123
;	return jvm->gpRegs[25].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$C8(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR26(EA_ARGS)		
	XDEF	fR26__JASMINE_EA__r10P07JASMINEr7Ui
fR26__JASMINE_EA__r10P07JASMINEr7Ui
L124
;	return jvm->gpRegs[26].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$D0(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR27(EA_ARGS)		
	XDEF	fR27__JASMINE_EA__r10P07JASMINEr7Ui
fR27__JASMINE_EA__r10P07JASMINEr7Ui
L125
;	return jvm->gpRegs[27].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$D8(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR28(EA_ARGS)		
	XDEF	fR28__JASMINE_EA__r10P07JASMINEr7Ui
fR28__JASMINE_EA__r10P07JASMINEr7Ui
L126
;	return jvm->gpRegs[28].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$E0(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR29(EA_ARGS)		
	XDEF	fR29__JASMINE_EA__r10P07JASMINEr7Ui
fR29__JASMINE_EA__r10P07JASMINEr7Ui
L127
;	return jvm->gpRegs[29].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$E8(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR30(EA_ARGS)		
	XDEF	fR30__JASMINE_EA__r10P07JASMINEr7Ui
fR30__JASMINE_EA__r10P07JASMINEr7Ui
L128
;	return jvm->gpRegs[30].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$F0(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fR31(EA_ARGS)		
	XDEF	fR31__JASMINE_EA__r10P07JASMINEr7Ui
fR31__JASMINE_EA__r10P07JASMINEr7Ui
L129
;	return jvm->gpRegs[31].Data(s);
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$F8(a2),a0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fIR0(EA_ARGS)		
	XDEF	fIR0__JASMINE_EA__r10P07JASMINEr7Ui
fIR0__JASMINE_EA__r10P07JASMINEr7Ui
L130
;	return jvm->gpRegs[0].PtrU8();
	move.l	4(a2),d0
	rts

;void* JASMINE_EA::fIR1(EA_ARGS)		
	XDEF	fIR1__JASMINE_EA__r10P07JASMINEr7Ui
fIR1__JASMINE_EA__r10P07JASMINEr7Ui
L131
;	return jvm->gpRegs[1].PtrU8();
	lea	$8(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR2(EA_ARGS)		
	XDEF	fIR2__JASMINE_EA__r10P07JASMINEr7Ui
fIR2__JASMINE_EA__r10P07JASMINEr7Ui
L132
;	return jvm->gpRegs[2].PtrU8();
	lea	$10(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR3(EA_ARGS)		
	XDEF	fIR3__JASMINE_EA__r10P07JASMINEr7Ui
fIR3__JASMINE_EA__r10P07JASMINEr7Ui
L133
;	return jvm->gpRegs[3].PtrU8();
	lea	$18(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR4(EA_ARGS)		
	XDEF	fIR4__JASMINE_EA__r10P07JASMINEr7Ui
fIR4__JASMINE_EA__r10P07JASMINEr7Ui
L134
;	return jvm->gpRegs[4].PtrU8();
	lea	$20(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR5(EA_ARGS)		
	XDEF	fIR5__JASMINE_EA__r10P07JASMINEr7Ui
fIR5__JASMINE_EA__r10P07JASMINEr7Ui
L135
;	return jvm->gpRegs[5].PtrU8();
	lea	$28(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR6(EA_ARGS)		
	XDEF	fIR6__JASMINE_EA__r10P07JASMINEr7Ui
fIR6__JASMINE_EA__r10P07JASMINEr7Ui
L136
;	return jvm->gpRegs[6].PtrU8();
	lea	$30(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR7(EA_ARGS)		
	XDEF	fIR7__JASMINE_EA__r10P07JASMINEr7Ui
fIR7__JASMINE_EA__r10P07JASMINEr7Ui
L137
;	return jvm->gpRegs[7].PtrU8();
	lea	$38(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR8(EA_ARGS)		
	XDEF	fIR8__JASMINE_EA__r10P07JASMINEr7Ui
fIR8__JASMINE_EA__r10P07JASMINEr7Ui
L138
;	return jvm->gpRegs[8].PtrU8();
	lea	$40(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR9(EA_ARGS)		
	XDEF	fIR9__JASMINE_EA__r10P07JASMINEr7Ui
fIR9__JASMINE_EA__r10P07JASMINEr7Ui
L139
;	return jvm->gpRegs[9].PtrU8();
	lea	$48(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR10(EA_ARGS)	
	XDEF	fIR10__JASMINE_EA__r10P07JASMINEr7Ui
fIR10__JASMINE_EA__r10P07JASMINEr7Ui
L140
;	return jvm->gpRegs[10].PtrU8();
	lea	$50(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR11(EA_ARGS)	
	XDEF	fIR11__JASMINE_EA__r10P07JASMINEr7Ui
fIR11__JASMINE_EA__r10P07JASMINEr7Ui
L141
;	return jvm->gpRegs[11].PtrU8();
	lea	$58(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR12(EA_ARGS)	
	XDEF	fIR12__JASMINE_EA__r10P07JASMINEr7Ui
fIR12__JASMINE_EA__r10P07JASMINEr7Ui
L142
;	return jvm->gpRegs[12].PtrU8();
	lea	$60(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR13(EA_ARGS)	
	XDEF	fIR13__JASMINE_EA__r10P07JASMINEr7Ui
fIR13__JASMINE_EA__r10P07JASMINEr7Ui
L143
;	return jvm->gpRegs[13].PtrU8();
	lea	$68(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR14(EA_ARGS)	
	XDEF	fIR14__JASMINE_EA__r10P07JASMINEr7Ui
fIR14__JASMINE_EA__r10P07JASMINEr7Ui
L144
;	return jvm->gpRegs[14].PtrU8();
	lea	$70(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR15(EA_ARGS)	
	XDEF	fIR15__JASMINE_EA__r10P07JASMINEr7Ui
fIR15__JASMINE_EA__r10P07JASMINEr7Ui
L145
;	return jvm->gpRegs[15].PtrU8();
	lea	$78(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR16(EA_ARGS)	
	XDEF	fIR16__JASMINE_EA__r10P07JASMINEr7Ui
fIR16__JASMINE_EA__r10P07JASMINEr7Ui
L146
;	return jvm->gpRegs[16].PtrU8();
	lea	$80(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR17(EA_ARGS)	
	XDEF	fIR17__JASMINE_EA__r10P07JASMINEr7Ui
fIR17__JASMINE_EA__r10P07JASMINEr7Ui
L147
;	return jvm->gpRegs[17].PtrU8();
	lea	$88(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR18(EA_ARGS)	
	XDEF	fIR18__JASMINE_EA__r10P07JASMINEr7Ui
fIR18__JASMINE_EA__r10P07JASMINEr7Ui
L148
;	return jvm->gpRegs[18].PtrU8();
	lea	$90(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR19(EA_ARGS)	
	XDEF	fIR19__JASMINE_EA__r10P07JASMINEr7Ui
fIR19__JASMINE_EA__r10P07JASMINEr7Ui
L149
;	return jvm->gpRegs[19].PtrU8();
	lea	$98(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR20(EA_ARGS)	
	XDEF	fIR20__JASMINE_EA__r10P07JASMINEr7Ui
fIR20__JASMINE_EA__r10P07JASMINEr7Ui
L150
;	return jvm->gpRegs[20].PtrU8();
	lea	$A0(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR21(EA_ARGS)	
	XDEF	fIR21__JASMINE_EA__r10P07JASMINEr7Ui
fIR21__JASMINE_EA__r10P07JASMINEr7Ui
L151
;	return jvm->gpRegs[21].PtrU8();
	lea	$A8(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR22(EA_ARGS)	
	XDEF	fIR22__JASMINE_EA__r10P07JASMINEr7Ui
fIR22__JASMINE_EA__r10P07JASMINEr7Ui
L152
;	return jvm->gpRegs[22].PtrU8();
	lea	$B0(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR23(EA_ARGS)	
	XDEF	fIR23__JASMINE_EA__r10P07JASMINEr7Ui
fIR23__JASMINE_EA__r10P07JASMINEr7Ui
L153
;	return jvm->gpRegs[23].PtrU8();
	lea	$B8(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR24(EA_ARGS)	
	XDEF	fIR24__JASMINE_EA__r10P07JASMINEr7Ui
fIR24__JASMINE_EA__r10P07JASMINEr7Ui
L154
;	return jvm->gpRegs[24].PtrU8();
	lea	$C0(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR25(EA_ARGS)	
	XDEF	fIR25__JASMINE_EA__r10P07JASMINEr7Ui
fIR25__JASMINE_EA__r10P07JASMINEr7Ui
L155
;	return jvm->gpRegs[25].PtrU8();
	lea	$C8(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR26(EA_ARGS)	
	XDEF	fIR26__JASMINE_EA__r10P07JASMINEr7Ui
fIR26__JASMINE_EA__r10P07JASMINEr7Ui
L156
;	return jvm->gpRegs[26].PtrU8();
	lea	$D0(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR27(EA_ARGS)	
	XDEF	fIR27__JASMINE_EA__r10P07JASMINEr7Ui
fIR27__JASMINE_EA__r10P07JASMINEr7Ui
L157
;	return jvm->gpRegs[27].PtrU8();
	lea	$D8(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR28(EA_ARGS)	
	XDEF	fIR28__JASMINE_EA__r10P07JASMINEr7Ui
fIR28__JASMINE_EA__r10P07JASMINEr7Ui
L158
;	return jvm->gpRegs[28].PtrU8();
	lea	$E0(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR29(EA_ARGS)	
	XDEF	fIR29__JASMINE_EA__r10P07JASMINEr7Ui
fIR29__JASMINE_EA__r10P07JASMINEr7Ui
L159
;	return jvm->gpRegs[29].PtrU8();
	lea	$E8(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR30(EA_ARGS)	
	XDEF	fIR30__JASMINE_EA__r10P07JASMINEr7Ui
fIR30__JASMINE_EA__r10P07JASMINEr7Ui
L160
;	return jvm->gpRegs[30].PtrU8();
	lea	$F0(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fIR31(EA_ARGS)	
	XDEF	fIR31__JASMINE_EA__r10P07JASMINEr7Ui
fIR31__JASMINE_EA__r10P07JASMINEr7Ui
L161
;	return jvm->gpRegs[31].PtrU8();
	lea	$F8(a2),a0
	move.l	4(a0),d0
	rts

;void* JASMINE_EA::fLIR0(EA_ARGS)	
	XDEF	fLIR0__JASMINE_EA__r10P07JASMINEr7Ui
fLIR0__JASMINE_EA__r10P07JASMINEr7Ui
L162
; return jvm->gpRegs[0].PtrU8() + EAOFFSET();
	move.l	4(a2),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR1(EA_ARGS)	
	XDEF	fLIR1__JASMINE_EA__r10P07JASMINEr7Ui
fLIR1__JASMINE_EA__r10P07JASMINEr7Ui
L163
; return jvm->gpRegs[1].PtrU8() + EAOFFSET();
	lea	$8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR2(EA_ARGS)	
	XDEF	fLIR2__JASMINE_EA__r10P07JASMINEr7Ui
fLIR2__JASMINE_EA__r10P07JASMINEr7Ui
L164
; return jvm->gpRegs[2].PtrU8() + EAOFFSET();
	lea	$10(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR3(EA_ARGS)	
	XDEF	fLIR3__JASMINE_EA__r10P07JASMINEr7Ui
fLIR3__JASMINE_EA__r10P07JASMINEr7Ui
L165
; return jvm->gpRegs[3].PtrU8() + EAOFFSET();
	lea	$18(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR4(EA_ARGS)	
	XDEF	fLIR4__JASMINE_EA__r10P07JASMINEr7Ui
fLIR4__JASMINE_EA__r10P07JASMINEr7Ui
L166
; return jvm->gpRegs[4].PtrU8() + EAOFFSET();
	lea	$20(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR5(EA_ARGS)	
	XDEF	fLIR5__JASMINE_EA__r10P07JASMINEr7Ui
fLIR5__JASMINE_EA__r10P07JASMINEr7Ui
L167
; return jvm->gpRegs[5].PtrU8() + EAOFFSET();
	lea	$28(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR6(EA_ARGS)	
	XDEF	fLIR6__JASMINE_EA__r10P07JASMINEr7Ui
fLIR6__JASMINE_EA__r10P07JASMINEr7Ui
L168
; return jvm->gpRegs[6].PtrU8() + EAOFFSET();
	lea	$30(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR7(EA_ARGS)	
	XDEF	fLIR7__JASMINE_EA__r10P07JASMINEr7Ui
fLIR7__JASMINE_EA__r10P07JASMINEr7Ui
L169
; return jvm->gpRegs[7].PtrU8() + EAOFFSET();
	lea	$38(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR8(EA_ARGS)	
	XDEF	fLIR8__JASMINE_EA__r10P07JASMINEr7Ui
fLIR8__JASMINE_EA__r10P07JASMINEr7Ui
L170
; return jvm->gpRegs[8].PtrU8() + EAOFFSET();
	lea	$40(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR9(EA_ARGS)	
	XDEF	fLIR9__JASMINE_EA__r10P07JASMINEr7Ui
fLIR9__JASMINE_EA__r10P07JASMINEr7Ui
L171
; return jvm->gpRegs[9].PtrU8() + EAOFFSET();
	lea	$48(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR10(EA_ARGS)	
	XDEF	fLIR10__JASMINE_EA__r10P07JASMINEr7Ui
fLIR10__JASMINE_EA__r10P07JASMINEr7Ui
L172
; return jvm->gpRegs[10].PtrU8() + EAOFFSET();
	lea	$50(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR11(EA_ARGS)	
	XDEF	fLIR11__JASMINE_EA__r10P07JASMINEr7Ui
fLIR11__JASMINE_EA__r10P07JASMINEr7Ui
L173
; return jvm->gpRegs[11].PtrU8() + EAOFFSET();
	lea	$58(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR12(EA_ARGS)	
	XDEF	fLIR12__JASMINE_EA__r10P07JASMINEr7Ui
fLIR12__JASMINE_EA__r10P07JASMINEr7Ui
L174
; return jvm->gpRegs[12].PtrU8() + EAOFFSET();
	lea	$60(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR13(EA_ARGS)	
	XDEF	fLIR13__JASMINE_EA__r10P07JASMINEr7Ui
fLIR13__JASMINE_EA__r10P07JASMINEr7Ui
L175
; return jvm->gpRegs[13].PtrU8() + EAOFFSET();
	lea	$68(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR14(EA_ARGS)	
	XDEF	fLIR14__JASMINE_EA__r10P07JASMINEr7Ui
fLIR14__JASMINE_EA__r10P07JASMINEr7Ui
L176
; return jvm->gpRegs[14].PtrU8() + EAOFFSET();
	lea	$70(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR15(EA_ARGS)	
	XDEF	fLIR15__JASMINE_EA__r10P07JASMINEr7Ui
fLIR15__JASMINE_EA__r10P07JASMINEr7Ui
L177
; return jvm->gpRegs[15].PtrU8() + EAOFFSET();
	lea	$78(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR16(EA_ARGS)	
	XDEF	fLIR16__JASMINE_EA__r10P07JASMINEr7Ui
fLIR16__JASMINE_EA__r10P07JASMINEr7Ui
L178
; return jvm->gpRegs[16].PtrU8() + EAOFFSET();
	lea	$80(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR17(EA_ARGS)	
	XDEF	fLIR17__JASMINE_EA__r10P07JASMINEr7Ui
fLIR17__JASMINE_EA__r10P07JASMINEr7Ui
L179
; return jvm->gpRegs[17].PtrU8() + EAOFFSET();
	lea	$88(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR18(EA_ARGS)	
	XDEF	fLIR18__JASMINE_EA__r10P07JASMINEr7Ui
fLIR18__JASMINE_EA__r10P07JASMINEr7Ui
L180
; return jvm->gpRegs[18].PtrU8() + EAOFFSET();
	lea	$90(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR19(EA_ARGS)	
	XDEF	fLIR19__JASMINE_EA__r10P07JASMINEr7Ui
fLIR19__JASMINE_EA__r10P07JASMINEr7Ui
L181
; return jvm->gpRegs[19].PtrU8() + EAOFFSET();
	lea	$98(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR20(EA_ARGS)	
	XDEF	fLIR20__JASMINE_EA__r10P07JASMINEr7Ui
fLIR20__JASMINE_EA__r10P07JASMINEr7Ui
L182
; return jvm->gpRegs[20].PtrU8() + EAOFFSET();
	lea	$A0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR21(EA_ARGS)	
	XDEF	fLIR21__JASMINE_EA__r10P07JASMINEr7Ui
fLIR21__JASMINE_EA__r10P07JASMINEr7Ui
L183
; return jvm->gpRegs[21].PtrU8() + EAOFFSET();
	lea	$A8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR22(EA_ARGS)	
	XDEF	fLIR22__JASMINE_EA__r10P07JASMINEr7Ui
fLIR22__JASMINE_EA__r10P07JASMINEr7Ui
L184
; return jvm->gpRegs[22].PtrU8() + EAOFFSET();
	lea	$B0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR23(EA_ARGS)	
	XDEF	fLIR23__JASMINE_EA__r10P07JASMINEr7Ui
fLIR23__JASMINE_EA__r10P07JASMINEr7Ui
L185
; return jvm->gpRegs[23].PtrU8() + EAOFFSET();
	lea	$B8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR24(EA_ARGS)	
	XDEF	fLIR24__JASMINE_EA__r10P07JASMINEr7Ui
fLIR24__JASMINE_EA__r10P07JASMINEr7Ui
L186
; return jvm->gpRegs[24].PtrU8() + EAOFFSET();
	lea	$C0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR25(EA_ARGS)	
	XDEF	fLIR25__JASMINE_EA__r10P07JASMINEr7Ui
fLIR25__JASMINE_EA__r10P07JASMINEr7Ui
L187
; return jvm->gpRegs[25].PtrU8() + EAOFFSET();
	lea	$C8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR26(EA_ARGS)	
	XDEF	fLIR26__JASMINE_EA__r10P07JASMINEr7Ui
fLIR26__JASMINE_EA__r10P07JASMINEr7Ui
L188
; return jvm->gpRegs[26].PtrU8() + EAOFFSET();
	lea	$D0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR27(EA_ARGS)	
	XDEF	fLIR27__JASMINE_EA__r10P07JASMINEr7Ui
fLIR27__JASMINE_EA__r10P07JASMINEr7Ui
L189
; return jvm->gpRegs[27].PtrU8() + EAOFFSET();
	lea	$D8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR28(EA_ARGS)	
	XDEF	fLIR28__JASMINE_EA__r10P07JASMINEr7Ui
fLIR28__JASMINE_EA__r10P07JASMINEr7Ui
L190
; return jvm->gpRegs[28].PtrU8() + EAOFFSET();
	lea	$E0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR29(EA_ARGS)	
	XDEF	fLIR29__JASMINE_EA__r10P07JASMINEr7Ui
fLIR29__JASMINE_EA__r10P07JASMINEr7Ui
L191
; return jvm->gpRegs[29].PtrU8() + EAOFFSET();
	lea	$E8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR30(EA_ARGS)	
	XDEF	fLIR30__JASMINE_EA__r10P07JASMINEr7Ui
fLIR30__JASMINE_EA__r10P07JASMINEr7Ui
L192
; return jvm->gpRegs[30].PtrU8() + EAOFFSET();
	lea	$F0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLIR31(EA_ARGS)	
	XDEF	fLIR31__JASMINE_EA__r10P07JASMINEr7Ui
fLIR31__JASMINE_EA__r10P07JASMINEr7Ui
L193
; return jvm->gpRegs[31].PtrU8() + EAOFFSET();
	lea	$F8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLUIR0(EA_ARGS)
	XDEF	fLUIR0__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR0__JASMINE_EA__r10P07JASMINEr7Ui
L194
;	uint8* &p = jvm->gpRegs[0].PtrU8();
	lea	4(a2),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR1(EA_ARGS)
	XDEF	fLUIR1__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR1__JASMINE_EA__r10P07JASMINEr7Ui
L195
;	uint8* &p = jvm->gpRegs[1].PtrU8();
	lea	$8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR2(EA_ARGS)
	XDEF	fLUIR2__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR2__JASMINE_EA__r10P07JASMINEr7Ui
L196
;	uint8* &p = jvm->gpRegs[2].PtrU8();
	lea	$10(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR3(EA_ARGS)
	XDEF	fLUIR3__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR3__JASMINE_EA__r10P07JASMINEr7Ui
L197
;	uint8* &p = jvm->gpRegs[3].PtrU8();
	lea	$18(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR4(EA_ARGS)
	XDEF	fLUIR4__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR4__JASMINE_EA__r10P07JASMINEr7Ui
L198
;	uint8* &p = jvm->gpRegs[4].PtrU8();
	lea	$20(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR5(EA_ARGS)
	XDEF	fLUIR5__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR5__JASMINE_EA__r10P07JASMINEr7Ui
L199
;	uint8* &p = jvm->gpRegs[5].PtrU8();
	lea	$28(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR6(EA_ARGS)
	XDEF	fLUIR6__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR6__JASMINE_EA__r10P07JASMINEr7Ui
L200
;	uint8* &p = jvm->gpRegs[6].PtrU8();
	lea	$30(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR7(EA_ARGS)
	XDEF	fLUIR7__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR7__JASMINE_EA__r10P07JASMINEr7Ui
L201
;	uint8* &p = jvm->gpRegs[7].PtrU8();
	lea	$38(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR8(EA_ARGS)
	XDEF	fLUIR8__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR8__JASMINE_EA__r10P07JASMINEr7Ui
L202
;	uint8* &p = jvm->gpRegs[8].PtrU8();
	lea	$40(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR9(EA_ARGS)
	XDEF	fLUIR9__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR9__JASMINE_EA__r10P07JASMINEr7Ui
L203
;	uint8* &p = jvm->gpRegs[9].PtrU8();
	lea	$48(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR10(EA_ARGS)
	XDEF	fLUIR10__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR10__JASMINE_EA__r10P07JASMINEr7Ui
L204
;	uint8* &p = jvm->gpRegs[10].PtrU8();
	lea	$50(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR11(EA_ARGS)
	XDEF	fLUIR11__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR11__JASMINE_EA__r10P07JASMINEr7Ui
L205
;	uint8* &p = jvm->gpRegs[11].PtrU8();
	lea	$58(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR12(EA_ARGS)
	XDEF	fLUIR12__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR12__JASMINE_EA__r10P07JASMINEr7Ui
L206
;	uint8* &p = jvm->gpRegs[12].PtrU8();
	lea	$60(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR13(EA_ARGS)
	XDEF	fLUIR13__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR13__JASMINE_EA__r10P07JASMINEr7Ui
L207
;	uint8* &p = jvm->gpRegs[13].PtrU8();
	lea	$68(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR14(EA_ARGS)
	XDEF	fLUIR14__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR14__JASMINE_EA__r10P07JASMINEr7Ui
L208
;	uint8* &p = jvm->gpRegs[14].PtrU8();
	lea	$70(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR15(EA_ARGS)
	XDEF	fLUIR15__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR15__JASMINE_EA__r10P07JASMINEr7Ui
L209
;	uint8* &p = jvm->gpRegs[15].PtrU8();
	lea	$78(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR16(EA_ARGS)
	XDEF	fLUIR16__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR16__JASMINE_EA__r10P07JASMINEr7Ui
L210
;	uint8* &p = jvm->gpRegs[16].PtrU8();
	lea	$80(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR17(EA_ARGS)
	XDEF	fLUIR17__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR17__JASMINE_EA__r10P07JASMINEr7Ui
L211
;	uint8* &p = jvm->gpRegs[17].PtrU8();
	lea	$88(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR18(EA_ARGS)
	XDEF	fLUIR18__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR18__JASMINE_EA__r10P07JASMINEr7Ui
L212
;	uint8* &p = jvm->gpRegs[18].PtrU8();
	lea	$90(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR19(EA_ARGS)
	XDEF	fLUIR19__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR19__JASMINE_EA__r10P07JASMINEr7Ui
L213
;	uint8* &p = jvm->gpRegs[19].PtrU8();
	lea	$98(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR20(EA_ARGS)
	XDEF	fLUIR20__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR20__JASMINE_EA__r10P07JASMINEr7Ui
L214
;	uint8* &p = jvm->gpRegs[20].PtrU8();
	lea	$A0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR21(EA_ARGS)
	XDEF	fLUIR21__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR21__JASMINE_EA__r10P07JASMINEr7Ui
L215
;	uint8* &p = jvm->gpRegs[21].PtrU8();
	lea	$A8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR22(EA_ARGS)
	XDEF	fLUIR22__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR22__JASMINE_EA__r10P07JASMINEr7Ui
L216
;	uint8* &p = jvm->gpRegs[22].PtrU8();
	lea	$B0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR23(EA_ARGS)
	XDEF	fLUIR23__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR23__JASMINE_EA__r10P07JASMINEr7Ui
L217
;	uint8* &p = jvm->gpRegs[23].PtrU8();
	lea	$B8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR24(EA_ARGS)
	XDEF	fLUIR24__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR24__JASMINE_EA__r10P07JASMINEr7Ui
L218
;	uint8* &p = jvm->gpRegs[24].PtrU8();
	lea	$C0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR25(EA_ARGS)
	XDEF	fLUIR25__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR25__JASMINE_EA__r10P07JASMINEr7Ui
L219
;	uint8* &p = jvm->gpRegs[25].PtrU8();
	lea	$C8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR26(EA_ARGS)
	XDEF	fLUIR26__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR26__JASMINE_EA__r10P07JASMINEr7Ui
L220
;	uint8* &p = jvm->gpRegs[26].PtrU8();
	lea	$D0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR27(EA_ARGS)
	XDEF	fLUIR27__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR27__JASMINE_EA__r10P07JASMINEr7Ui
L221
;	uint8* &p = jvm->gpRegs[27].PtrU8();
	lea	$D8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR28(EA_ARGS)
	XDEF	fLUIR28__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR28__JASMINE_EA__r10P07JASMINEr7Ui
L222
;	uint8* &p = jvm->gpRegs[28].PtrU8();
	lea	$E0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR29(EA_ARGS)
	XDEF	fLUIR29__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR29__JASMINE_EA__r10P07JASMINEr7Ui
L223
;	uint8* &p = jvm->gpRegs[29].PtrU8();
	lea	$E8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR30(EA_ARGS)
	XDEF	fLUIR30__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR30__JASMINE_EA__r10P07JASMINEr7Ui
L224
;	uint8* &p = jvm->gpRegs[30].PtrU8();
	lea	$F0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fLUIR31(EA_ARGS)
	XDEF	fLUIR31__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR31__JASMINE_EA__r10P07JASMINEr7Ui
L225
;	uint8* &p = jvm->gpRegs[31].PtrU8();
	lea	$F8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fIRRO(EA_ARGS)
	XDEF	fIRRO__JASMINE_EA__r10P07JASMINEr7Ui
fIRRO__JASMINE_EA__r10P07JASMINEr7Ui
L226
;	jvm->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	return IRRO_BASEREG.PtrU8() + IRRO_OFSTREG();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fIRROU(EA_ARGS)
	XDEF	fIRROU__JASMINE_EA__r10P07JASMINEr7Ui
fIRROU__JASMINE_EA__r10P07JASMINEr7Ui
L227
;	jvm->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	uint8*	&p = IRRO_BASEREG.PtrU8();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	lea	4(a0),a1
;	p += IRRO_OFSTREG();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fIRSRO(EA_ARGS)
	XDEF	fIRSRO__JASMINE_EA__r10P07JASMINEr7Ui
fIRSRO__JASMINE_EA__r10P07JASMINEr7Ui
L228
;	jvm->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	return IRRO_BASEREG.PtrU8() + IRRO_SCALE()*IRRO_OFSTREG();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	moveq	#0,d0
	move.w	(a0),d0
	move.l	$110(a2),a0
	moveq	#0,d1
	move.b	2(a0),d1
	lea	0(a2,d1.l*8),a0
	muls.l	4(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fIRSROU(EA_ARGS)
	XDEF	fIRSROU__JASMINE_EA__r10P07JASMINEr7Ui
fIRSROU__JASMINE_EA__r10P07JASMINEr7Ui
L229
;	jvm->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	uint8*	&p = IRRO_BASEREG.PtrU8();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	lea	4(a0),a1
;	p += IRRO_SCALE()*IRRO_OFSTREG();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.w	(a0),d0
	move.l	$110(a2),a0
	moveq	#0,d1
	move.b	2(a0),d1
	lea	0(a2,d1.l*8),a0
	muls.l	4(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
;	return p;
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fCTR(EA_ARGS)			
	XDEF	fCTR__JASMINE_EA__r10P07JASMINEr7Ui
fCTR__JASMINE_EA__r10P07JASMINEr7Ui
L230
; return &jvm->countReg;
	move.l	#$138,d0
	add.l	a2,d0
	rts

;void* JASMINE_EA::fDS(EA_ARGS)			
	XDEF	fDS__JASMINE_EA__r10P07JASMINEr7Ui
fDS__JASMINE_EA__r10P07JASMINEr7Ui
L231
;	return ((uint8*)jvm->dataSectPtr) + EAOFFSET();
	move.l	$12C(a2),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fCDS(EA_ARGS)			
	XDEF	fCDS__JASMINE_EA__r10P07JASMINEr7Ui
fCDS__JASMINE_EA__r10P07JASMINEr7Ui
L232
;	return ((uint8*)jvm->constSectPtr) + EAOFFSET();
	move.l	$130(a2),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLITERAL(EA_ARGS)	
	XDEF	fLITERAL__JASMINE_EA__r10P07JASMINEr7Ui
fLITERAL__JASMINE_EA__r10P07JASMINEr7Ui
L233
; return GETLITERAL(s);
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	lea	4(a0),a0
	move.l	d7,d0
	muls.l	#-1,d0
	add.l	a0,d0
	rts

;void* JASMINE_EA::fOFFSET_PC(EA_ARGS)		
	XDEF	fOFFSET_PC__JASMINE_EA__r10P07JASMINEr7Ui
fOFFSET_PC__JASMINE_EA__r10P07JASMINEr7Ui
L234
; jvm->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
; return jvm->instPtr + *((sint32*)jvm->instPtr);
	move.l	$110(a2),a0
	move.l	(a0),d0
	asl.l	#2,d0
	add.l	$110(a2),d0
	rts

;void* JASMINE_EA::fFUNC_TAB(EA_ARGS) 
	XDEF	fFUNC_TAB__JASMINE_EA__r10P07JASMINEr7Ui
fFUNC_TAB__JASMINE_EA__r10P07JASMINEr7Ui
L235
; return 0;
	moveq	#0,d0
	rts

	END
