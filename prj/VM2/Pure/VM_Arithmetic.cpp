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

extern "C" {
  #include <math.h>
}

void VMCORE::fADD_I8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].s8 = *This->op[0].s8 + *This->op[1].s8;
}

void VMCORE::fADD_I16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].s16 = *This->op[0].s16 + *This->op[1].s16;
}

void VMCORE::fADD_I32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].s32 = *This->op[0].s32 + *This->op[1].s32;
}

void VMCORE::fADD_I64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].s64 = *This->op[0].s64 + *This->op[1].s64;
}

void VMCORE::fADD_F32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].f32 = *This->op[0].f32 + *This->op[1].f32;
}

void VMCORE::fADD_F64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].f64 = *This->op[0].f64 + *This->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSUB_I8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].s8 = *This->op[0].s8 - *This->op[1].s8;
}

void VMCORE::fSUB_I16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].s16 = *This->op[0].s16 - *This->op[1].s16;
}

void VMCORE::fSUB_I32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].s32 = *This->op[0].s32 - *This->op[1].s32;
}

void VMCORE::fSUB_I64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].s64 = *This->op[0].s64 - *This->op[1].s64;
}

void VMCORE::fSUB_F32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].f32 = *This->op[0].f32 - *This->op[1].f32;
}

void VMCORE::fSUB_F64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].f64 = *This->op[0].f64 - *This->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fMUL_I8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].s8 = *This->op[0].s8 * *This->op[1].s8;
}

void VMCORE::fMUL_I16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].s16 = *This->op[0].s16 * *This->op[1].s16;
}

void VMCORE::fMUL_I32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].s32 = *This->op[0].s32 * *This->op[1].s32;
}

void VMCORE::fMUL_I64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].s64 = *This->op[0].s64 * *This->op[1].s64;
}

void VMCORE::fMUL_F32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].f32 = *This->op[0].f32 * *This->op[1].f32;
}

void VMCORE::fMUL_F64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].f64 = *This->op[0].f64 * *This->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fDIV_I8(OP_ARGS)
{
  Decode3_X8(This);
  if (*This->op[1].s8)
    *This->op[2].s8 = *This->op[0].s8 / *This->op[1].s8;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fDIV_I16(OP_ARGS)
{
  Decode3_X16(This);
  if (*This->op[1].s16)
    *This->op[2].s16 = *This->op[0].s16 / *This->op[1].s16;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fDIV_I32(OP_ARGS)
{
  Decode3_X32(This);
  if (*This->op[1].s32)
    *This->op[2].s32 = *This->op[0].s32 / *This->op[1].s32;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fDIV_I64(OP_ARGS)
{
  Decode3_X64(This);
  if (*This->op[1].s64)
    *This->op[2].s64 = *This->op[0].s64 / *This->op[1].s64;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fDIV_F32(OP_ARGS)
{
  Decode3_X32(This);
    *This->op[2].f32 = *This->op[0].f32 / *This->op[1].f32;
}

void VMCORE::fDIV_F64(OP_ARGS)
{
  Decode3_X64(This);
    *This->op[2].f64 = *This->op[0].f64 / *This->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fMOD_I8(OP_ARGS)
{
  Decode3_X8(This);
  if (*This->op[1].s8)
    *This->op[2].s8 = *This->op[0].s8 % *This->op[1].s8;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fMOD_I16(OP_ARGS)
{
  Decode3_X16(This);
  if (*This->op[1].s16)
    *This->op[2].s16 = *This->op[0].s16 % *This->op[1].s16;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fMOD_I32(OP_ARGS)
{
  Decode3_X32(This);
  if (*This->op[1].s32)
    *This->op[2].s32 = *This->op[0].s32 % *This->op[1].s32;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fMOD_I64(OP_ARGS)
{
  Decode3_X64(This);
  if (*This->op[1].s64)
    *This->op[2].s64 = *This->op[0].s64 % *This->op[1].s64;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fMOD_F32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].f32 = (float32)fmod(*This->op[0].f32, *This->op[1].f32);
}

void VMCORE::fMOD_F64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].f64 = fmod(*This->op[0].f64, *This->op[1].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fMUL_U8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].u8 = *This->op[0].u8 * *This->op[1].u8;
}

void VMCORE::fMUL_U16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].u16 = *This->op[0].u16 * *This->op[1].u16;
}

void VMCORE::fMUL_U32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].u32 = *This->op[0].u32 * *This->op[1].u32;
}

void VMCORE::fMUL_U64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].u64 = *This->op[0].u64 * *This->op[1].u64;
}

void VMCORE::fDIV_U8(OP_ARGS)
{
  Decode3_X8(This);
  if (*This->op[1].u8)
    *This->op[2].u8 = *This->op[0].u8 / *This->op[1].u8;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fDIV_U16(OP_ARGS)
{
  Decode3_X16(This);
  if (*This->op[1].u16)
    *This->op[2].u16 = *This->op[0].u16 / *This->op[1].u16;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fDIV_U32(OP_ARGS)
{
  Decode3_X32(This);
  if (*This->op[1].u32)
    *This->op[2].u32 = *This->op[0].u32 / *This->op[1].u32;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fDIV_U64(OP_ARGS)
{
  Decode3_X64(This);
  if (*This->op[1].u64)
    *This->op[2].u64 = *This->op[0].u64 / *This->op[1].u64;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fMOD_U8(OP_ARGS)
{
  Decode3_X8(This);
  if (*This->op[1].u8)
    *This->op[2].u8 = *This->op[0].u8 % *This->op[1].u8;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fMOD_U16(OP_ARGS)
{
  Decode3_X16(This);
  if (*This->op[1].u16)
    *This->op[2].u16 = *This->op[0].u16 % *This->op[1].u16;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fMOD_U32(OP_ARGS)
{
  Decode3_X32(This);
  if (*This->op[1].u32)
    *This->op[2].u32 = *This->op[0].u32 % *This->op[1].u32;
  else
    This->exitReg = MATH_DIVBYZERO;
}

void VMCORE::fMOD_U64(OP_ARGS)
{
  Decode3_X8(This);
  if (*This->op[1].u64)
    *This->op[2].u64 = *This->op[0].u64 % *This->op[1].u64;
  else
    This->exitReg = MATH_DIVBYZERO;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fNEG_I8(OP_ARGS)
{
  Decode2_X8(This);
  *This->op[1].s8 = -(*This->op[0].s8);
}

void VMCORE::fNEG_I16(OP_ARGS)
{
  Decode2_X16(This);
  *This->op[1].s16 = -(*This->op[0].s16);
}

void VMCORE::fNEG_I32(OP_ARGS)
{
  Decode2_X32(This);
  *This->op[1].s32 = -(*This->op[0].s32);
}

void VMCORE::fNEG_I64(OP_ARGS)
{
  Decode2_X64(This);
  *This->op[1].s64 = -(*This->op[0].s64);
}

void VMCORE::fNEG_F32(OP_ARGS)
{
  Decode2_X32(This);
  *This->op[1].f32 = -(*This->op[0].f32);
}

void VMCORE::fNEG_F64(OP_ARGS)
{
  Decode2_X64(This);
  *This->op[1].f64 = -(*This->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSHL_I8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].s8 = (*This->op[0].s8) << (*This->op[1].s8);
}

void VMCORE::fSHL_I16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].s16 = (*This->op[0].s16) << (*This->op[1].s16);
}

void VMCORE::fSHL_I32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].s32 = (*This->op[0].s32) << (*This->op[1].s32);
}

void VMCORE::fSHL_I64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].s64 = (*This->op[0].s64) << (*This->op[1].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSHR_I8(OP_ARGS)
{
  Decode3_X8(This);
  *This->op[2].s8 = (*This->op[0].s8) >> (*This->op[1].s8);
}

void VMCORE::fSHR_I16(OP_ARGS)
{
  Decode3_X16(This);
  *This->op[2].s16 = (*This->op[0].s16) >> (*This->op[1].s16);
}

void VMCORE::fSHR_I32(OP_ARGS)
{
  Decode3_X32(This);
  *This->op[2].s32 = (*This->op[0].s32) >> (*This->op[1].s32);
}

void VMCORE::fSHR_I64(OP_ARGS)
{
  Decode3_X64(This);
  *This->op[2].s64 = (*This->op[0].s64) >> (*This->op[1].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

#ifdef USE_VM_BLOCKCOMMANDS
void VMCORE::fBADD_I8(OP_ARGS)}
void VMCORE::fBADD_I16(OP_ARGS){}
void VMCORE::fBADD_I32(OP_ARGS){}
void VMCORE::fBADD_I64(OP_ARGS){}
void VMCORE::fBADD_F32(OP_ARGS){}
void VMCORE::fBADD_F64(OP_ARGS){}
void VMCORE::fBSUB_I8(OP_ARGS){}
void VMCORE::fBSUB_I16(OP_ARGS){}
void VMCORE::fBSUB_I32(OP_ARGS){}
void VMCORE::fBSUB_I64(OP_ARGS){}
void VMCORE::fBSUB_F32(OP_ARGS){}
void VMCORE::fBSUB_F64(OP_ARGS){}
void VMCORE::fBMUL_I8(OP_ARGS){}
void VMCORE::fBMUL_I16(OP_ARGS){}
void VMCORE::fBMUL_I32(OP_ARGS){}
void VMCORE::fBMUL_I64(OP_ARGS){}
void VMCORE::fBMUL_F32(OP_ARGS){}
void VMCORE::fBMUL_F64(OP_ARGS){}
void VMCORE::fBDIV_I8(OP_ARGS){}
void VMCORE::fBDIV_I16(OP_ARGS){}
void VMCORE::fBDIV_I32(OP_ARGS){}
void VMCORE::fBDIV_I64(OP_ARGS){}
void VMCORE::fBDIV_F32(OP_ARGS){}
void VMCORE::fBDIV_F64(OP_ARGS){}
void VMCORE::fBMOD_I8(OP_ARGS){}
void VMCORE::fBMOD_I16(OP_ARGS){}
void VMCORE::fBMOD_I32(OP_ARGS){}
void VMCORE::fBMOD_I64(OP_ARGS){}
void VMCORE::fBMOD_F32(OP_ARGS){}
void VMCORE::fBMOD_F64(OP_ARGS){}
void VMCORE::fBNEG_I8(OP_ARGS){}
void VMCORE::fBNEG_I16(OP_ARGS){}
void VMCORE::fBNEG_I32(OP_ARGS){}
void VMCORE::fBNEG_I64(OP_ARGS){}
void VMCORE::fBNEG_F32(OP_ARGS){}
void VMCORE::fBNEG_F64(OP_ARGS){}
void VMCORE::fBSHL_I8(OP_ARGS){}
void VMCORE::fBSHL_I16(OP_ARGS){}
void VMCORE::fBSHL_I32(OP_ARGS){}
void VMCORE::fBSHL_I64(OP_ARGS){}
void VMCORE::fBSHR_I8(OP_ARGS){}
void VMCORE::fBSHR_I16(OP_ARGS){}
void VMCORE::fBSHR_I32(OP_ARGS){}
void VMCORE::fBSHR_I64(OP_ARGS){}
#endif

