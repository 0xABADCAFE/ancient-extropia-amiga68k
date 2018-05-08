
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineCastS.cpp
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


;void JASMINE_OP::fI16_S8(OP_ARGS)
	XDEF	fI16_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI16_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L98
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(sint16) = OP1_8(sint8);
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
	move.b	(a0),d2
	ext.w	d2
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

;void JASMINE_OP::fI32_S8(OP_ARGS)
	XDEF	fI32_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI32_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L111
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(sint32) = OP1_8(sint8);
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
	move.b	(a0),d2
	extb.l	d2
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

;void JASMINE_OP::fI64_S8(OP_ARGS)
	XDEF	fI64_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI64_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L124
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(sint64) = OP1_8(sint8);
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
	move.b	(a0),d3
	extb.l	d3
	bpl.b	L137
	moveq	#-1,d2
L137
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

;void JASMINE_OP::fF32_S8(OP_ARGS)
	XDEF	fF32_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF32_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L138
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = (float32)(OP1_8(sint8));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L140
L139
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L147
L140
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L142
L141
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L147
L142
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L144
L143
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L147
L144
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L145
L146
L147
	move.b	(a0),d0
	extb.l	d0
	fmove.l	d0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L149
L148
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L150
L149
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L150
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fF64_S8(OP_ARGS)
	XDEF	fF64_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF64_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L151
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = (float64)(OP1_8(sint8));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L153
L152
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L160
L153
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L155
L154
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L160
L155
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L157
L156
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L160
L157
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L158
L159
L160
	move.b	(a0),d0
	extb.l	d0
	fmove.l	d0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L162
L161
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L163
L162
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L163
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fI32_S16(OP_ARGS)
	XDEF	fI32_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI32_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L164
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(sint32) = OP1_16(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L166
L165
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L173
L166
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L168
L167
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L173
L168
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L170
L169
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L173
L170
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L171
L172
L173
	move.w	(a0),d2
	ext.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L175
L174
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L176
L175
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L176
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI64_S16(OP_ARGS)
	XDEF	fI64_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI64_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L177
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(sint64) = OP1_16(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L179
L178
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L186
L179
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L181
L180
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L186
L181
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L183
L182
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L186
L183
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L184
L185
L186
	moveq	#0,d2
	move.w	(a0),d3
	ext.l	d3
	bpl.b	L190
	moveq	#-1,d2
L190
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L188
L187
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L189
L188
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L189
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fF32_S16(OP_ARGS)
	XDEF	fF32_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF32_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L191
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = (float32)(OP1_16(sint16));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L193
L192
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L200
L193
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L195
L194
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L200
L195
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L197
L196
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L200
L197
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L198
L199
L200
	move.w	(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L202
L201
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L203
L202
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L203
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fF64_S16(OP_ARGS)
	XDEF	fF64_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF64_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L204
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = (float64)(OP1_16(sint16));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L206
L205
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L213
L206
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L208
L207
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L213
L208
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L210
L209
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L213
L210
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L211
L212
L213
	move.w	(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L215
L214
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L216
L215
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L216
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fI64_S32(OP_ARGS)
	XDEF	fI64_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI64_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L217
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(sint64) = OP1_32(sint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L219
L218
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L226
L219
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L221
L220
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L226
L221
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L223
L222
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L226
L223
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L224
L225
L226
	moveq	#0,d2
	move.l	(a0),d3
	bpl.b	L230
	moveq	#-1,d2
L230
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L228
L227
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L229
L228
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L229
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fF32_S32(OP_ARGS)
	XDEF	fF32_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF32_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L231
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = (float32)(OP1_32(sint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L233
L232
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L240
L233
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L235
L234
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L240
L235
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L237
L236
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L240
L237
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L238
L239
L240
	fmove.l	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L242
L241
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L243
L242
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L243
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fF64_S32(OP_ARGS)
	XDEF	fF64_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF64_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L244
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = (float64)(OP1_32(sint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L246
L245
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L253
L246
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L248
L247
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L253
L248
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L250
L249
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L253
L250
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L251
L252
L253
	fmove.l	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L255
L254
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L256
L255
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L256
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fF32_S64(OP_ARGS)
	XDEF	fF32_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF32_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L257
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = (float32)(OP1_64(sint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L259
L258
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L266
L259
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L261
L260
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L266
L261
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L263
L262
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L266
L263
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L270
	moveq	#-1,d0
L270
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L264
L265
L266
	move.l	(a0),d0
	move.l	4(a0),d1
	fmove.l	d1,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L268
L267
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L269
L268
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L269
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fF64_S64(OP_ARGS)
	XDEF	fF64_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fF64_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L271
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = (float64)(OP1_64(sint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L273
L272
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L280
L273
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L275
L274
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L280
L275
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L277
L276
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L280
L277
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L284
	moveq	#-1,d0
L284
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L278
L279
L280
	move.l	(a0),d0
	move.l	4(a0),d1
	fmove.l	d1,fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L282
L281
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L283
L282
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L283
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fS64_F64(OP_ARGS)
	XDEF	fS64_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fS64_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L285
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(sint64) = (sint64)(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L287
L286
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L294
L287
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L289
L288
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L294
L289
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L291
L290
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L294
L291
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L298
	moveq	#-1,d0
L298
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L292
L293
L294
	fmove.d	(a0),fp0
	fmove.l	fp0,d0
	moveq	#0,d2
	move.l	d0,d3
	bpl.b	L299
	moveq	#-1,d2
L299
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L296
L295
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L297
L296
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L297
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fS32_F64(OP_ARGS)
	XDEF	fS32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fS32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L300
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(sint32) = (sint32)(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L302
L301
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L309
L302
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L304
L303
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L309
L304
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L306
L305
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L309
L306
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L313
	moveq	#-1,d0
L313
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L307
L308
L309
	fmove.d	(a0),fp0
	fmove.l	fp0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L311
L310
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L312
L311
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L312
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fS16_F64(OP_ARGS)
	XDEF	fS16_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fS16_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L314
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(sint16) = (sint16)(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L316
L315
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L323
L316
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L318
L317
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L323
L318
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L320
L319
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L323
L320
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L327
	moveq	#-1,d0
L327
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L321
L322
L323
	fmove.d	(a0),fp0
	fmove.l	fp0,d0
	move.w	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L325
L324
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L326
L325
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L326
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fS8_F64(OP_ARGS)
	XDEF	fS8_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fS8_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L328
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(sint8) = (sint8)(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L330
L329
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L337
L330
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L332
L331
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L337
L332
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L334
L333
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L337
L334
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L341
	moveq	#-1,d0
L341
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L335
L336
L337
	fmove.d	(a0),fp0
	fmove.l	fp0,d0
	move.b	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L339
L338
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L340
L339
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L340
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fS64_F32(OP_ARGS)
	XDEF	fS64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fS64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L342
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(sint64) = (sint64)OP1_32(float32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L344
L343
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L351
L344
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L346
L345
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L351
L346
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L348
L347
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L351
L348
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L349
L350
L351
	fmove.s	(a0),fp0
	fmove.l	fp0,d0
	moveq	#0,d2
	move.l	d0,d3
	bpl	L355
	moveq	#-1,d2
L355
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L353
L352
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L354
L353
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L354
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fS32_F32(OP_ARGS)
	XDEF	fS32_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fS32_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L356
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(sint32) = (sint32)(OP1_32(float32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L358
L357
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L365
L358
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L360
L359
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L365
L360
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L362
L361
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L365
L362
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L363
L364
L365
	fmove.s	(a0),fp0
	fmove.l	fp0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L367
L366
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L368
L367
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L368
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fS16_F32(OP_ARGS)
	XDEF	fS16_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fS16_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L369
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(sint16) = (sint16)(OP1_32(float32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L371
L370
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L378
L371
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L373
L372
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L378
L373
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L375
L374
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L378
L375
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L376
L377
L378
	fmove.s	(a0),fp0
	fmove.l	fp0,d0
	move.w	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L380
L379
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L381
L380
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L381
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fS8_F32(OP_ARGS)
	XDEF	fS8_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fS8_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L382
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(sint8) = (sint8)(OP1_32(float32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L384
L383
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L391
L384
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L386
L385
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L391
L386
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L388
L387
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L391
L388
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L389
L390
L391
	fmove.s	(a0),fp0
	fmove.l	fp0,d0
	move.b	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L393
L392
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L394
L393
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L394
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI32_S64(OP_ARGS)
	XDEF	fI32_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI32_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L395
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(sint32) = (sint32)(OP1_64(sint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L397
L396
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L404
L397
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L399
L398
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L404
L399
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L401
L400
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L404
L401
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L408
	moveq	#-1,d0
L408
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L402
L403
L404
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d1,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L406
L405
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L407
L406
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L407
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI16_S64(OP_ARGS)
	XDEF	fI16_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI16_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L409
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(sint16) = (sint16)(OP1_64(sint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L411
L410
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L418
L411
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L413
L412
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L418
L413
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L415
L414
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L418
L415
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L422
	moveq	#-1,d0
L422
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L416
L417
L418
	move.l	(a0),d0
	move.l	4(a0),d1
	move.w	d1,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L420
L419
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L421
L420
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L421
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI8_S64(OP_ARGS)
	XDEF	fI8_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI8_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L423
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(sint8) = (sint8)(OP1_64(sint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L425
L424
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L432
L425
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L427
L426
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L432
L427
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L429
L428
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L432
L429
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L436
	moveq	#-1,d0
L436
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L430
L431
L432
	move.l	(a0),d0
	move.l	4(a0),d1
	move.b	d1,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L434
L433
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L435
L434
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L435
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI16_S32(OP_ARGS)
	XDEF	fI16_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI16_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L437
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(sint16) = (sint16)(OP1_32(sint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L439
L438
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L446
L439
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L441
L440
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L446
L441
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L443
L442
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L446
L443
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L444
L445
L446
	move.w	2(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L448
L447
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L449
L448
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L449
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI8_S32(OP_ARGS)
	XDEF	fI8_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI8_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L450
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(sint8) = (sint8)(OP1_32(sint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L452
L451
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L459
L452
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L454
L453
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L459
L454
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L456
L455
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L459
L456
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L457
L458
L459
	move.b	3(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L461
L460
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L462
L461
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L462
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fI8_S16(OP_ARGS)
	XDEF	fI8_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fI8_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L463
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(sint8) = (sint8)(OP1_16(sint16));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L465
L464
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L472
L465
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L467
L466
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L472
L467
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L469
L468
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L472
L469
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L470
L471
L472
	move.b	1(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L474
L473
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L475
L474
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L475
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

	END
