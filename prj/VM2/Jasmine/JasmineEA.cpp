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
//  In most cases there will not be any instruction specific data
//  and instPtr points to the subsequent instruction
//
/////////////////////////////////////////////////////////////////////



#define EAOFFSET()			*((sint32*)(++jvm->instPtr))

#if (X_ENDIAN == XA_BIGENDIAN)
#define GETLITERAL(n) 	(((uint8*)(++jvm->instPtr))+4-(n))
#define IRRO_BASEREG 		jvm->gpRegs[((uint8*)(jvm->instPtr))[3]]
#define IRRO_OFSTREG() 	jvm->gpRegs[((uint8*)(jvm->instPtr))[2]].ValS32()
#define IRRO_SCALE()		((sint32)(*((uint16*)jvm->instPtr)))
#else
#define GETLITERAL(n) 	((uint8*)(++jvm->instPtr))
#define IRRO_BASEREG 		jvm->gpRegs[((uint8*)(jvm->instPtr))[0]]
#define IRRO_OFSTREG() 	jvm->gpRegs[((uint8*)(jvm->instPtr))[1]].ValS32()
#define IRRO_SCALE()		((sint32)((uint16*)(jvm->instPtr)[1]))
#endif

void* JASMINE_EA::fR0(EA_ARGS)		{	return jvm->gpRegs[0].Data(s); }
void* JASMINE_EA::fR1(EA_ARGS)		{	return jvm->gpRegs[1].Data(s); }
void* JASMINE_EA::fR2(EA_ARGS)		{	return jvm->gpRegs[2].Data(s); }
void* JASMINE_EA::fR3(EA_ARGS)		{	return jvm->gpRegs[3].Data(s); }
void* JASMINE_EA::fR4(EA_ARGS)		{	return jvm->gpRegs[4].Data(s); }
void* JASMINE_EA::fR5(EA_ARGS)		{	return jvm->gpRegs[5].Data(s); }
void* JASMINE_EA::fR6(EA_ARGS)		{	return jvm->gpRegs[6].Data(s); }
void* JASMINE_EA::fR7(EA_ARGS)		{	return jvm->gpRegs[7].Data(s); }
void* JASMINE_EA::fR8(EA_ARGS)		{	return jvm->gpRegs[8].Data(s); }
void* JASMINE_EA::fR9(EA_ARGS)		{	return jvm->gpRegs[9].Data(s); }
void* JASMINE_EA::fR10(EA_ARGS)		{	return jvm->gpRegs[10].Data(s); }
void* JASMINE_EA::fR11(EA_ARGS)		{	return jvm->gpRegs[11].Data(s); }
void* JASMINE_EA::fR12(EA_ARGS)		{	return jvm->gpRegs[12].Data(s); }
void* JASMINE_EA::fR13(EA_ARGS)		{	return jvm->gpRegs[13].Data(s); }
void* JASMINE_EA::fR14(EA_ARGS)		{	return jvm->gpRegs[14].Data(s); }
void* JASMINE_EA::fR15(EA_ARGS)		{	return jvm->gpRegs[15].Data(s); }
void* JASMINE_EA::fR16(EA_ARGS)		{	return jvm->gpRegs[16].Data(s); }
void* JASMINE_EA::fR17(EA_ARGS)		{	return jvm->gpRegs[17].Data(s); }
void* JASMINE_EA::fR18(EA_ARGS)		{	return jvm->gpRegs[18].Data(s); }
void* JASMINE_EA::fR19(EA_ARGS)		{	return jvm->gpRegs[19].Data(s); }
void* JASMINE_EA::fR20(EA_ARGS)		{	return jvm->gpRegs[20].Data(s); }
void* JASMINE_EA::fR21(EA_ARGS)		{	return jvm->gpRegs[21].Data(s); }
void* JASMINE_EA::fR22(EA_ARGS)		{	return jvm->gpRegs[22].Data(s); }
void* JASMINE_EA::fR23(EA_ARGS)		{	return jvm->gpRegs[23].Data(s); }
void* JASMINE_EA::fR24(EA_ARGS)		{	return jvm->gpRegs[24].Data(s); }
void* JASMINE_EA::fR25(EA_ARGS)		{	return jvm->gpRegs[25].Data(s); }
void* JASMINE_EA::fR26(EA_ARGS)		{	return jvm->gpRegs[26].Data(s); }
void* JASMINE_EA::fR27(EA_ARGS)		{	return jvm->gpRegs[27].Data(s); }
void* JASMINE_EA::fR28(EA_ARGS)		{	return jvm->gpRegs[28].Data(s); }
void* JASMINE_EA::fR29(EA_ARGS)		{	return jvm->gpRegs[29].Data(s); }
void* JASMINE_EA::fR30(EA_ARGS)		{	return jvm->gpRegs[30].Data(s); }
void* JASMINE_EA::fR31(EA_ARGS)		{	return jvm->gpRegs[31].Data(s); }

void* JASMINE_EA::fIR0(EA_ARGS)		{	return jvm->gpRegs[0].PtrU8(); }
void* JASMINE_EA::fIR1(EA_ARGS)		{	return jvm->gpRegs[1].PtrU8(); }
void* JASMINE_EA::fIR2(EA_ARGS)		{	return jvm->gpRegs[2].PtrU8(); }
void* JASMINE_EA::fIR3(EA_ARGS)		{	return jvm->gpRegs[3].PtrU8(); }
void* JASMINE_EA::fIR4(EA_ARGS)		{	return jvm->gpRegs[4].PtrU8(); }
void* JASMINE_EA::fIR5(EA_ARGS)		{	return jvm->gpRegs[5].PtrU8(); }
void* JASMINE_EA::fIR6(EA_ARGS)		{	return jvm->gpRegs[6].PtrU8(); }
void* JASMINE_EA::fIR7(EA_ARGS)		{	return jvm->gpRegs[7].PtrU8(); }
void* JASMINE_EA::fIR8(EA_ARGS)		{	return jvm->gpRegs[8].PtrU8(); }
void* JASMINE_EA::fIR9(EA_ARGS)		{	return jvm->gpRegs[9].PtrU8(); }
void* JASMINE_EA::fIR10(EA_ARGS)	{	return jvm->gpRegs[10].PtrU8(); }
void* JASMINE_EA::fIR11(EA_ARGS)	{	return jvm->gpRegs[11].PtrU8(); }
void* JASMINE_EA::fIR12(EA_ARGS)	{	return jvm->gpRegs[12].PtrU8(); }
void* JASMINE_EA::fIR13(EA_ARGS)	{	return jvm->gpRegs[13].PtrU8(); }
void* JASMINE_EA::fIR14(EA_ARGS)	{	return jvm->gpRegs[14].PtrU8(); }
void* JASMINE_EA::fIR15(EA_ARGS)	{	return jvm->gpRegs[15].PtrU8(); }
void* JASMINE_EA::fIR16(EA_ARGS)	{	return jvm->gpRegs[16].PtrU8(); }
void* JASMINE_EA::fIR17(EA_ARGS)	{	return jvm->gpRegs[17].PtrU8(); }
void* JASMINE_EA::fIR18(EA_ARGS)	{	return jvm->gpRegs[18].PtrU8(); }
void* JASMINE_EA::fIR19(EA_ARGS)	{	return jvm->gpRegs[19].PtrU8(); }
void* JASMINE_EA::fIR20(EA_ARGS)	{	return jvm->gpRegs[20].PtrU8(); }
void* JASMINE_EA::fIR21(EA_ARGS)	{	return jvm->gpRegs[21].PtrU8(); }
void* JASMINE_EA::fIR22(EA_ARGS)	{	return jvm->gpRegs[22].PtrU8(); }
void* JASMINE_EA::fIR23(EA_ARGS)	{	return jvm->gpRegs[23].PtrU8(); }
void* JASMINE_EA::fIR24(EA_ARGS)	{	return jvm->gpRegs[24].PtrU8(); }
void* JASMINE_EA::fIR25(EA_ARGS)	{	return jvm->gpRegs[25].PtrU8(); }
void* JASMINE_EA::fIR26(EA_ARGS)	{	return jvm->gpRegs[26].PtrU8(); }
void* JASMINE_EA::fIR27(EA_ARGS)	{	return jvm->gpRegs[27].PtrU8(); }
void* JASMINE_EA::fIR28(EA_ARGS)	{	return jvm->gpRegs[28].PtrU8(); }
void* JASMINE_EA::fIR29(EA_ARGS)	{	return jvm->gpRegs[29].PtrU8(); }
void* JASMINE_EA::fIR30(EA_ARGS)	{	return jvm->gpRegs[30].PtrU8(); }
void* JASMINE_EA::fIR31(EA_ARGS)	{	return jvm->gpRegs[31].PtrU8(); }

void* JASMINE_EA::fLIR0(EA_ARGS)	{ return jvm->gpRegs[0].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR1(EA_ARGS)	{ return jvm->gpRegs[1].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR2(EA_ARGS)	{ return jvm->gpRegs[2].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR3(EA_ARGS)	{ return jvm->gpRegs[3].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR4(EA_ARGS)	{ return jvm->gpRegs[4].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR5(EA_ARGS)	{ return jvm->gpRegs[5].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR6(EA_ARGS)	{ return jvm->gpRegs[6].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR7(EA_ARGS)	{ return jvm->gpRegs[7].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR8(EA_ARGS)	{ return jvm->gpRegs[8].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR9(EA_ARGS)	{ return jvm->gpRegs[9].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR10(EA_ARGS)	{ return jvm->gpRegs[10].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR11(EA_ARGS)	{ return jvm->gpRegs[11].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR12(EA_ARGS)	{ return jvm->gpRegs[12].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR13(EA_ARGS)	{ return jvm->gpRegs[13].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR14(EA_ARGS)	{ return jvm->gpRegs[14].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR15(EA_ARGS)	{ return jvm->gpRegs[15].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR16(EA_ARGS)	{ return jvm->gpRegs[16].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR17(EA_ARGS)	{ return jvm->gpRegs[17].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR18(EA_ARGS)	{ return jvm->gpRegs[18].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR19(EA_ARGS)	{ return jvm->gpRegs[19].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR20(EA_ARGS)	{ return jvm->gpRegs[20].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR21(EA_ARGS)	{ return jvm->gpRegs[21].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR22(EA_ARGS)	{ return jvm->gpRegs[22].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR23(EA_ARGS)	{ return jvm->gpRegs[23].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR24(EA_ARGS)	{ return jvm->gpRegs[24].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR25(EA_ARGS)	{ return jvm->gpRegs[25].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR26(EA_ARGS)	{ return jvm->gpRegs[26].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR27(EA_ARGS)	{ return jvm->gpRegs[27].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR28(EA_ARGS)	{ return jvm->gpRegs[28].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR29(EA_ARGS)	{ return jvm->gpRegs[29].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR30(EA_ARGS)	{ return jvm->gpRegs[30].PtrU8() + EAOFFSET(); }
void* JASMINE_EA::fLIR31(EA_ARGS)	{ return jvm->gpRegs[31].PtrU8() + EAOFFSET(); }

void* JASMINE_EA::fLUIR0(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[0].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR1(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[1].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR2(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[2].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR3(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[3].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR4(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[4].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR5(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[5].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR6(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[6].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR7(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[7].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR8(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[8].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR9(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[9].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR10(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[10].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR11(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[11].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR12(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[12].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR13(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[13].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR14(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[14].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR15(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[15].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR16(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[16].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR17(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[17].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR18(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[18].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR19(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[19].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR20(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[20].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR21(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[21].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR22(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[22].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR23(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[23].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR24(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[24].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR25(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[25].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR26(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[26].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR27(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[27].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR28(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[28].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR29(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[29].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR30(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[30].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fLUIR31(EA_ARGS)
{
	uint8* &p = jvm->gpRegs[31].PtrU8();
	p += EAOFFSET();
	return p;
}

void* JASMINE_EA::fIRRO(EA_ARGS)
{
	jvm->instPtr++;
	return IRRO_BASEREG.PtrU8() + IRRO_OFSTREG();
}

void* JASMINE_EA::fIRROU(EA_ARGS)
{
	jvm->instPtr++;
	uint8*	&p = IRRO_BASEREG.PtrU8();
	p += IRRO_OFSTREG();
	return p;
}

void* JASMINE_EA::fIRSRO(EA_ARGS)
{
	jvm->instPtr++;
	return IRRO_BASEREG.PtrU8() + IRRO_SCALE()*IRRO_OFSTREG();
}

void* JASMINE_EA::fIRSROU(EA_ARGS)
{
	jvm->instPtr++;
	uint8*	&p = IRRO_BASEREG.PtrU8();
	p += IRRO_SCALE()*IRRO_OFSTREG();
	return p;
}

void* JASMINE_EA::fCTR(EA_ARGS)			{ return &jvm->countReg; }
void* JASMINE_EA::fDS(EA_ARGS)			{	return ((uint8*)jvm->dataSectPtr) + EAOFFSET(); }
void* JASMINE_EA::fCDS(EA_ARGS)			{	return ((uint8*)jvm->constSectPtr) + EAOFFSET(); }
void* JASMINE_EA::fLITERAL(EA_ARGS)	{ return GETLITERAL(s);}

void* JASMINE_EA::fOFFSET_PC(EA_ARGS)		{ jvm->instPtr++; return jvm->instPtr + *((sint32*)jvm->instPtr); }

void* JASMINE_EA::fFUNC_TAB(EA_ARGS) { return 0; }

#undef EAOFFSET
#undef GETLITERAL
#undef IRRO_BASEREG
#undef IRRO_OFSTREG


