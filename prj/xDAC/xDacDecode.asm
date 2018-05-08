;//****************************************************************************//
;//** File:         prj/xDAC/xDacDecode.asm ($NAME=xDacDecode.asm)           **//
;//** Description:  Decoding methods for xDAC stream, hand optimised         **//
;//** Comment(s):                                                            **//
;//** Created:      2002-01-20                                               **//
;//** Updated:      2002-02-24                                               **//
;//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
;//** Note(s):      Generated from prj/xDAC/xDacDecode.cpp and fine tuned    **//
;//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
;//**               Serkan YAZICI, Karl Churchill                            **//
;//**               All Rights Reserved.                                     **//
;//****************************************************************************//

;// StormC settings : optimisation 6, large code/large data model

	mc68040

	XREF	Zero__MEM__PvUi

	SECTION "_0ct__streampos__T:0",CODE
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//  General notes
;//
;//  a0 - a1   : gen purpose pointers (volatile)
;//  a2 - a4   : gen purpose pointers (must be preserved on func exit)
;//  a5        : local stack pointer
;//  a6        : gen purpose pointer  (must be preserved on func exit)
;//  a7        : user stack pointer / supervisor stack pointer
;//
;//  d0 - d1   : gen purpose data (volatile)
;//  d2 - d7   : gen purpose data (must be preserved on func exit)
;//
;//  fp0 - fp1 : gen purpose floats (volatile)
;//  fp1 - fp7 : gen purpose floats (must be preserved on fun exit)
;//
;//  Karls notes
;//
;//  Hand code is implemented using VLRISC68K compatible addressing modes. Floating
;//  point operations are not used.
;//
;//  Addressing modes used and approx C pointer equivalent, n = reg num(0-7)
;//
;//  (An)       ==> *p            680x0
;//  -(An)      ==> *(--p)        680x0
;//	 (An)+      ==> *(p++)        680x0
;//  d(An)      ==> *(p+d)        680x0
;//  d(An,Dn)   ==> *(p+d+Dn)     680x0   : Dn may be word/long
;//  d(An,Dn*s) ==> *(p+d+(Dn*s)) 68020+  : Dn may be word/long, s = 1,2,4
;//
;//  For -(An)/(An)+, the step size is that of the element moved (byte/word/long)
;//  All other modes are byte addressable
;//
;////////////////////////////////////////////////////////////////////////////////


;////////////////////////////////////////////////////////////////////////////////
;//
;//  sint32 XDAC::DecodeMergedStereo(sint16* dest, sint32 num)
;//
;//  Uses 1 32-bit register for both L and R. Writes are 32 bits
;//
;//  Only the outer frame counter is on the stack, will try to improve this
;//
;//  d0 : shifted / scratch
;//  d1 : packed / scratch
;//  d2 : sample pair
;//  d3 : frame header / scratch
;//  d4 : sample counter
;//  d5 : bitRate
;//  d6 : mask
;//  d7 : shiftMx
;//
;//  a0 : qTable
;//  a2 : s (stream)
;//  a3 : d (destination)
;//  a5 : local stack
;//  a6 : this
;//  a7 : master stack pointer
;//
;////////////////////////////////////////////////////////////////////////////////

	SECTION "DecodeMergedStereo__XDAC__TPsj:0",CODE
	XDEF	DecodeMergedStereo__XDAC__TPsj

DecodeMergedStereo__XDAC__TPsj
L125	EQU	-$24
	link	a5,#L125
	movem.l	d2-d7/a2/a3/a6,-(a7)

	move.l	$8(a5),a6 ;// put "this" into a6 for faster dereferencing of members


L114
;//	rsint16*	d = dest;
;//	ruint16*	s = current;
	move.l	$C(a5),a3
	move.l	$34(a6),a2

;//	rsint32		n = num+1;
	move.l	$10(a5),d0
	addq.l	#1,d0
	move.l	d0,-4(a5)

;//	while(--n)
	bra	L123

L115
;//	ruint16 c = *s++	-> d3
	move.w	(a2)+,d3

;//	if (XDAC_SILENCE(c))
	move.w	d3,d0
	and.w	#$8000,d0
	beq.b	L117

L116
;//	ruint16 f = XDAC_SLNC_LEN(c);
	and.w	#$FFF,d3

;//	rsint32 len = (shared.frameLen*f)<<1;
	move.w	$24(a6),d2
	mulu	d3,d2

;//	MEM::Zero(d,(len<<1)) - stack args
	lsl.l	#2,d2
	move.l d2, -(a7) ;// len
	move.l a3, -(a7) ;// d
	jsr	Zero__MEM__PvUi
	addq.w	#$8,a7

;//	d += len;
	lsr.l	#1,d2
	add.l	d2,a3; // add to d pointer

;//	n -= (f-1);
	addq.w	#1, d3
	ext.l	d3
	sub.l	d3,-4(a5)
	bra	L123

L117
;//	rsint16 bitRate = XDAC_BITRATE(c) -> d5
;//	ruint16 mask    = (1<<bitRate)-1 -> d6
;//	rsint16 shiftMx = ((8*sizeof(sint16))/bitRate) -> d7
;//	rsint16 shifted = shiftMx ->d1
	move.w	d3,d5
	and.w	#$300,d5
	lsr.w	#8,d5
	addq.w	#2,d5

	moveq	#1,d6
	lsl.l	d5,d6
	subq.l	#1,d6

	moveq	#$10,d7
	divu	d5,d7

	move.w	d7,d1

;// Get the start sample pair -> d2
;//	68k big endian so, L in msw, R in lsw after 32-bit move
;// sample1 = *s++, sample2 = *s++
	move.l	(a2)+, d2

;//	rsint16* qTable = (sint16*)s;
	move.l	a2,a0

;//	s += XDAC_TABLESIZE(c)
	moveq	#0,d0
	move.w	d3,d0
	and.w	#$1F,d0
	lea		2(a2,d0.l*2),a2;

;// ruint16 packed = *s++ -> d0
	move.w	(a2)+,d0

;//	rsint16	i = shared.frameLen -> d4
	move.w	$24(a6),d4

;//	while(--i)
	bra.b	L122

L118
;//	sample += qTable[(packed & mask)];

;// write 1st pair of samples, initially these will be the start samples
	move.l	d2,   (a3)+

;// This approach limits us to 2 swaps per loop, but means that we are a sample
;// pair short when the inner loop exits, so we must remember to write them
;// after the inner loop

;// swap channels in d2 -> L in lsw, R in msw
;// packed in d0, shifted in d1, bitrate in d5, mask in d6, shiftMx in d7
	swap	d2
	move.w	d0,d3
	and.l	d6,d3
	move.w	(a0,d3.l*2),d3

;//	Add delta to left
	add.w	d3,d2

;// *d++ = sample - defer write until we have the second sample
	swap	d2

;// packed >>= bitRate;
	lsr.w	d5,d0

;// if (--shifted==0)
	subq.w	#1,d1
	tst.w	d1
	bne.b	L120

L119
;// shifted = shiftMx;
	move.w	d7,d1

;// packed = *s++;
	move.w	(a2)+,d0

L120
;// sample += qTable[(packed & mask)];
	move.w	d0,d3
	and.l	d6,d3
	move.w	(a0,d3.l*2),d3

;// Add delta to right
	add.w	d3,d2

;// packed >>= bitRate;
	lsr.w	d5,d0

;// if (--shifted==0)
	subq.w	#1,d1
	tst.w	d1
	bne.b	L122

L121
;// shifted = shiftMx;
	move.w	d7,d1
;// packed = *s++;
	move.w	(a2)+,d0

L122
	subq.w	#1,d4
	tst.w	d4
	bne.b	L118

;// we have final pair of samples to write before next frame
	move.l	d2,   (a3)+

;// s-=(bitRate&1)
;//	and.w	#1,	d5;
;//	neg.w	d5;
;//	lea		(a2, d5.w*2),a2

;// if (shifted==shiftMx)
;//		s--;
	cmp.w	d7,d5
	bne.b	L123
	lea		-2(a2),a2

L123
	subq.l	#1,-4(a5)
	tst.l	-4(a5)
	bne	L115

L124
;// current = s;
	move.l	a2,$34(a6)

;//	frameNum += num;
	move.l	$38(a6),d0
	add.l	$10(a5),d0
	move.l	d0,$38(a6)
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  sint32 XDAC::DecodeMonoFrames(sint16* dest, sint32 num)
;//
;//  d0 : shifted / scratch
;//  d1 : packed / scratch
;//  d2 : sample pair
;//  d3 : frame header / scratch
;//  d4 : sample counter
;//  d5 : bitRate
;//  d6 : mask
;//  d7 : shiftMx
;//
;//  a0 : qTable
;//  a1 : scratch
;//  a2 : source
;//  a3 : dest
;//  a5 : local stack
;//  a6 : this
;//  a7 : master stack pointer
;//
;////////////////////////////////////////////////////////////////////////////////

	SECTION "DecodeMonoFrames__XDAC__TPsj:0",CODE
	XDEF	DecodeMonoFrames__XDAC__TPsj

DecodeMonoFrames__XDAC__TPsj
L135	EQU	-$20
	link	a5,#L135
	movem.l	d2-d7/a2/a3/a6, -(a7)

	move.l	$8(a5),a6 ;// this pointer in a6 for faster dereferencing of members

L126

;// rsint16*	d = dest;
;// ruint16*	s = current;
	move.l	$C(a5),a3
	move.l	$34(a6),a2

;// rsint32		n = num+1;
	move.l	$10(a5),d0
	addq.l	#1,d0
	move.l	d0,-4(a5)

;//	while(--n)
	bra	L133

L127
;// ruint16 c = *s++; ->d3
	move.w	(a2)+,d3

;// if (XDAC_SILENCE(c))
	move.w	d3,d0
	and.w	#$8000,d0
	beq.b	L129

L128
;//	ruint16 f = XDAC_SLNC_LEN(c);
	and.w	#$FFF,d3

;//	rsint32 len = (shared.frameLen*f)<<1; -> d2
	move.w	$24(a6),d2
	mulu	d3,d2
	lsl.l	#1,d2; // len*sizeof(sint16) -> d2

;// MEM::Zero(d,len) - stack args
	move.l d2, -(a7) ;// len
	move.l a3, -(a7) ;// d
	jsr	Zero__MEM__PvUi
	addq.w	#$8,a7

;//	d += len;
	add.l	d2,a3; // add to d pointer

;//	n -= (f-1);
	addq.w	#1, d3
	ext.l	d3
	sub.l	d3,-4(a5)
	bra.b	L133

L129
;//	rsint16 bitRate = XDAC_BITRATE(c) -> d5
;//	ruint16 mask    = (1<<bitRate)-1 -> d6
;//	rsint16 shiftMx = ((8*sizeof(sint16))/bitRate) -> d7
;//	rsint16 shifted = shiftMx ->d1
	move.w	d3,d5
	and.w	#$300,d5
	lsr.w	#8,d5
	addq.w	#2,d5
	moveq	#1,d6
	lsl.l	d5,d6
	subq.l	#1,d6
	moveq	#$10,d7
	divu	d5,d7
	move.w	d7,d1

;// rsint16 sample = *((sint16*)s++);
	move.w	(a2)+,d2

;// rsint16*	qTable	= (sint16*)s;
	move.l	a2,a0

;//	s += XDAC_TABLESIZE(c);
	moveq	#0,d0
	move.w	d3,d0
	and.w	#$1F,d0
	lea		2(a2,d0.l*2),a2

;// *d++ = (sint16)sample - write start sample
	move.w	d2,(a3)+

;// ruint16 packed = *s++;
	move.w	(a2)+,d0

;// rsint16	i = shared.frameLen;
	move.w	$24(a6),d4

;// while(--i)
	bra.b	L132

L130
;// sample += qTable[(packed & mask)];

	move.w	d0,d3
	and.l	d6,d3
	move.w	(a0,d3.l*2),d3

;//	Add delta
	add.w	d3,d2

;// *d++ = sample;
	move.w	d2,(a3)+

;// packed >>= bitRate;
	lsr.w	d5,d0

;// if (--shifted==0)
	subq.w	#1,d1
	tst.w	d1
	bne.b	L132

L131
;// shifted = shiftMx;
	move.w	d7,d1

;//	packed = *s++;
	move.w	(a2)+,d0

L132
	subq.w	#1,d4
	tst.w	d4
	bne.b	L130

;// if (shifted==shiftMx)
;//		s--;
	cmp.w	d5,	d7
	bne.b	L133
	lea		-2(a2),a2

;// s -= (bitRate & 1)
;//	and.w	#1,	d5;
;//	neg.w	d5;
;//	lea		(a2, d5.w*2),a2

L133
	subq.l	#1,-4(a5)
	tst.l	-4(a5)
	bne	L127

L134
;// current = s;
	move.l	a2,$34(a6)

;// frameNum += num;
	move.l	$38(a6),d0
	add.l	$10(a5),d0
	move.l	d0,$38(a6)
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  sint32 XDAC::DecodeMergedFrames(sint16* dest, sint32 num)
;//
;////////////////////////////////////////////////////////////////////////////////

	SECTION "DecodeMergedFrames__XDAC__TPsj:0",CODE
	XDEF	DecodeMergedFrames__XDAC__TPsj

DecodeMergedFrames__XDAC__TPsj
L151	EQU	-$2C
	link	a5,#L151
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$C(a5),a0
L136
;	rsint16*	d = dest;
	move.l	a0,a6
;	ruint16*	s	= current;
	move.l	$8(a5),a0
	move.l	$34(a0),a2
;	rsint32	n = num+1;
	move.l	$10(a5),d0
	addq.l	#1,d0
	move.l	d0,-4(a5)
;	while(--n)
	bra	L149
L137
;		ruint16 c = *s++;
	move.w	(a2)+,d3
;		if (XDAC_SILENCE(c))
	moveq	#0,d0
	move.w	d3,d0
	and.l	#$8000,d0
	beq.b	L139
L138
;			ruint16 f = XDAC_SLNC_LEN(c);
	moveq	#0,d0
	move.w	d3,d0
	and.l	#$FFF,d0
	move.w	d0,d3
;			rsint32 len = shared.frameLen*shared.channels*f;
	move.l	$8(a5),a1
	move.w	$24(a1),d1
	move.l	$8(a5),a1
	move.w	d1,d2
	mulu	$26(a1),d2
	moveq	#0,d0
	move.w	d3,d0
	mulu.l	d0,d2
;			MEM::Zero(d,len);
	move.l	d2,-(a7)
	move.l	a6,-(a7)
	jsr	Zero__MEM__PvUi
	addq.w	#$8,a7
;			d += len;
	move.l	d2,d0
	moveq	#1,d2
	asl.l	d2,d0
	add.l	a6,d0
	move.l	d0,a6

;// n -= (f-1);
	addq.w	#1, d3
	ext.l	d3
	sub.l	d0,-4(a5)
	bra	L149

L139
;			for (rsint16 ch=0
	moveq	#0,d0
;			for (rsint16 ch=0, *smp=sample;
	lea	-$C(a5),a0
	bra.b	L141
L140
;				*d++ = *smp++ = *((sint16*)s)++;
	move.w	(a2)+,d1
	move.w	d1,(a0)+
	move.w	d1,(a6)+
	addq.w	#1,d0
L141
	move.w	d0,d2
	ext.l	d2
	move.l	$8(a5),a3
	moveq	#0,d1
	move.w	$26(a3),d1
	cmp.l	d1,d2
	blt.b	L140
L142
;			rsint16		bitRate	= XDAC_BITRATE(c);
	moveq	#0,d0
	move.w	d3,d0
	and.l	#$300,d0
	moveq	#$8,d1
	asr.l	d1,d0
	addq.l	#2,d0
	move.w	d0,d6
;			ruint16		mask		= (1<<bitRate)-1;
	move.w	d6,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	d1,d0
	subq.l	#1,d0
	move.w	d0,-$12(a5)
;			rsint16		shiftMx	= ((8*sizeof(sint16))/bitRate);
	move.w	d6,d0
	ext.l	d0
	moveq	#$10,d1
	divul.l	d0,d1
	move.w	d1,d7
;			rsint16		shifted	= shiftMx;
	move.w	d7,d2
;			rsint16*	qTable	= (sint16*)s;
	move.l	a2,a1
;			s	+=	XDAC_TABLESIZE(c);
	moveq	#0,d0
	move.w	d3,d0
	and.l	#$1F,d0
	addq.l	#1,d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;			ruint16		packed	= *s++;
	move.w	(a2)+,d1
;			rsint16		i				= shared.frameLen;
	move.l	$8(a5),a3
	move.w	$24(a3),-$1E(a5)
;			while (--i)
	bra.b	L148
L143
;				for(ch=0;
	moveq	#0,d0
	bra.b	L147
L144
;					rsint16 curr = sample[ch] + qTable[(packed&mask)];
	move.w	d0,d3
	ext.l	d3
	lea	-$C(a5),a0
	move.w	0(a0,d3.l*2),d3
	ext.l	d3
	moveq	#0,d4
	move.w	d1,d4
	moveq	#0,d5
	move.w	-$12(a5),d5
	and.l	d5,d4
	move.w	0(a1,d4.l*2),d4
	ext.l	d4
	add.l	d4,d3
;					*d++ = sample[ch] = curr;
	move.w	d0,d4
	ext.l	d4
	lea	-$C(a5),a0
	move.w	d3,0(a0,d4.l*2)
	move.w	d3,(a6)+
;					packed >>= bitRate;
	lsr.w	d6,d1
;					if (--shifted==0)
	subq.w	#1,d2
	tst.w	d2
	bne.b	L146
L145
;						shifted = shiftMx;
	move.w	d7,d2
;						packed = *s++;
	move.w	(a2)+,d1
L146
	addq.w	#1,d0
L147
	move.w	d0,d4
	ext.l	d4
	move.l	$8(a5),a3
	moveq	#0,d3
	move.w	$26(a3),d3
	cmp.l	d3,d4
	blt.b	L144
L148
	subq.w	#1,-$1E(a5)
	tst.w	-$1E(a5)
	bne.b	L143

;// s -= (bitRate & 1)
;//	and.w	#1,	d6;
;//	neg.w	d6;
;//	lea		(a2, d6.w*2),a2

;// if (shifted==shiftMx)
;//		s--;
	cmp.w	d6,	d7
	bne.b	L149
	lea		-2(a2),a2

L149
	subq.l	#1,-4(a5)
	tst.l	-4(a5)
	bne	L137
L150
;//	current = s;
	move.l	$8(a5),a0
	move.l	a2,$34(a0)
;//	frameNum += num;
	move.l	$8(a5),a0
	move.l	$38(a0),d0
	add.l	$10(a5),d0
	move.l	$8(a5),a0
	move.l	d0,$38(a0)
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  sint32 XDAC::DecodeAlternFrames(sint16* dest, sint32 num)
;//
;////////////////////////////////////////////////////////////////////////////////

	SECTION "DecodeAlternFrames__XDAC__TPsj:0",CODE
	XDEF	DecodeAlternFrames__XDAC__TPsj

DecodeAlternFrames__XDAC__TPsj
L164	EQU	-$2C
	link	a5,#L164
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$10(a5),d0
L152
;//	ruint16*	s	= current;
	move.l	$8(a5),a0
	move.l	$34(a0),a2
;//	rsint32		n = num+1;
	addq.l	#1,d0
	move.l	d0,-4(a5)
;//	while(--n)
	bra	L162
L153
;		for (rsint16 ch=0;
	clr.w	-$22(a5)
	bra	L161
L154
;			rsint16*	d = dest+ch;
	move.w	-$22(a5),d0
	ext.l	d0
	move.l	$C(a5),a1
	lea	0(a1,d0.l*2),a0
;			ruint16 c = *s++;
	move.w	(a2)+,d2
;			if (XDAC_SILENCE(c))
	moveq	#0,d0
	move.w	d2,d0
	and.l	#$8000,d0
	beq.b	L156
L155
;				MEM::Zero(d,shared.frameLen);
	move.l	$8(a5),a3
	moveq	#0,d0
	move.w	$24(a3),d0
	move.l	d0,-(a7)
	move.l	a0,-(a7)
	jsr	Zero__MEM__PvUi
	addq.w	#$8,a7
;				d += shared.frameLen;
	bra	L160
L156
;				rsint16		bitRate = XDAC_BITRATE(c);
	moveq	#0,d0
	move.w	d2,d0
	and.l	#$300,d0
	moveq	#$8,d1
	asr.l	d1,d0
	addq.l	#2,d0
	move.w	d0,d6
;				ruint16		mask		= (1<<bitRate)-1;
	move.w	d6,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	d1,d0
	subq.l	#1,d0
	move.w	d0,-6(a5)
;				rsint16		shiftMx	= ((8*sizeof(sint16))/bitRate);
	move.w	d6,d0
	ext.l	d0
	moveq	#$10,d1
	divul.l	d0,d1
	move.w	d1,-$8(a5)
;				rsint16		shifted	= shiftMx;
	move.w	-$8(a5),d1
;				rsint16 	sample	= *((sint16*)s++);
	move.w	(a2)+,d3
;				rsint16*	qTable	= (sint16*)s;
	move.l	a2,a6
;				rsint16		ch			= shared.channels;
	move.l	$8(a5),a3
	move.w	$26(a3),d7
;				s			+=	XDAC_TABLESIZE(c);
	moveq	#0,d0
	move.w	d2,d0
	and.l	#$1F,d0
	addq.l	#1,d0
	moveq	#1,d2
	asl.l	d2,d0
	add.l	d0,a2
;				*d		= 	(sint16)sample;
	move.w	d3,(a0)
;				d			+=	ch;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d2
	asl.l	d2,d0
	add.l	d0,a0
;				ruint16 packed = *s++;
	move.w	(a2)+,d0
;				rsint16	i = shared.frameLen;
	move.l	$8(a5),a3
	move.w	$24(a3),d4
;				while(--i)
	bra.b	L159
L157
;					sample += qTable[(packed & mask)];
	moveq	#0,d2
	move.w	d0,d2
	moveq	#0,d5
	move.w	-6(a5),d5
	and.l	d5,d2
	add.w	0(a6,d2.l*2),d3
;					*d	= sample;
	move.w	d3,(a0)
;					d		+= ch;
	move.w	d7,d2
	ext.l	d2
	moveq	#1,d5
	asl.l	d5,d2
	add.l	d2,a0
;					packed >>= bitRate;
	lsr.w	d6,d0
;					if (--shifted==0)
	subq.w	#1,d1
	tst.w	d1
	bne.b	L159
L158
;						shifted = shiftMx;
	move.w	-$8(a5),d1
;						packed = *s++;
	move.w	(a2)+,d0
L159
	subq.w	#1,d4
	tst.w	d4
	bne.b	L157

;// if (shifted==shiftMx)
;//   s--;
	cmp.w	-8(a5), d1
	bne.b	L160
	lea		-2(a2),a2

;//				s-=(bitRate&1);
;//	move.w	d6,d0
;//	ext.l	d0
;//	and.l	#1,d0
;//	moveq	#1,d1
;//	asl.l	d1,d0
;//	neg.l	d0
;//	add.l	d0,a2

L160
	addq.w	#1,-$22(a5)
L161
	move.w	-$22(a5),d1
	ext.l	d1
	move.l	$8(a5),a1
	moveq	#0,d0
	move.w	$26(a1),d0
	cmp.l	d0,d1
	blt	L154
L162
	subq.l	#1,-4(a5)
	tst.l	-4(a5)
	bne	L153

L163
;	current = s;
	move.l	$8(a5),a0
	move.l	a2,$34(a0)
;	frameNum += num;
	move.l	$8(a5),a0
	move.l	$38(a0),d0
	add.l	$10(a5),d0
	move.l	$8(a5),a0
	move.l	d0,$38(a0)

	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  sint32 XDAC::DecodeEitherFrames(sint16* dest, sint32 num)
;//
;////////////////////////////////////////////////////////////////////////////////

	SECTION "DecodeEitherFrames__XDAC__TPsj:0",CODE
	XDEF	DecodeEitherFrames__XDAC__TPsj

DecodeEitherFrames__XDAC__TPsj
L166	EQU	0
	link	a5,#L166
L165
	move.l	#-$3050000,d0
	unlk	a5
	rts

	END
