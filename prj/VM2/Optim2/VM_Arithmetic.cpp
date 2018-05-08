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

#ifndef USE_HAND_ASM

extern "C" {
	#include <math.h>
}

void VMCORE::fADD_I8(CMDARGS)
{
	OPINIT();
	OP3(sint8) = OP1(sint8) + OP2(sint8);
	OPDONE();
}

void VMCORE::fADD_I16(CMDARGS)
{
	OPINIT();
	OP3(sint16) = OP1(sint16) + OP2(sint16);
	OPDONE();
}

void VMCORE::fADD_I32(CMDARGS)
{
	OPINIT();
	OP3(sint32) = OP1(sint32) + OP2(sint32);
	OPDONE();
}

void VMCORE::fADD_I64(CMDARGS)
{
	OPINIT();
	OP3(sint64) = OP1(sint64) + OP2(sint64);
	OPDONE();
}

void VMCORE::fADD_F32(CMDARGS)
{
	OPINIT();
	OP3(float32) = OP1(float32) + OP2(float32);
	OPDONE();
}

void VMCORE::fADD_F64(CMDARGS)
{
	OPINIT();
	OP3(float64) = OP1(float64) + OP2(float64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSUB_I8(CMDARGS)
{
	OPINIT();
	OP3(sint8) = OP1(sint8) - OP2(sint8);
	OPDONE();
}

void VMCORE::fSUB_I16(CMDARGS)
{
	OPINIT();
	OP3(sint16) = OP1(sint16) - OP2(sint16);
	OPDONE();
}

void VMCORE::fSUB_I32(CMDARGS)
{
	OPINIT();
	OP3(sint32) = OP1(sint32) - OP2(sint32);
	OPDONE();
}

void VMCORE::fSUB_I64(CMDARGS)
{
	OPINIT();
	OP3(sint64) = OP1(sint64) - OP2(sint64);
	OPDONE();
}

void VMCORE::fSUB_F32(CMDARGS)
{
	OPINIT();
	OP3(float32) = OP1(float32) - OP2(float32);
	OPDONE();
}

void VMCORE::fSUB_F64(CMDARGS)
{
	OPINIT();
	OP3(float64) = OP1(float64) - OP2(float64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fMUL_I8(CMDARGS)
{
	OPINIT();
	OP3(sint8) = OP1(sint8) * OP2(sint8);
	OPDONE();
}

void VMCORE::fMUL_I16(CMDARGS)
{
	OPINIT();
	OP3(sint16) = OP1(sint16) * OP2(sint16);
	OPDONE();
}

void VMCORE::fMUL_I32(CMDARGS)
{
	OPINIT();
	OP3(sint32) = OP1(sint32) * OP2(sint32);
	OPDONE();
}

void VMCORE::fMUL_I64(CMDARGS)
{
	OPINIT();
	OP3(sint64) = OP1(sint64) * OP2(sint64);
	OPDONE();
}

void VMCORE::fMUL_F32(CMDARGS)
{
	OPINIT();
	OP3(float32) = OP1(float32) * OP2(float32);
	OPDONE();
}

void VMCORE::fMUL_F64(CMDARGS)
{
	OPINIT();
	OP3(float64) = OP1(float64) * OP2(float64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fDIV_I8(CMDARGS)
{
	OPINIT();
	rsint32 n = OP1(sint8);
	rsint16 d = OP2(sint8);
	if (d)
		OP3(sint8) = n/d;
	else
		This->exitReg = -1;
	OPDONE();
}

void VMCORE::fDIV_I16(CMDARGS)
{
	OPINIT();
	rsint32 n = OP1(sint16);
	rsint16 d = OP2(sint16);
	if (d)
		OP3(sint16) = n/d;
	else
		This->exitReg = -1;
	OPDONE();
}

void VMCORE::fDIV_I32(CMDARGS)
{
	OPINIT();
	rsint32 n = OP1(sint32);
	rsint32 d = OP2(sint32);
	if (d)
		OP3(sint32) = n/d;
	else
		This->exitReg = -1;
	OPDONE();
}

void VMCORE::fDIV_I64(CMDARGS)
{
	OPINIT();
	rsint64* n = POP1(sint64);
	rsint64* d = POP2(sint64);
	if (*d)
		OP3(sint64) = (*n) / (*d);
	else
		This->exitReg = -1;
	OPDONE();
}

void VMCORE::fDIV_F32(CMDARGS)
{
	OPINIT();
	OP3(float32) = OP1(float32) / OP2(float32);
	OPDONE();
}

void VMCORE::fDIV_F64(CMDARGS)
{
	OPINIT();
	OP3(float64) = OP1(float64) / OP2(float64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fMOD_I8(CMDARGS)
{
	OPINIT();
	rsint32 n = OP1(sint8);
	rsint16 d = OP2(sint8);
	if (d)
		OP3(sint8) = n%d;
	else
		This->exitReg = -1;
	OPDONE();
}

void VMCORE::fMOD_I16(CMDARGS)
{
	OPINIT();
	rsint32 n = OP1(sint8);
	rsint16 d = OP2(sint8);
	if (d)
		OP3(sint16) = n%d;
	else
		This->exitReg = -1;
	OPDONE();
}

void VMCORE::fMOD_I32(CMDARGS)
{
	OPINIT();
	rsint32 n = OP1(sint32);
	rsint32 d = OP2(sint32);
	if (d)
		OP3(sint32) = n/d;
	else
		This->exitReg = -1;
	OPDONE();
}

void VMCORE::fMOD_I64(CMDARGS)
{
	OPINIT();
	rsint64* n = POP1(sint64);
	rsint64* d = POP2(sint64);
	if (*d)
		OP3(sint64) = (*n) % (*d);
	else
		This->exitReg = -1;
	OPDONE();
}

void VMCORE::fMOD_F32(CMDARGS)
{
	OPINIT();
	OP3(float32) = (float32)fmod(OP1(float32), OP2(float32));
	OPDONE();
}

void VMCORE::fMOD_F64(CMDARGS)
{
	OPINIT();
	OP3(float64) = fmod(OP1(float64), OP2(float64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fNEG_I8(CMDARGS)
{
	OPINIT();
	OP2(sint8) = -(OP1(sint8));
	OPDONE();
}

void VMCORE::fNEG_I16(CMDARGS)
{
	OPINIT();
	OP2(sint16) = -(OP1(sint16));
	OPDONE();
}

void VMCORE::fNEG_I32(CMDARGS)
{
	OPINIT();
	OP2(sint32) = -(OP1(sint32));
	OPDONE();
}

void VMCORE::fNEG_I64(CMDARGS)
{
	OPINIT();
	OP2(sint64) = -(OP1(sint64));
	OPDONE();
}

void VMCORE::fNEG_F32(CMDARGS)
{
	OPINIT();
	OP2(float32) = -(OP1(float32));
	OPDONE();
}

void VMCORE::fNEG_F64(CMDARGS)
{
	OPINIT();
	OP2(float64) = -(OP1(float64));
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSHL_I8(CMDARGS)
{
	OPINIT();
	OP3(sint8) = OP1(sint8) << OP2(sint8);
	OPDONE();
}

void VMCORE::fSHL_I16(CMDARGS)
{
	OPINIT();
	OP3(sint16) = OP1(sint16) << OP2(sint16);
	OPDONE();
}

void VMCORE::fSHL_I32(CMDARGS)
{
	OPINIT();
	OP3(sint32) = OP1(sint32) << OP2(sint32);
	OPDONE();
}

void VMCORE::fSHL_I64(CMDARGS)
{
	OPINIT();
	OP3(sint64) = OP1(sint64) << OP2(sint64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSHR_I8(CMDARGS)
{
	OPINIT();
	OP3(sint8) = OP1(sint8) >> OP2(sint8);
	OPDONE();
}

void VMCORE::fSHR_I16(CMDARGS)
{
	OPINIT();
	OP3(sint16) = OP1(sint16) >> OP2(sint16);
	OPDONE();
}

void VMCORE::fSHR_I32(CMDARGS)
{
	OPINIT();
	OP3(sint32) = OP1(sint32) >> OP2(sint32);
	OPDONE();
}

void VMCORE::fSHR_I64(CMDARGS)
{
	OPINIT();
	OP3(sint64) = OP1(sint64) >> OP2(sint64);
	OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

#ifdef USE_VM_BLOCKCOMMANDS
void VMCORE::fBADD_I8(CMDARGS){}
void VMCORE::fBADD_I16(CMDARGS) {}
void VMCORE::fBADD_I32(CMDARGS) {}
void VMCORE::fBADD_I64(CMDARGS) {}
void VMCORE::fBADD_F32(CMDARGS) {}
void VMCORE::fBADD_F64(CMDARGS) {}
void VMCORE::fBSUB_I8(CMDARGS) {}
void VMCORE::fBSUB_I16(CMDARGS) {}
void VMCORE::fBSUB_I32(CMDARGS) {}
void VMCORE::fBSUB_I64(CMDARGS) {}
void VMCORE::fBSUB_F32(CMDARGS) {}
void VMCORE::fBSUB_F64(CMDARGS) {}
void VMCORE::fBMUL_I8(CMDARGS) {}
void VMCORE::fBMUL_I16(CMDARGS) {}
void VMCORE::fBMUL_I32(CMDARGS) {}
void VMCORE::fBMUL_I64(CMDARGS) {}
void VMCORE::fBMUL_F32(CMDARGS) {}
void VMCORE::fBMUL_F64(CMDARGS) {}
void VMCORE::fBDIV_I8(CMDARGS) {}
void VMCORE::fBDIV_I16(CMDARGS) {}
void VMCORE::fBDIV_I32(CMDARGS) {}
void VMCORE::fBDIV_I64(CMDARGS) {}
void VMCORE::fBDIV_F32(CMDARGS) {}
void VMCORE::fBDIV_F64(CMDARGS) {}
void VMCORE::fBMOD_I8(CMDARGS) {}
void VMCORE::fBMOD_I16(CMDARGS) {}
void VMCORE::fBMOD_I32(CMDARGS) {}
void VMCORE::fBMOD_I64(CMDARGS) {}
void VMCORE::fBMOD_F32(CMDARGS) {}
void VMCORE::fBMOD_F64(CMDARGS) {}
void VMCORE::fBNEG_I8(CMDARGS) {}
void VMCORE::fBNEG_I16(CMDARGS) {}
void VMCORE::fBNEG_I32(CMDARGS) {}
void VMCORE::fBNEG_I64(CMDARGS) {}
void VMCORE::fBNEG_F32(CMDARGS) {}
void VMCORE::fBNEG_F64(CMDARGS) {}
void VMCORE::fBSHL_I8(CMDARGS) {}
void VMCORE::fBSHL_I16(CMDARGS) {}
void VMCORE::fBSHL_I32(CMDARGS) {}
void VMCORE::fBSHL_I64(CMDARGS) {}
void VMCORE::fBSHR_I8(CMDARGS) {}
void VMCORE::fBSHR_I16(CMDARGS) {}
void VMCORE::fBSHR_I32(CMDARGS) {}
void VMCORE::fBSHR_I64(CMDARGS) {}
#endif

#endif