
; Storm C Compiler
; extropialib:lib/Platforms/Amiga68k/BaseLib/sysBase.cpp
	mc68030
	mc68881
	XREF	FreeAll__MEM_
	XREF	_system
	XREF	_vsprintf
	XREF	_sprintf
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_st
	XREF	_gxSt
	XREF	_numStartArgs__xBASELIB
	XREF	_startArgs__xBASELIB
	XREF	_SysBase
	XREF	_TimerBase
	XREF	_DOSBase
	XREF	_PowerPCBase
	XREF	_main__sysBASELIB
	XREF	_allocated__MEM
	XREF	_totSize__MEM
	XREF	_nextFree__MEM
	XREF	_cnt__MEM
	XREF	_maxAllocs__MEM
	XREF	_fpuPrecision__CPU
	XREF	_cpuNames__CPU

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "_IntuitionBase:1",DATA

	XDEF	_IntuitionBase
_IntuitionBase
	dc.l	0

	SECTION "_sysData__sysBASELIB:1",DATA

	XDEF	_sysData__sysBASELIB
_sysData__sysBASELIB
	dc.l	0

	SECTION "_msgbuff__sysBASELIB:1",DATA

	XDEF	_msgbuff__sysBASELIB
_msgbuff__sysBASELIB
	dc.l	0

	SECTION "Init__sysBASELIB_:0",CODE


;sint32 sysBASELIB::Init()
	XDEF	Init__sysBASELIB_
Init__sysBASELIB_
	move.l	a6,-(a7)
L9
;	IntuitionBase = (INTUITIONBASE*)OpenLibrary("intuition.library", 4
	move.l	_SysBase,a6
	moveq	#$28,d0
	move.l	#L8,a1
	jsr	-$228(a6)
	move.l	d0,_IntuitionBase
;	if (IntuitionBase == 0)
	move.l	_IntuitionBase,a0
	cmp.w	#0,a0
	bne.b	L11
L10
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts
L11
;	sysData = AllocVec((MAXALLOCS*sizeof(MEMINFO))+MESSAGEBUFFSIZE, ME
	move.l	_SysBase,a6
	move.l	#$3000,d0
	move.l	#$10001,d1
	jsr	-$2AC(a6)
	move.l	d0,_sysData__sysBASELIB
;	if (sysData == 0)
	move.l	_sysData__sysBASELIB,a0
	cmp.w	#0,a0
	bne.b	L13
L12
;		CloseLibrary((LIBRARY*)IntuitionBase);
	move.l	_IntuitionBase,a1
	move.l	_SysBase,a6
	jsr	-$19E(a6)
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	move.l	(a7)+,a6
	rts
L13
;	MEM::allocated = (MEMINFO*)sysData;
	move.l	_sysData__sysBASELIB,_allocated__MEM
;	msgbuff = (char*)((uint32)sysData+(MAXALLOCS*sizeof(MEMINFO)));
	move.l	_sysData__sysBASELIB,d0
	add.l	#$2000,d0
	move.l	d0,_msgbuff__sysBASELIB
;  return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

L8
	dc.b	'intuition.library',0

	SECTION "Done__sysBASELIB_:0",CODE


;void sysBASELIB::Done()
	XDEF	Done__sysBASELIB_
Done__sysBASELIB_
	move.l	a6,-(a7)
L14
;	MEM::FreeAll();
	jsr	FreeAll__MEM_
;	if (sysData)
	tst.l	_sysData__sysBASELIB
	beq.b	L16
L15
;		FreeVec(sysData);
	move.l	_sysData__sysBASELIB,a1
	move.l	_SysBase,a6
	jsr	-$2B2(a6)
;		sysData = 0;
	clr.l	_sysData__sysBASELIB
;		msgbuff = 0;
	clr.l	_msgbuff__sysBASELIB
L16
;	if (IntuitionBase)
	tst.l	_IntuitionBase
	beq.b	L18
L17
;		CloseLibrary((LIBRARY*)IntuitionBase);
	move.l	_IntuitionBase,a1
	move.l	_SysBase,a6
	jsr	-$19E(a6)
L18
;	IntuitionBase = 0;
	clr.l	_IntuitionBase
	move.l	(a7)+,a6
	rts

	SECTION "MessageBox__sysBASELIB__PcPcPce:0",CODE


;sint32 sysBASELIB::MessageBox(char* title, char* opts, char* body,..
	XDEF	MessageBox__sysBASELIB__PcPcPce
MessageBox__sysBASELIB__PcPcPce
L20	EQU	-$18
	link	a5,#L20
	movem.l	d2/a2/a3/a6,-(a7)
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L19
;	va_start(arglist,body)
	lea	$10(a5),a0
	move.l	a0,d2
	addq.l	#4,d2
;	vsprintf(msgbuff,body,arglist);
	move.l	d2,-(a7)
	move.l	$10(a5),-(a7)
	move.l	_msgbuff__sysBASELIB,-(a7)
	jsr	_vsprintf
	add.w	#$C,a7
;	EasyStruct mb = {sizeof(EasyStruct),0,title, msgbuff, o
	lea	-$18(a5),a0
	move.l	#$14,(a0)+
	clr.l	(a0)+
	move.l	a3,(a0)+
	move.l	_msgbuff__sysBASELIB,(a0)+
	move.l	a2,(a0)
;	return EasyRequest(0, &mb, 0, arglist);
	move.l	d2,-(a7)
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	lea	-$18(a5),a1
	sub.l	a2,a2
	move.l	a7,a3
	jsr	-$24C(a6)
	addq.w	#4,a7
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts

	SECTION "OpenDebugFile__sysBASELIB__Pc:0",CODE


;void sysBASELIB::OpenDebugFile(char *name)
	XDEF	OpenDebugFile__sysBASELIB__Pc
OpenDebugFile__sysBASELIB__Pc
	move.l	4(a7),a0
L23
;	sprintf(msgbuff,"Run >NIL: %s \"%s\" ", xFILE_VIEWER_APP, name);
	move.l	a0,-(a7)
	move.l	#L21,-(a7)
	move.l	#L22,-(a7)
	move.l	_msgbuff__sysBASELIB,-(a7)
	jsr	_sprintf
	add.w	#$10,a7
;	RunAsyncProgram(msgbuff);
	move.l	_msgbuff__sysBASELIB,a0
	move.l	a0,-(a7)
	jsr	_system
	addq.w	#4,a7
	rts

L22
	dc.b	'Run >NIL: %s ',$22,'%s',$22,' ',0
L21
	dc.b	'SYS:Utilities/Multiview',0

	END
