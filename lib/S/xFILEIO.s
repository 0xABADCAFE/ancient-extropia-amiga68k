
; Storm C Compiler
; extropialib:lib/Platforms/Amiga68k/IOLib/xFILEIO.cpp
	mc68030
	mc68881
	XREF	InputQueued__xINPUT__T
	XREF	Idle__xINPUT__T
	XREF	ExitEvent__xINPUT__T
	XREF	MouseEvent__xINPUT__Tjjj
	XREF	ApplyInputModification__xINPUT__T
	XREF	_0dt__xKEY__T
	XREF	_0ct__xKEY__T
	XREF	KeyEvent__xKEY__Tjsj
	XREF	Swap64__MEM__r8Pvr9Pvr0Ui
	XREF	Swap32__MEM__r8Pvr9Pvr0Ui
	XREF	Swap16__MEM__r8Pvr9Pvr0Ui
	XREF	Copy__MEM__r8Pvr9Pvr0Ui
	XREF	Free__MEM__Pv
	XREF	Alloc__MEM__UisE
	XREF	_system
	XREF	_vsprintf
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

	SECTION "Exists__xFILEIO__PCc:0",CODE


;bool xFILEIO::Exists(const char* fileName)
	XDEF	Exists__xFILEIO__PCc
Exists__xFILEIO__PCc
	movem.l	d2/a6,-(a7)
	move.l	$C(a7),a0
L124
;	BPTR handle = ::Open(fileName,MODE_OLDFILE);
	move.l	_DOSBase,a6
	move.l	a0,d1
	move.l	#$3ED,d2
	jsr	-$1E(a6)
	move.l	d0,d1
;	if (handle)
	beq.b	L126
L125
;		::Close(handle);
	move.l	_DOSBase,a6
	jsr	-$24(a6)
;		return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/a6
	rts
L126
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/a6
	rts

	SECTION "ReadText__xFILEIO__TPcjcj:0",CODE


;sint32 xFILEIO::ReadText(char* buf, sint32 max, char mark, sint32 nu
	XDEF	ReadText__xFILEIO__TPcjcj
ReadText__xFILEIO__TPcjcj
	movem.l	d2-d6/a2/a3/a6,-(a7)
	move.l	$32(a7),d4
	move.b	$30(a7),d5
	move.l	$2C(a7),d6
	move.l	$28(a7),a0
	move.l	$24(a7),a3
L127
;	char* p = buf;
	move.l	a0,a2
;	rsint32 i = max;
	move.l	d6,d3
;	while (--i && num)
	bra	L143
L128
;		rsint32 c = GetChar();
	move.l	a3,a6
	tst.l	$18(a6)
	bne	L136
L129
	move.l	a6,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	move.l	d0,d2
	cmp.l	#0,d2
	bgt.b	L133
L130
	tst.l	d2
	bne.b	L132
L131
	or.l	#$10,$96(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra.b	L137
L132
	and.l	#-$41,$96(a6)
	move.l	#-$3040004,d0
	bra.b	L137
L133
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$20(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d2,d0
	bls.b	L135
L134
	move.l	d2,$92(a6)
L135
	lea	$20(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),d0
	add.l	$92(a6),d0
	move.l	d0,$14(a6)
	moveq	#1,d0
	sub.l	$8E(a6),d0
	move.l	d0,$8E(a6)
	sub.l	$92(a6),d2
	move.l	d2,$18(a6)
	clr.l	$92(a6)
L136
	move.l	$14(a6),a0
	move.b	(a0),d1
	subq.l	#1,$18(a6)
	addq.l	#1,$14(a6)
	move.b	d1,d0
	extb.l	d0
L137
;		if (c==ERR_FILE_READ || c==EOF) // terminate if error
	cmp.l	#-$3040004,d0
	beq.b	L139
L138
	cmp.l	#-1,d0
	bne.b	L140
L139
;			
	bra.b	L145
L140
;		if (c==(sint32)mark)
	move.b	d5,d1
	extb.l	d1
	cmp.l	d1,d0
	bne.b	L142
L141
;			num--;
	subq.l	#1,d4
L142
;		*(p++) = (char)c;
	move.b	d0,(a2)+
L143
	subq.l	#1,d3
	tst.l	d3
	beq.b	L145
L144
	tst.l	d4
	bne	L128
L145
;	*p = 0;
	move.l	a2,a0
	clr.b	(a0)
;	return (max-i);
	move.l	d6,d0
	sub.l	d3,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	rts

	SECTION "WriteText__xFILEIO__TPce:0",CODE


;sint32 xFILEIO::WriteText(char* format,...)
	XDEF	WriteText__xFILEIO__TPce
WriteText__xFILEIO__TPce
L147	EQU	-$8
	link	a5,#L147
	move.l	a2,-(a7)
	move.l	$8(a5),a2
L146
;	va_start(a,format)
	lea	$C(a5),a0
	move.l	a0,d0
	addq.l	#4,d0
;	sint32 num = vsprintf(sysBASELIB::MsgBuf(),format,a);
	move.l	d0,-(a7)
	move.l	$C(a5),-(a7)
	move.l	_msgbuff__sysBASELIB,a0
	move.l	a0,-(a7)
	jsr	_vsprintf
	add.w	#$C,a7
;	return Write(sysBASELIB::MsgBuf(), 1, num);
	move.l	d0,-(a7)
	pea	1.w
	move.l	_msgbuff__sysBASELIB,a0
	move.l	a0,-(a7)
	move.l	a2,-(a7)
	jsr	Write__xFILEIO__TPvUiUi
	add.w	#$10,a7
	move.l	(a7)+,a2
	unlk	a5
	rts

	SECTION "SendPacket__xFILEIO__TPv:0",CODE


;void xFILEIO::SendPacket(void* arg2)
	XDEF	SendPacket__xFILEIO__TPv
SendPacket__xFILEIO__TPv
	movem.l	a2/a3/a6,-(a7)
	move.l	$14(a7),a1
	move.l	$10(a7),a3
L148
;	af_Packet.sp_Pkt.dp_Port = &af_PacketPort;
	lea	$6C(a3),a0
	move.l	a3,a2
	move.l	a0,$40(a2)
;	af_Packet.sp_Pkt.dp_Arg2 = (sint32)arg2;
	move.l	a3,a0
	move.l	a1,$54(a0)
;	PutMsg(af_Handler, &af_Packet.sp_Msg);
	move.l	a3,a2
	move.l	_SysBase,a6
	move.l	$10(a2),a0
	lea	$28(a3),a1
	jsr	-$16E(a6)
;	flags |= WAIT_PACKET;
	move.l	a3,a0
	move.l	$96(a0),d0
	or.l	#$8,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "WaitPacket__xFILEIO__T:0",CODE


;sint32 xFILEIO::WaitPacket()
	XDEF	WaitPacket__xFILEIO__T
WaitPacket__xFILEIO__T
	movem.l	d2-d4/a2/a6,-(a7)
	move.l	$18(a7),a2
L149
;	if (flags & WAIT_PACKET)
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#$8,d0
	beq	L159
L150
;		while (true)
	bra	L158
L151
;			af_PacketPort.mp_Flags = PA_SIGNAL;
	move.l	a2,a0
	clr.b	$7A(a0)
;			Remove((struct Node *)WaitPort(&af_PacketPort));
	move.l	_SysBase,a6
	lea	$6C(a2),a0
	jsr	-$180(a6)
	move.l	_SysBase,a6
	move.l	d0,a1
	jsr	-$FC(a6)
;			af_PacketPort.mp_Flags = PA_IGNORE;
	move.l	a2,a0
	move.b	#2,$7A(a0)
;			flags &= ~WAIT_PACKET;
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#-$9,d0
	move.l	a2,a0
	move.l	d0,$96(a0)
;			sint32 bytes = af_Packet.sp_Pkt.dp_Res1;
	move.l	$48(a2),d0
;			if (bytes >= 0)
	bmi.b	L153
L152
;				return bytes;
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L153
;			if (ErrorReport(af_Packet.sp_Pkt.dp_Res2,REPORT_STREAM,af_File
	move.l	a2,a0
	move.l	$8(a0),d3
	move.l	_DOSBase,a6
	move.l	$4C(a2),d1
	moveq	#0,d2
	moveq	#0,d4
	jsr	-$1E0(a6)
	tst.l	d0
	beq.b	L155
L154
;				flags &= ~FILE_GOOD;
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#-$41,d0
	move.l	a2,a0
	move.l	d0,$96(a0)
;				return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L155
;			if (flags & OPEN_READ)
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#1,d0
	beq.b	L157
L156
;				SendPacket(af_Buffers[af_CurrentBuf]);
	move.l	a2,a1
	lea	$20(a2),a0
	move.l	$8E(a1),d0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a2,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
	bra.b	L158
L157
;				SendPacket(af_Buffers[1 - af_CurrentBuf]);
	move.l	a2,a1
	moveq	#1,d0
	sub.l	$8E(a1),d0
	lea	$20(a2),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a2,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
L158
	bra	L151
L159
;	SetIoErr(af_Packet.sp_Pkt.dp_Res2);
	move.l	_DOSBase,a6
	move.l	$4C(a2),d1
	jsr	-$1CE(a6)
;	return af_Packet.sp_Pkt.dp_Res1;
	move.l	$48(a2),d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts

	SECTION "RequeuePacket__xFILEIO__T:0",CODE


;void xFILEIO::RequeuePacket()
	XDEF	RequeuePacket__xFILEIO__T
RequeuePacket__xFILEIO__T
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a7),a3
L160
;	AddHead(&af_PacketPort.mp_MsgList,&af_Packet.sp_Msg.mn_Node);
	move.l	_SysBase,a6
	lea	$80(a3),a0
	lea	$28(a3),a1
	jsr	-$F0(a6)
;	flags |= WAIT_PACKET;
	move.l	a3,a0
	move.l	$96(a0),d0
	or.l	#$8,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "RecordSyncFailure__xFILEIO__T:0",CODE


;void xFILEIO::RecordSyncFailure()
	XDEF	RecordSyncFailure__xFILEIO__T
RecordSyncFailure__xFILEIO__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L161
;	af_Packet.sp_Pkt.dp_Res1 = -1;
	move.l	a2,a0
	move.l	#-1,$48(a0)
;	af_Packet.sp_Pkt.dp_Res2 = IoErr();
	move.l	_DOSBase,a6
	jsr	-$84(a6)
	move.l	a2,a0
	move.l	d0,$4C(a0)
;	af_BytesLeft = 0;
	move.l	a2,a0
	clr.l	$18(a0)
;	flags &= ~FILE_GOOD;
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#-$41,d0
	move.l	a2,a0
	move.l	d0,$96(a0)
	movem.l	(a7)+,a2/a6
	rts

	SECTION "Open__xFILEIO__TPCcjj:0",CODE


;sint32 xFILEIO::Open(const char* fileName, sint32 mode, sint32 buffe
	XDEF	Open__xFILEIO__TPCcjj
Open__xFILEIO__TPCcjj
L200	EQU	-$48
	link	a5,#L200
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$14(a5),d5
	move.l	$10(a5),d7
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L162
;	BPTR				handle = 0;
	moveq	#0,d4
;	BPTR				lock = 0;
	moveq	#0,d6
;	if (mode == READ)
	move.l	d7,d0
	cmp.l	#1,d0
	bne	L169
L163
;		if (handle = ::Open(fileName,MODE_OLDFILE))
	move.l	_DOSBase,a6
	move.l	a2,d1
	move.l	#$3ED,d2
	jsr	-$1E(a6)
	move.l	d0,d4
	beq.b	L168
L164
;			lock = Lock(fileName,ACCESS_READ);
	move.l	_DOSBase,a6
	move.l	a2,d1
	moveq	#-2,d2
	jsr	-$54(a6)
	move.l	d0,d6
;			if (::Seek(handle, 0, OFFSET_END)>=0)
	move.l	_DOSBase,a6
	move.l	d4,d1
	moveq	#0,d2
	moveq	#1,d3
	jsr	-$42(a6)
	tst.l	d0
	bmi.b	L166
L165
;				fileSize = ::Seek(handle, 0, OFFSET_CURRENT);
	move.l	_DOSBase,a6
	move.l	d4,d1
	moveq	#0,d2
	moveq	#0,d3
	jsr	-$42(a6)
	move.l	a3,a0
	move.l	d0,4(a0)
	bra.b	L167
L166
;				::Close(handle);
	move.l	_DOSBase,a6
	move.l	d4,d1
	jsr	-$24(a6)
;				fileSize = 0;
	move.l	a3,a0
	clr.l	4(a0)
;				handle = 0;
	moveq	#0,d4
L167
;			::Seek(handle, 0, OFFSET_BEGINNING);
	move.l	_DOSBase,a6
	move.l	d4,d1
	moveq	#0,d2
	moveq	#-1,d3
	jsr	-$42(a6)
;			flags |= OPEN_READ;
	move.l	a3,a0
	move.l	$96(a0),d0
	or.l	#1,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
L168
	bra	L180
L169
;		if (mode == WRITE)
	move.l	d7,d0
	cmp.l	#2,d0
	bne.b	L173
L170
;			if (handle = ::Open(fileName,MODE_NEWFILE))
	move.l	_DOSBase,a6
	move.l	a2,d1
	move.l	#$3EE,d2
	jsr	-$1E(a6)
	move.l	d0,d4
	beq.b	L172
L171
;				fileSize = 0;
	move.l	a3,a0
	clr.l	4(a0)
;				flags |= OPEN_WRITE;
	move.l	a3,a0
	move.l	$96(a0),d0
	or.l	#2,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
L172
	bra.b	L178
L173
;		else if (mode == APPEND)
	move.l	d7,d0
	cmp.l	#4,d0
	bne.b	L178
L174
;			if (handle = ::Open(fileName,MODE_READWRITE))
	move.l	_DOSBase,a6
	move.l	a2,d1
	move.l	#$3EC,d2
	jsr	-$1E(a6)
	move.l	d0,d4
	beq.b	L178
L175
;				flags |= OPEN_APPEND;
	move.l	a3,a0
	move.l	$96(a0),d0
	or.l	#4,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
;				if (::Seek(handle,0,OFFSET_END)>=0)
	move.l	_DOSBase,a6
	move.l	d4,d1
	moveq	#0,d2
	moveq	#1,d3
	jsr	-$42(a6)
	tst.l	d0
	bmi.b	L177
L176
;					fileSize = ::Seek(handle, 0, OFFSET_CURRENT);
	move.l	_DOSBase,a6
	move.l	d4,d1
	moveq	#0,d2
	moveq	#0,d3
	jsr	-$42(a6)
	move.l	a3,a0
	move.l	d0,4(a0)
	bra.b	L178
L177
;					::Close(handle);
	move.l	_DOSBase,a6
	move.l	d4,d1
	jsr	-$24(a6)
;					fileSize = 0;
	move.l	a3,a0
	clr.l	4(a0)
;					handle = 0;
	moveq	#0,d4
L178
;		if (handle)
	tst.l	d4
	beq.b	L180
L179
;			lock = ParentOfFH(handle);
	move.l	_DOSBase,a6
	move.l	d4,d1
	jsr	-$180(a6)
	move.l	d0,d6
L180
;	if (handle)
	tst.l	d4
	beq	L194
L181
;		sint32 blockSize = 512;
	move.l	#$200,d3
;		if (lock)
	tst.l	d6
	beq.b	L185
L182
;2
	lea	-$34(a5),a0
	moveq	#3,d0
	add.l	a0,d0
	and.l	#-4,d0
	move.l	d0,a2
;			if (Info(lock,&infoData))
	move.l	_DOSBase,a6
	move.l	d6,d1
	move.l	a2,d2
	jsr	-$72(a6)
	tst.l	d0
	beq.b	L184
L183
;				blockSize  = infoData.id_BytesPerBlock;
	move.l	a2,a0
	move.l	$14(a0),d3
;				bufferSize = (((bufferSize + (blockSize*2) - 1) / (blockSize
	move.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,d5
	subq.l	#1,d5
	move.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	divsl.l	d0,d5
	move.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	muls.l	d0,d5
L184
;			UnLock(lock);
	move.l	_DOSBase,a6
	move.l	d6,d1
	jsr	-$5A(a6)
;			lock = NULL;
	moveq	#0,d6
L185
;		bufferSpace = MEM::Alloc(bufferSize, true, MEM::ALIGN_CACHE);
	pea	$10.w
	move.w	#1,-(a7)
	move.l	d5,-(a7)
	jsr	Alloc__MEM__UisE
	add.w	#$A,a7
	move.l	a3,a1
	move.l	d0,(a1)
;		if (bufferSpace)
	move.l	a3,a1
	tst.l	(a1)
	beq	L192
L186
;			af_File			= handle;
	move.l	a3,a0
	move.l	d4,$8(a0)
;			af_BlockSize = blockSize;
	move.l	a3,a0
	move.l	d3,$C(a0)
;			FileHandle* fh   = (FileHandle*)BADDR(af_File);
	move.l	a3,a0
	move.l	$8(a0),-$10(a5)
	move.l	-$10(a5),d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-$10(a5)
;			af_Handler       = fh->fh_Type;
	move.l	-$10(a5),a1
	move.l	$8(a1),a0
	move.l	a3,a1
	move.l	a0,$10(a1)
;			af_BufferSize    = bufferSize >> 1;
	moveq	#1,d0
	asr.l	d0,d5
	move.l	a3,a0
	move.l	d5,$1C(a0)
;			af_Buffers[0]    = bufferSpace;
	move.l	a3,a0
	move.l	(a0),a1
	move.l	a1,$20(a3)
;			af_Buffers[1]    = (void*)((uint32)bufferSpace + af_BufferSize)
	move.l	a3,a0
	move.l	(a0),d0
	move.l	a3,a0
	add.l	$1C(a0),d0
	lea	$20(a3),a0
	move.l	d0,4(a0)
;			af_Offset        = af_Buffers[0];
	move.l	a3,a1
	move.l	$20(a3),$14(a1)
;			af_CurrentBuf    = 0;
	move.l	a3,a0
	clr.l	$8E(a0)
;			af_SeekOffset    = 0;
	move.l	a3,a0
	clr.l	$92(a0)
;			flags &= ~WAIT_PACKET;
	move.l	a3,a0
	move.l	$96(a0),d0
	and.l	#-$9,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
;			af_PacketPort.mp_MsgList.lh_Head     = (struct Node *)&af_Pack
	lea	$84(a3),a0
	move.l	a3,a1
	move.l	a0,$80(a1)
;			af_PacketPort.mp_MsgList.lh_Tail     = NULL;
	move.l	a3,a1
	clr.l	$84(a1)
;			af_PacketPort.mp_MsgList.lh_TailPred = (struct Node *)&af_Pack
	lea	$80(a3),a0
	move.l	a3,a1
	move.l	a0,$88(a1)
;			af_PacketPort.mp_Node.ln_Type        = NT_MSGPORT;
	move.l	a3,a0
	move.b	#4,$74(a0)
;			af_PacketPort.mp_Node.ln_Name        = NULL;
	move.l	a3,a1
	clr.l	$76(a1)
;			af_PacketPort.mp_Flags               = PA_IGNORE;
	move.l	a3,a0
	move.b	#2,$7A(a0)
;			af_PacketPort.mp_SigBit              = SIGB_SINGLE;
	move.l	a3,a0
	move.b	#4,$7B(a0)
;			af_PacketPort.mp_SigTask             = FindTask(NULL);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a1
	move.l	d0,$7C(a1)
;			af_Packet.sp_Pkt.dp_Link          = &af_Packet.sp_Msg;
	lea	$28(a3),a0
	move.l	a3,a1
	move.l	a0,$3C(a1)
;			af_Packet.sp_Pkt.dp_Arg1          = fh->fh_Arg1;
	move.l	-$10(a5),a0
	move.l	$24(a0),d0
	move.l	a3,a0
	move.l	d0,$50(a0)
;			af_Packet.sp_Pkt.dp_Arg3          = af_BufferSize;
	move.l	a3,a0
	move.l	$1C(a0),d0
	move.l	a3,a0
	move.l	d0,$58(a0)
;			af_Packet.sp_Pkt.dp_Res1          = 0;
	move.l	a3,a0
	clr.l	$48(a0)
;			af_Packet.sp_Pkt.dp_Res2          = 0;
	move.l	a3,a0
	clr.l	$4C(a0)
;			af_Packet.sp_Msg.mn_Node.ln_Name  = (char*)&af_Packet.sp_Pkt;
	lea	$3C(a3),a0
	move.l	a3,a1
	move.l	a0,$32(a1)
;			af_Packet.sp_Msg.mn_Node.ln_Type  = NT_MESSAGE;
	move.l	a3,a0
	move.b	#5,$30(a0)
;			af_Packet.sp_Msg.mn_Length        = sizeof(struct StandardPack
	move.l	a3,a0
	move.w	#$44,$3A(a0)
;			if (mode == READ)
	move.l	d7,d0
	cmp.l	#1,d0
	bne.b	L190
L187
;				af_Packet.sp_Pkt.dp_Type = ACTION_READ;
	move.l	a3,a0
	move.l	#$52,$44(a0)
;				af_BytesLeft             = 0;
	move.l	a3,a0
	clr.l	$18(a0)
;				af_Offset                = af_Buffers[1];
	lea	$20(a3),a0
	move.l	a3,a1
	move.l	4(a0),$14(a1)
;				if (af_Handler)
	move.l	a3,a1
	tst.l	$10(a1)
	beq.b	L189
L188
;					SendPacket(af_Buffers[0]);
	move.l	$20(a3),-(a7)
	move.l	a3,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
L189
	bra.b	L191
L190
;				af_Packet.sp_Pkt.dp_Type = ACTION_WRITE;
	move.l	a3,a0
	move.l	#$57,$44(a0)
;				af_BytesLeft             = af_BufferSize;
	move.l	a3,a0
	move.l	$1C(a0),d0
	move.l	a3,a0
	move.l	d0,$18(a0)
L191
	bra.b	L193
L192
;			flags &= ~OPEN_ANY;
	move.l	a3,a0
	move.l	$96(a0),d0
	and.l	#-$8,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
;			::Close(handle);
	move.l	_DOSBase,a6
	move.l	d4,d1
	jsr	-$24(a6)
;			SetIoErr(ERROR_NO_FREE_STORE);
	move.l	_DOSBase,a6
	moveq	#$67,d1
	jsr	-$1CE(a6)
L193
	bra.b	L195
L194
;		flags &= ~OPEN_ANY;
	move.l	a3,a0
	move.l	$96(a0),d0
	and.l	#-$8,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
L195
;	if(lock != NULL)
	tst.l	d6
	beq.b	L197
L196
;		flags &= ~OPEN_ANY;
	move.l	a3,a0
	move.l	$96(a0),d0
	and.l	#-$8,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
;		sint32 error = IoErr();
	move.l	_DOSBase,a6
	jsr	-$84(a6)
	move.l	d0,d2
;		UnLock(lock);
	move.l	_DOSBase,a6
	move.l	d6,d1
	jsr	-$5A(a6)
;		SetIoErr(error);
	move.l	_DOSBase,a6
	move.l	d2,d1
	jsr	-$1CE(a6)
L197
;	if (flags & OPEN_ANY)
	move.l	a3,a0
	move.l	$96(a0),d0
	and.l	#7,d0
	beq.b	L199
L198
;		flags |= FILE_GOOD;
	move.l	a3,a0
	move.l	$96(a0),d0
	or.l	#$40,d0
	move.l	a3,a0
	move.l	d0,$96(a0)
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L199
;		return ERR_FILE_OPEN;
	move.l	#-$304000B,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "Flush__xFILEIO__T:0",CODE


;sint32 xFILEIO::Flush()
	XDEF	Flush__xFILEIO__T
Flush__xFILEIO__T
	movem.l	d2/d3/a6,-(a7)
	move.l	$10(a7),a6
L201
;	sint32 result = WaitPacket();
	move.l	a6,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
;		if (result >= 0)
	tst.l	d0
	bmi.b	L205
L202
;			if (flags & (OPEN_WRITE|OPEN_APPEND))
	move.l	$96(a6),d1
	and.l	#6,d1
	beq.b	L205
L203
;			n		-= af_BytesLeft;
	move.l	$1C(a6),d2
	cmp.l	$18(a6),d2
	bls.b	L205
L204
;				result = ::Write(af_File,af_Buffers[af_CurrentBuf],af_Buffer
	move.l	$1C(a6),d3
	sub.l	$18(a6),d3
	lea	$20(a6),a0
	move.l	$8E(a6),d0
	move.l	$8(a6),d1
	move.l	_DOSBase,a6
	move.l	0(a0,d0.l*4),d2
	jsr	-$30(a6)
L205
;	return result;
	movem.l	(a7)+,d2/d3/a6
	rts

	SECTION "Close__xFILEIO__T:0",CODE


;sint32 xFILEIO::Close()
	XDEF	Close__xFILEIO__T
Close__xFILEIO__T
	movem.l	d2/d3/a2/a6,-(a7)
	move.l	$14(a7),a2
L206
;	sint32 result = OK;
;	if (flags & OPEN_ANY)
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#7,d0
	beq.b	L212
L207
;		result = WaitPacket();
	move.l	a2,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	move.l	d0,d2
;		if (result >= 0)
	bmi.b	L211
L208
;			if (flags & (OPEN_WRITE|OPEN_APPEND))
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#6,d0
	beq.b	L211
L209
;				if (af_BufferSize > af_BytesLeft)
	move.l	a2,a0
	move.l	$1C(a0),d1
	move.l	a2,a0
	cmp.l	$18(a0),d1
	bls.b	L211
L210
;				result = ::Write(af_File,af_Buffers[af_CurrentBuf],af_Buffer
	move.l	a2,a0
	move.l	$1C(a0),d3
	move.l	a2,a0
	sub.l	$18(a0),d3
	move.l	a2,a1
	lea	$20(a2),a0
	move.l	$8E(a1),d0
	move.l	a2,a1
	move.l	_DOSBase,a6
	move.l	$8(a1),d1
	move.l	0(a0,d0.l*4),d2
	jsr	-$30(a6)
	move.l	d0,d2
L211
;		::Close(af_File);
	move.l	a2,a0
	move.l	_DOSBase,a6
	move.l	$8(a0),d1
	jsr	-$24(a6)
	bra.b	L213
L212
;		SetIoErr(ERROR_INVALID_LOCK);
	move.l	_DOSBase,a6
	move.l	#$D3,d1
	jsr	-$1CE(a6)
;		result = ERR_FILE_CLOSE;
	move.l	#-$304000C,d2
L213
;	if (bufferSpace)
	move.l	a2,a1
	tst.l	(a1)
	beq.b	L215
L214
;		MEM::Free(bufferSpace);
	move.l	a2,a1
	move.l	(a1),-(a7)
	jsr	Free__MEM__Pv
	addq.w	#4,a7
;		bufferSpace = 0;
	move.l	a2,a1
	clr.l	(a1)
L215
;	flags &= ~(OPEN_ANY|FILE_GOOD);
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#-$48,d0
	move.l	a2,a0
	move.l	d0,$96(a0)
;	return result;
	move.l	d2,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "Read__xFILEIO__TPvUiUi:0",CODE


;sint32 xFILEIO::Read(void* buffer, size_t s, size_t n)
	XDEF	Read__xFILEIO__TPvUiUi
Read__xFILEIO__TPvUiUi
	movem.l	d2-d5/a2/a6,-(a7)
	move.l	$28(a7),d3
	move.l	$24(a7),d5
	move.l	$20(a7),a2
	move.l	$1C(a7),a6
L216
;	n *= s;
	mulu.l	d5,d3
;	sint32 totalBytes = 0;
	moveq	#0,d4
;	while (n > af_BytesLeft)
	bra	L224
L217
;		MEM::Copy(buffer, af_Offset, af_BytesLeft);
	move.l	$18(a6),d0
	move.l	a2,a0
	move.l	$14(a6),a1
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
;		n										-= af_BytesLeft;
	sub.l	$18(a6),d3
;		buffer							= (void*)((uint32)buffer + af_BytesLeft);
	move.l	a2,d0
	add.l	$18(a6),d0
	move.l	d0,a2
;		totalBytes					+= af_BytesLeft;
	add.l	$18(a6),d4
;		af_BytesLeft				= 0;
	clr.l	$18(a6)
;		sint32 bytesArrived = WaitPacket();
	move.l	a6,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	move.l	d0,d2
;		if (bytesArrived <= 0)
	cmp.l	#0,d2
	bgt.b	L221
L218
;			if (bytesArrived == 0)
	tst.l	d2
	bne.b	L220
L219
;				flags |= FILE_ATEND;
	or.l	#$10,$96(a6)
;				SetIoErr(0);
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
;				return totalBytes/s;
	move.l	d4,d0
	divsl.l	d5,d0
	movem.l	(a7)+,d2-d5/a2/a6
	rts
L220
;			return ERR_FILE_READ;
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2-d5/a2/a6
	rts
L221
;		SendPacket(af_Buffers[1-af_CurrentBuf]);
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$20(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;		if (af_SeekOffset > bytesArrived)
	move.l	$92(a6),d0
	cmp.l	d2,d0
	bls.b	L223
L222
;			af_SeekOffset = bytesArrived;
	move.l	d2,$92(a6)
L223
;		af_Offset      = (void*)((uint32)af_Buffers[af_CurrentBuf] + af_
	lea	$20(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),d0
	add.l	$92(a6),d0
	move.l	d0,$14(a6)
;		af_CurrentBuf  = 1 - af_CurrentBuf;
	moveq	#1,d0
	sub.l	$8E(a6),d0
	move.l	d0,$8E(a6)
;		af_BytesLeft   = bytesArrived - af_SeekOffset;
	sub.l	$92(a6),d2
	move.l	d2,$18(a6)
;		af_SeekOffset  = 0;
	clr.l	$92(a6)
L224
	cmp.l	$18(a6),d3
	bgt	L217
L225
;	MEM::Copy(buffer, af_Offset, n);
	move.l	d3,d0
	move.l	a2,a0
	move.l	$14(a6),a1
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
;	af_BytesLeft -= n;
	sub.l	d3,$18(a6)
;	af_Offset     = (void*)((uint32)af_Offset + n);
	add.l	d3,$14(a6)
;	return (totalBytes + n)/s;
	move.l	d4,d0
	add.l	d3,d0
	divsl.l	d5,d0
	movem.l	(a7)+,d2-d5/a2/a6
	rts

	SECTION "Write__xFILEIO__TPvUiUi:0",CODE


;sint32 xFILEIO::Write(void* buffer, size_t s, size_t n)
	XDEF	Write__xFILEIO__TPvUiUi
Write__xFILEIO__TPvUiUi
	movem.l	d2-d4/a2/a3,-(a7)
	move.l	$24(a7),d2
	move.l	$20(a7),d4
	move.l	$18(a7),a2
	move.l	$1C(a7),a3
L226
;	n *= s;
	mulu.l	d4,d2
;	sint32 totalBytes = 0;
	moveq	#0,d3
;	while (n > af_BytesLeft)
	bra	L234
L227
;		if (!af_Handler)
	tst.l	$10(a2)
	bne.b	L229
L228
;			af_Offset			= af_Buffers[0];
	move.l	$20(a2),a0
	move.l	a0,$14(a2)
;			af_BytesLeft	= af_BufferSize;
	move.l	$1C(a2),d0
	move.l	d0,$18(a2)
;			return n;
	move.l	d2,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L229
;		if (af_BytesLeft)
	tst.l	$18(a2)
	beq.b	L231
L230
;			MEM::Copy(af_Offset, buffer, af_BytesLeft);
	move.l	$18(a2),d0
	move.l	$14(a2),a0
	move.l	a3,a1
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
;			n		-= af_BytesLeft;
	sub.l	$18(a2),d2
;			buffer			= (void*)((uint32)buffer + af_BytesLeft);
	move.l	a3,d0
	add.l	$18(a2),d0
	move.l	d0,a3
;			totalBytes	+= af_BytesLeft;
	add.l	$18(a2),d3
L231
;		if (WaitPacket() < 0)
	move.l	a2,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	tst.l	d0
	bpl.b	L233
L232
;			return ERR_FILE_WRITE;
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L233
;		SendPacket(af_Buffers[af_CurrentBuf]);
	lea	$20(a2),a0
	move.l	$8E(a2),d0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a2,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;		af_CurrentBuf	= 1 - af_CurrentBuf;
	moveq	#1,d0
	sub.l	$8E(a2),d0
	move.l	d0,$8E(a2)
;		af_Offset			= af_Buffers[af_CurrentBuf];
	lea	$20(a2),a0
	move.l	$8E(a2),d0
	move.l	0(a0,d0.l*4),$14(a2)
;		af_BytesLeft	= af_BufferSize;
	move.l	$1C(a2),d0
	move.l	d0,$18(a2)
L234
	cmp.l	$18(a2),d2
	bgt	L227
L235
;	MEM::Copy(af_Offset, buffer, n);
	move.l	d2,d0
	move.l	$14(a2),a0
	move.l	a3,a1
	jsr	Copy__MEM__r8Pvr9Pvr0Ui
;	af_BytesLeft		-= n;
	sub.l	d2,$18(a2)
;	af_Offset				= (void*)((uint32)af_Offset + n);
	add.l	d2,$14(a2)
;	return (totalBytes + n)/s;
	move.l	d3,d0
	add.l	d2,d0
	divsl.l	d4,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts

	SECTION "Tell__xFILEIO__T:0",CODE


;sint32 xFILEIO::Tell()
	XDEF	Tell__xFILEIO__T
Tell__xFILEIO__T
	movem.l	d2-d4/a2/a6,-(a7)
	move.l	$18(a7),a2
L236
;	if (flags & OPEN_READ)
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#1,d0
	beq.b	L240
L237
;		sint32 bytesArrived = WaitPacket();
	move.l	a2,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	move.l	d0,d4
;		if (bytesArrived < 0)
	bpl.b	L239
L238
;			return ERR_FILE_SEEK;
	move.l	#-$3040008,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L239
;		return ::Seek(af_File,0,OFFSET_CURRENT) - (af_BytesLeft+bytesArr
	move.l	a2,a0
	move.l	_DOSBase,a6
	move.l	$8(a0),d1
	moveq	#0,d2
	moveq	#0,d3
	jsr	-$42(a6)
	move.l	a2,a0
	move.l	$18(a0),d1
	add.l	d4,d1
	sub.l	d1,d0
	move.l	a2,a0
	add.l	$92(a0),d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L240
;		return Seek(0, CURRENT);
	clr.l	-(a7)
	clr.l	-(a7)
	move.l	a2,-(a7)
	jsr	Seek__xFILEIO__Tjj
	add.w	#$C,a7
	movem.l	(a7)+,d2-d4/a2/a6
	rts

	SECTION "Seek__xFILEIO__Tjj:0",CODE


;sint32 xFILEIO::Seek(sint32 position, sint32 mode)
	XDEF	Seek__xFILEIO__Tjj
Seek__xFILEIO__Tjj
L270	EQU	-$11C
	link	a5,#L270
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$10(a5),d4
	move.l	$C(a5),d6
	move.l	$8(a5),a2
L241
;	sint32 bytesArrived = WaitPacket();
	move.l	a2,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	move.l	d0,d7
;	if (bytesArrived < 0)
	bpl.b	L243
L242
;		return ERR_FILE_SEEK;
	move.l	#-$3040008,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L243
;	if (flags & OPEN_READ)
	move.l	a2,a0
	move.l	$96(a0),d0
	and.l	#1,d0
	beq	L263
L244
;		sint32 filePos = ::Seek(af_File,0,OFFSET_CURRENT);
	move.l	a2,a0
	move.l	_DOSBase,a6
	move.l	$8(a0),d1
	moveq	#0,d2
	moveq	#0,d3
	jsr	-$42(a6)
	move.l	d0,d3
;		if (filePos < 0)
	bpl.b	L246
L245
;			RecordSyncFailure();
	move.l	a2,-(a7)
	jsr	RecordSyncFailure__xFILEIO__T
	addq.w	#4,a7
;			return ERR_FILE_SEEK;
	move.l	#-$3040008,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L246
;		current = filePos - (af_BytesLeft+bytesArrived) + af_SeekOffset;
	move.l	a2,a0
	move.l	$18(a0),d0
	add.l	d7,d0
	move.l	d3,d5
	sub.l	d0,d5
	move.l	a2,a0
	add.l	$92(a0),d5
;		if (mode == CURRENT)
	tst.l	d4
	bne.b	L248
L247
;			target = current + position;
	move.l	d5,d4
	add.l	d6,d4
	bra.b	L253
L248
;		else if (mode == START)
	cmp.l	#-1,d4
	bne.b	L250
L249
;			target = position;
	move.l	d6,d4
	bra.b	L253
L250
;2
	lea	-$118(a5),a0
	moveq	#3,d0
	add.l	a0,d0
	and.l	#-4,d0
	move.l	d0,a3
;			if (!ExamineFH(af_File,&fib))
	move.l	a2,a0
	move.l	_DOSBase,a6
	move.l	$8(a0),d1
	move.l	a3,d2
	jsr	-$186(a6)
	tst.w	d0
	bne.b	L252
L251
;				RecordSyncFailure();
	move.l	a2,-(a7)
	jsr	RecordSyncFailure__xFILEIO__T
	addq.w	#4,a7
;				return ERR_FILE_SEEK;
	move.l	#-$3040008,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L252
;			target = fib.fib_Size + position;
	move.l	a3,a0
	move.l	$7C(a0),d4
	add.l	d6,d4
L253
;		sint32 minBuf = current - (sint32)((uint32)af_Offset - (uint32)a
	move.l	a2,a0
	move.l	$14(a0),d0
	move.l	a2,a1
	moveq	#1,d1
	sub.l	$8E(a1),d1
	lea	$20(a2),a0
	sub.l	0(a0,d1.l*4),d0
	move.l	d5,d1
	sub.l	d0,d1
;		sint32 maxBuf = current + af_BytesLeft + bytesArrived;
	move.l	a2,a0
	move.l	$18(a0),d0
	add.l	d5,d0
	add.l	d7,d0
;		sint32 diff = target - current;
	move.l	d4,d2
	sub.l	d5,d2
;		if ((target < minBuf) || (target >= maxBuf))
	cmp.l	d1,d4
	blt.b	L255
L254
	cmp.l	d0,d4
	blt	L258
L255
;			sint32 roundTarget = (target / af_BlockSize) * af_BlockSize;
	move.l	a2,a0
	move.l	d4,d0
	divul.l	$C(a0),d0
	move.l	d0,d6
	move.l	a2,a0
	move.l	d6,d0
	mulu.l	$C(a0),d0
	move.l	d0,d6
;			if (::Seek(af_File,roundTarget-filePos,OFFSET_CURRENT) < 0)
	move.l	d6,d2
	sub.l	d3,d2
	move.l	a2,a0
	move.l	_DOSBase,a6
	move.l	$8(a0),d1
	moveq	#0,d3
	jsr	-$42(a6)
	tst.l	d0
	bpl.b	L257
L256
;				RecordSyncFailure();
	move.l	a2,-(a7)
	jsr	RecordSyncFailure__xFILEIO__T
	addq.w	#4,a7
;				return ERR_FILE_SEEK;
	move.l	#-$3040008,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L257
;			SendPacket(af_Buffers[0]);
	move.l	$20(a2),-(a7)
	move.l	a2,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;			af_SeekOffset = target-roundTarget;
	sub.l	d6,d4
	move.l	a2,a0
	move.l	d4,$92(a0)
;			af_BytesLeft  = 0;
	move.l	a2,a0
	clr.l	$18(a0)
;			af_CurrentBuf = 0;
	move.l	a2,a0
	clr.l	$8E(a0)
;			af_Offset     = af_Buffers[1];
	lea	$20(a2),a0
	move.l	a2,a1
	move.l	4(a0),$14(a1)
	bra	L262
L258
;		else if ((target < current) || (diff <= af_BytesLeft))
	cmp.l	d5,d4
	blt.b	L260
L259
	move.l	a2,a0
	cmp.l	$18(a0),d2
	bgt.b	L261
L260
;			RequeuePacket();
	move.l	a2,-(a7)
	jsr	RequeuePacket__xFILEIO__T
	addq.w	#4,a7
;			af_BytesLeft -= diff;
	move.l	a2,a0
	move.l	$18(a0),d0
	sub.l	d2,d0
	move.l	a2,a0
	move.l	d0,$18(a0)
;			af_Offset     = (void*)((uint32)af_Offset + diff);
	move.l	a2,a0
	move.l	$14(a0),d0
	add.l	d2,d0
	move.l	a2,a1
	move.l	d0,$14(a1)
	bra.b	L262
L261
;			SendPacket(af_Buffers[1-af_CurrentBuf]);
	move.l	a2,a1
	moveq	#1,d0
	sub.l	$8E(a1),d0
	lea	$20(a2),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a2,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;			diff -= af_BytesLeft - af_SeekOffset;
	move.l	a2,a0
	move.l	$18(a0),d0
	move.l	a2,a0
	sub.l	$92(a0),d0
	sub.l	d0,d2
;			af_Offset     = (void*)((uint32)af_Buffers[af_CurrentBuf] + di
	move.l	a2,a1
	lea	$20(a2),a0
	move.l	$8E(a1),d0
	move.l	0(a0,d0.l*4),d0
	add.l	d2,d0
	move.l	a2,a1
	move.l	d0,$14(a1)
;			af_BytesLeft  = bytesArrived - diff;
	move.l	d7,d0
	sub.l	d2,d0
	move.l	a2,a0
	move.l	d0,$18(a0)
;			af_SeekOffset = 0;
	move.l	a2,a0
	clr.l	$92(a0)
;			af_CurrentBuf = 1 - af_CurrentBuf;
	move.l	a2,a0
	moveq	#1,d0
	sub.l	$8E(a0),d0
	move.l	a2,a0
	move.l	d0,$8E(a0)
L262
	bra	L269
L263
;		if (af_BufferSize > af_BytesLeft)
	move.l	a2,a0
	move.l	$1C(a0),d1
	move.l	a2,a0
	cmp.l	$18(a0),d1
	bls.b	L266
L264
;			if (::Write(af_File,af_Buffers[af_CurrentBuf],af_BufferSize - 
	move.l	a2,a0
	move.l	$1C(a0),d3
	move.l	a2,a0
	sub.l	$18(a0),d3
	move.l	a2,a1
	lea	$20(a2),a0
	move.l	$8E(a1),d0
	move.l	a2,a1
	move.l	_DOSBase,a6
	move.l	$8(a1),d1
	move.l	0(a0,d0.l*4),d2
	jsr	-$30(a6)
	tst.l	d0
	bpl.b	L266
L265
;				RecordSyncFailure();
	move.l	a2,-(a7)
	jsr	RecordSyncFailure__xFILEIO__T
	addq.w	#4,a7
;				return ERR_FILE_SEEK;
	move.l	#-$3040008,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L266
;		current = ::Seek(af_File,position,mode);
	move.l	a2,a0
	move.l	_DOSBase,a6
	move.l	$8(a0),d1
	move.l	d6,d2
	move.l	d4,d3
	jsr	-$42(a6)
	move.l	d0,d5
;		if (current < 0)
	bpl.b	L268
L267
;			RecordSyncFailure();
	move.l	a2,-(a7)
	jsr	RecordSyncFailure__xFILEIO__T
	addq.w	#4,a7
;			return ERR_FILE_SEEK;
	move.l	#-$3040008,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L268
;		af_BytesLeft  = af_BufferSize;
	move.l	a2,a0
	move.l	$1C(a0),d0
	move.l	a2,a0
	move.l	d0,$18(a0)
;		af_CurrentBuf = 0;
	move.l	a2,a0
	clr.l	$8E(a0)
;		af_Offset     = af_Buffers[0];
	move.l	a2,a1
	move.l	$20(a2),$14(a1)
L269
;	return current;
	move.l	d5,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "Read16Swap__xFILEIO__TPvUi:0",CODE


;sint32 xFILEIO::Read16Swap(void* buffer,size_t n)
	XDEF	Read16Swap__xFILEIO__TPvUi
Read16Swap__xFILEIO__TPvUi
	movem.l	d2-d4/a2/a6,-(a7)
	move.l	$20(a7),d3
	move.l	$1C(a7),a2
	move.l	$18(a7),a6
L271
;	if (((uint32)buffer|(uint32)af_Offset)&1UL)
	move.l	a2,d0
	or.l	$14(a6),d0
	and.l	#1,d0
	beq.b	L273
L272
;		return ERR_PTR;
	move.l	#-$3020000,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L273
;	n <<= 1;
	moveq	#1,d0
	asl.l	d0,d3
;	sint32 totalBytes = 0;
	moveq	#0,d4
;	while (n > af_BytesLeft)
	bra	L281
L274
;		MEM::Swap16(buffer, af_Offset, (af_BytesLeft>>1));
	move.l	$18(a6),d0
	moveq	#1,d1
	asr.l	d1,d0
	move.l	a2,a0
	move.l	$14(a6),a1
	jsr	Swap16__MEM__r8Pvr9Pvr0Ui
;		n										-= af_BytesLeft;
	sub.l	$18(a6),d3
;		buffer							= (void*)((uint32)buffer + af_BytesLeft);
	move.l	a2,d0
	add.l	$18(a6),d0
	move.l	d0,a2
;		totalBytes					+= af_BytesLeft;
	add.l	$18(a6),d4
;		af_BytesLeft				= 0;
	clr.l	$18(a6)
;		sint32 bytesArrived = WaitPacket();
	move.l	a6,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	move.l	d0,d2
;		if (bytesArrived <= 0)
	cmp.l	#0,d2
	bgt.b	L278
L275
;			if (bytesArrived == 0)
	tst.l	d2
	bne.b	L277
L276
;				flags |= FILE_ATEND;
	or.l	#$10,$96(a6)
;				SetIoErr(0);
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
;				return totalBytes>>1;
	move.l	d4,d0
	moveq	#1,d4
	asr.l	d4,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L277
;			return ERR_FILE_READ;
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L278
;		SendPacket(af_Buffers[1-af_CurrentBuf]);
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$20(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;		if (af_SeekOffset > bytesArrived)
	move.l	$92(a6),d0
	cmp.l	d2,d0
	bls.b	L280
L279
;			af_SeekOffset = bytesArrived;
	move.l	d2,$92(a6)
L280
;		af_Offset      = (void*)((uint32)af_Buffers[af_CurrentBuf] + af_
	lea	$20(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),d0
	add.l	$92(a6),d0
	move.l	d0,$14(a6)
;		af_CurrentBuf  = 1 - af_CurrentBuf;
	moveq	#1,d0
	sub.l	$8E(a6),d0
	move.l	d0,$8E(a6)
;		af_BytesLeft   = bytesArrived - af_SeekOffset;
	sub.l	$92(a6),d2
	move.l	d2,$18(a6)
;		af_SeekOffset  = 0;
	clr.l	$92(a6)
L281
	cmp.l	$18(a6),d3
	bgt	L274
L282
;	MEM::Swap16(buffer, af_Offset, (n>>1));
	move.l	d3,d0
	moveq	#1,d1
	lsr.l	d1,d0
	move.l	a2,a0
	move.l	$14(a6),a1
	jsr	Swap16__MEM__r8Pvr9Pvr0Ui
;	af_BytesLeft -= n;
	sub.l	d3,$18(a6)
;	af_Offset     = (void*)((uint32)af_Offset + n);
	add.l	d3,$14(a6)
;	return (totalBytes + n)>>1;
	move.l	d4,d0
	add.l	d3,d0
	moveq	#1,d1
	asr.l	d1,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts

	SECTION "Read32Swap__xFILEIO__TPvUi:0",CODE


;sint32 xFILEIO::Read32Swap(void* buffer,size_t n)
	XDEF	Read32Swap__xFILEIO__TPvUi
Read32Swap__xFILEIO__TPvUi
	movem.l	d2-d4/a2/a6,-(a7)
	move.l	$20(a7),d3
	move.l	$1C(a7),a2
	move.l	$18(a7),a6
L283
;	if (((uint32)buffer|(uint32)af_Offset)&1UL)
	move.l	a2,d0
	or.l	$14(a6),d0
	and.l	#1,d0
	beq.b	L285
L284
;		return ERR_PTR;
	move.l	#-$3020000,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L285
;	n <<= 2;
	moveq	#2,d0
	asl.l	d0,d3
;	sint32 totalBytes = 0;
	moveq	#0,d4
;	while (n > af_BytesLeft)
	bra	L293
L286
;		MEM::Swap32(buffer, af_Offset, (af_BytesLeft>>2));
	move.l	$18(a6),d0
	moveq	#2,d1
	asr.l	d1,d0
	move.l	a2,a0
	move.l	$14(a6),a1
	jsr	Swap32__MEM__r8Pvr9Pvr0Ui
;		n										-= af_BytesLeft;
	sub.l	$18(a6),d3
;		buffer							= (void*)((uint32)buffer + af_BytesLeft);
	move.l	a2,d0
	add.l	$18(a6),d0
	move.l	d0,a2
;		totalBytes					+= af_BytesLeft;
	add.l	$18(a6),d4
;		af_BytesLeft				= 0;
	clr.l	$18(a6)
;		sint32 bytesArrived = WaitPacket();
	move.l	a6,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	move.l	d0,d2
;		if (bytesArrived <= 0)
	cmp.l	#0,d2
	bgt.b	L290
L287
;			if (bytesArrived == 0)
	tst.l	d2
	bne.b	L289
L288
;				flags |= FILE_ATEND;
	or.l	#$10,$96(a6)
;				SetIoErr(0);
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
;				return totalBytes>>2;
	move.l	d4,d0
	moveq	#2,d4
	asr.l	d4,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L289
;			return ERR_FILE_READ;
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L290
;		SendPacket(af_Buffers[1-af_CurrentBuf]);
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$20(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;		if (af_SeekOffset > bytesArrived)
	move.l	$92(a6),d0
	cmp.l	d2,d0
	bls.b	L292
L291
;			af_SeekOffset = bytesArrived;
	move.l	d2,$92(a6)
L292
;		af_Offset      = (void*)((uint32)af_Buffers[af_CurrentBuf] + af_
	lea	$20(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),d0
	add.l	$92(a6),d0
	move.l	d0,$14(a6)
;		af_CurrentBuf  = 1 - af_CurrentBuf;
	moveq	#1,d0
	sub.l	$8E(a6),d0
	move.l	d0,$8E(a6)
;		af_BytesLeft   = bytesArrived - af_SeekOffset;
	sub.l	$92(a6),d2
	move.l	d2,$18(a6)
;		af_SeekOffset  = 0;
	clr.l	$92(a6)
L293
	cmp.l	$18(a6),d3
	bgt	L286
L294
;	MEM::Swap32(buffer, af_Offset, (n>>2));
	move.l	d3,d0
	moveq	#2,d1
	lsr.l	d1,d0
	move.l	a2,a0
	move.l	$14(a6),a1
	jsr	Swap32__MEM__r8Pvr9Pvr0Ui
;	af_BytesLeft -= n;
	sub.l	d3,$18(a6)
;	af_Offset     = (void*)((uint32)af_Offset + n);
	add.l	d3,$14(a6)
;	return (totalBytes + n)>>2;
	move.l	d4,d0
	add.l	d3,d0
	moveq	#2,d1
	asr.l	d1,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts

	SECTION "Read64Swap__xFILEIO__TPvUi:0",CODE


;sint32 xFILEIO::Read64Swap(void* buffer,size_t n)
	XDEF	Read64Swap__xFILEIO__TPvUi
Read64Swap__xFILEIO__TPvUi
	movem.l	d2-d4/a2/a6,-(a7)
	move.l	$20(a7),d3
	move.l	$1C(a7),a2
	move.l	$18(a7),a6
L295
;	if (((uint32)buffer|(uint32)af_Offset)&1UL)
	move.l	a2,d0
	or.l	$14(a6),d0
	and.l	#1,d0
	beq.b	L297
L296
;		return ERR_PTR;
	move.l	#-$3020000,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L297
;	n <<= 3;
	moveq	#3,d0
	asl.l	d0,d3
;	sint32 totalBytes = 0;
	moveq	#0,d4
;	while (n > af_BytesLeft)
	bra	L305
L298
;		MEM::Swap64(buffer, af_Offset, (af_BytesLeft>>3));
	move.l	$18(a6),d0
	moveq	#3,d1
	asr.l	d1,d0
	move.l	a2,a0
	move.l	$14(a6),a1
	jsr	Swap64__MEM__r8Pvr9Pvr0Ui
;		n										-= af_BytesLeft;
	sub.l	$18(a6),d3
;		buffer							= (void*)((uint32)buffer + af_BytesLeft);
	move.l	a2,d0
	add.l	$18(a6),d0
	move.l	d0,a2
;		totalBytes					+= af_BytesLeft;
	add.l	$18(a6),d4
;		af_BytesLeft				= 0;
	clr.l	$18(a6)
;		sint32 bytesArrived = WaitPacket();
	move.l	a6,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	move.l	d0,d2
;		if (bytesArrived <= 0)
	cmp.l	#0,d2
	bgt.b	L302
L299
;			if (bytesArrived == 0)
	tst.l	d2
	bne.b	L301
L300
;				flags |= FILE_ATEND;
	or.l	#$10,$96(a6)
;				SetIoErr(0);
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
;				return totalBytes>>3;
	move.l	d4,d0
	moveq	#3,d4
	asr.l	d4,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L301
;			return ERR_FILE_READ;
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L302
;		SendPacket(af_Buffers[1-af_CurrentBuf]);
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$20(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;		if (af_SeekOffset > bytesArrived)
	move.l	$92(a6),d0
	cmp.l	d2,d0
	bls.b	L304
L303
;			af_SeekOffset = bytesArrived;
	move.l	d2,$92(a6)
L304
;		af_Offset      = (void*)((uint32)af_Buffers[af_CurrentBuf] + af_
	lea	$20(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),d0
	add.l	$92(a6),d0
	move.l	d0,$14(a6)
;		af_CurrentBuf  = 1 - af_CurrentBuf;
	moveq	#1,d0
	sub.l	$8E(a6),d0
	move.l	d0,$8E(a6)
;		af_BytesLeft   = bytesArrived - af_SeekOffset;
	sub.l	$92(a6),d2
	move.l	d2,$18(a6)
;		af_SeekOffset  = 0;
	clr.l	$92(a6)
L305
	cmp.l	$18(a6),d3
	bgt	L298
L306
;	MEM::Swap64(buffer, af_Offset, (n>>3));
	move.l	d3,d0
	moveq	#3,d1
	lsr.l	d1,d0
	move.l	a2,a0
	move.l	$14(a6),a1
	jsr	Swap64__MEM__r8Pvr9Pvr0Ui
;	af_BytesLeft -= n;
	sub.l	d3,$18(a6)
;	af_Offset     = (void*)((uint32)af_Offset + n);
	add.l	d3,$14(a6)
;	return (totalBytes + n)>>3;
	move.l	d4,d0
	add.l	d3,d0
	moveq	#3,d1
	asr.l	d1,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts

	SECTION "Write16Swap__xFILEIO__TPvUi:0",CODE


;sint32 xFILEIO::Write16Swap(void* buffer,size_t n)
	XDEF	Write16Swap__xFILEIO__TPvUi
Write16Swap__xFILEIO__TPvUi
	movem.l	d2/d3/a2/a3,-(a7)
	move.l	$1C(a7),d2
	move.l	$14(a7),a2
	move.l	$18(a7),a3
L307
;	if (((uint32)buffer|(uint32)af_Offset)&1UL)
	move.l	a3,d0
	or.l	$14(a2),d0
	and.l	#1,d0
	beq.b	L309
L308
;		return ERR_PTR;
	move.l	#-$3020000,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L309
;	n <<= 1;
	moveq	#1,d0
	asl.l	d0,d2
;	sint32 totalBytes = 0;
	moveq	#0,d3
;	while (n > af_BytesLeft)
	bra	L317
L310
;		if (!af_Handler)
	tst.l	$10(a2)
	bne.b	L312
L311
;			af_Offset			= af_Buffers[0];
	move.l	$20(a2),a0
	move.l	a0,$14(a2)
;			af_BytesLeft	= af_BufferSize;
	move.l	$1C(a2),d0
	move.l	d0,$18(a2)
;			return n;
	move.l	d2,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L312
;		if (af_BytesLeft)
	tst.l	$18(a2)
	beq.b	L314
L313
;			MEM::Swap16(af_Offset, buffer, (af_BytesLeft>>1));
	move.l	$18(a2),d0
	moveq	#1,d1
	asr.l	d1,d0
	move.l	$14(a2),a0
	move.l	a3,a1
	jsr	Swap16__MEM__r8Pvr9Pvr0Ui
;			n		-= af_BytesLeft;
	sub.l	$18(a2),d2
;			buffer			= (void*)((uint32)buffer + af_BytesLeft);
	move.l	a3,d0
	add.l	$18(a2),d0
	move.l	d0,a3
;			totalBytes	+= af_BytesLeft;
	add.l	$18(a2),d3
L314
;		if (WaitPacket() < 0)
	move.l	a2,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	tst.l	d0
	bpl.b	L316
L315
;			return ERR_FILE_WRITE;
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L316
;		SendPacket(af_Buffers[af_CurrentBuf]);
	lea	$20(a2),a0
	move.l	$8E(a2),d0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a2,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;		af_CurrentBuf	= 1 - af_CurrentBuf;
	moveq	#1,d0
	sub.l	$8E(a2),d0
	move.l	d0,$8E(a2)
;		af_Offset			= af_Buffers[af_CurrentBuf];
	lea	$20(a2),a0
	move.l	$8E(a2),d0
	move.l	0(a0,d0.l*4),$14(a2)
;		af_BytesLeft	= af_BufferSize;
	move.l	$1C(a2),d0
	move.l	d0,$18(a2)
L317
	cmp.l	$18(a2),d2
	bgt	L310
L318
;	MEM::Swap16(af_Offset, buffer, (n>>1));
	move.l	d2,d0
	moveq	#1,d1
	lsr.l	d1,d0
	move.l	$14(a2),a0
	move.l	a3,a1
	jsr	Swap16__MEM__r8Pvr9Pvr0Ui
;	af_BytesLeft		-= n;
	sub.l	d2,$18(a2)
;	af_Offset				= (void*)((uint32)af_Offset + n);
	add.l	d2,$14(a2)
;	return (totalBytes + n)>>1;
	move.l	d3,d0
	add.l	d2,d0
	moveq	#1,d1
	asr.l	d1,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts

	SECTION "Write32Swap__xFILEIO__TPvUi:0",CODE


;sint32 xFILEIO::Write32Swap(void* buffer,size_t n)
	XDEF	Write32Swap__xFILEIO__TPvUi
Write32Swap__xFILEIO__TPvUi
	movem.l	d2/d3/a2/a3,-(a7)
	move.l	$1C(a7),d2
	move.l	$14(a7),a2
	move.l	$18(a7),a3
L319
;	if (((uint32)buffer|(uint32)af_Offset)&1UL)
	move.l	a3,d0
	or.l	$14(a2),d0
	and.l	#1,d0
	beq.b	L321
L320
;		return ERR_PTR;
	move.l	#-$3020000,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L321
;	n <<= 2;
	moveq	#2,d0
	asl.l	d0,d2
;	sint32 totalBytes = 0;
	moveq	#0,d3
;	while (n > af_BytesLeft)
	bra	L329
L322
;		if (!af_Handler)
	tst.l	$10(a2)
	bne.b	L324
L323
;			af_Offset			= af_Buffers[0];
	move.l	$20(a2),a0
	move.l	a0,$14(a2)
;			af_BytesLeft	= af_BufferSize;
	move.l	$1C(a2),d0
	move.l	d0,$18(a2)
;			return n;
	move.l	d2,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L324
;		if (af_BytesLeft)
	tst.l	$18(a2)
	beq.b	L326
L325
;			MEM::Swap32(af_Offset, buffer, (af_BytesLeft>>2));
	move.l	$18(a2),d0
	moveq	#2,d1
	asr.l	d1,d0
	move.l	$14(a2),a0
	move.l	a3,a1
	jsr	Swap32__MEM__r8Pvr9Pvr0Ui
;			n		-= af_BytesLeft;
	sub.l	$18(a2),d2
;			buffer			= (void*)((uint32)buffer + af_BytesLeft);
	move.l	a3,d0
	add.l	$18(a2),d0
	move.l	d0,a3
;			totalBytes	+= af_BytesLeft;
	add.l	$18(a2),d3
L326
;		if (WaitPacket() < 0)
	move.l	a2,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	tst.l	d0
	bpl.b	L328
L327
;			return ERR_FILE_WRITE;
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L328
;		SendPacket(af_Buffers[af_CurrentBuf]);
	lea	$20(a2),a0
	move.l	$8E(a2),d0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a2,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;		af_CurrentBuf	= 1 - af_CurrentBuf;
	moveq	#1,d0
	sub.l	$8E(a2),d0
	move.l	d0,$8E(a2)
;		af_Offset			= af_Buffers[af_CurrentBuf];
	lea	$20(a2),a0
	move.l	$8E(a2),d0
	move.l	0(a0,d0.l*4),$14(a2)
;		af_BytesLeft	= af_BufferSize;
	move.l	$1C(a2),d0
	move.l	d0,$18(a2)
L329
	cmp.l	$18(a2),d2
	bgt	L322
L330
;	MEM::Swap32(af_Offset, buffer, (n>>2));
	move.l	d2,d0
	moveq	#2,d1
	lsr.l	d1,d0
	move.l	$14(a2),a0
	move.l	a3,a1
	jsr	Swap32__MEM__r8Pvr9Pvr0Ui
;	af_BytesLeft		-= n;
	sub.l	d2,$18(a2)
;	af_Offset				= (void*)((uint32)af_Offset + n);
	add.l	d2,$14(a2)
;	return (totalBytes + n)>>2;
	move.l	d3,d0
	add.l	d2,d0
	moveq	#2,d1
	asr.l	d1,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts

	SECTION "Write64Swap__xFILEIO__TPvUi:0",CODE


;sint32 xFILEIO::Write64Swap(void* buffer,size_t n)
	XDEF	Write64Swap__xFILEIO__TPvUi
Write64Swap__xFILEIO__TPvUi
	movem.l	d2/d3/a2/a3,-(a7)
	move.l	$1C(a7),d2
	move.l	$14(a7),a2
	move.l	$18(a7),a3
L331
;	if (((uint32)buffer|(uint32)af_Offset)&1UL)
	move.l	a3,d0
	or.l	$14(a2),d0
	and.l	#1,d0
	beq.b	L333
L332
;		return ERR_PTR;
	move.l	#-$3020000,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L333
;	n <<= 3;
	moveq	#3,d0
	asl.l	d0,d2
;	sint32 totalBytes = 0;
	moveq	#0,d3
;	while (n > af_BytesLeft)
	bra	L341
L334
;		if (!af_Handler)
	tst.l	$10(a2)
	bne.b	L336
L335
;			af_Offset			= af_Buffers[0];
	move.l	$20(a2),a0
	move.l	a0,$14(a2)
;			af_BytesLeft	= af_BufferSize;
	move.l	$1C(a2),d0
	move.l	d0,$18(a2)
;			return n;
	move.l	d2,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L336
;		if (af_BytesLeft)
	tst.l	$18(a2)
	beq.b	L338
L337
;			MEM::Swap64(af_Offset, buffer, (af_BytesLeft>>3));
	move.l	$18(a2),d0
	moveq	#3,d1
	asr.l	d1,d0
	move.l	$14(a2),a0
	move.l	a3,a1
	jsr	Swap64__MEM__r8Pvr9Pvr0Ui
;			n		-= af_BytesLeft;
	sub.l	$18(a2),d2
;			buffer			= (void*)((uint32)buffer + af_BytesLeft);
	move.l	a3,d0
	add.l	$18(a2),d0
	move.l	d0,a3
;			totalBytes	+= af_BytesLeft;
	add.l	$18(a2),d3
L338
;		if (WaitPacket() < 0)
	move.l	a2,-(a7)
	jsr	WaitPacket__xFILEIO__T
	addq.w	#4,a7
	tst.l	d0
	bpl.b	L340
L339
;			return ERR_FILE_WRITE;
	move.l	#-$3040005,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L340
;		SendPacket(af_Buffers[af_CurrentBuf]);
	lea	$20(a2),a0
	move.l	$8E(a2),d0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a2,-(a7)
	jsr	SendPacket__xFILEIO__TPv
	addq.w	#$8,a7
;		af_CurrentBuf	= 1 - af_CurrentBuf;
	moveq	#1,d0
	sub.l	$8E(a2),d0
	move.l	d0,$8E(a2)
;		af_Offset			= af_Buffers[af_CurrentBuf];
	lea	$20(a2),a0
	move.l	$8E(a2),d0
	move.l	0(a0,d0.l*4),$14(a2)
;		af_BytesLeft	= af_BufferSize;
	move.l	$1C(a2),d0
	move.l	d0,$18(a2)
L341
	cmp.l	$18(a2),d2
	bgt	L334
L342
;	MEM::Swap64(af_Offset, buffer, (n>>3));
	move.l	d2,d0
	moveq	#3,d1
	lsr.l	d1,d0
	move.l	$14(a2),a0
	move.l	a3,a1
	jsr	Swap64__MEM__r8Pvr9Pvr0Ui
;	af_BytesLeft		-= n;
	sub.l	d2,$18(a2)
;	af_Offset				= (void*)((uint32)af_Offset + n);
	add.l	d2,$14(a2)
;	return (totalBytes + n)>>3;
	move.l	d3,d0
	add.l	d2,d0
	moveq	#3,d1
	asr.l	d1,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts

	END
