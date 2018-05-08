
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/JasmineArithmetic.cpp
	mc68030
	mc68881
	XREF	_fmod__r
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


;void JASMINE_OP::fADD_I8(OP_ARGS)
	XDEF	fADD_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fADD_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L130
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(sint8) = OP1_8(sint8) + OP2_8(sint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L132
L131
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L139
L132
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L134
L133
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L139
L134
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L136
L135
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L139
L136
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L137
L138
L139
	move.b	(a0),d2
	extb.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L141
L140
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L148
L141
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L143
L142
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L148
L143
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L145
L144
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L148
L145
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L146
L147
L148
	move.b	(a0),d0
	extb.l	d0
	add.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L150
L149
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra.b	L151
L150
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L151
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fADD_I16(OP_ARGS)
	XDEF	fADD_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fADD_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L152
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(sint16) = OP1_16(sint16) + OP2_16(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L154
L153
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra.b	L161
L154
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L156
L155
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L161
L156
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L158
L157
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L161
L158
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L159
L160
L161
	move.w	(a0),d2
	ext.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L163
L162
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra.b	L170
L163
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L165
L164
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L170
L165
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L167
L166
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L170
L167
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L168
L169
L170
	move.w	(a0),d0
	ext.l	d0
	add.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L172
L171
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra.b	L173
L172
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L173
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fADD_I32(OP_ARGS)
	XDEF	fADD_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fADD_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L174
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(sint32) = OP1_32(sint32) + OP2_32(sint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L176
L175
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L183
L176
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L178
L177
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L183
L178
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L180
L179
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L183
L180
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L181
L182
L183
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L185
L184
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L192
L185
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L187
L186
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra.b	L192
L187
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L189
L188
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L192
L189
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L190
L191
L192
	add.l	(a0),d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L194
L193
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra.b	L195
L194
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L195
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fADD_I64(OP_ARGS)
	XDEF	fADD_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fADD_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L196
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(sint64) = OP1_64(sint64) + OP2_64(sint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L198
L197
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L205
L198
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L200
L199
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L205
L200
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L202
L201
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra.b	L205
L202
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L218
	moveq	#-1,d0
L218
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L203
L204
L205
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L207
L206
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L214
L207
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L209
L208
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L214
L209
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L211
L210
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L214
L211
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L219
	moveq	#-1,d0
L219
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L212
L213
L214
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d4,d0
	move.l	d5,d1
	XREF	Add64
	jsr	Add64
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L216
L215
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra.b	L217
L216
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L217
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fADD_F32(OP_ARGS)
	XDEF	fADD_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fADD_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L220
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(float32) = OP1_32(float32) + OP2_32(float32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L222
L221
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L229
L222
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge.b	L224
L223
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L229
L224
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge.b	L226
L225
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L229
L226
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L227
L228
L229
	fmove.s	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge.b	L231
L230
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L238
L231
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L233
L232
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L238
L233
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L235
L234
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L238
L235
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L236
L237
L238
	fmove.s	(a0),fp0
	fadd.x	fp0,fp2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L240
L239
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L241
L240
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L241
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fADD_F64(OP_ARGS)
	XDEF	fADD_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fADD_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L242
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(float64) = OP1_64(float64) + OP2_64(float64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L244
L243
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L251
L244
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L246
L245
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L251
L246
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L248
L247
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L251
L248
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L264
	moveq	#-1,d0
L264
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L249
L250
L251
	fmove.d	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L253
L252
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L260
L253
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L255
L254
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L260
L255
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L257
L256
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L260
L257
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L265
	moveq	#-1,d0
L265
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L258
L259
L260
	fmove.d	(a0),fp0
	fadd.x	fp0,fp2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L262
L261
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L263
L262
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L263
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSUB_I8(OP_ARGS)
	XDEF	fSUB_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSUB_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L266
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(sint8) = OP1_8(sint8) - OP2_8(sint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L268
L267
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L275
L268
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L270
L269
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L275
L270
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L272
L271
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L275
L272
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L273
L274
L275
	move.b	(a0),d2
	extb.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L277
L276
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L284
L277
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L279
L278
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L284
L279
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L281
L280
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L284
L281
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L282
L283
L284
	move.b	(a0),d0
	extb.l	d0
	sub.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L286
L285
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L287
L286
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L287
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSUB_I16(OP_ARGS)
	XDEF	fSUB_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSUB_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L288
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(sint16) = OP1_16(sint16) - OP2_16(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L290
L289
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L297
L290
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L292
L291
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L297
L292
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L294
L293
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L297
L294
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L295
L296
L297
	move.w	(a0),d2
	ext.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L299
L298
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
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
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L306
L303
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L304
L305
L306
	move.w	(a0),d0
	ext.l	d0
	sub.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L308
L307
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L309
L308
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L309
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSUB_I32(OP_ARGS)
	XDEF	fSUB_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSUB_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L310
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(sint32) = OP1_32(sint32) - OP2_32(sint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L312
L311
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L319
L312
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L314
L313
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L319
L314
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L316
L315
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L319
L316
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L317
L318
L319
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L321
L320
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L328
L321
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L323
L322
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L328
L323
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L325
L324
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L328
L325
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L326
L327
L328
	sub.l	(a0),d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L330
L329
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L331
L330
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L331
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSUB_I64(OP_ARGS)
	XDEF	fSUB_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSUB_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L332
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(sint64) = OP1_64(sint64) - OP2_64(sint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L334
L333
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L341
L334
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L336
L335
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L341
L336
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L338
L337
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L341
L338
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L354
	moveq	#-1,d0
L354
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L339
L340
L341
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L343
L342
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L350
L343
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L345
L344
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L350
L345
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L347
L346
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L350
L347
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl.b	L355
	moveq	#-1,d0
L355
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L348
L349
L350
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d4,d0
	move.l	d5,d1
	XREF	Sub64
	jsr	Sub64
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L352
L351
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L353
L352
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L353
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fSUB_F32(OP_ARGS)
	XDEF	fSUB_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSUB_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L356
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(float32) = OP1_32(float32) - OP2_32(float32);
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
	fmove.s	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L367
L366
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L374
L367
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L369
L368
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L374
L369
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L371
L370
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L374
L371
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L372
L373
L374
	fmove.s	(a0),fp0
	fsub.x	fp0,fp2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L376
L375
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L377
L376
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L377
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fSUB_F64(OP_ARGS)
	XDEF	fSUB_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSUB_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L378
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(float64) = OP1_64(float64) - OP2_64(float64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L380
L379
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L387
L380
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L382
L381
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L387
L382
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L384
L383
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L387
L384
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L400
	moveq	#-1,d0
L400
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L385
L386
L387
	fmove.d	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L389
L388
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L396
L389
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L391
L390
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L396
L391
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L393
L392
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L396
L393
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L401
	moveq	#-1,d0
L401
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L394
L395
L396
	fmove.d	(a0),fp0
	fsub.x	fp0,fp2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L398
L397
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L399
L398
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L399
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMUL_I8(OP_ARGS)
	XDEF	fMUL_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L402
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(sint8) = OP1_8(sint8) * OP2_8(sint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L404
L403
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L411
L404
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L406
L405
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L411
L406
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L408
L407
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L411
L408
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L409
L410
L411
	move.b	(a0),d2
	ext.w	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L413
L412
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L420
L413
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L415
L414
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L420
L415
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L417
L416
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L420
L417
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L418
L419
L420
	move.b	(a0),d0
	ext.w	d0
	muls	d2,d0
	move.b	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L422
L421
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L423
L422
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L423
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMUL_I16(OP_ARGS)
	XDEF	fMUL_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L424
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(sint16) = OP1_16(sint16) * OP2_16(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L426
L425
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L433
L426
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L428
L427
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L433
L428
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L430
L429
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L433
L430
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L431
L432
L433
	move.w	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L435
L434
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L442
L435
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L437
L436
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L442
L437
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L439
L438
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L442
L439
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L440
L441
L442
	move.w	(a0),d0
	muls	d2,d0
	move.w	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L444
L443
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L445
L444
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L445
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMUL_I32(OP_ARGS)
	XDEF	fMUL_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L446
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(sint32) = OP1_32(sint32) * OP2_32(sint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L448
L447
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L455
L448
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L450
L449
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L455
L450
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L452
L451
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L455
L452
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L453
L454
L455
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L457
L456
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L464
L457
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L459
L458
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L464
L459
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L461
L460
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L464
L461
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L462
L463
L464
	muls.l	(a0),d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L466
L465
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L467
L466
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L467
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMUL_I64(OP_ARGS)
	XDEF	fMUL_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L468
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(sint64) = OP1_64(sint64) * OP2_64(sint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L470
L469
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L477
L470
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L472
L471
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L477
L472
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L474
L473
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L477
L474
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L490
	moveq	#-1,d0
L490
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L475
L476
L477
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L479
L478
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L486
L479
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L481
L480
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L486
L481
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L483
L482
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L486
L483
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L491
	moveq	#-1,d0
L491
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L484
L485
L486
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d4,d0
	move.l	d5,d1
	XREF	SMult64
	jsr	SMult64
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L488
L487
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L489
L488
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L489
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fMUL_F32(OP_ARGS)
	XDEF	fMUL_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L492
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(float32) = OP1_32(float32) * OP2_32(float32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L494
L493
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L501
L494
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L496
L495
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L501
L496
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L498
L497
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L501
L498
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L499
L500
L501
	fmove.s	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L503
L502
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L510
L503
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L505
L504
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L510
L505
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L507
L506
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L510
L507
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L508
L509
L510
	fmove.s	(a0),fp0
	fmul.x	fp0,fp2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L512
L511
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L513
L512
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L513
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fMUL_F64(OP_ARGS)
	XDEF	fMUL_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L514
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(float64) = OP1_64(float64) * OP2_64(float64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L516
L515
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L523
L516
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L518
L517
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L523
L518
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L520
L519
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L523
L520
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L536
	moveq	#-1,d0
L536
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L521
L522
L523
	fmove.d	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L525
L524
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L532
L525
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L527
L526
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L532
L527
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L529
L528
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L532
L529
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L537
	moveq	#-1,d0
L537
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L530
L531
L532
	fmove.d	(a0),fp0
	fmul.x	fp0,fp2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L534
L533
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L535
L534
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L535
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fDIV_I8(OP_ARGS)
	XDEF	fDIV_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L538
;	OPINIT()
	move.l	$110(a2),a3
;	sint8 d = OP1_8(sint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L540
L539
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L547
L540
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L542
L541
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L547
L542
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L544
L543
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L547
L544
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L545
L546
L547
	move.b	(a0),d2
;	if (d)
	beq	L561
L548
;		OP3_8(sint8) = OP1_8(sint8) / d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L550
L549
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L557
L550
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L552
L551
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L557
L552
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L554
L553
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L557
L554
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L555
L556
L557
	move.b	(a0),d0
	ext.w	d0
	ext.l	d0
	move.b	d2,d1
	ext.w	d1
	divs	d1,d0
	ext.l	d0
	move.b	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L559
L558
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L560
L559
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L560
	move.b	d2,(a0)
	bra	L562
L561
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L562
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fDIV_I16(OP_ARGS)
	XDEF	fDIV_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L563
;	OPINIT()
	move.l	$110(a2),a3
;	sint16 d = OP1_16(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L565
L564
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L572
L565
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L567
L566
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L572
L567
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L569
L568
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L572
L569
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L570
L571
L572
	move.w	(a0),d2
;	if (d)
	beq	L586
L573
;		OP3_16(sint16) = OP1_16(sint16) / d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L575
L574
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L582
L575
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L577
L576
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L582
L577
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L579
L578
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L582
L579
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L580
L581
L582
	move.w	(a0),d0
	ext.l	d0
	divs	d2,d0
	ext.l	d0
	move.w	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L584
L583
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L585
L584
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L585
	move.w	d2,(a0)
	bra	L587
L586
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L587
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fDIV_I32(OP_ARGS)
	XDEF	fDIV_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L588
;	OPINIT()
	move.l	$110(a2),a3
;	sint32 d = OP1_32(sint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L590
L589
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L597
L590
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L592
L591
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L597
L592
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L594
L593
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L597
L594
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L595
L596
L597
	move.l	(a0),d3
;	if (d)
	beq	L611
L598
;		OP3_32(sint32) = OP1_32(sint32) / d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L600
L599
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L607
L600
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L602
L601
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L607
L602
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L604
L603
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L607
L604
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L605
L606
L607
	move.l	(a0),d2
	divsl.l	d3,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L609
L608
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L610
L609
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L610
	move.l	d2,(a0)
	bra	L612
L611
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L612
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fDIV_I64(OP_ARGS)
	XDEF	fDIV_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L613
;	OPINIT()
	move.l	$110(a2),a3
;	sint64 d = OP1_64(sint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L615
L614
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L622
L615
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L617
L616
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L622
L617
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L619
L618
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L622
L619
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L638
	moveq	#-1,d0
L638
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L620
L621
L622
	move.l	(a0),d4
	move.l	4(a0),d5
;	if (d)
	move.l	d4,d0
	move.l	d5,d1
	or.l	d0,d1
	beq	L636
L623
;		OP3_64(sint64) = OP1_64(sint64) / d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L625
L624
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L632
L625
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L627
L626
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L632
L627
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L629
L628
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L632
L629
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L639
	moveq	#-1,d0
L639
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L630
L631
L632
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d4,d2
	move.l	d5,d3
	XREF	SDiv64
	jsr	SDiv64
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L634
L633
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L635
L634
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L635
	move.l	d2,(a0)
	move.l	d3,4(a0)
	bra	L637
L636
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L637
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fDIV_F32(OP_ARGS)
	XDEF	fDIV_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L640
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(float32) = OP1_32(float32) / OP2_32(float32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L642
L641
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L649
L642
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L644
L643
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L649
L644
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L646
L645
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L649
L646
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L647
L648
L649
	fmove.s	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L651
L650
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L658
L651
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L653
L652
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L658
L653
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L655
L654
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L658
L655
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L656
L657
L658
	fmove.s	(a0),fp0
	fdiv.x	fp0,fp2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L660
L659
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L661
L660
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L661
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fDIV_F64(OP_ARGS)
	XDEF	fDIV_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L662
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(float64) = OP1_64(float64) / OP2_64(float64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L664
L663
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L671
L664
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L666
L665
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L671
L666
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L668
L667
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L671
L668
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L684
	moveq	#-1,d0
L684
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L669
L670
L671
	fmove.d	(a0),fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L673
L672
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L680
L673
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L675
L674
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L680
L675
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L677
L676
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L680
L677
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L685
	moveq	#-1,d0
L685
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L678
L679
L680
	fmove.d	(a0),fp0
	fdiv.x	fp0,fp2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L682
L681
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L683
L682
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L683
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMOD_I8(OP_ARGS)
	XDEF	fMOD_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L686
;	OPINIT()
	move.l	$110(a2),a3
;	sint8 d = OP1_8(sint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L688
L687
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L695
L688
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L690
L689
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L695
L690
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L692
L691
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L695
L692
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L693
L694
L695
	move.b	(a0),d2
;	if (d)
	beq	L709
L696
;		OP3_8(sint8) = OP1_8(sint8) % d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L698
L697
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L705
L698
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L700
L699
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L705
L700
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L702
L701
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L705
L702
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L703
L704
L705
	move.b	(a0),d0
	ext.w	d0
	ext.l	d0
	move.b	d2,d1
	ext.w	d1
	divs	d1,d0
	swap	d0
	ext.l	d0
	move.b	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L707
L706
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L708
L707
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L708
	move.b	d2,(a0)
	bra	L710
L709
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L710
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMOD_I16(OP_ARGS)
	XDEF	fMOD_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L711
;	OPINIT()
	move.l	$110(a2),a3
;	sint16 d = OP1_16(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L713
L712
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L720
L713
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L715
L714
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L720
L715
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L717
L716
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L720
L717
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L718
L719
L720
	move.w	(a0),d2
;	if (d)
	beq	L734
L721
;		OP3_16(sint16) = OP1_16(sint16) % d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L723
L722
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L730
L723
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L725
L724
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L730
L725
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L727
L726
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L730
L727
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L728
L729
L730
	move.w	(a0),d0
	ext.l	d0
	divs	d2,d0
	swap	d0
	ext.l	d0
	move.w	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L732
L731
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L733
L732
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L733
	move.w	d2,(a0)
	bra	L735
L734
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L735
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMOD_I32(OP_ARGS)
	XDEF	fMOD_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L736
;	OPINIT()
	move.l	$110(a2),a3
;	sint32 d = OP1_32(sint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L738
L737
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L745
L738
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L740
L739
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L745
L740
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L742
L741
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L745
L742
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L743
L744
L745
	move.l	(a0),d3
;	if (d)
	beq	L759
L746
;		OP3_32(sint32) = OP1_32(sint32) % d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L748
L747
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L755
L748
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L750
L749
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L755
L750
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L752
L751
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L755
L752
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L753
L754
L755
	move.l	(a0),d2
	divsl.l	d3,d0:d2
	move.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L757
L756
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L758
L757
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L758
	move.l	d2,(a0)
	bra	L760
L759
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L760
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fMOD_I64(OP_ARGS)
	XDEF	fMOD_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L761
;	OPINIT()
	move.l	$110(a2),a3
;	sint64 d = OP1_64(sint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L763
L762
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L770
L763
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L765
L764
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L770
L765
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L767
L766
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L770
L767
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L786
	moveq	#-1,d0
L786
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L768
L769
L770
	move.l	(a0),d4
	move.l	4(a0),d5
;	if (d)
	move.l	d4,d0
	move.l	d5,d1
	or.l	d0,d1
	beq	L784
L771
;		OP3_64(sint64) = OP1_64(sint64) % d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L773
L772
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L780
L773
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L775
L774
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L780
L775
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L777
L776
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L780
L777
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L787
	moveq	#-1,d0
L787
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L778
L779
L780
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d4,d2
	move.l	d5,d3
	XREF	SMod64
	jsr	SMod64
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L782
L781
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L783
L782
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L783
	move.l	d2,(a0)
	move.l	d3,4(a0)
	bra	L785
L784
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L785
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fMOD_F32(OP_ARGS)
	XDEF	fMOD_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L788
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(float32) = (float32) fmod(OP1_32(float32), OP
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L790
L789
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L797
L790
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L792
L791
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L797
L792
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L794
L793
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L797
L794
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L795
L796
L797
	fmove.s	(a0),fp0
	fmove.d	fp0,-(a7)
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L799
L798
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L806
L799
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L801
L800
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L806
L801
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L803
L802
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L806
L803
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L804
L805
L806
	fmove.s	(a0),fp0
	fmove.d	fp0,-(a7)
	jsr	_fmod__r
	add.w	#$10,a7
	fmove.x	fp0,fp2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L808
L807
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L809
L808
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L809
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fMOD_F64(OP_ARGS)
	XDEF	fMOD_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L810
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(float64) = fmod(OP1_64(float64), OP2_64(float
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L812
L811
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L819
L812
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L814
L813
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L819
L814
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L816
L815
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L819
L816
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L832
	moveq	#-1,d0
L832
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L817
L818
L819
	fmove.d	(a0),fp0
	fmove.d	fp0,-(a7)
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L821
L820
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L828
L821
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L823
L822
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L828
L823
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L825
L824
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L828
L825
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L833
	moveq	#-1,d0
L833
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L826
L827
L828
	fmove.d	(a0),fp0
	fmove.d	fp0,-(a7)
	jsr	_fmod__r
	fmove.x	fp0,fp2
	add.w	#$10,a7
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L830
L829
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L831
L830
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L831
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMUL_U8(OP_ARGS)
	XDEF	fMUL_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L834
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(uint8) = OP1_8(uint8) * OP2_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L836
L835
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L843
L836
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L838
L837
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L843
L838
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L840
L839
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L843
L840
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L841
L842
L843
	moveq	#0,d2
	move.b	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L845
L844
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L852
L845
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L847
L846
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L852
L847
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L849
L848
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L852
L849
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L850
L851
L852
	moveq	#0,d0
	move.b	(a0),d0
	mulu	d2,d0
	move.b	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L854
L853
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L855
L854
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L855
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMUL_U16(OP_ARGS)
	XDEF	fMUL_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L856
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(uint16) = OP1_16(uint16) * OP2_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L858
L857
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L865
L858
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L860
L859
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L865
L860
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L862
L861
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L865
L862
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L863
L864
L865
	move.w	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L867
L866
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L874
L867
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L869
L868
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L874
L869
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L871
L870
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L874
L871
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L872
L873
L874
	move.w	(a0),d0
	mulu	d2,d0
	move.w	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L876
L875
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L877
L876
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L877
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMUL_U32(OP_ARGS)
	XDEF	fMUL_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L878
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(uint32) = OP1_32(uint32) * OP2_32(uint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L880
L879
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L887
L880
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L882
L881
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L887
L882
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L884
L883
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L887
L884
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L885
L886
L887
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L889
L888
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L896
L889
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L891
L890
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L896
L891
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L893
L892
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L896
L893
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L894
L895
L896
	mulu.l	(a0),d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L898
L897
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L899
L898
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L899
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMUL_U64(OP_ARGS)
	XDEF	fMUL_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMUL_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L900
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(uint64) = OP1_64(uint64) * OP2_64(uint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L902
L901
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L909
L902
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L904
L903
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L909
L904
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L906
L905
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L909
L906
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L922
	moveq	#-1,d0
L922
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L907
L908
L909
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L911
L910
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L918
L911
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L913
L912
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L918
L913
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L915
L914
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L918
L915
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L923
	moveq	#-1,d0
L923
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L916
L917
L918
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d4,d0
	move.l	d5,d1
	XREF	UMult64
	jsr	UMult64
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L920
L919
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L921
L920
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L921
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fDIV_U8(OP_ARGS)
	XDEF	fDIV_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L924
;	OPINIT()
	move.l	$110(a2),a3
;	uint8 d = OP1_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L926
L925
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L933
L926
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L928
L927
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L933
L928
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L930
L929
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L933
L930
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L931
L932
L933
	move.b	(a0),d2
;	if (d)
	beq	L947
L934
;		OP3_8(uint8) = OP1_8(uint8) / d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L936
L935
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L943
L936
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L938
L937
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L943
L938
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L940
L939
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L943
L940
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L941
L942
L943
	moveq	#0,d0
	move.b	(a0),d0
	and.l	#$FFFF,d0
	moveq	#0,d1
	move.b	d2,d1
	divu	d1,d0
	and.l	#$FFFF,d0
	move.b	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L945
L944
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L946
L945
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L946
	move.b	d2,(a0)
	bra	L948
L947
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L948
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fDIV_U16(OP_ARGS)
	XDEF	fDIV_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L949
;	OPINIT()
	move.l	$110(a2),a3
;	uint16 d = OP1_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L951
L950
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L958
L951
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L953
L952
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L958
L953
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L955
L954
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L958
L955
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L956
L957
L958
	move.w	(a0),d2
;	if (d)
	beq	L972
L959
;		OP3_16(uint16) = OP1_16(uint16) / d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L961
L960
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L968
L961
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L963
L962
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L968
L963
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L965
L964
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L968
L965
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L966
L967
L968
	moveq	#0,d0
	move.w	(a0),d0
	divu	d2,d0
	and.l	#$FFFF,d0
	move.w	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L970
L969
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L971
L970
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L971
	move.w	d2,(a0)
	bra	L973
L972
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L973
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fDIV_U32(OP_ARGS)
	XDEF	fDIV_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L974
;	OPINIT()
	move.l	$110(a2),a3
;	uint32 d = OP1_32(uint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L976
L975
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L983
L976
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L978
L977
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L983
L978
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L980
L979
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L983
L980
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L981
L982
L983
	move.l	(a0),d3
;	if (d)
	beq	L997
L984
;		OP3_32(uint32) = OP1_32(uint32) / d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L986
L985
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L993
L986
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L988
L987
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L993
L988
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L990
L989
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L993
L990
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L991
L992
L993
	move.l	(a0),d2
	divul.l	d3,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L995
L994
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L996
L995
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L996
	move.l	d2,(a0)
	bra	L998
L997
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L998
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fDIV_U64(OP_ARGS)
	XDEF	fDIV_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fDIV_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L999
;	OPINIT()
	move.l	$110(a2),a3
;	uint64 d = OP1_64(uint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1001
L1000
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1008
L1001
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1003
L1002
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1008
L1003
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1005
L1004
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1008
L1005
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1024
	moveq	#-1,d0
L1024
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L1006
L1007
L1008
	move.l	(a0),d4
	move.l	4(a0),d5
;	if (d)
	move.l	d4,d0
	move.l	d5,d1
	or.l	d0,d1
	beq	L1022
L1009
;		OP3_64(uint64) = OP1_64(uint64) / d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1011
L1010
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1018
L1011
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1013
L1012
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1018
L1013
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1015
L1014
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1018
L1015
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1025
	moveq	#-1,d0
L1025
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L1016
L1017
L1018
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d4,d2
	move.l	d5,d3
	XREF	UDiv64
	jsr	UDiv64
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1020
L1019
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1021
L1020
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L1021
	move.l	d2,(a0)
	move.l	d3,4(a0)
	bra	L1023
L1022
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L1023
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fMOD_U8(OP_ARGS)
	XDEF	fMOD_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1026
;	OPINIT()
	move.l	$110(a2),a3
;	uint8 d = OP1_8(uint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1028
L1027
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1035
L1028
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1030
L1029
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1035
L1030
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1032
L1031
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1035
L1032
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L1033
L1034
L1035
	move.b	(a0),d2
;	if (d)
	beq	L1049
L1036
;		OP3_8(uint8) = OP1_8(uint8) % d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1038
L1037
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1045
L1038
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1040
L1039
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1045
L1040
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1042
L1041
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1045
L1042
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L1043
L1044
L1045
	moveq	#0,d0
	move.b	(a0),d0
	and.l	#$FFFF,d0
	moveq	#0,d1
	move.b	d2,d1
	divu	d1,d0
	swap	d0
	and.l	#$FFFF,d0
	move.b	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1047
L1046
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1048
L1047
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L1048
	move.b	d2,(a0)
	bra	L1050
L1049
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L1050
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMOD_U16(OP_ARGS)
	XDEF	fMOD_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1051
;	OPINIT()
	move.l	$110(a2),a3
;	uint16 d = OP1_16(uint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1053
L1052
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1060
L1053
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1055
L1054
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1060
L1055
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1057
L1056
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1060
L1057
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L1058
L1059
L1060
	move.w	(a0),d2
;	if (d)
	beq	L1074
L1061
;		OP3_16(uint16) = OP1_16(uint16) % d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1063
L1062
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1070
L1063
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1065
L1064
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1070
L1065
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1067
L1066
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1070
L1067
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L1068
L1069
L1070
	moveq	#0,d0
	move.w	(a0),d0
	divu	d2,d0
	swap	d0
	and.l	#$FFFF,d0
	move.w	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1072
L1071
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1073
L1072
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L1073
	move.w	d2,(a0)
	bra	L1075
L1074
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L1075
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fMOD_U32(OP_ARGS)
	XDEF	fMOD_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L1076
;	OPINIT()
	move.l	$110(a2),a3
;	uint32 d = OP1_32(uint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1078
L1077
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1085
L1078
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1080
L1079
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1085
L1080
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1082
L1081
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1085
L1082
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L1083
L1084
L1085
	move.l	(a0),d3
;	if (d)
	beq	L1099
L1086
;		OP3_32(uint32) = OP1_32(uint32) % d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1088
L1087
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1095
L1088
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1090
L1089
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1095
L1090
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1092
L1091
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1095
L1092
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L1093
L1094
L1095
	move.l	(a0),d2
	divul.l	d3,d0:d2
	move.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1097
L1096
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1098
L1097
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L1098
	move.l	d2,(a0)
	bra	L1100
L1099
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L1100
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fMOD_U64(OP_ARGS)
	XDEF	fMOD_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fMOD_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L1101
;	OPINIT()
	move.l	$110(a2),a3
;	uint64 d = OP1_64(uint64);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1103
L1102
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1110
L1103
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1105
L1104
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1110
L1105
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1107
L1106
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1110
L1107
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1126
	moveq	#-1,d0
L1126
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L1108
L1109
L1110
	move.l	(a0),d4
	move.l	4(a0),d5
;	if (d)
	move.l	d4,d0
	move.l	d5,d1
	or.l	d0,d1
	beq	L1124
L1111
;		OP3_64(uint64) = OP1_64(uint64) % d;
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1113
L1112
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1120
L1113
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1115
L1114
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1120
L1115
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1117
L1116
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1120
L1117
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1127
	moveq	#-1,d0
L1127
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L1118
L1119
L1120
	move.l	(a0),d0
	move.l	4(a0),d1
	move.l	d4,d2
	move.l	d5,d3
	XREF	UMod64
	jsr	UMod64
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1122
L1121
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1123
L1122
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L1123
	move.l	d2,(a0)
	move.l	d3,4(a0)
	bra	L1125
L1124
;		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	move.l	#3,$134(a2)
L1125
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fNEG_I8(OP_ARGS)
	XDEF	fNEG_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fNEG_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1128
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_8(sint8) = -(OP1_8(sint8));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1130
L1129
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1137
L1130
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1132
L1131
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1137
L1132
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1134
L1133
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1137
L1134
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L1135
L1136
L1137
	move.b	(a0),d0
	extb.l	d0
	neg.l	d0
	move.b	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1139
L1138
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1140
L1139
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L1140
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fNEG_I16(OP_ARGS)
	XDEF	fNEG_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fNEG_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1141
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_16(sint16) = -(OP1_16(sint16));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1143
L1142
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1150
L1143
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1145
L1144
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1150
L1145
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1147
L1146
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1150
L1147
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L1148
L1149
L1150
	move.w	(a0),d0
	ext.l	d0
	neg.l	d0
	move.w	d0,d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1152
L1151
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1153
L1152
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L1153
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fNEG_I32(OP_ARGS)
	XDEF	fNEG_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fNEG_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1154
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(sint32) = -(OP1_32(sint32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1156
L1155
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1163
L1156
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1158
L1157
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1163
L1158
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1160
L1159
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1163
L1160
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L1161
L1162
L1163
	move.l	(a0),d2
	neg.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1165
L1164
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1166
L1165
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L1166
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fNEG_I64(OP_ARGS)
	XDEF	fNEG_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fNEG_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d3/d7/a3/a6,-(a7)
	move.l	a3,a6
L1167
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(sint64) = -(OP1_64(sint64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1169
L1168
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1176
L1169
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1171
L1170
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1176
L1171
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1173
L1172
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1176
L1173
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1180
	moveq	#-1,d0
L1180
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L1174
L1175
L1176
	move.l	(a0),d2
	move.l	4(a0),d3
	move.l	d2,d0
	move.l	d3,d1
	XREF	Neg64
	jsr	Neg64
	move.l	d0,d2
	move.l	d1,d3
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1178
L1177
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1179
L1178
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L1179
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d3/d7/a3/a6
	rts

;void JASMINE_OP::fNEG_F32(OP_ARGS)
	XDEF	fNEG_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fNEG_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L1181
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_32(float32) = -(OP1_32(float32));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1183
L1182
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1190
L1183
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1185
L1184
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1190
L1185
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1187
L1186
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1190
L1187
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L1188
L1189
L1190
	fmove.s	(a0),fp2
	fneg.s	fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1192
L1191
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1193
L1192
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L1193
	fmove.s	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d7/a3/a6
	rts

;void JASMINE_OP::fNEG_F64(OP_ARGS)
	XDEF	fNEG_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fNEG_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	a3,a6
L1194
;	OPINIT()
	move.l	$110(a2),a3
;	OP2D_64(float64) = -(OP1_64(float64));
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1196
L1195
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1203
L1196
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1198
L1197
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1203
L1198
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1200
L1199
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1203
L1200
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1207
	moveq	#-1,d0
L1207
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L1201
L1202
L1203
	fmove.d	(a0),fp2
	fneg.d	fp2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1205
L1204
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1206
L1205
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L1206
	fmove.d	fp2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHL_I8(OP_ARGS)
	XDEF	fSHL_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHL_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1208
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(sint8) = OP1_8(sint8) << OP2_8(sint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1210
L1209
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1217
L1210
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1212
L1211
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1217
L1212
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1214
L1213
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1217
L1214
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L1215
L1216
L1217
	move.b	(a0),d2
	extb.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1219
L1218
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1226
L1219
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1221
L1220
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1226
L1221
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1223
L1222
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1226
L1223
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L1224
L1225
L1226
	move.b	(a0),d0
	extb.l	d0
	asl.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1228
L1227
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1229
L1228
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L1229
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHL_I16(OP_ARGS)
	XDEF	fSHL_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHL_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1230
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(sint16) = OP1_16(sint16) << OP2_16(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1232
L1231
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1239
L1232
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1234
L1233
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1239
L1234
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1236
L1235
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1239
L1236
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L1237
L1238
L1239
	move.w	(a0),d2
	ext.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1241
L1240
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1248
L1241
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1243
L1242
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1248
L1243
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1245
L1244
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1248
L1245
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L1246
L1247
L1248
	move.w	(a0),d0
	ext.l	d0
	asl.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1250
L1249
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1251
L1250
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L1251
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHL_I32(OP_ARGS)
	XDEF	fSHL_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHL_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1252
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(sint32) = OP1_32(sint32) << OP2_32(sint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1254
L1253
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1261
L1254
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1256
L1255
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1261
L1256
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1258
L1257
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1261
L1258
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L1259
L1260
L1261
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1263
L1262
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1270
L1263
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1265
L1264
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1270
L1265
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1267
L1266
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1270
L1267
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L1268
L1269
L1270
	move.l	(a0),d0
	asl.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1272
L1271
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1273
L1272
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L1273
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHL_I64(OP_ARGS)
	XDEF	fSHL_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHL_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L1274
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(sint64) = OP1_64(sint64) << OP2_64(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1276
L1275
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1283
L1276
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1278
L1277
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1283
L1278
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1280
L1279
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1283
L1280
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1296
	moveq	#-1,d0
L1296
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L1281
L1282
L1283
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1285
L1284
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1292
L1285
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1287
L1286
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1292
L1287
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1289
L1288
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1292
L1289
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1297
	moveq	#-1,d0
L1297
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L1290
L1291
L1292
	move.w	(a0),d2
	ext.l	d2
	move.l	d2,d3
	moveq	#0,d2
	tst.l	d3
	bpl	L1298
	moveq	#-1,d2
L1298
	move.l	d4,d0
	move.l	d5,d1
	XREF	lib_64bit_shl
	jsr	lib_64bit_shl
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1294
L1293
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1295
L1294
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L1295
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

;void JASMINE_OP::fSHR_I8(OP_ARGS)
	XDEF	fSHR_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHR_I8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1299
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_8(sint8) = OP1_8(sint8) >> OP2_8(sint8);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1301
L1300
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1308
L1301
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1303
L1302
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1308
L1303
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1305
L1304
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1308
L1305
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	addq.w	#7,a0
L1306
L1307
L1308
	move.b	(a0),d2
	extb.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1310
L1309
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1317
L1310
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1312
L1311
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1317
L1312
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1314
L1313
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1317
L1314
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.b	d0,7(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#7,a0
L1315
L1316
L1317
	move.b	(a0),d0
	extb.l	d0
	asr.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1319
L1318
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#7,a0
	bra	L1320
L1319
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#1,d7
	jsr	(a0)
	move.l	d0,a0
L1320
	move.b	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHR_I16(OP_ARGS)
	XDEF	fSHR_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHR_I16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1321
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_16(sint16) = OP1_16(sint16) >> OP2_16(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1323
L1322
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1330
L1323
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1325
L1324
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1330
L1325
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1327
L1326
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1330
L1327
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	addq.w	#6,a0
L1328
L1329
L1330
	move.w	(a0),d2
	ext.l	d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1332
L1331
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1339
L1332
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1334
L1333
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1339
L1334
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1336
L1335
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1339
L1336
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.w	d0,6(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#6,a0
L1337
L1338
L1339
	move.w	(a0),d0
	ext.l	d0
	asr.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1341
L1340
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#6,a0
	bra	L1342
L1341
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#2,d7
	jsr	(a0)
	move.l	d0,a0
L1342
	move.w	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHR_I32(OP_ARGS)
	XDEF	fSHR_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHR_I32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2/d7/a3/a6,-(a7)
	move.l	a3,a6
L1343
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_32(sint32) = OP1_32(sint32) >> OP2_32(sint32);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1345
L1344
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1352
L1345
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1347
L1346
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1352
L1347
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1349
L1348
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1352
L1349
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	addq.w	#4,a0
L1350
L1351
L1352
	move.l	(a0),d2
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1354
L1353
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1361
L1354
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1356
L1355
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1361
L1356
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1358
L1357
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1361
L1358
	and.l	#$FF,d0
	sub.l	#$E0,d0
	lea	$100(a2),a0
	lea	$8(a0),a0
	move.l	d0,4(a0)
	lea	$100(a2),a0
	lea	$8(a0),a0
	addq.w	#4,a0
L1359
L1360
L1361
	move.l	(a0),d0
	asr.l	d0,d2
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1363
L1362
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	addq.w	#4,a0
	bra	L1364
L1363
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#4,d7
	jsr	(a0)
	move.l	d0,a0
L1364
	move.l	d2,(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2/d7/a3/a6
	rts

;void JASMINE_OP::fSHR_I64(OP_ARGS)
	XDEF	fSHR_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
fSHR_I64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	movem.l	d2-d5/d7/a3/a6,-(a7)
	move.l	a3,a6
L1365
;	OPINIT()
	move.l	$110(a2),a3
;	OP3_64(sint64) = OP1_64(sint64) >> OP2_64(sint16);
	move.b	1(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1367
L1366
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1374
L1367
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1369
L1368
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1374
L1369
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1371
L1370
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1374
L1371
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1387
	moveq	#-1,d0
L1387
	move.l	d0,$100(a2)
	move.l	d1,$104(a2)
	lea	$100(a2),a0
L1372
L1373
L1374
	move.l	(a0),d4
	move.l	4(a0),d5
	move.b	2(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1376
L1375
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1383
L1376
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$40,d1
	bge	L1378
L1377
	and.l	#$FF,d0
	lea	-$100(a2),a0
	lea	0(a0,d0.l*8),a0
	move.l	4(a0),a0
	bra	L1383
L1378
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$E0,d1
	bge	L1380
L1379
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
	bra	L1383
L1380
	and.l	#$FF,d0
	sub.l	#$E0,d0
	move.l	d0,d1
	moveq	#0,d0
	tst.l	d1
	bpl	L1388
	moveq	#-1,d0
L1388
	lea	$100(a2),a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
	lea	$100(a2),a0
	addq.w	#$8,a0
L1381
L1382
L1383
	move.w	(a0),d2
	ext.l	d2
	move.l	d2,d3
	moveq	#0,d2
	tst.l	d3
	bpl	L1389
	moveq	#-1,d2
L1389
	move.l	d4,d0
	move.l	d5,d1
	XREF	lib_64bit_shrS
	jsr	lib_64bit_shrS
	move.l	d0,d2
	move.l	d1,d3
	move.b	3(a3),d0
	moveq	#0,d1
	move.b	d0,d1
	cmp.l	#$20,d1
	bge	L1385
L1384
	and.l	#$FF,d0
	lea	0(a2,d0.l*8),a0
	bra	L1386
L1385
	and.l	#$FF,d0
	move.l	0(a6,d0.l*4),a0
	moveq	#$8,d7
	jsr	(a0)
	move.l	d0,a0
L1386
	move.l	d2,(a0)
	move.l	d3,4(a0)
;	OPDONE();
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	movem.l	(a7)+,d2-d5/d7/a3/a6
	rts

	END
