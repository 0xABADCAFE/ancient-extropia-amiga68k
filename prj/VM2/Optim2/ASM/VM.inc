
;//////////////////////////////////////////////////////////////////////////////
;//
;//  VM.inc
;//
;//  This file to be included in all VMCORE 68K asm sources 
;//
;//////////////////////////////////////////////////////////////////////////////

;// Target

	mc68040

;// Imported symbols

	XREF	Neg64
	XREF	Add64
	XREF	Sub64
	XREF	SMult64
	XREF	SDiv64
	XREF	SDiv64
	XREF	SMod64
	XREF	lib_64bit_shl
	XREF	lib_64bit_shr
	XREF	lib_64bit_shrS
	XREF	_fmod__r
	XREF	_0dt__VMCORE__T
	XREF	_instTable__VMCORE
	XREF	_eaTable__VMCORE

;// VMCORE class member offsets

OFS_opPtr0				EQU $100
OFS_opPtr1				EQU $104
OFS_opPtr2				EQU $108
OFS_instPtr				EQU $10C
OFS_dataSectPtr		EQU $110
OFS_constSectPtr		EQU $114
OFS_branchStack		EQU $118
OFS_stack				EQU $11C
OFS_exitReg				EQU $120
OFS_countReg			EQU $124
OFS_branchStackBase	EQU $128
OFS_stackBase			EQU $12C

EA_regDirect			EQU 32
EA_regIndirect			EQU 64

