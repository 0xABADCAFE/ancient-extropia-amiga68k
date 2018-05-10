
; Storm C Compiler
; Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/GraphicsLib/Texture.cpp
	mc68030
	mc68881
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
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__UisE
	XREF	_strncmp
	XREF	_system
	XREF	_fread
	XREF	_fscanf
	XREF	_fclose
	XREF	_fopen
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

	SECTION "Create__xTEXTURE__TsssPvPUj:0",CODE


;sint32 xTEXTURE::Create(S_WH, sint16 f, void* data, uint32* pal)
	XDEF	Create__xTEXTURE__TsssPvPUj
Create__xTEXTURE__TsssPvPUj
L170	EQU	-$58
	link	a5,#L170
	movem.l	d2-d4/a2/a3/a6,-(a7)
	movem.l	$12(a5),a1/a2
	move.w	$E(a5),d2
	move.w	$C(a5),d3
	move.w	$10(a5),d4
L157
;	if (x3D::Context() == 0 || data == 0)
	move.l	_context__sys3DDEVICE,a0
	cmp.w	#0,a0
	beq.b	L159
L158
	cmp.w	#0,a1
	bne.b	L160
L159
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L160
;	if (ctx || source)
	move.l	$8(a5),a3
	tst.l	$C(a3)
	bne.b	L162
L161
	move.l	$8(a5),a3
	tst.l	$14(a3)
	beq.b	L163
L162
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L163
;	ctx = x3D::Context();
	move.l	_context__sys3DDEVICE,a0
	move.l	$8(a5),a3
	move.l	a0,$C(a3)
; source = data;
	move.l	$8(a5),a0
	move.l	a1,$14(a0)
;	if (pal && f == TXS_LUT_8)
	cmp.w	#0,a2
	beq.b	L166
L164
	tst.w	d4
	bne.b	L166
L165
;		TagItem tTags[] = {
	lea	-$30(a5),a0
	move.l	#$80201000,(a0)+
	move.l	$8(a5),a3
	move.l	$14(a3),(a0)+
	move.l	#$80201001,(a0)+
	move.l	#1,(a0)+
	move.l	#$80201002,(a0)+
	move.w	d3,d0
	ext.l	d0
	move.l	d0,(a0)+
	move.l	#$80201003,(a0)+
	move.w	d2,d0
	ext.l	d0
	move.l	d0,(a0)+
	move.l	#$80201005,(a0)+
	move.l	a2,(a0)+
	clr.l	(a0)+
	clr.l	(a0)
;		tex = W3D_AllocTexObj(ctx, &error, tTags);
	move.l	$8(a5),a0
	lea	$1C(a0),a1
	move.l	$8(a5),a3
	move.l	_Warp3DBase,a6
	move.l	$C(a3),a0
	lea	-$30(a5),a2
	jsr	-$60(a6)
	move.l	$8(a5),a1
	move.l	d0,$10(a1)
	bra.b	L167
L166
;		TagItem tTags[] = {
	lea	-$28(a5),a0
	move.l	#$80201000,(a0)+
	move.l	$8(a5),a2
	move.l	$14(a2),(a0)+
	move.l	#$80201001,(a0)+
	move.w	d4,d0
	ext.l	d0
	addq.l	#1,d0
	move.l	d0,(a0)+
	move.l	#$80201002,(a0)+
	move.w	d3,d0
	ext.l	d0
	move.l	d0,(a0)+
	move.l	#$80201003,(a0)+
	move.w	d2,d0
	ext.l	d0
	move.l	d0,(a0)+
	clr.l	(a0)+
	clr.l	(a0)
;		tex = W3D_AllocTexObj(ctx, &error, tTags);
	move.l	$8(a5),a0
	lea	$1C(a0),a1
	move.l	$8(a5),a3
	move.l	_Warp3DBase,a6
	move.l	$C(a3),a0
	lea	-$28(a5),a2
	jsr	-$60(a6)
	move.l	$8(a5),a1
	move.l	d0,$10(a1)
L167
;	if (tex)
	move.l	$8(a5),a1
	tst.l	$10(a1)
	beq.b	L169
L168
;		x1 = 0;
	move.l	$8(a5),a0
	clr.w	$24(a0)
; y1 = 0;
	move.l	$8(a5),a0
	clr.w	$26(a0)
;		x2 = width  = w;
	move.l	$8(a5),a0
	move.w	d3,(a0)
	move.l	$8(a5),a0
	move.w	d3,$28(a0)
;		y2 = height = h;
	move.l	$8(a5),a0
	move.w	d2,2(a0)
	move.l	$8(a5),a0
	move.w	d2,$2A(a0)
;		format	= f;
	move.l	$8(a5),a0
	move.w	d4,6(a0)
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L169
;	return ERR_RSC;
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts

	SECTION "Delete__xTEXTURE__T:0",CODE


;sint32 xTEXTURE::Delete()
	XDEF	Delete__xTEXTURE__T
Delete__xTEXTURE__T
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a7),a3
L171
;	if (tex==0)
	move.l	a3,a1
	move.l	$10(a1),a0
	cmp.w	#0,a0
	bne.b	L173
L172
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L173
;	if (ctx != x3D::Context())
	move.l	a3,a0
	move.l	$C(a0),a1
	move.l	_context__sys3DDEVICE,a0
	cmp.l	a0,a1
	beq.b	L175
L174
;		return ERR_PTR_INCONSISTENT;
	move.l	#-$3020005,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L175
;	W3D_FreeTexObj(ctx, tex);
	move.l	a3,a0
	move.l	$10(a0),a1
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	$C(a2),a0
	jsr	-$66(a6)
;	tex 		= 0;
	move.l	a3,a1
	clr.l	$10(a1)
;	ctx 		= 0;
	move.l	a3,a1
	clr.l	$C(a1)
;	if (flags & OWNDATA && source!=0)
	move.l	a3,a0
	move.l	$20(a0),d0
	and.l	#1,d0
	beq.b	L178
L176
	move.l	a3,a1
	move.l	$14(a1),a0
	cmp.w	#0,a0
	beq.b	L178
L177
;		MEM::Free(source);
	move.l	a3,a1
	move.l	$14(a1),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
L178
;	source	= 0;
	move.l	a3,a1
	clr.l	$14(a1)
;	palette = 0;
	move.l	a3,a1
	clr.l	$18(a1)
;	error		= 0;
	move.l	a3,a0
	clr.l	$1C(a0)
;	flags		= 0;
	move.l	a3,a0
	clr.l	$20(a0)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "Load__xTEXTURE__TPCcj:0",CODE


;sint32 xTEXTURE::Load(const char* name, sint32 forceFmt)
	XDEF	Load__xTEXTURE__TPCcj
Load__xTEXTURE__TPCcj
L199	EQU	-$2C
	link	a5,#L199
	movem.l	d2/a2/a3/a6,-(a7)
	move.l	$C(a5),a0
	move.l	$8(a5),a2
L181
;	FILE *f = fopen(name, "r");
	move.l	#L179,-(a7)
	move.l	a0,-(a7)
	jsr	_fopen
	addq.w	#$8,a7
	move.l	d0,a3
;	if (!f)
	cmp.w	#0,a3
	bne.b	L183
L182
;		return ERR_FILE_OPEN;
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts
L183
;	char sig[8] = {0};
	lea	-$C(a5),a0
	clr.b	(a0)+
	moveq	#6,d0
L200
	clr.b	(a0)+
	dbra	d0,L200
;	fread(sig, 1, 8, f);
	move.l	a3,-(a7)
	pea	$8.w
	pea	1.w
	pea	-$C(a5)
	jsr	_fread
	add.w	#$10,a7
;	if (strncmp(sig, "xTEX32B",7)!=0)
	pea	7.w
	move.l	#L180,-(a7)
	pea	-$C(a5)
	jsr	_strncmp
	add.w	#$C,a7
	tst.l	d0
	beq.b	L185
L184
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_FILE_OPEN;
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts
L185
;	uint32 frame[6] = {0};
	lea	-$24(a5),a0
	clr.l	(a0)+
	moveq	#4,d0
L201
	clr.l	(a0)+
	dbra	d0,L201
;	fread(frame, 4, 6, f);
	move.l	a3,-(a7)
	pea	6.w
	pea	4.w
	pea	-$24(a5)
	jsr	_fread
	add.w	#$10,a7
;	if (frame[0] > 512 || frame[1] > 512)
	move.l	-$24(a5),d0
	cmp.l	#$200,d0
	bhi.b	L187
L186
	lea	-$24(a5),a0
	move.l	4(a0),d0
	cmp.l	#$200,d0
	bls.b	L188
L187
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_VALUE_MAX;
	move.l	#-$3010002,d0
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts
L188
;	if (frame[0]<(frame[2]*frame[4]))
	lea	-$24(a5),a0
	move.l	$8(a0),d0
	lea	-$24(a5),a0
	mulu.l	$10(a0),d0
	move.l	-$24(a5),d2
	cmp.l	d0,d2
	bhs.b	L190
L189
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_FILE_CORRUPT;
	move.l	#-$3040003,d0
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts
L190
;	if (frame[1]<(frame[3]*frame[5]))
	lea	-$24(a5),a0
	move.l	4(a0),d2
	lea	-$24(a5),a0
	move.l	$C(a0),d0
	lea	-$24(a5),a0
	mulu.l	$14(a0),d0
	cmp.l	d0,d2
	bhs.b	L192
L191
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_FILE_CORRUPT;
	move.l	#-$3040003,d0
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts
L192
;	uint32* buffer = (uint32*)MEM::Alloc(frame[0]*frame[1]*4);
	clr.l	-(a7)
	clr.w	-(a7)
	lea	-$24(a5),a0
	move.l	-$24(a5),d0
	mulu.l	4(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,a6
;	if (!buffer)
	cmp.w	#0,a6
	bne.b	L194
L193
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts
L194
;	sint32 pix = fread(buffer, 4, frame[0]*frame[1], f);
	move.l	a3,-(a7)
	lea	-$24(a5),a0
	move.l	-$24(a5),d0
	mulu.l	4(a0),d0
	move.l	d0,-(a7)
	pea	4.w
	move.l	a6,-(a7)
	jsr	_fread
	add.w	#$10,a7
	move.l	d0,d2
;	fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;	if (pix!=frame[0]*frame[1])
	lea	-$24(a5),a0
	move.l	-$24(a5),d0
	mulu.l	4(a0),d0
	cmp.l	d0,d2
	beq.b	L196
L195
;		MEM::Free(buffer);
	move.l	a6,-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		return ERR_FILE_CORRUPT;
	move.l	#-$3040003,d0
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts
L196
;	if (Create(frame[0], frame[1], TXS_ARGB_8888, buffer)!=OK)
	clr.l	-(a7)
	move.l	a6,-(a7)
	move.w	#5,-(a7)
	lea	-$24(a5),a0
	move.w	6(a0),-(a7)
	move.w	-$22(a5),-(a7)
	move.l	a2,-(a7)
	jsr	Create__xTEXTURE__TsssPvPUj
	add.w	#$12,a7
	tst.l	d0
	beq.b	L198
L197
;		MEM::Free(buffer);
	move.l	a6,-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		return ERR_RSC;
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts
L198
;	flags |= OWNDATA|MULTICELL;
	or.l	#5,$20(a2)
;	cW		= frame[2];
	lea	-$24(a5),a0
	move.w	$A(a0),$2C(a2)
;	cH		= frame[3];
	lea	-$24(a5),a0
	move.w	$E(a0),$2E(a2)
;	cHrz	= frame[4];
	lea	-$24(a5),a0
	move.w	$12(a0),$30(a2)
;	cVrt	= frame[5];
	lea	-$24(a5),a0
	move.w	$16(a0),$32(a2)
;	curr	= 0;
	clr.w	$36(a2)
;	cells	= cHrz*cVrt;
	move.w	$32(a2),d0
	muls	$30(a2),d0
	move.w	d0,$34(a2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts

L179
	dc.b	'r',0
L180
	dc.b	'xTEX32B',0

	SECTION "LoadPPM__xTEXTURE__TPCcUj:0",CODE


;sint32 xTEXTURE::LoadPPM(const char* name, uint32 alphagen)
	XDEF	LoadPPM__xTEXTURE__TPCcUj
LoadPPM__xTEXTURE__TPCcUj
L225	EQU	-$30
	link	a5,#L225
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$10(a5),d3
	move.l	$C(a5),a0
	move.l	$8(a5),a6
L204
;	FILE *f = fopen(name, "r");
	move.l	#L202,-(a7)
	move.l	a0,-(a7)
	jsr	_fopen
	addq.w	#$8,a7
	move.l	d0,a2
;	if (!f)
	cmp.w	#0,a2
	bne.b	L206
L205
;		return ERR_FILE_OPEN;
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L206
;	sint32 i = fscanf(f, "P6\n%ld\n%ld\n255\n",&w, &h);
	pea	-$C(a5)
	pea	-$8(a5)
	move.l	#L203,-(a7)
	move.l	a2,-(a7)
	jsr	_fscanf
	add.w	#$10,a7
;	if (i!= 2)
	move.l	d0,d2
	cmp.l	#2,d2
	beq.b	L208
L207
;		fclose(f);
	move.l	a2,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_FILE_READ;
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L208
;	void *src = MEM::Alloc(w*h*4);
	clr.l	-(a7)
	clr.w	-(a7)
	move.l	-$8(a5),d0
	mulu.l	-$C(a5),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,a3
;	if (!src)
	cmp.w	#0,a3
	bne.b	L210
L209
;		fclose(f);
	move.l	a2,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L210
;	i = fread(src, 1, w*h*3, f);
	move.l	a2,-(a7)
	move.l	-$8(a5),d0
	mulu.l	-$C(a5),d0
	mulu.l	#3,d0
	move.l	d0,-(a7)
	pea	1.w
	move.l	a3,-(a7)
	jsr	_fread
	add.w	#$10,a7
	move.l	d0,d2
;	fclose(f);
	move.l	a2,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;	if (i != w*h*3)
	move.l	-$8(a5),d0
	mulu.l	-$C(a5),d0
	mulu.l	#3,d0
	cmp.l	d0,d2
	beq.b	L212
L211
;		MEM::Free(src);
	move.l	a3,-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		return ERR_FILE_CORRUPT;
	move.l	#-$3040003,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L212
;	i = (w*h)-1;
	move.l	-$8(a5),d2
	mulu.l	-$C(a5),d2
	subq.l	#1,d2
;		ruint8* s 	= (uint8*)src+(3*i);
	move.l	d2,d0
	muls.l	#3,d0
	lea	0(a3,d0.l),a0
;		ruint32* d	= (uint32*)src;
	move.l	a3,a1
;		if ((alphagen & 0x00FFFFFF) == 0)
	move.l	d3,d0
	and.l	#$FFFFFF,d0
	bne.b	L217
L213
;			i++;
	addq.l	#1,d2
;		for (ruint32 i=0; i < (
	bra.b	L215
L214
;				ruint32 x = alphagen | ((*s)<<16) | ((*(s+1))<<8) | (*(s+2));
	moveq	#0,d0
	move.b	(a0),d0
	moveq	#$10,d1
	asl.l	d1,d0
	or.l	d3,d0
	moveq	#0,d1
	move.b	1(a0),d1
	moveq	#$8,d4
	asl.l	d4,d1
	or.l	d1,d0
	moveq	#0,d1
	move.b	2(a0),d1
	or.l	d1,d0
;				d[i] = x;
	move.l	d0,0(a1,d2.l*4)
;		s-=3;
	moveq	#3,d0
	neg.l	d0
	add.l	d0,a0
L215
	subq.l	#1,d2
	tst.l	d2
	bpl.b	L214
L216
	bra	L222
L217
;			ruint32 red = ((alphagen & 0x00FF0000)>>16);
	move.l	d3,d5
	and.l	#$FF0000,d5
	moveq	#$10,d0
	lsr.l	d0,d5
;			ruint32 grn = ((alphagen & 0x0000FF00)>>8);
	move.l	d3,d4
	and.l	#$FF00,d4
	moveq	#$8,d0
	lsr.l	d0,d4
;			ruint32 blu = (alphagen & 0x000000FF);
	move.l	d3,d0
	and.l	#$FF,d0
	move.l	d0,d7
;			ruint32 alp = (alphagen >> 24);
	move.l	d3,d0
	moveq	#$18,d3
	lsr.l	d3,d0
	move.l	d0,-$24(a5)
;			ruint32 dvz = (red<<8) + (grn<<8) + (blu<<8);
	move.l	d5,d3
	moveq	#$8,d0
	asl.l	d0,d3
	move.l	d4,d0
	moveq	#$8,d1
	asl.l	d1,d0
	add.l	d0,d3
	move.l	d7,d0
	moveq	#$8,d1
	asl.l	d1,d0
	add.l	d0,d3
;			if (dvz == 0)
	bne.b	L219
L218
;				dvz = 65536*3;
	move.l	#$30000,d3
L219
;			i++;
	addq.l	#1,d2
;			while (--i>=0)
	bra.b	L221
L220
;				uint32 a = alp*(red*(*s)+grn*(*(s+1))+blu*(*(s+2)));
	moveq	#0,d0
	move.b	(a0),d0
	mulu.l	d5,d0
	moveq	#0,d1
	move.b	1(a0),d1
	mulu.l	d4,d1
	add.l	d1,d0
	moveq	#0,d1
	move.b	2(a0),d1
	mulu.l	d7,d1
	add.l	d1,d0
	mulu.l	-$24(a5),d0
;				a/=dvz;
	divul.l	d3,d0
;				d[i] = a<<24|((*s)<<16)|((*(s+1))<<8)|(*(s+2));
	moveq	#$18,d1
	asl.l	d1,d0
	moveq	#0,d1
	move.b	(a0),d1
	moveq	#$10,d6
	asl.l	d6,d1
	or.l	d1,d0
	moveq	#0,d1
	move.b	1(a0),d1
	moveq	#$8,d6
	asl.l	d6,d1
	or.l	d1,d0
	moveq	#0,d1
	move.b	2(a0),d1
	or.l	d1,d0
	move.l	d0,0(a1,d2.l*4)
; s-=3;
	moveq	#3,d0
	neg.l	d0
	add.l	d0,a0
L221
	subq.l	#1,d2
	tst.l	d2
	bpl.b	L220
L222
;	if (Create(w, h, TXS_ARGB_8888, src)!=OK)
	clr.l	-(a7)
	move.l	a3,-(a7)
	move.w	#5,-(a7)
	move.w	-$A(a5),-(a7)
	move.w	-6(a5),-(a7)
	move.l	a6,-(a7)
	jsr	Create__xTEXTURE__TsssPvPUj
	add.w	#$12,a7
	tst.l	d0
	beq.b	L224
L223
;		MEM::Free(src);
	move.l	a3,-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		return ERR_RSC;
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L224
;		flags |= OWNDATA;
	move.l	a6,a0
	move.l	$20(a0),d0
	or.l	#1,d0
	move.l	a6,a0
	move.l	d0,$20(a0)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

L203
	dc.b	'P6',$A,'%ld',$A,'%ld',$A,'255',$A,0
L202
	dc.b	'r',0

	SECTION "LoadLST__xTEXTURE__TPCcs:0",CODE


;sint32 xTEXTURE::LoadLST(const char *name, sint16 fmt)
	XDEF	LoadLST__xTEXTURE__TPCcs
LoadLST__xTEXTURE__TPCcs
L262	EQU	-$44
	link	a5,#L262
	movem.l	d2-d4/a2/a3/a6,-(a7)
	move.w	$10(a5),d3
	move.l	$C(a5),a0
	move.l	$8(a5),a2
L228
;	FILE *f = fopen(name, "r");
	move.l	#L226,-(a7)
	move.l	a0,-(a7)
	jsr	_fopen
	addq.w	#$8,a7
	move.l	d0,a3
;	if (!f)
	cmp.w	#0,a3
	bne.b	L230
L229
;		return ERR_FILE_OPEN;
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L230
;	char sig[8] = {0};
	lea	-$C(a5),a0
	clr.b	(a0)+
	moveq	#6,d0
L263
	clr.b	(a0)+
	dbra	d0,L263
;	fread(sig, 1, 8, f);
	move.l	a3,-(a7)
	pea	$8.w
	pea	1.w
	pea	-$C(a5)
	jsr	_fread
	add.w	#$10,a7
;	if (strncmp(sig, "xLST256",7)!=0)
	pea	7.w
	move.l	#L227,-(a7)
	pea	-$C(a5)
	jsr	_strncmp
	add.w	#$C,a7
	tst.l	d0
	beq.b	L232
L231
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_FILE_OPEN;
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L232
;	uint32 frame[6] = {0};
	lea	-$24(a5),a0
	clr.l	(a0)+
	moveq	#4,d0
L264
	clr.l	(a0)+
	dbra	d0,L264
;	fread(frame, 4, 6, f);
	move.l	a3,-(a7)
	pea	6.w
	pea	4.w
	pea	-$24(a5)
	jsr	_fread
	add.w	#$10,a7
;	if (frame[0] > 512 || frame[1] > 512)
	move.l	-$24(a5),d0
	cmp.l	#$200,d0
	bhi.b	L234
L233
	lea	-$24(a5),a0
	move.l	4(a0),d0
	cmp.l	#$200,d0
	bls.b	L235
L234
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_VALUE_MAX;
	move.l	#-$3010002,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L235
;	if (frame[0]<(frame[2]*frame[4]))
	lea	-$24(a5),a0
	move.l	$8(a0),d0
	lea	-$24(a5),a0
	mulu.l	$10(a0),d0
	move.l	-$24(a5),d2
	cmp.l	d0,d2
	bhs.b	L237
L236
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_FILE_CORRUPT;
	move.l	#-$3040003,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L237
;	if (frame[1]<(frame[3]*frame[5]))
	lea	-$24(a5),a0
	move.l	4(a0),d2
	lea	-$24(a5),a0
	move.l	$C(a0),d0
	lea	-$24(a5),a0
	mulu.l	$14(a0),d0
	cmp.l	d0,d2
	bhs.b	L239
L238
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_FILE_CORRUPT;
	move.l	#-$3040003,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L239
;	uint32 dataSize = 1024 + (frame[0]*frame[1]);
	lea	-$24(a5),a0
	move.l	-$24(a5),d0
	mulu.l	4(a0),d0
	move.l	d0,d2
	add.l	#$400,d2
;	void* buffer = MEM::Alloc(dataSize);
	clr.l	-(a7)
	clr.w	-(a7)
	move.l	d2,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,-$2C(a5)
;	if (!buffer)
	tst.l	-$2C(a5)
	bne.b	L241
L240
;		fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L241
;	fread(buffer, 1, dataSize, f);
	move.l	a3,-(a7)
	move.l	d2,-(a7)
	pea	1.w
	move.l	-$2C(a5),-(a7)
	jsr	_fread
	add.w	#$10,a7
;	fclose(f);
	move.l	a3,-(a7)
	jsr	_fclose
	addq.w	#4,a7
;	uint32* pal = (uint32*)buffer;
	move.l	-$2C(a5),a6
;	uint8*  dat = (uint8*)buffer+1024;
	move.l	#$400,d0
	add.l	-$2C(a5),d0
	move.l	d0,a3
;	if (fmt==TXS_LUT_8)
	tst.w	d3
	bne.b	L245
L242
;		if (Create(frame[0], frame[1], TXS_LUT_8, dat, pal)!=OK)
	move.l	a6,-(a7)
	move.l	a3,-(a7)
	clr.w	-(a7)
	lea	-$24(a5),a0
	move.w	6(a0),-(a7)
	move.w	-$22(a5),-(a7)
	move.l	a2,-(a7)
	jsr	Create__xTEXTURE__TsssPvPUj
	add.w	#$12,a7
	tst.l	d0
	beq.b	L244
L243
;			MEM::Free(buffer);
	move.l	-$2C(a5),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;			return ERR_RSC;
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L244
	bra	L261
L245
;	else if (fmt==TXS_ARGB_4444)
	cmp.w	#4,d3
	bne	L254
L246
;		uint16* destBuffer = (uint16*)MEM::Alloc(frame[0]*frame[1]*2);
	clr.l	-(a7)
	clr.w	-(a7)
	lea	-$24(a5),a0
	move.l	-$24(a5),d0
	mulu.l	4(a0),d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,-$38(a5)
;		if (!destBuffer)
	tst.l	-$38(a5)
	bne.b	L248
L247
;			MEM::Free(buffer);
	move.l	-$2C(a5),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L248
;		for (ruint32 i=0;
	moveq	#0,d2
	bra.b	L250
L249
;			ruint32 c = pal[(dat[i])];
	moveq	#0,d0
	move.b	0(a3,d2.l),d0
	move.l	0(a6,d0.l*4),d0
;			ruint16 t1 = (c & 0x000000F0)>>4;
	move.l	d0,d1
	and.l	#$F0,d1
	moveq	#4,d3
	lsr.l	d3,d1
;			t1 |= (c & 0x0000F000)>>8;
	move.l	d0,d3
	and.l	#$F000,d3
	moveq	#$8,d4
	lsr.l	d4,d3
	or.w	d3,d1
;			t1 |= (c & 0x00F00000)>>12;
	move.l	d0,d3
	and.l	#$F00000,d3
	moveq	#$C,d4
	lsr.l	d4,d3
	or.w	d3,d1
;			t1 |= (c & 0xF0000000)>>16;
	and.l	#-$10000000,d0
	moveq	#$10,d3
	lsr.l	d3,d0
	or.w	d0,d1
;			destBuffer[i]=t1;
	move.l	-$38(a5),a1
	move.w	d1,0(a1,d2.l*2)
	addq.l	#1,d2
L250
	lea	-$24(a5),a0
	move.l	-$24(a5),d0
	mulu.l	4(a0),d0
	cmp.l	d0,d2
	blo.b	L249
L251
;		MEM::Free(buffer);
	move.l	-$2C(a5),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		if (Create(frame[0], frame[1], TXS_ARGB_4444, destBuffer)!=OK)
	clr.l	-(a7)
	move.l	-$38(a5),-(a7)
	move.w	#4,-(a7)
	lea	-$24(a5),a0
	move.w	6(a0),-(a7)
	move.w	-$22(a5),-(a7)
	move.l	a2,-(a7)
	jsr	Create__xTEXTURE__TsssPvPUj
	add.w	#$12,a7
	tst.l	d0
	beq.b	L253
L252
;			MEM::Free(destBuffer);
	move.l	-$38(a5),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;			return ERR_RSC;
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L253
	bra	L261
L254
;		uint32* destBuffer = (uint32*)MEM::Alloc(frame[0]*frame[1]*4);
	clr.l	-(a7)
	clr.w	-(a7)
	lea	-$24(a5),a0
	move.l	-$24(a5),d0
	mulu.l	4(a0),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	d0,-$38(a5)
;		if (!destBuffer)
	tst.l	-$38(a5)
	bne.b	L256
L255
;			MEM::Free(buffer);
	move.l	-$2C(a5),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L256
;		for (uint32 i=0;
	moveq	#0,d0
	bra.b	L258
L257
;			destBuffer[i]=pal[(dat[i])];
	moveq	#0,d1
	move.b	0(a3,d0.l),d1
	move.l	-$38(a5),a1
	move.l	0(a6,d1.l*4),0(a1,d0.l*4)
	addq.l	#1,d0
L258
	lea	-$24(a5),a0
	move.l	-$24(a5),d1
	mulu.l	4(a0),d1
	cmp.l	d1,d0
	blo.b	L257
L259
;		MEM::Free(buffer);
	move.l	-$2C(a5),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		if (Create(frame[0], frame[1], TXS_ARGB_8888, destBuffer)!=OK)
	clr.l	-(a7)
	move.l	-$38(a5),-(a7)
	move.w	#5,-(a7)
	lea	-$24(a5),a0
	move.w	6(a0),-(a7)
	move.w	-$22(a5),-(a7)
	move.l	a2,-(a7)
	jsr	Create__xTEXTURE__TsssPvPUj
	add.w	#$12,a7
	tst.l	d0
	beq.b	L261
L260
;			MEM::Free(destBuffer);
	move.l	-$38(a5),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;			return ERR_RSC;
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts
L261
;	flags |= OWNDATA|MULTICELL;
	or.l	#5,$20(a2)
;	cW		= frame[2];
	lea	-$24(a5),a0
	move.w	$A(a0),$2C(a2)
;	cH		= frame[3];
	lea	-$24(a5),a0
	move.w	$E(a0),$2E(a2)
;	cHrz	= frame[4];
	lea	-$24(a5),a0
	move.w	$12(a0),$30(a2)
;	cVrt	= frame[5];
	lea	-$24(a5),a0
	move.w	$16(a0),$32(a2)
;	curr	= 0;
	clr.w	$36(a2)
;	cells	= cHrz*cVrt;
	move.w	$32(a2),d0
	muls	$30(a2),d0
	move.w	d0,$34(a2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts

L226
	dc.b	'r',0
L227
	dc.b	'xLST256',0

	SECTION "DefineCell__xTEXTURE__TUjss:0",CODE


;sint32 xTEXTURE::DefineCell(ICOORD2D cDim, sint16 h, sint16 v)
	XDEF	DefineCell__xTEXTURE__TUjss
DefineCell__xTEXTURE__TUjss
	movem.l	d2-d4,-(a7)
	move.l	$14(a7),d0
	move.w	$1A(a7),d2
	move.w	$18(a7),d3
	move.l	$10(a7),a0
L265
;	if ((h*CoordX(cDim)) > width || (v*CoordY(cDim)> height))
	move.l	d0,d1
	moveq	#$10,d4
	asr.l	d4,d1
	move.w	d3,d4
	muls	d1,d4
	move.w	(a0),d1
	ext.l	d1
	cmp.l	d1,d4
	bgt.b	L267
L266
	move.l	d0,d1
	and.l	#$FFFF,d1
	move.w	d2,d4
	muls	d1,d4
	move.w	2(a0),d1
	ext.l	d1
	cmp.l	d1,d4
	ble.b	L268
L267
;		return ERR_VALUE_MAX;
	move.l	#-$3010002,d0
	movem.l	(a7)+,d2-d4
	rts
L268
;	if (CoordX(cDim)<=0 || CoordY(cDim)<=0 || h<=0 || v<=0)
	move.l	d0,d1
	moveq	#$10,d4
	asr.l	d4,d1
	cmp.w	#0,d1
	ble.b	L272
L269
	move.l	d0,d1
	and.l	#$FFFF,d1
	cmp.w	#0,d1
	ble.b	L272
L270
	cmp.w	#0,d3
	ble.b	L272
L271
	cmp.w	#0,d2
	bgt.b	L273
L272
;		return ERR_VALUE_MIN;
	move.l	#-$3010004,d0
	movem.l	(a7)+,d2-d4
	rts
L273
;	cW = CoordX(cDim);
	move.l	d0,d1
	moveq	#$10,d4
	asr.l	d4,d1
	move.w	d1,$2C(a0)
; cH = CoordY(cDim);
	and.l	#$FFFF,d0
	move.w	d0,$2E(a0)
; cHrz = h;
	move.w	d3,$30(a0)
; cVrt = v;
	move.w	d2,$32(a0)
;	curr	= 0;
	clr.w	$36(a0)
;	cells	= cHrz*cVrt;
	move.w	$32(a0),d0
	muls	$30(a0),d0
	move.w	d0,$34(a0)
;	flags |= MULTICELL;
	or.l	#4,$20(a0)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4
	rts

	END
