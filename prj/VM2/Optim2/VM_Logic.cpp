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

#ifndef USE_HAND_ASM

void VMCORE::fAND_X8(CMDARGS)
{
  OPINIT();
  OP3(uint8) = OP1(uint8) & OP2(uint8);
  OPDONE();
}

void VMCORE::fAND_X16(CMDARGS)
{
  OPINIT();
  OP3(uint16) = OP1(uint16) & OP2(uint16);
  OPDONE();
}

void VMCORE::fAND_X32(CMDARGS)
{
  OPINIT();
  OP3(uint32) = OP1(uint32) & OP2(uint32);
  OPDONE();
}

void VMCORE::fAND_X64(CMDARGS)
{
  OPINIT();
  OP3(uint64) = OP1(uint64) & OP2(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fOR_X8(CMDARGS)
{
  OPINIT();
  OP3(uint8) = OP1(uint8) | OP2(uint8);
  OPDONE();
}

void VMCORE::fOR_X16(CMDARGS)
{
  OPINIT();
  OP3(uint16) = OP1(uint16) | OP2(uint16);
  OPDONE();
}

void VMCORE::fOR_X32(CMDARGS)
{
  OPINIT();
  OP3(uint32) = OP1(uint32) | OP2(uint32);
  OPDONE();
}

void VMCORE::fOR_X64(CMDARGS)
{
  OPINIT();
  OP3(uint64) = OP1(uint64) | OP2(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fXOR_X8(CMDARGS)
{
  OPINIT();
  OP3(uint8) = OP1(uint8) ^ OP2(uint8);
  OPDONE();
}

void VMCORE::fXOR_X16(CMDARGS)
{
  OPINIT();
  OP3(uint16) = OP1(uint16) ^ OP2(uint16);
  OPDONE();
}

void VMCORE::fXOR_X32(CMDARGS)
{
  OPINIT();
  OP3(uint32) = OP1(uint32) ^ OP2(uint32);
  OPDONE();
}

void VMCORE::fXOR_X64(CMDARGS)
{
  OPINIT();
  OP3(uint64) = OP1(uint64) ^ OP2(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fINV_X8(CMDARGS)
{
  OPINIT();
  OP2(uint8) = ~(OP1(uint8));
  OPDONE();
}

void VMCORE::fINV_X16(CMDARGS)
{
  OPINIT();
  OP2(uint16) = ~(OP1(uint16));
  OPDONE();
}

void VMCORE::fINV_X32(CMDARGS)
{
  OPINIT();
  OP2(uint32) = ~(OP1(uint32));
  OPDONE();
}

void VMCORE::fINV_X64(CMDARGS)
{
  OPINIT();
  OP2(uint64) = ~(OP1(uint64));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSHL_X8(CMDARGS)
{
  OPINIT();
  OP3(uint8) = OP1(uint8) << OP2(uint8);
  OPDONE();
}

void VMCORE::fSHL_X16(CMDARGS)
{
  OPINIT();
  OP3(uint16) = OP1(uint16) << OP2(uint16);
  OPDONE();
}

void VMCORE::fSHL_X32(CMDARGS)
{
  OPINIT();
  OP3(uint32) = OP1(uint32) << OP2(uint32);
  OPDONE();
}

void VMCORE::fSHL_X64(CMDARGS)
{
  OPINIT();
  OP3(uint64) = OP1(uint64) << OP2(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSHR_X8(CMDARGS)
{
  OPINIT();
  OP3(uint8) = OP1(uint8) >> OP2(uint8);
  OPDONE();
}

void VMCORE::fSHR_X16(CMDARGS)
{
  OPINIT();
  OP3(uint16) = OP1(uint16) >> OP2(uint16);
  OPDONE();
}

void VMCORE::fSHR_X32(CMDARGS)
{
  OPINIT();
  OP3(uint32) = OP1(uint32) >> OP2(uint32);
  OPDONE();
}

void VMCORE::fSHR_X64(CMDARGS)
{
  OPINIT();
  OP3(uint64) = OP1(uint64) >> OP2(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////
/*
void VMCORE::fBAND_X8(CMDARGS) {}
void VMCORE::fBAND_X16(CMDARGS) {}
void VMCORE::fBAND_X32(CMDARGS) {}
void VMCORE::fBAND_X64(CMDARGS) {}
void VMCORE::fBOR_X8(CMDARGS) {}
void VMCORE::fBOR_X16(CMDARGS) {}
void VMCORE::fBOR_X32(CMDARGS) {}
void VMCORE::fBOR_X64(CMDARGS) {}
void VMCORE::fBXOR_X8(CMDARGS) {}
void VMCORE::fBXOR_X16(CMDARGS) {}
void VMCORE::fBXOR_X32(CMDARGS) {}
void VMCORE::fBXOR_X64(CMDARGS) {}
void VMCORE::fBINV_X8(CMDARGS) {}
void VMCORE::fBINV_X16(CMDARGS) {}
void VMCORE::fBINV_X32(CMDARGS) {}
void VMCORE::fBINV_X64(CMDARGS) {}
void VMCORE::fBSHL_X8(CMDARGS) {}
void VMCORE::fBSHL_X16(CMDARGS) {}
void VMCORE::fBSHL_X32(CMDARGS) {}
void VMCORE::fBSHL_X64(CMDARGS) {}
void VMCORE::fBSHR_X8(CMDARGS) {}
void VMCORE::fBSHR_X16(CMDARGS) {}
void VMCORE::fBSHR_X32(CMDARGS) {}
void VMCORE::fBSHR_X64(CMDARGS) {}
*/

#endif