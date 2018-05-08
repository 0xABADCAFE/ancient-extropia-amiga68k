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


/////////////////////////////////////////////////////////////////////
//
//  Effective address calculation
//
//  When the ea funcs are called, instPtr points to the current
//  opcode word. During evaluation, any literal data or extension
//  words cause instPtr to be incremented.
//
//  Upon completion, instPtr points to the word following the last
//  extension word/literal data:
//
//  Before
//
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ] <- instPtr
//  [ ea 1 extension word             ]
//  [ ea 2 extension word             ]
//  [ instruction specific data       ]
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ]
//
//  After
//
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ]
//  [ ea 1 extension word             ]
//  [ ea 2 extension word             ]
//  [ instruction specific data       ] <- instPtr
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ]
//
//  In most cases there will not be any instruction soecific data
//  and instPtr points to the subsequent instruction
//
/////////////////////////////////////////////////////////////////////

#define EAOFFSET()      *((sint32*)(++This->instPtr))

#if (X_ENDIAN == XA_BIGENDIAN)
#define GETLITERAL(n)   (((uint8*)(++This->instPtr))+(4U-n))
#define IRRO_BASEREG    This->gpRegs[((uint8*)(This->instPtr))[3]]
#define IRRO_OFSTREG()  This->gpRegs[((uint8*)(This->instPtr))[2]].ValS32()
#else
#define GETLITERAL(n)   ((uint8*)(++This->instPtr))
#define IRRO_BASEREG    This->gpRegs[((uint8*)(This->instPtr))[0]]
#define IRRO_OFSTREG()  This->gpRegs[((uint8*)(This->instPtr))[1]].ValS32()
#endif

void* VMCORE::fR0(EAFARGS)      { return This->gpRegs[0].Data(s); }
void* VMCORE::fR1(EAFARGS)      { return This->gpRegs[1].Data(s); }
void* VMCORE::fR2(EAFARGS)      { return This->gpRegs[2].Data(s); }
void* VMCORE::fR3(EAFARGS)      { return This->gpRegs[3].Data(s); }
void* VMCORE::fR4(EAFARGS)      { return This->gpRegs[4].Data(s); }
void* VMCORE::fR5(EAFARGS)      { return This->gpRegs[5].Data(s); }
void* VMCORE::fR6(EAFARGS)      { return This->gpRegs[6].Data(s); }
void* VMCORE::fR7(EAFARGS)      { return This->gpRegs[7].Data(s); }
void* VMCORE::fR8(EAFARGS)      { return This->gpRegs[8].Data(s); }
void* VMCORE::fR9(EAFARGS)      { return This->gpRegs[9].Data(s); }
void* VMCORE::fR10(EAFARGS)   { return This->gpRegs[10].Data(s); }
void* VMCORE::fR11(EAFARGS)   { return This->gpRegs[11].Data(s); }
void* VMCORE::fR12(EAFARGS)   { return This->gpRegs[12].Data(s); }
void* VMCORE::fR13(EAFARGS)   { return This->gpRegs[13].Data(s); }
void* VMCORE::fR14(EAFARGS)   { return This->gpRegs[14].Data(s); }
void* VMCORE::fR15(EAFARGS)   { return This->gpRegs[15].Data(s); }
void* VMCORE::fR16(EAFARGS)   { return This->gpRegs[16].Data(s); }
void* VMCORE::fR17(EAFARGS)   { return This->gpRegs[17].Data(s); }
void* VMCORE::fR18(EAFARGS)   { return This->gpRegs[18].Data(s); }
void* VMCORE::fR19(EAFARGS)   { return This->gpRegs[19].Data(s); }
void* VMCORE::fR20(EAFARGS)   { return This->gpRegs[20].Data(s); }
void* VMCORE::fR21(EAFARGS)   { return This->gpRegs[21].Data(s); }
void* VMCORE::fR22(EAFARGS)   { return This->gpRegs[22].Data(s); }
void* VMCORE::fR23(EAFARGS)   { return This->gpRegs[23].Data(s); }
void* VMCORE::fR24(EAFARGS)   { return This->gpRegs[24].Data(s); }
void* VMCORE::fR25(EAFARGS)   { return This->gpRegs[25].Data(s); }
void* VMCORE::fR26(EAFARGS)   { return This->gpRegs[26].Data(s); }
void* VMCORE::fR27(EAFARGS)   { return This->gpRegs[27].Data(s); }
void* VMCORE::fR28(EAFARGS)   { return This->gpRegs[28].Data(s); }
void* VMCORE::fR29(EAFARGS)   { return This->gpRegs[29].Data(s); }
void* VMCORE::fR30(EAFARGS)   { return This->gpRegs[30].Data(s); }
void* VMCORE::fR31(EAFARGS)   { return This->gpRegs[31].Data(s); }

void* VMCORE::fIR0(EAFARGS)   { return This->gpRegs[0].PtrU8(); }
void* VMCORE::fIR1(EAFARGS)   { return This->gpRegs[1].PtrU8(); }
void* VMCORE::fIR2(EAFARGS)   { return This->gpRegs[2].PtrU8(); }
void* VMCORE::fIR3(EAFARGS)   { return This->gpRegs[3].PtrU8(); }
void* VMCORE::fIR4(EAFARGS)   { return This->gpRegs[4].PtrU8(); }
void* VMCORE::fIR5(EAFARGS)   { return This->gpRegs[5].PtrU8(); }
void* VMCORE::fIR6(EAFARGS)   { return This->gpRegs[6].PtrU8(); }
void* VMCORE::fIR7(EAFARGS)   { return This->gpRegs[7].PtrU8(); }
void* VMCORE::fIR8(EAFARGS)   { return This->gpRegs[8].PtrU8(); }
void* VMCORE::fIR9(EAFARGS)   { return This->gpRegs[9].PtrU8(); }
void* VMCORE::fIR10(EAFARGS)    { return This->gpRegs[10].PtrU8(); }
void* VMCORE::fIR11(EAFARGS)    { return This->gpRegs[11].PtrU8(); }
void* VMCORE::fIR12(EAFARGS)    { return This->gpRegs[12].PtrU8(); }
void* VMCORE::fIR13(EAFARGS)    { return This->gpRegs[13].PtrU8(); }
void* VMCORE::fIR14(EAFARGS)    { return This->gpRegs[14].PtrU8(); }
void* VMCORE::fIR15(EAFARGS)    { return This->gpRegs[15].PtrU8(); }
void* VMCORE::fIR16(EAFARGS)    { return This->gpRegs[16].PtrU8(); }
void* VMCORE::fIR17(EAFARGS)    { return This->gpRegs[17].PtrU8(); }
void* VMCORE::fIR18(EAFARGS)    { return This->gpRegs[18].PtrU8(); }
void* VMCORE::fIR19(EAFARGS)    { return This->gpRegs[19].PtrU8(); }
void* VMCORE::fIR20(EAFARGS)    { return This->gpRegs[20].PtrU8(); }
void* VMCORE::fIR21(EAFARGS)    { return This->gpRegs[21].PtrU8(); }
void* VMCORE::fIR22(EAFARGS)    { return This->gpRegs[22].PtrU8(); }
void* VMCORE::fIR23(EAFARGS)    { return This->gpRegs[23].PtrU8(); }
void* VMCORE::fIR24(EAFARGS)    { return This->gpRegs[24].PtrU8(); }
void* VMCORE::fIR25(EAFARGS)    { return This->gpRegs[25].PtrU8(); }
void* VMCORE::fIR26(EAFARGS)    { return This->gpRegs[26].PtrU8(); }
void* VMCORE::fIR27(EAFARGS)    { return This->gpRegs[27].PtrU8(); }
void* VMCORE::fIR28(EAFARGS)    { return This->gpRegs[28].PtrU8(); }
void* VMCORE::fIR29(EAFARGS)    { return This->gpRegs[29].PtrU8(); }
void* VMCORE::fIR30(EAFARGS)    { return This->gpRegs[30].PtrU8(); }
void* VMCORE::fIR31(EAFARGS)    { return This->gpRegs[31].PtrU8(); }

void* VMCORE::fLIR0(EAFARGS)    { return This->gpRegs[0].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR1(EAFARGS)    { return This->gpRegs[1].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR2(EAFARGS)    { return This->gpRegs[2].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR3(EAFARGS)    { return This->gpRegs[3].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR4(EAFARGS)    { return This->gpRegs[4].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR5(EAFARGS)    { return This->gpRegs[5].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR6(EAFARGS)    { return This->gpRegs[6].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR7(EAFARGS)    { return This->gpRegs[7].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR8(EAFARGS)    { return This->gpRegs[8].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR9(EAFARGS)    { return This->gpRegs[9].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR10(EAFARGS) { return This->gpRegs[10].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR11(EAFARGS) { return This->gpRegs[11].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR12(EAFARGS) { return This->gpRegs[12].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR13(EAFARGS) { return This->gpRegs[13].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR14(EAFARGS) { return This->gpRegs[14].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR15(EAFARGS) { return This->gpRegs[15].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR16(EAFARGS) { return This->gpRegs[16].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR17(EAFARGS) { return This->gpRegs[17].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR18(EAFARGS) { return This->gpRegs[18].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR19(EAFARGS) { return This->gpRegs[19].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR20(EAFARGS) { return This->gpRegs[20].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR21(EAFARGS) { return This->gpRegs[21].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR22(EAFARGS) { return This->gpRegs[22].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR23(EAFARGS) { return This->gpRegs[23].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR24(EAFARGS) { return This->gpRegs[24].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR25(EAFARGS) { return This->gpRegs[25].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR26(EAFARGS) { return This->gpRegs[26].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR27(EAFARGS) { return This->gpRegs[27].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR28(EAFARGS) { return This->gpRegs[28].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR29(EAFARGS) { return This->gpRegs[29].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR30(EAFARGS) { return This->gpRegs[30].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR31(EAFARGS) { return This->gpRegs[31].PtrU8() + EAOFFSET(); }

void* VMCORE::fLUIR0(EAFARGS)
{
  uint8* &p = This->gpRegs[0].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR1(EAFARGS)
{
  uint8* &p = This->gpRegs[1].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR2(EAFARGS)
{
  uint8* &p = This->gpRegs[2].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR3(EAFARGS)
{
  uint8* &p = This->gpRegs[3].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR4(EAFARGS)
{
  uint8* &p = This->gpRegs[4].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR5(EAFARGS)
{
  uint8* &p = This->gpRegs[5].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR6(EAFARGS)
{
  uint8* &p = This->gpRegs[6].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR7(EAFARGS)
{
  uint8* &p = This->gpRegs[7].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR8(EAFARGS)
{
  uint8* &p = This->gpRegs[8].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR9(EAFARGS)
{
  uint8* &p = This->gpRegs[9].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR10(EAFARGS)
{
  uint8* &p = This->gpRegs[10].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR11(EAFARGS)
{
  uint8* &p = This->gpRegs[11].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR12(EAFARGS)
{
  uint8* &p = This->gpRegs[12].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR13(EAFARGS)
{
  uint8* &p = This->gpRegs[13].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR14(EAFARGS)
{
  uint8* &p = This->gpRegs[14].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR15(EAFARGS)
{
  uint8* &p = This->gpRegs[15].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR16(EAFARGS)
{
  uint8* &p = This->gpRegs[16].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR17(EAFARGS)
{
  uint8* &p = This->gpRegs[17].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR18(EAFARGS)
{
  uint8* &p = This->gpRegs[18].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR19(EAFARGS)
{
  uint8* &p = This->gpRegs[19].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR20(EAFARGS)
{
  uint8* &p = This->gpRegs[20].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR21(EAFARGS)
{
  uint8* &p = This->gpRegs[21].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR22(EAFARGS)
{
  uint8* &p = This->gpRegs[22].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR23(EAFARGS)
{
  uint8* &p = This->gpRegs[23].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR24(EAFARGS)
{
  uint8* &p = This->gpRegs[24].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR25(EAFARGS)
{
  uint8* &p = This->gpRegs[25].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR26(EAFARGS)
{
  uint8* &p = This->gpRegs[26].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR27(EAFARGS)
{
  uint8* &p = This->gpRegs[27].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR28(EAFARGS)
{
  uint8* &p = This->gpRegs[28].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR29(EAFARGS)
{
  uint8* &p = This->gpRegs[29].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR30(EAFARGS)
{
  uint8* &p = This->gpRegs[30].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fLUIR31(EAFARGS)
{
  uint8* &p = This->gpRegs[31].PtrU8();
  p += EAOFFSET();
  return p;
}

void* VMCORE::fIRRO(EAFARGS)
{
  This->instPtr++;
  return IRRO_BASEREG.PtrU8() + IRRO_OFSTREG();
}

void* VMCORE::fIRROU(EAFARGS)
{
  This->instPtr++;
  uint8*  &p = IRRO_BASEREG.PtrU8();
  p += IRRO_OFSTREG();
  return p;
}

void* VMCORE::fCLONE1ST(EAFARGS)  { return This->op[0].u8; }
void* VMCORE::fCLONE2ND(EAFARGS)  { return This->op[1].u8; }
void* VMCORE::fCTR(EAFARGS)     { return &This->countReg; }
void* VMCORE::fDS(EAFARGS)        { return ((uint8*)This->dataSectPtr) + EAOFFSET(); }
void* VMCORE::fCDS(EAFARGS)     { return ((uint8*)This->constSectPtr) + EAOFFSET(); }
void* VMCORE::fLITERAL(EAFARGS) { return GETLITERAL(s);}

#undef EAOFFSET
#undef GETLITERAL
#undef IRRO_BASEREG
#undef IRRO_OFSTREG


