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
;//**  Author(s):     Karl Churchill                                         **//
;//**                                                                        **//
;//**  Copyright:     (C)1998-2002, eXtropia Studios                         **//
;//**                 Serkan YAZICI, Karl Churchill                          **//
;//**                 All Rights Reserved.                                   **//
;//**                                                                        **//
;//****************************************************************************//

	INCDIR  "Extropialib:prj/VM2/Jasmine/M680x0"
	INCLUDE "Jasmine.i"


	XDEF	fF64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	SECTION ":0",CODE

;// void JASMINE_OP::fF64_F32(OP_ARGS)
	CNOP 0,8

fF64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	moveq		#4,d7
	move.b	1(a5),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		F64_F32_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi.b		F64_F32_OP1_REG_INDIRECT

F64_F32_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	fmove.s	(a0),fp0
	bra.b		F64_F32_DONE_OP1

F64_F32_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	fmove.s	(a0),fp0
	bra.b		F64_F32_DONE_OP1

F64_F32_OP1_REG_DIRECT
	fmove.s	JASMINE_gpRegs+4(a2,d5.w*8),fp0

F64_F32_DONE_OP1
	moveq		#8,d7
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		F64_F32_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi.b		F64_F32_OP2_REG_INDIRECT

F64_F32_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	fmove.d	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
	rts	

F64_F32_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	fmove.d	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
	rts

F64_F32_OP2_REG_DIRECT
	fmove.d	fp0, JASMINE_gpRegs(a2,d5.w*8)
	addq.l	#4,JASMINE_instPtr(a2)
	rts
	
;//////////////////////////////////////////////////////////////////////////////

;// void JASMINE_OP::fF32_F64(OP_ARGS)
	CNOP 0,8

fF32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	moveq		#8,d7
	move.b	1(a5),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		F32_F64_OP1_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi.b		F32_F64_OP1_REG_INDIRECT

F32_F64_OP1_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	fmove.d	(a0),fp0
	bra.b		F32_F64_DONE_OP1

F32_F64_OP1_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	fmove.d	(a0),fp0
	bra.b		F32_F64_DONE_OP1

F32_F64_OP1_REG_DIRECT
	fmove.d	JASMINE_gpRegs(a2,d5.w*8),fp0

F32_F64_DONE_OP1
	moveq		#4,d7
	move.b	2(a4),d5
	cmp.w		#EA_regDirect,d5
	bmi.b		F32_F64_OP2_REG_DIRECT
	cmp.w		#EA_regIndirect,d5
	bmi.b		F32_F64_OP2_REG_INDIRECT

F32_F64_OP2_EAFUNC
	move.l	(a3,d5.w*4),a0
	jsr		(a0)
	move.l	d0,a0
	fmove.s	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
	rts	

F32_F64_OP2_REG_INDIRECT
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	fmove.s	fp0,(a0)
	addq.l	#4,JASMINE_instPtr(a2)
	rts

F32_F64_OP2_REG_DIRECT
	fmove.s	fp0, JASMINE_gpRegs+4(a2,d5.w*8)
	addq.l	#4,JASMINE_instPtr(a2)
	rts

;//////////////////////////////////////////////////////////////////////////////
	
	END

;//////////////////////////////////////////////////////////////////////////////
