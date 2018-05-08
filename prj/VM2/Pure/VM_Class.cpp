//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "VM_Class.hpp"

VMCORE::EAFUNC VMCORE::eaTable[256] =
{
	fR0,			fR1,			fR2,			fR3, 			fR4,			fR5,			fR6,			fR7,
	fR8,			fR9,			fR10,			fR11,			fR12,			fR13,			fR14,			fR15,
	fR16,			fR17,			fR18,			fR19,			fR20,			fR21,			fR22,			fR23,
	fR24,			fR25,			fR26,			fR27,			fR28,			fR29,			fR30,			fR31,
	fIR0,			fIR1,			fIR2,			fIR3, 		fIR4,			fIR5,			fIR6,			fIR7,
	fIR8,			fIR9,			fIR10,		fIR11,		fIR12,		fIR13,		fIR14,		fIR15,
	fIR16,		fIR17,		fIR18,		fIR19,		fIR20,		fIR21,		fIR22,		fIR23,
	fIR24,		fIR25,		fIR26,		fIR27,		fIR28,		fIR29,		fIR30,		fIR31,
	fLIR0,		fLIR1,		fLIR2,		fLIR3, 		fLIR4,		fLIR5,		fLIR6,		fLIR7,
	fLIR8,		fLIR9,		fLIR10,		fLIR11,		fLIR12,		fLIR13,		fLIR14,		fLIR15,
	fLIR16,		fLIR17,		fLIR18,		fLIR19,		fLIR20,		fLIR21,		fLIR22,		fLIR23,
	fLIR24,		fLIR25,		fLIR26,		fLIR27,		fLIR28,		fLIR29,		fLIR30,		fLIR31,
	fLUIR0,		fLUIR1,		fLUIR2,		fLUIR3, 	fLUIR4,		fLUIR5,		fLUIR6,		fLUIR7,
	fLUIR8,		fLUIR9,		fLUIR10,	fLUIR11,	fLUIR12,	fLUIR13,	fLUIR14,	fLUIR15,
	fLUIR16,	fLUIR17,	fLUIR18,	fLUIR19,	fLUIR20,	fLUIR21,	fLUIR22,	fLUIR23,
	fLUIR24,	fLUIR25,	fLUIR26,	fLUIR27,	fLUIR28,	fLUIR29,	fLUIR30,	fLUIR31,
	fIRRO,		fIRROU,
	fIRSRO,		fIRSROU,
	fCTR,
	fDS, fCDS,
	fLITERAL,
	fOFFSET_PC,
	0
};

VMCORE::OPFUNC VMCORE::instTable[256] =
{
	fNOP,
	fEND,
	fSYS,
	fLEA,
	fBRA,
	fBNEQ_I8,			fBNEQ_I16,			fBNEQ_I32,			fBNEQ_I64,			fBNEQ_F32,			fBNEQ_F64,
	fBLS_I8,			fBLS_I16,				fBLS_I32,				fBLS_I64,				fBLS_F32,				fBLS_F64,
	fBLSEQ_I8,		fBLSEQ_I16,			fBLSEQ_I32,			fBLSEQ_I64,			fBLSEQ_F32,			fBLSEQ_F64,
	fBEQ_I8,			fBEQ_I16,				fBEQ_I32,				fBEQ_I64,				fBEQ_F32,				fBEQ_F64,
	fBGREQ_I8,		fBGREQ_I16,			fBGREQ_I32,			fBGREQ_I64,			fBGREQ_F32,			fBGREQ_F64,
	fBGR_I8,			fBGR_I16,				fBGR_I32,				fBGR_I64,				fBGR_F32,				fBGR_F64,

	fCALL,
	fRET,

	fPUSH_X8,			fPUSH_X16,			fPUSH_X32,			fPUSH_X64,
	fPOP_X8,			fPOP_X16,				fPOP_X32,				fPOP_X64,
	fPUSHREGS,		fPOPREGS,
	fCLR_X8,			fCLR_X16,				fCLR_X32,				fCLR_X64,
	fMOVE_X8,			fMOVE_X16,			fMOVE_X32,			fMOVE_X64,

	fENDIAN_X16,	fENDIAN_X32,		fENDIAN_X64,
	fSWAP_X8,			fSWAP_X16,			fSWAP_X32,			fSWAP_X64,

	fI8TOI16,			fI8TOI32,				fI8TOI64,				fI8TOF32,				fI8TOF64,
	fI16TOI32,		fI16TOI64,			fI16TOF32,			fI16TOF64,
	fI32TOI64,		fI32TOF32,			fI32TOF64,
	fI64TOF32,		fI64TOF64,
	fF32TOF64,

	fF64TOF32,		fF64TOI64,			fF64TOI32,			fF64TOI16,			fF64TOI8,
	fF32TOI64,		fF32TOI32,			fF32TOI16,			fF32TOI8,
	fI64TOI32,		fI64TOI16,			fI64TOI8,
	fI32TOI16,		fI32TOI8,
	fI16TOI8,

	fADD_I8,			fADD_I16,				fADD_I32,				fADD_I64,				fADD_F32,				fADD_F64,
	fSUB_I8,			fSUB_I16,				fSUB_I32,				fSUB_I64,				fSUB_F32,				fSUB_F64,
	fMUL_I8,			fMUL_I16,				fMUL_I32,				fMUL_I64,				fMUL_F32,				fMUL_F64,
	fDIV_I8,			fDIV_I16,				fDIV_I32,				fDIV_I64,				fDIV_F32,				fDIV_F64,
	fMOD_I8,			fMOD_I16,				fMOD_I32,				fMOD_I64,				fMOD_F32,				fMOD_F64,

	fMUL_U8,			fMUL_U16,				fMUL_U32,				fMUL_U64,
	fDIV_U8,			fDIV_U16,				fDIV_U32,				fDIV_U64,
	fMOD_U8,			fMOD_U16,				fMOD_U32,				fMOD_U64,

	fNEG_I8,			fNEG_I16,				fNEG_I32,				fNEG_I64,				fNEG_F32,				fNEG_F64,
	fSHL_I8,			fSHL_I16,				fSHL_I32,				fSHL_I64,
	fSHR_I8,			fSHR_I16,				fSHR_I32,				fSHR_I64,
	fAND_X8,			fAND_X16,				fAND_X32,				fAND_X64,
	fOR_X8,				fOR_X16,				fOR_X32,				fOR_X64,
	fXOR_X8,			fXOR_X16,				fXOR_X32,				fXOR_X64,
	fINV_X8,			fINV_X16,				fINV_X32,				fINV_X64,

	fSHL_X8,			fSHL_X16,				fSHL_X32,				fSHL_X64,
	fSHR_X8,			fSHR_X16,				fSHR_X32,				fSHR_X64,

#ifdef USE_VM_BLOCKCOMMANDS
	// Blockmode variants
	fBCLR_X8,			fBCLR_X16,			fBCLR_X32,			fBCLR_X64,
	fBMOVE_X8,		fBMOVE_X16,			fBMOVE_X32,			fBMOVE_X64,
	fBADD_I8,			fBADD_I16,			fBADD_I32,			fBADD_I64,			fBADD_F32,			fBADD_F64,
	fBSUB_I8,			fBSUB_I16,			fBSUB_I32,			fBSUB_I64,			fBSUB_F32,			fBSUB_F64,
	fBMUL_I8,			fBMUL_I16,			fBMUL_I32,			fBMUL_I64,			fBMUL_F32,			fBMUL_F64,
	fBDIV_I8,			fBDIV_I16,			fBDIV_I32,			fBDIV_I64,			fBDIV_F32,			fBDIV_F64,
	fBMOD_I8,			fBMOD_I16,			fBMOD_I32,			fBMOD_I64,			fBMOD_F32,			fBMOD_F64,
	fBNEG_I8,			fBNEG_I16,			fBNEG_I32,			fBNEG_I64,			fBNEG_F32,			fBNEG_F64,
	fBSHL_I8,			fBSHL_I16,			fBSHL_I32,			fBSHL_I64,
	fBSHR_I8,			fBSHR_I16,			fBSHR_I32,			fBSHR_I64,
	fBAND_X8,			fBAND_X16,			fBAND_X32,			fBAND_X64,
	fBOR_X8,			fBOR_X16,				fBOR_X32,				fBOR_X64,
	fBXOR_X8,			fBXOR_X16,			fBXOR_X32,			fBXOR_X64,
	fBINV_X8,			fBINV_X16,			fBINV_X32,			fBINV_X64,
	fBSHL_X8,			fBSHL_X16,			fBSHL_X32,			fBSHL_X64,
	fBSHR_X8,			fBSHR_X16,			fBSHR_X32,			fBSHR_X64,
#endif
	0
};

VMCORE::OPFUNC VMCORE::sysTable[256] = {
	fSYS_OUT_U8,			fSYS_OUT_U16,				fSYS_OUT_U32,				fSYS_OUT_U64,
	fSYS_OUT_S8,			fSYS_OUT_S16,				fSYS_OUT_S32,				fSYS_OUT_S64,
	fSYS_OUT_F32,			fSYS_OUT_F64,				fSYS_OUT_STR,
	fSYS_INP_U8,			fSYS_INP_U16,				fSYS_INP_U32,				fSYS_INP_U64,
	fSYS_INP_S8,			fSYS_INP_S16,				fSYS_INP_S32,				fSYS_INP_S64,
	fSYS_INP_F32,			fSYS_INP_F64,				fSYS_INP_STR,
	fSYS_BRK,					fSYS_DUMP,					fSYS_VER,
	fSYS_NEW_X8,			fSYS_NEW_X16,				fSYS_NEW_X32,				fSYS_NEW_X64,
	fSYS_DEL_X8,			fSYS_DEL_X16,				fSYS_DEL_X32,				fSYS_DEL_X64,
	0
};

sint32 VMCORE::illegalDone = 0;

const char*	VMCORE::resultString[VMCORE::NUM_EXITCODES] =
{
	"Active",
	"Natural exit",
	"Divide by zero",
	"Stack overflow",
	"Stack underflow",
	"Method overflow",
	"Method underflow",
	"Reg stack overflow",
	"Reg stack underflow",
	"Illegal instruction",
	"Illegal addressing mode"
};

///////////////////////////////////////////////////////////////////////////////

void* VMCORE::IllegalAddress(EA_ARGS)
{
	cerr << "\n\nIllegal Address : inst " << (void*)(This->instPtr);
	fSYS_DUMP(This);
	This->exitReg = ILLEGAL_EATYPE;
	cerr << "\n";
	return This->imReg[0].Data64();
}

///////////////////////////////////////////////////////////////////////////////

void VMCORE::IllegalOpcode(OP_ARGS)
{
	cerr << "\n\nIllegal Opcode : inst " << (void*)(This->instPtr);
	fSYS_DUMP(This);
	cerr << "\n";
	This->exitReg = ILLEGAL_OPCODE;
}

///////////////////////////////////////////////////////////////////////////////

VMCORE::VMCORE() : countReg(0), exitReg(0), instPtr(0), dataSectPtr(0), constSectPtr(0),
									 methodStackBase(0), stackBase(0), regStackBase(0)
{
	for(sint32 i=0; i<32;i++)
		gpRegs[i].ValU64() = 0;
	imReg[0].ValU64() = 0;
	imReg[1].ValU64() = 0;

	// set up the undefined bytecodes to point to the appropriate 'illegal' handlers
	if (!illegalDone)
	{
		illegalDone = 1;
		sint32 i;
		for (i = VM::NUM_EA; i<256; i++)
			eaTable[i] = &IllegalAddress;
		for (i = VM::NUM_OPS; i<256; i++)
			instTable[i] = &IllegalOpcode;
		for (i = VM::NUM_SYS; i<256; i++)
			sysTable[i] = &IllegalOpcode;
	}
}

///////////////////////////////////////////////////////////////////////////////

VMCORE::~VMCORE()
{
	Free();
}

///////////////////////////////////////////////////////////////////////////////

sint32	VMCORE::Alloc(size_t stackSize, size_t methStackSize, size_t regStackSize)
{
	Free();
	if (methStackSize)
	{
		if (!(methodStackBase = new uint32*[methStackSize]))
			return ERR_NO_FREE_STORE;
		methodStackTop	= methodStackBase + methStackSize-1;
	}
	else
		methodStack = methodStackBase = methodStackTop = 0;

	if (stackSize)
	{
		if (!(stackBase = new uint8[stackSize]))
		{
			Free();
			return ERR_NO_FREE_STORE;
		}
		stackTop	= stackBase + stackSize-1;
	}
	else
		stack = stackBase = stackTop = 0;

	if (regStackSize)
	{
		if (!(regStackBase = new uint64[regStackSize]))
		{
			Free();
			return ERR_NO_FREE_STORE;
		}
		regStackTop = regStackBase+regStackSize-1;
	}
	else
		regStack = regStackBase = regStackTop = 0;
	return OK;
}

///////////////////////////////////////////////////////////////////////////////

void VMCORE::Free()
{
	if (methodStack)
		delete[] methodStackBase;
	if (stackBase)
		delete[] stackBase;
	if (regStackBase)
		delete[] regStackBase;
	vmObject = 0;
	methodStack = methodStackBase = methodStackTop = 0;
	stack = stackBase = stackTop = 0;
	regStack = regStackBase = regStackTop = 0;
}

///////////////////////////////////////////////////////////////////////////////

#if (X_ENDIAN == XA_BIGENDIAN)

void VMCORE::Execute(EX_ARGS)
{
	while (!This->exitReg && (xTHREADABLE::GotSignal(xTHREADABLE::SIGNAL_BREAK)==0))
	{
		iTab[*((uint8*)This->instPtr)](This);
	}
}

#else

void VMCORE::Execute(EX_ARGS)
{
	while (!This->exitReg)
	{
		iTab[((uint8*)This->instPtr)[3]](This);
	}
}

#endif

///////////////////////////////////////////////////////////////////////////////

uint32 VMCORE::Execute(VMOBJ& prog)
{
	if (Alloc(prog.Stack(), prog.MethodStack(), prog.RegisterStack())!=OK)
	{
		cerr << "VM Program initialization failed (not enough memory)\n";
		return 0;
	}
	vmObject			= &prog;
	instPtr				= prog.Code();
	dataSectPtr		= prog.Data();
	constSectPtr	= prog.Cnst();
	methodStack		= methodStackBase;
	stack					= stackBase;
	regStack			= regStackBase;
	exitReg				= 0;
	countReg			= 0;

	cout << "Executing VM code\n\n";
	Execute(this, instTable);

	if (exitReg!=END_OF_CODE)
		cout << "\nError in VM program : " << ExitResult() << " [" << (sint32)exitReg << "]\n";
	else
		cout << "\nExecution complete\n";
	return exitReg;
}

///////////////////////////////////////////////////////////////////////////////

