
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineSys.cpp
	mc68030
	mc68881
	XREF	_0dt__JASMINEOBJECT__T
	XREF	CnstSize__JASMINEOBJECT__T
	XREF	DataSize__JASMINEOBJECT__T
	XREF	CodeSize__JASMINEOBJECT__T
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
	XREF	GetPC__JASMINE__T
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
	XREF	_scanf
	XREF	_printf
	XREF	_fflush
	XREF	_puts
	XREF	_fgets
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


;void JASMINE_EA::DSYS_EA(EA_ARGS)
	XDEF	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
	movem.l	d2/d7,-(a7)
L122
;	uint32 x = ((uint8*)jvm->instPtr)[2];
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
;	if (x<VM::IM0)
	cmp.l	#$E0,d0
	bhs.b	L124
L123
;		jvm->op[0].any = eaTable[x](jvm,s);
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L129
L124
;		switch(s)
	cmp.l	#4,d7
	beq.b	L127
	bhi.b	L130
	cmp.l	#1,d7
	beq.b	L125
	cmp.l	#2,d7
	beq.b	L126
	bra	L129
L130
	cmp.l	#$8,d7
	beq.b	L128
	bra.b	L129
;			
L125
;				jvm->imReg[0].ValU8() = x-VM::IM0;
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
;				jvm->op[0].any = jvm->imReg[0].Data8();
	lea	$100(a2),a0
	lea	7(a0),a1
	move.l	a1,$114(a2)
;				
	bra.b	L129
L126
;				jvm->imReg[0].ValU16() = x-VM::IM0;
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
;				jvm->op[0].any = jvm->imReg[0].Data16();
	lea	$100(a2),a0
	lea	6(a0),a1
	move.l	a1,$114(a2)
;				
	bra.b	L129
L127
;				jvm->imReg[0].ValU32() = x-VM::IM0;
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
;				jvm->op[0].any = jvm->imReg[0].Data32();
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
;				
	bra.b	L129
L128
;				jvm->imReg[0].ValU64() = x-VM::IM0;
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
;				jvm->op[0].any = jvm->imReg[0].Data64();
	lea	$100(a2),a1
	move.l	a1,$114(a2)
;				
L129
	movem.l	(a7)+,d2/d7
	rts

;void JASMINE_EA::D2SYS_EA(EA_2ARGS)
	XDEF	D2SYS_EA__JASMINE_EA__r10P07JASMINEr6Uir7Ui
D2SYS_EA__JASMINE_EA__r10P07JASMINEr6Uir7Ui
	movem.l	d2/d3/d7,-(a7)
	move.l	d7,d2
	move.l	d6,d7
L131
;	uint32 x = ((uint8*)jvm->instPtr)[2];
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
;	if (x<VM::IM0)
	cmp.l	#$E0,d0
	bhs.b	L133
L132
;		jvm->op[0].any = eaTable[x](jvm,s1);
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L138
L133
;		switch(s1)
	cmp.l	#4,d7
	beq.b	L136
	bhi.b	L146
	cmp.l	#1,d7
	beq.b	L134
	cmp.l	#2,d7
	beq.b	L135
	bra	L138
L146
	cmp.l	#$8,d7
	beq.b	L137
	bra	L138
;			
L134
;				jvm->imReg[0].ValU8() = x-VM::IM0;
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
;				jvm->op[0].any = jvm->imReg[0].Data8();
	lea	$100(a2),a0
	lea	7(a0),a1
	move.l	a1,$114(a2)
;				
	bra.b	L138
L135
;				jvm->imReg[0].ValU16() = x-VM::IM0;
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
;				jvm->op[0].any = jvm->imReg[0].Data16();
	lea	$100(a2),a0
	lea	6(a0),a1
	move.l	a1,$114(a2)
;				
	bra.b	L138
L136
;				jvm->imReg[0].ValU32() = x-VM::IM0;
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
;				jvm->op[0].any = jvm->imReg[0].Data32();
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
;				
	bra.b	L138
L137
;				jvm->imReg[0].ValU64() = x-VM::IM0;
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
;				jvm->op[0].any = jvm->imReg[0].Data64();
	lea	$100(a2),a1
	move.l	a1,$114(a2)
;				
L138
;	x = ((uint8*)jvm->instPtr)[3];
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
;	if (x<VM::IM0)
	cmp.l	#$E0,d0
	bhs.b	L140
L139
;		jvm->op[1].any = eaTable[x](jvm,s2);
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	move.l	d2,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L145
L140
;		switch(s2)
	cmp.l	#4,d2
	beq	L143
	bhi.b	L147
	cmp.l	#1,d2
	beq.b	L141
	cmp.l	#2,d2
	beq.b	L142
	bra	L145
L147
	cmp.l	#$8,d2
	beq	L144
	bra	L145
;			
L141
;				jvm->imReg[1].ValU8() = x-VM::IM0;
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
;				jvm->op[1].any = jvm->imReg[1].Data8();
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	7(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
;				
	bra	L145
L142
;				jvm->imReg[1].ValU16() = x-VM::IM0;
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
;				jvm->op[1].any = jvm->imReg[1].Data16();
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	6(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
;				
	bra.b	L145
L143
;				jvm->imReg[1].ValU32() = x-VM::IM0;
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
;				jvm->op[1].any = jvm->imReg[1].Data32();
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
;				
	bra.b	L145
L144
;				jvm->imReg[1].ValU64() = x-VM::IM0;
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
;				jvm->op[1].any = jvm->imReg[1].Data64();
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
;				
L145
	movem.l	(a7)+,d2/d3/d7
	rts

;void JASMINE_OP::fSYS(OP_ARGS)
	XDEF	fSYS__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L148
;	sysTable[((uint8*)jvm->instPtr)[1]](jvm, pf);
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	move.l	#_sysTable__JASMINE_OP,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
;	jvm->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	rts

;void JASMINE_OP::fSYS_OUT_U8(OP_ARGS)
	XDEF	fSYS_OUT_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L150
;	JASMINE_EA::DSYS_EA(jvm,1);
	moveq	#1,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("%c", *jvm->op[0].u8);
	move.l	$114(a2),a0
	moveq	#0,d0
	move.b	(a0),d0
	move.l	d0,-(a7)
	move.l	#L149,-(a7)
	jsr	_printf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_U16(OP_ARGS)
	XDEF	fSYS_OUT_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L152
;	JASMINE_EA::DSYS_EA(jvm,2);
	moveq	#2,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("%hu", *jvm->op[0].u16);
	move.l	$114(a2),a0
	moveq	#0,d0
	move.w	(a0),d0
	move.l	d0,-(a7)
	move.l	#L151,-(a7)
	jsr	_printf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_U32(OP_ARGS)
	XDEF	fSYS_OUT_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L154
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("%lu", *jvm->op[0].u32);
	move.l	$114(a2),a0
	move.l	(a0),-(a7)
	move.l	#L153,-(a7)
	jsr	_printf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_U64(OP_ARGS)
	XDEF	fSYS_OUT_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L156
;	JASMINE_EA::DSYS_EA(jvm,8);
	moveq	#$8,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("0x%08X%08X",(jvm->op[0].u32)[0],(jvm->op[0].u32)[1]);
	move.l	$114(a2),a0
	move.l	4(a0),-(a7)
	move.l	$114(a2),a0
	move.l	(a0),-(a7)
	move.l	#L155,-(a7)
	jsr	_printf
	add.w	#$C,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_S8(OP_ARGS)
	XDEF	fSYS_OUT_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L157
;	JASMINE_EA::DSYS_EA(jvm,1);
	moveq	#1,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("%c", *jvm->op[0].s8);
	move.l	$114(a2),a0
	move.b	(a0),d0
	extb.l	d0
	move.l	d0,-(a7)
	move.l	#L149,-(a7)
	jsr	_printf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_S16(OP_ARGS)
	XDEF	fSYS_OUT_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L159
;	JASMINE_EA::DSYS_EA(jvm,2);
	moveq	#2,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("%hi", *jvm->op[0].s16);
	move.l	$114(a2),a0
	move.w	(a0),d0
	ext.l	d0
	move.l	d0,-(a7)
	move.l	#L158,-(a7)
	jsr	_printf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_S32(OP_ARGS)
	XDEF	fSYS_OUT_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L161
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("%li", *jvm->op[0].s32);
	move.l	$114(a2),a0
	move.l	(a0),-(a7)
	move.l	#L160,-(a7)
	jsr	_printf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_S64(OP_ARGS)
	XDEF	fSYS_OUT_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L162
;	JASMINE_EA::DSYS_EA(jvm,8);
	moveq	#$8,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("0x%08X%08X",(jvm->op[0].u32)[0],(jvm->op[0].u32)[1]);
	move.l	$114(a2),a0
	move.l	4(a0),-(a7)
	move.l	$114(a2),a0
	move.l	(a0),-(a7)
	move.l	#L155,-(a7)
	jsr	_printf
	add.w	#$C,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_F32(OP_ARGS)
	XDEF	fSYS_OUT_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L164
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("%.6G", *jvm->op[0].f32);
	move.l	$114(a2),a0
	fmove.s	(a0),fp0
	fmove.d	fp0,-(a7)
	move.l	#L163,-(a7)
	jsr	_printf
	add.w	#$C,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_F64(OP_ARGS)
	XDEF	fSYS_OUT_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L166
;	JASMINE_EA::DSYS_EA(jvm,8);
	moveq	#$8,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("%.10G", *jvm->op[0].f64);
	move.l	$114(a2),a0
	fmove.d	(a0),fp0
	fmove.d	fp0,-(a7)
	move.l	#L165,-(a7)
	jsr	_printf
	add.w	#$C,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_OUT_STR(OP_ARGS)
	XDEF	fSYS_OUT_STR__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_OUT_STR__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L168
;	JASMINE_EA::DSYS_EA(jvm,1);
	moveq	#1,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	printf("%s", jvm->op[0].ch);
	move.l	$114(a2),-(a7)
	move.l	#L167,-(a7)
	jsr	_printf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_U8(OP_ARGS)
	XDEF	fSYS_INP_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L169
;	JASMINE_EA::DSYS_EA(jvm,1);
	moveq	#1,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%c", jvm->op[0].u8);
	move.l	$114(a2),-(a7)
	move.l	#L149,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_U16(OP_ARGS)
	XDEF	fSYS_INP_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L170
;	JASMINE_EA::DSYS_EA(jvm,2);
	moveq	#2,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%hu", jvm->op[0].u16);
	move.l	$114(a2),-(a7)
	move.l	#L151,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_U32(OP_ARGS)
	XDEF	fSYS_INP_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L171
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%lu", jvm->op[0].u32);
	move.l	$114(a2),-(a7)
	move.l	#L153,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_U64(OP_ARGS)
	XDEF	fSYS_INP_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L172
;	JASMINE_EA::DSYS_EA(jvm,8);
	moveq	#$8,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%lu", &(jvm->op[0].u32)[1]);
	move.l	$114(a2),a0
	pea	4(a0)
	move.l	#L153,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_S8(OP_ARGS)
	XDEF	fSYS_INP_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L173
;	JASMINE_EA::DSYS_EA(jvm,1);
	moveq	#1,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%c", jvm->op[0].s8);
	move.l	$114(a2),-(a7)
	move.l	#L149,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_S16(OP_ARGS)
	XDEF	fSYS_INP_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L174
;	JASMINE_EA::DSYS_EA(jvm,2);
	moveq	#2,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%hi", jvm->op[0].s16);
	move.l	$114(a2),-(a7)
	move.l	#L158,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_S32(OP_ARGS)
	XDEF	fSYS_INP_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L175
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%li", jvm->op[0].s32);
	move.l	$114(a2),-(a7)
	move.l	#L160,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_S64(OP_ARGS)
	XDEF	fSYS_INP_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L176
;	JASMINE_EA::DSYS_EA(jvm,8);
	moveq	#$8,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%li", &(jvm->op[0].s32)[1]);
	move.l	$114(a2),a0
	pea	4(a0)
	move.l	#L160,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_F32(OP_ARGS)
	XDEF	fSYS_INP_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L178
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%f", jvm->op[0].f32);
	move.l	$114(a2),-(a7)
	move.l	#L177,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_F64(OP_ARGS)
	XDEF	fSYS_INP_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L180
;	JASMINE_EA::DSYS_EA(jvm,8);
	moveq	#$8,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	scanf("%lf", jvm->op[0].f64);
	move.l	$114(a2),-(a7)
	move.l	#L179,-(a7)
	jsr	_scanf
	addq.w	#$8,a7
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_INP_STR(OP_ARGS)
	XDEF	fSYS_INP_STR__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_INP_STR__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d6/d7,-(a7)
L181
;	JASMINE_EA::D2SYS_EA(jvm,4,1);
	moveq	#4,d6
	moveq	#1,d7
	jsr	D2SYS_EA__JASMINE_EA__r10P07JASMINEr6Uir7Ui
;	fflush(stdout);
	move.l	#_std__out,-(a7)
	jsr	_fflush
	addq.w	#4,a7
;	fgets((char*)(jvm->op[1].u8),*jvm->op[0].s32, stdin);
	move.l	#_std__in,-(a7)
	move.l	$114(a2),a0
	move.l	(a0),-(a7)
	lea	$114(a2),a0
	move.l	4(a0),-(a7)
	jsr	_fgets
	add.w	#$C,a7
	movem.l	(a7)+,d6/d7
	rts

;void JASMINE_OP::fSYS_BRK(OP_ARGS)
	XDEF	fSYS_BRK__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_BRK__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L182
	rts

;void JASMINE_OP::fSYS_DUMP(OP_ARGS)
	XDEF	fSYS_DUMP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_DUMP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d2,-(a7)
L190
;	puts("                 ______________________");
	move.l	#L183,-(a7)
	jsr	_puts
	addq.w	#4,a7
;	puts("  ______________/ VMCORE Register Dump \\______________");
	move.l	#L184,-(a7)
	jsr	_puts
	addq.w	#4,a7
;	for (sint32 i=0;
	moveq	#0,d2
	bra.b	L192
L191
;		printf("  r%-2d: 0x%08X:%08X    r%-2d: 0x%08X:%08X\n",
	move.l	d2,d0
	addq.l	#1,d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),-(a7)
	move.l	d2,d0
	addq.l	#1,d0
	move.l	0(a2,d0.l*8),-(a7)
	move.l	d2,d0
	addq.l	#1,d0
	move.l	d0,-(a7)
	lea	0(a2,d2.l*8),a0
	move.l	4(a0),-(a7)
	move.l	0(a2,d2.l*8),-(a7)
	move.l	d2,-(a7)
	move.l	#L185,-(a7)
	jsr	_printf
	add.w	#$1C,a7
	addq.l	#2,d2
L192
	cmp.l	#$20,d2
	blt.b	L191
L193
;	printf("  i%-2d: 0x%08X:%08X    i%-2d: 0x%08X:%08X\n", 0,
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	4(a0),-(a7)
	lea	$100(a2),a0
	move.l	$8(a0),-(a7)
	pea	1.w
	lea	$100(a2),a0
	move.l	4(a0),-(a7)
	move.l	$100(a2),-(a7)
	clr.l	-(a7)
	move.l	#L186,-(a7)
	jsr	_printf
	add.w	#$1C,a7
;	printf("  PC  : %-5dMS  : %-5dRS   : %-5dDS  : %d\n",
	move.l	$124(a2),d0
	sub.l	$14C(a2),d0
	move.l	d0,-(a7)
	move.l	$120(a2),d0
	sub.l	$154(a2),d0
	moveq	#3,d1
	asr.l	d1,d0
	move.l	d0,-(a7)
	move.l	$128(a2),d0
	sub.l	$144(a2),d0
	moveq	#2,d1
	asr.l	d1,d0
	move.l	d0,-(a7)
	move.l	a2,-(a7)
	jsr	GetPC__JASMINE__T
	addq.w	#4,a7
	move.l	d0,-(a7)
	move.l	#L187,-(a7)
	jsr	_printf
	add.w	#$14,a7
;	printf("  Code: %-5dData: %-5dConst: %-5d\n",
	move.l	$15C(a2),-(a7)
	jsr	CnstSize__JASMINEOBJECT__T
	addq.w	#4,a7
	move.l	d0,-(a7)
	move.l	$15C(a2),-(a7)
	jsr	DataSize__JASMINEOBJECT__T
	addq.w	#4,a7
	move.l	d0,-(a7)
	move.l	$15C(a2),-(a7)
	jsr	CodeSize__JASMINEOBJECT__T
	addq.w	#4,a7
	move.l	d0,-(a7)
	move.l	#L188,-(a7)
	jsr	_printf
	add.w	#$10,a7
;	puts("  ____________________________________________________\n");
	move.l	#L189,-(a7)
	jsr	_puts
	addq.w	#4,a7
	move.l	(a7)+,d2
	rts

;void JASMINE_OP::fSYS_VER(OP_ARGS)
	XDEF	fSYS_VER__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_VER__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L195
;	puts("eXtropia JASMINE version 1");
	move.l	#L194,-(a7)
	jsr	_puts
	addq.w	#4,a7
	rts

;void JASMINE_OP::fSYS_NEW_X8(OP_ARGS)
	XDEF	fSYS_NEW_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_NEW_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L196
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU8() = new uint
	move.l	$114(a2),a0
	move.l	(a0),-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	$110(a2),a0
	moveq	#0,d1
	move.b	3(a0),d1
	lea	0(a2,d1.l*8),a0
	move.l	d0,4(a0)
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_NEW_X16(OP_ARGS)
	XDEF	fSYS_NEW_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_NEW_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L197
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU16() = new uin
	move.l	$114(a2),a0
	move.l	(a0),d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	$110(a2),a0
	moveq	#0,d1
	move.b	3(a0),d1
	lea	0(a2,d1.l*8),a0
	move.l	d0,4(a0)
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_NEW_X32(OP_ARGS)
	XDEF	fSYS_NEW_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_NEW_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L198
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU32() = new uin
	move.l	$114(a2),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	$110(a2),a0
	moveq	#0,d1
	move.b	3(a0),d1
	lea	0(a2,d1.l*8),a0
	move.l	d0,4(a0)
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_NEW_X64(OP_ARGS)
	XDEF	fSYS_NEW_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_NEW_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L199
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU64() = new uin
	move.l	$114(a2),a0
	move.l	(a0),d0
	moveq	#3,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	$110(a2),a0
	moveq	#0,d1
	move.b	3(a0),d1
	lea	0(a2,d1.l*8),a0
	move.l	d0,4(a0)
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_DEL_X8(OP_ARGS)
	XDEF	fSYS_DEL_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_DEL_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L200
;	delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU8();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),a0
	cmp.w	#0,a0
	beq.b	L202
L201
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L202
	rts

;void JASMINE_OP::fSYS_DEL_X16(OP_ARGS)
	XDEF	fSYS_DEL_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_DEL_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L203
;	delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU16();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),a0
	cmp.w	#0,a0
	beq.b	L205
L204
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L205
	rts

;void JASMINE_OP::fSYS_DEL_X32(OP_ARGS)
	XDEF	fSYS_DEL_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_DEL_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L206
;	delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU32();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),a0
	cmp.w	#0,a0
	beq.b	L208
L207
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L208
	rts

;void JASMINE_OP::fSYS_DEL_X64(OP_ARGS)
	XDEF	fSYS_DEL_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_DEL_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L209
;	delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU64();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),a0
	cmp.w	#0,a0
	beq.b	L211
L210
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L211
	rts

;void JASMINE_OP::fSYS_NEWS_X8(OP_ARGS)
	XDEF	fSYS_NEWS_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_NEWS_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L212
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_NEWS_X16(OP_ARGS)
	XDEF	fSYS_NEWS_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_NEWS_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L213
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_NEWS_X32(OP_ARGS)
	XDEF	fSYS_NEWS_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_NEWS_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L214
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_NEWS_X64(OP_ARGS)
	XDEF	fSYS_NEWS_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_NEWS_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L215
;	JASMINE_EA::DSYS_EA(jvm,4);
	moveq	#4,d7
	jsr	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fSYS_DELS_X8(OP_ARGS)
	XDEF	fSYS_DELS_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_DELS_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L216
	rts

;void JASMINE_OP::fSYS_DELS_X16(OP_ARGS)
	XDEF	fSYS_DELS_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_DELS_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L217
	rts

;void JASMINE_OP::fSYS_DELS_X32(OP_ARGS)
	XDEF	fSYS_DELS_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_DELS_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L218
	rts

;void JASMINE_OP::fSYS_DELS_X64(OP_ARGS)
	XDEF	fSYS_DELS_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSYS_DELS_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L219
	rts

L183
	dc.b	'                 ______________________',0
L188
	dc.b	'  Code: %-5dData: %-5dConst: %-5d',$A,0
L187
	dc.b	'  PC  : %-5dMS  : %-5dRS   : %-5dDS  : %d',$A,0
L184
	dc.b	'  ______________/ VMCORE Register Dump \______________',0
L189
	dc.b	'  ____________________________________________________',$A,0
L186
	dc.b	'  i%-2d: 0x%08X:%08X    i%-2d: 0x%08X:%08X',$A,0
L185
	dc.b	'  r%-2d: 0x%08X:%08X    r%-2d: 0x%08X:%08X',$A,0
L165
	dc.b	'%.10G',0
L163
	dc.b	'%.6G',0
L149
	dc.b	'%c',0
L177
	dc.b	'%f',0
L158
	dc.b	'%hi',0
L151
	dc.b	'%hu',0
L179
	dc.b	'%lf',0
L160
	dc.b	'%li',0
L153
	dc.b	'%lu',0
L167
	dc.b	'%s',0
L155
	dc.b	'0x%08X%08X',0
L194
	dc.b	'eXtropia JASMINE version 1',0

	END
