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


#ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Seperate EA pass version, operand pointers saved in op[0] - op[2]
//
/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI16_S8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,2);
	*jvm->op[1].s16 = *jvm->op[0].s8;
}

void JASMINE_OP::f32_S8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,4);
	*jvm->op[1].s32 = *jvm->op[0].s8;
}

void JASMINE_OP::fI64_S8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,8);
	*jvm->op[1].s64 = *jvm->op[0].s8;
}

void JASMINE_OP::fF32_S8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,4);
	*jvm->op[1].f32 = (float32)(*jvm->op[0].s8);
}

void JASMINE_OP::fF64_S8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,8);
	*jvm->op[1].f64 = (float64)(*jvm->op[0].s8);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI32_S16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,4);
	*jvm->op[1].s32 = *jvm->op[0].s16;
}

void JASMINE_OP::fI64_S16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,8);
	*jvm->op[1].s64 = *jvm->op[0].s16;
}

void JASMINE_OP::fF32_S16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,4);
	*jvm->op[1].f32 = (float32)(*jvm->op[0].s16);
}

void JASMINE_OP::fF64_S16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,8);
	*jvm->op[1].f64 = (float64)(*jvm->op[0].s16);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI64_S32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,8);
	*jvm->op[1].s64 = *jvm->op[0].s32;
}

void JASMINE_OP::fF32_S32(OP_ARGS)
{
	JASMINE_EA::D2_X32(jvm);
	*jvm->op[1].f32 = (float32)(*jvm->op[0].s32);
}

void JASMINE_OP::fF64_S32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,8);
	*jvm->op[1].f64 = (float64)(*jvm->op[0].s32);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fF32_S64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,4);
	*jvm->op[1].f32 = (float32)(*jvm->op[0].s64);
}

void JASMINE_OP::fF64_S64(OP_ARGS)
{
	JASMINE_EA::D2_X64(jvm);
	*jvm->op[1].f64 = (float64)(*jvm->op[0].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fS64_F64(OP_ARGS)
{
	JASMINE_EA::D2_X64(jvm);
	*jvm->op[1].s64 = (sint64)(*jvm->op[0].f64);
}

void JASMINE_OP::fS32_F64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,4);
	*jvm->op[1].s32 = (sint32)(*jvm->op[0].f64);
}

void JASMINE_OP::fS16_F64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,2);
	*jvm->op[1].s16 = (sint16)(*jvm->op[0].f64);
}

void JASMINE_OP::fS8_F64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,1);
	*jvm->op[1].s8 = (sint8)(*jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fS64_F32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,8);
	*jvm->op[1].s64 = (sint64)(*jvm->op[0].f32);
}

void JASMINE_OP::fS32_F32(OP_ARGS)
{
	JASMINE_EA::D2_X32(jvm);
	*jvm->op[1].s32 = (sint32)(*jvm->op[0].f32);
}

void JASMINE_OP::fS16_F32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,2);
	*jvm->op[1].s16 = (sint16)(*jvm->op[0].f32);
}

void JASMINE_OP::fS8_F32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,1);
	*jvm->op[1].s8 = (sint8)(*jvm->op[0].f32);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI32_S64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,4);
	*jvm->op[1].s32 = (sint32)(*jvm->op[0].s64);
}

void JASMINE_OP::fI16_S64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,2);
	*jvm->op[1].s16 = (sint16)(*jvm->op[0].s64);
}

void JASMINE_OP::fI8_S64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,1);
	*jvm->op[1].s8 = (sint8)(*jvm->op[0].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI16_S32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,2);
	*jvm->op[1].s16 = (sint16)(*jvm->op[0].s32);
}

void JASMINE_OP::fI8_S32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,1);
	*jvm->op[1].s8 = (sint8)(*jvm->op[0].s32);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI8_S16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,1);
	*jvm->op[1].s8 = (sint8)(*jvm->op[0].s16);
}


#else // #ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
/////////////////////////////////////////////////////////////////////////////////////


void JASMINE_OP::fI16_S8(OP_ARGS)
{
	OPINIT();
	OP2D_16(sint16) = OP1_8(sint8);
	OPDONE();
}

void JASMINE_OP::fI32_S8(OP_ARGS)
{
	OPINIT();
	OP2D_32(sint32) = OP1_8(sint8);
	OPDONE();
}

void JASMINE_OP::fI64_S8(OP_ARGS)
{
	OPINIT();
	OP2D_64(sint64) = OP1_8(sint8);
	OPDONE();
}

void JASMINE_OP::fF32_S8(OP_ARGS)
{
	OPINIT();
	OP2D_32(float32) = (float32)(OP1_8(sint8));
	OPDONE();
}

void JASMINE_OP::fF64_S8(OP_ARGS)
{
	OPINIT();
	OP2D_64(float64) = (float64)(OP1_8(sint8));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI32_S16(OP_ARGS)
{
	OPINIT();
	OP2D_32(sint32) = OP1_16(sint16);
	OPDONE();
}

void JASMINE_OP::fI64_S16(OP_ARGS)
{
	OPINIT();
	OP2D_64(sint64) = OP1_16(sint16);
	OPDONE();
}

void JASMINE_OP::fF32_S16(OP_ARGS)
{
	OPINIT();
	OP2D_32(float32) = (float32)(OP1_16(sint16));
	OPDONE();
}

void JASMINE_OP::fF64_S16(OP_ARGS)
{
	OPINIT();
	OP2D_64(float64) = (float64)(OP1_16(sint16));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI64_S32(OP_ARGS)
{
	OPINIT();
	OP2D_64(sint64) = OP1_32(sint32);
	OPDONE();
}

void JASMINE_OP::fF32_S32(OP_ARGS)
{
	OPINIT();
	OP2D_32(float32) = (float32)(OP1_32(sint32));
	OPDONE();
}

void JASMINE_OP::fF64_S32(OP_ARGS)
{
	OPINIT();
	OP2D_64(float64) = (float64)(OP1_32(sint32));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fF32_S64(OP_ARGS)
{
	OPINIT();
	OP2D_32(float32) = (float32)(OP1_64(sint64));
	OPDONE();
}

void JASMINE_OP::fF64_S64(OP_ARGS)
{
	OPINIT();
	OP2D_64(float64) = (float64)(OP1_64(sint64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fS64_F64(OP_ARGS)
{
	OPINIT();
	OP2D_64(sint64) = (sint64)(OP1_64(float64));
	OPDONE();
}

void JASMINE_OP::fS32_F64(OP_ARGS)
{
	OPINIT();
	OP2D_32(sint32) = (sint32)(OP1_64(float64));
	OPDONE();
}

void JASMINE_OP::fS16_F64(OP_ARGS)
{
	OPINIT();
	OP2D_16(sint16) = (sint16)(OP1_64(float64));
	OPDONE();
}

void JASMINE_OP::fS8_F64(OP_ARGS)
{
	OPINIT();
	OP2D_8(sint8) = (sint8)(OP1_64(float64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fS64_F32(OP_ARGS)
{
	OPINIT();
	OP2D_64(sint64) = (sint64)OP1_32(float32);
	OPDONE();
}

void JASMINE_OP::fS32_F32(OP_ARGS)
{
	OPINIT();
	OP2D_32(sint32) = (sint32)(OP1_32(float32));
	OPDONE();
}

void JASMINE_OP::fS16_F32(OP_ARGS)
{
	OPINIT();
	OP2D_16(sint16) = (sint16)(OP1_32(float32));
	OPDONE();
}

void JASMINE_OP::fS8_F32(OP_ARGS)
{
	OPINIT();
	OP2D_8(sint8) = (sint8)(OP1_32(float32));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI32_S64(OP_ARGS)
{
	OPINIT();
	OP2D_32(sint32) = (sint32)(OP1_64(sint64));
	OPDONE();
}

void JASMINE_OP::fI16_S64(OP_ARGS)
{
	OPINIT();
	OP2D_16(sint16) = (sint16)(OP1_64(sint64));
	OPDONE();
}

void JASMINE_OP::fI8_S64(OP_ARGS)
{
	OPINIT();
	OP2D_8(sint8) = (sint8)(OP1_64(sint64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI16_S32(OP_ARGS)
{
	OPINIT();
	OP2D_16(sint16) = (sint16)(OP1_32(sint32));
	OPDONE();
}

void JASMINE_OP::fI8_S32(OP_ARGS)
{
	OPINIT();
	OP2D_8(sint8) = (sint8)(OP1_32(sint32));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI8_S16(OP_ARGS)
{
	OPINIT();
	OP2D_8(sint8) = (sint8)(OP1_16(sint16));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////


#endif // #ifndef JASMINE_MACRO_EA

