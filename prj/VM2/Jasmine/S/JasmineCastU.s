
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineCastU.cpp
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


;void JASMINE_OP::fI16_U8(OP_ARGS)
	XDEF	fI16_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI16_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L98
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(uint16) = OP1_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L100
L99
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
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
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L107
L104
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L105
L106
L107
	moveq	#0,d2
	move.b	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L109
L108
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra.b	L110
L109
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L110
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI32_U8(OP_ARGS)
	XDEF	fI32_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI32_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L111
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(uint32) = OP1_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L113
L112
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
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
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L120
L117
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L118
L119
L120
	moveq	#0,d2
	move.b	(a0),d2
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
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI64_U8(OP_ARGS)
	XDEF	fI64_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI64_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L124
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(uint64) = OP1_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L126
L125
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L133
L126
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L128
L127
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L133
L128
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L130
L129
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L133
L130
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L131
L132
L133
	moveq	#0,d2
	moveq	#0,d2
	move.b	(a0),d3
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L135
L134
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L136
L135
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L136
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fF32_U8(OP_ARGS)
	XDEF	fF32_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF32_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L137
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = (float32)(OP1_8(uint8));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L139
L138
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L146
L139
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L141
L140
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L146
L141
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L143
L142
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L146
L143
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L144
L145
L146
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L148
L147
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L149
L148
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L149
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fF64_U8(OP_ARGS)
	XDEF	fF64_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF64_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L150
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = (float64)(OP1_8(uint8));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L152
L151
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L159
L152
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L154
L153
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L159
L154
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L156
L155
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L159
L156
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L157
L158
L159
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L161
L160
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L162
L161
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L162
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fI32_U16(OP_ARGS)
	XDEF	fI32_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI32_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L163
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(uint32) = OP1_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L165
L164
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L172
L165
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L167
L166
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L172
L167
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L169
L168
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L172
L169
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L170
L171
L172
	moveq	#0,d2
	move.w	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L174
L173
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L175
L174
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L175
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI64_U16(OP_ARGS)
	XDEF	fI64_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI64_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L176
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(uint64) = OP1_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L178
L177
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L185
L178
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L180
L179
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L185
L180
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L182
L181
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L185
L182
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L183
L184
L185
	moveq	#0,d2
	moveq	#0,d2
	move.w	(a0),d3
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L187
L186
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L188
L187
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L188
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fF32_U16(OP_ARGS)
	XDEF	fF32_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF32_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L189
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = (float32)(OP1_16(uint16));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L191
L190
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L198
L191
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L193
L192
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L198
L193
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L195
L194
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L198
L195
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L196
L197
L198
	moveq	#0,d0
	move.w	(a0),d0
	fmove.l	d0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L200
L199
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L201
L200
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L201
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fF64_U16(OP_ARGS)
	XDEF	fF64_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF64_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L202
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = (float64)(OP1_16(uint16));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L204
L203
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L211
L204
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L206
L205
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L211
L206
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L208
L207
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L211
L208
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L209
L210
L211
	moveq	#0,d0
	move.w	(a0),d0
	fmove.l	d0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L213
L212
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L214
L213
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L214
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fI64_U32(OP_ARGS)
	XDEF	fI64_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI64_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L215
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(uint64) = OP1_32(uint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L217
L216
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L224
L217
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L219
L218
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L224
L219
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L221
L220
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L224
L221
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L222
L223
L224
	moveq	#0,d2
	move.l	(a0),d3
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L226
L225
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L227
L226
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L227
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fF32_U32(OP_ARGS)
	XDEF	fF32_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF32_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L228
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = (float32)(OP1_32(uint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L230
L229
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L237
L230
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L232
L231
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L237
L232
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L234
L233
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L237
L234
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L235
L236
L237
	fmove.l	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L239
L238
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L240
L239
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L240
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fF64_U32(OP_ARGS)
	XDEF	fF64_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF64_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L241
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = (float64)(OP1_32(uint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L243
L242
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L250
L243
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L245
L244
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L250
L245
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L247
L246
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L250
L247
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L248
L249
L250
	fmove.l	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L252
L251
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L253
L252
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L253
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fF32_U64(OP_ARGS)
	XDEF	fF32_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF32_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L254
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = (float32)(OP1_64(uint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L256
L255
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L263
L256
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L258
L257
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L263
L258
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L260
L259
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L263
L260
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L267
	moveq	#-1,d0
L267
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L261
L262
L263
	move.l	(a0),d0
	move.l	4(a0),d1
	fmove.l	d1,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L265
L264
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L266
L265
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L266
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fF64_U64(OP_ARGS)
	XDEF	fF64_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF64_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L268
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = (float64)(OP1_64(uint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L270
L269
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L277
L270
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L272
L271
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L277
L272
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L274
L273
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L277
L274
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L281
	moveq	#-1,d0
L281
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L275
L276
L277
	move.l	(a0),d0
	move.l	4(a0),d1
	fmove.l	d1,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L279
L278
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L280
L279
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L280
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fU64_F64(OP_ARGS)
	XDEF	fU64_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fU64_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L282
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(uint64) = (uint64)(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L284
L283
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L291
L284
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L286
L285
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L291
L286
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L288
L287
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L291
L288
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L295
	moveq	#-1,d0
L295
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L289
L290
L291
	fmove.d	(a0),fp0
	fmove.l	fp0,d0
	moveq	#0,d2
	move.l	d0,d3
	bpl.b	L296
	moveq	#-1,d2
L296
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L293
L292
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L294
L293
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L294
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fU32_F64(OP_ARGS)
	XDEF	fU32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fU32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L297
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(uint32) = (uint32)(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L299
L298
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L306
L299
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L301
L300
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L306
L301
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L303
L302
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L306
L303
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L310
	moveq	#-1,d0
L310
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L304
L305
L306
	fmove.d	(a0),fp0
	fmove.l	fp0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L308
L307
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L309
L308
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L309
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fU16_F64(OP_ARGS)
	XDEF	fU16_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fU16_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L311
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(uint16) = (uint16)(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L313
L312
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L320
L313
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L315
L314
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L320
L315
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L317
L316
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L320
L317
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L324
	moveq	#-1,d0
L324
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L318
L319
L320
	fmove.d	(a0),fp0
	fmove.l	fp0,d0
	move.w	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L322
L321
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L323
L322
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L323
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fU8_F64(OP_ARGS)
	XDEF	fU8_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fU8_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L325
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(uint8) = (uint8)(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L327
L326
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L334
L327
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L329
L328
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L334
L329
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L331
L330
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L334
L331
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L338
	moveq	#-1,d0
L338
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L332
L333
L334
	fmove.d	(a0),fp0
	fmove.l	fp0,d0
	move.b	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L336
L335
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L337
L336
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L337
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fU64_F32(OP_ARGS)
	XDEF	fU64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fU64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L339
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(uint64) = (uint64)OP1_32(float32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L341
L340
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L348
L341
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L343
L342
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L348
L343
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L345
L344
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L348
L345
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L346
L347
L348
	fmove.s	(a0),fp0
	fmove.l	fp0,d0
	moveq	#0,d2
	move.l	d0,d3
	bpl	L352
	moveq	#-1,d2
L352
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L350
L349
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L351
L350
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L351
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fU32_F32(OP_ARGS)
	XDEF	fU32_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fU32_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L353
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(uint32) = (uint32)(OP1_32(float32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L355
L354
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L362
L355
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L357
L356
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L362
L357
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L359
L358
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L362
L359
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L360
L361
L362
	fmove.s	(a0),fp0
	fmove.l	fp0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L364
L363
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L365
L364
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L365
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fU16_F32(OP_ARGS)
	XDEF	fU16_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fU16_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L366
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(uint16) = (uint16)(OP1_32(float32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L368
L367
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L375
L368
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L370
L369
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L375
L370
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L372
L371
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L375
L372
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L373
L374
L375
	fmove.s	(a0),fp0
	fmove.l	fp0,d0
	move.w	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L377
L376
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L378
L377
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L378
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fU8_F32(OP_ARGS)
	XDEF	fU8_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fU8_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L379
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(uint8) = (uint8)(OP1_32(float32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L381
L380
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L388
L381
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L383
L382
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L388
L383
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L385
L384
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L388
L385
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L386
L387
L388
	fmove.s	(a0),fp0
	fmove.l	fp0,d0
	move.b	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L390
L389
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L391
L390
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L391
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI32_U64(OP_ARGS)
	XDEF	fI32_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI32_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L392
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(uint32) = (uint32)(OP1_64(uint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L394
L393
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L401
L394
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L396
L395
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L401
L396
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L398
L397
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L401
L398
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L405
	moveq	#-1,d0
L405
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L399
L400
L401
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d1,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L403
L402
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L404
L403
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L404
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI16_U64(OP_ARGS)
	XDEF	fI16_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI16_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L406
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(uint16) = (uint16)(OP1_64(uint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L408
L407
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L415
L408
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L410
L409
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L415
L410
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L412
L411
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L415
L412
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L419
	moveq	#-1,d0
L419
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L413
L414
L415
	move.l	(a0),d0
	move.l	4(a0),d1
	move.w	d1,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L417
L416
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L418
L417
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L418
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI8_U64(OP_ARGS)
	XDEF	fI8_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI8_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L420
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(uint8) = (uint8)(OP1_64(uint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L422
L421
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L429
L422
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L424
L423
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L429
L424
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L426
L425
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L429
L426
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L433
	moveq	#-1,d0
L433
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L427
L428
L429
	move.l	(a0),d0
	move.l	4(a0),d1
	move.b	d1,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L431
L430
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L432
L431
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L432
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI16_U32(OP_ARGS)
	XDEF	fI16_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI16_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L434
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(uint16) = (uint16)(OP1_32(uint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L436
L435
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L443
L436
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L438
L437
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L443
L438
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L440
L439
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L443
L440
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L441
L442
L443
	move.w	2(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L445
L444
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L446
L445
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L446
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI8_U32(OP_ARGS)
	XDEF	fI8_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI8_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L447
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(uint8) = (uint8)(OP1_32(uint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L449
L448
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L456
L449
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L451
L450
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L456
L451
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L453
L452
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L456
L453
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L454
L455
L456
	move.b	3(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L458
L457
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L459
L458
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L459
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI8_U16(OP_ARGS)
	XDEF	fI8_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI8_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L460
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(uint8) = (uint8)(OP1_16(uint16));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L462
L461
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L469
L462
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L464
L463
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L469
L464
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L466
L465
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L469
L466
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L467
L468
L469
	move.b	1(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L471
L470
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L472
L471
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L472
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

	END
