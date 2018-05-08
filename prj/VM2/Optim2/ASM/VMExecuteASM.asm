;//////////////////////////////////////////////////////////////////////////////
;//
;//  VM_Execute.asm
;//  
;//////////////////////////////////////////////////////////////////////////////

	INCDIR  "Extropialib:prj/VM2/Optim2/ASM"
	INCLUDE "VM.inc"

	XDEF	Execute__VMCORE__T

	SECTION ":0",CODE

;///////////////////////////////////////////////////////////////////////////////////////////////////////
;//
;//  uint32 VMCORE::Execute()
;//
;//  Inside here we can push all the machine registers and pop again execution
;//  That way we can use all the machine registers in the implementation and keep various useful
;//  stuff in registers. This works because the opcode handling functions are only called from here
;//  and nowhere else
;//
;//  d0-d1  : volatile scratch
;//  a0-a1  : volatile scratch
;//  d0-d4  : scratch
;//  a0-a1  : scratch
;//  a2     : VMCORE this pointer
;//  a3     : eaTable
;//  a4     : ea byte pointer / scratch
;//  a5     : scratch
;//  a6     : instTable
;//  d6     : instruction bytcode
;//  d7     : operand sizes, set by opcode func
;//  d5     : ea bytecode
;//
;///////////////////////////////////////////////////////////////////////////////////////////////////////

Execute__VMCORE__T

;// Grab the VMCORE this pointer from the stack, is currently only thing there
;// Push everything were gonna trash later onto the stack

	move.l	4(a7), a0
	movem.l	d2-d7/a2-a6,-(a7);				;// We want to use all regs
	move.l	a0, a2								;// this
	move.l	#_eaTable__VMCORE,a3				;// EA func LUT
	move.l	#_instTable__VMCORE,a6			;// CMD func LUT

;// clear global data regs
	moveq		#0,d5
	moveq		#0,d6
	bra.b		ARE_WE_THERE_YET

DO_SOME_WORK
	move.l	OFS_instPtr(a2), a0
	move.b	(a0),d6
	move.l	(a6,d6.l*4),a0	
	jsr (a0)
	
ARE_WE_THERE_YET
	tst.l		OFS_exitReg(a2)
	beq.b		DO_SOME_WORK
	move.l	OFS_exitReg(a2),d0			;// return exitReg
	movem.l	(a7)+,d2-d7/a2-a6 			;// Restore regs
	rts