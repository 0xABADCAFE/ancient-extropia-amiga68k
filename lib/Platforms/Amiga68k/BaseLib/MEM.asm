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
	
;////////////////////////////////////////////////////////////////////////////////
;//
;//  All functions trash d0, d1, a0, a1
;//
;//  Wherever possible, data is moved using full 32-bit bus aligned transfers
;//  Large data moves are unrolled to move up to 64 bytes per loop
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
	tst.l		d0
	bgt		Swap16_WordsToSwap
	rts

Swap16_WordsToSwap
	cmp.l		#1,		d0
	beq					Swap16_TrailingWord

Swap16_Use32
	;// d0 count
	;// d1 scratch
	;// d2 loop counter
	;// a0 src
	;// a1 dst
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

	subq.l	#1,		d2
	bgt.b		.case0

	movem.l	(a7)+,	d2/a2
	and.l		#1,		d0
	beq.b		Swap16_Done

Swap16_TrailingWord
	move.w	(a1)+,	d0
	rol.w		#8,		d0
	move.w	d0,		(a0)+

Swap16_Done
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
	tst.l		d0
	bgt.b		Swap32_WordsToSwap
	rts

Swap32_WordsToSwap
	;// d0 count/loop counter
	;// d1 scratch
	;// a0 src
	;// a1 dst
	;// a2 swtich/case jump target
	move.l	a2,	-(a7)
	move.l	d0,		d1
	lsr.l		#4,		d0		;// d0 = count>>4
	and.l		#$F,		d1		;// d1 = count & 15
	move.l	.switch(pc,d1.l*4),a2
	jmp		(a2)

.switch
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
	tst.l		d0
	bgt.b		Swap64_WordsToSwap
	rts

Swap64_WordsToSwap
	;// d0 count/loop counter
	;// d1 scratch
	;// d2 scratch
	;// a0 src
	;// a1 dst
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
	tst.l		d0
	bgt		Copy8_BytesToCopy
	rts

Copy8_BytesToCopy
	;// Is destination or source aligned to an odd address? 
	move.l	a0,		d1
	and.l		#1,		d1
	bne		Copy8_CantAlign32
	move.l	a1,		d1
	and.l		#1,		d1
	bne		Copy8_CantAlign32

	;// If count < 4 just use trailing byte copy
	cmp.l		#3,		d0
	bls		Copy8_TrailingBytes
	
Copy8_Use32
	move.l	d0,		-(a7)			;// save original count
	move.l	d0,		d1
	lsr.l		#6,		d1				;// d1 = loop count		(count>>6)
	lsr.l		#2,		d0				;// d0 = 32-bit count	(count>>2)
	jsr		MEM_Copy32Loop
	move.l	(a7)+,	d0				;// restore count	

Copy8_TrailingBytes
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

Copy8_CantAlign32
	;// either source or destination was misaligned so 32-bit transfers cant be used
	exg		a0,			a1			;// CopyMem([a0]src, [a1]dest, [d0]len);
	move.l	a6,			-(a7)
	move.l	_SysBase,	a6
	jsr		LVO_CopyMem(a6)		;// CopyMem
	movem.l	(a7)+,		a6
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Copy16([a0]uint16* dst, [a1]uint16* src, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Copy16__MEM__r8PUsr9PUsr0Ui

Copy16__MEM__r8PUsr9PUsr0Ui
	tst.l		d0
	bgt		Copy16_WordsToCopy
	rts

Copy16_WordsToCopy
	cmp.l		#1,	d0
	beq		Copy16_TrailingWord

Copy16_Use32
	move.l	d0,		-(a7)			;// save original count
	move.l	d0,		d1
	lsr.l		#5,		d1				;// d1 = loop count		(count>>5)
	lsr.l		#1,		d0				;// d0 = 32-bit count	(count>>1)
	jsr		MEM_Copy32Loop
	move.l	(a7)+,	d0				;// restore count	

	and.l		#1,		d0
	beq.b		Copy16_Done

Copy16_TrailingWord
	move.w	(a1)+,	(a0)+

Copy16_Done
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
	bgt		Copy32_WordsToCopy
	rts

Copy32_WordsToCopy
	move.l	d0,	d1
	lsr.l		#4,	d1
	;// drop through
	
;////////////////////////////////////////////////////////////////////////////////
;//
;//  Optimised 32-bit copy code, loop unrolled 16 times
;//
;//  d0 32-bit count / scratch
;//  d1 loop counter
;//  a0 dst
;//  a1 src
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
	tst.l		d0
	bgt		Zero8_BytesToClear
	rts
	
Zero8_BytesToClear
	;// if count < 4 skip straight to end byte clear
	cmp.l		#3,	d0
	bls		Zero8_TrailingBytes

	;// Is start address 4-byte aligned ?
	move.l	a0,	d1
	and.l		#3,	d1
	beq		Zero8_Use32

Zero8_AlignStart32
	;// d1 contains the odd residue of the start address
	;// count = count - (4 - residue) -> count = count - 4 + residue
	subq.l	#4,	d0
	add.l		d1,	d0
	;// convert residue into jump offset
	;// jmp = residue - 1
	subq.l	#1,	d1
	jmp .startBytes(pc, d1.l*2)

.startBytes
	clr.b		(a0)+
	clr.b		(a0)+
	clr.b		(a0)+

	;// it may be that the count < 4 by now so we skip
	;// straight to end byte copy this is the case
	cmp.l		#3,	d0
	bls		Zero8_TrailingBytes	

	;// We can now use 32-bit clear code for remainder

Zero8_Use32
	move.l	d0,	-(a7)			;// save original count
	move.l	d0,	d1
	lsr.l		#6,	d1				;// d1 = loop count		(count>>6)
	lsr.l		#2,	d0				;// d0 = 32-bit count	(count>>2)
	jsr		MEM_Zero32Loop
	move.l	(a7)+,d0				;// restore count	

Zero8_TrailingBytes
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

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Zero16([a0]uint16* dst, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Zero16__MEM__r8PUsr0Ui

Zero16__MEM__r8PUsr0Ui
	tst.l	d0
	bgt	Zero16_WordsToClear
	rts

Zero16_WordsToClear
	;// count == 1 ?
	cmp.l	#1,	d0
	beq			Zero16_TrailingWord

	;// Is start aligned ?
	move.l	a0, d1
	and.l		#3, d1
	beq		Zero16_Use32

Zero16_AlignStart32
	clr.w		(a0)+
	subq.l	#1, d0

	;// count == 1 ?
	cmp.l	#1,	d0
	beq			Zero16_TrailingWord
	;// count == 0 ?
	bmi			Zero16_Done
	
Zero16_Use32
	move.l	d0,	-(a7)			;// save original count
	move.l	d0,	d1
	lsr.l		#5,	d1				;// d1 = loop count		(count>>5)
	lsr.l		#1,	d0				;// d0 = 32-bit count	(count>>1)
	jsr		MEM_Zero32Loop
	move.l	(a7)+,d0				;// restore count	

	and.l		#1,	d0
	beq.b	Zero16_Done

Zero16_TrailingWord
	clr.w	(a0)+

Zero16_Done
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
	tst.l	d0
	bgt	Zero32_WordsToClear
	rts

Zero32_WordsToClear
	move.l	d0,	d1
	lsr.l		#4,	d1
	;// drop through

;////////////////////////////////////////////////////////////////////////////////
;//
;//  Optimised 32-bit clear code, loop unrolled 16 times
;//
;//  d0 32-bit count / scratch
;//  d1 loop counter
;//  a0 dst
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
	tst.l		d1
	bgt		Set8_BytesToSet
	rts

Set8_BytesToSet
	move.l	d1, a1 ;// save a copy of the count in a1

	;// Is count < 4 ?
	cmp.l		#3,	d1
	bls		Set8_TrailingBytes

	;// Is start address 4-byte aligned ?
	move.l	a0,	d1
	and.l		#3,	d1
	beq		Set8_Use32

Set8_AlignStart32
	
	;// d1 contains the odd residue of the start address
	;// count = count - (4 - residue) -> count = count - 4 + residue
	exg		a1,	d0 ;// switch regs (count in a1)
	subq.l	#4,	d0
	add.l		d1,	d0
	exg		a1,	d0 ;// updated count in a1

	;// convert residue into jump offset
	;// jmp = residue - 1
	subq.l	#1,	d1
	jmp .startBytes(pc, d1.l*2)

.startBytes
	move.b	d0,	(a0)+
	move.b	d0,	(a0)+
	move.b	d0,	(a0)+

	move.l	a1,	d1 ;// updated counter in d1

	;// it may be that the count < 4 by now so we skip
	;// straight to end byte copy this is the case
	cmp.l		#3,	d1
	bls		Set8_TrailingBytes

	;// We can now use 32-bit setting code for remainder
Set8_Use32
	;// convert 0x000000XX value into 32-bit 0xXXXXXXXX value
	moveq		#0,	d1
	move.b	d0,	d1 		;// d1 = 00:00:00:XX
	rol.w		#8,	d1			;// d1 = 00:00:XX:00
	move.b	d0,	d1 		;// d1 = 00:00:XX:XX
	move.w	d1,	d0			;// d0 = 00:00:XX:XX
	swap		d0					;// d0 = XX:XX:00:00
	move.w	d1,	d0			;// d0 = XX:XX:XX:XX

	move.l	a1,	d1			;// restore count in d1

	move.l	d0,	a1			;// save 32-bit val in a1
	move.l	d1,	d0
	lsr.l		#2,	d0
	and.l		#$F,	d0 		;// 32-bit loop jump offset [(count>>2) & 15] in d0
	exg		d0,	a1			;// "" in a1, 32-bit val in d0
	move.l	d1,	-(a7)		;// save original d1 byte count
	lsr.l		#6,	d1			;// 32-bit loop count (count>>6) in d1
	jsr		MEM_Set32Loop
	move.l	(a7)+,d1			;// restore original d1 count

Set8_TrailingBytes
;// odd bytes at end
	move.l	d0,	a1	;// save val in a1
	moveq		#3,	d0
	and.l		d0,	d1
	sub.l		d1,	d0
	move.l	d0,	d1	;// d1 now contains jump offset
	move.l	a1,	d0 ;// restore val in d0
	jmp		.endbytes(pc, d1.l*2)

.endbytes
	move.b	d0,	(a0)+
	move.b	d0,	(a0)+
	move.b	d0,	(a0)+
	rts

;// endbytes jump debug
	move.l	$0BADC0DE, d0
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Set16([a0]uint16* dst, [d0]uint16 value, [d1]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Set16__MEM__r8PUsr0Usr1Ui

Set16__MEM__r8PUsr0Usr1Ui
	tst.l		d1
	bgt		Set16_WordsToSet
	rts

Set16_WordsToSet
	move.l	d1,	a1 ; // keep copy of count in a1
	;// count == 1 ?
	cmp.l		#1,	d1
	beq		Set16_TrailingWord

	;// Is start aligned ?
	move.l	a0, 	d1
	and.l		#3, 	d1
	beq		Set16_Use32

Set16_AlignStart32
	move.w	d0,	(a0)+
	move.l	a1,	d1
	subq.l	#1,	d1
	;// count == 1 ?
	cmp.l		#1,	d1
	beq		Set16_TrailingWord
	;// count == 0 ?
	bmi		Set16_Done

	move.l	d1,	a1 ; // keep copy of count in a1

;// save d1 in a1 then use as scratch for making 32-bit value:value in d0
Set16_Use32
	move.w	d0,	d1 ;// d1 = 0000:XXXX
	swap		d0			;// d0 = XXXX:0000
	move.w	d1,	d0	;// d0 = XXXX:XXXX

	move.l	a1,	d1 ;// restore count in d1

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
	beq.b		Set16_Done

Set16_TrailingWord
	;// odd 16-bit word at end
	move.w	d0, (a0)+
Set16_Done
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Set32([a0]uint32* dst, [d0]uint32 value, [d1]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF	Set32__MEM__r8PUjr0Ujr1Ui

Set32__MEM__r8PUjr0Ujr1Ui
	tst.l		d1
	bgt		Set32_WordsToSet
	rts

Set32_WordsToSet
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
;//  a0 dst
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
	tst.l		d0
	bgt		Set64_WordsToSet
	rts

Set64_WordsToSet
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
