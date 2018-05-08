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

void JASMINE_OP::fI16_U8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,2);
	*jvm->op[1].u16 = *jvm->op[0].u8;
}

void JASMINE_OP::f32_U8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,4);
	*jvm->op[1].u32 = *jvm->op[0].u8;
}

void JASMINE_OP::fI64_U8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,8);
	*jvm->op[1].u64 = *jvm->op[0].u8;
}

void JASMINE_OP::fF32_U8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,4);
	*jvm->op[1].f32 = (float32)(*jvm->op[0].u8);
}

void JASMINE_OP::fF64_U8(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 1,8);
	*jvm->op[1].f64 = (float64)(*jvm->op[0].u8);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI32_U16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,4);
	*jvm->op[1].u32 = *jvm->op[0].u16;
}

void JASMINE_OP::fI64_U16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,8);
	*jvm->op[1].u64 = *jvm->op[0].u16;
}

void JASMINE_OP::fF32_U16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,4);
	*jvm->op[1].f32 = (float32)(*jvm->op[0].u16);
}

void JASMINE_OP::fF64_U16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,8);
	*jvm->op[1].f64 = (float64)(*jvm->op[0].u16);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI64_U32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,8);
	*jvm->op[1].u64 = *jvm->op[0].u32;
}

void JASMINE_OP::fF32_U32(OP_ARGS)
{
	JASMINE_EA::D2_X32(jvm);
	*jvm->op[1].f32 = (float32)(*jvm->op[0].u32);
}

void JASMINE_OP::fF64_U32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,8);
	*jvm->op[1].f64 = (float64)(*jvm->op[0].u32);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fF32_U64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,4);
	*jvm->op[1].f32 = (float32)(*jvm->op[0].u64);
}

void JASMINE_OP::fF64_U64(OP_ARGS)
{
	JASMINE_EA::D2_X64(jvm);
	*jvm->op[1].f64 = (float64)(*jvm->op[0].u64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fU64_F64(OP_ARGS)
{
	JASMINE_EA::D2_X64(jvm);
	*jvm->op[1].u64 = (uint64)(*jvm->op[0].f64);
}

void JASMINE_OP::fU32_F64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,4);
	*jvm->op[1].u32 = (uint32)(*jvm->op[0].f64);
}

void JASMINE_OP::fU16_F64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,2);
	*jvm->op[1].u16 = (uint16)(*jvm->op[0].f64);
}

void JASMINE_OP::fU8_F64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,1);
	*jvm->op[1].u8 = (uint8)(*jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fU64_F32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,8);
	*jvm->op[1].u64 = (uint64)(*jvm->op[0].f32);
}

void JASMINE_OP::fU32_F32(OP_ARGS)
{
	JASMINE_EA::D2_X32(jvm);
	*jvm->op[1].u32 = (uint32)(*jvm->op[0].f32);
}

void JASMINE_OP::fU16_F32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,2);
	*jvm->op[1].u16 = (uint16)(*jvm->op[0].f32);
}

void JASMINE_OP::fU8_F32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,1);
	*jvm->op[1].u8 = (sint8)(*jvm->op[0].f32);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI32_U64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,4);
	*jvm->op[1].u32 = (uint32)(*jvm->op[0].u64);
}

void JASMINE_OP::fI16_U64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,2);
	*jvm->op[1].u16 = (uint16)(*jvm->op[0].u64);
}

void JASMINE_OP::fI8_U64(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 8,1);
	*jvm->op[1].u8 = (uint8)(*jvm->op[0].u64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI16_U32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,2);
	*jvm->op[1].u16 = (uint16)(*jvm->op[0].u32);
}

void JASMINE_OP::fI8_U32(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 4,1);
	*jvm->op[1].u8 = (uint8)(*jvm->op[0].u32);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI8_U16(OP_ARGS)
{
	JASMINE_EA::D2(jvm, 2,1);
	*jvm->op[1].u8 = (uint8)(*jvm->op[0].u16);
}

#else // #ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
/////////////////////////////////////////////////////////////////////////////////////


void JASMINE_OP::fI16_U8(OP_ARGS)
{
	OPINIT();
	OP2D_16(uint16) = OP1_8(uint8);
	OPDONE();
}

void JASMINE_OP::fI32_U8(OP_ARGS)
{
	OPINIT();
	OP2D_32(uint32) = OP1_8(uint8);
	OPDONE();
}

void JASMINE_OP::fI64_U8(OP_ARGS)
{
	OPINIT();
	OP2D_64(uint64) = OP1_8(uint8);
	OPDONE();
}

void JASMINE_OP::fF32_U8(OP_ARGS)
{
	OPINIT();
	OP2D_32(float32) = (float32)(OP1_8(uint8));
	OPDONE();
}

void JASMINE_OP::fF64_U8(OP_ARGS)
{
	OPINIT();
	OP2D_64(float64) = (float64)(OP1_8(uint8));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI32_U16(OP_ARGS)
{
	OPINIT();
	OP2D_32(uint32) = OP1_16(uint16);
	OPDONE();
}

void JASMINE_OP::fI64_U16(OP_ARGS)
{
	OPINIT();
	OP2D_64(uint64) = OP1_16(uint16);
	OPDONE();
}

void JASMINE_OP::fF32_U16(OP_ARGS)
{
	OPINIT();
	OP2D_32(float32) = (float32)(OP1_16(uint16));
	OPDONE();
}

void JASMINE_OP::fF64_U16(OP_ARGS)
{
	OPINIT();
	OP2D_64(float64) = (float64)(OP1_16(uint16));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI64_U32(OP_ARGS)
{
	OPINIT();
	OP2D_64(uint64) = OP1_32(uint32);
	OPDONE();
}

void JASMINE_OP::fF32_U32(OP_ARGS)
{
	OPINIT();
	OP2D_32(float32) = (float32)(OP1_32(uint32));
	OPDONE();
}

void JASMINE_OP::fF64_U32(OP_ARGS)
{
	OPINIT();
	OP2D_64(float64) = (float64)(OP1_32(uint32));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fF32_U64(OP_ARGS)
{
	OPINIT();
	OP2D_32(float32) = (float32)(OP1_64(uint64));
	OPDONE();
}

void JASMINE_OP::fF64_U64(OP_ARGS)
{
	OPINIT();
	OP2D_64(float64) = (float64)(OP1_64(uint64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fU64_F64(OP_ARGS)
{
	OPINIT();
	OP2D_64(uint64) = (uint64)(OP1_64(float64));
	OPDONE();
}

void JASMINE_OP::fU32_F64(OP_ARGS)
{
	OPINIT();
	OP2D_32(uint32) = (uint32)(OP1_64(float64));
	OPDONE();
}

void JASMINE_OP::fU16_F64(OP_ARGS)
{
	OPINIT();
	OP2D_16(uint16) = (uint16)(OP1_64(float64));
	OPDONE();
}

void JASMINE_OP::fU8_F64(OP_ARGS)
{
	OPINIT();
	OP2D_8(uint8) = (uint8)(OP1_64(float64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fU64_F32(OP_ARGS)
{
	OPINIT();
	OP2D_64(uint64) = (uint64)OP1_32(float32);
	OPDONE();
}

void JASMINE_OP::fU32_F32(OP_ARGS)
{
	OPINIT();
	OP2D_32(uint32) = (uint32)(OP1_32(float32));
	OPDONE();
}

void JASMINE_OP::fU16_F32(OP_ARGS)
{
	OPINIT();
	OP2D_16(uint16) = (uint16)(OP1_32(float32));
	OPDONE();
}

void JASMINE_OP::fU8_F32(OP_ARGS)
{
	OPINIT();
	OP2D_8(uint8) = (uint8)(OP1_32(float32));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI32_U64(OP_ARGS)
{
	OPINIT();
	OP2D_32(uint32) = (uint32)(OP1_64(uint64));
	OPDONE();
}

void JASMINE_OP::fI16_U64(OP_ARGS)
{
	OPINIT();
	OP2D_16(uint16) = (uint16)(OP1_64(uint64));
	OPDONE();
}

void JASMINE_OP::fI8_U64(OP_ARGS)
{
	OPINIT();
	OP2D_8(uint8) = (uint8)(OP1_64(uint64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI16_U32(OP_ARGS)
{
	OPINIT();
	OP2D_16(uint16) = (uint16)(OP1_32(uint32));
	OPDONE();
}

void JASMINE_OP::fI8_U32(OP_ARGS)
{
	OPINIT();
	OP2D_8(uint8) = (uint8)(OP1_32(uint32));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fI8_U16(OP_ARGS)
{
	OPINIT();
	OP2D_8(uint8) = (uint8)(OP1_16(uint16));
	OPDONE();
}

#endif // #ifndef JASMINE_MACRO_EA

