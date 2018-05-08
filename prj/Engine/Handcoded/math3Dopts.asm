;//****************************************************************************//
;//**                                                                        **//
;//**  File:          math3D.asm ($NAME=math3D.asm)                          **//
;//**                                                                        **//
;//**  Description:   3D vector arithmetic routines MC68040+                 **//
;//**  Comment(s):                                                           **//
;//**                                                                        **//
;//**  First Started: 2003-01-18                                             **//
;//**  Last Updated:  2003-01-18                                             **//
;//**                                                                        **//
;//**  Author(s):     Karl Churchill                                         **//
;//**                                                                        **//
;//**  Copyright:     (C)1998-2003, eXtropia Studios                         **//
;//**                 Serkan YAZICI, Karl Churchill                          **//
;//**                 All Rights Reserved.                                   **//
;//**                                                                        **//
;//****************************************************************************//

	INCDIR  "Extropialib:prj/Engine/Handcoded/"
	INCLUDE "math3D.i"

	XDEF	asmMagnitude__VEC3D___r_r8P05VEC3D
	XDEF	asmNormalize__VEC3D__r8CP05VEC3D
	XDEF	asm_MultiplyAssign__TRANSFORM__r8CPfr9CPf

	SECTION ":0",CODE

;// float32 VEC3D::asmMagnitude([a0] VEC3D*)
	CNOP 0,4
asmMagnitude__VEC3D___r_r8P05VEC3D
	move.l	(a7),a0	; 			// a0 = 'this' pointer
	fmove.s	VEC3D_x(a0), fp0
	fmul.x	fp0, fp0				;// fp0 = x*x
	fmove.s	VEC3D_y(a0), fp1
	fmul.x	fp1, fp1				;// fp1 = y*y
	fadd.x	fp1, fp0				;// fp0 = x*x + y*y
	fmove.s	VEC3D_z(a0), fp1
	fmul.x	fp1, fp1				;// fp1 = z*z
	fadd.x	fp1, fp0				;// fp0 = x*x + y*y + z*z
	fsqrt.x	fp0					;// return fp0
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;// void VEC3D::asmNormalize([a0] VEC3D *const)
;//
;//////////////////////////////////////////////////////////////////////////////
	CNOP 0,4
asmNormalize__VEC3D__r8CP05VEC3D	
	fmove.s	VEC3D_x(a0), fp0
	fmul.x	fp0, fp0				;// fp0 = x*x
	fmove.s	VEC3D_y(a0), fp1
	fmul.x	fp1, fp1				;// fp1 = y*y
	fadd.x	fp1, fp0				;// fp0 = x*x + y*y
	fmove.s	VEC3D_z(a0), fp1
	fmul.x	fp1, fp1				;// fp1 = z*z
	fadd.x	fp1, fp0				;// fp0 = x*x + y*y + z*z
	fmove.s	#1.0,fp1
	fsqrt.x	fp0, fp0
	fdiv.x	fp0, fp1				;// fp1 = 1.0/sqrt(x*x + y*y + z*z)
	fmove.s	VEC3D_x(a0), fp0
	fmul.x	fp1, fp0
	fmove.s	fp0, VEC3D_x(a0)	;// x*=fp1
	fmove.s	VEC3D_y(a0), fp0
	fmul.x	fp1, fp0
	fmove.s	fp0, VEC3D_y(a0)	;// y*=fp1
	fmove.s	VEC3D_z(a0), fp0
	fmul.x	fp1, fp0
	fmove.s	fp0, VEC3D_z(a0)	;// z*=fp1
	rts

;//////////////////////////////////////////////////////////////////////////////
;//
;//  void TRANSFORM::asm_MultiplyAssign0001([a0] float32 *const d, [a1] float32* const s)
;//
;//  Optimised for d row 4 = | 0 0 0 1 |
;//
;//////////////////////////////////////////////////////////////////////////////
	CNOP 0,4

	MACRO CELL
	fmove.s	M_1\2(a1), fp0
	fmul.s	(a7), fp0
	fmove.s	M_2\2(a1), fp1
	fmul.s	4(a7), fp1
	fadd.x	fp1, fp0
	fmove.s	M_3\2(a1), fp1
	fmul.s	8(a7), fp1
	fadd.x	fp1, fp0
	IFC "\2","4"
	fadd.s	M_\1\2(a0), fp0
	ENDC
	fmove.s	fp0, M_\1\2(a0)
	ENDM

	MACRO CELL0XX
	;// optimised for first row term zero
	fmove.s	M_2\2(a1), fp0
	fmul.s	4(a7), fp0
	fmove.s	M_3\2(a1), fp1
	fmul.s	8(a7), fp1
	fadd.x	fp1, fp0
	IFC "\2","4"
	fadd.s	M_\1\2(a0), fp0
	ENDC
	fmove.s	fp0, M_\1\2(a0)	
	ENDM
	
	MACRO CELLX0X
	;// optimised for second row term zero
	fmove.s	M_1\2(a1), fp0
	fmul.s	(a7), fp0
	fmove.s	M_2\2(a1), fp1
	fmul.s	8(a7), fp1
	fadd.x	fp1, fp0
	IFC "\2","4"
	fadd.s	M_\1\2(a0), fp0
	ENDC
	fmove.s	fp0, M_\1\2(a0)	
	ENDM
	
	MACRO CELLXX0
	;// optimised for third row term zero
	fmove.s	M_1\2(a1), fp0
	fmul.s	(a7), fp0
	fmove.s	M_2\2(a1), fp1
	fmul.s	4(a7), fp1
	fadd.x	fp1, fp0
	IFC "\2","4"
	fadd.s	M_\1\2(a0), fp0
	ENDC
	fmove.s	fp0, M_\1\2(a0)
	ENDM



asm_MultiplyAssign__TRANSFORM__r8CPfr9CPf

;// check stack alignment and allocate either 12 or 14 bytes to
;// cache row elements, ensuring the data are 32-bit aligned
	move.w	#12, d1
	move.l	a7,d0
	and.w		#2,d0
	beq		.stackOK	
	addq.w	#2, d1

.stackOK
	sub.w		d1,a7
	;// Cache row elements on stack which takes less space than pushing
	;// full fp registers and cacheing row elements in registers.
	;// Little or no difference in speed for fmul.s d8(a7), fpn versus
	;// fmul.x fpm, fpn. The multiplication is still internally extended
	;// precision.
	move.l	M_11(a0), (a7)
	move.l	M_12(a0), 4(a7)
	move.l	M_13(a0), 8(a7)

	;// calc M[1,1]
	CELL 1, 1
	CELL 1, 2
	CELL 1, 3
	CELL 1, 4

	move.l	M_21(a0), (a7)
	move.l	M_22(a0), 4(a7)
	move.l	M_23(a0), 8(a7)

	CELL 2, 1
	CELL 2, 2
	CELL 2, 3
	CELL 2, 4

	move.l	M_31(a0), (a7)
	move.l	M_32(a0), 4(a7)
	move.l	M_33(a0), 8(a7)

	CELL 3, 1
	CELL 3, 2
	CELL 3, 3
	CELL 3, 4

	add.w	d1, a7
	rts

	END
