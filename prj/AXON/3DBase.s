
; Storm C Compiler
; Mendoza:Extropia/eXtropia/prj/AXON/3DBase.cpp
	mc68030
	mc68881
	XREF	_sqrt__r
	XREF	_0dt__sysRTLIB__T
	XREF	MessageBox__sysBASELIB__PcPcPce
	XREF	_system
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
	XREF	_memset
	XREF	_memmove
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
	XREF	_errBuff__xBASELIB
	XREF	_errSev__xBASELIB
	XREF	_errTbl__xBASELIB
	XREF	_SysBase
	XREF	_IntuitionBase
	XREF	_DOSBase
	XREF	_sysData__sysBASELIB
	XREF	_msgbuff__sysBASELIB
	XREF	_main__sysBASELIB
	XREF	_allocated__MEM
	XREF	_totSize__MEM
	XREF	_nextFree__MEM
	XREF	_cnt__MEM
	XREF	_maxAllocs__MEM

	SECTION ":0",CODE


;VEC3D& VEC3D::operator*=(const TRANSFORM& t)
	XDEF	op__multAsgn__VEC3D__TRC09TRANSFORM
op__multAsgn__VEC3D__TRC09TRANSFORM
	move.l	a2,-(a7)
	fmovem.x fp2/fp3/fp4/fp5,-(a7)
	move.l	$3C(a7),a0
	move.l	$38(a7),a1
L124
;	rfloat32*m = t.matrix;
	move.l	$60(a0),a0
;	rfloat32 tx = x;
	fmove.s	(a1),fp4
;	rfloat32 ty = y;
	fmove.s	4(a1),fp3
;	rfloat32 tz = z;
	fmove.s	$8(a1),fp2
;	x = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
	fmove.s	(a0)+,fp0
	fmul.x	fp4,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp3,fp1
	fadd.x	fp1,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp2,fp1
	fadd.x	fp1,fp0
	fadd.s	(a0)+,fp0
	fmove.s	fp0,(a1)
;	y = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
	fmove.s	(a0)+,fp0
	fmul.x	fp4,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp3,fp1
	fadd.x	fp1,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp2,fp1
	fadd.x	fp1,fp0
	fadd.s	(a0)+,fp0
	fmove.s	fp0,4(a1)
;	z = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m);
	fmove.s	(a0)+,fp0
	fmul.x	fp4,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp3,fp1
	fadd.x	fp1,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp2,fp1
	fadd.x	fp1,fp0
	fadd.s	(a0),fp0
	fmove.s	fp0,$8(a1)
	move.l	a1,d0
	fmovem.x (a7)+,fp2/fp3/fp4/fp5
	move.l	(a7)+,a2
	rts

;sint32 PLANE::Define(VEC3D* p1, VEC3D* p2, VEC3D* p3)
	XDEF	Define__PLANE__TP05VEC3DP05VEC3DP05VEC3D
Define__PLANE__TP05VEC3DP05VEC3DP05VEC3D
L126	EQU	-$94
	link	a5,#L126
	movem.l	a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4,-(a7)
	move.l	$C(a5),a0
	move.l	$8(a5),a1
	move.l	$14(a5),a2
L125
;	flags = SOURCE_V3D;
	move.l	#1,(a1)
;	i = p1;
	move.l	a0,4(a1)
;	j = p2;
	move.l	$10(a5),$8(a1)
;	k = p3;
	move.l	a2,$C(a1)
;	VEC3D v = (*p2)-(*p3);
	lea	-$C(a5),a3
	move.l	a3,-$64(a5)
	lea	-$58(a5),a3
	move.l	a3,-$68(a5)
	move.l	$10(a5),-$6C(a5)
	lea	-$7C(a5),a3
	move.l	a3,a6
	move.l	-$6C(a5),-$60(a5)
	move.l	-$60(a5),a3
	fmove.s	(a3),fp0
	move.l	a6,a3
	fmove.s	fp0,(a3)
	move.l	-$60(a5),a3
	fmove.s	4(a3),fp0
	move.l	a6,a3
	fmove.s	fp0,4(a3)
	move.l	-$60(a5),a3
	fmove.s	$8(a3),fp0
	move.l	a6,a3
	fmove.s	fp0,$8(a3)
	lea	-$7C(a5),a3
	move.l	a3,a6
	move.l	a6,a3
	fmove.s	(a3),fp0
	fsub.s	(a2),fp0
	move.l	a6,a3
	fmove.s	fp0,(a3)
	move.l	a6,a3
	fmove.s	4(a3),fp0
	fsub.s	4(a2),fp0
	move.l	a6,a3
	fmove.s	fp0,4(a3)
	move.l	a6,a3
	fmove.s	$8(a3),fp0
	fsub.s	$8(a2),fp0
	move.l	a6,a3
	fmove.s	fp0,$8(a3)
	move.l	a6,a3
	fmove.s	(a3),fp0
	move.l	-$68(a5),a3
	fmove.s	fp0,(a3)
	move.l	a6,a3
	fmove.s	4(a3),fp0
	move.l	-$68(a5),a3
	fmove.s	fp0,4(a3)
	move.l	a6,a3
	fmove.s	$8(a3),fp0
	move.l	-$68(a5),a3
	fmove.s	fp0,$8(a3)
	lea	-$58(a5),a3
	move.l	a3,a6
	move.l	a6,a3
	fmove.s	(a3),fp0
	move.l	-$64(a5),a3
	fmove.s	fp0,(a3)
	move.l	a6,a3
	fmove.s	4(a3),fp0
	move.l	-$64(a5),a3
	fmove.s	fp0,4(a3)
	move.l	a6,a3
	fmove.s	$8(a3),fp0
	move.l	-$64(a5),a3
	fmove.s	fp0,$8(a3)
;	
;		rfloat32 D0 = p1->x*v.y - p1->y*v.x + p2->x*p3->y - p3->x*p2->y;
	fmove.s	(a0),fp1
	fmul.s	-$8(a5),fp1
	fmove.s	4(a0),fp0
	fmul.s	-$C(a5),fp0
	fsub.x	fp0,fp1
	move.l	$10(a5),a3
	fmove.s	(a3),fp0
	fmul.s	4(a2),fp0
	fadd.x	fp0,fp1
	move.l	$10(a5),a3
	fmove.s	(a2),fp0
	fmul.s	4(a3),fp0
	fsub.x	fp0,fp1
;		a = (p3->y*p2->z + p1->z*v.y - p1->y*v.z - p2->y*p3->z)/D0;
	move.l	$10(a5),a3
	fmove.s	4(a2),fp0
	fmul.s	$8(a3),fp0
	fmove.s	$8(a0),fp2
	fmul.s	-$8(a5),fp2
	fadd.x	fp2,fp0
	fmove.s	4(a0),fp2
	fmul.s	-4(a5),fp2
	fsub.x	fp2,fp0
	move.l	$10(a5),a3
	fmove.s	4(a3),fp2
	fmul.s	$8(a2),fp2
	fsub.x	fp2,fp0
	fdiv.x	fp1,fp0
	fmove.s	fp0,$1C(a1)
;		b = (p1->x*v.z - p3->x*p2->z + p2->x*p3->z - p1->z*v.x)/D0;
	fmove.s	(a0),fp0
	fmul.s	-4(a5),fp0
	fmove.s	(a2),fp2
	move.l	$10(a5),a3
	fmul.s	$8(a3),fp2
	fsub.x	fp2,fp0
	move.l	$10(a5),a3
	fmove.s	(a3),fp2
	fmul.s	$8(a2),fp2
	fadd.x	fp2,fp0
	fmove.s	$8(a0),fp2
	fmul.s	-$C(a5),fp2
	fsub.x	fp2,fp0
	fdiv.x	fp1,fp0
	fmove.s	fp0,$20(a1)
;		c = p1->z - a*p1->x - b*p1->y;
	fmove.s	$1C(a1),fp1
	fmul.s	(a0),fp1
	fmove.s	$8(a0),fp0
	fsub.x	fp1,fp0
	fmove.s	$20(a1),fp1
	fmul.s	4(a0),fp1
	fsub.x	fp1,fp0
	fmove.s	fp0,$24(a1)
;	normal = v*((*p1)-(*p3));
	lea	-$24(a5),a3
	move.l	a3,a6
	lea	-$18(a5),a3
	move.l	a2,-$70(a5)
	move.l	a0,a2
	lea	-$88(a5),a0
	move.l	(a2),(a0)
	move.l	4(a2),4(a0)
	move.l	$8(a2),$8(a0)
	move.l	-$70(a5),a2
	lea	-$88(a5),a0
	fmove.s	(a0),fp0
	fsub.s	(a2),fp0
	fmove.s	fp0,(a0)
	fmove.s	4(a0),fp0
	fsub.s	4(a2),fp0
	fmove.s	fp0,4(a0)
	fmove.s	$8(a0),fp0
	fsub.s	$8(a2),fp0
	fmove.s	fp0,$8(a0)
	fmove.s	(a0),fp0
	move.l	a3,a2
	fmove.s	fp0,(a2)
	move.l	a3,a2
	move.l	4(a0),4(a2)
	fmove.s	$8(a0),fp0
	move.l	a3,a0
	fmove.s	fp0,$8(a0)
	lea	-$18(a5),a0
	move.l	a0,a3
	lea	-$C(a5),a2
	lea	-$94(a5),a0
	move.l	(a2),(a0)
	move.l	4(a2),4(a0)
	move.l	$8(a2),$8(a0)
	move.l	a3,a2
	lea	-$94(a5),a0
	fmove.s	(a0),fp0
	fmove.s	4(a0),fp1
	fmul.s	$8(a2),fp1
	fmove.s	4(a2),fp2
	fmul.s	$8(a0),fp2
	fsub.x	fp2,fp1
	fmove.s	fp1,(a0)
	fmove.s	4(a0),fp3
	fmove.s	(a2),fp1
	fmul.s	$8(a0),fp1
	fmove.s	$8(a2),fp2
	fmul.x	fp0,fp2
	fsub.x	fp2,fp1
	fmove.s	fp1,4(a0)
	fmul.s	4(a2),fp0
	fmove.s	(a2),fp1
	fmul.x	fp3,fp1
	fsub.x	fp1,fp0
	fmove.s	fp0,$8(a0)
	fmove.s	(a0),fp0
	move.l	a6,a2
	fmove.s	fp0,(a2)
	move.l	a6,a2
	move.l	4(a0),4(a2)
	fmove.s	$8(a0),fp0
	move.l	a6,a0
	fmove.s	fp0,$8(a0)
	lea	-$24(a5),a2
	lea	$10(a1),a0
	move.l	(a2),(a0)
	move.l	4(a2),4(a0)
	move.l	$8(a2),$8(a0)
;	normal.Normalize();
	lea	$10(a1),a2
	move.l	a2,a0
	move.l	a0,a2
	fmove.s	(a0),fp0
	fmul.s	(a0),fp0
	fmove.s	4(a0),fp1
	fmul.s	4(a0),fp1
	fadd.x	fp1,fp0
	fmove.s	$8(a0),fp1
	fmul.s	$8(a0),fp1
	fadd.x	fp1,fp0
	fmove.d	fp0,-(a7)
	jsr	_sqrt__r
	addq.w	#$8,a7
	move.l	a2,a0
	fmove.s	(a0),fp1
	fdiv.x	fp0,fp1
	fmove.s	fp1,(a0)
	fmove.s	4(a0),fp1
	fdiv.x	fp0,fp1
	fmove.s	fp1,4(a0)
	fmove.s	$8(a0),fp1
	fdiv.x	fp0,fp1
	fmove.s	fp1,$8(a0)
	moveq	#0,d0
	fmovem.x (a7)+,fp2/fp3/fp4
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts

;sint32 PLANE::Define(C3D* p1, C3D* p2, C3D* p3)
	XDEF	Define__PLANE__TP03C3DP03C3DP03C3D
Define__PLANE__TP03C3DP03C3DP03C3D
L128	EQU	-$A0
	link	a5,#L128
	movem.l	a2/a3/a6,-(a7)
	fmovem.x fp2/fp3/fp4,-(a7)
	move.l	$C(a5),a0
	move.l	$8(a5),a1
	move.l	$14(a5),a2
L127
;	flags = SOURCE_C3D;
	move.l	#2,(a1)
;	i = p1;
	move.l	a0,4(a1)
;	j = p2;
	move.l	$10(a5),$8(a1)
;	k = p3;
	move.l	a2,$C(a1)
;	VEC3D v = ((VEC3D)*p2)-((VEC3D)*p3);
	lea	-$C(a5),a3
	move.l	a3,-$70(a5)
	lea	-$60(a5),a3
	move.l	a3,-$74(a5)
	move.l	$10(a5),-$78(a5)
	lea	-$88(a5),a3
	move.l	a3,a6
	move.l	-$78(a5),-$6C(a5)
	move.l	-$6C(a5),a3
	fmove.s	(a3),fp0
	move.l	a6,a3
	fmove.s	fp0,(a3)
	move.l	-$6C(a5),a3
	fmove.s	4(a3),fp0
	move.l	a6,a3
	fmove.s	fp0,4(a3)
	move.l	-$6C(a5),a3
	fmove.s	$8(a3),fp0
	move.l	a6,a3
	fmove.s	fp0,$8(a3)
	lea	-$88(a5),a3
	move.l	a3,a6
	move.l	a6,a3
	fmove.s	(a3),fp0
	fsub.s	(a2),fp0
	move.l	a6,a3
	fmove.s	fp0,(a3)
	move.l	a6,a3
	fmove.s	4(a3),fp0
	fsub.s	4(a2),fp0
	move.l	a6,a3
	fmove.s	fp0,4(a3)
	move.l	a6,a3
	fmove.s	$8(a3),fp0
	fsub.s	$8(a2),fp0
	move.l	a6,a3
	fmove.s	fp0,$8(a3)
	move.l	a6,a3
	fmove.s	(a3),fp0
	move.l	-$74(a5),a3
	fmove.s	fp0,(a3)
	move.l	a6,a3
	fmove.s	4(a3),fp0
	move.l	-$74(a5),a3
	fmove.s	fp0,4(a3)
	move.l	a6,a3
	fmove.s	$8(a3),fp0
	move.l	-$74(a5),a3
	fmove.s	fp0,$8(a3)
	lea	-$60(a5),a3
	move.l	a3,a6
	move.l	a6,a3
	fmove.s	(a3),fp0
	move.l	-$70(a5),a3
	fmove.s	fp0,(a3)
	move.l	a6,a3
	fmove.s	4(a3),fp0
	move.l	-$70(a5),a3
	fmove.s	fp0,4(a3)
	move.l	a6,a3
	fmove.s	$8(a3),fp0
	move.l	-$70(a5),a3
	fmove.s	fp0,$8(a3)
;	
;		rfloat32 D0 = p1->x*v.y - p1->y*v.x + p2->x*p3->y - p3->x*p2->y;
	fmove.s	(a0),fp1
	fmul.s	-$8(a5),fp1
	fmove.s	4(a0),fp0
	fmul.s	-$C(a5),fp0
	fsub.x	fp0,fp1
	move.l	$10(a5),a3
	fmove.s	(a3),fp0
	fmul.s	4(a2),fp0
	fadd.x	fp0,fp1
	move.l	$10(a5),a3
	fmove.s	(a2),fp0
	fmul.s	4(a3),fp0
	fsub.x	fp0,fp1
;		a = (p3->y*p2->z + p1->z*v.y - p1->y*v.z - p2->y*p3->z)/D0;
	move.l	$10(a5),a3
	fmove.s	4(a2),fp0
	fmul.s	$8(a3),fp0
	fmove.s	$8(a0),fp2
	fmul.s	-$8(a5),fp2
	fadd.x	fp2,fp0
	fmove.s	4(a0),fp2
	fmul.s	-4(a5),fp2
	fsub.x	fp2,fp0
	move.l	$10(a5),a3
	fmove.s	4(a3),fp2
	fmul.s	$8(a2),fp2
	fsub.x	fp2,fp0
	fdiv.x	fp1,fp0
	fmove.s	fp0,$1C(a1)
;		b = (p1->x*v.z - p3->x*p2->z + p2->x*p3->z - p1->z*v.x)/D0;
	fmove.s	(a0),fp0
	fmul.s	-4(a5),fp0
	fmove.s	(a2),fp2
	move.l	$10(a5),a3
	fmul.s	$8(a3),fp2
	fsub.x	fp2,fp0
	move.l	$10(a5),a3
	fmove.s	(a3),fp2
	fmul.s	$8(a2),fp2
	fadd.x	fp2,fp0
	fmove.s	$8(a0),fp2
	fmul.s	-$C(a5),fp2
	fsub.x	fp2,fp0
	fdiv.x	fp1,fp0
	fmove.s	fp0,$20(a1)
;		c = p1->z - a*p1->x - b*p1->y;
	fmove.s	$1C(a1),fp1
	fmul.s	(a0),fp1
	fmove.s	$8(a0),fp0
	fsub.x	fp1,fp0
	fmove.s	$20(a1),fp1
	fmul.s	4(a0),fp1
	fsub.x	fp1,fp0
	fmove.s	fp0,$24(a1)
;	normal = v*((VEC3D)(*p1)-(VEC3D)(*p3));
	lea	-$28(a5),a3
	move.l	a3,a6
	lea	-$1C(a5),a3
	move.l	a2,-$7C(a5)
	move.l	a0,a2
	lea	-$94(a5),a0
	move.l	(a2),(a0)
	move.l	4(a2),4(a0)
	move.l	$8(a2),$8(a0)
	move.l	-$7C(a5),a2
	lea	-$94(a5),a0
	fmove.s	(a0),fp0
	fsub.s	(a2),fp0
	fmove.s	fp0,(a0)
	fmove.s	4(a0),fp0
	fsub.s	4(a2),fp0
	fmove.s	fp0,4(a0)
	fmove.s	$8(a0),fp0
	fsub.s	$8(a2),fp0
	fmove.s	fp0,$8(a0)
	fmove.s	(a0),fp0
	move.l	a3,a2
	fmove.s	fp0,(a2)
	move.l	a3,a2
	move.l	4(a0),4(a2)
	fmove.s	$8(a0),fp0
	move.l	a3,a0
	fmove.s	fp0,$8(a0)
	lea	-$1C(a5),a0
	move.l	a0,a3
	lea	-$C(a5),a2
	lea	-$A0(a5),a0
	move.l	(a2),(a0)
	move.l	4(a2),4(a0)
	move.l	$8(a2),$8(a0)
	move.l	a3,a2
	lea	-$A0(a5),a0
	fmove.s	(a0),fp0
	fmove.s	4(a0),fp1
	fmul.s	$8(a2),fp1
	fmove.s	4(a2),fp2
	fmul.s	$8(a0),fp2
	fsub.x	fp2,fp1
	fmove.s	fp1,(a0)
	fmove.s	4(a0),fp3
	fmove.s	(a2),fp1
	fmul.s	$8(a0),fp1
	fmove.s	$8(a2),fp2
	fmul.x	fp0,fp2
	fsub.x	fp2,fp1
	fmove.s	fp1,4(a0)
	fmul.s	4(a2),fp0
	fmove.s	(a2),fp1
	fmul.x	fp3,fp1
	fsub.x	fp1,fp0
	fmove.s	fp0,$8(a0)
	fmove.s	(a0),fp0
	move.l	a6,a2
	fmove.s	fp0,(a2)
	move.l	a6,a2
	move.l	4(a0),4(a2)
	fmove.s	$8(a0),fp0
	move.l	a6,a0
	fmove.s	fp0,$8(a0)
	lea	-$28(a5),a2
	lea	$10(a1),a0
	move.l	(a2),(a0)
	move.l	4(a2),4(a0)
	move.l	$8(a2),$8(a0)
;	normal.Normalize();
	lea	$10(a1),a2
	move.l	a2,a0
	move.l	a0,a2
	fmove.s	(a0),fp0
	fmul.s	(a0),fp0
	fmove.s	4(a0),fp1
	fmul.s	4(a0),fp1
	fadd.x	fp1,fp0
	fmove.s	$8(a0),fp1
	fmul.s	$8(a0),fp1
	fadd.x	fp1,fp0
	fmove.d	fp0,-(a7)
	jsr	_sqrt__r
	addq.w	#$8,a7
	move.l	a2,a0
	fmove.s	(a0),fp1
	fdiv.x	fp0,fp1
	fmove.s	fp1,(a0)
	fmove.s	4(a0),fp1
	fdiv.x	fp0,fp1
	fmove.s	fp1,4(a0)
	fmove.s	$8(a0),fp1
	fdiv.x	fp0,fp1
	fmove.s	fp1,$8(a0)
	moveq	#0,d0
	fmovem.x (a7)+,fp2/fp3/fp4
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts

;void TRANSFORM::Scale(float32 s)
	XDEF	Scale__TRANSFORM__Tf
Scale__TRANSFORM__Tf
	move.l	a2,-(a7)
	fmovem.x fp2,-(a7)
	move.l	$14(a7),a1
	fmove.s	$18(a7),fp0
L129
;	rfloat32* m = matrix;
	move.l	$60(a1),a0
;	*(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
; *(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
; *(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
; *(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
;	*(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
; *(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
; *(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
; *(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
;	*(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
; *(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
; *(m++) *= s;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
; *m *= s;
	fmove.s	(a0),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a0)
;	flags &= ~IDENTITY;
	and.l	#-3,$64(a1)
;	flags |= SCALED;
	or.l	#4,$64(a1)
	fmovem.x (a7)+,fp2
	move.l	(a7)+,a2
	rts

;void TRANSFORM::Scale(float32 sx, float32 sy, float32 sz)
	XDEF	Scale__TRANSFORM__Tfff
Scale__TRANSFORM__Tfff
	move.l	a2,-(a7)
	fmovem.x fp2/fp3/fp4,-(a7)
	move.l	$2C(a7),a1
	fmove.s	$38(a7),fp1
	fmove.s	$34(a7),fp2
	fmove.s	$30(a7),fp3
L130
;	rfloat32* m = matrix;
	move.l	$60(a1),a0
;	*(m++) *= sx;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp3,fp0
	fmove.s	fp0,(a2)
; *(m++) *= sx;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp3,fp0
	fmove.s	fp0,(a2)
; *(m++) *= sx;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp3,fp0
	fmove.s	fp0,(a2)
; *(m++) *= sx;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp3,fp0
	fmove.s	fp0,(a2)
;	*(m++) *= sy;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,(a2)
; *(m++) *= sy;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,(a2)
; *(m++) *= sy;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,(a2)
; *(m++) *= sy;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,(a2)
;	*(m++) *= sz;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp1,fp0
	fmove.s	fp0,(a2)
; *(m++) *= sz;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp1,fp0
	fmove.s	fp0,(a2)
; *(m++) *= sz;
	move.l	a0,a2
	addq.w	#4,a0
	fmove.s	(a2),fp0
	fmul.x	fp1,fp0
	fmove.s	fp0,(a2)
; *m *= sz;
	fmove.s	(a0),fp0
	fmul.x	fp1,fp0
	fmove.s	fp0,(a0)
;	flags &= ~IDENTITY;
	and.l	#-3,$64(a1)
;	flags |= SCALED;
	or.l	#4,$64(a1)
	fmovem.x (a7)+,fp2/fp3/fp4
	move.l	(a7)+,a2
	rts

;void TRANSFORM::Scale(const VEC3D& s)
	XDEF	Scale__TRANSFORM__TRC05VEC3D
Scale__TRANSFORM__TRC05VEC3D
	movem.l	a2/a3,-(a7)
	move.l	$10(a7),a1
	move.l	$C(a7),a2
L131
;	rfloat32* m = matrix;
	move.l	$60(a2),a0
;	*(m++) *= s.x;
	fmove.s	(a1),fp1
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.x	fp1,fp0
	fmove.s	fp0,(a3)
; *(m++) *= s.x;
	fmove.s	(a1),fp1
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.x	fp1,fp0
	fmove.s	fp0,(a3)
; *(m++) *= s.x;
	fmove.s	(a1),fp1
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.x	fp1,fp0
	fmove.s	fp0,(a3)
; *(m++) *= s.x;
	fmove.s	(a1),fp1
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.x	fp1,fp0
	fmove.s	fp0,(a3)
;	*(m++) *= s.y;
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.s	4(a1),fp0
	fmove.s	fp0,(a3)
; *(m++) *= s.y;
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.s	4(a1),fp0
	fmove.s	fp0,(a3)
; *(m++) *= s.y;
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.s	4(a1),fp0
	fmove.s	fp0,(a3)
; *(m++) *= s.y;
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.s	4(a1),fp0
	fmove.s	fp0,(a3)
;	*(m++) *= s.z;
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.s	$8(a1),fp0
	fmove.s	fp0,(a3)
; *(m++) *= s.z;
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.s	$8(a1),fp0
	fmove.s	fp0,(a3)
; *(m++) *= s.z;
	move.l	a0,a3
	addq.w	#4,a0
	fmove.s	(a3),fp0
	fmul.s	$8(a1),fp0
	fmove.s	fp0,(a3)
; *m *= s.z;
	fmove.s	(a0),fp0
	fmul.s	$8(a1),fp0
	fmove.s	fp0,(a0)
;	flags &= ~IDENTITY;
	and.l	#-3,$64(a2)
;	flags |= SCALED;
	or.l	#4,$64(a2)
	movem.l	(a7)+,a2/a3
	rts

;void TRANSFORM::Translate(const VEC3D& p)
	XDEF	Translate__TRANSFORM__TRC05VEC3D
Translate__TRANSFORM__TRC05VEC3D
	move.l	a2,-(a7)
	movem.l	$8(a7),a0/a2
L132
;	matrix[3]+=p.x;
	move.l	$60(a0),a1
	add.w	#$C,a1
	fmove.s	(a1),fp0
	fadd.s	(a2),fp0
	fmove.s	fp0,(a1)
;	matrix[7]+=p.y;
	move.l	$60(a0),a1
	add.w	#$1C,a1
	fmove.s	(a1),fp0
	fadd.s	4(a2),fp0
	fmove.s	fp0,(a1)
;	matrix[11]+=p.z;
	move.l	$60(a0),a1
	add.w	#$2C,a1
	fmove.s	(a1),fp0
	fadd.s	$8(a2),fp0
	fmove.s	fp0,(a1)
;	flags &= ~IDENTITY;
	and.l	#-3,$64(a0)
;	flags |= TRANSLATED;
	or.l	#$8,$64(a0)
	move.l	(a7)+,a2
	rts

;void TRANSFORM::Translate(float32 tx, float32 ty, float32 tz)
	XDEF	Translate__TRANSFORM__Tfff
Translate__TRANSFORM__Tfff
	fmovem.x fp2/fp3,-(a7)
	move.l	$1C(a7),a0
	fmove.s	$28(a7),fp1
	fmove.s	$24(a7),fp2
	fmove.s	$20(a7),fp3
L133
;	rfloat32* m = matrix;
;	matrix[3]+=tx;
	move.l	$60(a0),a1
	add.w	#$C,a1
	fmove.s	(a1),fp0
	fadd.x	fp3,fp0
	fmove.s	fp0,(a1)
;	matrix[7]+=ty;
	move.l	$60(a0),a1
	add.w	#$1C,a1
	fmove.s	(a1),fp0
	fadd.x	fp2,fp0
	fmove.s	fp0,(a1)
;	matrix[11]+=tz;
	move.l	$60(a0),a1
	add.w	#$2C,a1
	fmove.s	(a1),fp0
	fadd.x	fp1,fp0
	fmove.s	fp0,(a1)
;	flags &= ~IDENTITY;
	and.l	#-3,$64(a0)
;	flags |= TRANSLATED;
	or.l	#$8,$64(a0)
	fmovem.x (a7)+,fp2/fp3
	rts

;void TRANSFORM::Rotate(float32 rx, float32 ry, float32 rz)
	XDEF	Rotate__TRANSFORM__Tfff
Rotate__TRANSFORM__Tfff
L252	EQU	-$28
	link	a5,#L252
	movem.l	d2/a2-a4,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	$8(a5),a3
	fmove.s	$C(a5),fp3
	fmove.s	$10(a5),fp6
	fmove.s	$14(a5),fp7
L134
;	
;		float32 f0 = QTRIG::SinF(rx);
	fmove.x	fp3,fp2
	fmove.l	fp2,d1
	fmove.l	d1,fp0
	fsub.x	fp0,fp2
	fmove.s	#$.3F800000,fp1
	fsub.x	fp2,fp1
	move.l	d1,d0
	cmp.l	#$5A,d0
	bhs.b	L136
L135
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra.b	L143
L136
	cmp.l	#$B4,d0
	bhs.b	L138
L137
	move.l	#$B4,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra.b	L143
L138
	cmp.l	#$10E,d0
	bhs.b	L140
L139
	sub.l	#$B4,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L143
L140
	cmp.l	#$168,d0
	bhs.b	L142
L141
	move.l	#$168,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L143
L142
	sub.l	#$168,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
L143
	fmul.x	fp0,fp1
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$5A,d0
	bhs.b	L145
L144
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra	L152
L145
	cmp.l	#$B4,d0
	bhs.b	L147
L146
	move.l	#$B4,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra.b	L152
L147
	cmp.l	#$10E,d0
	bhs.b	L149
L148
	sub.l	#$B4,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L152
L149
	cmp.l	#$168,d0
	bhs.b	L151
L150
	move.l	#$168,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L152
L151
	sub.l	#$168,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
L152
	fmul.x	fp0,fp2
	fadd.x	fp2,fp1
;	float32 f1 = QTRIG::SinF(ry);
	fmove.x	fp6,fp2
	fmove.l	fp2,d1
	fmove.l	d1,fp0
	fsub.x	fp0,fp2
	fmove.s	#$.3F800000,fp5
	fsub.x	fp2,fp5
	move.l	d1,d0
	cmp.l	#$5A,d0
	bhs.b	L154
L153
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra	L161
L154
	cmp.l	#$B4,d0
	bhs.b	L156
L155
	move.l	#$B4,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra.b	L161
L156
	cmp.l	#$10E,d0
	bhs.b	L158
L157
	sub.l	#$B4,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L161
L158
	cmp.l	#$168,d0
	bhs.b	L160
L159
	move.l	#$168,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L161
L160
	sub.l	#$168,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
L161
	fmul.x	fp0,fp5
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$5A,d0
	bhs.b	L163
L162
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra	L170
L163
	cmp.l	#$B4,d0
	bhs.b	L165
L164
	move.l	#$B4,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra.b	L170
L165
	cmp.l	#$10E,d0
	bhs.b	L167
L166
	sub.l	#$B4,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L170
L167
	cmp.l	#$168,d0
	bhs.b	L169
L168
	move.l	#$168,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L170
L169
	sub.l	#$168,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
L170
	fmul.x	fp0,fp2
	fadd.x	fp2,fp5
;	float32 f2 = QTRIG::SinF(rz);
	fmove.x	fp7,fp2
	fmove.l	fp2,d1
	fmove.l	d1,fp0
	fsub.x	fp0,fp2
	fmove.s	#$.3F800000,fp4
	fsub.x	fp2,fp4
	move.l	d1,d0
	cmp.l	#$5A,d0
	bhs.b	L172
L171
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra	L179
L172
	cmp.l	#$B4,d0
	bhs.b	L174
L173
	move.l	#$B4,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra.b	L179
L174
	cmp.l	#$10E,d0
	bhs.b	L176
L175
	sub.l	#$B4,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L179
L176
	cmp.l	#$168,d0
	bhs.b	L178
L177
	move.l	#$168,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L179
L178
	sub.l	#$168,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
L179
	fmul.x	fp0,fp4
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$5A,d0
	bhs.b	L181
L180
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra	L188
L181
	cmp.l	#$B4,d0
	bhs.b	L183
L182
	move.l	#$B4,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	bra	L188
L183
	cmp.l	#$10E,d0
	bhs.b	L185
L184
	sub.l	#$B4,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L188
L185
	cmp.l	#$168,d0
	bhs.b	L187
L186
	move.l	#$168,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
	fneg.s	fp0
	bra.b	L188
L187
	sub.l	#$168,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp0
L188
	fmul.x	fp0,fp2
	fadd.x	fp2,fp4
;		float32 f3 = QTRIG::CosF(rx);
	fmove.l	fp3,d1
	fmove.l	d1,fp0
	fsub.x	fp0,fp3
	fmove.s	#$.3F800000,fp0
	fsub.x	fp3,fp0
	move.l	d1,d0
	cmp.l	#$5A,d0
	bhs.b	L190
L189
	moveq	#$5A,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L197
L190
	cmp.l	#$B4,d0
	bhs.b	L192
L191
	sub.l	#$5A,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L197
L192
	cmp.l	#$10E,d0
	bhs.b	L194
L193
	move.l	#$10E,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L197
L194
	cmp.l	#$168,d0
	bhs.b	L196
L195
	sub.l	#$10E,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra.b	L197
L196
	move.l	#$1C2,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
L197
	fmul.x	fp2,fp0
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$5A,d0
	bhs.b	L199
L198
	moveq	#$5A,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L206
L199
	cmp.l	#$B4,d0
	bhs.b	L201
L200
	sub.l	#$5A,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L206
L201
	cmp.l	#$10E,d0
	bhs	L203
L202
	move.l	#$10E,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L206
L203
	cmp.l	#$168,d0
	bhs.b	L205
L204
	sub.l	#$10E,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra.b	L206
L205
	move.l	#$1C2,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
L206
	fmul.x	fp2,fp3
	fadd.x	fp3,fp0
;	float32 f4 = QTRIG::CosF(ry);
	fmove.x	fp6,fp3
	fmove.l	fp3,d1
	fmove.l	d1,fp2
	fsub.x	fp2,fp3
	fmove.s	#$.3F800000,fp2
	fsub.x	fp3,fp2
	fmove.s	fp2,-$14(a5)
	move.l	d1,d0
	cmp.l	#$5A,d0
	bhs	L208
L207
	moveq	#$5A,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L215
L208
	cmp.l	#$B4,d0
	bhs	L210
L209
	sub.l	#$5A,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L215
L210
	cmp.l	#$10E,d0
	bhs	L212
L211
	move.l	#$10E,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L215
L212
	cmp.l	#$168,d0
	bhs	L214
L213
	sub.l	#$10E,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L215
L214
	move.l	#$1C2,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
L215
	fmove.s	-$14(a5),fp6
	fmul.x	fp2,fp6
	fmove.s	fp6,-$14(a5)
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$5A,d0
	bhs	L217
L216
	moveq	#$5A,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L224
L217
	cmp.l	#$B4,d0
	bhs	L219
L218
	sub.l	#$5A,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L224
L219
	cmp.l	#$10E,d0
	bhs	L221
L220
	move.l	#$10E,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L224
L221
	cmp.l	#$168,d0
	bhs	L223
L222
	sub.l	#$10E,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L224
L223
	move.l	#$1C2,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
L224
	fmul.x	fp2,fp3
	fmove.s	-$14(a5),fp2
	fadd.x	fp3,fp2
	fmove.s	fp2,-$14(a5)
;	float32 f5 = QTRIG::CosF(rz);
	fmove.x	fp7,fp6
	fmove.x	fp6,fp2
	fmove.l	fp2,d1
	fmove.l	d1,fp2
	fmove.x	fp6,fp3
	fsub.x	fp2,fp3
	fmove.x	fp3,fp6
	fmove.s	#$.3F800000,fp3
	fsub.x	fp6,fp3
	move.l	d1,d0
	cmp.l	#$5A,d0
	bhs	L226
L225
	moveq	#$5A,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L233
L226
	cmp.l	#$B4,d0
	bhs	L228
L227
	sub.l	#$5A,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L233
L228
	cmp.l	#$10E,d0
	bhs	L230
L229
	move.l	#$10E,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L233
L230
	cmp.l	#$168,d0
	bhs	L232
L231
	sub.l	#$10E,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L233
L232
	move.l	#$1C2,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
L233
	fmul.x	fp2,fp3
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$5A,d0
	bhs	L235
L234
	moveq	#$5A,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L242
L235
	cmp.l	#$B4,d0
	bhs	L237
L236
	sub.l	#$5A,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L242
L237
	cmp.l	#$10E,d0
	bhs	L239
L238
	move.l	#$10E,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	fneg.s	fp2
	bra	L242
L239
	cmp.l	#$168,d0
	bhs	L241
L240
	sub.l	#$10E,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
	bra	L242
L241
	move.l	#$1C2,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	#_sineData__QTRIG,a1
	fmove.s	0(a1,d0.l*4),fp2
L242
	fmul.x	fp2,fp6
	fadd.x	fp6,fp3
;		rfloat32* m = Temp();
	move.l	a3,a0
	move.l	$64(a0),d0
	and.l	#1,d0
	beq.b	L244
L243
	bra.b	L245
L244
	add.w	#$30,a0
L245
;		*(m++) = f4*f5;
	fmove.s	-$14(a5),fp2
	fmul.x	fp3,fp2
	fmove.s	fp2,(a0)+
;									*(m++) = -(f4*f2);
	fmove.s	-$14(a5),fp2
	fmul.x	fp4,fp2
	fneg.s	fp2
	fmove.s	fp2,(a0)+
;						*(m++) = f1;
	fmove.s	fp5,(a0)+
;		m++;
	addq.w	#4,a0
;		*(m++) = f0*f1*f5 + f3*f2;
	fmove.x	fp1,fp2
	fmul.x	fp5,fp2
	fmul.x	fp3,fp2
	fmove.x	fp0,fp6
	fmul.x	fp4,fp6
	fadd.x	fp6,fp2
	fmove.s	fp2,(a0)+
;			*(m++) = f3*f5 - (f0*f1*f2);
	fmove.x	fp0,fp2
	fmul.x	fp3,fp2
	fmove.x	fp1,fp6
	fmul.x	fp5,fp6
	fmul.x	fp4,fp6
	fsub.x	fp6,fp2
	fmove.s	fp2,(a0)+
;	*(m++) = f0*f4;
	fmove.x	fp1,fp2
	fmul.s	-$14(a5),fp2
	fmove.s	fp2,(a0)+
;	m++;
	addq.w	#4,a0
;		*(m++) = -(f3*f1*f5 + f0*f2);
	fmove.x	fp0,fp2
	fmul.x	fp5,fp2
	fmul.x	fp3,fp2
	fmove.x	fp1,fp6
	fmul.x	fp4,fp6
	fadd.x	fp6,fp2
	fneg.s	fp2
	fmove.s	fp2,(a0)+
;		*(m++) = f3*f1*f2 - (f0*f5);
	fmove.x	fp0,fp2
	fmul.x	fp5,fp2
	fmul.x	fp4,fp2
	fmul.x	fp3,fp1
	fsub.x	fp1,fp2
	fmove.s	fp2,(a0)+
;	*(m++) = f3*f4;
	fmul.s	-$14(a5),fp0
	fmove.s	fp0,(a0)
;	
;		rfloat32* d = Temp();
	move.l	a3,a0
	move.l	$64(a0),d0
	and.l	#1,d0
	beq.b	L247
L246
	move.l	a0,a1
	bra.b	L248
L247
	lea	$30(a0),a1
L248
;		rfloat32* s1 = d;
	move.l	a1,a2
;		rfloat32* s2 = matrix;
	move.l	$60(a3),a0
;		
;			rfloat32 t1 = *(s1++);
	fmove.s	(a2)+,fp0
;			rfloat32 t2 = *(s1++);
	fmove.s	(a2)+,fp2
;			rfloat32 t3 = *(s1++);
	fmove.s	(a2)+,fp1
;			s1++;
	addq.w	#4,a2
;			*(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	moveq	#$10,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	moveq	#$20,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
	moveq	#4,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp3
	fmul.x	fp0,fp3
	moveq	#$14,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	moveq	#$24,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
	moveq	#$8,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp3
	fmul.x	fp0,fp3
	moveq	#$18,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	moveq	#$28,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
	moveq	#$C,d0
	add.l	a0,d0
	move.l	d0,a4
	fmul.s	(a4),fp0
	moveq	#$1C,d0
	add.l	a0,d0
	move.l	d0,a4
	fmul.s	(a4),fp2
	fadd.x	fp2,fp0
	moveq	#$2C,d0
	add.l	a0,d0
	move.l	d0,a4
	fmul.s	(a4),fp1
	fadd.x	fp1,fp0
	fmove.s	fp0,(a1)+
;		
;			rfloat32 t1 = *(s1++);
	fmove.s	(a2)+,fp0
;			rfloat32 t2 = *(s1++);
	fmove.s	(a2)+,fp2
;			rfloat32 t3 = *(s1++);
	fmove.s	(a2)+,fp1
;			s1++;
	addq.w	#4,a2
;			*(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	moveq	#$10,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	moveq	#$20,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
	moveq	#4,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp3
	fmul.x	fp0,fp3
	moveq	#$14,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	moveq	#$24,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
	moveq	#$8,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp3
	fmul.x	fp0,fp3
	moveq	#$18,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	moveq	#$28,d0
	add.l	a0,d0
	move.l	d0,a4
	fmove.s	(a4),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
	moveq	#$C,d0
	add.l	a0,d0
	move.l	d0,a4
	fmul.s	(a4),fp0
	moveq	#$1C,d0
	add.l	a0,d0
	move.l	d0,a4
	fmul.s	(a4),fp2
	fadd.x	fp2,fp0
	moveq	#$2C,d0
	add.l	a0,d0
	move.l	d0,a4
	fmul.s	(a4),fp1
	fadd.x	fp1,fp0
	fmove.s	fp0,(a1)+
;		
;			rfloat32 t1 = *(s1++);
	fmove.s	(a2)+,fp0
;			rfloat32 t2 = *(s1++);
	fmove.s	(a2)+,fp2
;			rfloat32 t3 = *(s1++);
	fmove.s	(a2),fp1
;			*(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	fmove.s	fp0,(a1)
;	Swap();
	move.l	a3,a0
	move.l	$64(a0),d0
	and.l	#1,d0
	beq.b	L250
L249
	move.l	a0,$60(a0)
	and.l	#-2,$64(a0)
	bra.b	L251
L250
	lea	$30(a0),a1
	move.l	a1,$60(a0)
	or.l	#1,$64(a0)
L251
;	flags |= ROTATED;
	or.l	#$10,$64(a3)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,d2/a2-a4
	unlk	a5
	rts

;TRANSFORM& TRANSFORM::operator*=(const TRANSFORM& t)
	XDEF	op__multAsgn__TRANSFORM__TRC09TRANSFORM
op__multAsgn__TRANSFORM__TRC09TRANSFORM
	movem.l	a2-a4,-(a7)
	fmovem.x fp2/fp3/fp4/fp5,-(a7)
	move.l	$44(a7),a0
	move.l	$40(a7),a4
L253
;	rfloat32* d  = matrix;
	move.l	a4,a2
	move.l	$60(a2),a1
;	rfloat32* s1 = d;
	move.l	a1,a2
;	rfloat32* s2 = t.matrix;
	move.l	$60(a0),a0
;	
;			rfloat32 t1 = *(s1++);
	fmove.s	(a2)+,fp0
;			rfloat32 t2 = *(s1++);
	fmove.s	(a2)+,fp2
;			rfloat32 t3 = *(s1++);
	fmove.s	(a2)+,fp1
;			s1++;
	addq.w	#4,a2
;			*(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	move.l	a1,a3
	addq.w	#4,a1
	fmove.s	(a3),fp1
	fadd.x	fp0,fp1
	fmove.s	fp1,(a3)
;	
;			rfloat32 t1 = *(s1++);
	fmove.s	(a2)+,fp0
;			rfloat32 t2 = *(s1++);
	fmove.s	(a2)+,fp2
;			rfloat32 t3 = *(s1++);
	fmove.s	(a2)+,fp1
;			s1++;
	addq.w	#4,a2
;			*(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	move.l	a1,a3
	addq.w	#4,a1
	fmove.s	(a3),fp1
	fadd.x	fp0,fp1
	fmove.s	fp1,(a3)
;	
;			rfloat32 t1 = *(s1++);
	fmove.s	(a2)+,fp0
;			rfloat32 t2 = *(s1++);
	fmove.s	(a2)+,fp2
;			rfloat32 t3 = *(s1++);
	fmove.s	(a2),fp1
;			*(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)+
;			*(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	fmove.s	(a1),fp1
	fadd.x	fp0,fp1
	fmove.s	fp1,(a1)
	move.l	a4,d0
	fmovem.x (a7)+,fp2/fp3/fp4/fp5
	movem.l	(a7)+,a2-a4
	rts

;void TRANSFORM::Transform(VEC3D* s, uint32 n)
	XDEF	Transform__TRANSFORM__TP05VEC3DUj
Transform__TRANSFORM__TP05VEC3DUj
	move.l	$C(a7),d0
L254
;	n++;
	addq.l	#1,d0
;	while(--n)
L255
	subq.l	#1,d0
	tst.l	d0
	bne.b	L255
L256
;	
	rts

;void TRANSFORM::Transform(C3D* s, uint32 n)
	XDEF	Transform__TRANSFORM__TP03C3DUj
Transform__TRANSFORM__TP03C3DUj
	move.l	$C(a7),d0
L257
;	n++;
	addq.l	#1,d0
;	while(--n)
L258
	subq.l	#1,d0
	tst.l	d0
	bne.b	L258
L259
;	
	rts

;void TRANSFORM::Transform(sysVERTEX* s, uint32 n)
	XDEF	Transform__TRANSFORM__TP10W3D_VertexUj
Transform__TRANSFORM__TP10W3D_VertexUj
	move.l	$C(a7),d0
L260
;	n++;
	addq.l	#1,d0
;	while(--n)
L261
	subq.l	#1,d0
	tst.l	d0
	bne.b	L261
L262
;	
	rts

;void TRANSFORM::Transform(VEC3D* s, VEC3D* d, uint32 n)
	XDEF	Transform__TRANSFORM__TP05VEC3DP05VEC3DUj
Transform__TRANSFORM__TP05VEC3DP05VEC3DUj
	move.l	$10(a7),d0
L263
;	n++;
	addq.l	#1,d0
;	while(--n)
L264
	subq.l	#1,d0
	tst.l	d0
	bne.b	L264
L265
;	
	rts

;void TRANSFORM::Transform(VEC3D* s, C3D* d, uint32 n)
	XDEF	Transform__TRANSFORM__TP05VEC3DP03C3DUj
Transform__TRANSFORM__TP05VEC3DP03C3DUj
	move.l	$10(a7),d0
L266
;	n++;
	addq.l	#1,d0
;	while(--n)
L267
	subq.l	#1,d0
	tst.l	d0
	bne.b	L267
L268
;	
	rts

;void TRANSFORM::Transform(C3D* s, C3D* d, uint32 n)
	XDEF	Transform__TRANSFORM__TP03C3DP03C3DUj
Transform__TRANSFORM__TP03C3DP03C3DUj
	move.l	$10(a7),d0
L269
;	n++;
	addq.l	#1,d0
;	while(--n)
L270
	subq.l	#1,d0
	tst.l	d0
	bne.b	L270
L271
;	
	rts

;void TRANSFORM::Transform(C3D* s, sysVERTEX* d, uint32 n)
	XDEF	Transform__TRANSFORM__TP03C3DP10W3D_VertexUj
Transform__TRANSFORM__TP03C3DP10W3D_VertexUj
	move.l	$10(a7),d0
L272
;	n++;
	addq.l	#1,d0
;	while(--n)
L273
	subq.l	#1,d0
	tst.l	d0
	bne.b	L273
L274
;	
	rts

;void TRANSFORM::Transform(sysVERTEX* s, sysVERTEX* d, uint32 n)
	XDEF	Transform__TRANSFORM__TP10W3D_VertexP10W3D_VertexUj
Transform__TRANSFORM__TP10W3D_VertexP10W3D_VertexUj
	move.l	$10(a7),d0
L275
;	n++;
	addq.l	#1,d0
;	while(--n)
L276
	subq.l	#1,d0
	tst.l	d0
	bne.b	L276
L277
;	
	rts

;void TRANSFORM::Dump(ostream& out)
	XDEF	Dump__TRANSFORM__TR07ostream
Dump__TRANSFORM__TR07ostream
	movem.l	a2/a3,-(a7)
	movem.l	$C(a7),a2/a3
L283
;	out.precision(6);
	moveq	#6,d0
	move.l	a3,a0
	cmp.w	#0,a0
	beq.b	L285
L284
	move.l	(a0),a0
L285
	move.w	d0,$C(a0)
;	out.setf(ios::fixed);
	move.l	#$1000,d1
	move.l	a3,a0
	cmp.w	#0,a0
	beq.b	L287
L286
	move.l	(a0),a0
L287
	or.l	d1,$12(a0)
;	out << "\nTRANSFORM Matrix\n";
	move.l	#L278,-(a7)
	move.l	a3,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	out << "|\t" << matrix[0] << "\t" << matrix[1] << "\t" << matrix[2
	move.l	#L279,-(a7)
	move.l	$60(a2),a0
	move.l	$C(a0),-(a7)
	move.l	#L280,-(a7)
	move.l	$60(a2),a0
	move.l	$8(a0),-(a7)
	move.l	#L280,-(a7)
	move.l	$60(a2),a0
	move.l	4(a0),-(a7)
	move.l	#L280,-(a7)
	move.l	$60(a2),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-(a7)
	move.l	#L281,-(a7)
	move.l	a3,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	out << "|\t" << matrix[4] << "\t" << matrix[5] << "\t" << matrix[6
	move.l	#L279,-(a7)
	move.l	$60(a2),a0
	move.l	$1C(a0),-(a7)
	move.l	#L280,-(a7)
	move.l	$60(a2),a0
	move.l	$18(a0),-(a7)
	move.l	#L280,-(a7)
	move.l	$60(a2),a0
	move.l	$14(a0),-(a7)
	move.l	#L280,-(a7)
	move.l	$60(a2),a0
	move.l	$10(a0),-(a7)
	move.l	#L281,-(a7)
	move.l	a3,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	out << "|\t" << matrix[8] << "\t" << matrix[9] << "\t" << matrix[1
	move.l	#L279,-(a7)
	move.l	$60(a2),a0
	move.l	$2C(a0),-(a7)
	move.l	#L280,-(a7)
	move.l	$60(a2),a0
	move.l	$28(a0),-(a7)
	move.l	#L280,-(a7)
	move.l	$60(a2),a0
	move.l	$24(a0),-(a7)
	move.l	#L280,-(a7)
	move.l	$60(a2),a0
	move.l	$20(a0),-(a7)
	move.l	#L281,-(a7)
	move.l	a3,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	out << "|\t" << 0F << "\t" << 0F << "\t" << 0F << "\t" << 1F << "\
	move.l	#L282,-(a7)
	move.l	#$3F800000,-(a7)
	move.l	#L280,-(a7)
	clr.l	-(a7)
	move.l	#L280,-(a7)
	clr.l	-(a7)
	move.l	#L280,-(a7)
	clr.l	-(a7)
	move.l	#L281,-(a7)
	move.l	a3,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__Tf
	addq.w	#$8,a7
	move.l	d0,-(a7)
	jsr	op__leftshift__ostream__TPCc
	addq.w	#$8,a7
;	out.unsetf(ios::fixed);
	move.l	#$1000,d1
	move.l	a3,a0
	cmp.w	#0,a0
	beq.b	L289
L288
	move.l	(a0),a0
L289
	not.l	d1
	and.l	d1,$12(a0)
;	out.setf(ios::scientific);
	move.l	#$800,d1
	move.l	a3,a0
	cmp.w	#0,a0
	beq	L291
L290
	move.l	(a0),a0
L291
	or.l	d1,$12(a0)
	movem.l	(a7)+,a2/a3
	rts

L280
	dc.b	$9,0
L279
	dc.b	$9,'|',$A,0
L282
	dc.b	$9,'|',$A,$A,0
L278
	dc.b	$A,'TRANSFORM Matrix',$A,0
L281
	dc.b	'|',$9,0

	SECTION ":1",DATA

	XDEF	_sineData__QTRIG
_sineData__QTRIG
	dc.l	0,$3C8EF856,$3D0EF2C6,$3D565E46,$3D8EDC7E,$3DB27EB0,$3DD612C7,$3DF99675,$3E0E835E,$3E20303C,$3E31D0C8
	dc.l	$3E43636F,$3E54E6E2,$3E66598D,$3E77BA67,$3E8483ED,$3E8D204C,$3E95B1C8,$3E9E377B,$3EA6B0D9,$3EAF1D3F,$3EB77C02
	dc.l	$3EBFCC7E,$3EC80DE6,$3ED03FD6,$3ED86164,$3EE0722A,$3EE87160,$3EF05EA3,$3EF83906,$3F000000,$3F03D987,$3F07A8C5
	dc.l	$3F0B6D76,$3F0F2746,$3F12D5E1,$3F167914,$3F1A108D,$3F1D9BF6,$3F211B1E,$3F248DC1,$3F27F37C,$3F2B4C2C,$3F2E976B
	dc.l	$3F31D51B,$3F3504F7,$3F3826AA,$3F3B3A03,$3F3E3EC1,$3F4134AD,$3F441B75,$3F46F30A,$3F49BB17,$3F4C7368,$3F4F1BBD
	dc.l	$3F51B3F3,$3F543BD5,$3F56B324,$3F5919AD,$3F5B6F4C,$3F5DB3D1,$3F5FE719,$3F6208E0,$3F641908,$3F66175D,$3F6803CD
	dc.l	$3F69DE17,$3F6BA638,$3F6D5BEF,$3F6EFF1A,$3F708FB8,$3F720D8A,$3F737879,$3F74D068,$3F761545,$3F7746EE,$3F786552
	dc.l	$3F797050,$3F7A67E9,$3F7B4BE8,$3F7C1C61,$3F7CD91E,$3F7D8234,$3F7E177F,$3F7E9900,$3F7F06A3,$3F7F605B,$3F7FA637
	dc.l	$3F7FD817,$3F7FF60A,$3F800000
	XDEF	_gradData__QTRIG
_gradData__QTRIG
	dc.l	0,$3C8EFDFF,$3D0F091D,$3D56A98F,$3D8F35C7,$3DB32D46,$3DD740C5,$3DFB76B3,$3E0FE9FA,$3E222F6B,$3E348F11
	dc.l	$3E470B8D,$3E59A88B,$3E6C68AA,$3E7F4FD8,$3E89309C,$3E92D03E,$3E9C88C7,$3EA65BEB,$3EB04BC2,$3EBA5A47,$3EC489D2
	dc.l	$3ECEDC7F,$3ED954CB,$3EE3F50E,$3EEEBFEC,$3EF9B825,$3F02703C,$3F081E14,$3F0DE732,$3F13CD36,$3F19D208,$3F1FF76B
	dc.l	$3F263F9B,$3F2CACA0,$3F3340D4,$3F39FEB8,$3F40E8EB,$3F48025B,$3F4F4E01,$3F56CF42,$3F5E8997,$3F6680E1,$3F6EB94E
	dc.l	$3F773765,$3F800000,$3F848C3F,$3F89436C,$3F8E2878,$3F933F53,$3F988B44,$3F9E1134,$3FA3D514,$3FA9DC72,$3FB02D39
	dc.l	$3FB6CD9E,$3FBDC486,$3FC51A21,$3FCCD79E,$3FD50720,$3FDDB3D0,$3FE6EB1B,$3FF0BBC3,$3FFB36CE,$4003381D,$40093FA6
	dc.l	$400FBF1F,$4016C63F,$401E67E0,$4026B9CB,$402FD6B7,$4039DE94,$4044F8B6,$4051559B,$405F31BA,$406ED9E9,$40805850
	dc.l	$408A9B7D,$40968C54,$40A4A028,$40B57B20,$40CA0A3E,$40E3B11D,$41024F42,$41183AD2,$4136E1B0,$4164CFAB,$4198A617
	dc.l	$41E516F1,$426528DC,$447A0000

	END
