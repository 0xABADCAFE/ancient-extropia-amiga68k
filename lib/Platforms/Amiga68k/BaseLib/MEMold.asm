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

; Storm C Compiler
; Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/HandOptimized/sysBaseO.cpp
	mc68040

	XREF	_SysBase
	XREF	Zero__MEM__r8Pvr0Ui
	XREF	Set__MEM__r8Pvr0ir1Ui
;////////////////////////////////////////////////////////////////////////////////
;//
;//  All functions trash d0, d1, a0, a1
;//
;////////////////////////////////////////////////////////////////////////////////

	SECTION "Swap:0",CODE

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Swap16([a0]uint16* dst, [a1]uint16* src, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Swap16__MEM__r8PUsr9PUsr0Ui

	MACRO SWAP16
	move.l	(a1)+,	d1
	rol.w		#8,		d1			; // AA BB CC DD -> AA BB DD CC
	swap		d1						; // AA BB DD CC -> DD CC AA BB
	rol.w		#8,		d1			; // DD CC AA BB -> DD CC BB AA
	swap		d1						; // DD CC BB AA -> BB AA DD CC
	move.l	d1,		(a0)+
	ENDM

Swap16__MEM__r8PUsr9PUsr0Ui
	;// ensure count > 0
	tst.l		d0
	bgt		L49
	rts

L49
	;// count == 1 ?
	cmp.l		#1,		d0
	beq					L68

L50
	;// d0 count
	;// d1 scratch
	;// d2 loop counter
	;// a0 from
	;// a1 to
	;// a2 swtich/case jump target
	movem.l	d2/a2,	-(a7)
	move.l	d0,		d2
	lsr.l		#5,		d2	;// d2 = count>>5;
	move.l	d0,		d1
	lsr.l		#1,		d1
	and.l		#$F,		d1 ;// d1 = ((count>>1) & 15)
	move.l	.switch(pc,d1.l*4),a2
	jmp		(a2)

.switch
	dc.l .case0,	.case1,	.case2,	.case3
	dc.l .case4,	.case5,	.case6,	.case7
	dc.l .case8,	.case9,	.case10,	.case11
	dc.l .case12,	.case13,	.case14,	.case15

.case0	SWAP16
.case15	SWAP16
.case14	SWAP16
.case13	SWAP16
.case12	SWAP16
.case11	SWAP16
.case10	SWAP16
.case9	SWAP16
.case8	SWAP16
.case7	SWAP16
.case6	SWAP16
.case5	SWAP16
.case4	SWAP16
.case3	SWAP16
.case2	SWAP16
.case1	SWAP16

	;// while (--n > 0)
	subq.l	#1,		d2
	bgt.b		.case0
	movem.l	(a7)+,	d2/a2

L67
	;// check for odd 16-bit word at end of loop
	and.l		#1,		d0
	beq.b		L69

L68
	move.w	(a1)+,	d0
	rol.w		#8,		d0
	move.w	d0,		(a0)+

L69
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Swap32([a0]uint32* dst, [a1]uint32* src, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Swap32__MEM__r8PUjr9PUjr0Ui

	MACRO	SWAP32
	move.l (a1)+, d1
	rol.w	#8, d1			;// AABBCCDD -> AABBDDCC
	swap	d1					;// AABBDDCC -> DDCCAABB
	rol.w	#8, d1			;// DDCCAABB -> DDCCBBAA
	move.l	d1, (a0)+	
	ENDM

Swap32__MEM__r8PUjr9PUjr0Ui
	;// ensure count > 0
	tst.l		d0
	bgt.b		L71
	rts

L71
	;// d0 count/loop counter
	;// d1 scratch
	;// a0 from
	;// a1 to
	;// a2 swtich/case jump target
	move.l	a2,	-(a7)
	move.l	d0,		d1
	lsr.l		#4,		d0		;// d0 = count>>4
	and.l		#$F,		d1		;// d1 = count & 15
	move.l	.switch(pc,d1.l*4),a2
	jmp		(a2)

.switch
	; // case table
	dc.l .case0,	.case1,	.case2,	.case3
	dc.l .case4,	.case5,	.case6,	.case7
	dc.l .case8,	.case9,	.case10,	.case11
	dc.l .case12,	.case13,	.case14,	.case15

.case0	SWAP32
.case15	SWAP32
.case14	SWAP32
.case13	SWAP32
.case12	SWAP32
.case11	SWAP32
.case10	SWAP32
.case9	SWAP32
.case8	SWAP32
.case7	SWAP32
.case6	SWAP32
.case5	SWAP32
.case4	SWAP32
.case3	SWAP32
.case2	SWAP32
.case1	SWAP32

	subq.l	#1,		d0
	bgt.b		.case0

L88
	move.l	(a7)+,	a2
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Swap64([a0]uint64* dst, [a1]uint64* src, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Swap64__MEM__r8PUlr9PUlr0Ui

	MACRO	SWAP64
	move.l (a1)+, d1
	move.l (a1)+, d2
	rol.w	#8, d1			;// AABBCCDD -> AABBDDCC
	swap	d1					;// AABBDDCC -> DDCCAABB
	rol.w	#8, d1			;// DDCCAABB -> DDCCBAAB
	rol.w	#8, d2			;// AABBCCDD -> AABBDDCC
	swap	d2					;// AABBDDCC -> DDCCAABB
	rol.w	#8, d2			;// DDCCAABB -> DDCCBBAA
	move.l	d2, (a0)+	;// write longwords in reverse order of reading
	move.l	d1, (a0)+	;// to perform MSDW LSDW swap
	ENDM
	
Swap64__MEM__r8PUlr9PUlr0Ui
	;// ensure count > 0
	tst.l		d0
	bgt.b		L90
	rts

L90
	;// d0 count/loop counter
	;// d1 scratch
	;// d2 scratch
	;// a0 from
	;// a1 to
	;// a2 swtich/case jump target
	movem.l	d2/a2,	-(a7)
	move.l	d0,		d1
	lsr.l		#3,		d0		;// d0 = count>>3
	and.l		#$7,		d1		;// d1 = count & 7
	move.l	.switch(pc,d1.l*4),a2
	jmp		(a2)

.switch
	dc.l .case0,	.case1,	.case2,	.case3
	dc.l .case4,	.case5,	.case6,	.case7

.case0	SWAP64
.case7	SWAP64
.case6	SWAP64
.case5	SWAP64
.case4	SWAP64
.case3	SWAP64
.case2	SWAP64
.case1	SWAP64

	subq.l	#1,		d0
	bgt.b	.case0

L99
	movem.l	(a7)+,	d2/a2
	rts

;////////////////////////////////////////////////////////////////////////////////

	SECTION "Copy:0",CODE

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Copy8([a0]uint8* dst, [a1]uint8* src, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Copy8__MEM__r8PUcr9PUcr0Ui

Copy8__MEM__r8PUcr9PUcr0Ui
	;// ensure count > 0
	tst.l		d0
	bgt		L344
	rts

L344
	move.l	a0,		d1
	and.l		#1,		d1
	bne		L370
	move.l	a1,		d1
	and.l		#1,		d1
	bne		L370

L345
;// count < 4 ?
	cmp.l		#3,		d0
	bls		L364
	
L347
	move.l	d0,		-(a7)			;// save original count
	move.l	d0,		d1
	lsr.l		#6,		d1				;// d1 = loop count		(count>>6)
	lsr.l		#2,		d0				;// d0 = 32-bit count	(count>>2)
	jsr		MEM_Copy32Loop
	move.l	(a7)+,	d0				;// restore count	

L364
;// odd bytes at end
	moveq		#3,		d1
	and.l		d1,		d0
	sub.l		d0,		d1
	jmp		.endbytes(pc, d1.l*2)

.endbytes
	move.b	(a1)+,	(a0)+
	move.b	(a1)+,	(a0)+
	move.b	(a1)+,	(a0)+
	rts

;// tail end jump debug
	move.l	$0BADC0DE, d0
	rts

L370
;// either source or destination was misaligned
	move.l	a6,			-(a7)
	move.l	_SysBase,	a6
	jsr		-$270(a6)
	movem.l	(a7)+,		a6
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Copy16([a0]uint16* dst, [a1]uint16* src, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Copy16__MEM__r8PUsr9PUsr0Ui

Copy16__MEM__r8PUsr9PUsr0Ui
	;// ensure count > 0
	tst.l		d0
	bgt		L373
	rts
	
L371

L373
	;// count == 1 ?
	cmp.l		#1,	d0
	beq		L392

L374
	move.l	d0,		-(a7)			;// save original count
	move.l	d0,		d1
	lsr.l		#5,		d1				;// d1 = loop count		(count>>5)
	lsr.l		#1,		d0				;// d0 = 32-bit count	(count>>1)
	jsr		MEM_Copy32Loop
	move.l	(a7)+,	d0				;// restore count	

L391
	and.l		#1,		d0
	beq.b		L393

L392
	;// odd word at end
	move.w	(a1)+,(a0)+
L393
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Copy64([a0]uint64* dst, [a1]uint64* src, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Copy64__MEM__r8PUlr9PUlr0Ui

Copy64__MEM__r8PUlr9PUlr0Ui
	asl.l		#1,	d0 ;// double nbr of 32-bit words
	;// drop through

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Copy32([a0]uint32* dst, [a1]uint32* src, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Copy32__MEM__r8PUjr9PUjr0Ui

Copy32__MEM__r8PUjr9PUjr0Ui
	;// ensure count > 0
	tst.l		d0
	bgt		L397
	rts

L397
	move.l	d0,	d1
	lsr.l		#4,	d1
	;// drop through
	
;////////////////////////////////////////////////////////////////////////////////
;//
;//  Optimised 32-bit copy code, loop unrolled 16 times
;//
;//  d0 32-bit count / scratch
;//  d1 loop counter
;//  a0 from
;//  a1 to
;//  a2 jump scratch
;//
;//  trashes d0, d1, a0, a1
;//
;////////////////////////////////////////////////////////////////////////////////
	
MEM_Copy32Loop
	move.l	a2,	-(a7)
	and.l		#$F,	d0
	move.l	.switch(pc,d0.l*4),a2
	jmp		(a2)

.switch
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

	subq.l	#1,	d1
	bgt.b		.case0
	move.l	(a7)+,a2
	rts

;////////////////////////////////////////////////////////////////////////////////

	SECTION "Zero:0",CODE

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Zero8([a0]uint32* dst, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Zero8__MEM__r8PUcr0Ui

Zero8__MEM__r8PUcr0Ui
	;// ensure count > 0
	tst.l		d0
	bgt		L444
	rts

L444
	move.l	a0,	d1
	and.l		#1,	d1
	bne		L470

L445
	;// count < 4 ?
	cmp.l		#3,	d0
	bls		L464
	
L447
	move.l	d0,	-(a7)			;// save original count
	move.l	d0,	d1
	lsr.l		#6,	d1				;// d1 = loop count		(count>>6)
	lsr.l		#2,	d0				;// d0 = 32-bit count	(count>>2)
	jsr		MEM_Zero32Loop
	move.l	(a7)+,d0				;// restore count	

L464
;// odd bytes at end
	moveq		#3,	d1
	and.l		d1,	d0
	sub.l		d0,	d1
	jmp		.endbytes(pc, d1.l*2)

.endbytes
	clr.b		(a0)+
	clr.b		(a0)+
	clr.b		(a0)+
	rts

;// endbytes jump debug
	move.l	$0BADC0DE, d0
	rts

L470
	;// either source or destination was misaligned
	jsr		Zero__MEM__r8Pvr0Ui
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Zero16([a0]uint16* dst, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Zero16__MEM__r8PUsr0Ui

Zero16__MEM__r8PUsr0Ui
	;// ensure count > 0
	tst.l	d0
	bgt	L473
	rts

L473
	;// count == 1 ?
	cmp.l	#1,	d0
	beq			L492

L474
	move.l	d0,	-(a7)			;// save original count
	move.l	d0,	d1
	lsr.l		#5,	d1				;// d1 = loop count		(count>>5)
	lsr.l		#1,	d0				;// d0 = 32-bit count	(count>>1)
	jsr		MEM_Zero32Loop
	move.l	(a7)+,d0				;// restore count	

L491
	and.l		#1,	d0
	beq.b	L493

L492
	;// odd 16-bit word at end
	clr.w	(a0)+
L493
	rts



;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Zero64([a0]uint64* dst, [d0]size_t count)
;//
;//  Uses 32-bit copy code
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Zero64__MEM__r8PUlr0Ui

Zero64__MEM__r8PUlr0Ui
	asl.l		#1,	d0
	;// drop through

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Zero32([a0]uint32* dst, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Zero32__MEM__r8PUjr0Ui

Zero32__MEM__r8PUjr0Ui
	;// ensure count > 0
	tst.l	d0
	bgt	L497
	rts

L497
	move.l	d0,	d1
	lsr.l		#4,	d1
	;// drop through

;////////////////////////////////////////////////////////////////////////////////
;//
;//  Optimised 32-bit clear code, loop unrolled 16 times
;//
;//  d0 32-bit count / scratch
;//  d1 loop counter
;//  a0 to
;//  a1 jump scratch
;//
;//  trashes d0, d1, a0, a1
;//
;////////////////////////////////////////////////////////////////////////////////
	
MEM_Zero32Loop
	and.l		#$F,	d0
	move.l	.switch(pc,d0.l*4),a1
	jmp		(a1)

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

	subq.l	#1,	d1
	bgt.b		.case0
	rts

;////////////////////////////////////////////////////////////////////////////////

	SECTION "Set:0",CODE

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Set8([a0]uint8* dst, [d0]uint8 value, [d1]size_t count)
;//
;//  Uses a 32-bit copy loop unrolled 16 times
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Set8__MEM__r8PUcr0Ucr1Ui

Set8__MEM__r8PUcr0Ucr1Ui
	;// ensure count > 0
	tst.l		d1
	bgt		L600
	rts

L600
	move.l	d0,	a1
	move.l	a0,	d0
	and.l		#1,	d0
	exg		d0,	a1
	bne		L610

	;// count < 4 ?
	cmp.l		#3,	d1
	bls		L601
	
	move.l	d1,	a1
	moveq		#0,	d1
	move.b	d0,	d1 ;// d1 = 00:00:00:XX
	rol.w		#8,	d1 ;// d1 = 00:00:XX:00
	move.b	d0,	d1 ;// d1 = 00:00:XX:XX
	move.w	d1,	d0 ;// d0 = 00:00:XX:XX
	swap		d0			;// d0 = XX:XX:00:00
	move.w	d1,	d0 ;// d0 = XX:XX:XX:XX
	move.l	a1,	d1

	move.l	d0,	a1
	move.l	d1,	d0
	lsr.l		#2,	d0
	and.l		#$F,	d0
	exg		d0,	a1			;// a1 = ((count>>2) & 15)
	move.l	d1,	-(a7)
	lsr.l		#6,	d1			;// d1 = (count>>6)
	jsr		MEM_Set32Loop
	move.l	(a7)+,d1

L601
;// odd bytes at end
	exg		d0,	a1
	moveq		#3,	d0
	and.l		d0,	d1
	sub.l		d1,	d0
	move.l	d0,	d1
	exg		d0,	a1
	jmp		.endbytes(pc, d1.l*2)

.endbytes
	move.b	d0,	(a0)+
	move.b	d0,	(a0)+
	move.b	d0,	(a0)+
	rts

;// endbytes jump debug
	move.l	$0BADC0DE, d0
	rts

L610
	jsr		Set__MEM__r8Pvr0ir1Ui
	rts
;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Set16([a0]uint16* dst, [d0]uint16 value, [d1]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Set16__MEM__r8PUsr0Usr1Ui

Set16__MEM__r8PUsr0Usr1Ui
	;// ensure count > 0
	tst.l		d1
	bgt		L700
	rts

L700
;// count == 1 ?
	cmp.l	#1,	d1
	beq			L701

;// save d1 in a1 then use as scratch for making 32-bit value:value in d0

	move.l	d1,	a1
	moveq		#0,	d1
	move.w	d0,	d1 ;// d1 = 0000:XXXX
	swap		d0			;// d0 = XXXX:0000
	move.w	d1,	d0	;// d0 = XXXX:XXXX
	move.l	a1,	d1

	move.l	d0,	a1
	move.l	d1,	d0
	lsr.l		#1,	d0	
	and.l		#$F,	d0
	exg		d0,	a1			;// a1 = ((count>>1) & 15)
	move.l	d1,	-(a7)
	lsr.l		#5,	d1			;// d1 = (count>>5)
	jsr		MEM_Set32Loop
	move.l	(a7)+,d1

	and.l		#1,	d1
	beq.b		L702

L701
	;// odd 16-bit word at end
	move.w	d0, (a0)+
L702
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Set32([a0]uint32* dst, [d0]uint32 value, [d1]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Set32__MEM__r8PUjr0Ujr1Ui

Set32__MEM__r8PUjr0Ujr1Ui
	;// ensure count > 0
	tst.l		d1
	bgt		L800
	rts

L800
	exg		d0,	a1
	move.l	d1,	d0
	and.l		#$F,	d0
	exg		d0,	a1			;// a1 = (count & 15)
	lsr.l		#4,	d1			;// d1 = (count>>4)
	;// drop through

;////////////////////////////////////////////////////////////////////////////////
;//
;//  Optimised 32-bit set code, loop unrolled 16 times
;//
;//  d0 value
;//  d1 loop counter
;//  a0 to
;//  a1 jump scratch (count & 15)
;//
;//  trashes d0, d1, a0, a1
;//
;////////////////////////////////////////////////////////////////////////////////
	
MEM_Set32Loop
	move.l	.switch(pc,a1.l*4),a1
	jmp		(a1)

.switch
	dc.l	.case0,	.case1,	.case2,	.case3
	dc.l	.case4,	.case5,	.case6,	.case7
	dc.l	.case8,	.case8,	.case10,	.case11
	dc.l	.case12,	.case13,	.case14,	.case15
		
.case0	move.l	d0, (a0)+
.case15	move.l	d0, (a0)+
.case14	move.l	d0, (a0)+
.case13	move.l	d0, (a0)+
.case12	move.l	d0, (a0)+
.case11	move.l	d0, (a0)+
.case10	move.l	d0, (a0)+
.case9	move.l	d0, (a0)+
.case8	move.l	d0, (a0)+
.case7	move.l	d0, (a0)+
.case6	move.l	d0, (a0)+
.case5	move.l	d0, (a0)+
.case4	move.l	d0, (a0)+
.case3	move.l	d0, (a0)+
.case2	move.l	d0, (a0)+
.case1	move.l	d0, (a0)+

	subq.l	#1,	d1
	bgt.b		.case0
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Set64([a0]uint32* dst, [a1]uint64& value, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Set64__MEM__r8PUlr9RUlr0Ui

Set64__MEM__r8PUlr9RUlr0Ui
	;// ensure count > 0
	tst.l		d0
	bgt		L900
	rts

L900
	movem.l	d2/d3,	-(a7)
	move.l	d0,		d3
	and.l		#7,		d3	;// d3 = (count & 7)
	lsr.l		#3,		d0 ;// d0 = n = (count>>3)

	move.l	(a1),		d1
	move.l	4(a1),	d2

	move.l	.switch(pc,d3.l*4),a1
	jmp		(a1)

.switch
	dc.l	.case0,	.case1,	.case2,	.case3
	dc.l	.case4,	.case5,	.case6,	.case7
		
.case0	move.l	d1, (a0)+
			move.l	d2, (a0)+
.case7	move.l	d1, (a0)+
			move.l	d2, (a0)+
.case6	move.l	d1, (a0)+
			move.l	d2, (a0)+
.case5	move.l	d1, (a0)+
			move.l	d2, (a0)+
.case4	move.l	d1, (a0)+
			move.l	d2, (a0)+
.case3	move.l	d1, (a0)+
			move.l	d2, (a0)+
.case2	move.l	d1, (a0)+
			move.l	d2, (a0)+
.case1	move.l	d1, (a0)+
			move.l	d2, (a0)+

	subq.l	#1,	d0
	bgt.b		.case0

	movem.l	(a7)+,	d2/d3
	rts

	END
