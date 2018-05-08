;//****************************************************************************//
;//**                                                                        **//
;//**  File:          Address.asm ($NAME=Address.asm)                        **//
;//**                                                                        **//
;//**  Description:   JASMINE code execution routines, MC68040+              **//
;//**  Comment(s):    low level effective addressing modes                   **//
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

	XDEF	fR0__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR1__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR2__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR3__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR4__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR5__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR6__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR7__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR8__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR9__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR10__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR11__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR12__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR13__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR14__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR15__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR16__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR17__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR18__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR19__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR20__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR21__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR22__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR23__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR24__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR25__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR26__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR27__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR28__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR29__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR30__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fR31__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR0__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR1__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR2__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR3__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR4__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR5__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR6__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR7__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR8__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR9__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR10__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR11__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR12__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR13__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR14__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR15__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR16__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR17__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR18__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR19__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR20__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR21__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR22__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR23__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR24__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR25__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR26__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR27__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR28__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR29__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR30__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIR31__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR0__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR1__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR2__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR3__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR4__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR5__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR6__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR7__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR8__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR9__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR10__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR11__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR12__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR13__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR14__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR15__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR16__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR17__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR18__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR19__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR20__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR21__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR22__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR23__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR24__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR25__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR26__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR27__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR28__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR29__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR30__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLIR31__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR0__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR1__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR2__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR3__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR4__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR5__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR6__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR7__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR8__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR9__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR10__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR11__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR12__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR13__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR14__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR15__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR16__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR17__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR18__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR19__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR20__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR21__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR22__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR23__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR24__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR25__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR26__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR27__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR28__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR29__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR30__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLUIR31__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIRRO__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIRROU__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIRSRO__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fIRSROU__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fCTR__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fDS__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fCDS__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fLITERAL__JASMINE_EA__r10P07JASMINEr7Ui
	XDEF	fOFFSET_PC__JASMINE_EA__r10P07JASMINEr7Ui

;//////////////////////////////////////////////////////////////////////////////

	SECTION ":0",CODE

;//////////////////////////////////////////////////////////////////////////////

;void* JASMINE_EA::fRxx(EA_ARGS)		
fR0__JASMINE_EA__r10P07JASMINEr7Ui
fR1__JASMINE_EA__r10P07JASMINEr7Ui
fR2__JASMINE_EA__r10P07JASMINEr7Ui
fR3__JASMINE_EA__r10P07JASMINEr7Ui
fR4__JASMINE_EA__r10P07JASMINEr7Ui
fR5__JASMINE_EA__r10P07JASMINEr7Ui
fR6__JASMINE_EA__r10P07JASMINEr7Ui
fR7__JASMINE_EA__r10P07JASMINEr7Ui
fR8__JASMINE_EA__r10P07JASMINEr7Ui
fR9__JASMINE_EA__r10P07JASMINEr7Ui
fR10__JASMINE_EA__r10P07JASMINEr7Ui
fR11__JASMINE_EA__r10P07JASMINEr7Ui
fR12__JASMINE_EA__r10P07JASMINEr7Ui
fR13__JASMINE_EA__r10P07JASMINEr7Ui
fR14__JASMINE_EA__r10P07JASMINEr7Ui
fR15__JASMINE_EA__r10P07JASMINEr7Ui
fR16__JASMINE_EA__r10P07JASMINEr7Ui
fR17__JASMINE_EA__r10P07JASMINEr7Ui
fR18__JASMINE_EA__r10P07JASMINEr7Ui
fR19__JASMINE_EA__r10P07JASMINEr7Ui
fR20__JASMINE_EA__r10P07JASMINEr7Ui
fR21__JASMINE_EA__r10P07JASMINEr7Ui
fR22__JASMINE_EA__r10P07JASMINEr7Ui
fR23__JASMINE_EA__r10P07JASMINEr7Ui
fR24__JASMINE_EA__r10P07JASMINEr7Ui
fR25__JASMINE_EA__r10P07JASMINEr7Ui
fR26__JASMINE_EA__r10P07JASMINEr7Ui
fR27__JASMINE_EA__r10P07JASMINEr7Ui
fR28__JASMINE_EA__r10P07JASMINEr7Ui
fR29__JASMINE_EA__r10P07JASMINEr7Ui
fR30__JASMINE_EA__r10P07JASMINEr7Ui
fR31__JASMINE_EA__r10P07JASMINEr7Ui
	lea		JASMINE_gpRegs+8(a2, d5.w*8), a0
	sub.l		d7,a0
	move.l	a0,d0
	rts

;//////////////////////////////////////////////////////////////////////////////

;void* JASMINE_EA::fIRxx(EA_ARGS)		
fIR0__JASMINE_EA__r10P07JASMINEr7Ui
fIR1__JASMINE_EA__r10P07JASMINEr7Ui
fIR2__JASMINE_EA__r10P07JASMINEr7Ui
fIR3__JASMINE_EA__r10P07JASMINEr7Ui
fIR4__JASMINE_EA__r10P07JASMINEr7Ui
fIR5__JASMINE_EA__r10P07JASMINEr7Ui
fIR6__JASMINE_EA__r10P07JASMINEr7Ui
fIR7__JASMINE_EA__r10P07JASMINEr7Ui
fIR8__JASMINE_EA__r10P07JASMINEr7Ui
fIR9__JASMINE_EA__r10P07JASMINEr7Ui
fIR10__JASMINE_EA__r10P07JASMINEr7Ui
fIR11__JASMINE_EA__r10P07JASMINEr7Ui
fIR12__JASMINE_EA__r10P07JASMINEr7Ui
fIR13__JASMINE_EA__r10P07JASMINEr7Ui
fIR14__JASMINE_EA__r10P07JASMINEr7Ui
fIR15__JASMINE_EA__r10P07JASMINEr7Ui
fIR16__JASMINE_EA__r10P07JASMINEr7Ui
fIR17__JASMINE_EA__r10P07JASMINEr7Ui
fIR18__JASMINE_EA__r10P07JASMINEr7Ui
fIR19__JASMINE_EA__r10P07JASMINEr7Ui
fIR20__JASMINE_EA__r10P07JASMINEr7Ui
fIR21__JASMINE_EA__r10P07JASMINEr7Ui
fIR22__JASMINE_EA__r10P07JASMINEr7Ui
fIR23__JASMINE_EA__r10P07JASMINEr7Ui
fIR24__JASMINE_EA__r10P07JASMINEr7Ui
fIR25__JASMINE_EA__r10P07JASMINEr7Ui
fIR26__JASMINE_EA__r10P07JASMINEr7Ui
fIR27__JASMINE_EA__r10P07JASMINEr7Ui
fIR28__JASMINE_EA__r10P07JASMINEr7Ui
fIR29__JASMINE_EA__r10P07JASMINEr7Ui
fIR30__JASMINE_EA__r10P07JASMINEr7Ui
fIR31__JASMINE_EA__r10P07JASMINEr7Ui
	and.w		#$1F, d5
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	a0,d0
	rts

;//////////////////////////////////////////////////////////////////////////////

;void* JASMINE_EA::fLIR0(EA_ARGS)	
fLIR0__JASMINE_EA__r10P07JASMINEr7Ui
fLIR1__JASMINE_EA__r10P07JASMINEr7Ui
fLIR2__JASMINE_EA__r10P07JASMINEr7Ui
fLIR3__JASMINE_EA__r10P07JASMINEr7Ui
fLIR4__JASMINE_EA__r10P07JASMINEr7Ui
fLIR5__JASMINE_EA__r10P07JASMINEr7Ui
fLIR6__JASMINE_EA__r10P07JASMINEr7Ui
fLIR7__JASMINE_EA__r10P07JASMINEr7Ui
fLIR8__JASMINE_EA__r10P07JASMINEr7Ui
fLIR9__JASMINE_EA__r10P07JASMINEr7Ui
fLIR10__JASMINE_EA__r10P07JASMINEr7Ui
fLIR11__JASMINE_EA__r10P07JASMINEr7Ui
fLIR12__JASMINE_EA__r10P07JASMINEr7Ui
fLIR13__JASMINE_EA__r10P07JASMINEr7Ui
fLIR14__JASMINE_EA__r10P07JASMINEr7Ui
fLIR15__JASMINE_EA__r10P07JASMINEr7Ui
fLIR16__JASMINE_EA__r10P07JASMINEr7Ui
fLIR17__JASMINE_EA__r10P07JASMINEr7Ui
fLIR18__JASMINE_EA__r10P07JASMINEr7Ui
fLIR19__JASMINE_EA__r10P07JASMINEr7Ui
fLIR20__JASMINE_EA__r10P07JASMINEr7Ui
fLIR21__JASMINE_EA__r10P07JASMINEr7Ui
fLIR22__JASMINE_EA__r10P07JASMINEr7Ui
fLIR23__JASMINE_EA__r10P07JASMINEr7Ui
fLIR24__JASMINE_EA__r10P07JASMINEr7Ui
fLIR25__JASMINE_EA__r10P07JASMINEr7Ui
fLIR26__JASMINE_EA__r10P07JASMINEr7Ui
fLIR27__JASMINE_EA__r10P07JASMINEr7Ui
fLIR28__JASMINE_EA__r10P07JASMINEr7Ui
fLIR29__JASMINE_EA__r10P07JASMINEr7Ui
fLIR30__JASMINE_EA__r10P07JASMINEr7Ui
fLIR31__JASMINE_EA__r10P07JASMINEr7Ui
	and.w		#$1F, d5
	addq.l	#4,JASMINE_instPtr(a2)
	move.l	JASMINE_gpRegs+4(a2,d5.w*8),d0
	move.l	JASMINE_instPtr(a2),a0
	add.l		(a0),d0
	rts

;//////////////////////////////////////////////////////////////////////////////

;void* JASMINE_EA::fLUIR0(EA_ARGS)
fLUIR0__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR1__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR2__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR3__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR4__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR5__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR6__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR7__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR8__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR9__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR10__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR11__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR12__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR13__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR14__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR15__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR16__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR17__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR18__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR19__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR20__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR21__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR22__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR23__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR24__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR25__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR26__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR27__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR28__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR29__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR30__JASMINE_EA__r10P07JASMINEr7Ui
fLUIR31__JASMINE_EA__r10P07JASMINEr7Ui
	and.w		#$1F, d5
	addq.l	#4,JASMINE_instPtr(a2)
	lea		JASMINE_gpRegs+4(a2,d5.w*8),a0
	move.l	(a0), d0
	move.l	JASMINE_instPtr(a2),a1
	add.l		(a1), d0
	move.l	d0, (a0)
	rts

;void* JASMINE_EA::fIRRO(EA_ARGS)
fIRRO__JASMINE_EA__r10P07JASMINEr7Ui
L225
;	jvm->instPtr++;
	move.l	JASMINE_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,JASMINE_instPtr(a2)
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),a1
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fIRROU(EA_ARGS)
fIRROU__JASMINE_EA__r10P07JASMINEr7Ui
L226
;	jvm->instPtr++;
	move.l	JASMINE_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,JASMINE_instPtr(a2)
;	uint8*	&p = IRRO_BASEREG.PtrU8();
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	lea	4(a0),a1
;	p += IRRO_OFSTREG();
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d0
	move.b	2(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fIRSRO(EA_ARGS)
fIRSRO__JASMINE_EA__r10P07JASMINEr7Ui
L227
;	jvm->instPtr++;
	move.l	JASMINE_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,JASMINE_instPtr(a2)
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	move.l	4(a0),a1
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d0
	move.w	(a0),d0
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d1
	move.b	2(a0),d1
	lea	0(a2,d1.l*8),a0
	muls.l	4(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fIRSROU(EA_ARGS)
fIRSROU__JASMINE_EA__r10P07JASMINEr7Ui
L228
;	jvm->instPtr++;
	move.l	JASMINE_instPtr(a2),a0
	lea	4(a0),a0
	move.l	a0,JASMINE_instPtr(a2)
;	uint8*	&p = IRRO_BASEREG.PtrU8();
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d0
	move.b	3(a0),d0
	lea	0(a2,d0.l*8),a0
	lea	4(a0),a1
;	p += IRRO_SCALE()*IRRO_OFSTREG();
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d0
	move.w	(a0),d0
	move.l	JASMINE_instPtr(a2),a0
	moveq	#0,d1
	move.b	2(a0),d1
	lea	0(a2,d1.l*8),a0
	muls.l	4(a0),d0
	move.l	(a1),a0
	lea	0(a0,d0.l),a0
	move.l	a0,(a1)
	move.l	(a1),d0
	rts

;void* JASMINE_EA::fCTR(EA_ARGS)			
fCTR__JASMINE_EA__r10P07JASMINEr7Ui
L229
	lea	JASMINE_countReg(a2),a0
	move	a0,d0
	rts

;void* JASMINE_EA::fDS(EA_ARGS)			
fDS__JASMINE_EA__r10P07JASMINEr7Ui
L230
	move.l	JASMINE_dataSectPtr(a2),a1
	move.l	JASMINE_instPtr(a2),a0
	addq.w	#4,a0
	move.l	a0,JASMINE_instPtr(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fCDS(EA_ARGS)			
fCDS__JASMINE_EA__r10P07JASMINEr7Ui
L231
	move.l	JASMINE_constSectPtr(a2),a1
	move.l	JASMINE_instPtr(a2),a0
	addq.w	#4,a0
	move.l	a0,JASMINE_instPtr(a2)
	move.l	(a0),d0
	add.l	a1,d0
	rts

;void* JASMINE_EA::fLITERAL(EA_ARGS)	
fLITERAL__JASMINE_EA__r10P07JASMINEr7Ui
	addq.l	#4,JASMINE_instPtr(a2)
	move.l	JASMINE_instPtr(a2),d0
	addq.l	#4,d0
	sub.l		d7,d0
	rts

;void* JASMINE_EA::fOFFSET_PC(EA_ARGS)		
fOFFSET_PC__JASMINE_EA__r10P07JASMINEr7Ui
	move.l	JASMINE_instPtr(a2),a1
	addq.w	#4,a1
	move.l	(a1),d0
	lea		(a1,d0.l*4),a0
	move.l	a1,JASMINE_instPtr(a2)
	move.l	a0,d0
	rts

;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////