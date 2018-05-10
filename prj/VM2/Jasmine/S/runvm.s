
; Storm C Compiler
; Mendoza:Developer/eXtropia/prj/VM2/Jasmine/runvm.cpp
	mc68030
	mc68881
	XREF	_0dt__JASMINEOBJECT__T
	XREF	_0ct__JASMINEOBJECT__T
	XREF	ListMethods__JASMINEOBJECT__T
	XREF	ReadBody__JASMINEOBJECT__TR05XSFIO
	XREF	WriteBody__JASMINEOBJECT__TR05XSFIO
	XREF	_0ct__XSFOBJ__T
	XREF	Read__XSFOBJ__TR05XSFIO
	XREF	Open__XSFBASIC__TPCcsjj
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
	XREF	_0ct__JASMINE__T
	XREF	Execute__JASMINE__TR13JASMINEOBJECT
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
	XREF	Done__xBASELIB_
	XREF	Init__xBASELIB_
	XREF	_memset
	XREF	_system
	XREF	_printf
	XREF	_puts
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


;int main(int argc, char** argv)
	XDEF	main__iPPc
main__iPPc
L127	EQU	-$2BC
	link	a5,#L127
	movem.l	d2-d4/a2/a3,-(a7)
	movem.l	$8(a5),d2/a3
L110
;	if (xBASELIB::Init()!=OK)
	jsr	Init__xBASELIB_
	tst.l	d0
	beq.b	L112
L111
;		puts("Error initializing base library");
	move.l	#L104,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		return 10;
	moveq	#$A,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L112
;	if (argc != 2)
	cmp.l	#2,d2
	beq.b	L114
L113
;		puts("Usage : jasmine <object file>");
	move.l	#L105,-(a7)
	jsr	_puts
	addq.w	#4,a7
;		xBASELIB::Done();
	jsr	Done__xBASELIB_
;		return 5;
	moveq	#5,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L114
;	JASMINE test;
	move.l	#_0virttab__07JASMINE__07JASMINE,-4(a5)
	pea	-$164(a5)
	jsr	_0ct__JASMINE__T
	addq.w	#4,a7
;	XSFBASIC objFile("VMCODE", 1, 0, (XA_ALIGN32|X_ENDIAN|X_N
	move.l	#_0virttab__08XSFBASIC__08XSFBASIC,-$212(a5)
	lea	-$212(a5),a2
	lea	4(a2),a0
	move.b	#1,(a0)
	clr.b	1(a0)
	clr.b	-(a7)
	move.b	#2,-(a7)
	move.b	#1,-(a7)
	clr.b	-(a7)
	move.l	#L106,-(a7)
	move.l	a0,-(a7)
	jsr	Set__XSFHEAD__TPCcUcUcUcUc
	add.w	#$10,a7
	lea	$10(a2),a0
	clr.l	(a0)
	clr.l	$96(a0)
	clr.l	$AA(a2)
;	objFile.Open(argv[1]);
	pea	$400.w
	pea	1.w
	clr.w	-(a7)
	move.l	4(a3),-(a7)
	pea	-$212(a5)
	jsr	Open__XSFBASIC__TPCcsjj
	add.w	#$12,a7
;	if (objFile.Valid())
	lea	-$212(a5),a0
	cmp.w	#0,a0
	beq.b	L116
L115
	add.w	#$10,a0
L116
	move.l	$96(a0),d0
	and.l	#$40,d0
	tst.w	d0
	beq	L123
L117
;		JASMINEOBJECT program;
	move.l	#_0virttab__13JASMINEOBJECT__13JASMINEOBJECT,-$282(a5)
	pea	-$29E(a5)
	jsr	_0ct__JASMINEOBJECT__T
	addq.w	#4,a7
;		if (program.Read(objFile) > 0)
	pea	-$212(a5)
	pea	-$29E(a5)
	jsr	Read__XSFOBJ__TR05XSFIO
	addq.w	#$8,a7
	cmp.l	#0,d0
	ble.b	L119
L118
;			printf("Loaded program '%s'\n", argv[1]);
	move.l	4(a3),-(a7)
	move.l	#L107,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;			program.ListMethods();
	pea	-$29E(a5)
	jsr	ListMethods__JASMINEOBJECT__T
	addq.w	#4,a7
;			test.Execute(program);
	pea	-$29E(a5)
	pea	-$164(a5)
	jsr	Execute__JASMINE__TR13JASMINEOBJECT
	addq.w	#$8,a7
	bra.b	L120
L119
;			printf("Unable to execute '%s'\n", argv[1]);
	move.l	4(a3),-(a7)
	move.l	#L108,-(a7)
	jsr	_printf
	addq.w	#$8,a7
L120
;		objFile.Close();
	lea	-$212(a5),a0
	clr.l	$AA(a0)
	cmp.w	#0,a0
	beq.b	L122
L121
	add.w	#$10,a0
L122
	move.l	a0,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	pea	-$29E(a5)
	jsr	_0dt__JASMINEOBJECT__T
	addq.w	#4,a7
	bra.b	L124
L123
;		printf("Unable to open '%s'\n", argv[1]);
	move.l	4(a3),-(a7)
	move.l	#L109,-(a7)
	jsr	_printf
	addq.w	#$8,a7
L124
;	xBASELIB::Done();
	jsr	Done__xBASELIB_
	lea	-$212(a5),a0
	move.l	a0,a2
	move.l	a2,a0
	clr.l	$AA(a0)
	cmp.w	#0,a0
	beq.b	L126
L125
	add.w	#$10,a0
L126
	move.l	a0,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	pea	$10(a2)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	pea	-$164(a5)
	jsr	_0dt__JASMINE__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts

	XDEF	ReadyForRead__XSFOBJ__T
ReadyForRead__XSFOBJ__T
L128
	moveq	#0,d0
	rts

	XDEF	ReadyForWrite__XSFOBJ__T
ReadyForWrite__XSFOBJ__T
L129
	moveq	#0,d0
	rts

	XDEF	_0dt__XSFBASIC__T
_0dt__XSFBASIC__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L130
	move.l	a2,a0
	clr.l	$AA(a0)
	cmp.w	#0,a0
	beq.b	L132
L131
	add.w	#$10,a0
L132
	move.l	a0,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	pea	$10(a2)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
	move.l	(a7)+,a2
	rts

	XDEF	FileOptions__XSFBASIC__T
FileOptions__XSFBASIC__T
	move.l	4(a7),a0
L133
	cmp.w	#0,a0
	beq.b	L135
L134
	addq.w	#4,a0
L135
	move.b	$B(a0),d0
	rts

	XDEF	DataFormat__XSFBASIC__T
DataFormat__XSFBASIC__T
	move.l	4(a7),a0
L136
	cmp.w	#0,a0
	beq.b	L138
L137
	addq.w	#4,a0
L138
	move.b	$A(a0),d0
	rts

	XDEF	Size__XSFBASIC__T
Size__XSFBASIC__T
	move.l	4(a7),a0
L139
	cmp.w	#0,a0
	beq.b	L141
L140
	add.w	#$10,a0
L141
	move.l	$96(a0),d0
	and.l	#5,d0
	beq.b	L143
L142
	move.l	4(a0),d0
	bra.b	L144
L143
	move.l	#-$3040000,d0
L144
	rts

	XDEF	Tell__XSFBASIC__T
Tell__XSFBASIC__T
	move.l	4(a7),a0
L145
	cmp.w	#0,a0
	beq.b	L147
L146
	add.w	#$10,a0
L147
	move.l	a0,-(a7)
	jsr	Tell__xFILEIO__T
	addq.w	#4,a7
	rts

	XDEF	Seek__XSFBASIC__Tjj
Seek__XSFBASIC__Tjj
	movem.l	$8(a7),d0/d1
	move.l	4(a7),a0
L148
	move.l	d1,-(a7)
	move.l	d0,-(a7)
	cmp.w	#0,a0
	beq.b	L150
L149
	add.w	#$10,a0
L150
	move.l	a0,-(a7)
	jsr	Seek__xFILEIO__Tjj
	add.w	#$C,a7
	rts

	XDEF	StartOfFile__XSFBASIC__T
StartOfFile__XSFBASIC__T
	move.l	4(a7),a0
L151
	cmp.w	#0,a0
	beq.b	L153
L152
	add.w	#$10,a0
L153
	move.l	$96(a0),d0
	and.l	#$20,d0
	rts

	XDEF	EndOfFile__XSFBASIC__T
EndOfFile__XSFBASIC__T
	move.l	4(a7),a0
L154
	cmp.w	#0,a0
	beq.b	L156
L155
	add.w	#$10,a0
L156
	move.l	$96(a0),d0
	and.l	#$10,d0
	rts

	XDEF	Valid__XSFBASIC__T
Valid__XSFBASIC__T
	move.l	4(a7),a0
L157
	cmp.w	#0,a0
	beq.b	L159
L158
	add.w	#$10,a0
L159
	move.l	$96(a0),d0
	and.l	#$40,d0
	rts

	XDEF	Write64__XSFBASIC__TPvUi
Write64__XSFBASIC__TPvUi
	move.l	d2,-(a7)
	move.l	$10(a7),d1
	move.l	$8(a7),a0
	move.l	$C(a7),a1
L160
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L164
L161
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L163
L162
	add.w	#$10,a0
L163
	move.l	a0,-(a7)
	jsr	Write64Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L167
L164
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L166
L165
	add.w	#$10,a0
L166
	move.l	d0,-(a7)
	pea	$8.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
L167
	move.l	(a7)+,d2
	rts

	XDEF	Write32__XSFBASIC__TPvUi
Write32__XSFBASIC__TPvUi
	move.l	d2,-(a7)
	move.l	$10(a7),d1
	move.l	$8(a7),a0
	move.l	$C(a7),a1
L168
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L172
L169
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L171
L170
	add.w	#$10,a0
L171
	move.l	a0,-(a7)
	jsr	Write32Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L175
L172
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L174
L173
	add.w	#$10,a0
L174
	move.l	d0,-(a7)
	pea	4.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
L175
	move.l	(a7)+,d2
	rts

	XDEF	Write16__XSFBASIC__TPvUi
Write16__XSFBASIC__TPvUi
	move.l	d2,-(a7)
	move.l	$10(a7),d1
	move.l	$8(a7),a0
	move.l	$C(a7),a1
L176
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L180
L177
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L179
L178
	add.w	#$10,a0
L179
	move.l	a0,-(a7)
	jsr	Write16Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L183
L180
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L182
L181
	add.w	#$10,a0
L182
	move.l	d0,-(a7)
	pea	2.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
L183
	move.l	(a7)+,d2
	rts

	XDEF	Write8__XSFBASIC__TPvUi
Write8__XSFBASIC__TPvUi
	move.l	$C(a7),d0
	move.l	4(a7),a0
	move.l	$8(a7),a1
L184
	cmp.w	#0,a0
	beq.b	L186
L185
	add.w	#$10,a0
L186
	move.l	d0,-(a7)
	pea	1.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	rts

	XDEF	Read64__XSFBASIC__TPvUi
Read64__XSFBASIC__TPvUi
	move.l	d2,-(a7)
	move.l	$10(a7),d1
	move.l	$8(a7),a0
	move.l	$C(a7),a1
L187
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L191
L188
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L190
L189
	add.w	#$10,a0
L190
	move.l	a0,-(a7)
	jsr	Read64Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L194
L191
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L193
L192
	add.w	#$10,a0
L193
	move.l	d0,-(a7)
	pea	$8.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
L194
	move.l	(a7)+,d2
	rts

	XDEF	Read32__XSFBASIC__TPvUi
Read32__XSFBASIC__TPvUi
	move.l	d2,-(a7)
	move.l	$10(a7),d1
	move.l	$8(a7),a0
	move.l	$C(a7),a1
L195
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L199
L196
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L198
L197
	add.w	#$10,a0
L198
	move.l	a0,-(a7)
	jsr	Read32Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L202
L199
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L201
L200
	add.w	#$10,a0
L201
	move.l	d0,-(a7)
	pea	4.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
L202
	move.l	(a7)+,d2
	rts

	XDEF	Read16__XSFBASIC__TPvUi
Read16__XSFBASIC__TPvUi
	move.l	d2,-(a7)
	move.l	$10(a7),d1
	move.l	$8(a7),a0
	move.l	$C(a7),a1
L203
	move.l	$AA(a0),d0
	and.l	#$400,d0
	beq.b	L207
L204
	move.l	d1,-(a7)
	move.l	a1,-(a7)
	cmp.w	#0,a0
	beq.b	L206
L205
	add.w	#$10,a0
L206
	move.l	a0,-(a7)
	jsr	Read16Swap__xFILEIO__TPvUi
	add.w	#$C,a7
	bra.b	L210
L207
	move.l	d1,d0
	cmp.w	#0,a0
	beq.b	L209
L208
	add.w	#$10,a0
L209
	move.l	d0,-(a7)
	pea	2.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
L210
	move.l	(a7)+,d2
	rts

	XDEF	Read8__XSFBASIC__TPvUi
Read8__XSFBASIC__TPvUi
	move.l	$C(a7),d0
	move.l	4(a7),a0
	move.l	$8(a7),a1
L211
	cmp.w	#0,a0
	beq.b	L213
L212
	add.w	#$10,a0
L213
	move.l	d0,-(a7)
	pea	1.w
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	jsr	Read__xFILEIO__TPvUiUi
	add.w	#$10,a7
	rts

L104
	dc.b	'Error initializing base library',0
L107
	dc.b	'Loaded program '%s'',$A,0
L108
	dc.b	'Unable to execute '%s'',$A,0
L109
	dc.b	'Unable to open '%s'',$A,0
L105
	dc.b	'Usage : jasmine <object file>',0
L106
	dc.b	'VMCODE',0

	SECTION "_0virttab__07JASMINE__07JASMINE:0",CODE

	XDEF	_0virttab__07JASMINE__07JASMINE
_0virttab__07JASMINE__07JASMINE
	dc.l	$164,0
	dc.l	_0dt__JASMINE__T,0

	SECTION "_0virttab__08XSFBASIC__08XSFBASIC:0",CODE

	XDEF	_0virttab__08XSFBASIC__08XSFBASIC
_0virttab__08XSFBASIC__08XSFBASIC
	dc.l	$AE,0
	dc.l	_0dt__XSFBASIC__T,0
	dc.l	FileOptions__XSFBASIC__T,0
	dc.l	DataFormat__XSFBASIC__T,0
	dc.l	Size__XSFBASIC__T,0
	dc.l	Tell__XSFBASIC__T,0
	dc.l	Seek__XSFBASIC__Tjj,0
	dc.l	StartOfFile__XSFBASIC__T,0
	dc.l	EndOfFile__XSFBASIC__T,0
	dc.l	Valid__XSFBASIC__T,0
	dc.l	Write64__XSFBASIC__TPvUi,0
	dc.l	Write32__XSFBASIC__TPvUi,0
	dc.l	Write16__XSFBASIC__TPvUi,0
	dc.l	Write8__XSFBASIC__TPvUi,0
	dc.l	Read64__XSFBASIC__TPvUi,0
	dc.l	Read32__XSFBASIC__TPvUi,0
	dc.l	Read16__XSFBASIC__TPvUi,0
	dc.l	Read8__XSFBASIC__TPvUi,0
	dc.l	$AE,0
	dc.l	_0dt__XSFBASIC__T,0
	dc.l	FileOptions__XSFBASIC__T,0
	dc.l	DataFormat__XSFBASIC__T,0
	dc.l	Size__XSFBASIC__T,0
	dc.l	Tell__XSFBASIC__T,0
	dc.l	Seek__XSFBASIC__Tjj,0
	dc.l	StartOfFile__XSFBASIC__T,0
	dc.l	EndOfFile__XSFBASIC__T,0
	dc.l	Valid__XSFBASIC__T,0
	dc.l	Write64__XSFBASIC__TPvUi,0
	dc.l	Write32__XSFBASIC__TPvUi,0
	dc.l	Write16__XSFBASIC__TPvUi,0
	dc.l	Write8__XSFBASIC__TPvUi,0
	dc.l	Read64__XSFBASIC__TPvUi,0
	dc.l	Read32__XSFBASIC__TPvUi,0
	dc.l	Read16__XSFBASIC__TPvUi,0
	dc.l	Read8__XSFBASIC__TPvUi,0

	SECTION "_0virttab__13JASMINEOBJECT__13JASMINEOBJECT:0",CODE

	XDEF	_0virttab__13JASMINEOBJECT__13JASMINEOBJECT
_0virttab__13JASMINEOBJECT__13JASMINEOBJECT
	dc.l	$8C,0
	dc.l	_0dt__JASMINEOBJECT__T,0
	dc.l	ReadBody__JASMINEOBJECT__TR05XSFIO,0
	dc.l	WriteBody__JASMINEOBJECT__TR05XSFIO,0
	dc.l	ReadyForRead__XSFOBJ__T,0
	dc.l	ReadyForWrite__XSFOBJ__T,0
	dc.l	$8C,0
	dc.l	_0dt__JASMINEOBJECT__T,0
	dc.l	ReadBody__JASMINEOBJECT__TR05XSFIO,0
	dc.l	WriteBody__JASMINEOBJECT__TR05XSFIO,0

	END
