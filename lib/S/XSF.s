
; Storm C Compiler
; extropialib:lib/Common/XSF/XSF.cpp
	mc68030
	mc68881
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
	XREF	_strcmp
	XREF	_strncmp
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
	XREF	_KeymapBase
	XREF	_useCount__xKEY

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "Value__XDATAID__TPCc:0",CODE


;uint32 XDATAID::Value(const char* text)
	XDEF	Value__XDATAID__TPCc
Value__XDATAID__TPCc
	move.l	$8(a7),a0
L68
;	register uint8* p = (uint8*)text;
;	ruint32 val = 0;
	moveq	#0,d0
;	while (*p) 
	bra.b	L70
L69
;	while (*p) val = (val<<1)^*p++;
	moveq	#1,d1
	asl.l	d1,d0
	moveq	#0,d1
	move.b	(a0)+,d1
	eor.l	d1,d0
L70
	tst.b	(a0)
	bne.b	L69
L71
;	return val;
	rts

	SECTION "_sigXSF__XSFHEAD:1",DATA

	XDEF	_sigXSF__XSFHEAD
_sigXSF__XSFHEAD
	dc.b	$58,$53,$46,0

	SECTION "CheckXSF__XSFHEAD__R07XSFHEAD:0",CODE


;uint32 XSFHEAD::CheckXSF(XSFHEAD& x)
	XDEF	CheckXSF__XSFHEAD__R07XSFHEAD
CheckXSF__XSFHEAD__R07XSFHEAD
	move.l	4(a7),a0
L73
;	uint32 result = 0;
	moveq	#0,d0
;	if (x.verXSF > XSF_VER)
	move.b	(a0),d1
	cmp.b	#1,d1
	bls.b	L75
L74
;		result |= XSF_VER_HIGHER;
	or.l	#4,d0
	bra.b	L77
L75
;	else if (x.verXSF < XSF_VER)
	tst.b	(a0)
	bne.b	L77
L76
;		result |= XSF_VER_LOWER;
	or.l	#$8,d0
L77
;	if (x.revXSF > XSF_REV)
	tst.b	1(a0)
	beq.b	L79
L78
;		result |= XSF_REV_HIGHER;
	or.l	#$10,d0
	bra.b	L81
L79
;	else if (x.revXSF < XSF_REV)
	bra.b	L81
L80
;		result |= XSF_REV_LOWER;
	or.l	#$20,d0
L81
;	return result;
	rts

	SECTION "op__notEqual__XSFHEAD__TR07XSFHEAD:0",CODE


;bool XSFHEAD::operator!=(XSFHEAD& x)
	XDEF	op__notEqual__XSFHEAD__TR07XSFHEAD
op__notEqual__XSFHEAD__TR07XSFHEAD
	movem.l	d2/a2,-(a7)
	move.l	$10(a7),a0
	move.l	$C(a7),a1
L82
;		register char *s1 = sig
	addq.w	#2,a1
;		register char *s1 = sig, *s2 = x.sig;
	addq.w	#2,a0
;		rsint16 i = 7;
	moveq	#7,d0
;		while (--i)
	bra.b	L85
L83
;			if ( *(s1++) != *(s2++) )
	move.b	(a1)+,d2
	cmp.b	(a0)+,d2
	beq.b	L85
L84
;				return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/a2
	rts
L85
	subq.w	#1,d0
	tst.w	d0
	bne.b	L83
L86
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "op__equal__XSFHEAD__TR07XSFHEAD:0",CODE


;uint32 XSFHEAD::operator==(XSFHEAD& x)
	XDEF	op__equal__XSFHEAD__TR07XSFHEAD
op__equal__XSFHEAD__TR07XSFHEAD
	movem.l	d2/d3/a2/a3,-(a7)
	movem.l	$14(a7),a2/a3
L87
;	if (*this!=x)
	move.l	a3,-(a7)
	move.l	a2,-(a7)
	jsr	op__notEqual__XSFHEAD__TR07XSFHEAD
	addq.w	#$8,a7
	tst.w	d0
	beq.b	L89
L88
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L89
;	uint32 result = CheckXSF(*this);
	move.l	a2,-(a7)
	jsr	CheckXSF__XSFHEAD__R07XSFHEAD
	addq.w	#4,a7
;/////////////////
	move.l	a3,a0
	move.b	$8(a0),d2
	cmp.b	$8(a2),d2
	bls.b	L91
L90
;		result |= VERSION_HIGHER;
	or.l	#$40,d0
	bra.b	L93
L91
;	else if (x.version < version)
	move.l	a3,a0
	move.b	$8(a0),d2
	cmp.b	$8(a2),d2
	bhs.b	L93
L92
;		result |= VERSION_LOWER;
	or.l	#$80,d0
L93
;	if (x.revision > revision)
	move.l	a3,a0
	move.b	$9(a0),d2
	cmp.b	$9(a2),d2
	bls.b	L95
L94
;		result |= REVISION_HIGHER;
	or.l	#$100,d0
	bra.b	L97
L95
;	else if (x.revision < revision)
	move.l	a3,a0
	move.b	$9(a0),d2
	cmp.b	$9(a2),d2
	bhs.b	L97
L96
;		result |= REVISION_LOWER;
	or.l	#$200,d0
L97
;	if (x.dataFormat != dataFormat)
	move.l	a3,a0
	move.b	$A(a0),d2
	cmp.b	$A(a2),d2
	beq.b	L102
L98
;		if ((x.dataFormat & XA_ENDIANMASK) != (dataFormat & XA_ENDIANMAS
	move.l	a3,a0
	moveq	#0,d2
	move.b	$A(a0),d2
	and.l	#$20,d2
	moveq	#0,d1
	move.b	$A(a2),d1
	and.l	#$20,d1
	cmp.l	d1,d2
	beq.b	L100
L99
;			result |= BYTESWAPPED;
	or.l	#$400,d0
L100
;		if ((x.dataFormat & XA_NEGATIVEMASK) != (dataFormat & XA_NEGATIV
	move.l	a3,a0
	moveq	#0,d2
	move.b	$A(a0),d2
	and.l	#$40,d2
	moveq	#0,d1
	move.b	$A(a2),d1
	and.l	#$40,d1
	cmp.l	d1,d2
	beq.b	L102
L101
;			result |= NEGATIVEFMT;
	or.l	#$800,d0
L102
;	if (x.fileOptions != fileOptions)
	move.l	a3,a0
	move.b	$B(a0),d2
	cmp.b	$B(a2),d2
	beq.b	L104
L103
;		result |= OTHERFILESPEC;
	or.l	#$1000,d0
L104
;	if (!result)
	tst.l	d0
	bne.b	L106
L105
;		result |= EXACT;
	or.l	#2,d0
L106
;	return result | SAMEFORMAT;
	or.l	#1,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts

	SECTION "Read__XSFHEAD__TR05XSFIO:0",CODE


;bool	XSFHEAD::Read(XSFIO& f)
	XDEF	Read__XSFHEAD__TR05XSFIO
Read__XSFHEAD__TR05XSFIO
L111	EQU	-4
	link	a5,#L111
	movem.l	a2/a3,-(a7)
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L107
;	char b[4] = {0};
	lea	-4(a5),a0
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
;	f.Read8(b,4);
	pea	4.w
	pea	-4(a5)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$8C(a0),d0
	move.l	d0,-(a7)
	move.l	$88(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;	if (b[3] || (strcmp((char*)sigXSF,b)!=0))
	lea	-4(a5),a0
	tst.b	3(a0)
	bne.b	L109
L108
	pea	-4(a5)
	move.l	#_sigXSF__XSFHEAD,-(a7)
	jsr	_strcmp
	addq.w	#$8,a7
	tst.l	d0
	beq.b	L110
L109
;		f.Seek(0, xIOS::START);
	move.l	#-1,-(a7)
	clr.l	-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$34(a0),d0
	move.l	d0,-(a7)
	move.l	$30(a0),a0
	jsr	(a0)
	add.w	#$C,a7
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3
	unlk	a5
	rts
L110
;	return f.Read8((void*)this, sizeof(XSFHEAD))==sizeof(XSFHEAD);
	pea	$C.w
	move.l	a3,-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$8C(a0),d0
	move.l	d0,-(a7)
	move.l	$88(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#$C,d0
	seq	d0
	and.l	#1,d0
	movem.l	(a7)+,a2/a3
	unlk	a5
	rts

	SECTION "Write__XSFHEAD__TR05XSFIO:0",CODE


;bool	XSFHEAD::Write(XSFIO& f)
	XDEF	Write__XSFHEAD__TR05XSFIO
Write__XSFHEAD__TR05XSFIO
	movem.l	a2/a3,-(a7)
	move.l	$10(a7),a2
	move.l	$C(a7),a3
L112
;	if (f.Write8(sigXSF,4)!=4)
	pea	4.w
	move.l	#_sigXSF__XSFHEAD,-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#4,d0
	beq.b	L114
L113
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3
	rts
L114
;	return f.Write8((void*)this, sizeof(XSFHEAD))==sizeof(XSFHEAD);
	pea	$C.w
	move.l	a3,-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#$C,d0
	seq	d0
	and.l	#1,d0
	movem.l	(a7)+,a2/a3
	rts

	SECTION "op__equal__XSFHEAD__TR05XSFIO:0",CODE


;uint32 XSFHEAD::operator==(XSFIO& f)
	XDEF	op__equal__XSFHEAD__TR05XSFIO
op__equal__XSFHEAD__TR05XSFIO
L120	EQU	-$18
	link	a5,#L120
	movem.l	d2/a2/a3,-(a7)
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L115
;	sint32 pos = f.Tell();
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$2C(a0),d0
	move.l	d0,-(a7)
	move.l	$28(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	d0,d2
;	if(pos<0)
	bpl.b	L117
L116
;		return ERR_FILE_READ;
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts
L117
;	if(pos>0)
	cmp.l	#0,d2
	ble.b	L119
L118
;		f.Seek(0, xIOS::START);
	move.l	#-1,-(a7)
	clr.l	-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$34(a0),d0
	move.l	d0,-(a7)
	move.l	$30(a0),a0
	jsr	(a0)
	add.w	#$C,a7
L119
;	XSFHEAD t;
	lea	-$10(a5),a0
	move.b	#1,(a0)
	clr.b	1(a0)
	clr.b	2(a0)
;	t.Read(f);
	move.l	a2,-(a7)
	pea	-$10(a5)
	jsr	Read__XSFHEAD__TR05XSFIO
	addq.w	#$8,a7
;	f.Seek(pos, xIOS::START);
	move.l	#-1,-(a7)
	move.l	d2,-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$34(a0),d0
	move.l	d0,-(a7)
	move.l	$30(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	pea	-$10(a5)
	move.l	a3,-(a7)
	jsr	op__equal__XSFHEAD__TR07XSFHEAD
	addq.w	#$8,a7
	movem.l	(a7)+,d2/a2/a3
	unlk	a5
	rts

	SECTION "Set__XSFHEAD__TPCcUcUcUcUc:0",CODE


;void XSFHEAD::Set(const char* id, uint8 ver, uint8 rev, uint8 df, ui
	XDEF	Set__XSFHEAD__TPCcUcUcUcUc
Set__XSFHEAD__TPCcUcUcUcUc
	movem.l	d2-d6/a2/a3,-(a7)
	move.b	$2E(a7),d2
	move.b	$2C(a7),d3
	move.b	$2A(a7),d4
	move.b	$28(a7),d5
	move.l	$24(a7),a0
	move.l	$20(a7),a3
L121
;	char* tID = (char*)id;
	move.l	a0,a1
;		rsint16	i = 7;
	moveq	#7,d0
; register char* s = sig;
	lea	2(a3),a0
;		while (--i)
	bra.b	L124
L122
;			if ( !((*s++)=(*tID++)) )	
	move.b	(a1)+,d1
	move.b	d1,(a0)+
	bne.b	L124
L123
;			if ( !((*s++)=(*tID++)) )	
	bra.b	L125
L124
	subq.w	#1,d0
	tst.w	d0
	bne.b	L122
L125
;		if (i++)
	move.w	d0,d1
	addq.w	#1,d0
	tst.w	d1
	beq.b	L129
L126
;			while (--i)	
	bra.b	L128
L127
;			while (--i)	*s++ = 0;
	clr.b	(a0)+
L128
	subq.w	#1,d0
	tst.w	d0
	bne.b	L127
L129
;	version = ver;
	move.b	d5,$8(a3)
;	revision = rev;
	move.b	d4,$9(a3)
;	dataFormat = df;
	move.b	d3,$A(a3)
;	fileOptions = ff;
	move.b	d2,$B(a3)
	movem.l	(a7)+,d2-d6/a2/a3
	rts

	SECTION "Define__XSFBASIC__TPCcUcUcUcUc:0",CODE


;sint32 XSFBASIC::Define(const char* id, uint8 ver, uint8 rev, uint8 
	XDEF	Define__XSFBASIC__TPCcUcUcUcUc
Define__XSFBASIC__TPCcUcUcUcUc
	movem.l	d2-d5/a2/a3,-(a7)
	movem.l	$1C(a7),a2/a3
	move.b	$24(a7),d2
	move.b	$26(a7),d3
	move.b	$28(a7),d4
	move.b	$2A(a7),d5
L130
;	if (Valid())
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$DC(a0),d0
	move.l	d0,-(a7)
	move.l	$D8(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	tst.w	d0
	beq.b	L132
L131
;		return ERR_FILE;
	move.l	#-$3040000,d0
	movem.l	(a7)+,d2-d5/a2/a3
	rts
L132
;	XSFHEAD::Set(id, ver, rev, df, ff);
	move.b	d5,-(a7)
	move.b	d4,-(a7)
	move.b	d3,-(a7)
	move.b	d2,-(a7)
	move.l	a3,-(a7)
	cmp.w	#0,a2
	beq.b	L134
L133
	addq.w	#4,a2
L134
	move.l	a2,-(a7)
	jsr	Set__XSFHEAD__TPCcUcUcUcUc
	add.w	#$10,a7
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3
	rts

	SECTION "Create__XSFBASIC__TPCcj:0",CODE


;sint32 XSFBASIC::Create(const char* fileName, sint32 bufferSize)
	XDEF	Create__XSFBASIC__TPCcj
Create__XSFBASIC__TPCcj
	move.l	a2,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),a0
	move.l	$8(a7),a2
L135
;	if (xFILEIO::Open(fileName, xIOS::WRITE, bufferSize)!=OK)
	move.l	d0,-(a7)
	pea	2.w
	move.l	a0,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L137
L136
	add.w	#$10,a0
L137
	move.l	a0,-(a7)
	jsr	Open__xFILEIO__TPCcjj
	add.w	#$10,a7
	tst.l	d0
	beq.b	L139
L138
;		return ERR_FILE_CREATE;
	move.l	#-$3040006,d0
	move.l	(a7)+,a2
	rts
L139
;	if (XSFHEAD::Write(*this))
	move.l	a2,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L141
L140
	addq.w	#4,a0
L141
	move.l	a0,-(a7)
	jsr	Write__XSFHEAD__TR05XSFIO
	addq.w	#$8,a7
	tst.w	d0
	beq.b	L151
L142
;		if ((dataFormat & XA_ENDIANMASK) != (X_HARDWARE & XA_ENDIANMASK))
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L144
L143
	addq.w	#4,a0
L144
	moveq	#0,d0
	move.b	$A(a0),d0
	and.l	#$20,d0
	beq.b	L146
L145
;			flags |= BYTESWAPPED;
	or.l	#$400,$AA(a2)
L146
;		if ((dataFormat & XA_NEGATIVEMASK) != (X_HARDWARE & XA_NEGATIVEM
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L148
L147
	addq.w	#4,a0
L148
	moveq	#0,d0
	move.b	$A(a0),d0
	and.l	#$40,d0
	beq.b	L150
L149
;			flags |= NEGATIVEFMT;
	or.l	#$800,$AA(a2)
L150
;		return OK;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts
L151
;	xFILEIO::Close();
	cmp.w	#0,a2
	beq.b	L153
L152
	add.w	#$10,a2
L153
	move.l	a2,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
;	return ERR_FILE_CREATE;
	move.l	#-$3040006,d0
	move.l	(a7)+,a2
	rts

	SECTION "Open__XSFBASIC__TPCcsjj:0",CODE


;sint32 XSFBASIC::Open(const char* fileName, bool override, sint32 mo
	XDEF	Open__XSFBASIC__TPCcsjj
Open__XSFBASIC__TPCcsjj
	movem.l	d2/d3/a2,-(a7)
	move.l	$1E(a7),d0
	move.l	$1A(a7),d1
	move.w	$18(a7),d3
	move.l	$14(a7),a0
	move.l	$10(a7),a2
L154
;	if (mode==xIOS::WRITE)
	cmp.l	#2,d1
	bne.b	L156
L155
;		return Create(fileName, bufferSize);
	move.l	d0,-(a7)
	move.l	a0,-(a7)
	move.l	a2,-(a7)
	jsr	Create__XSFBASIC__TPCcj
	add.w	#$C,a7
	movem.l	(a7)+,d2/d3/a2
	rts
L156
;	if (xFILEIO::Open(fileName, mode, bufferSize)!=OK)
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	move.l	a0,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L158
L157
	add.w	#$10,a0
L158
	move.l	a0,-(a7)
	jsr	Open__xFILEIO__TPCcjj
	add.w	#$10,a7
	tst.l	d0
	beq.b	L160
L159
;		return ERR_FILE_OPEN;
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L160
;	uint32 r = (XSFHEAD&)(*this)==((XSFIO&)(*this));
	move.l	a2,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L162
L161
	addq.w	#4,a0
L162
	move.l	a0,-(a7)
	jsr	op__equal__XSFHEAD__TR05XSFIO
	addq.w	#$8,a7
	move.l	d0,d2
;	if (!r)
	bne.b	L166
L163
;		xFILEIO::Close();
	cmp.w	#0,a2
	beq.b	L165
L164
	add.w	#$10,a2
L165
	move.l	a2,-(a7)
	jsr	Close__xFILEIO__T
	addq.w	#4,a7
;		return ERR_FILE;
	move.l	#-$3040000,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L166
;	if (override)
	tst.w	d3
	beq.b	L170
L167
;		XSFHEAD::Read((XSFIO&)*this);
	move.l	a2,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L169
L168
	addq.w	#4,a0
L169
	move.l	a0,-(a7)
	jsr	Read__XSFHEAD__TR05XSFIO
	addq.w	#$8,a7
	bra.b	L173
L170
;		xFILEIO::Seek(XSFHEADERSIZE, xIOS::START);
	move.l	#-1,-(a7)
	pea	$10.w
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L172
L171
	add.w	#$10,a0
L172
	move.l	a0,-(a7)
	jsr	Seek__xFILEIO__Tjj
	add.w	#$C,a7
L173
;	flags = r;
	move.l	d2,$AA(a2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "_fileMarker__XSFOBJ:1",DATA

	XDEF	_fileMarker__XSFOBJ
_fileMarker__XSFOBJ
	dc.b	$78,$73,$66,0

	SECTION "_0ct__XSFOBJ__T:0",CODE


;XSFOBJ::XSFOBJ() 
	XDEF	_0ct__XSFOBJ__T
_0ct__XSFOBJ__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L176
	move.l	#L175,-(a7)
	move.l	a2,-(a7)
	jsr	Value__XDATAID__TPCc
	addq.w	#$8,a7
	move.l	d0,(a2)
	clr.w	4(a2)
	clr.w	6(a2)
	clr.w	$8(a2)
	clr.w	$A(a2)
	clr.l	$C(a2)
	clr.l	$10(a2)
	clr.l	$14(a2)
	clr.w	$18(a2)
	clr.b	$1A(a2)
	clr.b	$1B(a2)
	move.l	(a7)+,a2
	rts

L175
	dc.b	'Undefined',0

	SECTION "_0ct__XSFOBJ__TPCcUsUsUcUc:0",CODE


;XSFOBJ::XSFOBJ(const char* desc, uint16 super, uint16 sub, u
	XDEF	_0ct__XSFOBJ__TPCcUsUsUcUc
_0ct__XSFOBJ__TPCcUsUsUcUc
	movem.l	d2-d5/a2,-(a7)
	move.b	$26(a7),d2
	move.b	$24(a7),d3
	move.w	$22(a7),d4
	move.w	$20(a7),d5
	move.l	$1C(a7),a0
	move.l	$18(a7),a2
L177
	move.l	a0,-(a7)
	move.l	a2,-(a7)
	jsr	Value__XDATAID__TPCc
	addq.w	#$8,a7
	move.l	d0,(a2)
	move.w	d5,4(a2)
	move.w	d4,6(a2)
	clr.w	$8(a2)
	clr.w	$A(a2)
	clr.l	$C(a2)
	clr.l	$10(a2)
	clr.l	$14(a2)
	clr.w	$18(a2)
	move.b	d3,$1A(a2)
	move.b	d2,$1B(a2)
	movem.l	(a7)+,d2-d5/a2
	rts

	SECTION "Write__XSFOBJ__TR05XSFIO:0",CODE


;sint32	XSFOBJ::Write(XSFIO& f)
	XDEF	Write__XSFOBJ__TR05XSFIO
Write__XSFOBJ__TR05XSFIO
	movem.l	a2/a3,-(a7)
	move.l	$10(a7),a2
	move.l	$C(a7),a3
L178
;	sint32 r = ReadyForWrite();
	move.l	a3,a1
	move.l	$1C(a1),a0
	move.l	a3,d0
	add.l	$2C(a0),d0
	move.l	d0,-(a7)
	move.l	$28(a0),a0
	jsr	(a0)
	addq.w	#4,a7
;	if (r!=OK)
	tst.l	d0
	beq.b	L180
L179
;		return r;
	movem.l	(a7)+,a2/a3
	rts
L180
;	fileMarker[3] = f.DataFormat();
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$1C(a0),d0
	move.l	d0,-(a7)
	move.l	$18(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	#_fileMarker__XSFOBJ,a1
	move.b	d0,3(a1)
;	if (f.Write8(fileMarker,4)!=4 || f.Write32(&chunkID,1)!=1 || f.Wri
	pea	4.w
	move.l	#_fileMarker__XSFOBJ,-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#4,d0
	bne	L186
L181
	pea	1.w
	move.l	a3,-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	bne	L186
L182
	pea	4.w
	pea	4(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#4,d0
	bne.b	L186
L183
	pea	3.w
	pea	$C(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$5C(a0),d0
	move.l	d0,-(a7)
	move.l	$58(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#3,d0
	bne.b	L186
L184
	pea	1.w
	pea	$18(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$64(a0),d0
	move.l	d0,-(a7)
	move.l	$60(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	bne.b	L186
L185
	pea	2.w
	pea	$1A(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#2,d0
	beq.b	L187
L186
;		return ERR_FILE_WRITE;
	move.l	#-$3040005,d0
	movem.l	(a7)+,a2/a3
	rts
L187
;	r = WriteBody(f);
	move.l	a2,-(a7)
	move.l	a3,a1
	move.l	$1C(a1),a0
	move.l	a3,d0
	add.l	$1C(a0),d0
	move.l	d0,-(a7)
	move.l	$18(a0),a0
	jsr	(a0)
	addq.w	#$8,a7
;	if (r<0)
	tst.l	d0
	bpl.b	L189
L188
;		return r;
	movem.l	(a7)+,a2/a3
	rts
L189
;	return r+XSFOBJ_FILESIZE;
	add.l	#$20,d0
	movem.l	(a7)+,a2/a3
	rts

	SECTION "Read__XSFOBJ__TR05XSFIO:0",CODE


;sint32	XSFOBJ::Read(XSFIO& f)
	XDEF	Read__XSFOBJ__TR05XSFIO
Read__XSFOBJ__TR05XSFIO
L204	EQU	-$8
	link	a5,#L204
	movem.l	a2/a3,-(a7)
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L190
;	sint32 r = ReadyForRead();
	move.l	a3,a1
	move.l	$1C(a1),a0
	move.l	a3,d0
	add.l	$24(a0),d0
	move.l	d0,-(a7)
	move.l	$20(a0),a0
	jsr	(a0)
	addq.w	#4,a7
;	if (r!=OK)
	tst.l	d0
	beq.b	L192
L191
;		return r;
	movem.l	(a7)+,a2/a3
	unlk	a5
	rts
L192
;	char b[4] = {0};
	lea	-$8(a5),a0
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
;	if (f.Read8(b,4)!=4 || (strncmp(b,(char*)fileMarker,3)!=0))
	pea	4.w
	pea	-$8(a5)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$8C(a0),d0
	move.l	d0,-(a7)
	move.l	$88(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#4,d0
	bne.b	L194
L193
	pea	3.w
	move.l	#_fileMarker__XSFOBJ,-(a7)
	pea	-$8(a5)
	jsr	_strncmp
	add.w	#$C,a7
	tst.l	d0
	beq.b	L195
L194
;		return ERR_FILE_READ;
	move.l	#-$3040004,d0
	movem.l	(a7)+,a2/a3
	unlk	a5
	rts
L195
;	if (f.Read32(&chunkID,1)!=1 || f.Read16(&superClass,4)!=4 || f.Rea
	pea	1.w
	move.l	a3,-(a7)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	bne	L200
L196
	pea	4.w
	pea	4(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$84(a0),d0
	move.l	d0,-(a7)
	move.l	$80(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#4,d0
	bne.b	L200
L197
	pea	3.w
	pea	$C(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$7C(a0),d0
	move.l	d0,-(a7)
	move.l	$78(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#3,d0
	bne.b	L200
L198
	pea	1.w
	pea	$18(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$84(a0),d0
	move.l	d0,-(a7)
	move.l	$80(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#1,d0
	bne.b	L200
L199
	pea	2.w
	pea	$1A(a3)
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$8C(a0),d0
	move.l	d0,-(a7)
	move.l	$88(a0),a0
	jsr	(a0)
	add.w	#$C,a7
	cmp.l	#2,d0
	beq.b	L201
L200
;		return ERR_FILE_READ;
	move.l	#-$3040004,d0
	movem.l	(a7)+,a2/a3
	unlk	a5
	rts
L201
;	r = ReadBody(f);
	move.l	a2,-(a7)
	move.l	a3,a1
	move.l	$1C(a1),a0
	move.l	a3,d0
	add.l	$14(a0),d0
	move.l	d0,-(a7)
	move.l	$10(a0),a0
	jsr	(a0)
	addq.w	#$8,a7
;	if (r<0)
	tst.l	d0
	bpl.b	L203
L202
;		return r;
	movem.l	(a7)+,a2/a3
	unlk	a5
	rts
L203
;	return r+XSFOBJ_FILESIZE;
	add.l	#$20,d0
	movem.l	(a7)+,a2/a3
	unlk	a5
	rts

	END
