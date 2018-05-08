//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xBase.hpp>
#include <xSystem/xResources.hpp>

#include "VM_ObjectCode.hpp"

static char str1[] = "This VM program generates a sum from 1 - n\nEnter a number > 0: ";
static char str2[] = "The sum of 1 - ";
static char str3[] = " is ";
static char str4[] = "You must enter a number > 0:";

#define STRSIZE (sizeof(str1)+sizeof(str2)+sizeof(str3)+sizeof(str4))

static uint32	instTable[] = {
	//VM::OUT_STR<<24		| VM::CDS<<16,		(0),
	//VM::INP_S32<<24		| VM::R4<<16,
	//VM::BGR_I32<<24		|	VM::R4<<16,			(4),
	//VM::OUT_STR<<24		| VM::CDS<<16,		(sizeof(str1)+sizeof(str2)+sizeof(str3)),
	//VM::EXIT<<24,

	VM::MOVE_X32<<24	| VM::LITERAL<<16	| VM::R4<<8, (100000),

	VM::MOVE_X32<<24	|	VM::R4<<16			| VM::R0<<8,
	VM::MOVE_X32<<24	| VM::LITERAL<<16	| VM::R1<<8,	(1),
	VM::CLR_X32<<24		| VM::R2<<16,
	VM::CLR_X64<<24		| VM::R3<<16,

	VM::I32TOF64<<24	| VM::R0<<16			| VM::R2<<8,
	VM::ADD_F64<<24		| VM::R2<<16			| VM::R3<<8	| VM::R3,
	VM::SUB_I32<<24 	| VM::R0<<16			| VM::R1<<8	| VM::R0,
	VM::BNEQ_I32<<24	| VM::R0<<16,	(-4),
/*
	VM::OUT_STR<<24		| VM::CDS<<16, (sizeof(str1)),
	VM::OUT_S32<<24		| VM::R4<<16,
	VM::OUT_STR<<24		|	VM::CDS<<16, (sizeof(str1)+sizeof(str2)),
	VM::OUT_F64<<24		| VM::R3<<16,
	VM::OUT_U8<<24		| VM::LITERAL<<16,	('\n'),
*/
	VM::EXIT<<24
};

#define CODESIZE (sizeof(instTable)/sizeof(uint32))

int main(int argc, char** argv)
{
	if (xBASELIB::Init()!=OK)
	{
		cerr << "Error initializing base library\n";
		return 10;
	}

	if (argc != 2)
	{
		cout << "Usage : genvm <object file>\n";
		xBASELIB::Done();
		return 5;
	}

	VMOBJ program;
	program.Create(CODESIZE,1024,512,0,0,0,0, 0,0,0, STRSIZE);

	uint32* p = program.Code();
	uint32* t = instTable;

	sint32 i = 1+CODESIZE;
	while(--i)
		*p++ = *t++;

	char* c = (char*)program.Cnst();
	strcpy(c, str1);
	c+=sizeof(str1);
	strcpy(c, str2);
	c+=sizeof(str2);
	strcpy(c, str3);
	c+=sizeof(str3);
	strcpy(c, str4);

	XSFBASIC objFile("VMCODE", 1, 0, (XA_ALIGN32|X_ENDIAN|X_NEGATIVE), (0));
	objFile.Create(argv[1]);
	if (objFile.Valid())
	{
		program.Write(objFile);
		objFile.Close();
		cout << "Wrote VM program '" <<argv[1]<<"'\n";
	}
	xBASELIB::Done();
	return 0;
}