//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//


#include "VMClass.hpp"

#ifndef USE_HAND_ASM

void VMCORE::fNOP(CMDARGS)
{
	This->instPtr++;
}

void VMCORE::fBRK(CMDARGS)
{
	This->instPtr++;
}

void VMCORE::fEXIT(CMDARGS)
{
	This->exitReg = 1;
}

void VMCORE::fLEA(CMDARGS)
{
	This->instPtr++;
}

void VMCORE::fBRA(CMDARGS)
{
	This->instPtr += *((sint32*)++This->instPtr);
}

///////////////////////////////////////////////////////////////////////////////
//
//  Conditional branching infos
//
//  If a conditional branch is not taken, we must increment the
//  instruction stream pointer as it would otherwise point to
//  the offset value and not the subsequent instruction
//
///////////////////////////////////////////////////////////////////////////////

void VMCORE::fBNEQ_I8(CMDARGS)
{
	OPINIT();
	if (OP1(sint8) != 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBNEQ_I16(CMDARGS)
{
	OPINIT();
	if (OP1(sint16) != 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBNEQ_I32(CMDARGS)
{
	OPINIT();
	if (OP1(sint32) != 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBNEQ_I64(CMDARGS)
{
	OPINIT();
	if (OP1(sint64) != 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBNEQ_F32(CMDARGS)
{
	OPINIT();
	if (OP1(float32) != 0.0F)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBNEQ_F64(CMDARGS)
{
	OPINIT();
	if (OP1(float64) != 0.0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLS_I8(CMDARGS)
{
	OPINIT();
	if (OP1(sint8) < 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLS_I16(CMDARGS)
{
	OPINIT();
	if (OP1(sint16) < 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLS_I32(CMDARGS)
{
	OPINIT();
	if (OP1(sint32) < 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLS_I64(CMDARGS)
{
	OPINIT();
	if (OP1(sint64) < 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLS_F32(CMDARGS)
{
	OPINIT();
	if (OP1(float32) < 0.0F)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLS_F64(CMDARGS)
{
	OPINIT();
	if (OP1(float64) < 0.0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLSEQ_I8(CMDARGS)
{
	OPINIT();
	if (OP1(sint8) <= 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLSEQ_I16(CMDARGS)
{
	OPINIT();
	if (OP1(sint16) <= 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLSEQ_I32(CMDARGS)
{
	OPINIT();
	if (OP1(sint32) <= 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLSEQ_I64(CMDARGS)
{
	OPINIT();
	if (OP1(sint64) <= 0)
		This->instPtr += *((sint32*)++This->instPtr);
	else
		This->instPtr+=2;
}

void VMCORE::fBLSEQ_F32(CMDARGS)
{
	OPINIT();
	if (OP1(float32) <= 0F)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBLSEQ_F64(CMDARGS)
{
	OPINIT();
	if (OP1(float64) <= 0.0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBEQ_I8(CMDARGS)
{
	OPINIT();
	if (OP1(sint8) == 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBEQ_I16(CMDARGS)
{
	OPINIT();
	if (OP1(sint16) == 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBEQ_I32(CMDARGS)
{
	OPINIT();
	if (OP1(sint32) == 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBEQ_I64(CMDARGS)
{
	OPINIT();
	if (OP1(sint64) == 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBEQ_F32(CMDARGS)
{
	OPINIT();
	if (OP1(float32) == 0.0F)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBEQ_F64(CMDARGS)
{
	OPINIT();
	if (OP1(float64) == 0.0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGREQ_I8(CMDARGS)
{
	OPINIT();
	if (OP1(sint8) >= 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGREQ_I16(CMDARGS)
{
	OPINIT();
	if (OP1(sint16) >= 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGREQ_I32(CMDARGS)
{
	OPINIT();
	if (OP1(sint32) >= 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGREQ_I64(CMDARGS)
{
	OPINIT();
	if (OP1(sint64) >= 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGREQ_F32(CMDARGS)
{
	OPINIT();
	if (OP1(float32) >= 0.0F)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGREQ_F64(CMDARGS)
{
	OPINIT();
	if (OP1(float64) >= 0.0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGR_I8(CMDARGS)
{
	OPINIT();
	if (OP1(sint8) > 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGR_I16(CMDARGS)
{
	OPINIT();
	if (OP1(sint16) > 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGR_I32(CMDARGS)
{
	OPINIT();
	if (OP1(sint32) > 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGR_I64(CMDARGS)
{
	OPINIT();
	if (OP1(sint64) > 0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGR_F32(CMDARGS)
{
	OPINIT();
	if (OP1(float32) > 0.0F)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fBGR_F64(CMDARGS)
{
	OPINIT();
	if (OP1(float64) > 0.0)
	{
		This->instPtr += *((sint32*)++This->instPtr);
		return;
	}
	This->instPtr+=2;
}

void VMCORE::fJSR(CMDARGS)
{
	OPINIT();
	ruint32* dest = POP1(uint32);
	*(This->branchStack++) = ++This->instPtr;
	This->instPtr = dest;
}

void VMCORE::fRTS(CMDARGS)
{
	if (This->branchStack>This->branchStackBase)
		This->instPtr = *(--This->branchStack);
	else
		This->exitReg = -1;
}

#endif