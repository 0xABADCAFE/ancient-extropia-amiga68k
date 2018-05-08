//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "Jasmine.hpp"

#ifndef JASMINE_BREAK_DETECT_ALWAYS
  #ifdef JASMINE_BREAK_DETECT_BRANCH_ONLY
    #define CHECKBREAK()                      \
    if (THREAD::GotBreak())                   \
    {                                         \
      jvm->exitReg = JASMINE::USER_BREAK;     \
      return;                                 \
    }
  #else
    #define CHECKBREAK()
  #endif
#endif


void JASMINE_OP::fNOP(OP_ARGS)
{
  jvm->instPtr++;
}

void JASMINE_OP::fEND(OP_ARGS)
{
  jvm->exitReg = JASMINE::END_OF_CODE;
}

// #ifndef JASMINE_MACRO_EA

void JASMINE_OP::fLEA(OP_ARGS)
{
  // source must be non reg-direct EA
  // dest must be reg direct
  JASMINE_EA::D2(jvm,1,8);
  jvm->op[1].reg->PtrU8() = jvm->op[0].u8;
}

void JASMINE_OP::fBRA(OP_ARGS)
{
  CHECKBREAK();
  jvm->instPtr += *((sint32*)++jvm->instPtr);
}

///////////////////////////////////////////////////////////////////////////////
//
//  Conditional branching infos
//
///////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fBNEQ_I8(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X8(jvm);
  if (*jvm->op[0].s8!=*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBNEQ_I16(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X16(jvm);
  if (*jvm->op[0].s16!=*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBNEQ_I32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].s32!=*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBNEQ_I64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].s64!=*jvm->op[0].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBNEQ_F32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].f32!=*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBNEQ_F64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].f64!=*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLS_I8(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X8(jvm);
  if (*jvm->op[0].s8<*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLS_I16(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X16(jvm);
  if (*jvm->op[0].s16<*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLS_I32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].s32<*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLS_I64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].s64<*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLS_F32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].f32<*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLS_F64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].f64<*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLSEQ_I8(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X8(jvm);
  if (*jvm->op[0].s8<=*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLSEQ_I16(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X16(jvm);
  if (*jvm->op[0].s16<=*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLSEQ_I32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].s32<=*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLSEQ_I64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].s64<=*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLSEQ_F32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].f32<=*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBLSEQ_F64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].f64<=*jvm->op[0].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBEQ_I8(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X8(jvm);
  if (*jvm->op[0].s8==*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBEQ_I16(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X16(jvm);
  if (*jvm->op[0].s16==*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBEQ_I32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].s32==*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBEQ_I64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].s64==*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBEQ_F32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].f32==*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBEQ_F64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].f64==*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGREQ_I8(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X8(jvm);
  if (*jvm->op[0].s8>=*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGREQ_I16(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X16(jvm);
  if (*jvm->op[0].s16>=*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGREQ_I32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].s32>=*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGREQ_I64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].s64>=*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGREQ_F32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].f32>=*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGREQ_F64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].f64>=*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGR_I8(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X8(jvm);
  if (*jvm->op[0].s8>*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGR_I16(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X16(jvm);
  if (*jvm->op[0].s16>*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGR_I32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X32(jvm);
  if (*jvm->op[0].s32>*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGR_I64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D2C_X64(jvm);
  if (*jvm->op[0].s64>*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGR_F32(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D1_X32(jvm);
  if (*jvm->op[0].f32>*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fBGR_F64(OP_ARGS)
{
  CHECKBREAK();
  JASMINE_EA::D1_X64(jvm);
  if (*jvm->op[0].f64>*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JASMINE_OP::fCALL(OP_ARGS)
{
  if (jvm->methodStack<jvm->methodStackTop)
  {
    JASMINE_EA::D1_X32(jvm);
    *(jvm->methodStack++) = jvm->instPtr;
    jvm->instPtr = jvm->op[0].u32;
  }
  else
    jvm->exitReg = JASMINE::METHD_OVERFLOW;
}

void JASMINE_OP::fRET(OP_ARGS)
{
  if (jvm->methodStack>jvm->methodStackBase)
    jvm->instPtr = *(--jvm->methodStack);
  else
    jvm->exitReg = JASMINE::METHD_UNDERFLOW;
}

// #else // JASMINE_MACRO_EA

// #endif // JASMINE_MACRO_EA

#undef CHECKBREAK