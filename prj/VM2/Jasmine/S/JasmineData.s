
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineData.cpp
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


;void JASMINE_OP::fSAVE(OP_ARGS)
	XDEF	fSAVE__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSAVE__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d2,-(a7)
L144
;	sint32 first	= (((sint8*)jvm->instPtr)[EA1BYTE])/*&0x1F*/;
	move.l	$110(a2),a0
	move.b	1(a0),d0
	extb.l	d0
;	sint32 num		= (((sint8*)jvm->instPtr)[EA2BYTE])/*&0x1F*/ - first;
	move.l	$110(a2),a0
	move.b	2(a0),d1
	extb.l	d1
	sub.l	d0,d1
;	jvm->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	jvm->exitReg = JASMINE::PushRegs(jvm, first, num);
	jsr	PushRegs__JASMINE__r10P07JASMINEr0jr1j
	move.l	d0,$134(a2)
	move.l	(a7)+,d2
	rts

;void JASMINE_OP::fRESTORE(OP_ARGS)
	XDEF	fRESTORE__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fRESTORE__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d2,-(a7)
L145
;	sint32 first	= (((sint8*)jvm->instPtr)[EA1BYTE])/*&0x1F*/;
	move.l	$110(a2),a0
	move.b	1(a0),d0
	extb.l	d0
;	sint32 num		= (((sint8*)jvm->instPtr)[EA2BYTE])/*&0x1F*/ - first;
	move.l	$110(a2),a0
	move.b	2(a0),d1
	extb.l	d1
	sub.l	d0,d1
;	jvm->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	jvm->exitReg = JASMINE::PopRegs(jvm, first, num);
	jsr	PopRegs__JASMINE__r10P07JASMINEr0jr1j
	move.l	d0,$134(a2)
	move.l	(a7)+,d2
	rts

;void JASMINE_OP::fPUSH_X8(OP_ARGS)
	XDEF	fPUSH_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fPUSH_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L146
;	if (jvm->stack+JASMINE::STACK_SIZE_X8 < jvm->stackTop)
	move.l	$124(a2),a0
	lea	2(a0),a1
	cmp.l	$150(a2),a1
	bhs	L157
L147
;		OPINIT()
;		*jvm->stack = OP1_8(uint8);
	move.l	$110(a2),a0
	move.b	1(a0),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L149
L148
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L156
L149
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L151
L150
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L156
L151
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L153
L152
	and.l	#$FF,d0
	move.l	0(a3,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L156
L153
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L154
L155
L156
	move.b	(a0),d0
	move.l	$124(a2),a0
	move.b	d0,(a0)
;		jvm->stack += JASMINE::STACK_SIZE_X8;
	move.l	$124(a2),a0
	lea	2(a0),a0
	move.l	a0,$124(a2)
;		*jvm->stackTrace++ = JASMINE::STACK_TRACE_8;
	move.l	$140(a2),a1
	lea	1(a1),a0
	move.l	a0,$140(a2)
	move.b	#1,(a1)
;		OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	bra.b	L158
L157
;		jvm->exitReg = JASMINE::STACK_OVERFLOW;
	move.l	#4,$134(a2)
L158
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fPUSH_X16(OP_ARGS)
	XDEF	fPUSH_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fPUSH_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L159
;	if (jvm->stack+JASMINE::STACK_SIZE_X16 < jvm->stackTop)
	move.l	$124(a2),a0
	lea	2(a0),a1
	cmp.l	$150(a2),a1
	bhs	L170
L160
;		OPINIT()
;		*((uint16*)jvm->stack) = OP1_16(uint16);
	move.l	$110(a2),a0
	move.b	1(a0),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L162
L161
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra.b	L169
L162
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L164
L163
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L169
L164
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L166
L165
	and.l	#$FF,d0
	move.l	0(a3,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L169
L166
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L167
L168
L169
	move.w	(a0),d0
	move.l	$124(a2),a0
	move.w	d0,(a0)
;		jvm->stack += JASMINE::STACK_SIZE_X16;
	move.l	$124(a2),a0
	lea	2(a0),a0
	move.l	a0,$124(a2)
;		*jvm->stackTrace++ = JASMINE::STACK_TRACE_16;
	move.l	$140(a2),a1
	lea	1(a1),a0
	move.l	a0,$140(a2)
	move.b	#2,(a1)
;		OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	bra.b	L171
L170
;		jvm->exitReg = JASMINE::STACK_OVERFLOW;
	move.l	#4,$134(a2)
L171
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fPUSH_X32(OP_ARGS)
	XDEF	fPUSH_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fPUSH_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.l	d7,-(a7)
L172
;	if (jvm->stack+JASMINE::STACK_SIZE_X32 < jvm->stackTop)
	move.l	$124(a2),a0
	lea	4(a0),a1
	cmp.l	$150(a2),a1
	bhs	L183
L173
;		OPINIT()
;		*((uint32*)jvm->stack) = OP1_32(uint32);
	move.l	$110(a2),a0
	move.b	1(a0),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L175
L174
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L182
L175
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L177
L176
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L182
L177
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L179
L178
	and.l	#$FF,d0
	move.l	0(a3,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L182
L179
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L180
L181
L182
	move.l	(a0),d0
	move.l	$124(a2),a0
	move.l	d0,(a0)
;		jvm->stack += JASMINE::STACK_SIZE_X32;
	move.l	$124(a2),a0
	lea	4(a0),a0
	move.l	a0,$124(a2)
;		*jvm->stackTrace++ = JASMINE::STACK_TRACE_32;
	move.l	$140(a2),a1
	lea	1(a1),a0
	move.l	a0,$140(a2)
	move.b	#4,(a1)
;		OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	bra.b	L184
L183
;		jvm->exitReg = JASMINE::STACK_OVERFLOW;
	move.l	#4,$134(a2)
L184
	move.l	(a7)+,d7
	rts

;void JASMINE_OP::fPUSH_X64(OP_ARGS)
	XDEF	fPUSH_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fPUSH_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7,-(a7)
L185
;	if (jvm->stack+JASMINE::STACK_SIZE_X64 < jvm->stackTop)
	move.l	$124(a2),a0
	lea	$8(a0),a1
	cmp.l	$150(a2),a1
	bhs	L196
L186
;		OPINIT()
;		*((uint64*)jvm->stack) = OP1_64(uint64);
	move.l	$110(a2),a0
	move.b	1(a0),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L188
L187
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L195
L188
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L190
L189
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L195
L190
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L192
L191
	and.l	#$FF,d0
	move.l	0(a3,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L195
L192
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L198
	moveq	#-1,d0
L198
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L193
L194
L195
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	$124(a2),a0
	move.l	d0,(a0)
	move.l	d1,4(a0)
;		jvm->stack += JASMINE::STACK_SIZE_X64;
	move.l	$124(a2),a0
	lea	$8(a0),a0
	move.l	a0,$124(a2)
;		*jvm->stackTrace++ = JASMINE::STACK_TRACE_64;
	move.l	$140(a2),a1
	lea	1(a1),a0
	move.l	a0,$140(a2)
	move.b	#$8,(a1)
;		OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	bra.b	L197
L196
;		jvm->exitReg = JASMINE::STACK_OVERFLOW;
	move.l	#4,$134(a2)
L197
	movem.l	(a7)+,d2/d7
	rts

;void JASMINE_OP::fPOP_X8(OP_ARGS)
	XDEF	fPOP_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fPOP_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L199
;	if (jvm->stack+JASMINE::STACK_SIZE_X8 > jvm->stackBase)
	move.l	$124(a2),a0
	lea	2(a0),a1
	cmp.l	$14C(a2),a1
	bls.b	L204
L200
;		OPINIT()
	move.l	$110(a2),a3
;		jvm->stack -= JASMINE::STACK_SIZE_X8;
	moveq	#2,d0
	neg.l	d0
	move.l	$124(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a0,$124(a2)
;		OP1D_8(uint8) = *jvm->stack;
	move.l	$124(a2),a0
	move.b	(a0),d2
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L202
L201
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L203
L202
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L203
	move.b	d2,(a0)
;		--jvm->stackTrace;
	move.l	$140(a2),a0
	lea	-1(a0),a0
	move.l	a0,$140(a2)
;		OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	bra.b	L205
L204
;		jvm->exitReg = JASMINE::STACK_UNDERFLOW;
	move.l	#5,$134(a2)
L205
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fPOP_X16(OP_ARGS)
	XDEF	fPOP_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fPOP_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L206
;	if (jvm->stack+JASMINE::STACK_SIZE_X16 > jvm->stackBase)
	move.l	$124(a2),a0
	lea	2(a0),a1
	cmp.l	$14C(a2),a1
	bls	L211
L207
;		OPINIT()
	move.l	$110(a2),a3
;		jvm->stack -= JASMINE::STACK_SIZE_X16;
	moveq	#2,d0
	neg.l	d0
	move.l	$124(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a0,$124(a2)
;		OP1D_16(uint16) = *((uint16*)jvm->stack);
	move.l	$124(a2),a0
	move.w	(a0),d2
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L209
L208
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra.b	L210
L209
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L210
	move.w	d2,(a0)
;		--jvm->stackTrace;
	move.l	$140(a2),a0
	lea	-1(a0),a0
	move.l	a0,$140(a2)
;		OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	bra.b	L212
L211
;		jvm->exitReg = JASMINE::STACK_UNDERFLOW;
	move.l	#5,$134(a2)
L212
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fPOP_X32(OP_ARGS)
	XDEF	fPOP_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fPOP_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L213
;	if (jvm->stack+JASMINE::STACK_SIZE_X32 > jvm->stackBase)
	move.l	$124(a2),a0
	lea	4(a0),a1
	cmp.l	$14C(a2),a1
	bls	L218
L214
;		OPINIT()
	move.l	$110(a2),a3
;		jvm->stack -= JASMINE::STACK_SIZE_X32;
	moveq	#4,d0
	neg.l	d0
	move.l	$124(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a0,$124(a2)
;		OP1D_32(uint32) = *((uint32*)jvm->stack);
	move.l	$124(a2),a0
	move.l	(a0),d2
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L216
L215
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L217
L216
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L217
	move.l	d2,(a0)
;		--jvm->stackTrace;
	move.l	$140(a2),a0
	lea	-1(a0),a0
	move.l	a0,$140(a2)
;		OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	bra.b	L219
L218
;		jvm->exitReg = JASMINE::STACK_UNDERFLOW;
	move.l	#5,$134(a2)
L219
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fPOP_X64(OP_ARGS)
	XDEF	fPOP_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fPOP_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L220
;	if (jvm->stack+JASMINE::STACK_SIZE_X64 > jvm->stackBase)
	move.l	$124(a2),a0
	lea	$8(a0),a1
	cmp.l	$14C(a2),a1
	bls	L225
L221
;		OPINIT()
	move.l	$110(a2),a3
;		jvm->stack -= JASMINE::STACK_SIZE_X64;
	moveq	#$8,d0
	neg.l	d0
	move.l	$124(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a0,$124(a2)
;		OP1D_64(uint64) = *((uint64*)jvm->stack);
	move.l	$124(a2),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L223
L222
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L224
L223
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L224
	move.l	d2,(a0)
	move.l	d3,4(a0)
;		--jvm->stackTrace;
	move.l	$140(a2),a0
	lea	-1(a0),a0
	move.l	a0,$140(a2)
;		OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	bra.b	L226
L225
;		jvm->exitReg = JASMINE::STACK_UNDERFLOW;
	move.l	#5,$134(a2)
L226
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fSET_X8(OP_ARGS)
	XDEF	fSET_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSET_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L246	EQU	-$10
	link	a5,#L246
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,-$10(a5)
L227
;	OPINIT()
	move.l	$110(a2),a6
;		ruint8		v = OP1_8(uint8);
	move.b	1(a6),d2
	moveq	#0,d0
	move.b	d2,d0
	cmp.l	#$20,d0
	bge.b	L229
L228
	bra	L236
L229
	moveq	#0,d0
	move.b	d2,d0
	cmp.l	#$40,d0
	bge.b	L231
L230
	bra.b	L236
L231
	moveq	#0,d0
	move.b	d2,d0
	cmp.l	#$E0,d0
	bge.b	L233
L232
	moveq	#0,d0
	move.b	d2,d0
	move.l	-$10(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	bra.b	L236
L233
	moveq	#0,d0
	move.b	d2,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
L234
L235
L236
;		ruint8*		d	= POP2D_8(uint8);
	move.b	2(a6),d2
	moveq	#0,d0
	move.b	d2,d0
	cmp.l	#$20,d0
	bge.b	L238
L237
	moveq	#0,d0
	move.b	d2,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a3
	bra.b	L239
L238
	moveq	#0,d0
	move.b	d2,d0
	move.l	-$10(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a3
L239
;		rsint32		i	= OP3_32(sint32);
	move.b	3(a6),d2
	moveq	#0,d0
	move.b	d2,d0
	cmp.l	#$20,d0
	bge.b	L241
L240
	moveq	#0,d0
	move.b	d2,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L242
L241
	moveq	#0,d0
	move.b	d2,d0
	move.l	-$10(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L242
	move.l	(a0),d0
;		while (--i)
	bra.b	L244
L243
;			*d++ = v;
	move.b	d2,(a3)+
L244
	subq.l	#1,d0
	tst.l	d0
	bne.b	L243
L245
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	unlk	a5
	rts

;void JASMINE_OP::fSET_X16(OP_ARGS)
	XDEF	fSET_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSET_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L266	EQU	-$10
	link	a5,#L266
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,-$10(a5)
L247
;	OPINIT()
	move.l	$110(a2),a6
;		ruint16		v = OP1_16(uint16);
	moveq	#0,d2
	move.b	1(a6),d2
	moveq	#0,d0
	move.w	d2,d0
	cmp.l	#$20,d0
	bge.b	L249
L248
	bra	L256
L249
	moveq	#0,d0
	move.w	d2,d0
	cmp.l	#$40,d0
	bge.b	L251
L250
	bra	L256
L251
	moveq	#0,d0
	move.w	d2,d0
	cmp.l	#$E0,d0
	bge.b	L253
L252
	moveq	#0,d0
	move.w	d2,d0
	move.l	-$10(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	bra.b	L256
L253
	moveq	#0,d0
	move.w	d2,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
L254
L255
L256
;		ruint16*	d	= POP2D_16(uint16);
	moveq	#0,d2
	move.b	2(a6),d2
	moveq	#0,d0
	move.w	d2,d0
	cmp.l	#$20,d0
	bge	L258
L257
	moveq	#0,d0
	move.w	d2,d0
	lea	0(a2,d0.l*8),a0
	moveq	#6,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L259
L258
	moveq	#0,d0
	move.w	d2,d0
	move.l	-$10(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a3
L259
;		rsint32		i	= OP3_32(sint32);
	moveq	#0,d2
	move.b	3(a6),d2
	moveq	#0,d0
	move.w	d2,d0
	cmp.l	#$20,d0
	bge.b	L261
L260
	moveq	#0,d0
	move.w	d2,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L262
L261
	moveq	#0,d0
	move.w	d2,d0
	move.l	-$10(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L262
	move.l	(a0),d0
;		while (--i)
	bra.b	L264
L263
;			*d++ = v;
	move.w	d2,(a3)+
L264
	subq.l	#1,d0
	tst.l	d0
	bne.b	L263
L265
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	unlk	a5
	rts

;void JASMINE_OP::fSET_X32(OP_ARGS)
	XDEF	fSET_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSET_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L286	EQU	-$14
	link	a5,#L286
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L267
;	OPINIT()
	move.l	$110(a2),a6
;		ruint32		v = OP1_32(uint32);
	moveq	#0,d2
	move.b	1(a6),d2
	cmp.l	#$20,d2
	bhs.b	L269
L268
	bra	L276
L269
	cmp.l	#$40,d2
	bhs.b	L271
L270
	bra	L276
L271
	cmp.l	#$E0,d2
	bhs	L273
L272
	move.l	-$14(a5),a1
	move.l	0(a1,d2.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	bra	L276
L273
	sub.l	#$E0,d2
	lea	$100(a2),a0
	move.l	d2,4(a0)
L274
L275
L276
;		ruint32*	d	= POP2D_32(uint32);
	moveq	#0,d2
	move.b	2(a6),d2
	cmp.l	#$20,d2
	bhs	L278
L277
	lea	0(a2,d2.l*8),a0
	moveq	#4,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L279
L278
	move.l	-$14(a5),a1
	move.l	0(a1,d2.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a3
L279
;		rsint32		i	= OP3_32(sint32);
	moveq	#0,d2
	move.b	3(a6),d2
	cmp.l	#$20,d2
	bhs	L281
L280
	lea	0(a2,d2.l*8),a0
	addq.w	#4,a0
	bra	L282
L281
	move.l	-$14(a5),a1
	move.l	0(a1,d2.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L282
	move.l	(a0),d0
;		while (--i)
	bra	L284
L283
;			*d++ = v;
	move.l	d2,(a3)+
L284
	subq.l	#1,d0
	tst.l	d0
	bne.b	L283
L285
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	unlk	a5
	rts

;void JASMINE_OP::fSET_X64(OP_ARGS)
	XDEF	fSET_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSET_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L306	EQU	-$18
	link	a5,#L306
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,-$18(a5)
L287
;	OPINIT()
	move.l	$110(a2),a6
;		ruint64		v = OP1_64(uint64);
	moveq	#0,d4
	moveq	#0,d4
	move.b	1(a6),d5
	move.l	d4,d0
	move.l	d5,d1
	moveq	#0,d2
	moveq	#$20,d3
	cmp.l	d2,d0
	bhi	L289
	bne	L296
	cmp.l	d3,d1
	bhs	L289
L288
	bra	L296
L289
	move.l	d4,d0
	move.l	d5,d1
	moveq	#0,d2
	moveq	#$40,d3
	cmp.l	d2,d0
	bhi	L291
	bne	L296
	cmp.l	d3,d1
	bhs	L291
L290
	bra	L296
L291
	move.l	d4,d0
	move.l	d5,d1
	moveq	#0,d2
	move.l	#$E0,d3
	cmp.l	d2,d0
	bhi	L293
	bne	L292
	cmp.l	d3,d1
	bhs	L293
L292
	move.l	d5,d0
	move.l	-$18(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	bra	L296
L293
	move.l	d4,d0
	move.l	d5,d1
	moveq	#0,d2
	move.l	#$E0,d3
	XREF	Sub64
	jsr	Sub64
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
L294
L295
L296
;		ruint64*	d	= POP2D_64(uint64);
	moveq	#0,d4
	moveq	#0,d4
	move.b	2(a6),d5
	move.l	d4,d0
	move.l	d5,d1
	moveq	#0,d2
	moveq	#$20,d3
	cmp.l	d2,d0
	bhi	L298
	bne	L297
	cmp.l	d3,d1
	bhs	L298
L297
	move.l	d5,d0
	asl.l	#3,d0
	add.l	a2,d0
	move.l	d0,a3
	bra	L299
L298
	move.l	d5,d0
	move.l	-$18(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a3
L299
;		rsint32		i	= OP3_32(sint32);
	moveq	#0,d4
	moveq	#0,d4
	move.b	3(a6),d5
	move.l	d4,d0
	move.l	d5,d1
	moveq	#0,d2
	moveq	#$20,d3
	cmp.l	d2,d0
	bhi	L301
	bne	L300
	cmp.l	d3,d1
	bhs	L301
L300
	move.l	d5,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L302
L301
	move.l	d5,d0
	move.l	-$18(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L302
	move.l	(a0),d0
;		while (--i)
	bra	L304
L303
;			*d++ = v;
	move.l	d4,(a3)+
	move.l	d5,(a3)+
L304
	subq.l	#1,d0
	tst.l	d0
	bne.b	L303
L305
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	unlk	a5
	rts

;void JASMINE_OP::fMOVE_X8(OP_ARGS)
	XDEF	fMOVE_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOVE_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L326	EQU	-$18
	link	a5,#L326
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L307
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint8*		s = POP1_8(uint8);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L309
L308
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L316
L309
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L311
L310
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a3
	bra	L316
L311
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L313
L312
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a3
	bra	L316
L313
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a3
L314
L315
L316
;		ruint8*		d	= POP2D_8(uint8);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L318
L317
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a6
	bra	L319
L318
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a6
L319
;		rsint32		i	= OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L321
L320
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L322
L321
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L322
	move.l	(a0),d0
;		while (--i)
	bra	L324
L323
;			*d++ = *s++;
	move.b	(a3)+,(a6)+
L324
	subq.l	#1,d0
	tst.l	d0
	bne.b	L323
L325
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	unlk	a5
	rts

;void JASMINE_OP::fMOVE_X16(OP_ARGS)
	XDEF	fMOVE_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOVE_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L346	EQU	-$18
	link	a5,#L346
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L327
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint16*	s = POP1_16(uint16);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L329
L328
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#6,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L336
L329
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L331
L330
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a3
	bra	L336
L331
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L333
L332
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a3
	bra	L336
L333
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	moveq	#6,d0
	add.l	a0,d0
	move.l	d0,a3
L334
L335
L336
;		ruint16*	d	= POP2D_16(uint16);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L338
L337
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#6,d0
	add.l	a0,d0
	move.l	d0,a6
	bra	L339
L338
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a6
L339
;		rsint32		i	= OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L341
L340
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L342
L341
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L342
	move.l	(a0),d0
;		while (--i)
	bra	L344
L343
;			*d++ = *s++;
	move.w	(a3)+,(a6)+
L344
	subq.l	#1,d0
	tst.l	d0
	bne.b	L343
L345
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	unlk	a5
	rts

;void JASMINE_OP::fMOVE_X32(OP_ARGS)
	XDEF	fMOVE_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOVE_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L366	EQU	-$18
	link	a5,#L366
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L347
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint32*	s = POP1_32(uint32);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L349
L348
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#4,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L356
L349
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L351
L350
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a3
	bra	L356
L351
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L353
L352
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a3
	bra	L356
L353
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	moveq	#4,d0
	add.l	a0,d0
	move.l	d0,a3
L354
L355
L356
;		ruint32*	d	= POP2D_32(uint32);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L358
L357
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#4,d0
	add.l	a0,d0
	move.l	d0,a6
	bra	L359
L358
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a6
L359
;		rsint32		i	= OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L361
L360
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L362
L361
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L362
	move.l	(a0),d0
;		while (--i)
	bra	L364
L363
;			*d++ = *s++;
	move.l	(a3)+,(a6)+
L364
	subq.l	#1,d0
	tst.l	d0
	bne.b	L363
L365
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	unlk	a5
	rts

;void JASMINE_OP::fMOVE_X64(OP_ARGS)
	XDEF	fMOVE_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOVE_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L386	EQU	-$18
	link	a5,#L386
	movem.l	d2-d4/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L367
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint64*	s = POP1_64(uint64);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L369
L368
	and.l	#$FF,d0
	asl.l	#3,d0
	add.l	a2,d0
	move.l	d0,a3
	bra	L376
L369
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L371
L370
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a3
	bra	L376
L371
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L373
L372
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a3
	bra	L376
L373
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L387
	moveq	#-1,d0
L387
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	move.l	#$100,d0
	add.l	a2,d0
	move.l	d0,a3
L374
L375
L376
;		ruint64*	d	= POP2D_64(uint64);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L378
L377
	and.l	#$FF,d0
	asl.l	#3,d0
	add.l	a2,d0
	move.l	d0,a6
	bra	L379
L378
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a6
L379
;		rsint32		i	= OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L381
L380
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L382
L381
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L382
	move.l	(a0),d0
;		while (--i)
	bra	L384
L383
;			*d++ = *s++;
	move.l	(a3)+,d1
	move.l	(a3)+,d2
	move.l	d1,(a6)+
	move.l	d2,(a6)+
L384
	subq.l	#1,d0
	tst.l	d0
	bne.b	L383
L385
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d4/d7/a3/a6
	unlk	a5
	rts

;void	JASMINE_OP::fEMOV_X16(OP_ARGS)
	XDEF	fEMOV_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fEMOV_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L407	EQU	-$18
	link	a5,#L407
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L388
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint8* s = POP1_8(uint8);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L390
L389
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a6
	bra	L397
L390
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L392
L391
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a6
	bra	L397
L392
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L394
L393
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a6
	bra	L397
L394
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a6
L395
L396
L397
;		ruint8* d = POP2D_8(uint8);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L399
L398
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L400
L399
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a3
L400
;		rsint32	i = OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L402
L401
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L403
L402
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L403
	move.l	(a0),d0
;		while (--i)
	bra	L405
L404
;			*d++ = s[1];
	move.b	1(a6),(a3)+
;	*d++ = s[0];
	move.l	a6,a0
	move.b	(a0),d1
	move.b	d1,(a3)+
;			s+=sizeof(uint16);
	moveq	#2,d1
	add.l	a6,d1
	move.l	d1,a6
L405
	subq.l	#1,d0
	tst.l	d0
	bne.b	L404
L406
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	unlk	a5
	rts

;void	JASMINE_OP::fEMOV_X32(OP_ARGS)
	XDEF	fEMOV_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fEMOV_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L427	EQU	-$18
	link	a5,#L427
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L408
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint8* s = POP1_8(uint8);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L410
L409
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a6
	bra	L417
L410
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L412
L411
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a6
	bra	L417
L412
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L414
L413
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a6
	bra	L417
L414
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a6
L415
L416
L417
;		ruint8* d = POP2D_8(uint8);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L419
L418
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L420
L419
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a3
L420
;		rsint32	i = OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L422
L421
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L423
L422
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L423
	move.l	(a0),d0
;		while (--i)
	bra	L425
L424
;			*d++ = s[3];
	move.b	3(a6),(a3)+
;	*d++ = s[2];
	move.b	2(a6),(a3)+
;	*d++ = s[1];
	move.b	1(a6),(a3)+
;	*d++ = s[0];
	move.l	a6,a0
	move.b	(a0),d1
	move.b	d1,(a3)+
;			s+=sizeof(uint32);
	moveq	#4,d1
	add.l	a6,d1
	move.l	d1,a6
L425
	subq.l	#1,d0
	tst.l	d0
	bne.b	L424
L426
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	unlk	a5
	rts

;void	JASMINE_OP::fEMOV_X64(OP_ARGS)
	XDEF	fEMOV_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fEMOV_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L447	EQU	-$18
	link	a5,#L447
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L428
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint8* s = POP1_8(uint8);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L430
L429
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a6
	bra	L437
L430
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L432
L431
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a6
	bra	L437
L432
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L434
L433
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a6
	bra	L437
L434
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a6
L435
L436
L437
;		ruint8* d = POP2D_8(uint8);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L439
L438
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L440
L439
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a3
L440
;		rsint32	i = OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L442
L441
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L443
L442
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L443
	move.l	(a0),d0
;		while (--i)
	bra	L445
L444
;			*d++ = s[7];
	move.b	7(a6),(a3)+
;	*d++ = s[6];
	move.b	6(a6),(a3)+
;	*d++ = s[5];
	move.b	5(a6),(a3)+
;	*d++ = s[4];
	move.b	4(a6),(a3)+
;			*d++ = s[3];
	move.b	3(a6),(a3)+
;	*d++ = s[2];
	move.b	2(a6),(a3)+
;	*d++ = s[1];
	move.b	1(a6),(a3)+
;	*d++ = s[0];
	move.l	a6,a0
	move.b	(a0),d1
	move.b	d1,(a3)+
;			s+=sizeof(uint64);
	moveq	#$8,d1
	add.l	a6,d1
	move.l	d1,a6
L445
	subq.l	#1,d0
	tst.l	d0
	bne.b	L444
L446
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	unlk	a5
	rts

;void	JASMINE_OP::fSWAP_X8(OP_ARGS)
	XDEF	fSWAP_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSWAP_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L461	EQU	-$18
	link	a5,#L461
	movem.l	d2-d4/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L448
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint8*	pa = POP1D_8(uint8);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L450
L449
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a6
	bra	L451
L450
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a6
L451
;		ruint8*	pb = POP2D_8(uint8);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L453
L452
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#7,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L454
L453
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a3
L454
;		rsint32	i  = OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L456
L455
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L457
L456
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L457
	move.l	(a0),d0
;		while (--i)
	bra	L459
L458
;			ruint8 t = *pb;
	move.l	a3,a0
	move.b	(a0),d2
;			*pb++ = *pa;
	move.l	a6,a0
	move.b	(a0),d1
	move.b	d1,(a3)+
;			*pa++ = t;
	move.b	d2,(a6)+
L459
	subq.l	#1,d0
	tst.l	d0
	bne.b	L458
L460
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d4/d7/a3/a6
	unlk	a5
	rts

;void	JASMINE_OP::fSWAP_X16(OP_ARGS)
	XDEF	fSWAP_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSWAP_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L475	EQU	-$18
	link	a5,#L475
	movem.l	d2-d4/d7/a3/a6,-(a7)
	move.l	a3,-$14(a5)
L462
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint16* pa = POP1D_16(uint16);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L464
L463
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#6,d0
	add.l	a0,d0
	move.l	d0,a6
	bra	L465
L464
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a6
L465
;		ruint16* pb = POP2D_16(uint16);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L467
L466
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#6,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L468
L467
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a3
L468
;		rsint32	i  = OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L470
L469
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L471
L470
	and.l	#$FF,d0
	move.l	-$14(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L471
	move.l	(a0),d0
;		while (--i)
	bra	L473
L472
;			ruint16 t = *pb;
	move.l	a3,a0
	move.w	(a0),d2
;			*pb++ = *pa;
	move.l	a6,a0
	move.w	(a0),d1
	move.w	d1,(a3)+
;			*pa++ = t;
	move.w	d2,(a6)+
L473
	subq.l	#1,d0
	tst.l	d0
	bne.b	L472
L474
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d4/d7/a3/a6
	unlk	a5
	rts

;void	JASMINE_OP::fSWAP_X32(OP_ARGS)
	XDEF	fSWAP_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSWAP_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L489	EQU	-$1C
	link	a5,#L489
	movem.l	d2-d4/d7/a3/a6,-(a7)
	move.l	a3,-$18(a5)
L476
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint32* pa = POP1D_32(uint32);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L478
L477
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#4,d0
	add.l	a0,d0
	move.l	d0,a6
	bra	L479
L478
	and.l	#$FF,d0
	move.l	-$18(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a6
L479
;		ruint32* pb = POP2D_32(uint32);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L481
L480
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	moveq	#4,d0
	add.l	a0,d0
	move.l	d0,a3
	bra	L482
L481
	and.l	#$FF,d0
	move.l	-$18(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a3
L482
;		rsint32	i  = OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L484
L483
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L485
L484
	and.l	#$FF,d0
	move.l	-$18(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L485
	move.l	(a0),d0
;		while (--i)
	bra	L487
L486
;			ruint32 t = *pb;
	move.l	a3,a0
	move.l	(a0),d2
;			*pb++ = *pa;
	move.l	a6,a0
	move.l	(a0),d1
	move.l	d1,(a3)+
;			*pa++ = t;
	move.l	d2,(a6)+
L487
	subq.l	#1,d0
	tst.l	d0
	bne.b	L486
L488
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d4/d7/a3/a6
	unlk	a5
	rts

;void	JASMINE_OP::fSWAP_X64(OP_ARGS)
	XDEF	fSWAP_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSWAP_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L503	EQU	-$20
	link	a5,#L503
	movem.l	d2-d7/a3/a6,-(a7)
	move.l	a3,-$1C(a5)
L490
;	OPINIT()
	move.l	$110(a2),-4(a5)
;		ruint64* pa = POP1D_64(uint64);
	move.l	-4(a5),a1
	move.b	1(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L492
L491
	and.l	#$FF,d0
	asl.l	#3,d0
	add.l	a2,d0
	move.l	d0,a6
	bra	L493
L492
	and.l	#$FF,d0
	move.l	-$1C(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a6
L493
;		ruint64* pb = POP2D_64(uint64);
	move.l	-4(a5),a1
	move.b	2(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L495
L494
	and.l	#$FF,d0
	asl.l	#3,d0
	add.l	a2,d0
	move.l	d0,a3
	bra	L496
L495
	and.l	#$FF,d0
	move.l	-$1C(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a3
L496
;		rsint32	i  = OP3_32(sint32);
	move.l	-4(a5),a1
	move.b	3(a1),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L498
L497
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L499
L498
	and.l	#$FF,d0
	move.l	-$1C(a5),a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L499
	move.l	(a0),d0
;		while (--i)
	bra	L501
L500
;			ruint64 t = *pb;
	move.l	a3,a0
	move.l	(a0),d3
	move.l	4(a0),d4
;			*pb++ = *pa;
	move.l	a6,a0
	move.l	(a0),d1
	move.l	4(a0),d2
	move.l	d1,(a3)+
	move.l	d2,(a3)+
;			*pa++ = t;
	move.l	d3,(a6)+
	move.l	d4,(a6)+
L501
	subq.l	#1,d0
	tst.l	d0
	bne.b	L500
L502
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d7/a3/a6
	unlk	a5
	rts

	END
