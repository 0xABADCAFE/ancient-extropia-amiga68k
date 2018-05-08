;//****************************************************************************//
;//**                                                                        **//
;//**  File:          CastFloat.asm ($NAME=CastFloat.asm)                    **//
;//**                                                                        **//
;//**  Description:   JASMINE code execution routines, MC68040+              **//
;//**  Comment(s):    8-32 bit Integer arithmetic operations                 **//
;//**                                                                        **//
;//**  First Started: 2002-08-04                                             **//
;//**  Last Updated:  2002-08-24                                             **//
;//**                                                                        **//
;//**  Author(s):     Karl Churchill, Serkan YAZICI                          **//
;//**                                                                        **//
;//**  Copyright:     (C)1998-2002, eXtropia Studios                         **//
;//**                 Serkan YAZICI, Karl Churchill                          **//
;//**                 All Rights Reserved.                                   **//
;//**                                                                        **//
;//****************************************************************************//

	INCDIR  "Extropialib:prj/VM2/Jasmine/M680x0"
	INCLUDE "Jasmine.i"


	XDEF _FloatToUint32
	XDEF _Uint32ToFloat__r
	XDEF _Uint64ToFloat__r
	XDEF _Sint64ToFloat__r

	XDEF Sint64ToFloat64___r_r8Rl
	XDEF Uint64ToFloat64___r_r8Rl
	
	SECTION ":0",CODE

	CNOP 0,8

_FloatToUint32
	fcmp.x	#2147483648.0,fp0
	fbge.w	f2u_dosign
	fmove.l	fp0,d0
	rts
f2u_dosign
	fsub.x	#2147483648.0,fp0
	fmove.l	fp0,d0	
	add.l		#$80000000,d0
	rts

	CNOP 0,8

_UintTo32Float__r
	tst.l	d0
	fmove.l	d0,fp0
	bmi.b		u2f_dosign
	rts
u2f_dosign
	fadd.x	#4294967296.0,fp0
	rts


;//////////////////////////////////////////////////////////////////////////////
;//
;//  Uint64ToFloat()
;//
;//  [fp0] float64 Uint64ToFloat([d0]uint32 MSW : [d1]uint32 LSW)
;//
;//  Converts an unsigned 64-bit integer into floating point format. The integer
;//  is passed as two 32-bit words in d0/d1. The result is evaluated internally
;//  using extended precision (96-bits).
;//  This function trashes fp1.
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP 0,8

Uint64ToFloat64___r_r8Rl
	move.l	(a0),d0
	move.l	4(a0),d1
_Uint64ToFloat__r
	tst.l		d0							;// Check nature of MSW
	beq.b		mswZero					;// MSW is zero so skip to lsw only
	fmove.l	d0,fp0
	bge.b		mswSignOK				;// MSW not interpreted as -ve
	fadd.x	#4294967296.0,fp0		;// else add 2^32
mswSignOK
	fmul.x	#4294967296.0,fp0		;// scale by 2^32
	tst.l		d1							;// Check nature of LSW
	bne.b		lswNonZero
	rts									;// Zero, were outta here
lswNonZero
	fmove.l	d1,fp1
	bgt.b		lswSignOK				;// LSW not interpreted as -ve
	fadd.x	#4294967296.0,fp1		;// else add 2^32
lswSignOK
	fadd.x	fp1,fp0					;// return sum of converted MSW and LSW
	rts

	CNOP 0,8
mswZero									;// just process LSW
	tst.l		d1							;// Check nature of LSW
	bne.b		lswNonZero2
	fmove.x	#0.0,fp0					;// Zero, return 0.0
	rts
lswNonZero2
	fmove.l	d1,fp0
	bgt.b		lswSignOK2				;// LSW not interpreted as -ve
	fadd.x	#4294967296.0,fp0		;// else add 2^32
lswSignOK2
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  Sint64ToFloat()
;//
;//  [fp0] float64 Sint64ToFloat([d0]sint32 MSW : [d1]uint32 LSW)
;//
;//  Converts a signed 64-bit integer into floating point format. The integer
;//  is passed as two 32-bit words in d0/d1. The result is evaluated internally
;//  using extended precision (96-bits).
;//  This function trashes fp1.
;//
;//////////////////////////////////////////////////////////////////////////////

	CNOP 0,8

Sint64ToFloat64___r_r8Rl
	move.l	(a0),d0
	move.l	4(a0),d1
_Sint64ToFloat__r
	cmp.l		#-1,d0
	bne.b		UseMSW
	tst.l		d1
	fmove.l	d1,fp0
	bmi.b		Done
	fsub.x	#4294967296.0,fp0
	rts
UseMSW
	tst.l		d0							;// Check nature of MSW
	beq.b		mswZero					;// MSW is zero so skip to lsw only
	fmove.l	d0,fp0
	fmul.x	#4294967296.0,fp0		;// scale by 2^32
	bgt.b		Pos
Neg
	tst.l		d1							;// Check nature of LSW
	bne.b		lswNonZeroNeg
	rts									;// Zero, were outta here
lswNonZeroNeg
	fmove.l	d1,fp1
	bgt.b		lswSignOKNeg			;// LSW not interpreted as -ve
	fadd.x	#4294967296.0,fp1		;// else add 2^32
lswSignOKNeg
	fsub.x	fp1,fp0					;// return diff of converted MSW and LSW
	rts
Pos
	tst.l		d1							;// Check nature of LSW
	bne.b		lswNonZeroPos
	rts									;// Zero, were outta here
lswNonZeroPos
	fmove.l	d1,fp1
	bgt.b		lswSignOKPos			;// LSW not interpreted as -ve
	fadd.x	#4294967296.0,fp1		;// else add 2^32
lswSignOKPos
	fadd.x	fp1,fp0					;// return sum of converted MSW and LSW
Done
	rts

;//////////////////////////////////////////////////////////////////////////////
	
	END

;//////////////////////////////////////////////////////////////////////////////
