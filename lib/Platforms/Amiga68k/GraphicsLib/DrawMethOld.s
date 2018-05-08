
; Storm C Compiler
; Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/GraphicsLib/DrawMethOld.cpp
	mc68030
	mc68881
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
	XREF	_DiskfontBase
	XREF	_fontInfo__xDRAW
	XREF	_fontData__xDRAW
	XREF	_flags__xDRAW
	XREF	_flushCnt__xDRAW
	XREF	_cTab__xDRAW
	XREF	_sTab__xDRAW
	XREF	_fault__xDRAW
	XREF	_vBufPos__xDRAW
	XREF	_zDepth__xDRAW
	XREF	_maxVBufPos__xDRAW
	XREF	_vArraySize__xDRAW
	XREF	_vArray__xDRAW
	XREF	_vBuffer__xDRAW
	XREF	_nestCount__xDRAW
	XREF	_currentCol__xDRAW

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "Line__xDRAW__UjUjUj:0",CODE


;void xDRAW::Line(ruint32 col, RICOORD2D p1, RICOORD2D p2)
	XDEF	Line__xDRAW__UjUjUj
Line__xDRAW__UjUjUj
L184	EQU	-$A0
	link	a5,#L184
	movem.l	d2-d5/a2/a6,-(a7)
	movem.l	$8(a5),d0/d4
	move.l	$10(a5),d3
L181
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d0
	beq.b	L183
L182
;		currentCol = col;
	move.l	d0,_currentCol__xDRAW
;		SetColour(col);
	lea	-$A0(a5),a0
	move.l	d0,d1
	move.l	#$FF0000,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$10,d5
	lsr.l	d5,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$8,d5
	lsr.l	d5,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$18,d2
	asl.l	d2,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$A0(a5),a1
	jsr	-$168(a6)
L183
;	W3D_Line lin = {0};
	lea	-$90(a5),a0
	clr.l	(a0)+
	moveq	#$E,d0
L185
	clr.l	(a0)+
	dbra	d0,L185
	lea	$40(a0),a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
;		register sysVERTEX* v = &lin.v1;
	lea	-$90(a5),a0
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		VTX_X(v)=CoordX(p1);
	move.l	d4,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,(a0)
;	VTX_Y(v)=CoordY(p1);
	move.l	d4,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a0)
;	VTX_Z(v++)=d;
	move.l	a0,a1
	add.w	#$40,a0
	fmove.d	fp0,$8(a1)
;		VTX_X(v)=CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,(a0)
;	VTX_Y(v)=CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	fmove.d	fp0,$8(a0)
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		W3D_DrawLine(x3D::Context(), &lin);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$90(a5),a1
	jsr	-$96(a6)
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "LineShA__xDRAW__r14PUjUjUj:0",CODE


;void xDRAW::LineShA(ruint32* col, RICOORD2D p1, RICOORD2D p2)
	XDEF	LineShA__xDRAW__r14PUjUjUj
LineShA__xDRAW__r14PUjUjUj
L187	EQU	-$A4
	link	a5,#L187
	movem.l	d2-d5/a2/a6,-(a7)
	movem.l	$8(a5),d0/d1
L186
;	W3D_Line lin = {0};
	lea	-$90(a5),a0
	clr.l	(a0)+
	moveq	#$E,d2
L188
	clr.l	(a0)+
	dbra	d2,L188
	lea	$40(a0),a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
;	register sysVERTEX* v = &lin.v1;
	lea	-$90(a5),a1
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		VTX_X(v)=CoordX(p1);
	move.l	d0,d2
	moveq	#$10,d3
	asr.l	d3,d2
	ext.l	d2
	fmove.l	d2,fp1
	fmove.s	fp1,(a1)
;	VTX_Y(v)=CoordY(p1);
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a1)
;	VTX_Z(v++)=d;
	move.l	a1,a0
	add.w	#$40,a1
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=CoordX(p2);
	move.l	d1,d0
	moveq	#$10,d2
	asr.l	d2,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,(a1)
;	VTX_Y(v)=CoordY(p2);
	move.l	d1,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a1)
;	VTX_Z(v)=d;
	fmove.d	fp0,$8(a1)
;		p1 = *(col++);
	move.l	(a6)+,d0
;	p2 = 8;
	moveq	#$8,d1
;		ruint32 b = p1;
	move.l	d0,d3
; p1 >>= p2;
	lsr.l	d1,d0
;		ruint32 g = p1;
	move.l	d0,d2
; p1 >>= p2;
	lsr.l	d1,d0
;		ruint32 r = p1;
	move.l	d0,d4
; p1 >>= p2;
	lsr.l	d1,d0
;		ruint32 a = cTab[(p1)];
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d0.l*4),d5
;		p2 = 0x000000FF;
	move.l	#$FF,d1
; r = cTab[(r&p2)];
	and.l	d1,d4
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d4.l*4),d4
; g = cTab[(g&p2)];
	and.l	d1,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),d2
; b = cTab[(b&p2)];
	and.l	d1,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),d3
;		WRITECOLOUR(VTX_C(v))
	lea	$20(a1),a0
;		WRITECOLOUR(VTX_C(v))
	move.l	d4,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d2,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d3,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d5,(a0)
;		p1 = *col;
	move.l	(a6),d0
; p2 = 8;
	moveq	#$8,d1
;		b = p1;
	move.l	d0,d3
; p1 >>= p2;
	lsr.l	d1,d0
;		g = p1;
	move.l	d0,d2
; p1 >>= p2;
	lsr.l	d1,d0
;		p2 = 0x000000FF;
	move.l	#$FF,d1
; r = cTab[(p1&p2)];
	and.l	d1,d0
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d0.l*4),d4
; g = cTab[(g&p2)];
	and.l	d1,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),d2
; b = cTab[(b&p2)];
	and.l	d1,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),d3
;		WRITECOLOUR(VTX_C(v+1))
	lea	$40(a1),a0
	add.w	#$20,a0
;		WRITECOLOUR(VTX_C(v+1))
	move.l	d4,(a0)+
;		WRITECOLOUR(VTX_C(v+1))
	move.l	d2,(a0)+
;		WRITECOLOUR(VTX_C(v+1))
	move.l	d3,(a0)+
;		WRITECOLOUR(VTX_C(v+1))
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		W3D_DrawLine(x3D::Context(), &lin);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$90(a5),a1
	jsr	-$96(a6)
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "LineStrip__xDRAW__Ujr14PUjUj:0",CODE


;void xDRAW::LineStrip(ruint32 col, RICOORD2D* p, ruint32 n)
	XDEF	LineStrip__xDRAW__Ujr14PUjUj
LineStrip__xDRAW__Ujr14PUjUj
L204	EQU	-$30
	link	a5,#L204
	movem.l	d2-d4/a2/a3/a6,-(a7)
	move.l	a6,a2
	movem.l	$8(a5),d2/d3
L189
;	sysVERTEX*	v = Vertices(n);
	move.l	d3,d4
	move.l	_vBufPos__xDRAW,d0
	add.l	d4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L193
L190
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L192
L191
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L192
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L193
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	move.l	_vBuffer__xDRAW,a1
	lea	0(a1,d0.l),a0
	add.l	d4,_vBufPos__xDRAW
	or.l	#$40,_flags__xDRAW
	move.l	a0,a3
;		register sysVERTEX* t = v;
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp1
;		rsint32 i=n+1;
	move.l	d3,d1
	addq.l	#1,d1
;		while(--i)
	bra.b	L195
L194
;			VTX_X(t)=CoordX(*p);
	move.l	a2,a1
	move.l	(a1),d0
	moveq	#$10,d4
	asr.l	d4,d0
	ext.l	d0
	fmove.l	d0,fp0
	fmove.s	fp0,(a0)
;			VTX_Y(t)=CoordY(*(p++));
	move.l	(a2)+,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp0
	fmove.s	fp0,4(a0)
;			VTX_Z(t++)=d;
	move.l	a0,a1
	add.w	#$40,a0
	fmove.d	fp1,$8(a1)
L195
	subq.l	#1,d1
	tst.l	d1
	bne.b	L194
L196
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d2
	beq.b	L198
L197
;		currentCol = col;
	move.l	d2,_currentCol__xDRAW
;		SetColour(col);
	lea	-$18(a5),a0
	move.l	d2,d1
	move.l	#$FF0000,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$10,d4
	lsr.l	d4,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$8,d4
	lsr.l	d4,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$18,d2
	asl.l	d2,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$18(a5),a1
	jsr	-$168(a6)
L198
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		LineStrip(v,n);
	move.l	d3,d2
	lea	-$30(a5),a0
	move.l	d2,(a0)+
	move.l	a3,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	cmp.l	#$C8,d2
	bls.b	L203
L199
	move.l	#$C9,-$30(a5)
	bra.b	L201
L200
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$30(a5),a1
	jsr	-$186(a6)
	lea	-$30(a5),a0
	move.l	4(a0),a0
	lea	$3200(a0),a0
	move.l	a0,-$2C(a5)
	sub.l	#$C8,d2
L201
	cmp.l	#$C8,d2
	bhi.b	L200
L202
	move.l	d2,-$30(a5)
L203
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$30(a5),a1
	jsr	-$186(a6)
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts

	SECTION "Tri__xDRAW__UjUjUjUj:0",CODE


;void xDRAW::Tri(ruint32 col, RICOORD2D p1, RICOORD2D p2, RICOORD2D p
	XDEF	Tri__xDRAW__UjUjUjUj
Tri__xDRAW__UjUjUjUj
L208	EQU	-$D8
	link	a5,#L208
	movem.l	d2-d6/a2/a6,-(a7)
	movem.l	$8(a5),d0/d5
	move.l	$14(a5),d3
	move.l	$10(a5),d4
L205
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d0
	beq.b	L207
L206
;		currentCol = col;
	move.l	d0,_currentCol__xDRAW
;		SetColour(col);
	lea	-$D8(a5),a0
	move.l	d0,d1
	move.l	#$FF0000,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$10,d6
	lsr.l	d6,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$8,d6
	lsr.l	d6,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$18,d2
	asl.l	d2,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$D8(a5),a1
	jsr	-$168(a6)
L207
;	W3D_Triangle tri = {0};
	lea	-$C8(a5),a0
	clr.l	(a0)+
	moveq	#$E,d0
L209
	clr.l	(a0)+
	dbra	d0,L209
	lea	$40(a0),a0
	moveq	#$11,d0
L210
	clr.l	(a0)+
	dbra	d0,L210
;		register sysVERTEX* v = &tri.v1;
	lea	-$C8(a5),a0
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		VTX_X(v)=CoordX(p1);
	move.l	d5,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,(a0)
;	VTX_Y(v)=CoordY(p1);
	move.l	d5,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a0)
;	VTX_Z(v++)=d;
	move.l	a0,a1
	add.w	#$40,a0
	fmove.d	fp0,$8(a1)
;		VTX_X(v)=CoordX(p2);
	move.l	d4,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,(a0)
;	VTX_Y(v)=CoordY(p2);
	move.l	d4,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a0)
;	VTX_Z(v++)=d;
	move.l	a0,a1
	add.w	#$40,a0
	fmove.d	fp0,$8(a1)
;		VTX_X(v)=CoordX(p3);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,(a0)
;	VTX_Y(v)=CoordY(p3);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	fmove.d	fp0,$8(a0)
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		W3D_DrawTriangle(x3D::Context(), &tri);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$C8(a5),a1
	jsr	-$A2(a6)
	movem.l	(a7)+,d2-d6/a2/a6
	unlk	a5
	rts

	SECTION "TriShA__xDRAW__r14PUjUjUjUj:0",CODE


;void xDRAW::TriShA(ruint32* col, RICOORD2D p1, RICOORD2D p2, RICOORD
	XDEF	TriShA__xDRAW__r14PUjUjUjUj
TriShA__xDRAW__r14PUjUjUjUj
L212	EQU	-$DC
	link	a5,#L212
	movem.l	d2-d5/a2/a6,-(a7)
	movem.l	$8(a5),d0/d1/d5
L211
;	W3D_Triangle tri = {0};
	lea	-$C8(a5),a0
	clr.l	(a0)+
	moveq	#$E,d2
L213
	clr.l	(a0)+
	dbra	d2,L213
	lea	$40(a0),a0
	moveq	#$11,d2
L214
	clr.l	(a0)+
	dbra	d2,L214
;	register sysVERTEX* v = &tri.v1;
	lea	-$C8(a5),a0
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		VTX_X(v)=CoordX(p1);
	move.l	d0,d2
	moveq	#$10,d3
	asr.l	d3,d2
	ext.l	d2
	fmove.l	d2,fp1
	fmove.s	fp1,(a0)
;	VTX_Y(v)=CoordY(p1);
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a0)
;	VTX_Z(v++)=d;
	move.l	a0,a1
	add.w	#$40,a0
	fmove.d	fp0,$8(a1)
;		VTX_X(v)=CoordX(p2);
	move.l	d1,d0
	moveq	#$10,d2
	asr.l	d2,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,(a0)
;	VTX_Y(v)=CoordY(p2);
	move.l	d1,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a0)
;	VTX_Z(v++)=d;
	move.l	a0,a1
	add.w	#$40,a0
	fmove.d	fp0,$8(a1)
;		VTX_X(v)=CoordX(p3);
	move.l	d5,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,(a0)
;	VTX_Y(v)=CoordY(p3);
	move.l	d5,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	fmove.d	fp0,$8(a0)
;		p1 = *(col++);
	move.l	(a6)+,d0
;  p2 = 8;
	moveq	#$8,d1
;		ruint32 b = p1;
	move.l	d0,d3
; p1 >>= p2;
	lsr.l	d1,d0
;		ruint32 g = p1;
	move.l	d0,d2
; p1 >>= p2;
	lsr.l	d1,d0
;		ruint32 r = p1;
	move.l	d0,d4
; p1 >>= p2;
	lsr.l	d1,d0
;		p3 = cTab[(p1)];
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d0.l*4),d5
;		p2 = 0x000000FF;
	move.l	#$FF,d1
; r = cTab[(r&p2)];
	and.l	d1,d4
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d4.l*4),d4
; g = cTab[(g&p2)];
	and.l	d1,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),d2
; b = cTab[(b&p2)];
	and.l	d1,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),d3
;		WRITECOLOUR(VTX_C(v))
	lea	$20(a0),a1
;		WRITECOLOUR(VTX_C(v))
	move.l	d4,(a1)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d2,(a1)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d3,(a1)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d5,(a1)
;		p1 = *(col++);
	move.l	(a6)+,d0
; p2 = 8;
	moveq	#$8,d1
;		b = p1;
	move.l	d0,d3
; p1 >>= p2;
	lsr.l	d1,d0
;		g = p1;
	move.l	d0,d2
; p1 >>= p2;
	lsr.l	d1,d0
;		p2 = 0x000000FF;
	move.l	#$FF,d1
; r = cTab[(p1&p2)];
	and.l	d1,d0
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d0.l*4),d4
; g = cTab[(g&p2)];
	and.l	d1,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),d2
; b = cTab[(b&p2)];
	and.l	d1,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),d3
;		WRITECOLOUR(VTX_C(v+1))
	lea	$40(a0),a1
	add.w	#$20,a1
;		WRITECOLOUR(VTX_C(v+1))
	move.l	d4,(a1)+
;		WRITECOLOUR(VTX_C(v+1))
	move.l	d2,(a1)+
;		WRITECOLOUR(VTX_C(v+1))
	move.l	d3,(a1)+
;		WRITECOLOUR(VTX_C(v+1))
	move.l	d5,(a1)
;		p1 = *(col++);
	move.l	(a6),d0
; p2 = 8;
	moveq	#$8,d1
;		b = p1;
	move.l	d0,d3
; p1 >>= p2;
	lsr.l	d1,d0
;		g = p1;
	move.l	d0,d2
; p1 >>= p2;
	lsr.l	d1,d0
;		p2 = 0x000000FF;
	move.l	#$FF,d1
; r = cTab[(p1&p2)];
	and.l	d1,d0
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d0.l*4),d4
; g = cTab[(g&p2)];
	and.l	d1,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),d2
; b = cTab[(b&p2)];
	and.l	d1,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),d3
;		WRITECOLOUR(VTX_C(v+2))
	lea	$80(a0),a0
	add.w	#$20,a0
;		WRITECOLOUR(VTX_C(v+2))
	move.l	d4,(a0)+
;		WRITECOLOUR(VTX_C(v+2))
	move.l	d2,(a0)+
;		WRITECOLOUR(VTX_C(v+2))
	move.l	d3,(a0)+
;		WRITECOLOUR(VTX_C(v+2))
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		W3D_DrawTriangle(x3D::Context(), &tri);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$C8(a5),a1
	jsr	-$A2(a6)
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "Rect__xDRAW__UjUjUj:0",CODE


;void xDRAW::Rect(ruint32 col, RICOORD2D p1, RICOORD2D p2)
	XDEF	Rect__xDRAW__UjUjUj
Rect__xDRAW__UjUjUj
L222	EQU	-$20
	link	a5,#L222
	movem.l	d2-d5/a2/a6,-(a7)
	fmovem.x fp2/fp3/fp4,-(a7)
	movem.l	$8(a5),d2/d4
	move.l	$10(a5),d3
L215
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L219
L216
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L218
L217
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L218
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L219
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d2
	beq.b	L221
L220
;		currentCol = col;
	move.l	d2,_currentCol__xDRAW
;		SetColour(col);
	lea	-$10(a5),a0
	move.l	d2,d1
	move.l	#$FF0000,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$10,d5
	lsr.l	d5,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$8,d5
	lsr.l	d5,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$18,d2
	asl.l	d2,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$10(a5),a1
	jsr	-$168(a6)
L221
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		rfloat32 x1 = CoordX(p1);
	move.l	d4,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d4,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriStrip(v,4);
	lea	-$20(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$20(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "RectScTx__xDRAW__UjUjUjr14R08xTEXTURE:0",CODE


;void xDRAW::RectScTx(ruint32 col, RICOORD2D p1, RICOORD2D p2, regist
	XDEF	RectScTx__xDRAW__UjUjUjr14R08xTEXTURE
RectScTx__xDRAW__UjUjUjr14R08xTEXTURE
L230	EQU	-$20
	link	a5,#L230
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5,-(a7)
	move.l	a6,a3
	movem.l	$8(a5),d2/d4
	move.l	$10(a5),d3
L223
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L227
L224
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L226
L225
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L226
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L227
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d2
	beq.b	L229
L228
;		currentCol = col;
	move.l	d2,_currentCol__xDRAW
;		SetColour(col);
	lea	-$10(a5),a0
	move.l	d2,d1
	move.l	#$FF0000,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$10,d5
	lsr.l	d5,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$8,d5
	lsr.l	d5,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$18,d2
	asl.l	d2,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$10(a5),a1
	jsr	-$168(a6)
L229
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		rfloat32 x1 = CoordX(p1);
	move.l	d4,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d4,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp5
	move.l	a2,a0
	fmove.s	fp5,$14(a0)
;  VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp5
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp5,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x2;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	fmove.s	fp2,$14(a0)
;  VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp2,$18(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	fmove.s	fp2,$14(a0)
;  VTX_V(v++) = tx.y2;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp2,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x2;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;  VTX_V(v) = tx.y2;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$18(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriStripTx(v, 4, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$20(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$20(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "RectTlTx__xDRAW__UjUjUjr14R08xTEXTURE:0",CODE


;void xDRAW::RectTlTx(ruint32 col, RICOORD2D p1, RICOORD2D p2, regist
	XDEF	RectTlTx__xDRAW__UjUjUjr14R08xTEXTURE
RectTlTx__xDRAW__UjUjUjr14R08xTEXTURE
L238	EQU	-$20
	link	a5,#L238
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6,-(a7)
	move.l	a6,a3
	movem.l	$8(a5),d2/d4
	move.l	$10(a5),d3
L231
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L235
L232
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L234
L233
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L234
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L235
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d2
	beq.b	L237
L236
;		currentCol = col;
	move.l	d2,_currentCol__xDRAW
;		SetColour(col);
	lea	-$10(a5),a0
	move.l	d2,d1
	move.l	#$FF0000,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$10,d5
	lsr.l	d5,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	moveq	#$8,d5
	lsr.l	d5,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$8,d2
	lsr.l	d2,d0
	move.l	d1,d2
	and.l	d0,d2
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d2.l*4),(a0)+
	moveq	#$18,d2
	asl.l	d2,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$10(a5),a1
	jsr	-$168(a6)
L237
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp5
;		rfloat32 x1 = CoordX(p1);
	move.l	d4,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d4,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;						VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1 + x2 - x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp3,fp0
	fsub.x	fp4,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;	VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;						VTX_V(v++) = tx.y1 + y2 - y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp1,fp0
	fsub.x	fp2,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1 + x2 - x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp3,fp0
	fsub.x	fp4,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;	VTX_V(v) = tx.y1 + y2 - y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp1,fp0
	fsub.x	fp2,fp0
	move.l	a2,a0
	fmove.s	fp0,$18(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriStripTx(v, 4, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$20(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$20(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "RectShV__xDRAW__r14PUjUjUj:0",CODE


;void xDRAW::RectShV(ruint32* col, RICOORD2D p1, RICOORD2D p2)
	XDEF	RectShV__xDRAW__r14PUjUjUj
RectShV__xDRAW__r14PUjUjUj
L244	EQU	-$28
	link	a5,#L244
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4,-(a7)
	move.l	a6,a3
	movem.l	$8(a5),d2/d3
L239
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L243
L240
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L242
L241
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L242
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L243
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d	= zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		rfloat32 x1 = CoordX(p1);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	d2,d4
;		
	lsr.l	d3,d2
;		
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d5
;		
	move.l	#$FF,d3
;		
	and.l	d3,d4
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d4.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$20(a2),a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$40(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	a3,a0
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$80(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$C0(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriStrip(v, 4);
	lea	-$28(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$28(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "RectScTxShV__xDRAW__r14PUjUjUjr11R08xTEXTURE:0",CODE


;void xDRAW::RectScTxShV(ruint32* col, RICOORD2D p1, RICOORD2D p2, re
	XDEF	RectScTxShV__xDRAW__r14PUjUjUjr11R08xTEXTURE
RectScTxShV__xDRAW__r14PUjUjUjr11R08xTEXTURE
L250	EQU	-$30
	link	a5,#L250
	movem.l	d2-d5/a2/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5,-(a7)
	move.l	a6,-$20(a5)
	movem.l	$8(a5),d2/d3
L245
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L249
L246
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L248
L247
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L248
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L249
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d	= zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		rfloat32 x1 = CoordX(p1);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp5
	move.l	a2,a0
	fmove.s	fp5,$14(a0)
;  VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp5
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp5,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x2;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	fmove.s	fp2,$14(a0)
;  VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp2,$18(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	fmove.s	fp2,$14(a0)
;  VTX_V(v++) = tx.y2;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp2,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x2;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;  VTX_V(v) = tx.y2;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$18(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		
	move.l	-$20(a5),a0
	moveq	#4,d0
	add.l	d0,-$20(a5)
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	d2,d4
;		
	lsr.l	d3,d2
;		
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d5
;		
	move.l	#$FF,d3
;		
	and.l	d3,d4
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d4.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$20(a2),a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$40(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	-$20(a5),a0
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$80(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$C0(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriStripTx(v, 4, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$30(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$30(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "RectTlTxShV__xDRAW__r14PUjUjUjr11R08xTEXTURE:0",CODE


;void xDRAW::RectTlTxShV(ruint32* col, RICOORD2D p1, RICOORD2D p2, re
	XDEF	RectTlTxShV__xDRAW__r14PUjUjUjr11R08xTEXTURE
RectTlTxShV__xDRAW__r14PUjUjUjr11R08xTEXTURE
L256	EQU	-$30
	link	a5,#L256
	movem.l	d2-d5/a2/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6,-(a7)
	move.l	a6,-$20(a5)
	movem.l	$8(a5),d2/d3
L251
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L255
L252
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L254
L253
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L254
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L255
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d	= zDepth;
	fmove.d	_zDepth__xDRAW,fp5
;		rfloat32 x1 = CoordX(p1);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;						VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1 + x2 - x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp3,fp0
	fsub.x	fp4,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;	VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;						VTX_V(v++) = tx.y1 + y2 - y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp1,fp0
	fsub.x	fp2,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1 + x2 - x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp3,fp0
	fsub.x	fp4,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;	VTX_V(v) = tx.y1 + y2 - y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp1,fp0
	fsub.x	fp2,fp0
	move.l	a2,a0
	fmove.s	fp0,$18(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		
	move.l	-$20(a5),a0
	moveq	#4,d0
	add.l	d0,-$20(a5)
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	d2,d4
;		
	lsr.l	d3,d2
;		
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d5
;		
	move.l	#$FF,d3
;		
	and.l	d3,d4
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d4.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$20(a2),a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$40(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	-$20(a5),a0
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$80(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$C0(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriStripTx(v, 4, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$30(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$30(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "RectShH__xDRAW__r14PUjUjUj:0",CODE


;void xDRAW::RectShH(ruint32* col, RICOORD2D p1, RICOORD2D p2)
	XDEF	RectShH__xDRAW__r14PUjUjUj
RectShH__xDRAW__r14PUjUjUj
L262	EQU	-$28
	link	a5,#L262
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4,-(a7)
	move.l	a6,a3
	movem.l	$8(a5),d2/d3
L257
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L261
L258
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L260
L259
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L260
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L261
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d	= zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		rfloat32 x1 = CoordX(p1);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	d2,d4
;		
	lsr.l	d3,d2
;		
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d5
;		
	move.l	#$FF,d3
;		
	and.l	d3,d4
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d4.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$20(a2),a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$80(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	a3,a0
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$40(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$C0(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriStrip(v, 4);
	lea	-$28(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$28(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "RectScTxShH__xDRAW__r14PUjUjUjr11R08xTEXTURE:0",CODE


;void xDRAW::RectScTxShH(ruint32* col, RICOORD2D p1, RICOORD2D p2, re
	XDEF	RectScTxShH__xDRAW__r14PUjUjUjr11R08xTEXTURE
RectScTxShH__xDRAW__r14PUjUjUjr11R08xTEXTURE
L268	EQU	-$30
	link	a5,#L268
	movem.l	d2-d5/a2/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5,-(a7)
	move.l	a6,-$20(a5)
	movem.l	$8(a5),d2/d3
L263
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L267
L264
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L266
L265
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L266
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L267
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d	= zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		rfloat32 x1 = CoordX(p1);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp5
	move.l	a2,a0
	fmove.s	fp5,$14(a0)
;  VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp5
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp5,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x2;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	fmove.s	fp2,$14(a0)
;  VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp2,$18(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	fmove.s	fp2,$14(a0)
;  VTX_V(v++) = tx.y2;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp2,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x2;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;  VTX_V(v) = tx.y2;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$18(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		
	move.l	-$20(a5),a0
	moveq	#4,d0
	add.l	d0,-$20(a5)
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	d2,d4
;		
	lsr.l	d3,d2
;		
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d5
;		
	move.l	#$FF,d3
;		
	and.l	d3,d4
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d4.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$20(a2),a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$80(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	-$20(a5),a0
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$40(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$C0(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriStripTx(v, 4, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$30(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$30(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "RectTlTxShH__xDRAW__r14PUjUjUjr11R08xTEXTURE:0",CODE


;void xDRAW::RectTlTxShH(ruint32* col, RICOORD2D p1, RICOORD2D p2, re
	XDEF	RectTlTxShH__xDRAW__r14PUjUjUjr11R08xTEXTURE
RectTlTxShH__xDRAW__r14PUjUjUjr11R08xTEXTURE
L274	EQU	-$30
	link	a5,#L274
	movem.l	d2-d5/a2/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6,-(a7)
	move.l	a6,-$20(a5)
	movem.l	$8(a5),d2/d3
L269
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L273
L270
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L272
L271
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L272
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L273
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d	= zDepth;
	fmove.d	_zDepth__xDRAW,fp5
;		rfloat32 x1 = CoordX(p1);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;						VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1 + x2 - x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp3,fp0
	fsub.x	fp4,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;	VTX_V(v++) = tx.y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;						VTX_V(v++) = tx.y1 + y2 - y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp1,fp0
	fsub.x	fp2,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1 + x2 - x1;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp3,fp0
	fsub.x	fp4,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;	VTX_V(v) = tx.y1 + y2 - y1;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp1,fp0
	fsub.x	fp2,fp0
	move.l	a2,a0
	fmove.s	fp0,$18(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		
	move.l	-$20(a5),a0
	moveq	#4,d0
	add.l	d0,-$20(a5)
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	d2,d4
;		
	lsr.l	d3,d2
;		
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d5
;		
	move.l	#$FF,d3
;		
	and.l	d3,d4
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d4.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$20(a2),a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$80(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	-$20(a5),a0
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$40(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	lea	$C0(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriStripTx(v, 4, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$30(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$30(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "RectShA__xDRAW__r14PUjUjUj:0",CODE


;void xDRAW::RectShA(ruint32* col, RICOORD2D p1, RICOORD2D p2)
	XDEF	RectShA__xDRAW__r14PUjUjUj
RectShA__xDRAW__r14PUjUjUj
L280	EQU	-$28
	link	a5,#L280
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4,-(a7)
	move.l	a6,a3
	movem.l	$8(a5),d2/d3
L275
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L279
L276
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L278
L277
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L278
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L279
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d	= zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		rfloat32 x1 = CoordX(p1);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v++)=d;
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.d	fp0,$8(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	d2,d4
;		
	lsr.l	d3,d2
;		
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d5
;		
	move.l	#$FF,d3
;		
	and.l	d3,d4
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d4.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$20(a2),a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$40(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$80(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	a3,a0
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$C0(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriStrip(v, 4);
	lea	-$28(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$28(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "RectScTxShA__xDRAW__r14PUjUjUjr11R08xTEXTURE:0",CODE


;void xDRAW::RectScTxShA(ruint32* col, RICOORD2D p1, RICOORD2D p2, re
	XDEF	RectScTxShA__xDRAW__r14PUjUjUjr11R08xTEXTURE
RectScTxShA__xDRAW__r14PUjUjUjr11R08xTEXTURE
L286	EQU	-$54
	link	a5,#L286
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5,-(a7)
	move.l	a3,-$44(a5)
	move.l	a6,a3
	movem.l	$8(a5),d2/d3
L281
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L285
L282
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L284
L283
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L284
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L285
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d	= zDepth;
	fmove.d	_zDepth__xDRAW,fp0
;		rfloat32 x1 = CoordX(p1);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	-$44(a5),a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp5
	move.l	a2,a0
	fmove.s	fp5,$14(a0)
;  VTX_V(v++) = tx.y1;
	move.l	-$44(a5),a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp5
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp5,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x2;
	move.l	-$44(a5),a0
	move.w	$28(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	fmove.s	fp2,$14(a0)
;  VTX_V(v++) = tx.y1;
	move.l	-$44(a5),a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp2,$18(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	-$44(a5),a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	fmove.s	fp2,$14(a0)
;  VTX_V(v++) = tx.y2;
	move.l	-$44(a5),a0
	move.w	$2A(a0),d0
	ext.l	d0
	fmove.l	d0,fp2
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp2,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp0,$8(a0)
; VTX_U(v) = tx.x2;
	move.l	-$44(a5),a0
	move.w	$28(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;  VTX_V(v) = tx.y2;
	move.l	-$44(a5),a0
	move.w	$2A(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$18(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	d2,d4
;		
	lsr.l	d3,d2
;		
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d5
;		
	move.l	#$FF,d3
;		
	and.l	d3,d4
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d4.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$20(a2),a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$40(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$80(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	a3,a0
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$C0(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriStripTx(v, 4, tx.tex);
	move.l	-$44(a5),a0
	move.l	$10(a0),a6
	lea	-$54(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$54(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "RectTlTxShA__xDRAW__r14PUjUjUjr11R08xTEXTURE:0",CODE


;void xDRAW::RectTlTxShA(ruint32* col, RICOORD2D p1, RICOORD2D p2, re
	XDEF	RectTlTxShA__xDRAW__r14PUjUjUjr11R08xTEXTURE
RectTlTxShA__xDRAW__r14PUjUjUjr11R08xTEXTURE
L292	EQU	-$54
	link	a5,#L292
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6,-(a7)
	move.l	a3,-$44(a5)
	move.l	a6,a3
	movem.l	$8(a5),d2/d3
L287
;	if ((vBufPos+4) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	addq.l	#4,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L291
L288
;	if ((vBufPos+4) >= vArraySize) Flus
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L290
L289
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L290
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L291
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d	= zDepth;
	fmove.d	_zDepth__xDRAW,fp5
;		rfloat32 x1 = CoordX(p1);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp4
; rfloat32 x2 = CoordX(p2);
	move.l	d3,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;		rfloat32 y1 = CoordY(p1);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
; rfloat32 y2 = CoordY(p2);
	move.l	d3,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	-$44(a5),a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;						VTX_V(v++) = tx.y1;
	move.l	-$44(a5),a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y1;
	move.l	a2,a0
	fmove.s	fp2,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1 + x2 - x1;
	move.l	-$44(a5),a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp3,fp0
	fsub.x	fp4,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;	VTX_V(v++) = tx.y1;
	move.l	-$44(a5),a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x1;
	move.l	a2,a0
	fmove.s	fp4,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1;
	move.l	-$44(a5),a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;						VTX_V(v++) = tx.y1 + y2 - y1;
	move.l	-$44(a5),a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp1,fp0
	fsub.x	fp2,fp0
	move.l	a2,a0
	moveq	#$40,d0
	add.l	a2,d0
	move.l	d0,a2
	fmove.s	fp0,$18(a0)
;		VTX_X(v)=x2;
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y2;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp5,$8(a0)
; VTX_U(v) = tx.x1 + x2 - x1;
	move.l	-$44(a5),a0
	move.w	$24(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp3,fp0
	fsub.x	fp4,fp0
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;	VTX_V(v) = tx.y1 + y2 - y1;
	move.l	-$44(a5),a0
	move.w	$26(a0),d0
	ext.l	d0
	fmove.l	d0,fp0
	fadd.x	fp1,fp0
	fsub.x	fp2,fp0
	move.l	a2,a0
	fmove.s	fp0,$18(a0)
;		vBufPos += 4;
	addq.l	#4,_vBufPos__xDRAW
;		v-=3;
	move.l	#$C0,d0
	neg.l	d0
	add.l	a2,d0
	move.l	d0,a2
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	d2,d4
;		
	lsr.l	d3,d2
;		
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d5
;		
	move.l	#$FF,d3
;		
	and.l	d3,d4
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d4.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$20(a2),a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$40(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	(a3)+,d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$80(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		
	move.l	a3,a0
	move.l	(a0),d2
;		
	moveq	#$8,d3
;		
	move.l	d2,d1
;		
	lsr.l	d3,d2
;		
	move.l	d2,d0
;		
	lsr.l	d3,d2
;		
	move.l	#$FF,d3
;		
	and.l	d3,d2
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d2.l*4),d4
;		
	and.l	d3,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
;		
	and.l	d3,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	lea	$C0(a2),a0
	add.w	#$20,a0
;		
	move.l	d4,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d5,(a0)
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriStripTx(v, 4, tx.tex);
	move.l	-$44(a5),a0
	move.l	$10(a0),a6
	lea	-$54(a5),a0
	move.l	#4,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$54(a5),a1
	jsr	-$AE(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "Circle__xDRAW__UjUjUj:0",CODE


;void xDRAW::Circle(ruint32 col, RICOORD2D p1, ruint32 rad)
	XDEF	Circle__xDRAW__UjUjUj
Circle__xDRAW__UjUjUj
L303	EQU	-$20
	link	a5,#L303
	movem.l	d2-d5/a2/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	$10(a5),d2
	move.l	$8(a5),d3
	move.l	$C(a5),d4
L293
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L297
L294
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L296
L295
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L296
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L297
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d3
	beq.b	L299
L298
;		currentCol = col;
	move.l	d3,_currentCol__xDRAW
;		SetColour(col);
	lea	-$10(a5),a0
	move.l	d3,d1
	move.l	#$FF0000,d0
	move.l	d1,d3
	and.l	d0,d3
	moveq	#$10,d5
	lsr.l	d5,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$8,d3
	lsr.l	d3,d0
	move.l	d1,d3
	and.l	d0,d3
	moveq	#$8,d5
	lsr.l	d5,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$8,d3
	lsr.l	d3,d0
	move.l	d1,d3
	and.l	d0,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$18,d3
	asl.l	d3,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$10(a5),a1
	jsr	-$168(a6)
L299
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp2
;		rfloat32 x = CoordX(p1);
	move.l	d4,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 y = CoordY(p1);
	move.l	d4,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 rfx = rad;
	fmove.l	d2,fp5
;		VTX_X(v)=x;
	move.l	a2,a0
	fmove.s	fp1,(a0)
;	VTX_Y(v)=y;
	move.l	a2,a0
	fmove.s	fp0,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp2,$8(a0)
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.x	fp1,fp3
	fadd.x	fp5,fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fadd.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.x	fp1,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	moveq	#1,d2
	bra	L301
L300
;		
	move.l	#_sTab__xDRAW,a1
	fmove.x	fp5,fp4
	fmul.s	0(a1,d2.l*4),fp4
;		
	moveq	#$10,d0
	sub.l	d2,d0
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d0.l*4),fp3
	fmul.x	fp5,fp3
;		
	move.l	d2,d0
	asl.l	#6,d0
	lea	0(a2,d0.l),a0
	add.w	#$40,a0
;		
	fmove.x	fp1,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.x	fp1,fp6
	fadd.x	fp3,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.x	fp1,fp6
	fsub.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp6
	fadd.x	fp3,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.x	fp1,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp4,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
	addq.l	#1,d2
L301
	cmp.l	#$10,d2
	blo	L300
L302
;		vBufPos += (4*XDRAW_TRIGSIZE+2);
	add.l	#$42,_vBufPos__xDRAW
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriFan(v, 4*XDRAW_TRIGSIZE+2);
	lea	-$20(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$20(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "CircleShC__xDRAW__r14PUjUjUj:0",CODE


;void xDRAW::CircleShC(ruint32* col, RICOORD2D p1, ruint32 rad)
	XDEF	CircleShC__xDRAW__r14PUjUjUj
CircleShC__xDRAW__r14PUjUjUj
L312	EQU	-$38
	link	a5,#L312
	movem.l	d2-d6/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	a6,a3
	move.l	$C(a5),d2
	move.l	$8(a5),d5
L304
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L308
L305
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L307
L306
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L307
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L308
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp2
;		rfloat32 x = CoordX(p1);
	move.l	d5,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 y = CoordY(p1);
	move.l	d5,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 rfx = rad;
	fmove.l	d2,fp5
;		p1 = *(col++);
	move.l	(a3)+,d5
;		rad = 8;
	moveq	#$8,d2
;		ruint32 b = p1;
	move.l	d5,d1
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 g = p1;
	move.l	d5,d0
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 r = p1;
	move.l	d5,d3
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 a = cTab[(p1)];
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d4
;		rad = 0x000000FF;
	move.l	#$FF,d2
; r = cTab[(r&rad)];
	and.l	d2,d3
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d3.l*4),d3
; g = cTab[(g&rad)];
	and.l	d2,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&rad)];
	and.l	d2,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		VTX_X(v)=x;
	move.l	a2,a0
	fmove.s	fp1,(a0)
;	VTX_Y(v)=y;
	move.l	a2,a0
	fmove.s	fp0,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp2,$8(a0)
;		WRITECOLOUR(VTX_C(v))
	lea	$20(a2),a0
;		WRITECOLOUR(VTX_C(v))
	move.l	d3,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d0,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d1,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d4,(a0)
;		p1 = *(col);
	move.l	a3,a0
	move.l	(a0),d5
; rad = 8;
	moveq	#$8,d2
;		b = p1;
	move.l	d5,d1
; p1 >>= rad;
	lsr.l	d2,d5
;		g = p1;
	move.l	d5,d0
; p1 >>= rad;
	lsr.l	d2,d5
;		rad = 0x000000FF;
	move.l	#$FF,d2
; r = cTab[(p1&rad)];
	and.l	d2,d5
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d3
; g = cTab[(g&rad)];
	and.l	d2,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&rad)];
	and.l	d2,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp1,fp3
	fadd.x	fp5,fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fadd.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp1,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	moveq	#6,d5
	asl.l	d5,d2
	add.l	d2,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
;		
	moveq	#1,d2
	bra	L310
L309
;		
	move.l	#_sTab__xDRAW,a1
	fmove.x	fp5,fp4
	fmul.s	0(a1,d2.l*4),fp4
;		
	moveq	#$10,d5
	sub.l	d2,d5
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d5.l*4),fp3
	fmul.x	fp5,fp3
;		
	move.l	d2,d5
	asl.l	#6,d5
	lea	0(a2,d5.l),a0
	add.w	#$40,a0
;		
	fmove.x	fp1,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp1,fp6
	fadd.x	fp3,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp1,fp6
	fsub.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp6
	fadd.x	fp3,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp1,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp4,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
	addq.l	#1,d2
L310
	cmp.l	#$10,d2
	blo	L309
L311
;		vBufPos += (4*XDRAW_TRIGSIZE+2);
	add.l	#$42,_vBufPos__xDRAW
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriFan(v, 4*XDRAW_TRIGSIZE+2);
	lea	-$38(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$38(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "CircleShPt__xDRAW__r14PUjUjUjUj:0",CODE


;void xDRAW::CircleShPt(ruint32* col, RICOORD2D p1, RICOORD2D p2, rui
	XDEF	CircleShPt__xDRAW__r14PUjUjUjUj
CircleShPt__xDRAW__r14PUjUjUjUj
L321	EQU	-$38
	link	a5,#L321
	movem.l	d2-d6/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	a6,a3
	move.l	$10(a5),d2
	move.l	$8(a5),d5
	move.l	$C(a5),d6
L313
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L317
L314
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L316
L315
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L316
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L317
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp2
;		rfloat32 x = CoordX(p1);
	move.l	d5,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 y = CoordY(p1);
	move.l	d5,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 rfx = rad;
	fmove.l	d2,fp5
;		VTX_X(v)=x+CoordX(p2);
	move.l	d6,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
	fadd.x	fp1,fp3
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	VTX_Y(v)=y+CoordY(p2);
	move.l	d6,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp3
	fadd.x	fp0,fp3
	move.l	a2,a0
	fmove.s	fp3,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp2,$8(a0)
;		p1 = *(col++);
	move.l	(a3)+,d5
;	p2 = 8;
	moveq	#$8,d6
;		ruint32 b = p1;
	move.l	d5,d1
; p1 >>= p2;
	lsr.l	d6,d5
;		ruint32 g = p1;
	move.l	d5,d0
; p1 >>= p2;
	lsr.l	d6,d5
;		ruint32 r = p1;
	move.l	d5,d3
; p1 >>= p2;
	lsr.l	d6,d5
;		ruint32 a = cTab[(p1)];
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d4
;		p2 = 0x000000FF;
	move.l	#$FF,d6
; r = cTab[(r&p2)];
	and.l	d6,d3
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d3.l*4),d3
; g = cTab[(g&p2)];
	and.l	d6,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&p2)];
	and.l	d6,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		WRITECOLOUR(VTX_C(v))
	lea	$20(a2),a0
;		WRITECOLOUR(VTX_C(v))
	move.l	d3,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d0,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d1,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d4,(a0)
;		p1 = *(col);
	move.l	a3,a0
	move.l	(a0),d5
; p2 = 8;
	moveq	#$8,d6
;		b = p1;
	move.l	d5,d1
; p1 >>= p2;
	lsr.l	d6,d5
;		g = p1;
	move.l	d5,d0
; p1 >>= p2;
	lsr.l	d6,d5
;		p2 = 0x000000FF;
	move.l	#$FF,d6
; r = cTab[(p1&p2)];
	and.l	d6,d5
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d3
; g = cTab[(g&p2)];
	and.l	d6,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&p2)];
	and.l	d6,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp1,fp3
	fadd.x	fp5,fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fadd.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp1,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	moveq	#6,d5
	asl.l	d5,d2
	add.l	d2,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
;		
	moveq	#1,d2
	bra	L319
L318
;		
	move.l	#_sTab__xDRAW,a1
	fmove.x	fp5,fp4
	fmul.s	0(a1,d2.l*4),fp4
;		
	moveq	#$10,d5
	sub.l	d2,d5
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d5.l*4),fp3
	fmul.x	fp5,fp3
;		
	move.l	d2,d5
	asl.l	#6,d5
	lea	0(a2,d5.l),a0
	add.w	#$40,a0
;		
	fmove.x	fp1,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp1,fp6
	fadd.x	fp3,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp1,fp6
	fsub.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp6
	fadd.x	fp3,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp1,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp4,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
	addq.l	#1,d2
L319
	cmp.l	#$10,d2
	blo	L318
L320
;		vBufPos += (4*XDRAW_TRIGSIZE+2);
	add.l	#$42,_vBufPos__xDRAW
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriFan(v, 4*XDRAW_TRIGSIZE+2);
	lea	-$38(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$38(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "Elipse__xDRAW__UjUjUj:0",CODE


;void xDRAW::Elipse(ruint32 col, RICOORD2D p1, RICOORD2D rad)
	XDEF	Elipse__xDRAW__UjUjUj
Elipse__xDRAW__UjUjUj
L332	EQU	-$28
	link	a5,#L332
	movem.l	d2-d5/a2/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	$10(a5),d2
	move.l	$8(a5),d3
	move.l	$C(a5),d4
L322
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L326
L323
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L325
L324
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L325
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L326
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d3
	beq.b	L328
L327
;		currentCol = col;
	move.l	d3,_currentCol__xDRAW
;		SetColour(col);
	lea	-$18(a5),a0
	move.l	d3,d1
	move.l	#$FF0000,d0
	move.l	d1,d3
	and.l	d0,d3
	moveq	#$10,d5
	lsr.l	d5,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$8,d3
	lsr.l	d3,d0
	move.l	d1,d3
	and.l	d0,d3
	moveq	#$8,d5
	lsr.l	d5,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$8,d3
	lsr.l	d3,d0
	move.l	d1,d3
	and.l	d0,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$18,d3
	asl.l	d3,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$18(a5),a1
	jsr	-$168(a6)
L328
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp2
;		rfloat32 x = CoordX(p1);
	move.l	d4,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 y = CoordY(p1);
	move.l	d4,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 rfx = CoordX(rad);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,-$8(a5)
;	rfloat32 rfy = CoordY(rad);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp5
;		VTX_X(v)=x;
	move.l	a2,a0
	fmove.s	fp1,(a0)
;	VTX_Y(v)=y;
	move.l	a2,a0
	fmove.s	fp0,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp2,$8(a0)
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.x	fp1,fp3
	fadd.s	-$8(a5),fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fadd.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.x	fp1,fp3
	fsub.s	-$8(a5),fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	moveq	#1,d2
	bra	L330
L329
;		
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d2.l*4),fp4
;		
	moveq	#$10,d0
	sub.l	d2,d0
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d0.l*4),fp3
;		
	move.l	d2,d0
	asl.l	#6,d0
	lea	0(a2,d0.l),a0
	add.w	#$40,a0
;		
	fmove.s	-$8(a5),fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp0,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.s	-$8(a5),fp6
	fmul.x	fp3,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp5,fp6
	fmul.x	fp4,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.s	-$8(a5),fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$400,a0
;		
	fmul.s	-$8(a5),fp3
	fmove.x	fp1,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp5,fp3
	fmul.x	fp4,fp3
	fmove.x	fp0,fp4
	fsub.x	fp3,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp2,$8(a0)
	addq.l	#1,d2
L330
	cmp.l	#$10,d2
	blo	L329
L331
;		vBufPos += (4*XDRAW_TRIGSIZE+2);
	add.l	#$42,_vBufPos__xDRAW
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriFan(v, 4*XDRAW_TRIGSIZE+2);
	lea	-$28(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$28(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d5/a2/a6
	unlk	a5
	rts

	SECTION "ElipseShC__xDRAW__r14PUjUjUj:0",CODE


;void xDRAW::ElipseShC(ruint32* col, RICOORD2D p1, RICOORD2D rad)
	XDEF	ElipseShC__xDRAW__r14PUjUjUj
ElipseShC__xDRAW__r14PUjUjUj
L341	EQU	-$40
	link	a5,#L341
	movem.l	d2-d6/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	a6,a3
	move.l	$C(a5),d2
	move.l	$8(a5),d5
L333
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L337
L334
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L336
L335
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L336
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L337
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp2
;		rfloat32 x = CoordX(p1);
	move.l	d5,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 y = CoordY(p1);
	move.l	d5,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 rfx = CoordX(rad);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,-$30(a5)
;	rfloat32 rfy = CoordY(rad);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp5
;		p1 = *(col++);
	move.l	(a3)+,d5
;  rad = 8;
	moveq	#$8,d2
;		ruint32 b = p1;
	move.l	d5,d1
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 g = p1;
	move.l	d5,d0
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 r = p1;
	move.l	d5,d3
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 a = cTab[(p1)];
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d4
;		rad = 0x000000FF;
	move.l	#$FF,d2
; r = cTab[(r&rad)];
	and.l	d2,d3
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d3.l*4),d3
; g = cTab[(g&rad)];
	and.l	d2,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&rad)];
	and.l	d2,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		VTX_X(v)=x;
	move.l	a2,a0
	fmove.s	fp1,(a0)
;	VTX_Y(v)=y;
	move.l	a2,a0
	fmove.s	fp0,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp2,$8(a0)
;		WRITECOLOUR(VTX_C(v))
	lea	$20(a2),a0
;		WRITECOLOUR(VTX_C(v))
	move.l	d3,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d0,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d1,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d4,(a0)
;		p1 = *(col);
	move.l	a3,a0
	move.l	(a0),d5
; rad = 8;
	moveq	#$8,d2
;		b = p1;
	move.l	d5,d1
; p1 >>= rad;
	lsr.l	d2,d5
;		g = p1;
	move.l	d5,d0
; p1 >>= rad;
	lsr.l	d2,d5
;		rad = 0x000000FF;
	move.l	#$FF,d2
; r = cTab[(p1&rad)];
	and.l	d2,d5
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d3
; g = cTab[(g&rad)];
	and.l	d2,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&rad)];
	and.l	d2,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp1,fp3
	fadd.s	-$30(a5),fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fadd.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp1,fp3
	fsub.s	-$30(a5),fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	moveq	#6,d5
	asl.l	d5,d2
	add.l	d2,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
;		
	moveq	#1,d2
	bra	L339
L338
;		
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d2.l*4),fp4
;		
	moveq	#$10,d5
	sub.l	d2,d5
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d5.l*4),fp3
;		
	move.l	d2,d5
	asl.l	#6,d5
	lea	0(a2,d5.l),a0
	add.w	#$40,a0
;		
	fmove.s	-$30(a5),fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp0,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.s	-$30(a5),fp6
	fmul.x	fp3,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp5,fp6
	fmul.x	fp4,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.s	-$30(a5),fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmul.s	-$30(a5),fp3
	fmove.x	fp1,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp5,fp3
	fmul.x	fp4,fp3
	fmove.x	fp0,fp4
	fsub.x	fp3,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
	addq.l	#1,d2
L339
	cmp.l	#$10,d2
	blo	L338
L340
;		vBufPos += (4*XDRAW_TRIGSIZE+2);
	add.l	#$42,_vBufPos__xDRAW
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriFan(v, 4*XDRAW_TRIGSIZE+2);
	lea	-$40(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$40(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "ElipseShPt__xDRAW__r14PUjUjUjUj:0",CODE


;void xDRAW::ElipseShPt(ruint32* col, RICOORD2D p1, RICOORD2D p2, RIC
	XDEF	ElipseShPt__xDRAW__r14PUjUjUjUj
ElipseShPt__xDRAW__r14PUjUjUjUj
L350	EQU	-$40
	link	a5,#L350
	movem.l	d2-d6/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	a6,a3
	move.l	$10(a5),d2
	move.l	$8(a5),d5
	move.l	$C(a5),d6
L342
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L346
L343
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L345
L344
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L345
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L346
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp2
;		rfloat32 x = CoordX(p1);
	move.l	d5,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 y = CoordY(p1);
	move.l	d5,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 rfx = CoordX(rad);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,-$30(a5)
;	rfloat32 rfy = CoordY(rad);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp5
;		v[0].x=x+CoordX(p2);
	move.l	d6,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
	fadd.x	fp1,fp3
	move.l	a2,a0
	fmove.s	fp3,(a0)
;	v[0].y=y+CoordY(p2);
	move.l	d6,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp3
	fadd.x	fp0,fp3
	move.l	a2,a0
	fmove.s	fp3,4(a0)
;	v[0].z=d;
	move.l	a2,a0
	fmove.d	fp2,$8(a0)
;		p1 = *(col++);
	move.l	(a3)+,d5
;	p2 = 8;
	moveq	#$8,d6
;		ruint32 b = p1;
	move.l	d5,d1
; p1 >>= p2;
	lsr.l	d6,d5
;		ruint32 g = p1;
	move.l	d5,d0
; p1 >>= p2;
	lsr.l	d6,d5
;		ruint32 r = p1;
	move.l	d5,d3
; p1 >>= p2;
	lsr.l	d6,d5
;		ruint32 a = cTab[(p1)];
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d4
;		p2 = 0x000000FF;
	move.l	#$FF,d6
; r = cTab[(r&p2)];
	and.l	d6,d3
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d3.l*4),d3
; g = cTab[(g&p2)];
	and.l	d6,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&p2)];
	and.l	d6,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		WRITECOLOUR(VTX_C(v))
	lea	$20(a2),a0
;		WRITECOLOUR(VTX_C(v))
	move.l	d3,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d0,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d1,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d4,(a0)
;		p1 = *(col);
	move.l	a3,a0
	move.l	(a0),d5
;	p2 = 8;
	moveq	#$8,d6
;		b = p1;
	move.l	d5,d1
; p1 >>= p2;
	lsr.l	d6,d5
;		g = p1;
	move.l	d5,d0
; p1 >>= p2;
	lsr.l	d6,d5
;		p2 = 0x000000FF;
	move.l	#$FF,d6
; r = cTab[(p1&p2)];
	and.l	d6,d5
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d3
; g = cTab[(g&p2)];
	and.l	d6,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&p2)];
	and.l	d6,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp1,fp3
	fadd.s	-$30(a5),fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fadd.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp1,fp3
	fsub.s	-$30(a5),fp3
	fmove.s	fp3,(a0)
;		
	fmove.s	fp0,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	moveq	#6,d5
	asl.l	d5,d2
	add.l	d2,a0
;		
	fmove.s	fp1,(a0)
;		
	fmove.x	fp0,fp3
	fsub.x	fp5,fp3
	fmove.s	fp3,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
;		
	moveq	#1,d2
	bra	L348
L347
;		
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d2.l*4),fp4
;		
	moveq	#$10,d5
	sub.l	d2,d5
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d5.l*4),fp3
;		
	move.l	d2,d5
	asl.l	#6,d5
	lea	0(a2,d5.l),a0
	add.w	#$40,a0
;		
	fmove.s	-$30(a5),fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp0,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.s	-$30(a5),fp6
	fmul.x	fp3,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp5,fp6
	fmul.x	fp4,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.s	-$30(a5),fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmul.s	-$30(a5),fp3
	fmove.x	fp1,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp5,fp3
	fmul.x	fp4,fp3
	fmove.x	fp0,fp4
	fsub.x	fp3,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp2,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
	addq.l	#1,d2
L348
	cmp.l	#$10,d2
	blo	L347
L349
;		vBufPos += 4*XDRAW_TRIGSIZE+2;
	add.l	#$42,_vBufPos__xDRAW
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Disable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		TriFan(v, 4*XDRAW_TRIGSIZE+2);
	lea	-$40(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$40(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "CircleScTx__xDRAW__UjUjUjr14R08xTEXTURE:0",CODE


;void xDRAW::CircleScTx(ruint32 col, RICOORD2D p1, ruint32 rad, regis
	XDEF	CircleScTx__xDRAW__UjUjUjr14R08xTEXTURE
CircleScTx__xDRAW__UjUjUjr14R08xTEXTURE
L364	EQU	-$24
	link	a5,#L364
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	a6,a3
	move.l	$10(a5),d2
	move.l	$8(a5),d3
	move.l	$C(a5),d4
L351
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L355
L352
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L354
L353
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L354
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L355
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d3
	beq.b	L357
L356
;		currentCol = col;
	move.l	d3,_currentCol__xDRAW
;		SetColour(col);
	lea	-$14(a5),a0
	move.l	d3,d1
	move.l	#$FF0000,d0
	move.l	d1,d3
	and.l	d0,d3
	moveq	#$10,d5
	lsr.l	d5,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$8,d3
	lsr.l	d3,d0
	move.l	d1,d3
	and.l	d0,d3
	moveq	#$8,d5
	lsr.l	d5,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$8,d3
	lsr.l	d3,d0
	move.l	d1,d3
	and.l	d0,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$18,d3
	asl.l	d3,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$14(a5),a1
	jsr	-$168(a6)
L357
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp3
;		rfloat32 x = CoordX(p1);
	move.l	d4,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 y = CoordY(p1);
	move.l	d4,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 rfx = rad;
	fmove.l	d2,fp2
;		VTX_X(v)=x;
	move.l	a2,a0
	fmove.s	fp0,(a0)
;	VTX_Y(v)=y;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp3,$8(a0)
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp4
	fsub.x	fp2,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.x	fp0,fp4
	fadd.x	fp2,fp4
	fmove.s	fp4,(a0)
;		
	fmove.s	fp1,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp4
	fadd.x	fp2,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.x	fp0,fp4
	fsub.x	fp2,fp4
	fmove.s	fp4,(a0)
;		
	fmove.s	fp1,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp4
	fsub.x	fp2,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	moveq	#1,d2
	bra	L359
L358
;		
	move.l	#_sTab__xDRAW,a1
	fmove.x	fp2,fp5
	fmul.s	0(a1,d2.l*4),fp5
;		
	moveq	#$10,d0
	sub.l	d2,d0
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d0.l*4),fp4
	fmul.x	fp2,fp4
;		
	move.l	d2,d0
	asl.l	#6,d0
	lea	0(a2,d0.l),a0
	add.w	#$40,a0
;		
	fmove.x	fp0,fp6
	fadd.x	fp5,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp1,fp6
	fsub.x	fp4,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.x	fp0,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp1,fp6
	fadd.x	fp5,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.x	fp0,fp6
	fsub.x	fp5,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp1,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.x	fp0,fp6
	fsub.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp1,fp4
	fsub.x	fp5,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp3,$8(a0)
	addq.l	#1,d2
L359
	cmp.l	#$10,d2
	blo	L358
L360
;			x		= (tx.x1 + tx.x2)/2F;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$28(a0),d1
	ext.l	d1
	add.l	d1,d0
	fmove.l	d0,fp0
	fdiv.s	#$.40000000,fp0
;			y		= (tx.y1 + tx.y2)/2F;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$2A(a0),d1
	ext.l	d1
	add.l	d1,d0
	fmove.l	d0,fp1
	fdiv.s	#$.40000000,fp1
;			rfx	= (tx.x2 - tx.x1)/2F;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$24(a0),d1
	ext.l	d1
	sub.l	d1,d0
	fmove.l	d0,fp2
	fdiv.s	#$.40000000,fp2
;			rfloat32 rfy	= (tx.y2 - tx.y1)/2F;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$26(a0),d1
	ext.l	d1
	sub.l	d1,d0
	fmove.l	d0,fp5
	fdiv.s	#$.40000000,fp5
;			
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;			
	move.l	a2,a0
	fmove.s	fp1,$18(a0)
;			
	moveq	#$10,d2
;			
	lea	$40(a2),a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$26(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	move.l	a3,a1
	move.w	$28(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$14(a0)
;			
	fmove.s	fp1,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$2A(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	move.l	a3,a1
	move.w	$24(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$14(a0)
;			
	fmove.s	fp1,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$26(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$18(a0)
;			
	moveq	#1,d2
	bra	L362
L361
;			
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d2.l*4),fp4
;			
	moveq	#$10,d0
	sub.l	d2,d0
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d0.l*4),fp3
;			
	move.l	d2,d0
	asl.l	#6,d0
	lea	0(a2,d0.l),a0
	add.w	#$40,a0
;			
	fmove.x	fp2,fp6
	fmul.x	fp4,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp1,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmove.x	fp2,fp6
	fmul.x	fp3,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp5,fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmove.x	fp2,fp6
	fmul.x	fp4,fp6
	fmove.s	fp0,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmul.x	fp2,fp3
	fmove.x	fp0,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,$14(a0)
;			
	fmove.x	fp5,fp3
	fmul.x	fp4,fp3
	fmove.x	fp1,fp4
	fsub.x	fp3,fp4
	fmove.s	fp4,$18(a0)
	addq.l	#1,d2
L362
	cmp.l	#$10,d2
	blo	L361
L363
;		vBufPos += (4*XDRAW_TRIGSIZE+2);
	add.l	#$42,_vBufPos__xDRAW
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriFanTx(v, 4*XDRAW_TRIGSIZE+2, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$24(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$24(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "CircleScTxShC__xDRAW__r14PUjUjUjr11R08xTEXTURE:0",CODE


;void xDRAW::CircleScTxShC(ruint32* col, RICOORD2D p1, ruint32 rad, r
	XDEF	CircleScTxShC__xDRAW__r14PUjUjUjr11R08xTEXTURE
CircleScTxShC__xDRAW__r14PUjUjUjr11R08xTEXTURE
L376	EQU	-$40
	link	a5,#L376
	movem.l	d2-d6/a2/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	a6,-$30(a5)
	move.l	$C(a5),d2
	move.l	$8(a5),d5
L365
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L369
L366
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L368
L367
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L368
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L369
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp3
;		rfloat32 x = CoordX(p1);
	move.l	d5,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 y = CoordY(p1);
	move.l	d5,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 rfx = rad;
	fmove.l	d2,fp2
;		p1 = *(col++);
	move.l	-$30(a5),a0
	moveq	#4,d0
	add.l	d0,-$30(a5)
	move.l	(a0),d5
;		rad = 8;
	moveq	#$8,d2
;		ruint32 b = p1;
	move.l	d5,d1
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 g = p1;
	move.l	d5,d0
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 r = p1;
	move.l	d5,d3
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 a = cTab[(p1)];
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d4
;		rad = 0x000000FF;
	move.l	#$FF,d2
; r = cTab[(r&rad)];
	and.l	d2,d3
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d3.l*4),d3
; g = cTab[(g&rad)];
	and.l	d2,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&rad)];
	and.l	d2,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		VTX_X(v)=x;
	move.l	a2,a0
	fmove.s	fp0,(a0)
;	VTX_Y(v)=y;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp3,$8(a0)
;		WRITECOLOUR(VTX_C(v))
	lea	$20(a2),a0
;		WRITECOLOUR(VTX_C(v))
	move.l	d3,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d0,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d1,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d4,(a0)
;		p1 = *(col);
	move.l	-$30(a5),a0
	move.l	(a0),d5
; rad = 8;
	moveq	#$8,d2
;		b = p1;
	move.l	d5,d1
; p1 >>= rad;
	lsr.l	d2,d5
;		g = p1;
	move.l	d5,d0
; p1 >>= rad;
	lsr.l	d2,d5
;		rad = 0x000000FF;
	move.l	#$FF,d2
; r = cTab[(p1&rad)];
	and.l	d2,d5
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d3
; g = cTab[(g&rad)];
	and.l	d2,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&rad)];
	and.l	d2,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp4
	fsub.x	fp2,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp0,fp4
	fadd.x	fp2,fp4
	fmove.s	fp4,(a0)
;		
	fmove.s	fp1,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp4
	fadd.x	fp2,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp0,fp4
	fsub.x	fp2,fp4
	fmove.s	fp4,(a0)
;		
	fmove.s	fp1,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	moveq	#6,d5
	asl.l	d5,d2
	add.l	d2,a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp4
	fsub.x	fp2,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
;		
	moveq	#1,d2
	bra	L371
L370
;		
	move.l	#_sTab__xDRAW,a1
	fmove.x	fp2,fp5
	fmul.s	0(a1,d2.l*4),fp5
;		
	moveq	#$10,d5
	sub.l	d2,d5
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d5.l*4),fp4
	fmul.x	fp2,fp4
;		
	move.l	d2,d5
	asl.l	#6,d5
	lea	0(a2,d5.l),a0
	add.w	#$40,a0
;		
	fmove.x	fp0,fp6
	fadd.x	fp5,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp1,fp6
	fsub.x	fp4,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp0,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp1,fp6
	fadd.x	fp5,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp0,fp6
	fsub.x	fp5,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp1,fp6
	fadd.x	fp4,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp0,fp6
	fsub.x	fp4,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp1,fp4
	fsub.x	fp5,fp4
	fmove.s	fp4,4(a0)
;		
	fmove.d	fp3,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
	addq.l	#1,d2
L371
	cmp.l	#$10,d2
	blo	L370
L372
;			x		= (tx.x1 + tx.x2)/2F;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$28(a0),d1
	ext.l	d1
	add.l	d1,d0
	fmove.l	d0,fp0
	fdiv.s	#$.40000000,fp0
;			y		= (tx.y1 + tx.y2)/2F;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$2A(a0),d1
	ext.l	d1
	add.l	d1,d0
	fmove.l	d0,fp1
	fdiv.s	#$.40000000,fp1
;			rfx	= (tx.x2 - tx.x1)/2F;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$24(a0),d1
	ext.l	d1
	sub.l	d1,d0
	fmove.l	d0,fp2
	fdiv.s	#$.40000000,fp2
;			rfloat32 rfy	= (tx.y2 - tx.y1)/2F;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$26(a0),d1
	ext.l	d1
	sub.l	d1,d0
	fmove.l	d0,fp5
	fdiv.s	#$.40000000,fp5
;			
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;			
	move.l	a2,a0
	fmove.s	fp1,$18(a0)
;			
	moveq	#$10,d2
;			
	lea	$40(a2),a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$26(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	move.l	a3,a1
	move.w	$28(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$14(a0)
;			
	fmove.s	fp1,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$2A(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	move.l	a3,a1
	move.w	$24(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$14(a0)
;			
	fmove.s	fp1,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$26(a1),d0
	ext.l	d0
	fmove.l	d0,fp3
	fmove.s	fp3,$18(a0)
;			
	moveq	#1,d2
	bra	L374
L373
;			
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d2.l*4),fp4
;			
	moveq	#$10,d0
	sub.l	d2,d0
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d0.l*4),fp3
;			
	move.l	d2,d0
	asl.l	#6,d0
	lea	0(a2,d0.l),a0
	add.w	#$40,a0
;			
	fmove.x	fp2,fp6
	fmul.x	fp4,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp1,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmove.x	fp2,fp6
	fmul.x	fp3,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp5,fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmove.x	fp2,fp6
	fmul.x	fp4,fp6
	fmove.s	fp0,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp5,fp6
	fmul.x	fp3,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmul.x	fp2,fp3
	fmove.x	fp0,fp6
	fsub.x	fp3,fp6
	fmove.s	fp6,$14(a0)
;			
	fmove.x	fp5,fp3
	fmul.x	fp4,fp3
	fmove.x	fp1,fp4
	fsub.x	fp3,fp4
	fmove.s	fp4,$18(a0)
	addq.l	#1,d2
L374
	cmp.l	#$10,d2
	blo	L373
L375
;		vBufPos += (4*XDRAW_TRIGSIZE+2);
	add.l	#$42,_vBufPos__xDRAW
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriFanTx(v, 4*XDRAW_TRIGSIZE+2, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$40(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$40(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d6/a2/a6
	unlk	a5
	rts

	SECTION "ElipseScTx__xDRAW__UjUjUjr14R08xTEXTURE:0",CODE


;void xDRAW::ElipseScTx(ruint32 col, RICOORD2D p1, RICOORD2D rad, reg
	XDEF	ElipseScTx__xDRAW__UjUjUjr14R08xTEXTURE
ElipseScTx__xDRAW__UjUjUjr14R08xTEXTURE
L390	EQU	-$2C
	link	a5,#L390
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	a6,a3
	move.l	$10(a5),d2
	move.l	$8(a5),d3
	move.l	$C(a5),d4
L377
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L381
L378
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L380
L379
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L380
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L381
;	if (col != currentCol)
	cmp.l	_currentCol__xDRAW,d3
	beq.b	L383
L382
;		currentCol = col;
	move.l	d3,_currentCol__xDRAW
;		SetColour(col);
	lea	-$1C(a5),a0
	move.l	d3,d1
	move.l	#$FF0000,d0
	move.l	d1,d3
	and.l	d0,d3
	moveq	#$10,d5
	lsr.l	d5,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$8,d3
	lsr.l	d3,d0
	move.l	d1,d3
	and.l	d0,d3
	moveq	#$8,d5
	lsr.l	d5,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$8,d3
	lsr.l	d3,d0
	move.l	d1,d3
	and.l	d0,d3
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d3.l*4),(a0)+
	moveq	#$18,d3
	asl.l	d3,d0
	and.l	d0,d1
	moveq	#$18,d0
	lsr.l	d0,d1
	move.l	#_cTab__xDRAW,a2
	move.l	0(a2,d1.l*4),(a0)
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$1C(a5),a1
	jsr	-$168(a6)
L383
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp4
;		rfloat32 x = CoordX(p1);
	move.l	d4,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 y = CoordY(p1);
	move.l	d4,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 rfx = CoordX(rad);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;	rfloat32 rfy = CoordY(rad);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
;		VTX_X(v)=x;
	move.l	a2,a0
	fmove.s	fp0,(a0)
;	VTX_Y(v)=y;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp4,$8(a0)
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp5
	fsub.x	fp2,fp5
	fmove.s	fp5,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.x	fp0,fp5
	fadd.x	fp3,fp5
	fmove.s	fp5,(a0)
;		
	fmove.s	fp1,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp5
	fadd.x	fp2,fp5
	fmove.s	fp5,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;		
	fmove.x	fp0,fp5
	fsub.x	fp3,fp5
	fmove.s	fp5,(a0)
;		
	fmove.s	fp1,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	move.l	d2,d0
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp5
	fsub.x	fp2,fp5
	fmove.s	fp5,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	moveq	#1,d2
	bra	L385
L384
;		
	move.l	#_sTab__xDRAW,a1
	move.l	0(a1,d2.l*4),-$C(a5)
;		
	moveq	#$10,d0
	sub.l	d2,d0
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d0.l*4),fp5
;		
	move.l	d2,d0
	asl.l	#6,d0
	lea	0(a2,d0.l),a0
	add.w	#$40,a0
;		
	fmove.x	fp3,fp6
	fmul.s	-$C(a5),fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp2,fp6
	fmul.x	fp5,fp6
	fmove.s	fp1,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.x	fp3,fp6
	fmul.x	fp5,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp2,fp6
	fmul.s	-$C(a5),fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	add.w	#$400,a0
;		
	fmove.x	fp3,fp6
	fmul.s	-$C(a5),fp6
	fmove.s	fp0,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp2,fp6
	fmul.x	fp5,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	add.w	#$400,a0
;		
	fmul.x	fp3,fp5
	fmove.x	fp0,fp6
	fsub.x	fp5,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp2,fp5
	fmul.s	-$C(a5),fp5
	fmove.x	fp1,fp6
	fsub.x	fp5,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp4,$8(a0)
	addq.l	#1,d2
L385
	cmp.l	#$10,d2
	blo	L384
L386
;			x		= (tx.x1 + tx.x2)/2F;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$28(a0),d1
	ext.l	d1
	add.l	d1,d0
	fmove.l	d0,fp0
	fdiv.s	#$.40000000,fp0
;			y		= (tx.y1 + tx.y2)/2F;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$2A(a0),d1
	ext.l	d1
	add.l	d1,d0
	fmove.l	d0,fp1
	fdiv.s	#$.40000000,fp1
;			rfx	= (tx.x2 - tx.x1)/2F;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$24(a0),d1
	ext.l	d1
	sub.l	d1,d0
	fmove.l	d0,fp3
	fdiv.s	#$.40000000,fp3
;			rfy	= (tx.y2 - tx.y1)/2F;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$26(a0),d1
	ext.l	d1
	sub.l	d1,d0
	fmove.l	d0,fp2
	fdiv.s	#$.40000000,fp2
;			
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;			
	move.l	a2,a0
	fmove.s	fp1,$18(a0)
;			
	moveq	#$10,d2
;			
	lea	$40(a2),a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$26(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	move.l	a3,a1
	move.w	$28(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$14(a0)
;			
	fmove.s	fp1,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$2A(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	move.l	a3,a1
	move.w	$24(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$14(a0)
;			
	fmove.s	fp1,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$26(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$18(a0)
;			
	moveq	#1,d2
	bra	L388
L387
;			
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d2.l*4),fp5
;			
	moveq	#$10,d0
	sub.l	d2,d0
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d0.l*4),fp4
;			
	move.l	d2,d0
	asl.l	#6,d0
	lea	0(a2,d0.l),a0
	add.w	#$40,a0
;			
	fmove.x	fp3,fp6
	fmul.x	fp5,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp2,fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmove.x	fp3,fp6
	fmul.x	fp4,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp2,fp6
	fmul.x	fp5,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmove.x	fp3,fp6
	fmul.x	fp5,fp6
	fmove.s	fp0,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp2,fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmul.x	fp3,fp4
	fmove.x	fp0,fp6
	fsub.x	fp4,fp6
	fmove.s	fp6,$14(a0)
;			
	fmove.x	fp2,fp4
	fmul.x	fp5,fp4
	fmove.x	fp1,fp5
	fsub.x	fp4,fp5
	fmove.s	fp5,$18(a0)
	addq.l	#1,d2
L388
	cmp.l	#$10,d2
	blo	L387
L389
;		vBufPos += (4*XDRAW_TRIGSIZE+2);
	add.l	#$42,_vBufPos__xDRAW
;		Disable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriFanTx(v, 4*XDRAW_TRIGSIZE+2, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$2C(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$2C(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "ElipseScTxShC__xDRAW__r14PUjUjUjr11R08xTEXTURE:0",CODE


;void xDRAW::ElipseScTxShC(ruint32* col, RICOORD2D p1, RICOORD2D rad,
	XDEF	ElipseScTxShC__xDRAW__r14PUjUjUjr11R08xTEXTURE
ElipseScTxShC__xDRAW__r14PUjUjUjr11R08xTEXTURE
L402	EQU	-$48
	link	a5,#L402
	movem.l	d2-d6/a2/a6,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	a6,-$38(a5)
	move.l	$C(a5),d2
	move.l	$8(a5),d5
L391
;	if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) 
	move.l	_vBufPos__xDRAW,d0
	add.l	#$42,d0
	cmp.l	_vArraySize__xDRAW,d0
	blo.b	L395
L392
;	if (vBufPos+(4*XDR
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	jsr	-$138(a6)
	move.l	_vBufPos__xDRAW,d0
	cmp.l	_maxVBufPos__xDRAW,d0
	ble.b	L394
L393
	move.l	_vBufPos__xDRAW,_maxVBufPos__xDRAW
L394
	clr.l	_vBufPos__xDRAW
	and.l	#-3,_flags__xDRAW
	addq.l	#1,_flushCnt__xDRAW
L395
;	register sysVERTEX* v = vBuffer+vBufPos;
	move.l	_vBufPos__xDRAW,d0
	asl.l	#6,d0
	add.l	_vBuffer__xDRAW,d0
	move.l	d0,a2
;		rfloat64 d = zDepth;
	fmove.d	_zDepth__xDRAW,fp4
;		rfloat32 x = CoordX(p1);
	move.l	d5,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp0
;		rfloat32 y = CoordY(p1);
	move.l	d5,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp1
;		rfloat32 rfx = CoordX(rad);
	move.l	d2,d0
	moveq	#$10,d1
	asr.l	d1,d0
	ext.l	d0
	fmove.l	d0,fp3
;	rfloat32 rfy = CoordY(rad);
	move.l	d2,d0
	and.l	#$FFFF,d0
	ext.l	d0
	fmove.l	d0,fp2
;		p1 = *(col++);
	move.l	-$38(a5),a0
	moveq	#4,d0
	add.l	d0,-$38(a5)
	move.l	(a0),d5
;  rad = 8;
	moveq	#$8,d2
;		ruint32 b = p1;
	move.l	d5,d1
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 g = p1;
	move.l	d5,d0
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 r = p1;
	move.l	d5,d3
; p1 >>= rad;
	lsr.l	d2,d5
;		ruint32 a = cTab[(p1)];
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d4
;		rad = 0x000000FF;
	move.l	#$FF,d2
; r = cTab[(r&rad)];
	and.l	d2,d3
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d3.l*4),d3
; g = cTab[(g&rad)];
	and.l	d2,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&rad)];
	and.l	d2,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		VTX_X(v)=x;
	move.l	a2,a0
	fmove.s	fp0,(a0)
;	VTX_Y(v)=y;
	move.l	a2,a0
	fmove.s	fp1,4(a0)
;	VTX_Z(v)=d;
	move.l	a2,a0
	fmove.d	fp4,$8(a0)
;		WRITECOLOUR(VTX_C(v))
	lea	$20(a2),a0
;		WRITECOLOUR(VTX_C(v))
	move.l	d3,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d0,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d1,(a0)+
;		WRITECOLOUR(VTX_C(v))
	move.l	d4,(a0)
;		p1 = *(col);
	move.l	-$38(a5),a0
	move.l	(a0),d5
; rad = 8;
	moveq	#$8,d2
;		b = p1;
	move.l	d5,d1
; p1 >>= rad;
	lsr.l	d2,d5
;		g = p1;
	move.l	d5,d0
; p1 >>= rad;
	lsr.l	d2,d5
;		rad = 0x000000FF;
	move.l	#$FF,d2
; r = cTab[(p1&rad)];
	and.l	d2,d5
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d5.l*4),d3
; g = cTab[(g&rad)];
	and.l	d2,d0
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d0.l*4),d0
; b = cTab[(b&rad)];
	and.l	d2,d1
	move.l	#_cTab__xDRAW,a1
	move.l	0(a1,d1.l*4),d1
;		
	moveq	#$10,d2
;		
	lea	$40(a2),a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp5
	fsub.x	fp2,fp5
	fmove.s	fp5,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp0,fp5
	fadd.x	fp3,fp5
	fmove.s	fp5,(a0)
;		
	fmove.s	fp1,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp5
	fadd.x	fp2,fp5
	fmove.s	fp5,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	move.l	d2,d5
	moveq	#6,d6
	asl.l	d6,d5
	add.l	d5,a0
;		
	fmove.x	fp0,fp5
	fsub.x	fp3,fp5
	fmove.s	fp5,(a0)
;		
	fmove.s	fp1,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	moveq	#6,d5
	asl.l	d5,d2
	add.l	d2,a0
;		
	fmove.s	fp0,(a0)
;		
	fmove.x	fp1,fp5
	fsub.x	fp2,fp5
	fmove.s	fp5,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
;		
	moveq	#1,d2
	bra	L397
L396
;		
	move.l	#_sTab__xDRAW,a1
	move.l	0(a1,d2.l*4),-$34(a5)
;		
	moveq	#$10,d5
	sub.l	d2,d5
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d5.l*4),fp5
;		
	move.l	d2,d5
	asl.l	#6,d5
	lea	0(a2,d5.l),a0
	add.w	#$40,a0
;		
	fmove.x	fp3,fp6
	fmul.s	-$34(a5),fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp2,fp6
	fmul.x	fp5,fp6
	fmove.s	fp1,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp3,fp6
	fmul.x	fp5,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp2,fp6
	fmul.s	-$34(a5),fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmove.x	fp3,fp6
	fmul.s	-$34(a5),fp6
	fmove.s	fp0,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,(a0)
;		
	fmove.x	fp2,fp6
	fmul.x	fp5,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	lea	$20(a0),a1
;		
	move.l	d3,(a1)+
;		
	move.l	d0,(a1)+
;		
	move.l	d1,(a1)+
;		
	move.l	d4,(a1)
;		
	add.w	#$400,a0
;		
	fmul.x	fp3,fp5
	fmove.x	fp0,fp6
	fsub.x	fp5,fp6
	fmove.s	fp6,(a0)
;		
	fmove.x	fp2,fp5
	fmul.s	-$34(a5),fp5
	fmove.x	fp1,fp6
	fsub.x	fp5,fp6
	fmove.s	fp6,4(a0)
;		
	fmove.d	fp4,$8(a0)
;		
	add.w	#$20,a0
;		
	move.l	d3,(a0)+
;		
	move.l	d0,(a0)+
;		
	move.l	d1,(a0)+
;		
	move.l	d4,(a0)
	addq.l	#1,d2
L397
	cmp.l	#$10,d2
	blo	L396
L398
;			x		= (tx.x1 + tx.x2)/2F;
	move.l	a3,a0
	move.w	$24(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$28(a0),d1
	ext.l	d1
	add.l	d1,d0
	fmove.l	d0,fp0
	fdiv.s	#$.40000000,fp0
;			y		= (tx.y1 + tx.y2)/2F;
	move.l	a3,a0
	move.w	$26(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$2A(a0),d1
	ext.l	d1
	add.l	d1,d0
	fmove.l	d0,fp1
	fdiv.s	#$.40000000,fp1
;			rfx	= (tx.x2 - tx.x1)/2F;
	move.l	a3,a0
	move.w	$28(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$24(a0),d1
	ext.l	d1
	sub.l	d1,d0
	fmove.l	d0,fp3
	fdiv.s	#$.40000000,fp3
;			rfy	= (tx.y2 - tx.y1)/2F;
	move.l	a3,a0
	move.w	$2A(a0),d0
	ext.l	d0
	move.l	a3,a0
	move.w	$26(a0),d1
	ext.l	d1
	sub.l	d1,d0
	fmove.l	d0,fp2
	fdiv.s	#$.40000000,fp2
;			
	move.l	a2,a0
	fmove.s	fp0,$14(a0)
;			
	move.l	a2,a0
	fmove.s	fp1,$18(a0)
;			
	moveq	#$10,d2
;			
	lea	$40(a2),a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$26(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	move.l	a3,a1
	move.w	$28(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$14(a0)
;			
	fmove.s	fp1,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$2A(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	add.l	d0,a0
;			
	move.l	a3,a1
	move.w	$24(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$14(a0)
;			
	fmove.s	fp1,$18(a0)
;			
	move.l	d2,d0
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
;			
	fmove.s	fp0,$14(a0)
;			
	move.l	a3,a1
	move.w	$26(a1),d0
	ext.l	d0
	fmove.l	d0,fp4
	fmove.s	fp4,$18(a0)
;			
	moveq	#1,d2
	bra	L400
L399
;			
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d2.l*4),fp5
;			
	moveq	#$10,d0
	sub.l	d2,d0
	move.l	#_sTab__xDRAW,a1
	fmove.s	0(a1,d0.l*4),fp4
;			
	move.l	d2,d0
	asl.l	#6,d0
	lea	0(a2,d0.l),a0
	add.w	#$40,a0
;			
	fmove.x	fp3,fp6
	fmul.x	fp5,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp2,fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmove.x	fp3,fp6
	fmul.x	fp4,fp6
	fmove.s	fp0,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp2,fp6
	fmul.x	fp5,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmove.x	fp3,fp6
	fmul.x	fp5,fp6
	fmove.s	fp0,fp7
	fsub.x	fp6,fp7
	fmove.s	fp7,$14(a0)
;			
	fmove.x	fp2,fp6
	fmul.x	fp4,fp6
	fmove.s	fp1,fp7
	fadd.x	fp6,fp7
	fmove.s	fp7,$18(a0)
;			
	add.w	#$400,a0
;			
	fmul.x	fp3,fp4
	fmove.x	fp0,fp6
	fsub.x	fp4,fp6
	fmove.s	fp6,$14(a0)
;			
	fmove.x	fp2,fp4
	fmul.x	fp5,fp4
	fmove.x	fp1,fp5
	fsub.x	fp4,fp5
	fmove.s	fp5,$18(a0)
	addq.l	#1,d2
L400
	cmp.l	#$10,d2
	blo	L399
L401
;		vBufPos += (4*XDRAW_TRIGSIZE+2);
	add.l	#$42,_vBufPos__xDRAW
;		Enable(GOURAUD);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		Enable(TEXTURE);
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#1,d1
	jsr	-$30(a6)
;		TriFanTx(v, 4*XDRAW_TRIGSIZE+2, tx.tex);
	move.l	a3,a0
	move.l	$10(a0),a6
	lea	-$48(a5),a0
	move.l	#$42,(a0)+
	move.l	a2,(a0)+
	move.l	a6,(a0)+
	clr.l	(a0)+
	move.l	_context__sys3DDEVICE,a0
	move.l	_Warp3DBase,a6
	lea	-$48(a5),a1
	jsr	-$A8(a6)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2-d6/a2/a6
	unlk	a5
	rts

	END
