//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XSFVIRTUALMACHINE2_HPP
#error You must not #include VMFuncs manually
#endif

#ifdef XP_AMIGAOS
	#define EX_ARGS		register __a2 VMCORE* This, register __a3 VMCORE::OPFUNC* iTab
	#define EA_ARGS 	register __a2 VMCORE* This, register __d7 size_t s
	#define EA_2ARGS	register __a2 VMCORE* This, register __d6 size_t s1, register __d7 size_t s2
	#define OP_ARGS		register __a2 VMCORE* This
#else
	#define EX_ARGS		VMCORE* This, OPFUNC* iTab
	#define EA_ARGS		VMCORE* This, size_t s
	#define EA_2ARGS	VMCORE* This, size_t s1, size_t s2
	#define OP_ARGS		VMCORE* This
#endif

static void DecodeSYS_EA(EA_ARGS);
static void Decode2SYS_EA(EA_2ARGS);

#if (X_ENDIAN == XA_BIGENDIAN)

///////////////////////////////////////////////////////////////////////////////
//
//  BIG ENDIAN VERSIONS
//
///////////////////////////////////////////////////////////////////////////////

static void Decode1_X8(OP_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,1);
	else
	{
		This->imReg[0].ValU8() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data8();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode1_X16(OP_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,2);
	else
	{
		This->imReg[0].ValU16() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data16();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode1_X32(OP_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,4);
	else
	{
		This->imReg[0].ValU32() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data32();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode1_X64(OP_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,8);
	else
	{
		This->imReg[0].ValU64() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data64();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2(EA_2ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32	x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,s1);
	else
	{
		switch(s1)
		{
			case 1:
				This->imReg[0].ValU8() = x-VM::IM0;
				This->op[0].any = This->imReg[0].Data8();
				break;
			case 2:
				This->imReg[0].ValU16() = x-VM::IM0;
				This->op[0].any = This->imReg[0].Data16();
				break;
			case 4:
				This->imReg[0].ValU32() = x-VM::IM0;
				This->op[0].any = This->imReg[0].Data32();
				break;
			case 8:
				This->imReg[0].ValU64() = x-VM::IM0;
				This->op[0].any = This->imReg[0].Data64();
				break;
		}
	}
	x = *p;
	This->op[1].any = eaTable[x](This,s2);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2_X8(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,1);
	else
	{
		This->imReg[0].ValU8() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data8();
	}
	x = *p;
	This->op[1].any = eaTable[x](This,1);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2_X16(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,2);
	else
	{
		This->imReg[0].ValU16() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data16();
	}
	x = *p;
	This->op[1].any = eaTable[x](This,2);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2_X32(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,4);
	else
	{
		This->imReg[0].ValU32() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data32();
	}
	x = *p;
	This->op[1].any = eaTable[x](This,4);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2_X64(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,8);
	else
	{
		This->imReg[0].ValU64() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data64();
	}
	x = *p;
	This->op[1].any = eaTable[x](This,8);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2C_X8(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,1);
	else
	{
		This->imReg[0].ValU8() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data8();
	}
	x = *p;
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,1);
	else
	{
		This->imReg[1].ValU8() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data8();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2C_X16(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,2);
	else
	{
		This->imReg[0].ValU16() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data16();
	}
	x = *p;
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,2);
	else
	{
		This->imReg[1].ValU16() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data16();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2C_X32(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,4);
	else
	{
		This->imReg[0].ValU32() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data32();
	}
	x = *p;
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,4);
	else
	{
		This->imReg[1].ValU32() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data32();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2C_X64(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,8);
	else
	{
		This->imReg[0].ValU64() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data64();
	}
	x = *p;

	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,8);
	else
	{
		This->imReg[1].ValU64() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data64();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode3_X8(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,1);
	else
	{
		This->imReg[0].ValU8() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data8();
	}

	x = *p++;
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,1);
	else
	{
		This->imReg[1].ValU8() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data8();
	}

	This->op[2].any = eaTable[*p](This,1);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode3_X16(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,2);
	else
	{
		This->imReg[0].ValU16() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data16();
	}

	x = *p++;
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,2);
	else
	{
		This->imReg[1].ValU16() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data16();
	}

	This->op[2].any = eaTable[*p](This,2);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode3_X32(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,4);
	else
	{
		This->imReg[0].ValU32() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data32();
	}

	x = *p++;
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,4);
	else
	{
		This->imReg[1].ValU32() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data32();
	}

	This->op[2].any = eaTable[*p](This,4);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode3_X64(OP_ARGS)
{
	ruint8* p = ((uint8*)This->instPtr)+1;
	uint32 x = *p++;
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,8);
	else
	{
		This->imReg[0].ValU64() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data64();
	}

	x = *p++;
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,8);
	else
	{
		This->imReg[1].ValU64() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data64();
	}

	This->op[2].any = eaTable[*p](This,8);
	This->instPtr++;
}

#else

///////////////////////////////////////////////////////////////////////////////
//
//  LITTLE ENDIAN VERSIONS
//
///////////////////////////////////////////////////////////////////////////////

static void Decode1_X8(OP_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,1);
	else
	{
		This->imReg[0].ValU8() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data8();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode1_X16(OP_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,2);
	else
	{
		This->imReg[0].ValU16() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data16();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode1_X32(OP_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,4);
	else
	{
		This->imReg[0].ValU32() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data32();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode1_X64(OP_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,8);
	else
	{
		This->imReg[0].ValU64() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data64();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2(EA_2ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,s1);
	else
	{
		switch(s1)
		{
			case 1:
				This->imReg[0].ValU8() = x-VM::IM0;
				This->op[0].any = This->imReg[0].Data8();
				break;
			case 2:
				This->imReg[0].ValU16() = x-VM::IM0;
				This->op[0].any = This->imReg[0].Data16();
				break;
			case 4:
				This->imReg[0].ValU32() = x-VM::IM0;
				This->op[0].any = This->imReg[0].Data32();
				break;
			case 8:
				This->imReg[0].ValU64() = x-VM::IM0;
				This->op[0].any = This->imReg[0].Data64();
				break;
		}
	}
	x = ((uint8*)This->instPtr)[1];
	This->op[1].any = eaTable[x](This,s2);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2_X8(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,1);
	else
	{
		This->imReg[0].ValU8() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data8();
	}
	x = ((uint8*)This->instPtr)[1];
	This->op[1].any = eaTable[x](This,1);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2_X16(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,2);
	else
	{
		This->imReg[0].ValU16() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data16();
	}
	x = ((uint8*)This->instPtr)[1];
	This->op[1].any = eaTable[x](This,2);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2_X32(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,4);
	else
	{
		This->imReg[0].ValU32() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data32();
	}
	x = ((uint8*)This->instPtr)[1];
	This->op[1].any = eaTable[x](This,4);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2_X64(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,8);
	else
	{
		This->imReg[0].ValU64() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data64();
	}
	x = ((uint8*)This->instPtr)[1];
	This->op[1].any = eaTable[x](This,8);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2C_X8(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,1);
	else
	{
		This->imReg[0].ValU8() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data8();
	}
	x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,1);
	else
	{
		This->imReg[1].ValU8() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data8();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2C_X16(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,2);
	else
	{
		This->imReg[0].ValU16() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data16();
	}
	x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,2);
	else
	{
		This->imReg[1].ValU16() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data16();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2C_X32(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,4);
	else
	{
		This->imReg[0].ValU32() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data32();
	}
	x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,4);
	else
	{
		This->imReg[1].ValU32() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data32();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode2C_X64(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,8);
	else
	{
		This->imReg[0].ValU64() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data64();
	}
	x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,8);
	else
	{
		This->imReg[1].ValU64() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data64();
	}
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode3_X8(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,1);
	else
	{
		This->imReg[0].ValU8() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data8();
	}

	x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,1);
	else
	{
		This->imReg[1].ValU8() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data8();
	}

	x = ((uint8*)This->instPtr)[0];
	This->op[2].any = eaTable[x](This,1);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode3_X16(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,2);
	else
	{
		This->imReg[0].ValU16() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data16();
	}

	x = ((uint8*)This->instPtr)[1];

	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,2);
	else
	{
		This->imReg[1].ValU16() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data16();
	}
	x = ((uint8*)This->instPtr)[0];
	This->op[2].any = eaTable[x](This,2);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode3_X32(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,4);
	else
	{
		This->imReg[0].ValU32() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data32();
	}

	x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,4);
	else
	{
		This->imReg[1].ValU32() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data32();
	}

	x = ((uint8*)This->instPtr)[0];
	This->op[2].any = eaTable[x](This,4);
	This->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

static void Decode3_X64(OP_ARGS)
{
	ruint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,8);
	else
	{
		This->imReg[0].ValU64() = x-VM::IM0;
		This->op[0].any = This->imReg[0].Data64();
	}

	x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,8);
	else
	{
		This->imReg[1].ValU64() = x-VM::IM0;
		This->op[1].any = This->imReg[1].Data64();
	}

	x = ((uint8*)This->instPtr)[0];
	This->op[2].any = eaTable[x](This,8);
	This->instPtr++;
}

#endif

static void* fR0(EA_ARGS);
static void* fR1(EA_ARGS);
static void* fR2(EA_ARGS);
static void* fR3(EA_ARGS);
static void* fR4(EA_ARGS);
static void* fR5(EA_ARGS);
static void* fR6(EA_ARGS);
static void* fR7(EA_ARGS);
static void* fR8(EA_ARGS);
static void* fR9(EA_ARGS);
static void* fR10(EA_ARGS);
static void* fR11(EA_ARGS);
static void* fR12(EA_ARGS);
static void* fR13(EA_ARGS);
static void* fR14(EA_ARGS);
static void* fR15(EA_ARGS);
static void* fR16(EA_ARGS);
static void* fR17(EA_ARGS);
static void* fR18(EA_ARGS);
static void* fR19(EA_ARGS);
static void* fR20(EA_ARGS);
static void* fR21(EA_ARGS);
static void* fR22(EA_ARGS);
static void* fR23(EA_ARGS);
static void* fR24(EA_ARGS);
static void* fR25(EA_ARGS);
static void* fR26(EA_ARGS);
static void* fR27(EA_ARGS);
static void* fR28(EA_ARGS);
static void* fR29(EA_ARGS);
static void* fR30(EA_ARGS);
static void* fR31(EA_ARGS);
static void* fIR0(EA_ARGS);
static void* fIR1(EA_ARGS);
static void* fIR2(EA_ARGS);
static void* fIR3(EA_ARGS);
static void* fIR4(EA_ARGS);
static void* fIR5(EA_ARGS);
static void* fIR6(EA_ARGS);
static void* fIR7(EA_ARGS);
static void* fIR8(EA_ARGS);
static void* fIR9(EA_ARGS);
static void* fIR10(EA_ARGS);
static void* fIR11(EA_ARGS);
static void* fIR12(EA_ARGS);
static void* fIR13(EA_ARGS);
static void* fIR14(EA_ARGS);
static void* fIR15(EA_ARGS);
static void* fIR16(EA_ARGS);
static void* fIR17(EA_ARGS);
static void* fIR18(EA_ARGS);
static void* fIR19(EA_ARGS);
static void* fIR20(EA_ARGS);
static void* fIR21(EA_ARGS);
static void* fIR22(EA_ARGS);
static void* fIR23(EA_ARGS);
static void* fIR24(EA_ARGS);
static void* fIR25(EA_ARGS);
static void* fIR26(EA_ARGS);
static void* fIR27(EA_ARGS);
static void* fIR28(EA_ARGS);
static void* fIR29(EA_ARGS);
static void* fIR30(EA_ARGS);
static void* fIR31(EA_ARGS);
static void* fLIR0(EA_ARGS);
static void* fLIR1(EA_ARGS);
static void* fLIR2(EA_ARGS);
static void* fLIR3(EA_ARGS);
static void* fLIR4(EA_ARGS);
static void* fLIR5(EA_ARGS);
static void* fLIR6(EA_ARGS);
static void* fLIR7(EA_ARGS);
static void* fLIR8(EA_ARGS);
static void* fLIR9(EA_ARGS);
static void* fLIR10(EA_ARGS);
static void* fLIR11(EA_ARGS);
static void* fLIR12(EA_ARGS);
static void* fLIR13(EA_ARGS);
static void* fLIR14(EA_ARGS);
static void* fLIR15(EA_ARGS);
static void* fLIR16(EA_ARGS);
static void* fLIR17(EA_ARGS);
static void* fLIR18(EA_ARGS);
static void* fLIR19(EA_ARGS);
static void* fLIR20(EA_ARGS);
static void* fLIR21(EA_ARGS);
static void* fLIR22(EA_ARGS);
static void* fLIR23(EA_ARGS);
static void* fLIR24(EA_ARGS);
static void* fLIR25(EA_ARGS);
static void* fLIR26(EA_ARGS);
static void* fLIR27(EA_ARGS);
static void* fLIR28(EA_ARGS);
static void* fLIR29(EA_ARGS);
static void* fLIR30(EA_ARGS);
static void* fLIR31(EA_ARGS);
static void* fLUIR0(EA_ARGS);
static void* fLUIR1(EA_ARGS);
static void* fLUIR2(EA_ARGS);
static void* fLUIR3(EA_ARGS);
static void* fLUIR4(EA_ARGS);
static void* fLUIR5(EA_ARGS);
static void* fLUIR6(EA_ARGS);
static void* fLUIR7(EA_ARGS);
static void* fLUIR8(EA_ARGS);
static void* fLUIR9(EA_ARGS);
static void* fLUIR10(EA_ARGS);
static void* fLUIR11(EA_ARGS);
static void* fLUIR12(EA_ARGS);
static void* fLUIR13(EA_ARGS);
static void* fLUIR14(EA_ARGS);
static void* fLUIR15(EA_ARGS);
static void* fLUIR16(EA_ARGS);
static void* fLUIR17(EA_ARGS);
static void* fLUIR18(EA_ARGS);
static void* fLUIR19(EA_ARGS);
static void* fLUIR20(EA_ARGS);
static void* fLUIR21(EA_ARGS);
static void* fLUIR22(EA_ARGS);
static void* fLUIR23(EA_ARGS);
static void* fLUIR24(EA_ARGS);
static void* fLUIR25(EA_ARGS);
static void* fLUIR26(EA_ARGS);
static void* fLUIR27(EA_ARGS);
static void* fLUIR28(EA_ARGS);
static void* fLUIR29(EA_ARGS);
static void* fLUIR30(EA_ARGS);
static void* fLUIR31(EA_ARGS);
static void* fIRRO(EA_ARGS);
static void* fIRROU(EA_ARGS);
static void* fIRSRO(EA_ARGS);
static void* fIRSROU(EA_ARGS);
static void* fCTR(EA_ARGS);
static void* fDS(EA_ARGS);
static void* fCDS(EA_ARGS);
static void* fLITERAL(EA_ARGS);
static void* fOFFSET_PC(EA_ARGS);
static void* IllegalAddress(EA_ARGS);

static void IllegalOpcode(OP_ARGS);
static void	fNOP(OP_ARGS);
static void	fEND(OP_ARGS);
static void	fSYS(OP_ARGS);
static void	fLEA(OP_ARGS);
static void	fBRA(OP_ARGS);
static void	fBNEQ_I8(OP_ARGS);
static void	fBNEQ_I16(OP_ARGS);
static void	fBNEQ_I32(OP_ARGS);
static void	fBNEQ_I64(OP_ARGS);
static void	fBNEQ_F32(OP_ARGS);
static void	fBNEQ_F64(OP_ARGS);
static void	fBLS_I8(OP_ARGS);
static void	fBLS_I16(OP_ARGS);
static void	fBLS_I32(OP_ARGS);
static void	fBLS_I64(OP_ARGS);
static void	fBLS_F32(OP_ARGS);
static void	fBLS_F64(OP_ARGS);
static void	fBLSEQ_I8(OP_ARGS);
static void	fBLSEQ_I16(OP_ARGS);
static void	fBLSEQ_I32(OP_ARGS);
static void	fBLSEQ_I64(OP_ARGS);
static void	fBLSEQ_F32(OP_ARGS);
static void	fBLSEQ_F64(OP_ARGS);
static void	fBEQ_I8(OP_ARGS);
static void	fBEQ_I16(OP_ARGS);
static void	fBEQ_I32(OP_ARGS);
static void	fBEQ_I64(OP_ARGS);
static void	fBEQ_F32(OP_ARGS);
static void	fBEQ_F64(OP_ARGS);
static void	fBGREQ_I8(OP_ARGS);
static void	fBGREQ_I16(OP_ARGS);
static void	fBGREQ_I32(OP_ARGS);
static void	fBGREQ_I64(OP_ARGS);
static void	fBGREQ_F32(OP_ARGS);
static void	fBGREQ_F64(OP_ARGS);
static void	fBGR_I8(OP_ARGS);
static void	fBGR_I16(OP_ARGS);
static void	fBGR_I32(OP_ARGS);
static void	fBGR_I64(OP_ARGS);
static void	fBGR_F32(OP_ARGS);
static void	fBGR_F64(OP_ARGS);

static void	fCALL(OP_ARGS);
static void	fRET(OP_ARGS);

static void	fPUSH_X8(OP_ARGS);
static void	fPUSH_X16(OP_ARGS);
static void	fPUSH_X32(OP_ARGS);
static void	fPUSH_X64(OP_ARGS);
static void	fPOP_X8(OP_ARGS);
static void fPOP_X16(OP_ARGS);
static void fPOP_X32(OP_ARGS);
static void	fPOP_X64(OP_ARGS);
static void	fPUSHREGS(OP_ARGS);
static void	fPOPREGS(OP_ARGS);
static void	fCLR_X8(OP_ARGS);
static void	fCLR_X16(OP_ARGS);
static void	fCLR_X32(OP_ARGS);
static void	fCLR_X64(OP_ARGS);
static void	fMOVE_X8(OP_ARGS);
static void	fMOVE_X16(OP_ARGS);
static void	fMOVE_X32(OP_ARGS);
static void	fMOVE_X64(OP_ARGS);
static void	fENDIAN_X16(OP_ARGS);
static void	fENDIAN_X32(OP_ARGS);
static void	fENDIAN_X64(OP_ARGS);
static void	fSWAP_X8(OP_ARGS);
static void	fSWAP_X16(OP_ARGS);
static void	fSWAP_X32(OP_ARGS);
static void	fSWAP_X64(OP_ARGS);


// Cast (VMCORE* This,wide)
static void	fI8TOI16(OP_ARGS);
static void	fI8TOI32(OP_ARGS);
static void	fI8TOI64(OP_ARGS);
static void fI8TOF32(OP_ARGS);
static void fI8TOF64(OP_ARGS);
static void	fI16TOI32(OP_ARGS);
static void	fI16TOI64(OP_ARGS);
static void fI16TOF32(OP_ARGS);
static void fI16TOF64(OP_ARGS);
static void fI32TOI64(OP_ARGS);
static void fI32TOF32(OP_ARGS);
static void fI32TOF64(OP_ARGS);
static void fI64TOF32(OP_ARGS);
static void fI64TOF64(OP_ARGS);
static void fF32TOF64(OP_ARGS);

// Cast (VMCORE* This,narrow)
static void fF64TOF32(OP_ARGS);
static void fF64TOI64(OP_ARGS);
static void fF64TOI32(OP_ARGS);
static void fF64TOI16(OP_ARGS);
static void fF64TOI8(OP_ARGS);
static void fF32TOI64(OP_ARGS);
static void fF32TOI32(OP_ARGS);
static void fF32TOI16(OP_ARGS);
static void fF32TOI8(OP_ARGS);
static void fI64TOI32(OP_ARGS);
static void fI64TOI16(OP_ARGS);
static void fI64TOI8(OP_ARGS);
static void fI32TOI16(OP_ARGS);
static void fI32TOI8(OP_ARGS);
static void fI16TOI8(OP_ARGS);

static void fADD_I8(OP_ARGS);
static void fADD_I16(OP_ARGS);
static void fADD_I32(OP_ARGS);
static void fADD_I64(OP_ARGS);
static void fADD_F32(OP_ARGS);
static void fADD_F64(OP_ARGS);
static void fSUB_I8(OP_ARGS);
static void fSUB_I16(OP_ARGS);
static void fSUB_I32(OP_ARGS);
static void fSUB_I64(OP_ARGS);
static void fSUB_F32(OP_ARGS);
static void fSUB_F64(OP_ARGS);

static void fMUL_I8(OP_ARGS);
static void fMUL_I16(OP_ARGS);
static void fMUL_I32(OP_ARGS);
static void fMUL_I64(OP_ARGS);
static void fMUL_F32(OP_ARGS);
static void fMUL_F64(OP_ARGS);
static void fDIV_I8(OP_ARGS);
static void fDIV_I16(OP_ARGS);
static void fDIV_I32(OP_ARGS);
static void fDIV_I64(OP_ARGS);
static void fDIV_F32(OP_ARGS);
static void fDIV_F64(OP_ARGS);
static void fMOD_I8(OP_ARGS);
static void fMOD_I16(OP_ARGS);
static void fMOD_I32(OP_ARGS);
static void fMOD_I64(OP_ARGS);
static void fMOD_F32(OP_ARGS);
static void fMOD_F64(OP_ARGS);

static void fMUL_U8(OP_ARGS);
static void fMUL_U16(OP_ARGS);
static void fMUL_U32(OP_ARGS);
static void fMUL_U64(OP_ARGS);
static void fDIV_U8(OP_ARGS);
static void fDIV_U16(OP_ARGS);
static void fDIV_U32(OP_ARGS);
static void fDIV_U64(OP_ARGS);
static void fMOD_U8(OP_ARGS);
static void fMOD_U16(OP_ARGS);
static void fMOD_U32(OP_ARGS);
static void fMOD_U64(OP_ARGS);

static void fNEG_I8(OP_ARGS);
static void fNEG_I16(OP_ARGS);
static void fNEG_I32(OP_ARGS);
static void fNEG_I64(OP_ARGS);
static void fNEG_F32(OP_ARGS);
static void fNEG_F64(OP_ARGS);
static void fSHL_I8(OP_ARGS);
static void fSHL_I16(OP_ARGS);
static void fSHL_I32(OP_ARGS);
static void fSHL_I64(OP_ARGS);
static void fSHR_I8(OP_ARGS);
static void fSHR_I16(OP_ARGS);
static void fSHR_I32(OP_ARGS);
static void fSHR_I64(OP_ARGS);

static void fAND_X8(OP_ARGS);
static void fAND_X16(OP_ARGS);
static void fAND_X32(OP_ARGS);
static void fAND_X64(OP_ARGS);
static void fOR_X8(OP_ARGS);
static void fOR_X16(OP_ARGS);
static void fOR_X32(OP_ARGS);
static void fOR_X64(OP_ARGS);
static void fXOR_X8(OP_ARGS);
static void fXOR_X16(OP_ARGS);
static void fXOR_X32(OP_ARGS);
static void fXOR_X64(OP_ARGS);
static void fINV_X8(OP_ARGS);
static void fINV_X16(OP_ARGS);
static void fINV_X32(OP_ARGS);
static void fINV_X64(OP_ARGS);
static void fSHL_X8(OP_ARGS);
static void fSHL_X16(OP_ARGS);
static void fSHL_X32(OP_ARGS);
static void fSHL_X64(OP_ARGS);
static void fSHR_X8(OP_ARGS);
static void fSHR_X16(OP_ARGS);
static void fSHR_X32(OP_ARGS);
static void fSHR_X64(OP_ARGS);

#ifdef USE_VM_BLOCKCOMMANDS
static void	fBCLR_X8(OP_ARGS);
static void	fBCLR_X16(OP_ARGS);
static void	fBCLR_X32(OP_ARGS);
static void	fBCLR_X64(OP_ARGS);
static void	fBMOVE_X8(OP_ARGS);
static void	fBMOVE_X16(OP_ARGS);
static void	fBMOVE_X32(OP_ARGS);
static void	fBMOVE_X64(OP_ARGS);
static void fBADD_I8(OP_ARGS);
static void fBADD_I16(OP_ARGS);
static void fBADD_I32(OP_ARGS);
static void fBADD_I64(OP_ARGS);
static void fBADD_F32(OP_ARGS);
static void fBADD_F64(OP_ARGS);
static void fBSUB_I8(OP_ARGS);
static void fBSUB_I16(OP_ARGS);
static void fBSUB_I32(OP_ARGS);
static void fBSUB_I64(OP_ARGS);
static void fBSUB_F32(OP_ARGS);
static void fBSUB_F64(OP_ARGS);
static void fBMUL_I8(OP_ARGS);
static void fBMUL_I16(OP_ARGS);
static void fBMUL_I32(OP_ARGS);
static void fBMUL_I64(OP_ARGS);
static void fBMUL_F32(OP_ARGS);
static void fBMUL_F64(OP_ARGS);
static void fBDIV_I8(OP_ARGS);
static void fBDIV_I16(OP_ARGS);
static void fBDIV_I32(OP_ARGS);
static void fBDIV_I64(OP_ARGS);
static void fBDIV_F32(OP_ARGS);
static void fBDIV_F64(OP_ARGS);
static void fBMOD_I8(OP_ARGS);
static void fBMOD_I16(OP_ARGS);
static void fBMOD_I32(OP_ARGS);
static void fBMOD_I64(OP_ARGS);
static void fBMOD_F32(OP_ARGS);
static void fBMOD_F64(OP_ARGS);
static void fBNEG_I8(OP_ARGS);
static void fBNEG_I16(OP_ARGS);
static void fBNEG_I32(OP_ARGS);
static void fBNEG_I64(OP_ARGS);
static void fBNEG_F32(OP_ARGS);
static void fBNEG_F64(OP_ARGS);
static void fBSHL_I8(OP_ARGS);
static void fBSHL_I16(OP_ARGS);
static void fBSHL_I32(OP_ARGS);
static void fBSHL_I64(OP_ARGS);
static void fBSHR_I8(OP_ARGS);
static void fBSHR_I16(OP_ARGS);
static void fBSHR_I32(OP_ARGS);
static void fBSHR_I64(OP_ARGS);
static void fBAND_X8(OP_ARGS);
static void fBAND_X16(OP_ARGS);
static void fBAND_X32(OP_ARGS);
static void fBAND_X64(OP_ARGS);
static void fBOR_X8(OP_ARGS);
static void fBOR_X16(OP_ARGS);
static void fBOR_X32(OP_ARGS);
static void fBOR_X64(OP_ARGS);
static void fBXOR_X8(OP_ARGS);
static void fBXOR_X16(OP_ARGS);
static void fBXOR_X32(OP_ARGS);
static void fBXOR_X64(OP_ARGS);
static void fBINV_X8(OP_ARGS);
static void fBINV_X16(OP_ARGS);
static void fBINV_X32(OP_ARGS);
static void fBINV_X64(OP_ARGS);
static void fBSHL_X8(OP_ARGS);
static void fBSHL_X16(OP_ARGS);
static void fBSHL_X32(OP_ARGS);
static void fBSHL_X64(OP_ARGS);
static void fBSHR_X8(OP_ARGS);
static void fBSHR_X16(OP_ARGS);
static void fBSHR_X32(OP_ARGS);
static void fBSHR_X64(OP_ARGS);
#endif

static void fSYS_OUT_U8(OP_ARGS);
static void fSYS_OUT_U16(OP_ARGS);
static void fSYS_OUT_U32(OP_ARGS);
static void fSYS_OUT_U64(OP_ARGS);
static void fSYS_OUT_S8(OP_ARGS);
static void fSYS_OUT_S16(OP_ARGS);
static void fSYS_OUT_S32(OP_ARGS);
static void fSYS_OUT_S64(OP_ARGS);
static void fSYS_OUT_F32(OP_ARGS);
static void fSYS_OUT_F64(OP_ARGS);
static void fSYS_OUT_STR(OP_ARGS);
static void fSYS_INP_U8(OP_ARGS);
static void fSYS_INP_U16(OP_ARGS);
static void fSYS_INP_U32(OP_ARGS);
static void fSYS_INP_U64(OP_ARGS);
static void fSYS_INP_S8(OP_ARGS);
static void fSYS_INP_S16(OP_ARGS);
static void fSYS_INP_S32(OP_ARGS);
static void fSYS_INP_S64(OP_ARGS);
static void fSYS_INP_F32(OP_ARGS);
static void fSYS_INP_F64(OP_ARGS);
static void fSYS_INP_STR(OP_ARGS);
static void fSYS_BRK(OP_ARGS);
static void fSYS_DUMP(OP_ARGS);
static void fSYS_VER(OP_ARGS);
static void fSYS_NEW_X8(OP_ARGS);
static void fSYS_NEW_X16(OP_ARGS);
static void fSYS_NEW_X32(OP_ARGS);
static void fSYS_NEW_X64(OP_ARGS);
static void fSYS_DEL_X8(OP_ARGS);
static void fSYS_DEL_X16(OP_ARGS);
static void fSYS_DEL_X32(OP_ARGS);
static void fSYS_DEL_X64(OP_ARGS);