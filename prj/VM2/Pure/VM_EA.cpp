//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "VM_Class.hpp"


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



#define EAOFFSET()			*((sint32*)(++This->instPtr))

#if (X_ENDIAN == XA_BIGENDIAN)
#define GETLITERAL(n) 	(((uint8*)(++This->instPtr))+4-(n))
#define IRRO_BASEREG 		This->gpRegs[((uint8*)(This->instPtr))[3]]
#define IRRO_OFSTREG() 	This->gpRegs[((uint8*)(This->instPtr))[2]].ValS32()
#define IRRO_SCALE()		((sint32)(*((uint16*)This->instPtr)))
#else
#define GETLITERAL(n) 	((uint8*)(++This->instPtr))
#define IRRO_BASEREG 		This->gpRegs[((uint8*)(This->instPtr))[0]]
#define IRRO_OFSTREG() 	This->gpRegs[((uint8*)(This->instPtr))[1]].ValS32()
#define IRRO_SCALE()		((sint32)((uint16*)(This->instPtr)[1]))
#endif

void* VMCORE::fR0(EA_ARGS)		{	return This->gpRegs[0].Data(s); }
void* VMCORE::fR1(EA_ARGS)		{	return This->gpRegs[1].Data(s); }
void* VMCORE::fR2(EA_ARGS)		{	return This->gpRegs[2].Data(s); }
void* VMCORE::fR3(EA_ARGS)		{	return This->gpRegs[3].Data(s); }
void* VMCORE::fR4(EA_ARGS)		{	return This->gpRegs[4].Data(s); }
void* VMCORE::fR5(EA_ARGS)		{	return This->gpRegs[5].Data(s); }
void* VMCORE::fR6(EA_ARGS)		{	return This->gpRegs[6].Data(s); }
void* VMCORE::fR7(EA_ARGS)		{	return This->gpRegs[7].Data(s); }
void* VMCORE::fR8(EA_ARGS)		{	return This->gpRegs[8].Data(s); }
void* VMCORE::fR9(EA_ARGS)		{	return This->gpRegs[9].Data(s); }
void* VMCORE::fR10(EA_ARGS)		{	return This->gpRegs[10].Data(s); }
void* VMCORE::fR11(EA_ARGS)		{	return This->gpRegs[11].Data(s); }
void* VMCORE::fR12(EA_ARGS)		{	return This->gpRegs[12].Data(s); }
void* VMCORE::fR13(EA_ARGS)		{	return This->gpRegs[13].Data(s); }
void* VMCORE::fR14(EA_ARGS)		{	return This->gpRegs[14].Data(s); }
void* VMCORE::fR15(EA_ARGS)		{	return This->gpRegs[15].Data(s); }
void* VMCORE::fR16(EA_ARGS)		{	return This->gpRegs[16].Data(s); }
void* VMCORE::fR17(EA_ARGS)		{	return This->gpRegs[17].Data(s); }
void* VMCORE::fR18(EA_ARGS)		{	return This->gpRegs[18].Data(s); }
void* VMCORE::fR19(EA_ARGS)		{	return This->gpRegs[19].Data(s); }
void* VMCORE::fR20(EA_ARGS)		{	return This->gpRegs[20].Data(s); }
void* VMCORE::fR21(EA_ARGS)		{	return This->gpRegs[21].Data(s); }
void* VMCORE::fR22(EA_ARGS)		{	return This->gpRegs[22].Data(s); }
void* VMCORE::fR23(EA_ARGS)		{	return This->gpRegs[23].Data(s); }
void* VMCORE::fR24(EA_ARGS)		{	return This->gpRegs[24].Data(s); }
void* VMCORE::fR25(EA_ARGS)		{	return This->gpRegs[25].Data(s); }
void* VMCORE::fR26(EA_ARGS)		{	return This->gpRegs[26].Data(s); }
void* VMCORE::fR27(EA_ARGS)		{	return This->gpRegs[27].Data(s); }
void* VMCORE::fR28(EA_ARGS)		{	return This->gpRegs[28].Data(s); }
void* VMCORE::fR29(EA_ARGS)		{	return This->gpRegs[29].Data(s); }
void* VMCORE::fR30(EA_ARGS)		{	return This->gpRegs[30].Data(s); }
void* VMCORE::fR31(EA_ARGS)		{	return This->gpRegs[31].Data(s); }

void* VMCORE::fIR0(EA_ARGS)		{	return This->gpRegs[0].PtrU8(); }
void* VMCORE::fIR1(EA_ARGS)		{	return This->gpRegs[1].PtrU8(); }
void* VMCORE::fIR2(EA_ARGS)		{	return This->gpRegs[2].PtrU8(); }
void* VMCORE::fIR3(EA_ARGS)		{	return This->gpRegs[3].PtrU8(); }
void* VMCORE::fIR4(EA_ARGS)		{	return This->gpRegs[4].PtrU8(); }
void* VMCORE::fIR5(EA_ARGS)		{	return This->gpRegs[5].PtrU8(); }
void* VMCORE::fIR6(EA_ARGS)		{	return This->gpRegs[6].PtrU8(); }
void* VMCORE::fIR7(EA_ARGS)		{	return This->gpRegs[7].PtrU8(); }
void* VMCORE::fIR8(EA_ARGS)		{	return This->gpRegs[8].PtrU8(); }
void* VMCORE::fIR9(EA_ARGS)		{	return This->gpRegs[9].PtrU8(); }
void* VMCORE::fIR10(EA_ARGS)	{	return This->gpRegs[10].PtrU8(); }
void* VMCORE::fIR11(EA_ARGS)	{	return This->gpRegs[11].PtrU8(); }
void* VMCORE::fIR12(EA_ARGS)	{	return This->gpRegs[12].PtrU8(); }
void* VMCORE::fIR13(EA_ARGS)	{	return This->gpRegs[13].PtrU8(); }
void* VMCORE::fIR14(EA_ARGS)	{	return This->gpRegs[14].PtrU8(); }
void* VMCORE::fIR15(EA_ARGS)	{	return This->gpRegs[15].PtrU8(); }
void* VMCORE::fIR16(EA_ARGS)	{	return This->gpRegs[16].PtrU8(); }
void* VMCORE::fIR17(EA_ARGS)	{	return This->gpRegs[17].PtrU8(); }
void* VMCORE::fIR18(EA_ARGS)	{	return This->gpRegs[18].PtrU8(); }
void* VMCORE::fIR19(EA_ARGS)	{	return This->gpRegs[19].PtrU8(); }
void* VMCORE::fIR20(EA_ARGS)	{	return This->gpRegs[20].PtrU8(); }
void* VMCORE::fIR21(EA_ARGS)	{	return This->gpRegs[21].PtrU8(); }
void* VMCORE::fIR22(EA_ARGS)	{	return This->gpRegs[22].PtrU8(); }
void* VMCORE::fIR23(EA_ARGS)	{	return This->gpRegs[23].PtrU8(); }
void* VMCORE::fIR24(EA_ARGS)	{	return This->gpRegs[24].PtrU8(); }
void* VMCORE::fIR25(EA_ARGS)	{	return This->gpRegs[25].PtrU8(); }
void* VMCORE::fIR26(EA_ARGS)	{	return This->gpRegs[26].PtrU8(); }
void* VMCORE::fIR27(EA_ARGS)	{	return This->gpRegs[27].PtrU8(); }
void* VMCORE::fIR28(EA_ARGS)	{	return This->gpRegs[28].PtrU8(); }
void* VMCORE::fIR29(EA_ARGS)	{	return This->gpRegs[29].PtrU8(); }
void* VMCORE::fIR30(EA_ARGS)	{	return This->gpRegs[30].PtrU8(); }
void* VMCORE::fIR31(EA_ARGS)	{	return This->gpRegs[31].PtrU8(); }

void* VMCORE::fLIR0(EA_ARGS)	{ return This->gpRegs[0].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR1(EA_ARGS)	{ return This->gpRegs[1].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR2(EA_ARGS)	{ return This->gpRegs[2].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR3(EA_ARGS)	{ return This->gpRegs[3].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR4(EA_ARGS)	{ return This->gpRegs[4].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR5(EA_ARGS)	{ return This->gpRegs[5].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR6(EA_ARGS)	{ return This->gpRegs[6].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR7(EA_ARGS)	{ return This->gpRegs[7].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR8(EA_ARGS)	{ return This->gpRegs[8].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR9(EA_ARGS)	{ return This->gpRegs[9].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR10(EA_ARGS)	{ return This->gpRegs[10].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR11(EA_ARGS)	{ return This->gpRegs[11].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR12(EA_ARGS)	{ return This->gpRegs[12].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR13(EA_ARGS)	{ return This->gpRegs[13].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR14(EA_ARGS)	{ return This->gpRegs[14].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR15(EA_ARGS)	{ return This->gpRegs[15].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR16(EA_ARGS)	{ return This->gpRegs[16].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR17(EA_ARGS)	{ return This->gpRegs[17].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR18(EA_ARGS)	{ return This->gpRegs[18].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR19(EA_ARGS)	{ return This->gpRegs[19].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR20(EA_ARGS)	{ return This->gpRegs[20].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR21(EA_ARGS)	{ return This->gpRegs[21].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR22(EA_ARGS)	{ return This->gpRegs[22].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR23(EA_ARGS)	{ return This->gpRegs[23].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR24(EA_ARGS)	{ return This->gpRegs[24].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR25(EA_ARGS)	{ return This->gpRegs[25].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR26(EA_ARGS)	{ return This->gpRegs[26].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR27(EA_ARGS)	{ return This->gpRegs[27].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR28(EA_ARGS)	{ return This->gpRegs[28].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR29(EA_ARGS)	{ return This->gpRegs[29].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR30(EA_ARGS)	{ return This->gpRegs[30].PtrU8() + EAOFFSET(); }
void* VMCORE::fLIR31(EA_ARGS)	{ return This->gpRegs[31].PtrU8() + EAOFFSET(); }

void* VMCORE::fLUIR0(EA_ARGS)
{
	uint8* &p = This->gpRegs[0].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR1(EA_ARGS)
{
	uint8* &p = This->gpRegs[1].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR2(EA_ARGS)
{
	uint8* &p = This->gpRegs[2].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR3(EA_ARGS)
{
	uint8* &p = This->gpRegs[3].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR4(EA_ARGS)
{
	uint8* &p = This->gpRegs[4].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR5(EA_ARGS)
{
	uint8* &p = This->gpRegs[5].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR6(EA_ARGS)
{
	uint8* &p = This->gpRegs[6].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR7(EA_ARGS)
{
	uint8* &p = This->gpRegs[7].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR8(EA_ARGS)
{
	uint8* &p = This->gpRegs[8].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR9(EA_ARGS)
{
	uint8* &p = This->gpRegs[9].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR10(EA_ARGS)
{
	uint8* &p = This->gpRegs[10].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR11(EA_ARGS)
{
	uint8* &p = This->gpRegs[11].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR12(EA_ARGS)
{
	uint8* &p = This->gpRegs[12].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR13(EA_ARGS)
{
	uint8* &p = This->gpRegs[13].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR14(EA_ARGS)
{
	uint8* &p = This->gpRegs[14].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR15(EA_ARGS)
{
	uint8* &p = This->gpRegs[15].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR16(EA_ARGS)
{
	uint8* &p = This->gpRegs[16].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR17(EA_ARGS)
{
	uint8* &p = This->gpRegs[17].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR18(EA_ARGS)
{
	uint8* &p = This->gpRegs[18].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR19(EA_ARGS)
{
	uint8* &p = This->gpRegs[19].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR20(EA_ARGS)
{
	uint8* &p = This->gpRegs[20].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR21(EA_ARGS)
{
	uint8* &p = This->gpRegs[21].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR22(EA_ARGS)
{
	uint8* &p = This->gpRegs[22].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR23(EA_ARGS)
{
	uint8* &p = This->gpRegs[23].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR24(EA_ARGS)
{
	uint8* &p = This->gpRegs[24].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR25(EA_ARGS)
{
	uint8* &p = This->gpRegs[25].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR26(EA_ARGS)
{
	uint8* &p = This->gpRegs[26].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR27(EA_ARGS)
{
	uint8* &p = This->gpRegs[27].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR28(EA_ARGS)
{
	uint8* &p = This->gpRegs[28].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR29(EA_ARGS)
{
	uint8* &p = This->gpRegs[29].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR30(EA_ARGS)
{
	uint8* &p = This->gpRegs[30].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fLUIR31(EA_ARGS)
{
	uint8* &p = This->gpRegs[31].PtrU8();
	p += EAOFFSET();
	return p;
}

void* VMCORE::fIRRO(EA_ARGS)
{
	This->instPtr++;
	return IRRO_BASEREG.PtrU8() + IRRO_OFSTREG();
}

void* VMCORE::fIRROU(EA_ARGS)
{
	This->instPtr++;
	uint8*	&p = IRRO_BASEREG.PtrU8();
	p += IRRO_OFSTREG();
	return p;
}

void* VMCORE::fIRSRO(EA_ARGS)
{
	This->instPtr++;
	return IRRO_BASEREG.PtrU8() + IRRO_SCALE()*IRRO_OFSTREG();
}

void* VMCORE::fIRSROU(EA_ARGS)
{
	This->instPtr++;
	uint8*	&p = IRRO_BASEREG.PtrU8();
	p += IRRO_SCALE()*IRRO_OFSTREG();
	return p;
}

void* VMCORE::fCTR(EA_ARGS)			{ return &This->countReg; }
void* VMCORE::fDS(EA_ARGS)			{	return ((uint8*)This->dataSectPtr) + EAOFFSET(); }
void* VMCORE::fCDS(EA_ARGS)			{	return ((uint8*)This->constSectPtr) + EAOFFSET(); }
void* VMCORE::fLITERAL(EA_ARGS)	{ return GETLITERAL(s);}

void* VMCORE::fOFFSET_PC(EA_ARGS)		{ This->instPtr++; return This->instPtr + *((sint32*)This->instPtr); }


#undef EAOFFSET
#undef GETLITERAL
#undef IRRO_BASEREG
#undef IRRO_OFSTREG


