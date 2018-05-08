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

void VMCORE::fNOP(OP_ARGS)
{
	This->instPtr++;
}

void VMCORE::fEND(OP_ARGS)
{
	This->exitReg = END_OF_CODE;
}

void VMCORE::fLEA(OP_ARGS)
{
	// source must be non reg-direct EA
	// dest must be reg direct
	Decode2(This,1,8);
	This->op[1].reg->PtrU8() = This->op[0].u8;
}

void VMCORE::fBRA(OP_ARGS)
{
	This->instPtr += *((sint32*)++This->instPtr);
}

///////////////////////////////////////////////////////////////////////////////
//
//  Conditional branching infos
//
///////////////////////////////////////////////////////////////////////////////

void VMCORE::fBNEQ_I8(OP_ARGS)
{
	Decode2C_X8(This);
	if (*This->op[0].s8!=*This->op[1].s8)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBNEQ_I16(OP_ARGS)
{
	Decode2C_X16(This);
	if (*This->op[0].s16!=*This->op[1].s16)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBNEQ_I32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].s32!=*This->op[1].s32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBNEQ_I64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].s64!=*This->op[0].s64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBNEQ_F32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].f32!=*This->op[1].f32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBNEQ_F64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].f64!=*This->op[1].f64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLS_I8(OP_ARGS)
{
	Decode2C_X8(This);
	if (*This->op[0].s8<*This->op[1].s8)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLS_I16(OP_ARGS)
{
	Decode2C_X16(This);
	if (*This->op[0].s16<*This->op[1].s16)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLS_I32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].s32<*This->op[1].s32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLS_I64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].s64<*This->op[1].s64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLS_F32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].f32<*This->op[1].f32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLS_F64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].f64<*This->op[1].f64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLSEQ_I8(OP_ARGS)
{
	Decode2C_X8(This);
	if (*This->op[0].s8<=*This->op[1].s8)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLSEQ_I16(OP_ARGS)
{
	Decode2C_X16(This);
	if (*This->op[0].s16<=*This->op[1].s16)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLSEQ_I32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].s32<=*This->op[1].s32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLSEQ_I64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].s64<=*This->op[1].s64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLSEQ_F32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].f32<=*This->op[1].f32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBLSEQ_F64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].f64<=*This->op[0].f64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBEQ_I8(OP_ARGS)
{
	Decode2C_X8(This);
	if (*This->op[0].s8==*This->op[1].s8)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBEQ_I16(OP_ARGS)
{
	Decode2C_X16(This);
	if (*This->op[0].s16==*This->op[1].s16)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBEQ_I32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].s32==*This->op[1].s32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBEQ_I64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].s64==*This->op[1].s64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBEQ_F32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].f32==*This->op[1].f32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBEQ_F64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].f64==*This->op[1].f64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGREQ_I8(OP_ARGS)
{
	Decode2C_X8(This);
	if (*This->op[0].s8>=*This->op[1].s8)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGREQ_I16(OP_ARGS)
{
	Decode2C_X16(This);
	if (*This->op[0].s16>=*This->op[1].s16)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGREQ_I32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].s32>=*This->op[1].s32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGREQ_I64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].s64>=*This->op[1].s64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGREQ_F32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].f32>=*This->op[1].f32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGREQ_F64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].f64>=*This->op[1].f64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGR_I8(OP_ARGS)
{
	Decode2C_X8(This);
	if (*This->op[0].s8>*This->op[1].s8)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGR_I16(OP_ARGS)
{
	Decode2C_X16(This);
	if (*This->op[0].s16>*This->op[1].s16)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGR_I32(OP_ARGS)
{
	Decode2C_X32(This);
	if (*This->op[0].s32>*This->op[1].s32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGR_I64(OP_ARGS)
{
	Decode2C_X64(This);
	if (*This->op[0].s64>*This->op[1].s64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGR_F32(OP_ARGS)
{
	Decode1_X32(This);
	if (*This->op[0].f32>*This->op[1].f32)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fBGR_F64(OP_ARGS)
{
	Decode1_X64(This);
	if (*This->op[0].f64>*This->op[1].f64)
		This->instPtr += *((sint32*)This->instPtr);
	else
		This->instPtr++;
}

void VMCORE::fCALL(OP_ARGS)
{
	if (This->methodStack<This->methodStackTop)
	{
		Decode1_X32(This);
		*(This->methodStack++) = This->instPtr;
		This->instPtr = This->op[0].u32;
	}
	else
		This->exitReg = METHD_OVERFLOW;
}

void VMCORE::fRET(OP_ARGS)
{
	if (This->methodStack>This->methodStackBase)
		This->instPtr = *(--This->methodStack);
	else
		This->exitReg = METHD_UNDERFLOW;
}
