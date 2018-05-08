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

#include "JasmineObject.hpp"

static char str1[] = "VM program to generate factorials\n\nPlease enter a number : ";
static char str2[] = "Factorials are defined for positive integers only\n";
static char str3[] = "Factorial is : ";
//static char str4[] = "Hello ";

static char progName[] = "Factorial Demo";

static uint32	instTable[] = {
/*
	VM::MOVE_X32<<24	| VM::LITERAL<<16		| VM::R31<<8, (100000),
	VM::MOVE_X32<<24  | VM::IM1<<16				| VM::R30<<8,
	VM::CLR_X32<<24		| VM::R29<<16,
	VM::SUB_I32<<24		| VM::R31<<16				| VM::R30<<8	| VM::R31,
	VM::BGR_I32<<24		| VM::R31<<16				| VM::R29<<8, (-2),
	VM::END<<24,
*/
	VM::SYS<<24				| VM::OUT_STR<<16		| VM::CDS<<8, (0),
	VM::SYS<<24				| VM::INP_S32<<16		| VM::R0<<8,

	VM::BGREQ_I32<<24	| VM::R0<<16				| VM::IM0<<8, (4),
	VM::SYS<<24				| VM::OUT_STR<<16		| VM::CDS<<8, (sizeof(str1)),
	VM::END<<24,
	VM::F64_S32<<24		| VM::R0<<16				| VM::R0<<8,
	VM::F64_S32<<24		| VM::IM1<<16				| VM::R2<<8,
	VM::F64_S32<<24		| VM::IM2<<16				| VM::R3<<8,
	VM::PUSH_X64<<24	| VM::R0<<16,
	VM::CALL<<24			| VM::OFFSET_PC<<16,	(8), // call factorial()
	VM::POP_X64<<24		| VM::R0<<16,
	VM::SYS<<24				| VM::OUT_STR<<16		| VM::CDS<<8, (sizeof(str1)+sizeof(str2)),
	VM::SYS<<24				| VM::OUT_F64<<16		| VM::R0<<8,
	VM::SYS<<24				| VM::OUT_U8<<16		| VM::LITERAL<<8, ('\n'),
	VM::END<<24,

	// factorial (n)
	VM::SAVE<<24			|	VM::R0<<16			| VM::R1<<8,								// save local
	VM::POP_X64<<24		| VM::R0<<16,																	// get n
	VM::BLS_F64<<24		| VM::IM0<<16			| VM::R0<<8, (4),
	VM::PUSH_X64<<24	| VM::R2<<16,
	VM::BRA<<24, (10),

	VM::BGR_F64<<24		| VM::R3<<16				| VM::R0<<8,	(7),

	VM::SUB_F64<<24		| VM::R0<<16				| VM::R2<<8	| VM::R1,		// n-1
	VM::PUSH_X64<<24	| VM::R1<<16,
	VM::CALL<<24			| VM::OFFSET_PC<<16,	(-12),										// recurse
	VM::POP_X64<<24		| VM::R1<<16,
	VM::MUL_F64<<24		| VM::R0<<16				| VM::R1<<8		| VM::R0,

	// return n
	VM::PUSH_X64<<24	| VM::R0<<16,
	VM::RESTORE<<24		| VM::R0<<16				| VM::R1<<8,
	VM::RET<<24
};


#define STRSIZE (sizeof(str1)+sizeof(str2)+sizeof(str3)/*+sizeof(str4)*/)
#define FUNCSIZE 2
#define CODESIZE (sizeof(instTable)/sizeof(uint32))
#define STACKSIZE 1024
#define METHDSIZE 512
#define RGSTKSIZE 512

int main(int argc, char** argv)
{
	if (xBASELIB::Init()!=OK)
	{
		puts("Error initializing base library");
		return 10;
	}

	if (argc != 2)
	{
		puts("Usage : genvm <object file>");
		xBASELIB::Done();
		return 5;
	}

	JASMINEOBJECT* program = JASMINEFACTORY::Create(progName, 1, 0, FUNCSIZE,CODESIZE,STACKSIZE,METHDSIZE,RGSTKSIZE, 0,0,0,0, 0,0,0, STRSIZE);

	if (program)
	{
		program->Method(0)->Define("main", "<none>", JFINFO::F_MAIN, 0);
		program->Method(1)->Define("factorial", "<stack>float64(<stack>float64)", JFINFO::F_FUNC, 22);

		uint32* p = program->Code();
		uint32* t = instTable;
		sint32 i = 1+CODESIZE;

		while(--i)
			*p++ = *t++;

		char* c = (char*)program->Cnst();
		strcpy(c, str1);
		c+=sizeof(str1);
		strcpy(c, str2);
		c+=sizeof(str2);
		strcpy(c, str3);
		/*
		c+=sizeof(str3);
		strcpy(c, str4);
		*/
		XSFBASIC objFile(JASMINEOBJECT::XSFFileSig, JASMINEOBJECT::XSFSuperClass,
										 JASMINEOBJECT::XSFSubClass, JASMINEOBJECT::XSFDataFormat,
										 JASMINEOBJECT::XSFFileFormat);
		objFile.Create(argv[1]);
		if (objFile.Valid())
		{
			program->Write(objFile);
			objFile.Close();
			printf("Wrote VM program '%s'\n", argv[1]);
		}
		delete program;
	}
	else
		puts("Couldn't create JASMINEOBJECT");
	xBASELIB::Done();
	return 0;
}