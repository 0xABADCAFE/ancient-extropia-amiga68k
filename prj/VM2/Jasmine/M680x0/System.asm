;//****************************************************************************//
;//**                                                                        **//
;//**  File:          System.asm ($NAME=System.asm)                          **//
;//**                                                                        **//
;//**  Description:   JASMINE code execution routines, MC68040+              **//
;//**  Comment(s):    System/IO routines                                     **//
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

;	XDEF	DSYS_EA__JASMINE_EA__r10P07JASMINEr7Ui
;	XDEF	D2SYS_EA__JASMINE_EA__r10P07JASMINEr6Uir7Ui
	XDEF	fSYS__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_OUT_STR__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_INP_STR__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_BRK__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_DUMP__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_VER__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_NEW_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_NEW_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_NEW_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_NEW_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_DEL_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_DEL_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_DEL_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_DEL_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_NEWS_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_NEWS_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_NEWS_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_NEWS_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_DELS_X8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_DELS_X16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_DELS_X32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
;	XDEF	fSYS_DELS_X64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	SECTION ":0",CODE

;//////////////////////////////////////////////////////////////////////////////

;void JASMINE_OP::fSYS(OP_ARGS)

	CNOP	0,8
fSYS__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	move.b	1(a4),d5
	move.l	#_sysTable__JASMINE_OP,a1
	move.l	(a1,d5.w*4),a0

	;// Temporary hack to allow IO to work with Address.asm
	move.b	2(a4),d5

	jsr		(a0)
	addq.l	#4, JASMINE_instPtr(a2)
	rts
	
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
