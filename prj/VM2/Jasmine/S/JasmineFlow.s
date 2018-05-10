
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineFlow.cpp
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


;void JASMINE_OP::fNOP(OP_ARGS)
	XDEF	fNOP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fNOP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L211
;	jvm->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	rts

;void JASMINE_OP::fEND(OP_ARGS)
	XDEF	fEND__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fEND__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L212
;	jvm->exitReg = JASMINE::END_OF_CODE;
	move.l	#1,$134(a2)
	rts

;void JASMINE_OP::fLEA(OP_ARGS)
	XDEF	fLEA__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fLEA__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a2/a3,-(a7)
	move.l	a2,a3
L213
;	JASMINE_EA::D2(jvm,1,8);
	moveq	#$8,d2
	moveq	#1,d7
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L215
L214
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L220
L215
	cmp.l	#4,d7
	beq.b	L218
	bhi.b	L221
	cmp.l	#1,d7
	beq.b	L216
	cmp.l	#2,d7
	beq.b	L217
	bra	L220
L221
	cmp.l	#$8,d7
	beq.b	L219
	bra.b	L220
L216
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	7(a0),a1
	move.l	a1,$114(a2)
	bra.b	L220
L217
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	6(a0),a1
	move.l	a1,$114(a2)
	bra.b	L220
L218
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
	bra.b	L220
L219
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L220
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	move.l	d2,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	jvm->op[1].reg->PtrU8() = jvm->op[0].u8;
	lea	$114(a3),a0
	move.l	4(a0),a0
	move.l	$114(a3),4(a0)
	movem.l	(a7)+,d2/d3/d7/a2/a3
	rts

;void JASMINE_OP::fBRA(OP_ARGS)
	XDEF	fBRA__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBRA__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	a2/a3/a6,-(a7)
	move.l	a2,a3
L222
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq.b	L224
L223
	moveq	#1,d0
	bra.b	L225
L224
	moveq	#0,d0
L225
	tst.w	d0
	beq.b	L227
L226
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,a2/a3/a6
	rts
L227
;	jvm->instPtr += *((sint32*)++jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	addq.w	#4,a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	movem.l	(a7)+,a2/a3/a6
	rts

;void JASMINE_OP::fBNEQ_I8(OP_ARGS)
	XDEF	fBNEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBNEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L228
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq.b	L230
L229
	moveq	#1,d0
	bra.b	L231
L230
	moveq	#0,d0
L231
	tst.w	d0
	beq.b	L233
L232
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L233
;	JASMINE_EA::D2C_X8(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L235
L234
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra.b	L236
L235
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	7(a0),a1
	move.l	a1,$114(a2)
L236
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L238
L237
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra.b	L239
L238
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	7(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L239
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s8!=*jvm->op[1].s8)
	move.l	$114(a3),a0
	move.b	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.b	(a0),d1
	beq.b	L241
L240
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra.b	L242
L241
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L242
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBNEQ_I16(OP_ARGS)
	XDEF	fBNEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBNEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L243
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq.b	L245
L244
	moveq	#1,d0
	bra.b	L246
L245
	moveq	#0,d0
L246
	tst.w	d0
	beq.b	L248
L247
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L248
;	JASMINE_EA::D2C_X16(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L250
L249
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra.b	L251
L250
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	6(a0),a1
	move.l	a1,$114(a2)
L251
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L253
L252
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra.b	L254
L253
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	6(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L254
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s16!=*jvm->op[1].s16)
	move.l	$114(a3),a0
	move.w	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.w	(a0),d1
	beq.b	L256
L255
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra.b	L257
L256
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L257
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBNEQ_I32(OP_ARGS)
	XDEF	fBNEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBNEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L258
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq.b	L260
L259
	moveq	#1,d0
	bra.b	L261
L260
	moveq	#0,d0
L261
	tst.w	d0
	beq.b	L263
L262
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L263
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L265
L264
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra.b	L266
L265
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L266
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L268
L267
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra.b	L269
L268
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L269
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s32!=*jvm->op[1].s32)
	move.l	$114(a3),a0
	move.l	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.l	(a0),d1
	beq.b	L271
L270
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra.b	L272
L271
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L272
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBNEQ_I64(OP_ARGS)
	XDEF	fBNEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBNEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L273
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq.b	L275
L274
	moveq	#1,d0
	bra.b	L276
L275
	moveq	#0,d0
L276
	tst.w	d0
	beq.b	L278
L277
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts
L278
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L280
L279
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra.b	L281
L280
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L281
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L283
L282
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra.b	L284
L283
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L284
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s64!=*jvm->op[0].s64)
	move.l	$114(a3),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	$114(a3),a0
	move.l	(a0),d0
	move.l	4(a0),d1
	cmp.l	d2,d0
	bne.b	L285
	cmp.l	d3,d1
	beq.b	L286
L285
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra.b	L287
L286
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L287
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBNEQ_F32(OP_ARGS)
	XDEF	fBNEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBNEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L288
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq.b	L290
L289
	moveq	#1,d0
	bra.b	L291
L290
	moveq	#0,d0
L291
	tst.w	d0
	beq.b	L293
L292
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L293
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs.b	L295
L294
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L296
L295
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L296
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L298
L297
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L299
L298
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L299
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f32!=*jvm->op[1].f32)
	move.l	$114(a3),a0
	fmove.s	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.s	(a0),fp0
	fcmp.x	fp0,fp1
	fbeq.b	L301
L300
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra.b	L302
L301
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L302
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBNEQ_F64(OP_ARGS)
	XDEF	fBNEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBNEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L303
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq.b	L305
L304
	moveq	#1,d0
	bra.b	L306
L305
	moveq	#0,d0
L306
	tst.w	d0
	beq	L308
L307
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts
L308
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L310
L309
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L311
L310
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L311
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L313
L312
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L314
L313
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L314
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f64!=*jvm->op[1].f64)
	move.l	$114(a3),a0
	fmove.d	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.d	(a0),fp0
	fcmp.x	fp0,fp1
	fbeq.b	L316
L315
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L317
L316
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L317
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLS_I8(OP_ARGS)
	XDEF	fBLS_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLS_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L318
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq.b	L320
L319
	moveq	#1,d0
	bra.b	L321
L320
	moveq	#0,d0
L321
	tst.w	d0
	beq	L323
L322
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L323
;	JASMINE_EA::D2C_X8(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L325
L324
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L326
L325
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	7(a0),a1
	move.l	a1,$114(a2)
L326
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L328
L327
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L329
L328
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	7(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L329
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s8<*jvm->op[1].s8)
	move.l	$114(a3),a0
	move.b	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.b	(a0),d1
	bge	L331
L330
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L332
L331
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L332
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLS_I16(OP_ARGS)
	XDEF	fBLS_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLS_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L333
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L335
L334
	moveq	#1,d0
	bra.b	L336
L335
	moveq	#0,d0
L336
	tst.w	d0
	beq	L338
L337
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L338
;	JASMINE_EA::D2C_X16(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L340
L339
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L341
L340
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	6(a0),a1
	move.l	a1,$114(a2)
L341
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L343
L342
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L344
L343
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	6(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L344
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s16<*jvm->op[1].s16)
	move.l	$114(a3),a0
	move.w	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.w	(a0),d1
	bge	L346
L345
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L347
L346
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L347
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLS_I32(OP_ARGS)
	XDEF	fBLS_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLS_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L348
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L350
L349
	moveq	#1,d0
	bra	L351
L350
	moveq	#0,d0
L351
	tst.w	d0
	beq	L353
L352
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L353
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L355
L354
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L356
L355
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L356
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L358
L357
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L359
L358
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L359
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s32<*jvm->op[1].s32)
	move.l	$114(a3),a0
	move.l	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.l	(a0),d1
	bge	L361
L360
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L362
L361
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L362
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLS_I64(OP_ARGS)
	XDEF	fBLS_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLS_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L363
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L365
L364
	moveq	#1,d0
	bra	L366
L365
	moveq	#0,d0
L366
	tst.w	d0
	beq	L368
L367
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts
L368
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L370
L369
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L371
L370
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L371
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L373
L372
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L374
L373
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L374
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s64<*jvm->op[1].s64)
	move.l	$114(a3),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	lea	$114(a3),a0
	move.l	4(a0),a0
	move.l	(a0),d0
	move.l	4(a0),d1
	exg	d0,d2
	exg	d1,d3
	cmp.l	d2,d0
	bgt	L376
	bne	L375
	cmp.l	d3,d1
	bhs	L376
L375
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L377
L376
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L377
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLS_F32(OP_ARGS)
	XDEF	fBLS_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLS_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L378
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L380
L379
	moveq	#1,d0
	bra	L381
L380
	moveq	#0,d0
L381
	tst.w	d0
	beq	L383
L382
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L383
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L385
L384
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L386
L385
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L386
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L388
L387
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L389
L388
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L389
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f32<*jvm->op[1].f32)
	move.l	$114(a3),a0
	fmove.s	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.s	(a0),fp0
	fcmp.x	fp0,fp1
	fboge.b	L391
L390
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L392
L391
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L392
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLS_F64(OP_ARGS)
	XDEF	fBLS_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLS_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L393
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L395
L394
	moveq	#1,d0
	bra	L396
L395
	moveq	#0,d0
L396
	tst.w	d0
	beq	L398
L397
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts
L398
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L400
L399
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L401
L400
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L401
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L403
L402
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L404
L403
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L404
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f64<*jvm->op[1].f64)
	move.l	$114(a3),a0
	fmove.d	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.d	(a0),fp0
	fcmp.x	fp0,fp1
	fboge.b	L406
L405
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L407
L406
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L407
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLSEQ_I8(OP_ARGS)
	XDEF	fBLSEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLSEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L408
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L410
L409
	moveq	#1,d0
	bra	L411
L410
	moveq	#0,d0
L411
	tst.w	d0
	beq	L413
L412
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L413
;	JASMINE_EA::D2C_X8(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L415
L414
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L416
L415
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	7(a0),a1
	move.l	a1,$114(a2)
L416
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L418
L417
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L419
L418
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	7(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L419
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s8<=*jvm->op[1].s8)
	move.l	$114(a3),a0
	move.b	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.b	(a0),d1
	bgt	L421
L420
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L422
L421
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L422
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLSEQ_I16(OP_ARGS)
	XDEF	fBLSEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLSEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L423
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L425
L424
	moveq	#1,d0
	bra	L426
L425
	moveq	#0,d0
L426
	tst.w	d0
	beq	L428
L427
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L428
;	JASMINE_EA::D2C_X16(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L430
L429
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L431
L430
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	6(a0),a1
	move.l	a1,$114(a2)
L431
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L433
L432
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L434
L433
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	6(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L434
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s16<=*jvm->op[1].s16)
	move.l	$114(a3),a0
	move.w	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.w	(a0),d1
	bgt	L436
L435
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L437
L436
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L437
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLSEQ_I32(OP_ARGS)
	XDEF	fBLSEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLSEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L438
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L440
L439
	moveq	#1,d0
	bra	L441
L440
	moveq	#0,d0
L441
	tst.w	d0
	beq	L443
L442
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L443
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L445
L444
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L446
L445
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L446
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L448
L447
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L449
L448
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L449
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s32<=*jvm->op[1].s32)
	move.l	$114(a3),a0
	move.l	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.l	(a0),d1
	bgt	L451
L450
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L452
L451
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L452
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLSEQ_I64(OP_ARGS)
	XDEF	fBLSEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLSEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L453
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L455
L454
	moveq	#1,d0
	bra	L456
L455
	moveq	#0,d0
L456
	tst.w	d0
	beq	L458
L457
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts
L458
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L460
L459
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L461
L460
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L461
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L463
L462
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L464
L463
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L464
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s64<=*jvm->op[1].s64)
	move.l	$114(a3),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	lea	$114(a3),a0
	move.l	4(a0),a0
	move.l	(a0),d0
	move.l	4(a0),d1
	exg	d0,d2
	exg	d1,d3
	cmp.l	d2,d0
	bgt	L466
	bne	L465
	cmp.l	d3,d1
	bhi	L466
L465
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L467
L466
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L467
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLSEQ_F32(OP_ARGS)
	XDEF	fBLSEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLSEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L468
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L470
L469
	moveq	#1,d0
	bra	L471
L470
	moveq	#0,d0
L471
	tst.w	d0
	beq	L473
L472
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L473
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L475
L474
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L476
L475
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L476
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L478
L477
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L479
L478
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L479
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f32<=*jvm->op[1].f32)
	move.l	$114(a3),a0
	fmove.s	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.s	(a0),fp0
	fcmp.x	fp0,fp1
	fbogt.b	L481
L480
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L482
L481
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L482
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBLSEQ_F64(OP_ARGS)
	XDEF	fBLSEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBLSEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L483
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L485
L484
	moveq	#1,d0
	bra	L486
L485
	moveq	#0,d0
L486
	tst.w	d0
	beq	L488
L487
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts
L488
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L490
L489
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L491
L490
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L491
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L493
L492
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L494
L493
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L494
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f64<=*jvm->op[0].f64)
	move.l	$114(a3),a0
	fmove.d	(a0),fp1
	move.l	$114(a3),a0
	fmove.d	(a0),fp0
	fcmp.x	fp0,fp1
	fbogt.b	L496
L495
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L497
L496
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L497
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBEQ_I8(OP_ARGS)
	XDEF	fBEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBEQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L498
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L500
L499
	moveq	#1,d0
	bra	L501
L500
	moveq	#0,d0
L501
	tst.w	d0
	beq	L503
L502
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L503
;	JASMINE_EA::D2C_X8(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L505
L504
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L506
L505
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	7(a0),a1
	move.l	a1,$114(a2)
L506
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L508
L507
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L509
L508
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	7(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L509
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s8==*jvm->op[1].s8)
	move.l	$114(a3),a0
	move.b	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.b	(a0),d1
	bne	L511
L510
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L512
L511
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L512
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBEQ_I16(OP_ARGS)
	XDEF	fBEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBEQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L513
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L515
L514
	moveq	#1,d0
	bra	L516
L515
	moveq	#0,d0
L516
	tst.w	d0
	beq	L518
L517
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L518
;	JASMINE_EA::D2C_X16(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L520
L519
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L521
L520
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	6(a0),a1
	move.l	a1,$114(a2)
L521
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L523
L522
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L524
L523
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	6(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L524
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s16==*jvm->op[1].s16)
	move.l	$114(a3),a0
	move.w	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.w	(a0),d1
	bne	L526
L525
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L527
L526
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L527
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBEQ_I32(OP_ARGS)
	XDEF	fBEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBEQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L528
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L530
L529
	moveq	#1,d0
	bra	L531
L530
	moveq	#0,d0
L531
	tst.w	d0
	beq	L533
L532
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L533
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L535
L534
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L536
L535
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L536
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L538
L537
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L539
L538
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L539
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s32==*jvm->op[1].s32)
	move.l	$114(a3),a0
	move.l	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.l	(a0),d1
	bne	L541
L540
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L542
L541
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L542
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBEQ_I64(OP_ARGS)
	XDEF	fBEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBEQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L543
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L545
L544
	moveq	#1,d0
	bra	L546
L545
	moveq	#0,d0
L546
	tst.w	d0
	beq	L548
L547
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts
L548
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L550
L549
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L551
L550
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L551
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L553
L552
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L554
L553
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L554
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s64==*jvm->op[1].s64)
	move.l	$114(a3),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	lea	$114(a3),a0
	move.l	4(a0),a0
	move.l	(a0),d0
	move.l	4(a0),d1
	cmp.l	d2,d0
	bne	L556
	cmp.l	d3,d1
	bne	L556
L555
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L557
L556
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L557
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBEQ_F32(OP_ARGS)
	XDEF	fBEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBEQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L558
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L560
L559
	moveq	#1,d0
	bra	L561
L560
	moveq	#0,d0
L561
	tst.w	d0
	beq	L563
L562
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L563
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L565
L564
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L566
L565
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L566
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L568
L567
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L569
L568
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L569
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f32==*jvm->op[1].f32)
	move.l	$114(a3),a0
	fmove.s	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.s	(a0),fp0
	fcmp.x	fp0,fp1
	fbne.b	L571
L570
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L572
L571
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L572
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBEQ_F64(OP_ARGS)
	XDEF	fBEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBEQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L573
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L575
L574
	moveq	#1,d0
	bra	L576
L575
	moveq	#0,d0
L576
	tst.w	d0
	beq	L578
L577
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts
L578
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L580
L579
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L581
L580
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L581
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L583
L582
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L584
L583
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L584
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f64==*jvm->op[1].f64)
	move.l	$114(a3),a0
	fmove.d	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.d	(a0),fp0
	fcmp.x	fp0,fp1
	fbne.b	L586
L585
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L587
L586
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L587
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGREQ_I8(OP_ARGS)
	XDEF	fBGREQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGREQ_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L588
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L590
L589
	moveq	#1,d0
	bra	L591
L590
	moveq	#0,d0
L591
	tst.w	d0
	beq	L593
L592
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L593
;	JASMINE_EA::D2C_X8(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L595
L594
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L596
L595
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	7(a0),a1
	move.l	a1,$114(a2)
L596
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L598
L597
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L599
L598
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	7(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L599
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s8>=*jvm->op[1].s8)
	move.l	$114(a3),a0
	move.b	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.b	(a0),d1
	blt	L601
L600
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L602
L601
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L602
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGREQ_I16(OP_ARGS)
	XDEF	fBGREQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGREQ_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L603
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L605
L604
	moveq	#1,d0
	bra	L606
L605
	moveq	#0,d0
L606
	tst.w	d0
	beq	L608
L607
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L608
;	JASMINE_EA::D2C_X16(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L610
L609
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L611
L610
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	6(a0),a1
	move.l	a1,$114(a2)
L611
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L613
L612
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L614
L613
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	6(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L614
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s16>=*jvm->op[1].s16)
	move.l	$114(a3),a0
	move.w	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.w	(a0),d1
	blt	L616
L615
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L617
L616
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L617
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGREQ_I32(OP_ARGS)
	XDEF	fBGREQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGREQ_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L618
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L620
L619
	moveq	#1,d0
	bra	L621
L620
	moveq	#0,d0
L621
	tst.w	d0
	beq	L623
L622
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L623
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L625
L624
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L626
L625
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L626
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L628
L627
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L629
L628
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L629
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s32>=*jvm->op[1].s32)
	move.l	$114(a3),a0
	move.l	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.l	(a0),d1
	blt	L631
L630
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L632
L631
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L632
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGREQ_I64(OP_ARGS)
	XDEF	fBGREQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGREQ_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L633
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L635
L634
	moveq	#1,d0
	bra	L636
L635
	moveq	#0,d0
L636
	tst.w	d0
	beq	L638
L637
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts
L638
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L640
L639
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L641
L640
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L641
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L643
L642
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L644
L643
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L644
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s64>=*jvm->op[1].s64)
	move.l	$114(a3),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	lea	$114(a3),a0
	move.l	4(a0),a0
	move.l	(a0),d0
	move.l	4(a0),d1
	exg	d0,d2
	exg	d1,d3
	cmp.l	d2,d0
	blt	L646
	bne	L645
	cmp.l	d3,d1
	blo	L646
L645
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L647
L646
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L647
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGREQ_F32(OP_ARGS)
	XDEF	fBGREQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGREQ_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L648
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L650
L649
	moveq	#1,d0
	bra	L651
L650
	moveq	#0,d0
L651
	tst.w	d0
	beq	L653
L652
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L653
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L655
L654
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L656
L655
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L656
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L658
L657
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L659
L658
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L659
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f32>=*jvm->op[1].f32)
	move.l	$114(a3),a0
	fmove.s	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.s	(a0),fp0
	fcmp.x	fp0,fp1
	fbolt.b	L661
L660
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L662
L661
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L662
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGREQ_F64(OP_ARGS)
	XDEF	fBGREQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGREQ_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L663
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L665
L664
	moveq	#1,d0
	bra	L666
L665
	moveq	#0,d0
L666
	tst.w	d0
	beq	L668
L667
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts
L668
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L670
L669
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L671
L670
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L671
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L673
L672
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L674
L673
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L674
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f64>=*jvm->op[1].f64)
	move.l	$114(a3),a0
	fmove.d	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.d	(a0),fp0
	fcmp.x	fp0,fp1
	fbolt.b	L676
L675
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L677
L676
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L677
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGR_I8(OP_ARGS)
	XDEF	fBGR_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGR_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L678
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L680
L679
	moveq	#1,d0
	bra	L681
L680
	moveq	#0,d0
L681
	tst.w	d0
	beq	L683
L682
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L683
;	JASMINE_EA::D2C_X8(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L685
L684
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L686
L685
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	7(a0),a1
	move.l	a1,$114(a2)
L686
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L688
L687
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L689
L688
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	7(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L689
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s8>*jvm->op[1].s8)
	move.l	$114(a3),a0
	move.b	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.b	(a0),d1
	ble	L691
L690
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L692
L691
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L692
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGR_I16(OP_ARGS)
	XDEF	fBGR_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGR_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L693
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L695
L694
	moveq	#1,d0
	bra	L696
L695
	moveq	#0,d0
L696
	tst.w	d0
	beq	L698
L697
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L698
;	JASMINE_EA::D2C_X16(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L700
L699
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L701
L700
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	6(a0),a1
	move.l	a1,$114(a2)
L701
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L703
L702
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L704
L703
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	6(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L704
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s16>*jvm->op[1].s16)
	move.l	$114(a3),a0
	move.w	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.w	(a0),d1
	ble	L706
L705
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L707
L706
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L707
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGR_I32(OP_ARGS)
	XDEF	fBGR_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGR_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L708
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L710
L709
	moveq	#1,d0
	bra	L711
L710
	moveq	#0,d0
L711
	tst.w	d0
	beq	L713
L712
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L713
;	JASMINE_EA::D2C_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L715
L714
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L716
L715
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L716
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L718
L717
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L719
L718
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	lea	4(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L719
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s32>*jvm->op[1].s32)
	move.l	$114(a3),a0
	move.l	(a0),d1
	lea	$114(a3),a0
	move.l	4(a0),a0
	cmp.l	(a0),d1
	ble	L721
L720
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L722
L721
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L722
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGR_I64(OP_ARGS)
	XDEF	fBGR_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGR_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L723
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L725
L724
	moveq	#1,d0
	bra	L726
L725
	moveq	#0,d0
L726
	tst.w	d0
	beq	L728
L727
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts
L728
;	JASMINE_EA::D2C_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L730
L729
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L731
L730
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L731
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	cmp.l	#$E0,d0
	bhs	L733
L732
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	lea	$114(a2),a0
	move.l	d0,4(a0)
	bra	L734
L733
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	lea	$8(a0),a1
	lea	$114(a2),a0
	move.l	a1,4(a0)
L734
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].s64>*jvm->op[1].s64)
	move.l	$114(a3),a0
	move.l	(a0),d2
	move.l	4(a0),d3
	lea	$114(a3),a0
	move.l	4(a0),a0
	move.l	(a0),d0
	move.l	4(a0),d1
	exg	d0,d2
	exg	d1,d3
	cmp.l	d2,d0
	blt	L736
	bne	L735
	cmp.l	d3,d1
	bls	L736
L735
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L737
L736
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L737
	movem.l	(a7)+,d2/d3/d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGR_F32(OP_ARGS)
	XDEF	fBGR_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGR_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L738
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L740
L739
	moveq	#1,d0
	bra	L741
L740
	moveq	#0,d0
L741
	tst.w	d0
	beq	L743
L742
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d7/a2/a3/a6
	rts
L743
;	JASMINE_EA::D1_X32(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L745
L744
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L746
L745
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L746
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f32>*jvm->op[1].f32)
	move.l	$114(a3),a0
	fmove.s	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.s	(a0),fp0
	fcmp.x	fp0,fp1
	fbole.b	L748
L747
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L749
L748
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L749
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fBGR_F64(OP_ARGS)
	XDEF	fBGR_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fBGR_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a2/a3/a6,-(a7)
	move.l	a2,a3
L750
;	CHECKBREAK()
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq	L752
L751
	moveq	#1,d0
	bra	L753
L752
	moveq	#0,d0
L753
	tst.w	d0
	beq	L755
L754
;	CHECKBREAK()
	move.l	a3,a0
	move.l	#2,$134(a0)
;	CHECKBREAK()
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts
L755
;	JASMINE_EA::D1_X64(jvm);
	move.l	a3,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L757
L756
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L758
L757
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a1
	move.l	a1,$114(a2)
L758
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	if (*jvm->op[0].f64>*jvm->op[1].f64)
	move.l	$114(a3),a0
	fmove.d	(a0),fp1
	lea	$114(a3),a0
	move.l	4(a0),a0
	fmove.d	(a0),fp0
	fcmp.x	fp0,fp1
	fbole.b	L760
L759
;		jvm->instPtr += *((sint32*)jvm->instPtr);
	move.l	a3,a1
	move.l	$110(a1),a0
	move.l	(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a2
	move.l	$110(a2),a0
	lea	0(a0,d0.l),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
	bra	L761
L760
;		jvm->instPtr++;
	move.l	a3,a1
	move.l	$110(a1),a0
	lea	4(a0),a0
	move.l	a3,a1
	move.l	a0,$110(a1)
L761
	movem.l	(a7)+,d2/d7/a2/a3/a6
	rts

;void JASMINE_OP::fCALL(OP_ARGS)
	XDEF	fCALL__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fCALL__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a2/a3/a6,-(a7)
	move.l	a2,a6
L762
;	if (jvm->methodStack<jvm->methodStackTop)
	move.l	a6,a0
	move.l	$128(a0),a1
	move.l	a6,a2
	cmp.l	$148(a2),a1
	bhs	L767
L763
;		JASMINE_EA::D1_X32(jvm);
	move.l	a6,a2
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	1(a0),d0
	cmp.l	#$E0,d0
	bhs	L765
L764
	move.l	#_eaTable__JASMINE_EA,a1
	move.l	0(a1,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,$114(a2)
	bra	L766
L765
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	4(a0),a1
	move.l	a1,$114(a2)
L766
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;		*(jvm->methodStack++) = jvm->instPtr;
	move.l	a6,a0
	move.l	$110(a0),a2
	move.l	a6,a1
	move.l	$128(a1),a1
	lea	4(a1),a0
	move.l	a6,a3
	move.l	a0,$128(a3)
	move.l	a2,(a1)
;		jvm->instPtr = jvm->op[0].u32;
	move.l	a6,a1
	move.l	$114(a6),$110(a1)
	bra	L768
L767
;		jvm->exitReg = JASMINE::METHD_OVERFLOW;
	move.l	a6,a0
	move.l	#6,$134(a0)
L768
	movem.l	(a7)+,d7/a2/a3/a6
	rts

;void JASMINE_OP::fRET(OP_ARGS)
	XDEF	fRET__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fRET__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
L769
;	if (jvm->methodStack>jvm->methodStackBase)
	move.l	$128(a2),a1
	cmp.l	$144(a2),a1
	bls	L771
L770
;		jvm->instPtr = *(--jvm->methodStack);
	move.l	$128(a2),a0
	subq.w	#4,a0
	move.l	a0,$128(a2)
	move.l	(a0),$110(a2)
	bra	L772
L771
;		jvm->exitReg = JASMINE::METHD_UNDERFLOW;
	move.l	#7,$134(a2)
L772
	rts

	END
