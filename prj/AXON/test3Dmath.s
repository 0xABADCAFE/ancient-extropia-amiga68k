
; Storm C Compiler
; Mendoza:Extropia/eXtropia/prj/AXON/test3Dmath.cpp
	mc68030
	mc68881
	XREF	op__multAsgn__TRANSFORM__TRC09TRANSFORM
	XREF	Rotate__TRANSFORM__Tfff
	XREF	Translate__TRANSFORM__Tfff
	XREF	Scale__TRANSFORM__Tfff
	XREF	Define__PLANE__TP05VEC3DP05VEC3DP05VEC3D
	XREF	Define__PLANE__TR05VEC3DR05VEC3DR05VEC3D
	XREF	op__multAsgn__VEC3D__TRC09TRANSFORM
	XREF	_sqrt__r
	XREF	MessageBox__sysBASELIB__PcPcPce
	XREF	op__leftshift__ostream__Td
	XREF	op__leftshift__ostream__Tf
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
	XREF	Done__xBASELIB_
	XREF	Init__xBASELIB_
	XREF	_memset
	XREF	_memmove
	XREF	_system
	XREF	_ftell
	XREF	_fseek
	XREF	_fwrite
	XREF	_fread
	XREF	_vfprintf
	XREF	_sprintf
	XREF	_fflush
	XREF	_feof
	XREF	_fclose
	XREF	_fopen
	XREF	_fgets
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_st
	XREF	_gxSt
	XREF	_errBuff__xBASELIB
	XREF	_errSev__xBASELIB
	XREF	_errTbl__xBASELIB
	XREF	_SysBase
	XREF	_IntuitionBase
	XREF	_basefield__ios
	XREF	_adjustfield__ios
	XREF	_floatfield__ios
	XREF	_aNextBit__ios
	XREF	_aNextWord__ios
	XREF	_cin
	XREF	_cout
	XREF	_cerr
	XREF	_clog
	XREF	_sysData__sysBASELIB
	XREF	_msgbuff__sysBASELIB
	XREF	_main__sysBASELIB
	XREF	_allocated__MEM
	XREF	_totSize__MEM
	XREF	_nextFree__MEM
	XREF	_cnt__MEM
	XREF	_sineData__QTRIG
	XREF	_gradData__QTRIG

	SECTION ":0",CODE


;int main()
	XDEF	main_
main_
L133	EQU	-$84
	link	a5,#L133
	move.l	a2,-(a7)
	fmovem.x fp2,-(a7)
L112
;	if (xBASELIB::Init()!=OK)
	jsr	Init__xBASELIB_
	tst.l	d0
	beq.b	L116
L113
;	
;		cout << "xBASE library initialisation failed\n";
	move.l	#L106,-(a7)
	move.l	_cout,a0
	cmp.w	#0,a0
	beq.b	L115
L114
	addq.w	#4,a0
L115
	move.l	a0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	moveq	#$A,d0
	fmovem.x (a7)+,fp2
	move.l	(a7)+,a2
	unlk	a5
	rts
L116
;	cout << "Hello World\n";
	move.l	#L107,-(a7)
	move.l	_cout,a0
	cmp.w	#0,a0
	beq.b	L118
L117
	addq.w	#4,a0
L118
	move.l	a0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	TRANSFORM test;
	lea	-$68(a5),a0
	clr.l	$64(a0)
	move.l	a0,$60(a0)
	move.l	a0,a1
	move.l	$60(a1),a0
	move.l	#$3F800000,d0
	move.l	d0,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	d0,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	move.l	d0,(a0)+
	clr.l	(a0)
	move.l	#2,$64(a1)
	lea	-$68(a5),a1
	move.l	a1,-(a1)
	move.l	#_0dt__TRANSFORM__T,-(a1)
	XREF	sym_handlers
	move.l	sym_handlers,-(a1)
	move.l	a1,sym_handlers
;	test.Translate(-0.5, -0.5, 0);
	clr.l	-(a7)
	move.l	#$BF000000,-(a7)
	move.l	#$BF000000,-(a7)
	pea	-$68(a5)
	jsr	Translate__TRANSFORM__Tfff
	add.w	#$10,a7
;	test.Rotate(90,0,0);
	clr.l	-(a7)
	clr.l	-(a7)
	move.l	#$42B40000,-(a7)
	pea	-$68(a5)
	jsr	Rotate__TRANSFORM__Tfff
	add.w	#$10,a7
;	test.Scale(100,100,1);
	move.l	#$3F800000,-(a7)
	move.l	#$42C80000,-(a7)
	move.l	#$42C80000,-(a7)
	pea	-$68(a5)
	jsr	Scale__TRANSFORM__Tfff
	add.w	#$10,a7
;	test.Translate(50,50, 0);
	clr.l	-(a7)
	move.l	#$42480000,-(a7)
	move.l	#$42480000,-(a7)
	pea	-$68(a5)
	jsr	Translate__TRANSFORM__Tfff
	add.w	#$10,a7
;	VEC3D point1(0.5,0.5,0.6);
	lea	-$80(a5),a0
	move.l	#$3F000000,(a0)
	move.l	#$3F000000,4(a0)
	move.l	#$3F19999A,$8(a0)
;	cout << "point1.x = " << point1.x << "\n";
	move.l	#L108,-(a7)
	move.l	-$80(a5),-(a7)
	move.l	#L109,-(a7)
	move.l	_cout,a0
	cmp.w	#0,a0
	beq.b	L120
L119
	addq.w	#4,a0
L120
	move.l	a0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	cout << "point1.y = " << point1.y << "\n";
	move.l	#L108,-(a7)
	move.l	-$7C(a5),-(a7)
	move.l	#L110,-(a7)
	move.l	_cout,a0
	cmp.w	#0,a0
	beq.b	L122
L121
	addq.w	#4,a0
L122
	move.l	a0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	cout << "point1.z = " << point1.z << "\n";
	move.l	#L108,-(a7)
	move.l	-$78(a5),-(a7)
	move.l	#L111,-(a7)
	move.l	_cout,a0
	cmp.w	#0,a0
	beq.b	L124
L123
	addq.w	#4,a0
L124
	move.l	a0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	point1*=test;
	pea	-$68(a5)
	pea	-$80(a5)
	jsr	op__multAsgn__VEC3D__TRC09TRANSFORM
	addq.w	#$8,a7
;	cout.setf(ios::fixed);
	move.l	#$1000,d1
	move.l	_cout,a0
	cmp.w	#0,a0
	beq.b	L126
L125
	move.l	(a0),a0
L126
	or.l	d1,$12(a0)
;	cout << "point1.x = " << point1.x << "\n";
	move.l	#L108,-(a7)
	move.l	-$80(a5),-(a7)
	move.l	#L109,-(a7)
	move.l	_cout,a0
	cmp.w	#0,a0
	beq.b	L128
L127
	addq.w	#4,a0
L128
	move.l	a0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	cout << "point1.y = " << point1.y << "\n";
	move.l	#L108,-(a7)
	move.l	-$7C(a5),-(a7)
	move.l	#L110,-(a7)
	move.l	_cout,a0
	cmp.w	#0,a0
	beq.b	L130
L129
	addq.w	#4,a0
L130
	move.l	a0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	cout << "point1.z = " << point1.z << "\n";
	move.l	#L108,-(a7)
	move.l	-$78(a5),-(a7)
	move.l	#L111,-(a7)
	move.l	_cout,a0
	cmp.w	#0,a0
	beq.b	L132
L131
	addq.w	#4,a0
L132
	move.l	a0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	xBASELIB::Done();
	jsr	Done__xBASELIB_
	lea	-$74(a5),a0
	XREF	lib_destruct_a0
	jsr	lib_destruct_a0
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	move.l	(a7)+,a2
	unlk	a5
	rts

	XDEF	_0dt__TRANSFORM__T
_0dt__TRANSFORM__T
L134
	rts

L108
	dc.b	$A,0
L107
	dc.b	'Hello World',$A,0
L109
	dc.b	'point1.x = ',0
L110
	dc.b	'point1.y = ',0
L111
	dc.b	'point1.z = ',0
L106
	dc.b	'xBASE library initialisation failed',$A,0

	END
