//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "VMClass.hpp"

#ifdef USE_VM_STDIO

void VMCORE::fOUT_U8(CMDARGS)
{
  OPINIT();
  printf("%c", OP1(uint8));
  OPDONE();
}

void VMCORE::fOUT_U16(CMDARGS)
{
  OPINIT();
  printf("%hu", OP1(uint16));
  OPDONE();
}

void VMCORE::fOUT_U32(CMDARGS)
{
  OPINIT();
  printf("%lu", OP1(uint32));
  OPDONE();
}

void VMCORE::fOUT_U64(CMDARGS)
{
  OPINIT();

  OPDONE();
}

void VMCORE::fOUT_S8(CMDARGS)
{
  OPINIT();
  printf("%c", OP1(sint8));
  OPDONE();
}

void VMCORE::fOUT_S16(CMDARGS)
{
  OPINIT();
  printf("%hi", OP1(sint16));
  OPDONE();
}

void VMCORE::fOUT_S32(CMDARGS)
{
  OPINIT();
  printf("%li", OP1(sint32));
  OPDONE();
}

void VMCORE::fOUT_S64(CMDARGS)
{
  OPINIT();

  OPDONE();
}

void VMCORE::fOUT_F32(CMDARGS)
{
  OPINIT();
  printf("%f", OP1(float32));
  OPDONE();
}

void VMCORE::fOUT_F64(CMDARGS)
{
  OPINIT();
  printf("%f", OP1(float64));
  OPDONE();
}

void VMCORE::fOUT_STR(CMDARGS)
{
  OPINIT();
  printf("%s", POP1(char));
  OPDONE();
}

void VMCORE::fINP_U8(CMDARGS)
{
  OPINIT();
  scanf("%c",OP1(uint8));
  OPDONE();
}

void VMCORE::fINP_U16(CMDARGS)
{
  OPINIT();
  scanf("%hu", OP1(uint16));
  OPDONE();
}

void VMCORE::fINP_U32(CMDARGS)
{
  OPINIT();
  scanf("%lu", OP1(uint32));
  OPDONE();
}

void VMCORE::fINP_U64(CMDARGS)
{
  OPINIT();

  OPDONE();
}

void VMCORE::fINP_S8(CMDARGS)
{
  OPINIT();
  scanf("%c", OP1(sint8));
  OPDONE();
}

void VMCORE::fINP_S16(CMDARGS)
{
  OPINIT();
  scanf("%hi", OP1(sint16));
  OPDONE();
}

void VMCORE::fINP_S32(CMDARGS)
{
  OPINIT();
  scanf("%li", OP1(sint32));
  OPDONE();
}

void VMCORE::fINP_S64(CMDARGS)
{
  OPINIT();

  OPDONE();
}

void VMCORE::fINP_F32(CMDARGS)
{
  OPINIT();
  scanf("%f", OP1(float32));
  OPDONE();
}

void VMCORE::fINP_F64(CMDARGS)
{
  OPINIT();
  scanf("%lf", OP1(float64));
  OPDONE();
}

#endif
