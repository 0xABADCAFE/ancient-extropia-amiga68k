;//****************************************************************************//
;//**                                                                        **//
;//**  File:          Execute.asm ($NAME=Execute.asm)                        **//
;//**                                                                        **//
;//**  Description:   JASMINE code execution routines, MC68040+              **//
;//**  Comment(s):                                                           **//
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

	XDEF	Execute__JASMINE__P07JASMINE

	SECTION ":0",CODE

;//////////////////////////////////////////////////////////////////////////////
;//
;//  static void JASMINE::Execute(<stack> this)
;//
;//  Inside here we can push all the machine registers and pop again execution
;//  That way we can use all the machine registers in the implementation and
;//  keep various useful stuff in registers. This works because the opcode
;//  handling functions are only called from here and nowhere else.
;//
;//  d0-d1  : volatile scratch
;//  a0-a1  : volatile scratch
;//  d0-d4  : scratch
;//  a0-a1  : scratch
;//  a2     : this pointer
;//  a3     : eaTable
;//  a4     : instPtr
;//  a5     : scratch
;//  a6     : instTable
;//  d6     : instruction bytcode
;//  d7     : operand sizes, set by opcode func
;//  d5     : ea bytecode
;//
;//////////////////////////////////////////////////////////////////////////////

Execute__JASMINE__P07JASMINE

;// Grab the this pointer from the stack, is currently only thing there
;// Push everything were gonna trash later onto the stack

	move.l	4(a7), a0
	movem.l	d2-d7/a2-a6,-(a7);				;// We want to use all regs
	move.l	a0, a2								;// this
	move.l	#_eaTable__JASMINE_EA,a3		;// EA func LUT
	move.l	#_instTable__JASMINE_OP,a6		;// CMD func LUT

;// clear global data regs
	moveq		#0,d5
	moveq		#0,d6
;	lea		RETURN_POS(PC),a5

	bra.b		PROGRAM_DONE

EXECUTE_OPCODE
	move.l	JASMINE_instPtr(a2), a4
	move.b	(a4),d6
	move.l	(a6,d6.w*4),a0	
	jsr		(a0)								
	
PROGRAM_DONE
	tst.l		JASMINE_exitReg(a2)
	beq.b		EXECUTE_OPCODE
	movem.l	(a7)+,d2-d7/a2-a6 			;// Restore regs
	rts

;//////////////////////////////////////////////////////////////////////////////

;//////////////////////////////////////////////////////////////////////////////
	
	END
	
;//////////////////////////////////////////////////////////////////////////////
