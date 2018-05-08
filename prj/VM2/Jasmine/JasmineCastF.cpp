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


#ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Seperate EA pass version, operand pointers saved in op[0] - op[2]
//
/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fF64_F32(OP_ARGS)
{
  JASMINE_EA::D2(jvm, 4,8);
  *jvm->op[1].f64 = *jvm->op[0].f32;
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fF32_F64(OP_ARGS)
{
  JASMINE_EA::D2(jvm, 8,4);
  *jvm->op[1].f32 = (float32)(*jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fF64_F32(OP_ARGS)
{
  OPINIT();
  OP2D_64(float64) = OP1_32(float32);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fF32_F64(OP_ARGS)
{
  OPINIT();
  OP2D_32(float32) = (float32)(OP1_64(float64));
  OPDONE();
}

#endif // #ifndef JASMINE_MACRO_EA

