
; Storm C Compiler
; Mendoza:Extropia/eXtropia/prj/VM2/Optim2/VM_EA.cpp
	mc68030
	mc68881
	XREF	_0dt__VMCORE__T
	XREF	_system
	XREF	op__leftshift__ostream__Td
	XREF	op__leftshift__ostream__TUj
	XREF	op__leftshift__ostream__Tj
	XREF	op__leftshift__ostream__TPCc
	XREF	op__leftshift__ostream__Tc
	XREF	opfx__ostream__T
	XREF	read__istream__TPci
	XREF	get__istream__TRc
	XREF	getline__istream__TPcic
	XREF	get__istream__TPcic
	XREF	op__rightshift__istream__TRc
	XREF	op__rightshift__istream__TPc
	XREF	doallocate__streambuf__T
	XREF	xsgetn__streambuf__TPci
	XREF	xsputn__streambuf__TPCci
	XREF	underflow__streambuf__T
	XREF	overflow__streambuf__Ti
	XREF	setbuf__streambuf__TPcUi
	XREF	sputn__streambuf__TPCci
	XREF	_0dt__streambuf__T
	XREF	userword__ios__Ti
	XREF	init__ios__TP09streambuf
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_basefield__ios
	XREF	_adjustfield__ios
	XREF	_floatfield__ios
	XREF	_aNextBit__ios
	XREF	_aNextWord__ios
	XREF	_cin
	XREF	_cout
	XREF	_cerr
	XREF	_clog
	XREF	_st
	XREF	_gxSt
	XREF	_errSev__xBASELIB
	XREF	_errTbl__xBASELIB
	XREF	_SysBase
	XREF	_IntuitionBase
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
	XREF	_instTable__VMCORE
	XREF	_eaTable__VMCORE

	SECTION ":0",CODE


;void* VMCORE::R0(EAFARGS)			
	XDEF	R0__VMCORE__r10P06VMCOREr7Ui
R0__VMCORE__r10P06VMCOREr7Ui
L28
	moveq	#$8,d0
	sub.l	d7,d0
	add.l	a2,d0
	rts

;void* VMCORE::R1(EAFARGS)			
	XDEF	R1__VMCORE__r10P06VMCOREr7Ui
R1__VMCORE__r10P06VMCOREr7Ui
L29
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$8(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R2(EAFARGS)			
	XDEF	R2__VMCORE__r10P06VMCOREr7Ui
R2__VMCORE__r10P06VMCOREr7Ui
L30
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$10(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R3(EAFARGS)			
	XDEF	R3__VMCORE__r10P06VMCOREr7Ui
R3__VMCORE__r10P06VMCOREr7Ui
L31
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$18(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R4(EAFARGS)			
	XDEF	R4__VMCORE__r10P06VMCOREr7Ui
R4__VMCORE__r10P06VMCOREr7Ui
L32
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$20(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R5(EAFARGS)			
	XDEF	R5__VMCORE__r10P06VMCOREr7Ui
R5__VMCORE__r10P06VMCOREr7Ui
L33
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$28(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R6(EAFARGS)			
	XDEF	R6__VMCORE__r10P06VMCOREr7Ui
R6__VMCORE__r10P06VMCOREr7Ui
L34
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$30(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R7(EAFARGS)			
	XDEF	R7__VMCORE__r10P06VMCOREr7Ui
R7__VMCORE__r10P06VMCOREr7Ui
L35
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$38(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R8(EAFARGS)			
	XDEF	R8__VMCORE__r10P06VMCOREr7Ui
R8__VMCORE__r10P06VMCOREr7Ui
L36
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$40(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R9(EAFARGS)			
	XDEF	R9__VMCORE__r10P06VMCOREr7Ui
R9__VMCORE__r10P06VMCOREr7Ui
L37
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$48(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R10(EAFARGS)		
	XDEF	R10__VMCORE__r10P06VMCOREr7Ui
R10__VMCORE__r10P06VMCOREr7Ui
L38
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$50(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R11(EAFARGS)		
	XDEF	R11__VMCORE__r10P06VMCOREr7Ui
R11__VMCORE__r10P06VMCOREr7Ui
L39
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$58(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R12(EAFARGS)		
	XDEF	R12__VMCORE__r10P06VMCOREr7Ui
R12__VMCORE__r10P06VMCOREr7Ui
L40
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$60(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R13(EAFARGS)		
	XDEF	R13__VMCORE__r10P06VMCOREr7Ui
R13__VMCORE__r10P06VMCOREr7Ui
L41
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$68(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R14(EAFARGS)		
	XDEF	R14__VMCORE__r10P06VMCOREr7Ui
R14__VMCORE__r10P06VMCOREr7Ui
L42
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$70(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R15(EAFARGS)		
	XDEF	R15__VMCORE__r10P06VMCOREr7Ui
R15__VMCORE__r10P06VMCOREr7Ui
L43
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$78(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R16(EAFARGS)		
	XDEF	R16__VMCORE__r10P06VMCOREr7Ui
R16__VMCORE__r10P06VMCOREr7Ui
L44
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$80(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R17(EAFARGS)		
	XDEF	R17__VMCORE__r10P06VMCOREr7Ui
R17__VMCORE__r10P06VMCOREr7Ui
L45
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$88(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R18(EAFARGS)		
	XDEF	R18__VMCORE__r10P06VMCOREr7Ui
R18__VMCORE__r10P06VMCOREr7Ui
L46
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$90(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R19(EAFARGS)		
	XDEF	R19__VMCORE__r10P06VMCOREr7Ui
R19__VMCORE__r10P06VMCOREr7Ui
L47
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$98(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R20(EAFARGS)		
	XDEF	R20__VMCORE__r10P06VMCOREr7Ui
R20__VMCORE__r10P06VMCOREr7Ui
L48
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$A0(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R21(EAFARGS)		
	XDEF	R21__VMCORE__r10P06VMCOREr7Ui
R21__VMCORE__r10P06VMCOREr7Ui
L49
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$A8(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R22(EAFARGS)		
	XDEF	R22__VMCORE__r10P06VMCOREr7Ui
R22__VMCORE__r10P06VMCOREr7Ui
L50
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$B0(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R23(EAFARGS)		
	XDEF	R23__VMCORE__r10P06VMCOREr7Ui
R23__VMCORE__r10P06VMCOREr7Ui
L51
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$B8(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R24(EAFARGS)		
	XDEF	R24__VMCORE__r10P06VMCOREr7Ui
R24__VMCORE__r10P06VMCOREr7Ui
L52
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$C0(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R25(EAFARGS)		
	XDEF	R25__VMCORE__r10P06VMCOREr7Ui
R25__VMCORE__r10P06VMCOREr7Ui
L53
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$C8(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R26(EAFARGS)		
	XDEF	R26__VMCORE__r10P06VMCOREr7Ui
R26__VMCORE__r10P06VMCOREr7Ui
L54
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$D0(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R27(EAFARGS)		
	XDEF	R27__VMCORE__r10P06VMCOREr7Ui
R27__VMCORE__r10P06VMCOREr7Ui
L55
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$D8(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R28(EAFARGS)		
	XDEF	R28__VMCORE__r10P06VMCOREr7Ui
R28__VMCORE__r10P06VMCOREr7Ui
L56
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$E0(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R29(EAFARGS)		
	XDEF	R29__VMCORE__r10P06VMCOREr7Ui
R29__VMCORE__r10P06VMCOREr7Ui
L57
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$E8(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R30(EAFARGS)		
	XDEF	R30__VMCORE__r10P06VMCOREr7Ui
R30__VMCORE__r10P06VMCOREr7Ui
L58
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$F0(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::R31(EAFARGS)		
	XDEF	R31__VMCORE__r10P06VMCOREr7Ui
R31__VMCORE__r10P06VMCOREr7Ui
L59
	moveq	#$8,d0
	sub.l	d7,d0
	lea	$F8(a2),a0
	add.l	a0,d0
	rts

;void* VMCORE::IR0(EAFARGS)		
	XDEF	IR0__VMCORE__r10P06VMCOREr7Ui
IR0__VMCORE__r10P06VMCOREr7Ui
L60
	move.l	4(a2),d0
	rts

;void* VMCORE::IR1(EAFARGS)		
	XDEF	IR1__VMCORE__r10P06VMCOREr7Ui
IR1__VMCORE__r10P06VMCOREr7Ui
L61
	lea	$8(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR2(EAFARGS)		
	XDEF	IR2__VMCORE__r10P06VMCOREr7Ui
IR2__VMCORE__r10P06VMCOREr7Ui
L62
	lea	$10(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR3(EAFARGS)		
	XDEF	IR3__VMCORE__r10P06VMCOREr7Ui
IR3__VMCORE__r10P06VMCOREr7Ui
L63
	lea	$18(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR4(EAFARGS)		
	XDEF	IR4__VMCORE__r10P06VMCOREr7Ui
IR4__VMCORE__r10P06VMCOREr7Ui
L64
	lea	$20(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR5(EAFARGS)		
	XDEF	IR5__VMCORE__r10P06VMCOREr7Ui
IR5__VMCORE__r10P06VMCOREr7Ui
L65
	lea	$28(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR6(EAFARGS)		
	XDEF	IR6__VMCORE__r10P06VMCOREr7Ui
IR6__VMCORE__r10P06VMCOREr7Ui
L66
	lea	$30(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR7(EAFARGS)		
	XDEF	IR7__VMCORE__r10P06VMCOREr7Ui
IR7__VMCORE__r10P06VMCOREr7Ui
L67
	lea	$38(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR8(EAFARGS)		
	XDEF	IR8__VMCORE__r10P06VMCOREr7Ui
IR8__VMCORE__r10P06VMCOREr7Ui
L68
	lea	$40(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR9(EAFARGS)		
	XDEF	IR9__VMCORE__r10P06VMCOREr7Ui
IR9__VMCORE__r10P06VMCOREr7Ui
L69
	lea	$48(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR10(EAFARGS)		
	XDEF	IR10__VMCORE__r10P06VMCOREr7Ui
IR10__VMCORE__r10P06VMCOREr7Ui
L70
	lea	$50(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR11(EAFARGS)		
	XDEF	IR11__VMCORE__r10P06VMCOREr7Ui
IR11__VMCORE__r10P06VMCOREr7Ui
L71
	lea	$58(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR12(EAFARGS)		
	XDEF	IR12__VMCORE__r10P06VMCOREr7Ui
IR12__VMCORE__r10P06VMCOREr7Ui
L72
	lea	$60(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR13(EAFARGS)		
	XDEF	IR13__VMCORE__r10P06VMCOREr7Ui
IR13__VMCORE__r10P06VMCOREr7Ui
L73
	lea	$68(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR14(EAFARGS)		
	XDEF	IR14__VMCORE__r10P06VMCOREr7Ui
IR14__VMCORE__r10P06VMCOREr7Ui
L74
	lea	$70(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR15(EAFARGS)		
	XDEF	IR15__VMCORE__r10P06VMCOREr7Ui
IR15__VMCORE__r10P06VMCOREr7Ui
L75
	lea	$78(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR16(EAFARGS)		
	XDEF	IR16__VMCORE__r10P06VMCOREr7Ui
IR16__VMCORE__r10P06VMCOREr7Ui
L76
	lea	$80(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR17(EAFARGS)		
	XDEF	IR17__VMCORE__r10P06VMCOREr7Ui
IR17__VMCORE__r10P06VMCOREr7Ui
L77
	lea	$88(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR18(EAFARGS)		
	XDEF	IR18__VMCORE__r10P06VMCOREr7Ui
IR18__VMCORE__r10P06VMCOREr7Ui
L78
	lea	$90(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR19(EAFARGS)		
	XDEF	IR19__VMCORE__r10P06VMCOREr7Ui
IR19__VMCORE__r10P06VMCOREr7Ui
L79
	lea	$98(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR20(EAFARGS)		
	XDEF	IR20__VMCORE__r10P06VMCOREr7Ui
IR20__VMCORE__r10P06VMCOREr7Ui
L80
	lea	$A0(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR21(EAFARGS)		
	XDEF	IR21__VMCORE__r10P06VMCOREr7Ui
IR21__VMCORE__r10P06VMCOREr7Ui
L81
	lea	$A8(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR22(EAFARGS)		
	XDEF	IR22__VMCORE__r10P06VMCOREr7Ui
IR22__VMCORE__r10P06VMCOREr7Ui
L82
	lea	$B0(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR23(EAFARGS)		
	XDEF	IR23__VMCORE__r10P06VMCOREr7Ui
IR23__VMCORE__r10P06VMCOREr7Ui
L83
	lea	$B8(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR24(EAFARGS)		
	XDEF	IR24__VMCORE__r10P06VMCOREr7Ui
IR24__VMCORE__r10P06VMCOREr7Ui
L84
	lea	$C0(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR25(EAFARGS)		
	XDEF	IR25__VMCORE__r10P06VMCOREr7Ui
IR25__VMCORE__r10P06VMCOREr7Ui
L85
	lea	$C8(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR26(EAFARGS)		
	XDEF	IR26__VMCORE__r10P06VMCOREr7Ui
IR26__VMCORE__r10P06VMCOREr7Ui
L86
	lea	$D0(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR27(EAFARGS)		
	XDEF	IR27__VMCORE__r10P06VMCOREr7Ui
IR27__VMCORE__r10P06VMCOREr7Ui
L87
	lea	$D8(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR28(EAFARGS)		
	XDEF	IR28__VMCORE__r10P06VMCOREr7Ui
IR28__VMCORE__r10P06VMCOREr7Ui
L88
	lea	$E0(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR29(EAFARGS)		
	XDEF	IR29__VMCORE__r10P06VMCOREr7Ui
IR29__VMCORE__r10P06VMCOREr7Ui
L89
	lea	$E8(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR30(EAFARGS)		
	XDEF	IR30__VMCORE__r10P06VMCOREr7Ui
IR30__VMCORE__r10P06VMCOREr7Ui
L90
	lea	$F0(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::IR31(EAFARGS)		
	XDEF	IR31__VMCORE__r10P06VMCOREr7Ui
IR31__VMCORE__r10P06VMCOREr7Ui
L91
	lea	$F8(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::LIR0(EAFARGS)		
	XDEF	LIR0__VMCORE__r10P06VMCOREr7Ui
LIR0__VMCORE__r10P06VMCOREr7Ui
L92
	move.l	4(a2),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR1(EAFARGS)		
	XDEF	LIR1__VMCORE__r10P06VMCOREr7Ui
LIR1__VMCORE__r10P06VMCOREr7Ui
L93
	lea	$8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR2(EAFARGS)		
	XDEF	LIR2__VMCORE__r10P06VMCOREr7Ui
LIR2__VMCORE__r10P06VMCOREr7Ui
L94
	lea	$10(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR3(EAFARGS)		
	XDEF	LIR3__VMCORE__r10P06VMCOREr7Ui
LIR3__VMCORE__r10P06VMCOREr7Ui
L95
	lea	$18(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR4(EAFARGS)		
	XDEF	LIR4__VMCORE__r10P06VMCOREr7Ui
LIR4__VMCORE__r10P06VMCOREr7Ui
L96
	lea	$20(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR5(EAFARGS)		
	XDEF	LIR5__VMCORE__r10P06VMCOREr7Ui
LIR5__VMCORE__r10P06VMCOREr7Ui
L97
	lea	$28(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR6(EAFARGS)		
	XDEF	LIR6__VMCORE__r10P06VMCOREr7Ui
LIR6__VMCORE__r10P06VMCOREr7Ui
L98
	lea	$30(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR7(EAFARGS)		
	XDEF	LIR7__VMCORE__r10P06VMCOREr7Ui
LIR7__VMCORE__r10P06VMCOREr7Ui
L99
	lea	$38(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR8(EAFARGS)		
	XDEF	LIR8__VMCORE__r10P06VMCOREr7Ui
LIR8__VMCORE__r10P06VMCOREr7Ui
L100
	lea	$40(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR9(EAFARGS)		
	XDEF	LIR9__VMCORE__r10P06VMCOREr7Ui
LIR9__VMCORE__r10P06VMCOREr7Ui
L101
	lea	$48(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR10(EAFARGS)	
	XDEF	LIR10__VMCORE__r10P06VMCOREr7Ui
LIR10__VMCORE__r10P06VMCOREr7Ui
L102
	lea	$50(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR11(EAFARGS)	
	XDEF	LIR11__VMCORE__r10P06VMCOREr7Ui
LIR11__VMCORE__r10P06VMCOREr7Ui
L103
	lea	$58(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR12(EAFARGS)	
	XDEF	LIR12__VMCORE__r10P06VMCOREr7Ui
LIR12__VMCORE__r10P06VMCOREr7Ui
L104
	lea	$60(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR13(EAFARGS)	
	XDEF	LIR13__VMCORE__r10P06VMCOREr7Ui
LIR13__VMCORE__r10P06VMCOREr7Ui
L105
	lea	$68(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR14(EAFARGS)	
	XDEF	LIR14__VMCORE__r10P06VMCOREr7Ui
LIR14__VMCORE__r10P06VMCOREr7Ui
L106
	lea	$70(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR15(EAFARGS)	
	XDEF	LIR15__VMCORE__r10P06VMCOREr7Ui
LIR15__VMCORE__r10P06VMCOREr7Ui
L107
	lea	$78(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR16(EAFARGS)	
	XDEF	LIR16__VMCORE__r10P06VMCOREr7Ui
LIR16__VMCORE__r10P06VMCOREr7Ui
L108
	lea	$80(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR17(EAFARGS)	
	XDEF	LIR17__VMCORE__r10P06VMCOREr7Ui
LIR17__VMCORE__r10P06VMCOREr7Ui
L109
	lea	$88(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR18(EAFARGS)	
	XDEF	LIR18__VMCORE__r10P06VMCOREr7Ui
LIR18__VMCORE__r10P06VMCOREr7Ui
L110
	lea	$90(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR19(EAFARGS)	
	XDEF	LIR19__VMCORE__r10P06VMCOREr7Ui
LIR19__VMCORE__r10P06VMCOREr7Ui
L111
	lea	$98(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR20(EAFARGS)	
	XDEF	LIR20__VMCORE__r10P06VMCOREr7Ui
LIR20__VMCORE__r10P06VMCOREr7Ui
L112
	lea	$A0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR21(EAFARGS)	
	XDEF	LIR21__VMCORE__r10P06VMCOREr7Ui
LIR21__VMCORE__r10P06VMCOREr7Ui
L113
	lea	$A8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR22(EAFARGS)	
	XDEF	LIR22__VMCORE__r10P06VMCOREr7Ui
LIR22__VMCORE__r10P06VMCOREr7Ui
L114
	lea	$B0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR23(EAFARGS)	
	XDEF	LIR23__VMCORE__r10P06VMCOREr7Ui
LIR23__VMCORE__r10P06VMCOREr7Ui
L115
	lea	$B8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR24(EAFARGS)	
	XDEF	LIR24__VMCORE__r10P06VMCOREr7Ui
LIR24__VMCORE__r10P06VMCOREr7Ui
L116
	lea	$C0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR25(EAFARGS)	
	XDEF	LIR25__VMCORE__r10P06VMCOREr7Ui
LIR25__VMCORE__r10P06VMCOREr7Ui
L117
	lea	$C8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR26(EAFARGS)	
	XDEF	LIR26__VMCORE__r10P06VMCOREr7Ui
LIR26__VMCORE__r10P06VMCOREr7Ui
L118
	lea	$D0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR27(EAFARGS)	
	XDEF	LIR27__VMCORE__r10P06VMCOREr7Ui
LIR27__VMCORE__r10P06VMCOREr7Ui
L119
	lea	$D8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR28(EAFARGS)	
	XDEF	LIR28__VMCORE__r10P06VMCOREr7Ui
LIR28__VMCORE__r10P06VMCOREr7Ui
L120
	lea	$E0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR29(EAFARGS)	
	XDEF	LIR29__VMCORE__r10P06VMCOREr7Ui
LIR29__VMCORE__r10P06VMCOREr7Ui
L121
	lea	$E8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR30(EAFARGS)	
	XDEF	LIR30__VMCORE__r10P06VMCOREr7Ui
LIR30__VMCORE__r10P06VMCOREr7Ui
L122
	lea	$F0(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LIR31(EAFARGS)	
	XDEF	LIR31__VMCORE__r10P06VMCOREr7Ui
LIR31__VMCORE__r10P06VMCOREr7Ui
L123
	lea	$F8(a2),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LUIR0(EAFARGS)
	XDEF	LUIR0__VMCORE__r10P06VMCOREr7Ui
LUIR0__VMCORE__r10P06VMCOREr7Ui
L124
;	uint8* &p = This->gpRegs[0].PtrU8();
	lea	4(a2),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR1(EAFARGS)
	XDEF	LUIR1__VMCORE__r10P06VMCOREr7Ui
LUIR1__VMCORE__r10P06VMCOREr7Ui
L125
;	uint8* &p = This->gpRegs[1].PtrU8();
	lea	$8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR2(EAFARGS)
	XDEF	LUIR2__VMCORE__r10P06VMCOREr7Ui
LUIR2__VMCORE__r10P06VMCOREr7Ui
L126
;	uint8* &p = This->gpRegs[2].PtrU8();
	lea	$10(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR3(EAFARGS)
	XDEF	LUIR3__VMCORE__r10P06VMCOREr7Ui
LUIR3__VMCORE__r10P06VMCOREr7Ui
L127
;	uint8* &p = This->gpRegs[3].PtrU8();
	lea	$18(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR4(EAFARGS)
	XDEF	LUIR4__VMCORE__r10P06VMCOREr7Ui
LUIR4__VMCORE__r10P06VMCOREr7Ui
L128
;	uint8* &p = This->gpRegs[4].PtrU8();
	lea	$20(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR5(EAFARGS)
	XDEF	LUIR5__VMCORE__r10P06VMCOREr7Ui
LUIR5__VMCORE__r10P06VMCOREr7Ui
L129
;	uint8* &p = This->gpRegs[5].PtrU8();
	lea	$28(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR6(EAFARGS)
	XDEF	LUIR6__VMCORE__r10P06VMCOREr7Ui
LUIR6__VMCORE__r10P06VMCOREr7Ui
L130
;	uint8* &p = This->gpRegs[6].PtrU8();
	lea	$30(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR7(EAFARGS)
	XDEF	LUIR7__VMCORE__r10P06VMCOREr7Ui
LUIR7__VMCORE__r10P06VMCOREr7Ui
L131
;	uint8* &p = This->gpRegs[7].PtrU8();
	lea	$38(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR8(EAFARGS)
	XDEF	LUIR8__VMCORE__r10P06VMCOREr7Ui
LUIR8__VMCORE__r10P06VMCOREr7Ui
L132
;	uint8* &p = This->gpRegs[8].PtrU8();
	lea	$40(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR9(EAFARGS)
	XDEF	LUIR9__VMCORE__r10P06VMCOREr7Ui
LUIR9__VMCORE__r10P06VMCOREr7Ui
L133
;	uint8* &p = This->gpRegs[9].PtrU8();
	lea	$48(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR10(EAFARGS)
	XDEF	LUIR10__VMCORE__r10P06VMCOREr7Ui
LUIR10__VMCORE__r10P06VMCOREr7Ui
L134
;	uint8* &p = This->gpRegs[10].PtrU8();
	lea	$50(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR11(EAFARGS)
	XDEF	LUIR11__VMCORE__r10P06VMCOREr7Ui
LUIR11__VMCORE__r10P06VMCOREr7Ui
L135
;	uint8* &p = This->gpRegs[11].PtrU8();
	lea	$58(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR12(EAFARGS)
	XDEF	LUIR12__VMCORE__r10P06VMCOREr7Ui
LUIR12__VMCORE__r10P06VMCOREr7Ui
L136
;	uint8* &p = This->gpRegs[12].PtrU8();
	lea	$60(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR13(EAFARGS)
	XDEF	LUIR13__VMCORE__r10P06VMCOREr7Ui
LUIR13__VMCORE__r10P06VMCOREr7Ui
L137
;	uint8* &p = This->gpRegs[13].PtrU8();
	lea	$68(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR14(EAFARGS)
	XDEF	LUIR14__VMCORE__r10P06VMCOREr7Ui
LUIR14__VMCORE__r10P06VMCOREr7Ui
L138
;	uint8* &p = This->gpRegs[14].PtrU8();
	lea	$70(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR15(EAFARGS)
	XDEF	LUIR15__VMCORE__r10P06VMCOREr7Ui
LUIR15__VMCORE__r10P06VMCOREr7Ui
L139
;	uint8* &p = This->gpRegs[15].PtrU8();
	lea	$78(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR16(EAFARGS)
	XDEF	LUIR16__VMCORE__r10P06VMCOREr7Ui
LUIR16__VMCORE__r10P06VMCOREr7Ui
L140
;	uint8* &p = This->gpRegs[16].PtrU8();
	lea	$80(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR17(EAFARGS)
	XDEF	LUIR17__VMCORE__r10P06VMCOREr7Ui
LUIR17__VMCORE__r10P06VMCOREr7Ui
L141
;	uint8* &p = This->gpRegs[17].PtrU8();
	lea	$88(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR18(EAFARGS)
	XDEF	LUIR18__VMCORE__r10P06VMCOREr7Ui
LUIR18__VMCORE__r10P06VMCOREr7Ui
L142
;	uint8* &p = This->gpRegs[18].PtrU8();
	lea	$90(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR19(EAFARGS)
	XDEF	LUIR19__VMCORE__r10P06VMCOREr7Ui
LUIR19__VMCORE__r10P06VMCOREr7Ui
L143
;	uint8* &p = This->gpRegs[19].PtrU8();
	lea	$98(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR20(EAFARGS)
	XDEF	LUIR20__VMCORE__r10P06VMCOREr7Ui
LUIR20__VMCORE__r10P06VMCOREr7Ui
L144
;	uint8* &p = This->gpRegs[20].PtrU8();
	lea	$A0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR21(EAFARGS)
	XDEF	LUIR21__VMCORE__r10P06VMCOREr7Ui
LUIR21__VMCORE__r10P06VMCOREr7Ui
L145
;	uint8* &p = This->gpRegs[21].PtrU8();
	lea	$A8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR22(EAFARGS)
	XDEF	LUIR22__VMCORE__r10P06VMCOREr7Ui
LUIR22__VMCORE__r10P06VMCOREr7Ui
L146
;	uint8* &p = This->gpRegs[22].PtrU8();
	lea	$B0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR23(EAFARGS)
	XDEF	LUIR23__VMCORE__r10P06VMCOREr7Ui
LUIR23__VMCORE__r10P06VMCOREr7Ui
L147
;	uint8* &p = This->gpRegs[23].PtrU8();
	lea	$B8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR24(EAFARGS)
	XDEF	LUIR24__VMCORE__r10P06VMCOREr7Ui
LUIR24__VMCORE__r10P06VMCOREr7Ui
L148
;	uint8* &p = This->gpRegs[24].PtrU8();
	lea	$C0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR25(EAFARGS)
	XDEF	LUIR25__VMCORE__r10P06VMCOREr7Ui
LUIR25__VMCORE__r10P06VMCOREr7Ui
L149
;	uint8* &p = This->gpRegs[25].PtrU8();
	lea	$C8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR26(EAFARGS)
	XDEF	LUIR26__VMCORE__r10P06VMCOREr7Ui
LUIR26__VMCORE__r10P06VMCOREr7Ui
L150
;	uint8* &p = This->gpRegs[26].PtrU8();
	lea	$D0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR27(EAFARGS)
	XDEF	LUIR27__VMCORE__r10P06VMCOREr7Ui
LUIR27__VMCORE__r10P06VMCOREr7Ui
L151
;	uint8* &p = This->gpRegs[27].PtrU8();
	lea	$D8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR28(EAFARGS)
	XDEF	LUIR28__VMCORE__r10P06VMCOREr7Ui
LUIR28__VMCORE__r10P06VMCOREr7Ui
L152
;	uint8* &p = This->gpRegs[28].PtrU8();
	lea	$E0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR29(EAFARGS)
	XDEF	LUIR29__VMCORE__r10P06VMCOREr7Ui
LUIR29__VMCORE__r10P06VMCOREr7Ui
L153
;	uint8* &p = This->gpRegs[29].PtrU8();
	lea	$E8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR30(EAFARGS)
	XDEF	LUIR30__VMCORE__r10P06VMCOREr7Ui
LUIR30__VMCORE__r10P06VMCOREr7Ui
L154
;	uint8* &p = This->gpRegs[30].PtrU8();
	lea	$F0(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::LUIR31(EAFARGS)
	XDEF	LUIR31__VMCORE__r10P06VMCOREr7Ui
LUIR31__VMCORE__r10P06VMCOREr7Ui
L155
;	uint8* &p = This->gpRegs[31].PtrU8();
	lea	$F8(a2),a0
	lea	4(a0),a1
;	p += EAOFFSET();
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::IRRO(EAFARGS)
	XDEF	IRRO__VMCORE__r10P06VMCOREr7Ui
IRRO__VMCORE__r10P06VMCOREr7Ui
L156
;	This->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),a1
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::IRROU(EAFARGS)
	XDEF	IRROU__VMCORE__r10P06VMCOREr7Ui
IRROU__VMCORE__r10P06VMCOREr7Ui
L157
;	This->instPtr++;
	move.l	$110(a2),a0
	lea	4(a0),a0
	move.l	a0,$110(a2)
;	uint8*	&p = IRRO_BASEREG.PtrU8();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	lea	4(a0),a1
;	p += IRRO_OFSTREG();
	move.l	$110(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* VMCORE::CLONE1ST(EAFARGS)	
	XDEF	CLONE1ST__VMCORE__r10P06VMCOREr7Ui
CLONE1ST__VMCORE__r10P06VMCOREr7Ui
L158
	move.l	$104(a2),d0
	rts

;void* VMCORE::CLONE2ND(EAFARGS)	
	XDEF	CLONE2ND__VMCORE__r10P06VMCOREr7Ui
CLONE2ND__VMCORE__r10P06VMCOREr7Ui
L159
	lea	$104(a2),a0
	move.l	4(a0),d0
	rts

;void* VMCORE::CTR(EAFARGS)			
	XDEF	CTR__VMCORE__r10P06VMCOREr7Ui
CTR__VMCORE__r10P06VMCOREr7Ui
L160
	move.l	#$100,d0
	add.l	a2,d0
	rts

;void* VMCORE::DS(EAFARGS)				
	XDEF	DS__VMCORE__r10P06VMCOREr7Ui
DS__VMCORE__r10P06VMCOREr7Ui
L161
	move.l	$118(a2),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::CDS(EAFARGS)			
	XDEF	CDS__VMCORE__r10P06VMCOREr7Ui
CDS__VMCORE__r10P06VMCOREr7Ui
L162
	move.l	$11C(a2),a1
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* VMCORE::LITERAL(EAFARGS)	
	XDEF	LITERAL__VMCORE__r10P06VMCOREr7Ui
LITERAL__VMCORE__r10P06VMCOREr7Ui
L163
	move.l	$110(a2),a0
	addq.w	#4,a0
	move.l	a0,$110(a2)
	moveq	#4,d0
	sub.l	d7,d0
	add.l	a0,d0
	rts

	END
