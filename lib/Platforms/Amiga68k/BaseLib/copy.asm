;//****************************************************************************//
;//** File:         Mem.asm ($NAME=Mem.asm)                                  **//
;//** Description:  eXtropia Library Base API Source                         **//
;//** Comment(s):   This file is included in AmigaOS 68K systems             **//
;//** Library:      Base                                                     **//
;//** Created:      2001-11-10                                               **//
;//** Updated:      2001-12-17                                               **//
;//** Author(s):    Karl Churchill                                           **//
;//** Note(s):      Asm definitions for 68K MEM class functions              **//
;//** Copyright:    (C)1996-2001, eXtropia Studios                           **//
;//**               Serkan YAZICI, Karl Churchill                            **//
;//**               All Rights Reserved.                                     **//
;//****************************************************************************//

	mc68040

	XREF	_SysBase
LVO_CopyMem	EQU	-$270

	XDEF	Copy__MEM__r8Pvr9Pvr0Ui
	
;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Copy([a0] void* dst, [a1] void* src, [d0] size_t len)
;//
;////////////////////////////////////////////////////////////////////////////////


Copy__MEM__r8Pvr9Pvr0Ui
	tst.l		d0
	bgt		copyLengthOK
	rts

copyLengthOK
	cmp		a0,		a1
	bne		copyPointersOK
	rts

copyPointersOK
	cmp.l		#3,		d0
	bls		copyTrailingBytes

	move.l	a1,		d1
	and.l		#3,		d1
	bne		copyMisaligned
	move.l	a0,		d1
	and.l		#3,		d1
	bne		copyMisaligned

copy32
	move.l	d0,		-(a7)
	move.l	d0,		d1
	lsr.l		#6,		d1	;// each loop moves 64 bytes as 16*4
	lsr.l		#2,		d0	;// data moved in 4 byte units

	and.l		#$F,		d0 ;// calc jump offset
	move.l	a2,		-(a7)
	move.l	.jump(pc,d0.l*4),a2
	jmp		(a2)

.jump
	dc.l	.case0,	.case1,	.case2,	.case3
	dc.l	.case4,	.case5,	.case6,	.case7
	dc.l	.case8,	.case8,	.case10,	.case11
	dc.l	.case12,	.case13,	.case14,	.case15
		
.case0	move.l	(a1)+,(a0)+
.case15	move.l	(a1)+,(a0)+
.case14	move.l	(a1)+,(a0)+
.case13	move.l	(a1)+,(a0)+
.case12	move.l	(a1)+,(a0)+
.case11	move.l	(a1)+,(a0)+
.case10	move.l	(a1)+,(a0)+
.case9	move.l	(a1)+,(a0)+
.case8	move.l	(a1)+,(a0)+
.case7	move.l	(a1)+,(a0)+
.case6	move.l	(a1)+,(a0)+
.case5	move.l	(a1)+,(a0)+
.case4	move.l	(a1)+,(a0)+
.case3	move.l	(a1)+,(a0)+
.case2	move.l	(a1)+,(a0)+
.case1	move.l	(a1)+,(a0)+

	subq.l	#1,		d1
	bgt.b		.case0

	move.l	(a7)+,	a2
	move.l	(a7)+,	d0

copyTrailingBytes
	moveq		#3,		d1
	and.l		d1,		d0
	sub.l		d0,		d1
	jmp		.end(pc, d1.l*2)

.end
	move.b	(a1)+,	(a0)+	
	move.b	(a1)+,	(a0)+	
	move.b	(a1)+,	(a0)+
	rts

	move.l	$0BADC0DE, d0
	rts

copyMisaligned
	;// use exec CopyMem()
	exg		a0,		a1
	move.l	a6,		-(a7)
	jsr		LVO_CopyMem(a6)
	move.l	(a7)+,	a6
	rts

	END
