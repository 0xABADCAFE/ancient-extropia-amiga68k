//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "VMClass.hpp"


/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fPUSH_X8(CMDARGS)	{}
void VMCORE::fPUSH_X16(CMDARGS) {}
void VMCORE::fPUSH_X32(CMDARGS) {}
void VMCORE::fPUSH_X64(CMDARGS) {}
void VMCORE::fPOP_X8(CMDARGS) {}
void VMCORE::fPOP_X16(CMDARGS) {}
void VMCORE::fPOP_X32(CMDARGS) {}
void VMCORE::fPOP_X64(CMDARGS) {}
void VMCORE::fPUSHREGS(CMDARGS) {}
void VMCORE::fPOPREGS(CMDARGS) {}

/////////////////////////////////////////////////////////////////////////////////////

#ifndef USE_HAND_ASM

void VMCORE::fCLR_X8(CMDARGS)
{
	OPINIT();
	OP1(uint8) = 0;
	OPDONE();
}

void VMCORE::fCLR_X16(CMDARGS)
{
	OPINIT();
	OP1(uint16) = 0;
	OPDONE();
}

void VMCORE::fCLR_X32(CMDARGS)
{
	OPINIT();
	OP1(uint32) = 0;
	OPDONE();
}

void VMCORE::fCLR_X64(CMDARGS)
{
	OPINIT();
	OP1(uint64) = 0;
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fMOVE_X8(CMDARGS)
{
	OPINIT();
	OP2(uint8) = OP1(uint8);
	OPDONE();
}

void VMCORE::fMOVE_X16(CMDARGS)
{
	OPINIT();
	OP2(uint16) = OP1(uint16);
	OPDONE();
}

void VMCORE::fMOVE_X32(CMDARGS)
{
	OPINIT();
	OP2(uint32) = OP1(uint32);
	OPDONE();
}

void VMCORE::fMOVE_X64(CMDARGS)
{
	OPINIT();
	OP2(uint64) = OP1(uint64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI8TOI16(CMDARGS)
{
	OPINIT();
	OP2(sint16) = (sint16) OP1(sint8);
	OPDONE();
}

void VMCORE::fI8TOI32(CMDARGS)
{
	OPINIT();
	OP2(sint32) = (sint32) OP1(sint8);
	OPDONE();
}

void VMCORE::fI8TOI64(CMDARGS)
{
	OPINIT();
	OP2(sint64) = (sint64) OP1(sint8);
	OPDONE();
}

void VMCORE::fI8TOF32(CMDARGS)
{
	OPINIT();
	OP2(float32) = (float32) OP1(sint8);
	OPDONE();
}

void VMCORE::fI8TOF64(CMDARGS)
{
	OPINIT();
	OP2(float64) = (float64) OP1(sint8);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI16TOI32(CMDARGS)
{
	OPINIT();
	OP2(sint32) = (sint32) OP1(sint16);
	OPDONE();
}

void VMCORE::fI16TOI64(CMDARGS)
{
	OPINIT();
	OP2(sint64) = (sint32) OP1(sint16);
	OPDONE();
}

void VMCORE::fI16TOF32(CMDARGS)
{
	OPINIT();
	OP2(float32) = (float32) OP1(sint16);
	OPDONE();
}

void VMCORE::fI16TOF64(CMDARGS)
{
	OPINIT();
	OP2(float64) = (float64) OP1(sint16);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI32TOI64(CMDARGS)
{
	OPINIT();
	OP2(sint64) = (sint64) OP1(sint32);
	OPDONE();
}

void VMCORE::fI32TOF32(CMDARGS)
{
	OPINIT();
	OP2(float32) = (float32) OP1(sint32);
	OPDONE();
}

void VMCORE::fI32TOF64(CMDARGS)
{
	OPINIT();
	OP2(float64) = (float64) OP1(sint32);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI64TOF32(CMDARGS)
{
	OPINIT();
	OP2(float32) = (float32) OP1(sint64);
	OPDONE();
}

void VMCORE::fI64TOF64(CMDARGS)
{
	OPINIT();
	OP2(float64) = (float64) OP1(sint64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fF32TOF64(CMDARGS)
{
	OPINIT();
	OP2(sint64) = (sint64) OP1(float32);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fF64TOF32(CMDARGS)
{
	OPINIT();
	OP2(float32) = (float32) OP1(float64);
	OPDONE();
}

void VMCORE::fF64TOI64(CMDARGS)
{
	OPINIT();
	OP2(sint64) = (sint64) OP1(float64);
	OPDONE();
}

void VMCORE::fF64TOI32(CMDARGS)
{
	OPINIT();
	OP2(sint32) = (sint32) OP1(float64);
	OPDONE();
}

void VMCORE::fF64TOI16(CMDARGS)
{
	OPINIT();
	OP2(sint16) = (sint16) OP1(float64);
	OPDONE();
}

void VMCORE::fF64TOI8(CMDARGS)
{
	OPINIT();
	OP2(sint8) = (sint8) OP1(float32);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fF32TOI64(CMDARGS)
{
	OPINIT();
	OP2(sint64) = (sint16) OP1(sint16);
	OPDONE();
}

void VMCORE::fF32TOI32(CMDARGS)
{
	OPINIT();
	OP2(sint32) = (sint32) OP1(float32);
	OPDONE();
}

void VMCORE::fF32TOI16(CMDARGS)
{
	OPINIT();
	OP2(sint16) = (sint16) OP1(float32);
	OPDONE();
}

void VMCORE::fF32TOI8(CMDARGS)
{
	OPINIT();
	OP2(sint8) = (sint16) OP1(float32);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI64TOI32(CMDARGS)
{
	OPINIT();
	OP2(sint32) = (sint32) OP1(sint64);
	OPDONE();
}

void VMCORE::fI64TOI16(CMDARGS)
{
	OPINIT();
	OP2(sint16) = (sint16) OP1(sint64);
	OPDONE();
}

void VMCORE::fI64TOI8(CMDARGS)
{
	OPINIT();
	OP2(sint8) = (sint8) OP1(sint64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI32TOI16(CMDARGS)
{
	OPINIT();
	OP2(sint16) = (sint16) OP1(sint32);
	OPDONE();
}

void VMCORE::fI32TOI8(CMDARGS)
{
	OPINIT();
	OP2(sint8) = (sint8) OP1(sint32);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fI16TOI8(CMDARGS)
{
	OPINIT();
	OP2(sint8) = (sint8) OP1(sint16);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

/*
void VMCORE::fBCLR_X8(CMDARGS) {}
void VMCORE::fBCLR_X16(CMDARGS) {}
void VMCORE::fBCLR_X32(CMDARGS) {}
void VMCORE::fBCLR_X64(CMDARGS) {}
void VMCORE::fBMOVE_X8(CMDARGS) {}
void VMCORE::fBMOVE_X16(CMDARGS) {}
void VMCORE::fBMOVE_X32(CMDARGS) {}
void VMCORE::fBMOVE_X64(CMDARGS) {}
*/

#endif