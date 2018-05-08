
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineLogic.cpp
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


;void JASMINE_OP::fAND_X8(OP_ARGS)
	XDEF	fAND_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fAND_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L98
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(uint8) = OP1_8(uint8) & OP2_8(uint8);
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
	addq.w	#7,a0
	bra.b	L116
L109
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L111
L110
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L116
L111
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L113
L112
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L116
L113
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L114
L115
L116
	moveq	#0,d0
	move.b	(a0),d0
	and.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L118
L117
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L119
L118
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L119
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fAND_X16(OP_ARGS)
	XDEF	fAND_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fAND_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L120
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(uint16) = OP1_16(uint16) & OP2_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L122
L121
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra.b	L129
L122
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L124
L123
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L129
L124
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L126
L125
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L129
L126
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L127
L128
L129
	moveq	#0,d2
	move.w	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L131
L130
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra.b	L138
L131
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L133
L132
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L138
L133
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L135
L134
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L138
L135
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L136
L137
L138
	moveq	#0,d0
	move.w	(a0),d0
	and.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L140
L139
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra.b	L141
L140
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L141
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fAND_X32(OP_ARGS)
	XDEF	fAND_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fAND_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L142
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(uint32) = OP1_32(uint32) & OP2_32(uint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L144
L143
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L151
L144
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L146
L145
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L151
L146
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L148
L147
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L151
L148
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L149
L150
L151
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L153
L152
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
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
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L160
L157
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L158
L159
L160
	and.l	(a0),d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L162
L161
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L163
L162
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L163
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fAND_X64(OP_ARGS)
	XDEF	fAND_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fAND_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L164
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(uint64) = OP1_64(uint64) & OP2_64(uint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L166
L165
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
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
	bra	L173
L168
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L170
L169
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L173
L170
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L186
	moveq	#-1,d0
L186
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L171
L172
L173
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L175
L174
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L182
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
	bra	L182
L177
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L179
L178
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L182
L179
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L187
	moveq	#-1,d0
L187
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L180
L181
L182
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d4,d0
	move.l	d5,d1
	and.l	d2,d0
	and.l	d3,d1
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L184
L183
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L185
L184
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L185
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fOR_X8(OP_ARGS)
	XDEF	fOR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fOR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L188
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(uint8) = OP1_8(uint8) | OP2_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L190
L189
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L197
L190
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L192
L191
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L197
L192
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L194
L193
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L197
L194
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L195
L196
L197
	moveq	#0,d2
	move.b	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L199
L198
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L206
L199
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L201
L200
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L206
L201
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L203
L202
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L206
L203
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L204
L205
L206
	moveq	#0,d0
	move.b	(a0),d0
	or.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L208
L207
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L209
L208
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L209
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fOR_X16(OP_ARGS)
	XDEF	fOR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fOR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L210
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(uint16) = OP1_16(uint16) | OP2_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L212
L211
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L219
L212
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L214
L213
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L219
L214
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L216
L215
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L219
L216
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L217
L218
L219
	moveq	#0,d2
	move.w	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L221
L220
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L228
L221
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L223
L222
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L228
L223
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L225
L224
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L228
L225
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L226
L227
L228
	moveq	#0,d0
	move.w	(a0),d0
	or.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L230
L229
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L231
L230
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L231
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fOR_X32(OP_ARGS)
	XDEF	fOR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fOR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L232
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(uint32) = OP1_32(uint32) | OP2_32(uint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L234
L233
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L241
L234
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L236
L235
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L241
L236
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L238
L237
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L241
L238
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L239
L240
L241
	move.l	(a0),d2
	move.b	2(a3),d0
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
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L248
L249
L250
	or.l	(a0),d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L252
L251
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L253
L252
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L253
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fOR_X64(OP_ARGS)
	XDEF	fOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L254
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(uint64) = OP1_64(uint64) | OP2_64(uint64);
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
	bpl.b	L276
	moveq	#-1,d0
L276
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L261
L262
L263
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L265
L264
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L272
L265
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L267
L266
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L272
L267
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L269
L268
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L272
L269
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L277
	moveq	#-1,d0
L277
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L270
L271
L272
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d4,d0
	move.l	d5,d1
	or.l	d2,d0
	or.l	d3,d1
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L274
L273
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L275
L274
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L275
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fXOR_X8(OP_ARGS)
	XDEF	fXOR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fXOR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L278
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(uint8) = OP1_8(uint8) ^ OP2_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L280
L279
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L287
L280
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L282
L281
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L287
L282
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L284
L283
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L287
L284
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L285
L286
L287
	moveq	#0,d2
	move.b	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L289
L288
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L296
L289
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L291
L290
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L296
L291
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L293
L292
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L296
L293
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L294
L295
L296
	moveq	#0,d0
	move.b	(a0),d0
	eor.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L298
L297
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L299
L298
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L299
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fXOR_X16(OP_ARGS)
	XDEF	fXOR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fXOR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L300
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(uint16) = OP1_16(uint16) ^ OP2_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L302
L301
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
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
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L309
L306
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L307
L308
L309
	moveq	#0,d2
	move.w	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L311
L310
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L318
L311
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L313
L312
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L318
L313
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L315
L314
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L318
L315
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L316
L317
L318
	moveq	#0,d0
	move.w	(a0),d0
	eor.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L320
L319
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L321
L320
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L321
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fXOR_X32(OP_ARGS)
	XDEF	fXOR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fXOR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L322
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(uint32) = OP1_32(uint32) ^ OP2_32(uint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L324
L323
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L331
L324
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L326
L325
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L331
L326
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L328
L327
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L331
L328
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L329
L330
L331
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L333
L332
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L340
L333
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L335
L334
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L340
L335
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L337
L336
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L340
L337
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L338
L339
L340
	move.l	(a0),d0
	eor.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L342
L341
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L343
L342
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L343
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fXOR_X64(OP_ARGS)
	XDEF	fXOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fXOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L344
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(uint64) = OP1_64(uint64) ^ OP2_64(uint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L346
L345
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L353
L346
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L348
L347
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L353
L348
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L350
L349
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L353
L350
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L366
	moveq	#-1,d0
L366
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L351
L352
L353
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L355
L354
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
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
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L362
L359
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L367
	moveq	#-1,d0
L367
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L360
L361
L362
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d4,d0
	move.l	d5,d1
	eor.l	d2,d0
	eor.l	d3,d1
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L364
L363
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L365
L364
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L365
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fINV_X8(OP_ARGS)
	XDEF	fINV_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fINV_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L368
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(uint8) = ~(OP1_8(uint8));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L370
L369
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L377
L370
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L372
L371
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L377
L372
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L374
L373
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L377
L374
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L375
L376
L377
	moveq	#0,d0
	move.b	(a0),d0
	not.l	d0
	move.b	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L379
L378
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L380
L379
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L380
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fINV_X16(OP_ARGS)
	XDEF	fINV_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fINV_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L381
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(uint16) = ~(OP1_16(uint16));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L383
L382
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L390
L383
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L385
L384
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L390
L385
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L387
L386
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L390
L387
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L388
L389
L390
	moveq	#0,d0
	move.w	(a0),d0
	not.l	d0
	move.w	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L392
L391
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L393
L392
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L393
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fINV_X32(OP_ARGS)
	XDEF	fINV_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fINV_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L394
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(uint32) = ~(OP1_32(uint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L396
L395
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L403
L396
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L398
L397
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L403
L398
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L400
L399
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L403
L400
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L401
L402
L403
	move.l	(a0),d2
	not.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L405
L404
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L406
L405
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L406
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fINV_X64(OP_ARGS)
	XDEF	fINV_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fINV_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L407
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(uint64) = ~(OP1_64(uint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L409
L408
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L416
L409
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L411
L410
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L416
L411
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L413
L412
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L416
L413
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L420
	moveq	#-1,d0
L420
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L414
L415
L416
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d2,d0
	move.l	d3,d1
	not.l	d0
	not.l	d1
	move.l	d0,d2
	move.l	d1,d3
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L418
L417
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L419
L418
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L419
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fSHL_X8(OP_ARGS)
	XDEF	fSHL_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHL_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L421
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(uint8) = OP1_8(uint8) << OP2_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L423
L422
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L430
L423
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L425
L424
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L430
L425
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L427
L426
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L430
L427
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L428
L429
L430
	moveq	#0,d2
	move.b	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L432
L431
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L439
L432
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L434
L433
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L439
L434
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L436
L435
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L439
L436
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L437
L438
L439
	moveq	#0,d0
	move.b	(a0),d0
	asl.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L441
L440
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L442
L441
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L442
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHL_X16(OP_ARGS)
	XDEF	fSHL_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHL_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L443
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(uint16) = OP1_16(uint16) << OP2_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L445
L444
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L452
L445
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L447
L446
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L452
L447
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L449
L448
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L452
L449
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L450
L451
L452
	moveq	#0,d2
	move.w	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L454
L453
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L461
L454
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L456
L455
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L461
L456
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L458
L457
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L461
L458
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L459
L460
L461
	moveq	#0,d0
	move.w	(a0),d0
	asl.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L463
L462
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L464
L463
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L464
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHL_X32(OP_ARGS)
	XDEF	fSHL_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHL_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L465
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(uint32) = OP1_32(uint32) << OP2_32(uint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L467
L466
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L474
L467
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L469
L468
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L474
L469
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L471
L470
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L474
L471
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L472
L473
L474
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L476
L475
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L483
L476
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L478
L477
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L483
L478
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L480
L479
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L483
L480
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L481
L482
L483
	move.l	(a0),d0
	asl.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L485
L484
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L486
L485
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L486
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHR_X8(OP_ARGS)
	XDEF	fSHR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L487
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(uint8) = OP1_8(uint8) >> OP2_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L489
L488
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L496
L489
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L491
L490
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L496
L491
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L493
L492
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L496
L493
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L494
L495
L496
	moveq	#0,d2
	move.b	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L498
L497
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L505
L498
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L500
L499
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L505
L500
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L502
L501
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L505
L502
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L503
L504
L505
	moveq	#0,d0
	move.b	(a0),d0
	asr.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L507
L506
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L508
L507
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L508
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHR_X16(OP_ARGS)
	XDEF	fSHR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L509
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(uint16) = OP1_16(uint16) >> OP2_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L511
L510
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L518
L511
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L513
L512
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L518
L513
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L515
L514
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L518
L515
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L516
L517
L518
	moveq	#0,d2
	move.w	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L520
L519
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L527
L520
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L522
L521
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L527
L522
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L524
L523
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L527
L524
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L525
L526
L527
	moveq	#0,d0
	move.w	(a0),d0
	asr.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L529
L528
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L530
L529
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L530
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHR_X32(OP_ARGS)
	XDEF	fSHR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L531
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(uint32) = OP1_32(uint32) >> OP2_32(uint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L533
L532
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L540
L533
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L535
L534
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L540
L535
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L537
L536
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L540
L537
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L538
L539
L540
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L542
L541
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L549
L542
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L544
L543
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L549
L544
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L546
L545
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L549
L546
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L547
L548
L549
	move.l	(a0),d0
	lsr.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L551
L550
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L552
L551
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L552
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHR_X64(OP_ARGS)
	XDEF	fSHR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L553
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(uint64) = OP1_64(uint64) >> OP2_64(uint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L555
L554
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L562
L555
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L557
L556
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L562
L557
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L559
L558
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L562
L559
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L575
	moveq	#-1,d0
L575
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L560
L561
L562
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L564
L563
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L571
L564
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L566
L565
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L571
L566
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L568
L567
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L571
L568
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L576
	moveq	#-1,d0
L576
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L569
L570
L571
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d4,d0
	move.l	d5,d1
	XREF	lib_64bit_shr
	jsr	lib_64bit_shr
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L573
L572
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L574
L573
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L574
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

	END
