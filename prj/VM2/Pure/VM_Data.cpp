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

void VMCORE::fPUSH_X8(OP_ARGS)
{
	if (This->stack+VM_STACK_SIZE_X8 < This->stackTop)
	{
		Decode1_X8(This);
		*This->stack = *This->op[0].u8;
		This->stack += VM_STACK_SIZE_X8;
	}
	else
		This->exitReg = STACK_OVERFLOW;
}

void VMCORE::fPUSH_X16(OP_ARGS)
{
	if (This->stack+VM_STACK_SIZE_X16 < This->stackTop)
	{
		Decode1_X16(This);
		*((uint16*)This->stack) = *This->op[0].u16;
		This->stack += VM_STACK_SIZE_X16;
	}
	else
		This->exitReg = STACK_OVERFLOW;
}

void VMCORE::fPUSH_X32(OP_ARGS)
{
	if (This->stack+VM_STACK_SIZE_X32 < This->stackTop)
	{
		Decode1_X32(This);
		*((uint32*)This->stack) = *This->op[0].u32;
		This->stack += VM_STACK_SIZE_X32;
	}
	else
		This->exitReg = STACK_OVERFLOW;
}

void VMCORE::fPUSH_X64(OP_ARGS)
{
	if (This->stack+VM_STACK_SIZE_X64 < This->stackTop)
	{
		Decode1_X64(This);
		*((uint64*)This->stack) = *This->op[0].u64;
		This->stack += VM_STACK_SIZE_X64;
	}
	else
		This->exitReg = STACK_OVERFLOW;
}

void VMCORE::fPOP_X8(OP_ARGS)
{
	if (This->stack+VM_STACK_SIZE_X8 > This->stackBase)
	{
		Decode1_X8(This);
		This->stack -= VM_STACK_SIZE_X8;
		*This->op[0].u8 = *This->stack;
	}
	else
		This->exitReg = STACK_UNDERFLOW;
}

void VMCORE::fPOP_X16(OP_ARGS)
{
	if (This->stack+VM_STACK_SIZE_X16 > This->stackBase)
	{
		Decode1_X16(This);
		This->stack -= VM_STACK_SIZE_X16;
		*This->op[0].u16 = *((uint16*)This->stack);
	}
	else
		This->exitReg = STACK_UNDERFLOW;
}

void VMCORE::fPOP_X32(OP_ARGS)
{
	if (This->stack+VM_STACK_SIZE_X32 > This->stackBase)
	{
		Decode1_X32(This);
		This->stack -= VM_STACK_SIZE_X32;
		*This->op[0].u32 = *((uint32*)This->stack);
	}
	else
		This->exitReg = STACK_UNDERFLOW;
}

void VMCORE::fPOP_X64(OP_ARGS)
{
	if (This->stack+VM_STACK_SIZE_X64 > This->stackBase)
	{
		Decode1_X64(This);
		This->stack -= VM_STACK_SIZE_X64;
		*This->op[0].u64 = *((uint64*)This->stack);
	}
	else
		This->exitReg = STACK_UNDERFLOW;
}

#if (X_ENDIAN == XA_BIGENDIAN)

void VMCORE::fPUSHREGS(OP_ARGS)
{
	sint32 first	= (((sint8*)This->instPtr)[1])/*&0x1F*/;
	sint32 num		= (((sint8*)This->instPtr)[2])/*&0x1F*/ - first;
	This->instPtr++;
	if (num>=0)
	{
		//cout << "PUSHREGS : " << first << "-" << first+num << "\n";
		num++;
		if (This->regStack+num < This->regStackTop)
		{
			ruint32* rp = (uint32*)(&This->gpRegs[first]);
			while(num--)
			{
				*(((uint32*)This->regStack)++) = *rp++;
				*(((uint32*)This->regStack)++) = *rp++;
			}
		}
		else
			This->exitReg = REGS_OVERFLOW;
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
		}
		else
			This->exitReg = REGS_OVERFLOW;
	}
}

void VMCORE::fPOPREGS(OP_ARGS)
{
	sint32 first	= (((sint8*)This->instPtr)[1])/*&0x1F*/;
	sint32 num		= (((sint8*)This->instPtr)[2])/*&0x1F*/ - first;
	This->instPtr++;
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
		}
		else
			This->exitReg = REGS_UNDERFLOW;
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
		}
		else
			This->exitReg = REGS_UNDERFLOW;
	}
}

#else


void VMCORE::fPUSHREGS(OP_ARGS)
{
	sint32 first	= (((sint8*)This->instPtr)[2])/*&0x1F*/;
	sint32 num		= (((sint8*)This->instPtr)[1])/*&0x1F*/ - first;
	This->instPtr++;
	if (num>=0)
	{
		//cout << "PUSHREGS : " << first << "-" << first+num << "\n";
		num++;
		if (This->regStack+num < This->regStackTop)
		{
			ruint64* rp = (uint64*)(&This->gpRegs[first]);
			while(num--)
				*This->regStack++ = *rp++;
		}
		else
			This->exitReg = REGS_OVERFLOW;
	}
	else
	{
		num = 1-num;
		if (This->regStack+num < This->regStackTop)
		{
			ruint64* rp = (uint64*)(&This->gpRegs[first+1]);
			while(num--)
				*This->regStack++ = *(--rp);
		}
		else
			This->exitReg = REGS_OVERFLOW;
	}
}

void VMCORE::fPOPREGS(OP_ARGS)
{
	sint32 first	= (((sint8*)This->instPtr)[2])/*&0x1F*/;
	sint32 num		= (((sint8*)This->instPtr)[1])/*&0x1F*/ - first;
	This->instPtr++;
	if (num>=0)
	{
		num++;
		if (This->regStack-num >= This->regStackBase)
		{
			ruint64* rp = (uint64*)(&This->gpRegs[first+num]);
			while(num--)
				*(--rp) = *(--This->regStack);
		}
		else
			This->exitReg = REGS_UNDERFLOW;
	}
	else
	{
		first += num;
		num = 1-num;
		if (This->regStack-num >= This->regStackBase)
		{
			ruint64* rp = (uint64*)(&This->gpRegs[first]);
			while(num--)
				*rp++ = *(--This->regStack);
		}
		else
			This->exitReg = REGS_UNDERFLOW;
	}
}

#endif

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fCLR_X8(OP_ARGS)
{
	Decode1_X8(This);
	*This->op[0].u8 = 0;
}

void VMCORE::fCLR_X16(OP_ARGS)
{
	Decode1_X16(This);
	*This->op[0].u16 = 0;
}

void VMCORE::fCLR_X32(OP_ARGS)
{
	Decode1_X32(This);
	*This->op[0].u32 = 0;
}

void VMCORE::fCLR_X64(OP_ARGS)
{
	Decode1_X64(This);
	*This->op[0].u64 = 0;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fMOVE_X8(OP_ARGS)
{
	Decode2_X8(This);
	*This->op[1].u8 = *This->op[0].u8;
}

void VMCORE::fMOVE_X16(OP_ARGS)
{
	Decode2_X16(This);
	*This->op[1].u16 = *This->op[0].u16;
}

void VMCORE::fMOVE_X32(OP_ARGS)
{
	Decode2_X32(This);
	*This->op[1].u32 = *This->op[0].u32;
}

void VMCORE::fMOVE_X64(OP_ARGS)
{
	Decode2_X64(This);
	*This->op[1].u64 = *This->op[0].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void	VMCORE::fENDIAN_X16(OP_ARGS)
{
	Decode2_X16(This);
	(This->op[1].u8)[0] = (This->op[0].u8)[1];
	(This->op[1].u8)[1] = (This->op[0].u8)[0];
}

void	VMCORE::fENDIAN_X32(OP_ARGS)
{
	Decode2_X32(This);
	{
		ruint8* d = This->op[1].u8;
		ruint8* s = (This->op[0].u8)+8;
		*d++ = *(--s);
		*d++ = *(--s);
		*d++ = *(--s);
		*d = *(--s);
	}
}

void	VMCORE::fENDIAN_X64(OP_ARGS)
{
	Decode2_X64(This);
	{
		ruint8* d = This->op[1].u8;
		ruint8* s = (This->op[0].u8)+8;
		*d++ = *(--s);
		*d++ = *(--s);
		*d++ = *(--s);
		*d++ = *(--s);
		*d++ = *(--s);
		*d++ = *(--s);
		*d++ = *(--s);
		*d = *(--s);
	}
}

/////////////////////////////////////////////////////////////////////////////////////

void	VMCORE::fSWAP_X8(OP_ARGS)
{
	Decode2_X8(This);
	ruint8 temp = *This->op[1].u8;
	*This->op[1].u8 = *This->op[0].u8;
	*This->op[0].u8 = temp;
}

void	VMCORE::fSWAP_X16(OP_ARGS)
{
	Decode2_X16(This);
	ruint16 temp = *This->op[1].u16;
	*This->op[1].u16 = *This->op[0].u16;
	*This->op[0].u16 = temp;
}

void	VMCORE::fSWAP_X32(OP_ARGS)
{
	Decode2_X32(This);
	ruint32 temp = *This->op[1].u32;
	*This->op[1].u32 = *This->op[0].u32;
	*This->op[0].u32 = temp;
}

void	VMCORE::fSWAP_X64(OP_ARGS)
{
	Decode2_X64(This);
	uint64 temp = *This->op[1].u64;
	*This->op[1].u64 = *This->op[0].u64;
	*This->op[0].u64 = temp;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI8TOI16(OP_ARGS)
{
	Decode2(This, 1,2);
	*This->op[1].s16 = *This->op[0].s8;
}

void VMCORE::fI8TOI32(OP_ARGS)
{
	Decode2(This, 1,4);
	*This->op[1].s32 = *This->op[0].s8;
}

void VMCORE::fI8TOI64(OP_ARGS)
{
	Decode2(This, 1,8);
	*This->op[1].s64 = *This->op[0].s8;
}

void VMCORE::fI8TOF32(OP_ARGS)
{
	Decode2(This, 1,4);
	*This->op[1].f32 = (float32)(*This->op[0].s8);
}

void VMCORE::fI8TOF64(OP_ARGS)
{
	Decode2(This, 1,8);
	*This->op[1].f64 = (float64)(*This->op[0].s8);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI16TOI32(OP_ARGS)
{
	Decode2(This, 2,4);
	*This->op[1].s32 = *This->op[0].s16;
}

void VMCORE::fI16TOI64(OP_ARGS)
{
	Decode2(This, 2,8);
	*This->op[1].s64 = *This->op[0].s16;
}

void VMCORE::fI16TOF32(OP_ARGS)
{
	Decode2(This, 2,4);
	*This->op[1].f32 = (float32)(*This->op[0].s16);
}

void VMCORE::fI16TOF64(OP_ARGS)
{
	Decode2(This, 2,8);
	*This->op[1].f64 = (float64)(*This->op[0].s16);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI32TOI64(OP_ARGS)
{
	Decode2(This, 4,8);
	*This->op[1].s64 = *This->op[0].s32;
}

void VMCORE::fI32TOF32(OP_ARGS)
{
	Decode2_X32(This);
	*This->op[1].f32 = (float32)(*This->op[0].s32);
}

void VMCORE::fI32TOF64(OP_ARGS)
{
	Decode2(This, 4,8);
	*This->op[1].f64 = (float64)(*This->op[0].s32);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI64TOF32(OP_ARGS)
{
	Decode2(This, 8,4);
	*This->op[1].f32 = (float32)(*This->op[0].s64);
}

void VMCORE::fI64TOF64(OP_ARGS)
{
	Decode2_X64(This);
	*This->op[1].f64 = (float64)(*This->op[0].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fF32TOF64(OP_ARGS)
{
	Decode2(This, 4,8);
	*This->op[1].s64 = (sint64)(*This->op[0].f32);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fF64TOF32(OP_ARGS)
{
	Decode2(This, 8,4);
	*This->op[1].f32 = (float32)(*This->op[0].f64);
}

void VMCORE::fF64TOI64(OP_ARGS)
{
	Decode2_X64(This);
	*This->op[1].s64 = (sint64)(*This->op[0].f64);
}

void VMCORE::fF64TOI32(OP_ARGS)
{
	Decode2(This, 8,4);
	*This->op[1].s32 = (sint32)(*This->op[0].f64);
}

void VMCORE::fF64TOI16(OP_ARGS)
{
	Decode2(This, 8,2);
	*This->op[1].s16 = (sint16)(*This->op[0].f64);
}

void VMCORE::fF64TOI8(OP_ARGS)
{
	Decode2(This, 8,1);
	*This->op[1].s8 = (sint8)(*This->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fF32TOI64(OP_ARGS)
{
	Decode2(This, 4,8);
	*This->op[1].s64 = (sint16)(*This->op[0].f32);
}

void VMCORE::fF32TOI32(OP_ARGS)
{
	Decode2_X32(This);
	*This->op[1].s32 = (sint32)(*This->op[0].f32);
}

void VMCORE::fF32TOI16(OP_ARGS)
{
	Decode2(This, 4,2);
	*This->op[1].s16 = (sint16)(*This->op[0].f32);
}

void VMCORE::fF32TOI8(OP_ARGS)
{
	Decode2(This, 4,1);
	*This->op[1].s8 = (sint8)(*This->op[0].f32);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI64TOI32(OP_ARGS)
{
	Decode2(This, 8,4);
	*This->op[1].s32 = (sint32)(*This->op[0].s64);
}

void VMCORE::fI64TOI16(OP_ARGS)
{
	Decode2(This, 8,2);
	*This->op[1].s16 = (sint16)(*This->op[0].s64);
}

void VMCORE::fI64TOI8(OP_ARGS)
{
	Decode2(This, 8,1);
	*This->op[1].s8 = (sint8)(*This->op[0].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI32TOI16(OP_ARGS)
{
	Decode2(This, 4,2);
	*This->op[1].s16 = (sint16)(*This->op[0].s32);
}

void VMCORE::fI32TOI8(OP_ARGS)
{
	Decode2(This, 4,1);
	*This->op[1].s8 = (sint8)(*This->op[0].s32);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI16TOI8(OP_ARGS)
{
	Decode2(This, 2,1);
	*This->op[1].s8 = (sint8)(*This->op[0].s16);
}

#ifdef USE_VM_BLOCKCOMMANDS
void VMCORE::fBCLR_X8(OP_ARGS){}
void VMCORE::fBCLR_X16(OP_ARGS){}
void VMCORE::fBCLR_X32(OP_ARGS){}
void VMCORE::fBCLR_X64(OP_ARGS){}
void VMCORE::fBMOVE_X8(OP_ARGS){}
void VMCORE::fBMOVE_X16(OP_ARGS){}
void VMCORE::fBMOVE_X32(OP_ARGS){}
void VMCORE::fBMOVE_X64(OP_ARGS){}
#endif
