;//****************************************************************************//
;//** File:         sysBaseO.asm ($NAME=sysBaseO.asm)                        **//
;//** Description:  eXtropia Library Base API Source                         **//
;//** Comment(s):   This file is included in AmigaOS 68K systems             **//
;//** Library:      Base                                                     **//
;//** Created:      2001-11-10                                               **//
;//** Updated:      2001-12-17                                               **//
;//** Author(s):    Karl Churchill                                           **//
;//** Note(s):      Asm definitions for 68K MEM::Swap16/32/64 functions      **//
;//** Copyright:    (C)1996-2001, eXtropia Studios                           **//
;//**               Serkan YAZICI, Karl Churchill                            **//
;//**               All Rights Reserved.                                     **//
;//****************************************************************************//


; Storm C Compiler
; derived from Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/sysBaseO.cpp
	mc68040

	SECTION ":0",CODE


;/////////////////////////////////////////////////////////////////////////
;//
;//  MEM::Swap16([a0]uint16*,[a1]uint16*,[d0]size_t)
;//
;//  No local stack frame, uses USP for d2
;//
;/////////////////////////////////////////////////////////////////////////

	XDEF	Swap16__MEM__r8PUsr9PUsr0Ui
Swap16__MEM__r8PUsr9PUsr0Ui
L57
	move.l	d2,-(a7)
L58
;//	if ( ((UINT32)s|(UINT32)d) & 3UL)
	move.l	a0,d1
	move.l	a1,d2
	or.l	d2,d1
	and.l	#3,d1
	beq.b	L63

;///////////////// 16-bit copy loop
L59
L60
	move.w	(a0)+, d1
	rol.w	#8, d1
	move.w	d1, (a1)+
L61
	subq.l	#1,d0
	bne.b	L60
L62
	bra.b	L68
L63
;//		if (n&1UL)
	move.l	d0,d1
	and.l	#1,d1
	beq.b	L65
L64
;//	*(d+n-1) = *(((UINT8*)(s+n-1))+1)<<8 | *((UINT8*)(s+n-1));

	move.w	-2(a0,d0.l*2),	d1	;// temp = *(s+n-1)
	rol.w	#8,				d1	;// xxxxAABB -> xxxxBBAA
	move.w	d1,	-2(a1,d0.l*2)	;// *(d+n-1) = temp

L65
;//		n >>= 1;
	lsr.l	#1,d0

L66
	move.l (a0)+, d1
	rol.w	#8, d1	;// AABBCCDD -> AABBDDCC
	swap	d1		;// AABBDDCC -> DDCCAABB
	rol.w	#8, d1	;// DDCCAABB -> DDCCBBAA
	swap	d1		;// DDCCBBAA -> BBAADDCC
	move.l	d1, (a1)+
L67
	subq.l	#1,d0
	bne.b	L66

L68
	move.l	(a7)+,d2
	rts

;/////////////////////////////////////////////////////////////////////////
;//
;//  MEM::Swap32([a0]uint32*,[a1]uint32*,[d0]size_t)
;//
;//  No local stack frame, no USP use
;//
;/////////////////////////////////////////////////////////////////////////


	XDEF	Swap32__MEM__r8PUjr9PUjr0Ui
Swap32__MEM__r8PUjr9PUjr0Ui
L71
	move.l (a0)+, d1
	rol.w	#8, d1	;// AABBCCDD -> AABBDDCC
	swap	d1		;// AABBDDCC -> DDCCAABB
	rol.w	#8, d1	;// DDCCAABB -> DDCCBBAA
	move.l	d1, (a1)+
L72
	subq.l	#1,d0
	bne.b	L71
L73
	rts

;/////////////////////////////////////////////////////////////////////////
;//
;//  MEM::Swap64([a0]uint64*,[a1]uint64*,[d0]size_t)
;//
;//  No local stack frame, uses USP for d2
;//
;/////////////////////////////////////////////////////////////////////////

	XDEF	Swap64__MEM__r8PUlr9PUlr0Ui
Swap64__MEM__r8PUlr9PUlr0Ui

L75
	move.l	d2,-(a7)
L76
	move.l (a0)+, d1
	move.l (a0)+, d2

	rol.w	#8, d1	;// AABBCCDD -> AABBDDCC
	swap	d1		;// AABBDDCC -> DDCCAABB
	rol.w	#8, d1	;// DDCCAABB -> DDCCBAAB

	rol.w	#8, d2	;// AABBCCDD -> AABBDDCC
	swap	d2		;// AABBDDCC -> DDCCAABB
	rol.w	#8, d2	;// DDCCAABB -> DDCCBBAA

	move.l	d2, (a1)+ ;// write longwords in reverse order of reading
	move.l	d1, (a1)+ ;// to perform MSDW LSDW swap
L77
	subq.l	#1,d0
	bne.b	L76

L78
	move.l	(a7)+,d2
	rts

	END
