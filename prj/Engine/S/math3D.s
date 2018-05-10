
; Storm C Compiler
; Mendoza:Extropia/eXtropia/prj/Engine/math3D.cpp
	mc68030
	mc68881
	XREF	_fabs__r
	XREF	_sqrt__r
	XREF	_acos__r
	XREF	_cos__r
	XREF	_sin__r
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

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "op__multAsgn__TRANSFORM__TRC09TRANSFORM:0",CODE


;TRANSFORM& TRANSFORM::operator*=(const TRANSFORM& t)
	XDEF	op__multAsgn__TRANSFORM__TRC09TRANSFORM
op__multAsgn__TRANSFORM__TRC09TRANSFORM
	movem.l	a2/a3,-(a7)
	fmovem.x fp2/fp3/fp4/fp5,-(a7)
	move.l	$40(a7),a0
	move.l	$3C(a7),a3
L4
;	rfloat32* d = matrix;
	move.l	$60(a3),a1
;	rfloat32* s = t.matrix;
	move.l	$60(a0),a0
;		rfloat32 t1 = d[M_11];
	fmove.s	(a1),fp0
; rfloat32 t2 = d[M_12];
	fmove.s	4(a1),fp2
; rfloat32 t3 = d[M_13];
	fmove.s	$8(a1),fp1
;		d[M_11]  = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a1)
;		d[M_12]  = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,4(a1)
;		d[M_13]  = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$8(a1)
;		d[M_14] += t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	lea	$C(a1),a2
	fmove.s	(a2),fp1
	fadd.x	fp0,fp1
	fmove.s	fp1,(a2)
;		t1 = d[M_21];
	fmove.s	$10(a1),fp0
;	t2 = d[M_22];
	fmove.s	$14(a1),fp2
;	t3 = d[M_23];
	fmove.s	$18(a1),fp1
;		d[M_21]  = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$10(a1)
;		d[M_22]  = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$14(a1)
;		d[M_23]  = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$18(a1)
;		d[M_24] += t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	lea	$1C(a1),a2
	fmove.s	(a2),fp1
	fadd.x	fp0,fp1
	fmove.s	fp1,(a2)
;		t1 = d[M_31];
	fmove.s	$20(a1),fp0
;	t2 = d[M_32];
	fmove.s	$24(a1),fp2
; t3 = d[M_33];
	fmove.s	$28(a1),fp1
;		d[M_31]  = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$20(a1)
;		d[M_32]  = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$24(a1)
;		d[M_33]  = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$28(a1)
;		d[M_34] += t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	lea	$2C(a1),a0
	fmove.s	(a0),fp1
	fadd.x	fp0,fp1
	fmove.s	fp1,(a0)
;	return *this;
	move.l	a3,d0
	fmovem.x (a7)+,fp2/fp3/fp4/fp5
	movem.l	(a7)+,a2/a3
	rts

	SECTION "Rotate__TRANSFORM__Tfff:0",CODE


;void TRANSFORM::Rotate(float32 x, float32 y, float32 z)
	XDEF	Rotate__TRANSFORM__Tfff
Rotate__TRANSFORM__Tfff
L6	EQU	-$1C
	link	a5,#L6
	movem.l	a2/a3,-(a7)
	fmovem.x fp2/fp3/fp4/fp5/fp6/fp7,-(a7)
	move.l	$8(a5),a3
	fmove.s	$C(a5),fp2
	fmove.s	$14(a5),fp6
	fmove.s	$10(a5),fp7
L5
;	rfloat32 *d = Secondary();
	move.l	a3,a0
	move.l	$60(a0),d0
	sub.l	a0,d0
	moveq	#2,d1
	asr.l	d1,d0
	moveq	#$C,d1
	sub.l	d0,d1
	move.l	d1,d0
	lea	0(a0,d0.l*4),a2
;		float32 Sx = sin(x);
	fmove.x	fp2,fp0
	fmove.d	fp0,-(a7)
	jsr	_sin__r
	addq.w	#$8,a7
	fmove.x	fp0,fp3
;	float32 Sy = sin(y);
	fmove.x	fp7,fp0
	fmove.d	fp0,-(a7)
	jsr	_sin__r
	addq.w	#$8,a7
	fmove.x	fp0,fp5
;	float32 Sz = sin(z);
	fmove.x	fp6,fp0
	fmove.d	fp0,-(a7)
	jsr	_sin__r
	addq.w	#$8,a7
	fmove.x	fp0,fp4
;		float32 Cx = cos(x);
	fmove.x	fp2,fp0
	fmove.d	fp0,-(a7)
	jsr	_cos__r
	addq.w	#$8,a7
	fmove.x	fp0,fp2
;	float32 Cy = cos(y);
	fmove.x	fp7,fp0
	fmove.d	fp0,-(a7)
	jsr	_cos__r
	addq.w	#$8,a7
	fmove.s	fp0,-$14(a5)
;	float32 Cz = cos(z);
	fmove.x	fp6,fp0
	fmove.d	fp0,-(a7)
	jsr	_cos__r
	addq.w	#$8,a7
;		d[M_11] = Cy*Cz;
	fmove.s	-$14(a5),fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a2)
;		d[M_12] = -(Cy*Sz);
	fmove.s	-$14(a5),fp1
	fmul.x	fp4,fp1
	fneg.s	fp1
	fmove.s	fp1,4(a2)
;		d[M_13] = Sy;
	fmove.s	fp5,$8(a2)
;		d[M_21] = Sx*Sy*Cz + Cx*Sz;
	fmove.x	fp3,fp1
	fmul.x	fp5,fp1
	fmul.x	fp0,fp1
	fmove.x	fp2,fp6
	fmul.x	fp4,fp6
	fadd.x	fp6,fp1
	fmove.s	fp1,$10(a2)
;		d[M_22]	= Cx*Cz - (Sx*Sy*Sz);
	fmove.x	fp2,fp1
	fmul.x	fp0,fp1
	fmove.x	fp3,fp6
	fmul.x	fp5,fp6
	fmul.x	fp4,fp6
	fsub.x	fp6,fp1
	fmove.s	fp1,$14(a2)
;		d[M_23] = Sx*Cy;
	fmove.x	fp3,fp1
	fmul.s	-$14(a5),fp1
	fmove.s	fp1,$18(a2)
;		d[M_31] = -(Cx*Sy*Cz + Sx*Sz);
	fmove.x	fp2,fp1
	fmul.x	fp5,fp1
	fmul.x	fp0,fp1
	fmove.x	fp3,fp6
	fmul.x	fp4,fp6
	fadd.x	fp6,fp1
	fneg.s	fp1
	fmove.s	fp1,$20(a2)
;		d[M_32] = Cx*Sy*Sz - (Sx*Cz);
	fmove.x	fp2,fp1
	fmul.x	fp5,fp1
	fmul.x	fp4,fp1
	fmul.x	fp0,fp3
	fsub.x	fp3,fp1
	fmove.s	fp1,$24(a2)
;		d[M_33] = Cx*Cy;
	fmul.s	-$14(a5),fp2
	fmove.s	fp2,$28(a2)
;		rfloat32 *s = matrix;
	move.l	a3,a1
	move.l	$60(a1),a0
;		rfloat32 t1 = d[M_11];
	fmove.s	(a2),fp0
; rfloat32 t2 = d[M_12];
	fmove.s	4(a2),fp2
; rfloat32 t3 = d[M_13];
	fmove.s	$8(a2),fp1
;		d[M_11] = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,(a2)
;		d[M_12] = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,4(a2)
;		d[M_13] = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$8(a2)
;		d[M_14] = t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	fmove.s	fp0,$C(a2)
;		t1 = d[M_21];
	fmove.s	$10(a2),fp0
;	t2 = d[M_22];
	fmove.s	$14(a2),fp2
;	t3 = d[M_23];
	fmove.s	$18(a2),fp1
;		d[M_21] = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$10(a2)
;		d[M_22] = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$14(a2)
;		d[M_23] = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$18(a2)
;		d[M_24] = t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	fmove.s	fp0,$1C(a2)
;		t1 = d[M_31];
	fmove.s	$20(a2),fp0
;	t2 = d[M_32];
	fmove.s	$24(a2),fp2
;	t3 = d[M_33];
	fmove.s	$28(a2),fp1
;		d[M_31] = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
	fmove.s	(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$10(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$20(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$20(a2)
;		d[M_32] = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
	fmove.s	4(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$14(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$24(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$24(a2)
;		d[M_33] = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
	fmove.s	$8(a0),fp3
	fmul.x	fp0,fp3
	fmove.s	$18(a0),fp4
	fmul.x	fp2,fp4
	fadd.x	fp4,fp3
	fmove.s	$28(a0),fp4
	fmul.x	fp1,fp4
	fadd.x	fp4,fp3
	fmove.s	fp3,$28(a2)
;		d[M_34] = t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
	fmul.s	$C(a0),fp0
	fmul.s	$1C(a0),fp2
	fadd.x	fp2,fp0
	fmul.s	$2C(a0),fp1
	fadd.x	fp1,fp0
	fmove.s	fp0,$2C(a2)
;	matrix = d;
	move.l	a3,a0
	move.l	a2,$60(a0)
	fmovem.x (a7)+,fp2/fp3/fp4/fp5/fp6/fp7
	movem.l	(a7)+,a2/a3
	unlk	a5
	rts

	SECTION "Transform__TRANSFORM__TP05VEC3DUi:0",CODE


;void TRANSFORM::Transform(VEC3D* v, size_t n)
	XDEF	Transform__TRANSFORM__TP05VEC3DUi
Transform__TRANSFORM__TP05VEC3DUi
	movem.l	a2/a3,-(a7)
	fmovem.x fp2/fp3/fp4/fp5,-(a7)
	move.l	$44(a7),d0
	move.l	$40(a7),a0
	move.l	$3C(a7),a3
L7
;	register float32* p=&(v->x);
	move.l	a0,a1
;	n++;
	addq.l	#1,d0
;	while(--n)
	bra	L9
L8
;		rfloat32 *m = matrix;
	move.l	$60(a3),a0
;		rfloat32 tx = p[0];
	fmove.s	(a1),fp4
;		rfloat32 ty = p[1];
	fmove.s	4(a1),fp3
;		rfloat32 tz = p[2];
	fmove.s	$8(a1),fp2
;		*p++ = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
	fmove.s	(a0)+,fp0
	fmul.x	fp4,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp3,fp1
	fadd.x	fp1,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp2,fp1
	fadd.x	fp1,fp0
	fadd.s	(a0)+,fp0
	fmove.s	fp0,(a1)+
;		*p++ = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
	fmove.s	(a0)+,fp0
	fmul.x	fp4,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp3,fp1
	fadd.x	fp1,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp2,fp1
	fadd.x	fp1,fp0
	fadd.s	(a0)+,fp0
	fmove.s	fp0,(a1)+
;		*p++ = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
	fmove.s	(a0)+,fp0
	fmul.x	fp4,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp3,fp1
	fadd.x	fp1,fp0
	fmove.s	(a0)+,fp1
	fmul.x	fp2,fp1
	fadd.x	fp1,fp0
	fadd.s	(a0),fp0
	fmove.s	fp0,(a1)+
L9
	subq.l	#1,d0
	tst.l	d0
	bne	L8
L10
	fmovem.x (a7)+,fp2/fp3/fp4/fp5
	movem.l	(a7)+,a2/a3
	rts

	END
