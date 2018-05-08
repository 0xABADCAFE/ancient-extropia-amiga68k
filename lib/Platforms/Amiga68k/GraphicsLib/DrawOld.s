
; Storm C Compiler
; Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/GraphicsLib/DrawOld.cpp
	mc68030
	mc68881
	XREF	_sin__r
	XREF	Delete__xTEXTURE__T
	XREF	Create__xTEXTURE__TsssPvPUj
	XREF	Refresh__xDBSCREEN__T
	XREF	Close__xDBSCREEN__T
	XREF	Open__xDBSCREEN__T
	XREF	Close__xSCREEN__T
	XREF	Open__xSCREEN__T
	XREF	Set__xSCREEN__TP06xDMODEPCc
	XREF	Close__xDBWIN__T
	XREF	Open__xDBWIN__T
	XREF	Set__xDBWIN__TsssssPCc
	XREF	MoveEvent__xDISPLAYIO__T
	XREF	ResizeEvent__xDISPLAYIO__T
	XREF	Idle__xDISPLAYIO__T
	XREF	HandleEvent__xDISPLAYIO__T
	XREF	ApplyInputModification__xDISPLAYIO__T
	XREF	ViewSurface__xDISPLAY__T
	XREF	DrawSurface__xDISPLAY__T
	XREF	Refresh__xDISPLAY__T
	XREF	Close__xDISPLAY__T
	XREF	Open__xDISPLAY__T
	XREF	_0dt__LOCK__T
	XREF	_0dt__THREAD__T
	XREF	Run__THREAD__T
	XREF	_0dt__DELAY__T
	XREF	_0ct__DELAY__T
	XREF	Pause__DELAY__TUj
	XREF	Pause__DELAY__TUjUj
	XREF	Abort__DELAY__T
	XREF	UnLink__xCHAINABLE__T
	XREF	Close__xFILEIO__T
	XREF	Write__xFILEIO__TPvUiUi
	XREF	Read__xFILEIO__TPvUiUi
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
	XREF	_0dt__xSURFACE__T
	XREF	_0dt__POOL_ST__T
	XREF	_0ct__POOL_ST__TUsUj
	XREF	FreeT__POOL_ST__TPv
	XREF	NewT__POOL_ST__TPvUs
	XREF	NewT__POOL_ST__TPv
	XREF	Create__POOL_ST__TUsUj
	XREF	_0dt__POOL_LT__T
	XREF	SetDrawArea__x3D__P08xSURFACEssss
	XREF	FreeContext__x3D_
	XREF	BuildContext__x3D__P08xSURFACEs
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__UisE
	XREF	_system
	XREF	_vsprintf
	XREF	op__delete__PvUi
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
	XREF	_GfxBase
	XREF	_CyberGfxBase
	XREF	_surfaceTypes__x2D
	XREF	_Warp3DBase
	XREF	_hw3D__sys3DDEVICE
	XREF	_context__sys3DDEVICE
	XREF	_drawRegion__x3D
	XREF	_fogData__x3D
	XREF	_flags__x3D
	XREF	_vertices__x3D
	XREF	_currTex__x3D
	XREF	_drawSurface__x3D
	XREF	_currCol__x3D
	XREF	_flags__xGFX
	XREF	_mode__xGFX
	XREF	_numModes__xGFX
	XREF	_rPool__xSURFACE
	XREF	_KeymapBase
	XREF	_useCount__xKEY
	XREF	_TimerBase__MILLICLOCK
	XREF	_current__MILLICLOCK
	XREF	_clockFreq__MILLICLOCK
	XREF	_threadCnt__THREAD
	XREF	_threadsIdle__THREAD
	XREF	_rootThread__THREAD

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_DiskfontBase:1",DATA

	XDEF	_DiskfontBase
_DiskfontBase
	dc.l	0

	SECTION "_fontInfo__xDRAW:0",CODE


L150
	dc.b	'XCourier.font',0
L151
	dc.b	'XHelvetica.font',0
L152
	dc.b	'times.font',0

	SECTION "_fontInfo__xDRAW:1",DATA

	XDEF	_fontInfo__xDRAW
_fontInfo__xDRAW
	dc.l	L150
	dc.w	$D
	dc.b	0,0
	dc.l	L151
	dc.w	$D
	dc.b	0,$20
	dc.l	L151
	dc.w	$D
	dc.b	0,$20
	dc.l	L152
	dc.w	$D
	dc.b	0,$20

	SECTION "_fontData__xDRAW:1",DATA

	XDEF	_fontData__xDRAW
_fontData__xDRAW
	dc.l	0,0,0,0

	SECTION "_flags__xDRAW:1",DATA

	XDEF	_flags__xDRAW
_flags__xDRAW
	dc.l	0

	SECTION "_flushCnt__xDRAW:1",DATA

	XDEF	_flushCnt__xDRAW
_flushCnt__xDRAW
	dc.l	0

	SECTION "_vArray__xDRAW:1",DATA

	XDEF	_vArray__xDRAW
_vArray__xDRAW
	dc.l	0

	SECTION "_vBuffer__xDRAW:1",DATA

	XDEF	_vBuffer__xDRAW
_vBuffer__xDRAW
	dc.l	0

	SECTION "_fault__xDRAW:1",DATA

	XDEF	_fault__xDRAW
_fault__xDRAW
	dc.l	0

	SECTION "_vBufPos__xDRAW:1",DATA

	XDEF	_vBufPos__xDRAW
_vBufPos__xDRAW
	dc.l	0

	SECTION "_vArraySize__xDRAW:1",DATA

	XDEF	_vArraySize__xDRAW
_vArraySize__xDRAW
	dc.l	0

	SECTION "_zDepth__xDRAW:1",DATA

	XDEF	_zDepth__xDRAW
_zDepth__xDRAW
	dc.l	$3FF00000,0

	SECTION "_maxVBufPos__xDRAW:1",DATA

	XDEF	_maxVBufPos__xDRAW
_maxVBufPos__xDRAW
	dc.l	0

	SECTION "_currentCol__xDRAW:1",DATA

	XDEF	_currentCol__xDRAW
_currentCol__xDRAW
	dc.l	-$1000000

	SECTION "_cTab__xDRAW:1",DATA

	XDEF	_cTab__xDRAW
_cTab__xDRAW
	dc.l	0,$3B800000,$3C000000,$3C400000,$3C800000,$3CA00000,$3CC00000,$3CE00000,$3D000000,$3D100000,$3D200000
	dc.l	$3D300000,$3D400000,$3D500000,$3D600000,$3D700000,$3D800000,$3D880000,$3D900000,$3D980000,$3DA00000,$3DA80000
	dc.l	$3DB00000,$3DB80000,$3DC00000,$3DC80000,$3DD00000,$3DD80000,$3DE00000,$3DE80000,$3DF00000,$3DF80000,$3E000000
	dc.l	$3E040000,$3E080000,$3E0C0000,$3E100000,$3E140000,$3E180000,$3E1C0000,$3E200000,$3E240000,$3E280000,$3E2C0000
	dc.l	$3E300000,$3E340000,$3E380000,$3E3C0000,$3E400000,$3E440000,$3E480000,$3E4C0000,$3E500000,$3E540000,$3E580000
	dc.l	$3E5C0000,$3E600000,$3E640000,$3E680000,$3E6C0000,$3E700000,$3E740000,$3E780000,$3E7C0000,$3E800000,$3E820000
	dc.l	$3E840000,$3E860000,$3E880000,$3E8A0000,$3E8C0000,$3E8E0000,$3E900000,$3E920000,$3E940000,$3E960000,$3E980000
	dc.l	$3E9A0000,$3E9C0000,$3E9E0000,$3EA00000,$3EA20000,$3EA40000,$3EA60000,$3EA80000,$3EAA0000,$3EAC0000,$3EAE0000
	dc.l	$3EB00000,$3EB20000,$3EB40000,$3EB60000,$3EB80000,$3EBA0000,$3EBC0000,$3EBE0000,$3EC00000,$3EC20000,$3EC40000
	dc.l	$3EC60000,$3EC80000,$3ECA0000,$3ECC0000,$3ECE0000,$3ED00000,$3ED20000,$3ED40000,$3ED60000,$3ED80000,$3EDA0000
	dc.l	$3EDC0000,$3EDE0000,$3EE00000,$3EE20000,$3EE40000,$3EE60000,$3EE80000,$3EEA0000,$3EEC0000,$3EEE0000,$3EF00000
	dc.l	$3EF20000,$3EF40000,$3EF60000,$3EF80000,$3EFA0000,$3EFC0000,$3EFE0000,$3F000000,$3F010000,$3F020000,$3F030000
	dc.l	$3F040000,$3F050000,$3F060000,$3F070000,$3F080000,$3F090000,$3F0A0000,$3F0B0000,$3F0C0000,$3F0D0000,$3F0E0000
	dc.l	$3F0F0000,$3F100000,$3F110000,$3F120000,$3F130000,$3F140000,$3F150000,$3F160000,$3F170000,$3F180000,$3F190000
	dc.l	$3F1A0000,$3F1B0000,$3F1C0000,$3F1D0000,$3F1E0000,$3F1F0000,$3F200000,$3F210000,$3F220000,$3F230000,$3F240000
	dc.l	$3F250000,$3F260000,$3F270000,$3F280000,$3F290000,$3F2A0000,$3F2B0000,$3F2C0000,$3F2D0000,$3F2E0000,$3F2F0000
	dc.l	$3F300000,$3F310000,$3F320000,$3F330000,$3F340000,$3F350000,$3F360000,$3F370000,$3F380000,$3F390000,$3F3A0000
	dc.l	$3F3B0000,$3F3C0000,$3F3D0000,$3F3E0000,$3F3F0000,$3F400000,$3F410000,$3F420000,$3F430000,$3F440000,$3F450000
	dc.l	$3F460000,$3F470000,$3F480000,$3F490000,$3F4A0000,$3F4B0000,$3F4C0000,$3F4D0000,$3F4E0000,$3F4F0000,$3F500000
	dc.l	$3F510000,$3F520000,$3F530000,$3F540000,$3F550000,$3F560000,$3F570000,$3F580000,$3F590000,$3F5A0000,$3F5B0000
	dc.l	$3F5C0000,$3F5D0000,$3F5E0000,$3F5F0000,$3F600000,$3F610000,$3F620000,$3F630000,$3F640000,$3F650000,$3F660000
	dc.l	$3F670000,$3F680000,$3F690000,$3F6A0000,$3F6B0000,$3F6C0000,$3F6D0000,$3F6E0000,$3F6F0000,$3F700000,$3F710000
	dc.l	$3F720000,$3F730000,$3F740000,$3F750000,$3F760000,$3F770000,$3F780000,$3F790000,$3F7A0000,$3F7B0000,$3F7C0000
	dc.l	$3F7D0000,$3F7E0000,$3F7F0000

	SECTION "_sTab__xDRAW:0",CODE


	XDEF	_INIT_8_DrawOld_cpp__sTab__xDRAW
_INIT_8_DrawOld_cpp__sTab__xDRAW
L166
;float32 xDRAW::sTab[XDRAW_TRIGSIZE+2] = { 0 };
	move.l	#_sTab__xDRAW,a0
	lea	4(a0),a0
	moveq	#$10,d0
L167
	clr.l	(a0)+
	dbra	d0,L167
	rts

	SECTION "_sTab__xDRAW:1",DATA

	XDEF	_sTab__xDRAW
_sTab__xDRAW
	dc.l	0
	ds.b	68

	SECTION "_nestCount__xDRAW:1",DATA

	XDEF	_nestCount__xDRAW
_nestCount__xDRAW
	dc.l	0

	SECTION "Init__xDRAW__Uj:0",CODE


;sint32 xDRAW::Init(uint32 vSize)
	XDEF	Init__xDRAW__Uj
Init__xDRAW__Uj
	movem.l	d2/d3/a6,-(a7)
	move.l	$10(a7),d3
L170
;	if (!DiskfontBase)
	tst.l	_DiskfontBase
	bne.b	L173
L171
;		if (!(DiskfontBase = OpenLibrary("diskfont.library", 39)))
	move.l	_SysBase,a6
	moveq	#$27,d0
	move.l	#L169,a1
	jsr	-$228(a6)
	move.l	d0,_DiskfontBase
	tst.l	_DiskfontBase
	bne.b	L173
L172
;			return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2/d3/a6
	rts
L173
;		fontData[0] = OpenDiskFont(fontInfo);
	move.l	_DiskfontBase,a6
	move.l	#_fontInfo__xDRAW,a0
	jsr	-$1E(a6)
	move.l	#_fontData__xDRAW,a1
	move.l	d0,(a1)
;		fontData[1] = OpenDiskFont(fontInfo+1);
	move.l	#_fontInfo__xDRAW,a1
	move.l	_DiskfontBase,a6
	lea	$8(a1),a0
	jsr	-$1E(a6)
	move.l	#_fontData__xDRAW,a1
	move.l	d0,4(a1)
;		fontData[2] = OpenDiskFont(fontInfo+2);
	move.l	#_fontInfo__xDRAW,a1
	move.l	_DiskfontBase,a6
	lea	$10(a1),a0
	jsr	-$1E(a6)
	move.l	#_fontData__xDRAW,a1
	move.l	d0,$8(a1)
;		fontData[3] = OpenDiskFont(fontInfo+3);
	move.l	#_fontInfo__xDRAW,a1
	move.l	_DiskfontBase,a6
	lea	$18(a1),a0
	jsr	-$1E(a6)
	move.l	#_fontData__xDRAW,a1
	move.l	d0,$C(a1)
;	vArraySize = ClipInt(vSize, 1024, 65536);
	move.l	#$10000,d2
	move.l	#$400,d1
	move.l	d3,d0
	cmp.l	d1,d0
	bge.b	L175
L174
	move.l	d1,d0
	bra.b	L179
L175
	cmp.l	d2,d0
	ble.b	L177
L176
	move.l	d2,d0
L177
L178
L179
	move.l	d0,_vArraySize__xDRAW
;	for (sint32 i = 0;
	moveq	#0,d2
	bra.b	L181
L180
;		sTab[i] = sin(((float64)i*3.1415926536)/(2*XDRAW_TRIGSIZE));
	fmove.l	d2,fp0
	fmul.d	#$.400921FB.20000000,fp0
	fdiv.d	#$.40400000.00000000,fp0
	fmove.d	fp0,-(a7)
	jsr	_sin__r
	addq.w	#$8,a7
	move.l	#_sTab__xDRAW,a1
	fmove.s	fp0,0(a1,d2.l*4)
	addq.l	#1,d2
L181
	cmp.l	#$10,d2
	blt.b	L180
L182
;	sTab[XDRAW_TRIGSIZE]		= 1.0;
	move.l	#_sTab__xDRAW,a1
	move.l	#$3F800000,$40(a1)
;	sTab[XDRAW_TRIGSIZE+1]	= sTab[XDRAW_TRIGSIZE-1];
	move.l	#_sTab__xDRAW,a1
	fmove.s	$3C(a1),fp0
	move.l	#_sTab__xDRAW,a1
	fmove.s	fp0,$44(a1)
;	vBuffer = New(vBuffer, vArraySize);
	move.l	_vArraySize__xDRAW,d2
	clr.l	-(a7)
	clr.w	-(a7)
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	addq.l	#$8,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,a0
	cmp.w	#0,a0
	beq.b	L187
L183
	move.l	d2,(a0)
	move.l	#$40,4(a0)
	addq.w	#$8,a0
	move.l	a0,a1
	move.l	a1,a0
	move.l	d2,d0
	addq.l	#1,d0
	bra.b	L185
L184
	add.w	#$40,a0
L185
	subq.l	#1,d0
	tst.l	d0
	bne.b	L184
L186
	bra.b	L188
L187
	sub.l	a1,a1
L188
	move.l	a1,_vBuffer__xDRAW
;	if (vBuffer==0)
	move.l	_vBuffer__xDRAW,a0
	cmp.w	#0,a0
	bne.b	L190
L189
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a6
	rts
L190
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a6
	rts

L169
	dc.b	'diskfont.library',0

	SECTION "Done__xDRAW_:0",CODE


;sint32 xDRAW::Done()
	XDEF	Done__xDRAW_
Done__xDRAW_
	movem.l	d2/a2/a6,-(a7)
L191
;	FreeContext();
	jsr	FreeContext__x3D_
;	if (vBuffer)
	tst.l	_vBuffer__xDRAW
	beq.b	L199
L192
;		Delete(vBuffer);
	move.l	_vBuffer__xDRAW,a6
	cmp.w	#0,a6
	beq.b	L198
L193
	move.l	a6,d0
	subq.l	#$8,d0
	move.l	d0,a2
	move.l	a2,a0
	move.l	(a0),d2
	addq.l	#1,d2
	bra.b	L196
L194
	move.l	a6,a0
	add.w	#$40,a6
	cmp.w	#0,a0
	beq.b	L196
L195
	pea	$40.w
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L196
	subq.l	#1,d2
	tst.l	d2
	bne.b	L194
L197
	move.l	a2,-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L198
L199
;	vBuffer = 0;
	clr.l	_vBuffer__xDRAW
;	if (DiskfontBase)
	tst.l	_DiskfontBase
	beq.b	L206
L200
;		for (sint32 i=0;
	moveq	#0,d2
	bra.b	L204
L201
;			if (fontData[i]) 
	move.l	#_fontData__xDRAW,a1
	tst.l	0(a1,d2.l*4)
	beq.b	L203
L202
;			if (fontData[i]) CloseFont(fontData[i]);
	move.l	#_fontData__xDRAW,a1
	move.l	_GfxBase,a6
	move.l	0(a1,d2.l*4),a1
	jsr	-$4E(a6)
L203
	addq.l	#1,d2
L204
	cmp.l	#4,d2
	blt.b	L201
L205
;		CloseLibrary(DiskfontBase);
	move.l	_DiskfontBase,a1
	move.l	_SysBase,a6
	jsr	-$19E(a6)
;		DiskfontBase = 0;
	clr.l	_DiskfontBase
L206
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a6
	rts

	SECTION "AllocDepthBuffer__xDRAW_:0",CODE


;sint32 xDRAW::AllocDepthBuffer()
	XDEF	AllocDepthBuffer__xDRAW_
AllocDepthBuffer__xDRAW_
	move.l	a6,-(a7)
L207
;	if (flags & ZBUFFER)
	move.l	_flags__xDRAW,d0
	and.l	#4,d0
	beq.b	L209
L208
;		return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts
L209
;	if (x3D::Context())
	move.l	_context__sys3DDEVICE,a0
	cmp.w	#0,a0
	beq.b	L215
L210
;		uint32 r = W3D_AllocZBuffer(x3D::Context());
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$D8(a6)
;		switch(r)
	cmp.l	#-$17,d0
	beq.b	L213
	bhi.b	L216
	cmp.l	#0,d0
	beq.b	L211
	bra.b	L214
L216
	cmp.l	#-$8,d0
	beq.b	L212
	bra.b	L214
;			
L211
;			case W3D_SUCCESS:		flags |= ZBUFFER;
	or.l	#4,_flags__xDRAW
; return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts
L212
;			case W3D_NOGFXMEM:	return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	move.l	(a7)+,a6
	rts
L213
;			case W3D_NOZBUFFER:	return ERR_RSC_UNAVAIL
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts
L214
;			default:						return ERR_RSC_INVALID;
	move.l	#-$3050008,d0
	move.l	(a7)+,a6
	rts
L215
	move.l	(a7)+,a6
	rts

	SECTION "FreeDepthBuffer__xDRAW_:0",CODE


;sint32 xDRAW::FreeDepthBuffer()
	XDEF	FreeDepthBuffer__xDRAW_
FreeDepthBuffer__xDRAW_
	move.l	a6,-(a7)
L217
;	if (flags & ZBUFFER)
	move.l	_flags__xDRAW,d0
	and.l	#4,d0
	beq.b	L223
L218
;		flags &= ~ZBUFFER;
	and.l	#-5,_flags__xDRAW
;		if (x3D::Context())
	move.l	_context__sys3DDEVICE,a0
	cmp.w	#0,a0
	beq.b	L223
L219
;			uint32 r = W3D_FreeZBuffer(x3D::Context());
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$DE(a6)
;			switch(r)
	cmp.l	#0,d0
	beq.b	L220
	cmp.l	#-$17,d0
	beq.b	L221
	bra.b	L222
;				
L220
;				case W3D_SUCCESS:		return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts
L221
;				case W3D_NOZBUFFER:	return ERR_RSC_UNAVA
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts
L222
;				default:						return ERR_RSC_INVALID;
	move.l	#-$3050008,d0
	move.l	(a7)+,a6
	rts
L223
;	return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

	SECTION "Bind__xDRAW__P08xSURFACE:0",CODE


;sint32 xDRAW::Bind(xSURFACE* s)
	XDEF	Bind__xDRAW__P08xSURFACE
Bind__xDRAW__P08xSURFACE
	movem.l	d2/a2/a6,-(a7)
	move.l	$10(a7),a2
L224
;	if (x3D::Context())
	move.l	_context__sys3DDEVICE,a0
	cmp.w	#0,a0
	beq	L231
L225
;		if (!x3D::DrawSurface() || x3D::DrawSurface()->Format()==s->Form
	tst.l	_drawSurface__x3D
	beq.b	L227
L226
	move.l	_drawSurface__x3D,a0
	move.l	$8(a0),a1
	move.l	a0,d0
	add.l	$14(a1),d0
	move.l	d0,-(a7)
	move.l	$10(a1),a1
	jsr	(a1)
	move.l	d0,d2
	addq.w	#4,a7
	move.l	a2,a0
	move.l	$8(a0),a1
	move.l	a0,d0
	add.l	$14(a1),d0
	move.l	d0,-(a7)
	move.l	$10(a1),a1
	jsr	(a1)
	addq.w	#4,a7
	cmp.l	d0,d2
	bne.b	L228
L227
;			W3D_Flush(x3D::Context());
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
;			x3D::SetDrawArea(s, 0, 0, s->Width(), s->Height());
	move.l	a2,a0
	move.l	$8(a0),a1
	move.l	a0,d0
	add.l	$24(a1),d0
	move.l	d0,-(a7)
	move.l	$20(a1),a1
	jsr	(a1)
	addq.w	#4,a7
	move.w	d0,-(a7)
	move.l	a2,a0
	move.l	$8(a0),a1
	move.l	a0,d0
	add.l	$2C(a1),d0
	move.l	d0,-(a7)
	move.l	$28(a1),a1
	jsr	(a1)
	addq.w	#4,a7
	move.w	d0,-(a7)
	clr.w	-(a7)
	clr.w	-(a7)
	move.l	a2,-(a7)
	jsr	SetDrawArea__x3D__P08xSURFACEssss
	add.w	#$C,a7
;			return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L228
;			FreeContext();
	jsr	FreeContext__x3D_
;			if (BuildContext(s,true)==OK)
	move.w	#1,-(a7)
	move.l	a2,-(a7)
	jsr	BuildContext__x3D__P08xSURFACEs
	addq.w	#6,a7
	tst.l	d0
	bne.b	L230
L229
;				return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L230
;				return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L231
;		if (BuildContext(s, true)==OK)
	move.w	#1,-(a7)
	move.l	a2,-(a7)
	jsr	BuildContext__x3D__P08xSURFACEs
	addq.w	#6,a7
	tst.l	d0
	bne.b	L233
L232
;			return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L233
;			return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2/a2/a6
	rts

	SECTION "Release__xDRAW_:0",CODE


;sint32 xDRAW::Release()
	XDEF	Release__xDRAW_
Release__xDRAW_
	movem.l	a2/a6,-(a7)
L234
;	if (x3D::Context())
	move.l	_context__sys3DDEVICE,a0
	cmp.w	#0,a0
	beq.b	L238
L235
;		if (x3D::DrawSurface())
	move.l	_drawSurface__x3D,a0
	cmp.w	#0,a0
	beq.b	L237
L236
;			W3D_Flush(x3D::Context());
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
L237
;		W3D_FreeAllTexObj(x3D::Context());
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$17A(a6)
;		x3D::FreeDrawArea();
	clr.l	_drawRegion__x3D+4
	clr.l	_drawRegion__x3D
	clr.l	_drawRegion__x3D+$8
	clr.l	_drawRegion__x3D+$C
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	moveq	#0,d1
	sub.l	a1,a1
	move.l	#_drawRegion__x3D,a2
	jsr	-$C0(a6)
L238
;	flushCnt = maxVBufPos = 0;
	clr.l	_maxVBufPos__xDRAW
	move.l	_maxVBufPos__xDRAW,_flushCnt__xDRAW
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "SimpleText__xDRAW__UjUjPce:0",CODE


;void xDRAW::SimpleText(ICOORD2D c, uint32 font, char* text,...)
	XDEF	SimpleText__xDRAW__UjUjPce
SimpleText__xDRAW__UjUjPce
L246	EQU	-$8
	link	a5,#L246
	movem.l	d2-d4/a6,-(a7)
	movem.l	$8(a5),d3/d4
L239
;	if (!x3D::DrawSurface() || !x3D::DrawSurface()->rPort || !text)
	tst.l	_drawSurface__x3D
	beq.b	L242
L240
	move.l	_drawSurface__x3D,a0
	tst.l	$C(a0)
	beq.b	L242
L241
	tst.l	$10(a5)
	bne.b	L243
L242
;		return;
	movem.l	(a7)+,d2-d4/a6
	unlk	a5
	rts
L243
;	va_start(arglist,text)
	lea	$10(a5),a0
	move.l	a0,d0
	addq.l	#4,d0
;	sint32 n = vsprintf(textBuffer,text,arglist);
	move.l	d0,-(a7)
	move.l	$10(a5),-(a7)
	move.l	#_textBuffer__SimpleText__xDRAW__UjUjPce,-(a7)
	jsr	_vsprintf
	add.w	#$C,a7
	move.l	d0,d2
;	if (n<0)
	bpl.b	L245
L244
;		return;
	movem.l	(a7)+,d2-d4/a6
	unlk	a5
	rts
L245
;	::SetFont(x3D::DrawSurface()->rPort, fontData[font]);
	move.l	#_fontData__xDRAW,a1
	move.l	0(a1,d4.l*4),a0
	move.l	_drawSurface__x3D,a1
	move.l	_GfxBase,a6
	move.l	$C(a1),a1
	jsr	-$42(a6)
;	::Move(x3D::DrawSurface()->rPort, CoordX(c), CoordY(c));
	move.l	d3,d1
	and.l	#$FFFF,d1
	ext.l	d1
	move.l	d3,d0
	moveq	#$10,d3
	asr.l	d3,d0
	ext.l	d0
	move.l	_drawSurface__x3D,a0
	move.l	_GfxBase,a6
	move.l	$C(a0),a1
	jsr	-$F0(a6)
;	::Text(x3D::DrawSurface()->rPort, textBuffer, n);
	move.l	_drawSurface__x3D,a0
	move.l	$C(a0),a1
	move.l	_GfxBase,a6
	move.l	d2,d0
	move.l	#_textBuffer__SimpleText__xDRAW__UjUjPce,a0
	jsr	-$3C(a6)
	movem.l	(a7)+,d2-d4/a6
	unlk	a5
	rts

	SECTION "SimpleText__xDRAW__UjUjPce:2",BSS

_textBuffer__SimpleText__xDRAW__UjUjPce
	ds.b	256

	END
