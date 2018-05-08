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
	#include <math.h>
}

#ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Seperate EA pass version, operand pointers saved in op[0] - op[2]
//
/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fADD_I8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].s8 = *jvm->op[0].s8 + *jvm->op[1].s8;
}

void JASMINE_OP::fADD_I16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].s16 = *jvm->op[0].s16 + *jvm->op[1].s16;
}

void JASMINE_OP::fADD_I32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].s32 = *jvm->op[0].s32 + *jvm->op[1].s32;
}

void JASMINE_OP::fADD_I64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].s64 = *jvm->op[0].s64 + *jvm->op[1].s64;
}

void JASMINE_OP::fADD_F32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].f32 = *jvm->op[0].f32 + *jvm->op[1].f32;
}

void JASMINE_OP::fADD_F64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].f64 = *jvm->op[0].f64 + *jvm->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSUB_I8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].s8 = *jvm->op[0].s8 - *jvm->op[1].s8;
}

void JASMINE_OP::fSUB_I16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].s16 = *jvm->op[0].s16 - *jvm->op[1].s16;
}

void JASMINE_OP::fSUB_I32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].s32 = *jvm->op[0].s32 - *jvm->op[1].s32;
}

void JASMINE_OP::fSUB_I64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].s64 = *jvm->op[0].s64 - *jvm->op[1].s64;
}

void JASMINE_OP::fSUB_F32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].f32 = *jvm->op[0].f32 - *jvm->op[1].f32;
}

void JASMINE_OP::fSUB_F64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].f64 = *jvm->op[0].f64 - *jvm->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fMUL_I8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].s8 = *jvm->op[0].s8 * *jvm->op[1].s8;
}

void JASMINE_OP::fMUL_I16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].s16 = *jvm->op[0].s16 * *jvm->op[1].s16;
}

void JASMINE_OP::fMUL_I32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].s32 = *jvm->op[0].s32 * *jvm->op[1].s32;
}

void JASMINE_OP::fMUL_I64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].s64 = *jvm->op[0].s64 * *jvm->op[1].s64;
}

void JASMINE_OP::fMUL_F32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].f32 = *jvm->op[0].f32 * *jvm->op[1].f32;
}

void JASMINE_OP::fMUL_F64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].f64 = *jvm->op[0].f64 * *jvm->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fDIV_I8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	if (*jvm->op[1].s8)
		*jvm->op[2].s8 = *jvm->op[0].s8 / *jvm->op[1].s8;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fDIV_I16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	if (*jvm->op[1].s16)
		*jvm->op[2].s16 = *jvm->op[0].s16 / *jvm->op[1].s16;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fDIV_I32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	if (*jvm->op[1].s32)
		*jvm->op[2].s32 = *jvm->op[0].s32 / *jvm->op[1].s32;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fDIV_I64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	if (*jvm->op[1].s64)
		*jvm->op[2].s64 = *jvm->op[0].s64 / *jvm->op[1].s64;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fDIV_F32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
		*jvm->op[2].f32 = *jvm->op[0].f32 / *jvm->op[1].f32;
}

void JASMINE_OP::fDIV_F64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
		*jvm->op[2].f64 = *jvm->op[0].f64 / *jvm->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fMOD_I8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	if (*jvm->op[1].s8)
		*jvm->op[2].s8 = *jvm->op[0].s8 % *jvm->op[1].s8;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fMOD_I16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	if (*jvm->op[1].s16)
		*jvm->op[2].s16 = *jvm->op[0].s16 % *jvm->op[1].s16;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fMOD_I32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	if (*jvm->op[1].s32)
		*jvm->op[2].s32 = *jvm->op[0].s32 % *jvm->op[1].s32;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fMOD_I64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	if (*jvm->op[1].s64)
		*jvm->op[2].s64 = *jvm->op[0].s64 % *jvm->op[1].s64;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fMOD_F32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].f32 = (float32)fmod(*jvm->op[0].f32, *jvm->op[1].f32);
}

void JASMINE_OP::fMOD_F64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].f64 = fmod(*jvm->op[0].f64, *jvm->op[1].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fMUL_U8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].u8 = *jvm->op[0].u8 * *jvm->op[1].u8;
}

void JASMINE_OP::fMUL_U16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].u16 = *jvm->op[0].u16 * *jvm->op[1].u16;
}

void JASMINE_OP::fMUL_U32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].u32 = *jvm->op[0].u32 * *jvm->op[1].u32;
}

void JASMINE_OP::fMUL_U64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].u64 = *jvm->op[0].u64 * *jvm->op[1].u64;
}

void JASMINE_OP::fDIV_U8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	if (*jvm->op[1].u8)
		*jvm->op[2].u8 = *jvm->op[0].u8 / *jvm->op[1].u8;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fDIV_U16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	if (*jvm->op[1].u16)
		*jvm->op[2].u16 = *jvm->op[0].u16 / *jvm->op[1].u16;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fDIV_U32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	if (*jvm->op[1].u32)
		*jvm->op[2].u32 = *jvm->op[0].u32 / *jvm->op[1].u32;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fDIV_U64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	if (*jvm->op[1].u64)
		*jvm->op[2].u64 = *jvm->op[0].u64 / *jvm->op[1].u64;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fMOD_U8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	if (*jvm->op[1].u8)
		*jvm->op[2].u8 = *jvm->op[0].u8 % *jvm->op[1].u8;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fMOD_U16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	if (*jvm->op[1].u16)
		*jvm->op[2].u16 = *jvm->op[0].u16 % *jvm->op[1].u16;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fMOD_U32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	if (*jvm->op[1].u32)
		*jvm->op[2].u32 = *jvm->op[0].u32 % *jvm->op[1].u32;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

void JASMINE_OP::fMOD_U64(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	if (*jvm->op[1].u64)
		*jvm->op[2].u64 = *jvm->op[0].u64 % *jvm->op[1].u64;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fNEG_I8(OP_ARGS)
{
	JASMINE_EA::D2_X8(jvm);
	*jvm->op[1].s8 = -(*jvm->op[0].s8);
}

void JASMINE_OP::fNEG_I16(OP_ARGS)
{
	JASMINE_EA::D2_X16(jvm);
	*jvm->op[1].s16 = -(*jvm->op[0].s16);
}

void JASMINE_OP::fNEG_I32(OP_ARGS)
{
	JASMINE_EA::D2_X32(jvm);
	*jvm->op[1].s32 = -(*jvm->op[0].s32);
}

void JASMINE_OP::fNEG_I64(OP_ARGS)
{
	JASMINE_EA::D2_X64(jvm);
	*jvm->op[1].s64 = -(*jvm->op[0].s64);
}

void JASMINE_OP::fNEG_F32(OP_ARGS)
{
	JASMINE_EA::D2_X32(jvm);
	*jvm->op[1].f32 = -(*jvm->op[0].f32);
}

void JASMINE_OP::fNEG_F64(OP_ARGS)
{
	JASMINE_EA::D2_X64(jvm);
	*jvm->op[1].f64 = -(*jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSHL_I8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].s8 = (*jvm->op[0].s8) << (*jvm->op[1].s8);
}

void JASMINE_OP::fSHL_I16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].s16 = (*jvm->op[0].s16) << (*jvm->op[1].s16);
}

void JASMINE_OP::fSHL_I32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].s32 = (*jvm->op[0].s32) << (*jvm->op[1].s32);
}

void JASMINE_OP::fSHL_I64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].s64 = (*jvm->op[0].s64) << (*jvm->op[1].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSHR_I8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].s8 = (*jvm->op[0].s8) >> (*jvm->op[1].s8);
}

void JASMINE_OP::fSHR_I16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].s16 = (*jvm->op[0].s16) >> (*jvm->op[1].s16);
}

void JASMINE_OP::fSHR_I32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].s32 = (*jvm->op[0].s32) >> (*jvm->op[1].s32);
}

void JASMINE_OP::fSHR_I64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].s64 = (*jvm->op[0].s64) >> (*jvm->op[1].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fADD_I8(OP_ARGS)
{
	OPINIT();
	OP3_8(sint8) = OP1_8(sint8) + OP2_8(sint8);
	OPDONE();
}

void JASMINE_OP::fADD_I16(OP_ARGS)
{
	OPINIT();
	OP3_16(sint16) = OP1_16(sint16) + OP2_16(sint16);
	OPDONE();
}

void JASMINE_OP::fADD_I32(OP_ARGS)
{
	OPINIT();
	OP3_32(sint32) = OP1_32(sint32) + OP2_32(sint32);
	OPDONE();
}

void JASMINE_OP::fADD_I64(OP_ARGS)
{
	OPINIT();
	OP3_64(sint64) = OP1_64(sint64) + OP2_64(sint64);
	OPDONE();
}

void JASMINE_OP::fADD_F32(OP_ARGS)
{
	OPINIT();
	OP3_32(float32) = OP1_32(float32) + OP2_32(float32);
	OPDONE();
}

void JASMINE_OP::fADD_F64(OP_ARGS)
{
	OPINIT();
	OP3_64(float64) = OP1_64(float64) + OP2_64(float64);
	OPDONE();
}


/////////////////////////////////////////////////////////////////////////////////////


void JASMINE_OP::fSUB_I8(OP_ARGS)
{
	OPINIT();
	OP3_8(sint8) = OP1_8(sint8) - OP2_8(sint8);
	OPDONE();
}

void JASMINE_OP::fSUB_I16(OP_ARGS)
{
	OPINIT();
	OP3_16(sint16) = OP1_16(sint16) - OP2_16(sint16);
	OPDONE();
}

void JASMINE_OP::fSUB_I32(OP_ARGS)
{
	OPINIT();
	OP3_32(sint32) = OP1_32(sint32) - OP2_32(sint32);
	OPDONE();
}

void JASMINE_OP::fSUB_I64(OP_ARGS)
{
	OPINIT();
	OP3_64(sint64) = OP1_64(sint64) - OP2_64(sint64);
	OPDONE();
}

void JASMINE_OP::fSUB_F32(OP_ARGS)
{
	OPINIT();
	OP3_32(float32) = OP1_32(float32) - OP2_32(float32);
	OPDONE();
}

void JASMINE_OP::fSUB_F64(OP_ARGS)
{
	OPINIT();
	OP3_64(float64) = OP1_64(float64) - OP2_64(float64);
	OPDONE();
}


/////////////////////////////////////////////////////////////////////////////////////


void JASMINE_OP::fMUL_I8(OP_ARGS)
{
	OPINIT();
	OP3_8(sint8) = OP1_8(sint8) * OP2_8(sint8);
	OPDONE();
}

void JASMINE_OP::fMUL_I16(OP_ARGS)
{
	OPINIT();
	OP3_16(sint16) = OP1_16(sint16) * OP2_16(sint16);
	OPDONE();
}

void JASMINE_OP::fMUL_I32(OP_ARGS)
{
	OPINIT();
	OP3_32(sint32) = OP1_32(sint32) * OP2_32(sint32);
	OPDONE();
}

void JASMINE_OP::fMUL_I64(OP_ARGS)
{
	OPINIT();
	OP3_64(sint64) = OP1_64(sint64) * OP2_64(sint64);
	OPDONE();
}

void JASMINE_OP::fMUL_F32(OP_ARGS)
{
	OPINIT();
	OP3_32(float32) = OP1_32(float32) * OP2_32(float32);
	OPDONE();
}

void JASMINE_OP::fMUL_F64(OP_ARGS)
{
	OPINIT();
	OP3_64(float64) = OP1_64(float64) * OP2_64(float64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fDIV_I8(OP_ARGS)
{
	OPINIT();
	sint8 d = OP1_8(sint8);
	if (d)
		OP3_8(sint8) = OP1_8(sint8) / d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fDIV_I16(OP_ARGS)
{
	OPINIT();
	sint16 d = OP1_16(sint16);
	if (d)
		OP3_16(sint16) = OP1_16(sint16) / d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fDIV_I32(OP_ARGS)
{
	OPINIT();
	sint32 d = OP1_32(sint32);
	if (d)
		OP3_32(sint32) = OP1_32(sint32) / d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fDIV_I64(OP_ARGS)
{
	OPINIT();
	sint64 d = OP1_64(sint64);
	if (d)
		OP3_64(sint64) = OP1_64(sint64) / d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fDIV_F32(OP_ARGS)
{
	OPINIT();
	OP3_32(float32) = OP1_32(float32) / OP2_32(float32);
	OPDONE();
}

void JASMINE_OP::fDIV_F64(OP_ARGS)
{
	OPINIT();
	OP3_64(float64) = OP1_64(float64) / OP2_64(float64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////


void JASMINE_OP::fMOD_I8(OP_ARGS)
{
	OPINIT();
	sint8 d = OP1_8(sint8);
	if (d)
		OP3_8(sint8) = OP1_8(sint8) % d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fMOD_I16(OP_ARGS)
{
	OPINIT();
	sint16 d = OP1_16(sint16);
	if (d)
		OP3_16(sint16) = OP1_16(sint16) % d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fMOD_I32(OP_ARGS)
{
	OPINIT();
	sint32 d = OP1_32(sint32);
	if (d)
		OP3_32(sint32) = OP1_32(sint32) % d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fMOD_I64(OP_ARGS)
{
	OPINIT();
	sint64 d = OP1_64(sint64);
	if (d)
		OP3_64(sint64) = OP1_64(sint64) % d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fMOD_F32(OP_ARGS)
{
	OPINIT();
	OP3_32(float32) = (float32) fmod(OP1_32(float32), OP2_32(float32));
	OPDONE();
}

void JASMINE_OP::fMOD_F64(OP_ARGS)
{
	OPINIT();
	OP3_64(float64) = fmod(OP1_64(float64), OP2_64(float64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fMUL_U8(OP_ARGS)
{
	OPINIT();
	OP3_8(uint8) = OP1_8(uint8) * OP2_8(uint8);
	OPDONE();
}

void JASMINE_OP::fMUL_U16(OP_ARGS)
{
	OPINIT();
	OP3_16(uint16) = OP1_16(uint16) * OP2_16(uint16);
	OPDONE();
}

void JASMINE_OP::fMUL_U32(OP_ARGS)
{
	OPINIT();
	OP3_32(uint32) = OP1_32(uint32) * OP2_32(uint32);
	OPDONE();
}

void JASMINE_OP::fMUL_U64(OP_ARGS)
{
	OPINIT();
	OP3_64(uint64) = OP1_64(uint64) * OP2_64(uint64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fDIV_U8(OP_ARGS)
{
	OPINIT();
	uint8 d = OP1_8(uint8);
	if (d)
		OP3_8(uint8) = OP1_8(uint8) / d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fDIV_U16(OP_ARGS)
{
	OPINIT();
	uint16 d = OP1_16(uint16);
	if (d)
		OP3_16(uint16) = OP1_16(uint16) / d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fDIV_U32(OP_ARGS)
{
	OPINIT();
	uint32 d = OP1_32(uint32);
	if (d)
		OP3_32(uint32) = OP1_32(uint32) / d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fDIV_U64(OP_ARGS)
{
	OPINIT();
	uint64 d = OP1_64(uint64);
	if (d)
		OP3_64(uint64) = OP1_64(uint64) / d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fMOD_U8(OP_ARGS)
{
	OPINIT();
	uint8 d = OP1_8(uint8);
	if (d)
		OP3_8(uint8) = OP1_8(uint8) % d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fMOD_U16(OP_ARGS)
{
	OPINIT();
	uint16 d = OP1_16(uint16);
	if (d)
		OP3_16(uint16) = OP1_16(uint16) % d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fMOD_U32(OP_ARGS)
{
	OPINIT();
	uint32 d = OP1_32(uint32);
	if (d)
		OP3_32(uint32) = OP1_32(uint32) % d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

void JASMINE_OP::fMOD_U64(OP_ARGS)
{
	OPINIT();
	uint64 d = OP1_64(uint64);
	if (d)
		OP3_64(uint64) = OP1_64(uint64) % d;
	else
		jvm->exitReg = JASMINE::MATH_DIVBYZERO;
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fNEG_I8(OP_ARGS)
{
	OPINIT();
	OP2D_8(sint8) = -(OP1_8(sint8));
	OPDONE();
}

void JASMINE_OP::fNEG_I16(OP_ARGS)
{
	OPINIT();
	OP2D_16(sint16) = -(OP1_16(sint16));
	OPDONE();
}

void JASMINE_OP::fNEG_I32(OP_ARGS)
{
	OPINIT();
	OP2D_32(sint32) = -(OP1_32(sint32));
	OPDONE();
}

void JASMINE_OP::fNEG_I64(OP_ARGS)
{
	OPINIT();
	OP2D_64(sint64) = -(OP1_64(sint64));
	OPDONE();
}

void JASMINE_OP::fNEG_F32(OP_ARGS)
{
	OPINIT();
	OP2D_32(float32) = -(OP1_32(float32));
	OPDONE();
}

void JASMINE_OP::fNEG_F64(OP_ARGS)
{
	OPINIT();
	OP2D_64(float64) = -(OP1_64(float64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSHL_I8(OP_ARGS)
{
	OPINIT();
	OP3_8(sint8) = OP1_8(sint8) << OP2_8(sint8);
	OPDONE();
}

void JASMINE_OP::fSHL_I16(OP_ARGS)
{
	OPINIT();
	OP3_16(sint16) = OP1_16(sint16) << OP2_16(sint16);
	OPDONE();
}

void JASMINE_OP::fSHL_I32(OP_ARGS)
{
	OPINIT();
	OP3_32(sint32) = OP1_32(sint32) << OP2_32(sint32);
	OPDONE();
}

void JASMINE_OP::fSHL_I64(OP_ARGS)
{
	OPINIT();
	OP3_64(sint64) = OP1_64(sint64) << OP2_64(sint16);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSHR_I8(OP_ARGS)
{
	OPINIT();
	OP3_8(sint8) = OP1_8(sint8) >> OP2_8(sint8);
	OPDONE();
}

void JASMINE_OP::fSHR_I16(OP_ARGS)
{
	OPINIT();
	OP3_16(sint16) = OP1_16(sint16) >> OP2_16(sint16);
	OPDONE();
}

void JASMINE_OP::fSHR_I32(OP_ARGS)
{
	OPINIT();
	OP3_32(sint32) = OP1_32(sint32) >> OP2_32(sint32);
	OPDONE();
}

void JASMINE_OP::fSHR_I64(OP_ARGS)
{
	OPINIT();
	OP3_64(sint64) = OP1_64(sint64) >> OP2_64(sint16);
	OPDONE();
}


/////////////////////////////////////////////////////////////////////////////////////

#endif // #ifndef JASMINE_MACRO_EA

