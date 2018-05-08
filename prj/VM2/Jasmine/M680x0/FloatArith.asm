;//****************************************************************************//
;//**                                                                        **//
;//**  File:          FloatArith.asm ($NAME=FloatArith.asm)                  **//
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
	INCLUDE "FloatArith.i"

	XDEF	fADD_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fADD_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSUB_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSUB_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fMUL_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fMUL_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fDIV_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fDIV_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fMOD_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fMOD_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fNEG_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fNEG_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//////////////////////////////////////////////////////////////////////////////

	SECTION ":0",CODE

;void JASMINE_OP::fADD_F32(OP_ARGS);
;void JASMINE_OP::fADD_F64(OP_ARGS);

	CNOP	0,8
fADD_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	ADD_F	s

	CNOP	0,8
fADD_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	ADD_F	d

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fSUB_F32(OP_ARGS);
;void JASMINE_OP::fSUB_F64(OP_ARGS);

	CNOP	0,8
fSUB_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	SUB_F	s

	CNOP	0,8
fSUB_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	SUB_F	d

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fMUL_F32(OP_ARGS);
;void JASMINE_OP::fMUL_F64(OP_ARGS);

	CNOP	0,8
fMUL_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	MUL_F	s

	CNOP	0,8
fMUL_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	MUL_F	d
		
;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fDIV_F32(OP_ARGS);
;void JASMINE_OP::fDIV_F64(OP_ARGS);

	CNOP	0,8
fDIV_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	DIV_F	s

	CNOP	0,8
fDIV_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	DIV_F	d

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fMOD_F32(OP_ARGS);
;void JASMINE_OP::fMOD_F64(OP_ARGS);

	CNOP	0,8
fMOD_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	MOD_F	s

	CNOP	0,8
fMOD_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	MOD_F	d

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fNEG_F32(OP_ARGS);
;void JASMINE_OP::fNEG_F64(OP_ARGS);

	CNOP	0,8
fNEG_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	NEG_F	s
	
	CNOP	0,8
fNEG_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	NEG_F	d
	
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////

