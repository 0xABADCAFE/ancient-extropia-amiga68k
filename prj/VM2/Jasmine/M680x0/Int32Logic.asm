;//****************************************************************************//
;//**                                                                        **//
;//**  File:          Int32Logic.asm ($NAME=Int32Logic.asm)                  **//
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
	INCLUDE "Int32Logic.i"

	XDEF	fAND_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fAND_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fAND_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fAND_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fOR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fOR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fOR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fXOR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fXOR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fXOR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fXOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fINV_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fINV_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fINV_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fINV_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSHL_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSHL_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSHL_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSHL_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSHR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSHR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fSHR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSHR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//////////////////////////////////////////////////////////////////////////////

	SECTION ":0",CODE

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fAND_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	AND_X	b

	CNOP	0,8
fAND_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	AND_X	w

	CNOP	0,8
fAND_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	AND_X	l

;fAND_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fOR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	OR_X b

	CNOP	0,8
fOR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	OR_X w
	
	CNOP	0,8
fOR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	OR_X l
	
;fOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fXOR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XOR_X b
	
	CNOP	0,8
fXOR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XOR_X w

	CNOP	0,8
fXOR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XOR_X l

;fXOR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fINV_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	NOT_X b

	CNOP	0,8
fINV_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	NOT_X w

	CNOP	0,8
fINV_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	NOT_X l

;fINV_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fSHL_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	SHX_X b, l

	CNOP	0,8
fSHL_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	SHX_X w, l

	CNOP	0,8
fSHL_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	SHX_X l, l

;fSHL_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fSHR_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	SHX_X b, r

	CNOP	0,8
fSHR_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	SHX_X w, r

	CNOP	0,8
fSHR_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	SHX_X l, r

;fSHR_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
