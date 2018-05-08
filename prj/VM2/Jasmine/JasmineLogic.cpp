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

void JASMINE_OP::fAND_X8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].u8 = *jvm->op[0].u8 & *jvm->op[1].u8;
}

void JASMINE_OP::fAND_X16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].u16 = *jvm->op[0].u16 & *jvm->op[1].u16;
}

void JASMINE_OP::fAND_X32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].u32 = *jvm->op[0].u32 & *jvm->op[1].u32;
}

void JASMINE_OP::fAND_X64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].u64 = *jvm->op[0].u64 & *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fOR_X8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].u8 = *jvm->op[0].u8 | *jvm->op[1].u8;
}

void JASMINE_OP::fOR_X16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].u16 = *jvm->op[0].u16 | *jvm->op[1].u16;
}

void JASMINE_OP::fOR_X32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].u32 = *jvm->op[0].u32 | *jvm->op[1].u32;
}

void JASMINE_OP::fOR_X64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].u64 = *jvm->op[0].u64 | *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fXOR_X8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].u8 = *jvm->op[0].u32 ^ *jvm->op[1].u8;
}

void JASMINE_OP::fXOR_X16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].u16 = *jvm->op[0].u16 ^ *jvm->op[1].u16;
}

void JASMINE_OP::fXOR_X32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].u32 = *jvm->op[0].u32 ^ *jvm->op[1].u32;
}

void JASMINE_OP::fXOR_X64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].u64 = *jvm->op[0].u64 ^ *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fINV_X8(OP_ARGS)
{
	JASMINE_EA::D2_X8(jvm);
	*jvm->op[1].u8 = ~(*jvm->op[0].u8);
}

void JASMINE_OP::fINV_X16(OP_ARGS)
{
	JASMINE_EA::D2_X16(jvm);
	*jvm->op[1].u16 = ~(*jvm->op[0].u16);
}

void JASMINE_OP::fINV_X32(OP_ARGS)
{
	JASMINE_EA::D2_X32(jvm);
	*jvm->op[1].u32 = ~(*jvm->op[0].u32);
}

void JASMINE_OP::fINV_X64(OP_ARGS)
{
	JASMINE_EA::D2_X64(jvm);
	*jvm->op[1].u64 = ~(*jvm->op[0].u64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSHL_X8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].u8 = (*jvm->op[0].u8) << *jvm->op[1].u8;
}

void JASMINE_OP::fSHL_X16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].u16 = (*jvm->op[0].u16) << *jvm->op[1].u16;
}

void JASMINE_OP::fSHL_X32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].u32 = (*jvm->op[0].u32) << *jvm->op[1].u32;
}

void JASMINE_OP::fSHL_X64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].u64 = (*jvm->op[0].u64) << *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSHR_X8(OP_ARGS)
{
	JASMINE_EA::D3_X8(jvm);
	*jvm->op[2].u8 = (*jvm->op[0].u8) >> *jvm->op[1].u8;
}

void JASMINE_OP::fSHR_X16(OP_ARGS)
{
	JASMINE_EA::D3_X16(jvm);
	*jvm->op[2].u16 = (*jvm->op[0].u16) >> *jvm->op[1].u16;
}

void JASMINE_OP::fSHR_X32(OP_ARGS)
{
	JASMINE_EA::D3_X32(jvm);
	*jvm->op[2].u32 = (*jvm->op[0].u32) >> *jvm->op[1].u32;
}

void JASMINE_OP::fSHR_X64(OP_ARGS)
{
	JASMINE_EA::D3_X64(jvm);
	*jvm->op[2].u64 = (*jvm->op[0].u64) >> *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fAND_X8(OP_ARGS)
{
	OPINIT();
	OP3_8(uint8) = OP1_8(uint8) & OP2_8(uint8);
	OPDONE();
}

void JASMINE_OP::fAND_X16(OP_ARGS)
{
	OPINIT();
	OP3_16(uint16) = OP1_16(uint16) & OP2_16(uint16);
	OPDONE();
}

void JASMINE_OP::fAND_X32(OP_ARGS)
{
	OPINIT();
	OP3_32(uint32) = OP1_32(uint32) & OP2_32(uint32);
	OPDONE();
}

void JASMINE_OP::fAND_X64(OP_ARGS)
{
	OPINIT();
	OP3_64(uint64) = OP1_64(uint64) & OP2_64(uint64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fOR_X8(OP_ARGS)
{
	OPINIT();
	OP3_8(uint8) = OP1_8(uint8) | OP2_8(uint8);
	OPDONE();
}

void JASMINE_OP::fOR_X16(OP_ARGS)
{
	OPINIT();
	OP3_16(uint16) = OP1_16(uint16) | OP2_16(uint16);
	OPDONE();
}

void JASMINE_OP::fOR_X32(OP_ARGS)
{
	OPINIT();
	OP3_32(uint32) = OP1_32(uint32) | OP2_32(uint32);
	OPDONE();
}

void JASMINE_OP::fOR_X64(OP_ARGS)
{
	OPINIT();
	OP3_64(uint64) = OP1_64(uint64) | OP2_64(uint64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fXOR_X8(OP_ARGS)
{
	OPINIT();
	OP3_8(uint8) = OP1_8(uint8) ^ OP2_8(uint8);
	OPDONE();
}

void JASMINE_OP::fXOR_X16(OP_ARGS)
{
	OPINIT();
	OP3_16(uint16) = OP1_16(uint16) ^ OP2_16(uint16);
	OPDONE();
}

void JASMINE_OP::fXOR_X32(OP_ARGS)
{
	OPINIT();
	OP3_32(uint32) = OP1_32(uint32) ^ OP2_32(uint32);
	OPDONE();
}

void JASMINE_OP::fXOR_X64(OP_ARGS)
{
	OPINIT();
	OP3_64(uint64) = OP1_64(uint64) ^ OP2_64(uint64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fINV_X8(OP_ARGS)
{
	OPINIT();
	OP2D_8(uint8) = ~(OP1_8(uint8));
	OPDONE();
}

void JASMINE_OP::fINV_X16(OP_ARGS)
{
	OPINIT();
	OP2D_16(uint16) = ~(OP1_16(uint16));
	OPDONE();
}

void JASMINE_OP::fINV_X32(OP_ARGS)
{
	OPINIT();
	OP2D_32(uint32) = ~(OP1_32(uint32));
	OPDONE();
}

void JASMINE_OP::fINV_X64(OP_ARGS)
{
	OPINIT();
	OP2D_64(uint64) = ~(OP1_64(uint64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSHL_X8(OP_ARGS)
{
	OPINIT();
	OP3_8(uint8) = OP1_8(uint8) << OP2_8(uint8);
	OPDONE();
}

void JASMINE_OP::fSHL_X16(OP_ARGS)
{
	OPINIT();
	OP3_16(uint16) = OP1_16(uint16) << OP2_16(uint16);
	OPDONE();
}

void JASMINE_OP::fSHL_X32(OP_ARGS)
{
	OPINIT();
	OP3_32(uint32) = OP1_32(uint32) << OP2_32(uint32);
	OPDONE();
}
/*
void JASMINE_OP::fSHL_X64(OP_ARGS)
{
	OPINIT();
	OP3_64(uint64) = OP1_64(uint64) << OP2_64(uint64);
	OPDONE();
}
*/
/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSHR_X8(OP_ARGS)
{
	OPINIT();
	OP3_8(uint8) = OP1_8(uint8) >> OP2_8(uint8);
	OPDONE();
}

void JASMINE_OP::fSHR_X16(OP_ARGS)
{
	OPINIT();
	OP3_16(uint16) = OP1_16(uint16) >> OP2_16(uint16);
	OPDONE();
}

void JASMINE_OP::fSHR_X32(OP_ARGS)
{
	OPINIT();
	OP3_32(uint32) = OP1_32(uint32) >> OP2_32(uint32);
	OPDONE();
}

void JASMINE_OP::fSHR_X64(OP_ARGS)
{
	OPINIT();
	OP3_64(uint64) = OP1_64(uint64) >> OP2_64(uint64);
	OPDONE();
}

#endif // #ifndef JASMINE_MACRO_EA

