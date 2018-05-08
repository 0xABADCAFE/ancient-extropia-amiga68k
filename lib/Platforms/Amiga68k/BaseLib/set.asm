;//****************************************************************************//
;//** File:         set.asm ($NAME=set.asm)                                  **//
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

	XDEF	Set__MEM__r8Pvr0ir1Ui
	XDEF	Set16__MEM__r8Pvr0Usr1Ui
	XDEF	Set32__MEM__r8Pvr0Ujr1Ui
	XDEF	Set64__MEM__r8Pvr9RUlr0Ui

	SECTION "Set:0",CODE

;////////////////////////////////////////////////////////////////////////////////
;//
;//  All functions trash d0, d1, a0, a1
;//
;//  Wherever possible, data is moved using full 32-bit bus aligned transfers
;//  Large data moves are unrolled to move up to 64 bytes per loop
;//
;////////////////////////////////////////////////////////////////////////////////


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Set([a0] void* dst, [d0] int c, [d1] size_t len)
;//
;////////////////////////////////////////////////////////////////////////////////


Set__MEM__r8Pvr0ir1Ui
	tst.l		d1
	bgt		Set_BytesToSet
	rts

Set_BytesToSet
	move.l	d1, a1 ;// save a copy of the len in a1

	;// If len<4, jump to trailing byte set
	cmp.l		#3,	d1
	bls		Set_TrailingBytes

	;// Is start address 4-byte aligned ?
	move.l	a0,	d1
	and.l		#3,	d1
	beq		Set_Use32

Set_AlignStart32
	;// d1 contains the odd residue of the start address
	;// len = len - (4 - residue) -> len = len - 4 + residue
	exg		a1,	d0 ;// switch regs (len in a1)
	subq.l	#4,	d0
	add.l		d1,	d0
	exg		a1,	d0 ;// updated len in a1

	;// convert residue into jump offset
	;// jmp = residue - 1
	subq.l	#1,	d1
	jmp		.startBytes(pc, d1.l*2)

.startBytes
	move.b	d0,	(a0)+
	move.b	d0,	(a0)+
	move.b	d0,	(a0)+

	move.l	a1,	d1 ;// updated len in d1

	;// it may be that len < 4 by now so we skip
	;// straight to end byte copy this is the case
	cmp.l		#3,	d1
	bls		Set_TrailingBytes

Set_Use32
	;// We can now use 32-bit setting code for remainder
	;// convert 0x000000XX value into 32-bit 0xXXXXXXXX value
	moveq		#0,	d1
	move.b	d0,	d1 		;// d1 = 00:00:00:XX
	rol.w		#8,	d1			;// d1 = 00:00:XX:00
	move.b	d0,	d1 		;// d1 = 00:00:XX:XX
	move.w	d1,	d0			;// d0 = 00:00:XX:XX
	swap		d0					;// d0 = XX:XX:00:00
	move.w	d1,	d0			;// d0 = XX:XX:XX:XX

	move.l	a1,	d1			;// restore len in d1

	move.l	d0,	a1			;// save 32-bit val in a1
	move.l	d1,	d0
	lsr.l		#2,	d0
	and.l		#$F,	d0 		;// 32-bit loop jump offset [(count>>2) & 15] in d0
	exg		d0,	a1			;// "" in a1, 32-bit val in d0
	move.l	d1,	-(a7)		;// save original d1 byte count
	lsr.l		#6,	d1			;// 32-bit loop count (count>>6) in d1
	jsr		MEM_Set32Loop
	move.l	(a7)+,d1			;// restore original d1 count

Set_TrailingBytes
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

	;// debug
	move.l	$0BADC0DE, d0
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void MEM::Set16([a0]void* dst, [d0]uint16 value, [d1]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////


Set16__MEM__r8Pvr0Usr1Ui
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
;//  void MEM::Set32([a0]void* dst, [d0]uint32 value, [d1]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////


Set32__MEM__r8Pvr0Ujr1Ui
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
;//  void MEM::Set64([a0]void* dst, [a1]uint64& value, [d0]size_t count)
;//
;////////////////////////////////////////////////////////////////////////////////


Set64__MEM__r8Pvr9RUlr0Ui
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
