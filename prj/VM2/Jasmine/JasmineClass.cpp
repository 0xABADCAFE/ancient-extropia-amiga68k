//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "Jasmine.hpp"

extern "C" {
	#include <stddef.h>
}

sint32 JASMINE::illegalDone = 0;

void* JASMINE_EA::IllegalAddress(EA_ARGS)
{
	#ifdef JASMINE_DEBUG_ENABLE
	printf("\n\nIllegal Address : inst %p\n", (void*)(jvm->instPtr));
	#ifdef XP_AMIGAOS
	JASMINE_OP::fSYS_DUMP(jvm, eaTable);
	#else
	JASMINE_OP::fSYS_DUMP(jvm);
	#endif
	#endif
	jvm->exitReg = JASMINE::ILLEGAL_EATYPE;
	return jvm->imReg[0].Data64();
}

///////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::IllegalOpcode(OP_ARGS)
{
	#ifdef JASMINE_DEBUG_ENABLE
	printf("\n\nIllegal Opcode : 0x%8X\n", *(jvm->instPtr));
	#ifdef XP_AMIGAOS
	JASMINE_OP::fSYS_DUMP(jvm, pf);
	#else
	JASMINE_OP::fSYS_DUMP(jvm);
	#endif
	#endif
	jvm->exitReg = JASMINE::ILLEGAL_OPCODE;
}

///////////////////////////////////////////////////////////////////////////////

JASMINE::JASMINE() : countReg(0), exitReg(0), instPtr(0), dataSectPtr(0), constSectPtr(0),
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
			JASMINE_EA::eaTable[i] = &JASMINE_EA::IllegalAddress;
		for (i = VM::NUM_OPS; i<256; i++)
			JASMINE_OP::instTable[i] = &JASMINE_OP::IllegalOpcode;
		for (i = VM::NUM_SYS; i<256; i++)
			JASMINE_OP::sysTable[i] = &JASMINE_OP::IllegalOpcode;
	}
}

///////////////////////////////////////////////////////////////////////////////

JASMINE::~JASMINE()
{
	Free();
}

///////////////////////////////////////////////////////////////////////////////

sint32	JASMINE::Alloc(size_t stackSize, size_t methStackSize, size_t regStackSize)
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
		if (!(stackBase = new uint8[(stackSize<<1)]))
		{
			Free();
			return ERR_NO_FREE_STORE;
		}
		stackTrace = stackBase + stackSize;
		stackTop	= stackTrace-1;
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

void JASMINE::Free()
{
	if (methodStack)
		delete[] methodStackBase;
	if (stackBase)
		delete[] stackBase;
	if (regStackBase)
		delete[] regStackBase;
	vmObject = 0;
	methodStack = methodStackBase = methodStackTop = 0;
	stackTrace = stack = stackBase = stackTop = 0;
	regStack = regStackBase = regStackTop = 0;
}

///////////////////////////////////////////////////////////////////////////////

#ifndef JASMINE_HANDCODED

#if (X_ENDIAN == XA_BIGENDIAN)

#ifdef XP_AMIGAOS

void JASMINE::Execute(EX_ARGS)
{
	JASMINE_EA::Handler* eaTab = JASMINE_EA::eaTable;
	while (!This->exitReg)
	{
		#ifdef JASMINE_BREAK_DETECT_ALWAYS
		if (!xTHREADABLE::GotSignal(xTHREADABLE::SIGNAL_BREAK))
			iTab[*((uint8*)This->instPtr)](This, eaTab);
		else
			This->exitReg = USER_BREAK;
		#else
		iTab[*((uint8*)This->instPtr)](This, eaTab);
		#endif
	}
}

#else // XP_AMIGAOS

void JASMINE::Execute(EX_ARGS)
{
	while (!This->exitReg)
	{
		iTab[*((uint8*)This->instPtr)](This);
	}
}

#endif // XP_AMIGAOS

#else // X_ENDIAN

void JASMINE::Execute(EX_ARGS)
{
	while (!This->exitReg)
	{
		iTab[((uint8*)This->instPtr)[3]](This);
	}
}

#endif // X_ENDIAN

#endif // JASMINE_HANDCODED

///////////////////////////////////////////////////////////////////////////////

uint32 JASMINE::Execute(JASMINEOBJECT& prog)
{
	if (Alloc(prog.Stack(), prog.MethodStack(), prog.RegisterStack())!=OK)
	{
		puts("VM Program initialization failed (not enough memory)");
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

	//puts("Executing VM code\n");
	#ifdef JASMINE_HANDCODED
	Execute(this);
	#else
	Execute(this, JASMINE_OP::instTable);
	#endif

	if (exitReg!=END_OF_CODE)
		printf("\nError in VM program : %s [%d]\n", ExitResult(), (sint32)exitReg);
/*
	else
		puts("\nExecution complete");
*/
	return exitReg;
}

///////////////////////////////////////////////////////////////////////////////

sint32 JASMINE::GetPC()
{
	if (vmObject && vmObject->Code()!=0)
		return (sint32)(instPtr - vmObject->Code());
	return -1;
}

///////////////////////////////////////////////////////////////////////////////

sint32	JASMINE::PushRegs(JCLASSP, VLDREG1 sint32 first, VLDREG2 sint32 num)
{
	if (num>=0)
	{
		num++;
		if (This->regStack+num < This->regStackTop)
		{
			ruint32* rp = (uint32*)(&This->gpRegs[first]);
			while(num--)
			{
				*(((uint32*)This->regStack)++) = *rp++;
				*(((uint32*)This->regStack)++) = *rp++;
			}
			return 0;
		}
		else
			return REGS_OVERFLOW;
	}
	else
	{
		num = 1-num;
		if (This->regStack+num < This->regStackTop)
		{
			ruint32* rp = (uint32*)(&This->gpRegs[first]);
			while(num--)
			{
				*(((uint32*)This->regStack)++) = rp[0];//*(--rp);
				*(((uint32*)This->regStack)++) = rp[1];//*(--rp);
				rp-=2;
			}
			return 0;
		}
		else
			return REGS_OVERFLOW;
	}
}

///////////////////////////////////////////////////////////////////////////////

sint32	JASMINE::PopRegs(JCLASSP, VLDREG1 sint32 first, VLDREG2 sint32 num)
{
	if (num>=0)
	{
		num++;
		if (This->regStack-num >= This->regStackBase)
		{
			ruint32* rp = (uint32*)(&This->gpRegs[first+num]);
			while(num--)
			{
				*(--rp) = *(--((uint32*)This->regStack));
				*(--rp) = *(--((uint32*)This->regStack));
			}
			return 0;
		}
		else
			return REGS_UNDERFLOW;
	}
	else
	{
		first += num;
		num = 1-num;
		if (This->regStack-num >= This->regStackBase)
		{
			ruint32* rp = (uint32*)(&This->gpRegs[first]);
			while(num--)
			{
				--This->regStack;
				*rp++ = ((uint32*)This->regStack)[0];//*(--((uint32*)This->regStack));
				*rp++ = ((uint32*)This->regStack)[1];//*(--((uint32*)This->regStack));
			}
			return 0;
		}
		else
			return REGS_UNDERFLOW;
	}
}

///////////////////////////////////////////////////////////////////////////////

void JASMINE::GenInclude()
{
/*
		}	gpRegs[32];
		GPR	imReg[2];
		uint32* 	instPtr;
		union {
			uint8* u8;			uint16* u16;			uint32* u32;			uint64* u64;
			sint8* s8;			sint16* s16;			sint32* s32;			sint64* s64;
			float32* f32;		float64* f64;			char*		ch;				wchar_t* wch;
			void*		any;		GPR* reg;
		} op[3];
		uint64*		regStack;
		uint8*		stack;
		uint32**	methodStack;
		void*			dataSectPtr;
		void*			constSectPtr;
		uint32		exitReg;
		sint32		countReg;
		uint32		machineReg;

	printf ("JASMINE_gpRegs EQU $%X\n", offsetof(JASMINE,gpRegs[0]));
	printf ("JASMINE_imReg_0 EQU $%X\n", offsetof(JASMINE,imReg[0]));
	printf ("JASMINE_imReg_1 EQU $%X\n", offsetof(JASMINE,imReg[1]));
	printf ("JASMINE_op_0 EQU $%X\n", offsetof(JASMINE,op[0]));
	printf ("JASMINE_op_1 EQU $%X\n", offsetof(JASMINE,op[1]));
	printf ("JASMINE_op_2 EQU $%X\n", offsetof(JASMINE,op[2]));
	printf ("JASMINE_regStack EQU $%X\n", offsetof(JASMINE,regStack));
	printf ("JASMINE_stack EQU $%X\n", offsetof(JASMINE,stack));
	printf ("JASMINE_methodStack EQU $%X\n", offsetof(JASMINE,methodStack));
	printf ("JASMINE_dataSectPtr EQU $%X\n", offsetof(JASMINE,dataSectPtr));
	printf ("JASMINE_constSectPtr EQU $%X\n", offsetof(JASMINE,constSectPtr));
	printf ("JASMINE_exitReg EQU $%X\n", offsetof(JASMINE,exitReg));
	printf ("JASMINE_countReg EQU $%X\n", offsetof(JASMINE,countReg));
	printf ("JASMINE_machineReg EQU $%X\n", offsetof(JASMINE,machineReg));
*/
}