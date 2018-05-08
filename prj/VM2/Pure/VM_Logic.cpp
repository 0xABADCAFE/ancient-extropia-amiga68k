//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "VM_Class.hpp"

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fAND_X8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].u8 = *This->op[0].u8 & *This->op[1].u8;
}

void VMCORE::fAND_X16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].u16 = *This->op[0].u16 & *This->op[1].u16;
}

void VMCORE::fAND_X32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].u32 = *This->op[0].u32 & *This->op[1].u32;
}

void VMCORE::fAND_X64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].u64 = *This->op[0].u64 & *This->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fOR_X8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].u8 = *This->op[0].u8 | *This->op[1].u8;
}

void VMCORE::fOR_X16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].u16 = *This->op[0].u16 | *This->op[1].u16;
}

void VMCORE::fOR_X32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].u32 = *This->op[0].u32 | *This->op[1].u32;
}

void VMCORE::fOR_X64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].u64 = *This->op[0].u64 | *This->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fXOR_X8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].u8 = *This->op[0].u32 ^ *This->op[1].u8;
}

void VMCORE::fXOR_X16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].u16 = *This->op[0].u16 ^ *This->op[1].u16;
}

void VMCORE::fXOR_X32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].u32 = *This->op[0].u32 ^ *This->op[1].u32;
}

void VMCORE::fXOR_X64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].u64 = *This->op[0].u64 ^ *This->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fINV_X8(OP_ARGS)
{
  Decode2_X8(This);
  *This->op[1].u8 = ~(*This->op[0].u8);
}

void VMCORE::fINV_X16(OP_ARGS)
{
  Decode2_X16(This);
  *This->op[1].u16 = ~(*This->op[0].u16);
}

void VMCORE::fINV_X32(OP_ARGS)
{
  Decode2_X32(This);
  *This->op[1].u32 = ~(*This->op[0].u32);
}

void VMCORE::fINV_X64(OP_ARGS)
{
  Decode2_X64(This);
  *This->op[1].u64 = ~(*This->op[0].u64);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSHL_X8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].u8 = (*This->op[0].u8) << (*This->op[1].u8);
}

void VMCORE::fSHL_X16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].u16 = (*This->op[0].u16) << (*This->op[1].u16);
}

void VMCORE::fSHL_X32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].u32 = (*This->op[0].u32) << (*This->op[1].u32);
}

void VMCORE::fSHL_X64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].u64 = (*This->op[0].u64) << (*This->op[1].u64);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSHR_X8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].u8 = (*This->op[0].u8) >> (*This->op[1].u8);
}

void VMCORE::fSHR_X16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].u16 = (*This->op[0].u16) >> (*This->op[1].u16);
}

void VMCORE::fSHR_X32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].u32 = (*This->op[0].u32) >> (*This->op[1].u32);
}

void VMCORE::fSHR_X64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].u64 = (*This->op[0].u64) >> (*This->op[1].u64);
}

/////////////////////////////////////////////////////////////////////////////////////

#ifdef USE_VM_BLOCKCOMMANDS
void VMCORE::fBAND_X8(OP_ARGS){}
void VMCORE::fBAND_X16(OP_ARGS){}
void VMCORE::fBAND_X32(OP_ARGS){}
void VMCORE::fBAND_X64(OP_ARGS){}
void VMCORE::fBOR_X8(OP_ARGS){}
void VMCORE::fBOR_X16(OP_ARGS){}
void VMCORE::fBOR_X32(OP_ARGS){}
void VMCORE::fBOR_X64(OP_ARGS){}
void VMCORE::fBXOR_X8(OP_ARGS){}
void VMCORE::fBXOR_X16(OP_ARGS){}
void VMCORE::fBXOR_X32(OP_ARGS){}
void VMCORE::fBXOR_X64(OP_ARGS){}
void VMCORE::fBINV_X8(OP_ARGS){}
void VMCORE::fBINV_X16(OP_ARGS){}
void VMCORE::fBINV_X32(OP_ARGS){}
void VMCORE::fBINV_X64(OP_ARGS){}
void VMCORE::fBSHL_X8(OP_ARGS){}
void VMCORE::fBSHL_X16(OP_ARGS){}
void VMCORE::fBSHL_X32(OP_ARGS){}
void VMCORE::fBSHL_X64(OP_ARGS){}
void VMCORE::fBSHR_X8(OP_ARGS){}
void VMCORE::fBSHR_X16(OP_ARGS){}
void VMCORE::fBSHR_X32(OP_ARGS){}
void VMCORE::fBSHR_X64(OP_ARGS){}
#endif