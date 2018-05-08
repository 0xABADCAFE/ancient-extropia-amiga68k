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


	XDEF	Zero__MEM__r8Pvr0Ui
	
;////////////////////////////////////////////////////////////////////////////////
;//
;//  All functions trash d0, d1, a0, a1
;//
;//  Wherever possible, data is moved using full 32-bit bus aligned transfers
;//  Large data moves are unrolled to move up to 64 bytes per loop
;//
;////////////////////////////////////////////////////////////////////////////////

	SECTION "Zero:0",CODE

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Zero([a0]void* dst, [d0]size_t len)
;//
;////////////////////////////////////////////////////////////////////////////////

Zero__MEM__r8Pvr0Ui
	tst.l		d0
	bgt		Zero_BytesToClear
	rts
	
Zero_BytesToClear
	;// If len < 4 skip straight to end byte clear
	cmp.l		#3,	d0
	bls		Zero_TrailingBytes

Zero_AlignStart32
	move.l	a0,		d1
	and.l		#3,		d1
	beq		Zero_Use32
	;// d1 contains the odd residue of the start address
	;// 1) len = len - 4 + residue
	;// 2) convert residue into jump offset (jmp = residue - 1)
	subq.l	#4,		d0
	add.l		d1,		d0
	subq.l	#1,		d1
	jmp		.startBytes(pc, d1.l*2)

.startBytes
	clr.b		(a0)+
	clr.b		(a0)+
	clr.b		(a0)+

	;// it may be that the remaining len < 4 by now so we skip
	;// straight to end byte copy this is the case
	cmp.l		#3,		d0
	bls		Zero_TrailingBytes

Zero_Use32
	;// We can now use 32-bit clear code for remainder
	move.l	d0,		-(a7)			;// save original count
	move.l	d0,		d1
	lsr.l		#6,		d1				;// d1 = loop count		(count>>6)
	lsr.l		#2,		d0				;// d0 = 32-bit count	(count>>2)
	and.l		#$F,		d0
	move.l	.switch(pc,d0.l*4),a1
	jmp		(a1)

	CNOP		0, 4

.switch
	dc.l	.case0,	.case1,	.case2,	.case3
	dc.l	.case4,	.case5,	.case6,	.case7
	dc.l	.case8,	.case8,	.case10,	.case11
	dc.l	.case12,	.case13,	.case14,	.case15
		
.case0	clr.l	(a0)+
.case15	clr.l	(a0)+
.case14	clr.l	(a0)+
.case13	clr.l	(a0)+
.case12	clr.l	(a0)+
.case11	clr.l	(a0)+
.case10	clr.l	(a0)+
.case9	clr.l	(a0)+
.case8	clr.l	(a0)+
.case7	clr.l	(a0)+
.case6	clr.l	(a0)+
.case5	clr.l	(a0)+
.case4	clr.l	(a0)+
.case3	clr.l	(a0)+
.case2	clr.l	(a0)+
.case1	clr.l	(a0)+

	subq.l	#1,		d1
	bgt.b		.case0

	move.l	(a7)+,	d0	;// restore len

Zero_TrailingBytes
;// odd bytes at end
	moveq		#3,		d1
	and.l		d1,		d0
	sub.l		d0,		d1
	jmp		.endbytes(pc, d1.l*2)

.endbytes
	clr.b		(a0)+
	clr.b		(a0)+
	clr.b		(a0)+
	rts

;// endbytes jump debug
	move.l	$0BADC0DE, d0
	rts

	END
