
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineClass.cpp
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
	XREF	Execute__JASMINE__P07JASMINE
	XREF	fSYS_DUMP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
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
	XREF	_TimerBase__MILLICLOCK
	XREF	_current__MILLICLOCK
	XREF	_clockFreq__MILLICLOCK
	XREF	_threadCnt__THREAD
	XREF	_threadsIdle__THREAD
	XREF	_rootThread__THREAD
	XREF	_eaTable__JASMINE_EA
	XREF	_instTable__JASMINE_OP
	XREF	_sysTable__JASMINE_OP
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


;void* JASMINE_EA::IllegalAddress(EA_ARGS)
	XDEF	IllegalAddress__JASMINE_EA__r10P07JASMINEr7Ui
IllegalAddress__JASMINE_EA__r10P07JASMINEr7Ui
	move.l	a3,-(a7)
L148
;	printf("\n\nIllegal Address : inst %p\n", (void*)(jvm->instPtr));
	move.l	$110(a2),-(a7)
	move.l	#L147,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;	JASMINE_OP::fSYS_DUMP(jvm, eaTable);
	move.l	#_eaTable__JASMINE_EA,a3
	jsr	fSYS_DUMP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	jvm->exitReg = JASMINE::ILLEGAL_EATYPE;
	move.l	#$B,$134(a2)
;	return jvm->imReg[0].Data64();
	move.l	#$100,d0
	add.l	a2,d0
	move.l	(a7)+,a3
	rts

;void JASMINE_OP::IllegalOpcode(OP_ARGS)
	XDEF	IllegalOpcode__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
IllegalOpcode__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L150
;	printf("\n\nIllegal Opcode : 0x%8X\n", *(jvm->instPtr));
	move.l	$110(a2),a0
	move.l	(a0),-(a7)
	move.l	#L149,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;	JASMINE_OP::fSYS_DUMP(jvm, pf);
	jsr	fSYS_DUMP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	jvm->exitReg = JASMINE::ILLEGAL_OPCODE;
	move.l	#$A,$134(a2)
	rts

;JASMINE::JASMINE() 
	XDEF	_0ct__JASMINE__T
_0ct__JASMINE__T
	move.l	4(a7),a0
L151
	clr.l	$110(a0)
	clr.l	$12C(a0)
	clr.l	$130(a0)
	clr.l	$134(a0)
	clr.l	$138(a0)
	clr.l	$144(a0)
	clr.l	$14C(a0)
	clr.l	$154(a0)
;	for(sint32 i=0;
	moveq	#0,d0
	bra.b	L153
L152
;		gpRegs[i].ValU64() = 0;
	clr.l	0(a0,d0.l*8)
	clr.l	4(a0,d0.l*8)
	addq.l	#1,d0
L153
	cmp.l	#$20,d0
	blt.b	L152
L154
;	imReg[0].ValU64() = 0;
	clr.l	$100(a0)
	clr.l	$104(a0)
;	imReg[1].ValU64() = 0;
	lea	$100(a0),a0
	clr.l	$8(a0)
	clr.l	$C(a0)
;	if (!illegalDone)
	tst.l	_illegalDone__JASMINE
	bne.b	L164
L155
;		illegalDone = 1;
	move.l	#1,_illegalDone__JASMINE
;		for (i = VM::NUM_EA;
	move.l	#$8B,d0
	bra.b	L157
L156
;			JASMINE_EA::eaTable[i] = &JASMINE_EA::IllegalAddre
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	#IllegalAddress__JASMINE_EA__r10P07JASMINEr7Ui,0(a1,d0.l*4)
	addq.l	#1,d0
L157
	cmp.l	#$100,d0
	blt.b	L156
L158
;		for (i = VM::NUM_OPS;
	move.l	#$DC,d0
	bra.b	L160
L159
;			JASMINE_OP::instTable[i] = &JASMINE_OP::IllegalOpc
	move.l	#_instTable__JASMINE_OP,a1
	move.l	#IllegalOpcode__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip,0(a1,d0.l*4)
	addq.l	#1,d0
L160
	cmp.l	#$100,d0
	blt.b	L159
L161
;		for (i = VM::NUM_SYS;
	moveq	#$29,d0
	bra.b	L163
L162
;			JASMINE_OP::sysTable[i] = &JASMINE_OP::IllegalOpco
	move.l	#_sysTable__JASMINE_OP,a1
	move.l	#IllegalOpcode__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip,0(a1,d0.l*4)
	addq.l	#1,d0
L163
	cmp.l	#$100,d0
	blt.b	L162
L164
	rts

;JASMINE::~JASMINE()
	XDEF	_0dt__JASMINE__T
_0dt__JASMINE__T
	move.l	4(a7),a0
L165
;	Free();
	move.l	a0,-(a7)
	jsr	Free__JASMINE__T
	addq.w	#4,a7
	rts

;sint32	JASMINE::Alloc(size_t stackSize, size_t methStackSize, size_t
	XDEF	Alloc__JASMINE__TUiUiUi
Alloc__JASMINE__TUiUiUi
	movem.l	d2-d4/a2,-(a7)
	move.l	$20(a7),d2
	move.l	$18(a7),d3
	move.l	$1C(a7),d4
	move.l	$14(a7),a2
L166
;	Free();
	move.l	a2,-(a7)
	jsr	Free__JASMINE__T
	addq.w	#4,a7
;	if (methStackSize)
	tst.l	d4
	beq.b	L170
L167
;		if (!(methodStackBase = new uint32*[methStackSize]))
	move.l	d4,d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	d0,$144(a2)
	bne.b	L169
L168
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L169
;		methodStackTop	= methodStackBase + methStackSize-1;
	move.l	$144(a2),a0
	lea	0(a0,d4.l*4),a0
	lea	-4(a0),a0
	move.l	a0,$148(a2)
	bra.b	L171
L170
;		methodStack = methodStackBase = methodStackTop = 0;
	clr.l	$148(a2)
	clr.l	$144(a2)
	clr.l	$128(a2)
L171
;	if (stackSize)
	tst.l	d3
	beq.b	L175
L172
;		if (!(stackBase = new uint8[(stackSize<<1)]))
	move.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	d0,$14C(a2)
	bne.b	L174
L173
;			Free();
	move.l	a2,-(a7)
	jsr	Free__JASMINE__T
	addq.w	#4,a7
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L174
;		stackTrace = stackBase + stackSize;
	move.l	$14C(a2),a0
	lea	0(a0,d3.l),a0
	move.l	a0,$140(a2)
;		stackTop	= stackTrace-1;
	move.l	$140(a2),a0
	lea	-1(a0),a0
	move.l	a0,$150(a2)
	bra.b	L176
L175
;		stack = stackBase = stackTop = 0;
	clr.l	$150(a2)
	clr.l	$14C(a2)
	clr.l	$124(a2)
L176
;	if (regStackSize)
	tst.l	d2
	beq.b	L180
L177
;		if (!(regStackBase = new uint64[regStackSize]))
	move.l	d2,d0
	moveq	#3,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	d0,$154(a2)
	bne.b	L179
L178
;			Free();
	move.l	a2,-(a7)
	jsr	Free__JASMINE__T
	addq.w	#4,a7
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L179
;		regStackTop = regStackBase+regStackSize-1;
	move.l	$154(a2),a0
	lea	0(a0,d2.l*8),a0
	lea	-$8(a0),a0
	move.l	a0,$158(a2)
	bra.b	L181
L180
;		regStack = regStackBase = regStackTop = 0;
	clr.l	$158(a2)
	clr.l	$154(a2)
	clr.l	$120(a2)
L181
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2
	rts

;void JASMINE::Free()
	XDEF	Free__JASMINE__T
Free__JASMINE__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L182
;	if (methodStack)
	tst.l	$128(a2)
	beq.b	L185
L183
;		delete[] methodStackBase;
	move.l	$144(a2),a0
	cmp.w	#0,a0
	beq.b	L185
L184
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L185
;	if (stackBase)
	tst.l	$14C(a2)
	beq.b	L188
L186
;		delete[] stackBase;
	move.l	$14C(a2),a0
	cmp.w	#0,a0
	beq.b	L188
L187
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L188
;	if (regStackBase)
	tst.l	$154(a2)
	beq.b	L191
L189
;		delete[] regStackBase;
	move.l	$154(a2),a0
	cmp.w	#0,a0
	beq.b	L191
L190
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L191
;	vmObject = 0;
	clr.l	$15C(a2)
;	methodStack = methodStackBase = methodStackTop = 0;
	clr.l	$148(a2)
	clr.l	$144(a2)
	clr.l	$128(a2)
;	stackTrace = stack = stackBase = stackTop = 0;
	clr.l	$150(a2)
	clr.l	$14C(a2)
	clr.l	$124(a2)
	clr.l	$140(a2)
;	regStack = regStackBase = regStackTop = 0;
	clr.l	$158(a2)
	clr.l	$154(a2)
	clr.l	$120(a2)
	move.l	(a7)+,a2
	rts

;uint32 JASMINE::Execute(JASMINEOBJECT& prog)
	XDEF	Execute__JASMINE__TR13JASMINEOBJECT
Execute__JASMINE__TR13JASMINEOBJECT
	movem.l	a2/a3,-(a7)
	movem.l	$C(a7),a2/a3
L194
;	if (Alloc(prog.Stack(), prog.MethodStack(), prog.RegisterStack())!
	move.l	$50(a3),-(a7)
	move.l	$4C(a3),-(a7)
	move.l	$48(a3),-(a7)
	move.l	a2,-(a7)
	jsr	Alloc__JASMINE__TUiUiUi
	add.w	#$10,a7
	tst.l	d0
	beq.b	L196
L195
;		puts("VM Program initialization failed (not enough memory)");
	move.l	#L192,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3
	rts
L196
;	vmObject			= &prog;
	move.l	a3,$15C(a2)
;	instPtr				= prog.Code();
	move.l	$80(a3),$110(a2)
;	dataSectPtr		= prog.Data();
	move.l	$84(a3),$12C(a2)
;	constSectPtr	= prog.Cnst();
	move.l	$88(a3),$130(a2)
;	methodStack		= methodStackBase;
	move.l	$144(a2),a0
	move.l	a0,$128(a2)
;	stack					= stackBase;
	move.l	$14C(a2),a0
	move.l	a0,$124(a2)
;	regStack			= regStackBase;
	move.l	$154(a2),a0
	move.l	a0,$120(a2)
;	exitReg				= 0;
	clr.l	$134(a2)
;	countReg			= 0;
	clr.l	$138(a2)
;	Execute(this);
	move.l	a2,-(a7)
	jsr	Execute__JASMINE__P07JASMINE
	addq.w	#4,a7
;	if (exitReg!=END_OF_CODE)
	move.l	$134(a2),d0
	cmp.l	#1,d0
	beq.b	L198
L197
;		printf("\nError in VM program : %s [%d]\n", ExitResult(), (sint3
	move.l	$134(a2),-(a7)
	move.l	$134(a2),d0
	move.l	#_resultString__JASMINE,a1
	move.l	0(a1,d0.l*4),-(a7)
	move.l	#L193,-(a7)
	jsr	_printf
	add.w	#$C,a7
L198
;	return exitReg;
	move.l	$134(a2),d0
	movem.l	(a7)+,a2/a3
	rts

;sint32 JASMINE::GetPC()
	XDEF	GetPC__JASMINE__T
GetPC__JASMINE__T
	move.l	4(a7),a0
L199
;	if (vmObject && vmObject->Code()!=0)
	tst.l	$15C(a0)
	beq.b	L202
L200
	move.l	$15C(a0),a1
	move.l	$80(a1),a1
	cmp.w	#0,a1
	beq.b	L202
L201
;		return (sint32)(instPtr - vmObject->Code());
	move.l	$110(a0),a1
	move.l	$15C(a0),a0
	move.l	a1,d0
	sub.l	$80(a0),d0
	moveq	#2,d1
	asr.l	d1,d0
	rts
L202
;	return -1;
	moveq	#-1,d0
	rts

;sint32	JASMINE::PushRegs(JCLASSP, VLDREG1 sint32 first, VLDREG2 sint
	XDEF	PushRegs__JASMINE__r10P07JASMINEr0jr1j
PushRegs__JASMINE__r10P07JASMINEr0jr1j
	movem.l	d2/a3,-(a7)
L203
;	if (num>=0)
	tst.l	d1
	bmi.b	L210
L204
;		num++;
	addq.l	#1,d1
;		if (This->regStack+num < This->regStackTop)
	move.l	$120(a2),a0
	lea	0(a0,d1.l*8),a1
	cmp.l	$158(a2),a1
	bhs.b	L209
L205
;			ruint32* rp = (uint32*)(&This->gpRegs[first]);
	lea	0(a2,d0.l*8),a0
;			while(num--)
	bra.b	L207
L206
;				*(((uint32*)This->regStack)++) = *rp++;
	move.l	(a0)+,d0
	move.l	$120(a2),a3
	lea	4(a3),a1
	move.l	a1,$120(a2)
	move.l	d0,(a3)
;				*(((uint32*)This->regStack)++) = *rp++;
	move.l	(a0)+,d0
	move.l	$120(a2),a3
	lea	4(a3),a1
	move.l	a1,$120(a2)
	move.l	d0,(a3)
L207
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L206
L208
;			return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a3
	rts
L209
;			return REGS_OVERFLOW;
	moveq	#$8,d0
	movem.l	(a7)+,d2/a3
	rts
L210
;		num = 1-num;
	moveq	#1,d2
	sub.l	d1,d2
	move.l	d2,d1
;		if (This->regStack+num < This->regStackTop)
	move.l	$120(a2),a0
	lea	0(a0,d1.l*8),a1
	cmp.l	$158(a2),a1
	bhs.b	L215
L211
;			ruint32* rp = (uint32*)(&This->gpRegs[first]);
	lea	0(a2,d0.l*8),a0
;			while(num--)
	bra.b	L213
L212
;				*(((uint32*)This->regStack)++) = rp[0];
	move.l	(a0),d0
	move.l	$120(a2),a3
	lea	4(a3),a1
	move.l	a1,$120(a2)
	move.l	d0,(a3)
;				*(((uint32*)This->regStack)++) = rp[1];
	move.l	4(a0),d0
	move.l	$120(a2),a3
	lea	4(a3),a1
	move.l	a1,$120(a2)
	move.l	d0,(a3)
;				rp-=2;
	moveq	#$8,d0
	neg.l	d0
	add.l	d0,a0
L213
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L212
L214
;			return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a3
	rts
L215
;			return REGS_OVERFLOW;
	moveq	#$8,d0
	movem.l	(a7)+,d2/a3
	rts

;sint32	JASMINE::PopRegs(JCLASSP, VLDREG1 sint32 first, VLDREG2 sint3
	XDEF	PopRegs__JASMINE__r10P07JASMINEr0jr1j
PopRegs__JASMINE__r10P07JASMINEr0jr1j
	move.l	d2,-(a7)
L216
;	if (num>=0)
	tst.l	d1
	bmi.b	L223
L217
;		num++;
	addq.l	#1,d1
;		if (This->regStack-num >= This->regStackBase)
	move.l	d1,d2
	muls.l	#-$8,d2
	move.l	$120(a2),a0
	lea	0(a0,d2.l),a1
	cmp.l	$154(a2),a1
	blo.b	L222
L218
;			ruint32* rp = (uint32*)(&This->gpRegs[first+num]);
	add.l	d1,d0
	lea	0(a2,d0.l*8),a0
;			while(num--)
	bra.b	L220
L219
;				*(--rp) = *(--((uint32*)This->regStack));
	move.l	$120(a2),a1
	subq.w	#4,a1
	move.l	a1,$120(a2)
	move.l	(a1),-(a0)
;				*(--rp) = *(--((uint32*)This->regStack));
	move.l	$120(a2),a1
	subq.w	#4,a1
	move.l	a1,$120(a2)
	move.l	(a1),-(a0)
L220
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L219
L221
;			return 0;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L222
;			return REGS_UNDERFLOW;
	moveq	#$9,d0
	move.l	(a7)+,d2
	rts
L223
;		first += num;
	add.l	d1,d0
;		num = 1-num;
	moveq	#1,d2
	sub.l	d1,d2
	move.l	d2,d1
;		if (This->regStack-num >= This->regStackBase)
	move.l	d1,d2
	muls.l	#-$8,d2
	move.l	$120(a2),a0
	lea	0(a0,d2.l),a1
	cmp.l	$154(a2),a1
	blo.b	L228
L224
;			ruint32* rp = (uint32*)(&This->gpRegs[first]);
	lea	0(a2,d0.l*8),a0
;			while(num--)
	bra.b	L226
L225
;				--This->regStack;
	move.l	$120(a2),a1
	lea	-$8(a1),a1
	move.l	a1,$120(a2)
;				*rp++ = ((uint32*)This->regStack)[0];
	move.l	$120(a2),a1
	move.l	(a1),d0
	move.l	d0,(a0)+
;				*rp++ = ((uint32*)This->regStack)[1];
	move.l	$120(a2),a1
	move.l	4(a1),d0
	move.l	d0,(a0)+
L226
	move.l	d1,d0
	subq.l	#1,d1
	tst.l	d0
	bne.b	L225
L227
;			return 0;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L228
;			return REGS_UNDERFLOW;
	moveq	#$9,d0
	move.l	(a7)+,d2
	rts

;void JASMINE::GenInclude()
	XDEF	GenInclude__JASMINE_
GenInclude__JASMINE_
L229
	rts

L147
	dc.b	$A,$A,'Illegal Address : inst %p',$A,0
L149
	dc.b	$A,$A,'Illegal Opcode : 0x%8X',$A,0
L193
	dc.b	$A,'Error in VM program : %s [%d]',$A,0
L192
	dc.b	'VM Program initialization failed (not enough memory)',0

	SECTION ":1",DATA

	XDEF	_illegalDone__JASMINE
_illegalDone__JASMINE
	dc.l	0

	END
