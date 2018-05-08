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

#if (X_ENDIAN == XA_BIGENDIAN)

void VMCORE::DecodeSYS_EA(EA_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[2];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,s);
	else
	{
		switch(s)
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
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::Decode2SYS_EA(EA_2ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[2];
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

	x = ((uint8*)This->instPtr)[3];
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,s2);
	else
	{
		switch(s2)
		{
			case 1:
				This->imReg[1].ValU8() = x-VM::IM0;
				This->op[1].any = This->imReg[1].Data8();
				break;
			case 2:
				This->imReg[1].ValU16() = x-VM::IM0;
				This->op[1].any = This->imReg[1].Data16();
				break;
			case 4:
				This->imReg[1].ValU32() = x-VM::IM0;
				This->op[1].any = This->imReg[1].Data32();
				break;
			case 8:
				This->imReg[1].ValU64() = x-VM::IM0;
				This->op[1].any = This->imReg[1].Data64();
				break;
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS(OP_ARGS)
{
	cout.flush();
	fflush(0);
	sysTable[((uint8*)This->instPtr)[1]](This);
	This->instPtr++;
}

/////////////////////////////////////////////////////////////////////////////////////

#else

void VMCORE::DecodeSYS_EA(EA_ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[1];
	if (x<VM::IM0)
		This->op[0].any = eaTable[x](This,s);
	else
	{
		switch(s)
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
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::Decode2SYS_EA(EA_2ARGS)
{
	uint32 x = ((uint8*)This->instPtr)[1];
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

	x = ((uint8*)This->instPtr)[0];
	if (x<VM::IM0)
		This->op[1].any = eaTable[x](This,s2);
	else
	{
		switch(s2)
		{
			case 1:
				This->imReg[1].ValU8() = x-VM::IM0;
				This->op[1].any = This->imReg[1].Data8();
				break;
			case 2:
				This->imReg[1].ValU16() = x-VM::IM0;
				This->op[1].any = This->imReg[1].Data16();
				break;
			case 4:
				This->imReg[1].ValU32() = x-VM::IM0;
				This->op[1].any = This->imReg[1].Data32();
				break;
			case 8:
				This->imReg[1].ValU64() = x-VM::IM0;
				This->op[1].any = This->imReg[1].Data64();
				break;
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS(OP_ARGS)
{
	cout.flush();
	fflush(0);
	sysTable[((uint8*)This->instPtr)[2]](This);
	This->instPtr++;
}

#endif

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_OUT_U8(OP_ARGS)
{
	DecodeSYS_EA(This,1);
	cout << *This->op[0].u8;
}

void VMCORE::fSYS_OUT_U16(OP_ARGS)
{
	DecodeSYS_EA(This,2);
	cout << *This->op[0].u16;
}

void VMCORE::fSYS_OUT_U32(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	cout << *This->op[0].u32;
}

void VMCORE::fSYS_OUT_U64(OP_ARGS)
{
	DecodeSYS_EA(This,8);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_OUT_S8(OP_ARGS)
{
	DecodeSYS_EA(This,1);
	cout << *This->op[0].s8;
}

void VMCORE::fSYS_OUT_S16(OP_ARGS)
{
	DecodeSYS_EA(This,2);
	cout << *This->op[0].s16;
}

void VMCORE::fSYS_OUT_S32(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	cout << *This->op[0].s32;
}

void VMCORE::fSYS_OUT_S64(OP_ARGS)
{
	DecodeSYS_EA(This,1);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_OUT_F32(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	cout << *This->op[0].f32;
}

void VMCORE::fSYS_OUT_F64(OP_ARGS)
{
	DecodeSYS_EA(This,8);
	cout << *This->op[0].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_OUT_STR(OP_ARGS)
{
	DecodeSYS_EA(This,1);
	cout << This->op[0].ch;
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_INP_U8(OP_ARGS)
{
	DecodeSYS_EA(This,1);
	cin >> *This->op[0].u8;
}

void VMCORE::fSYS_INP_U16(OP_ARGS)
{
	DecodeSYS_EA(This,2);
	cin >> *This->op[0].u16;
}

void VMCORE::fSYS_INP_U32(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	cin >> *This->op[0].u32;
}

void VMCORE::fSYS_INP_U64(OP_ARGS)
{
	DecodeSYS_EA(This,8);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_INP_S8(OP_ARGS)
{
	DecodeSYS_EA(This,1);
	cin >> *This->op[0].s8;
}

void VMCORE::fSYS_INP_S16(OP_ARGS)
{
	DecodeSYS_EA(This,2);
	cin >> *This->op[0].s16;
}

void VMCORE::fSYS_INP_S32(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	cin >> *This->op[0].s32;
}

void VMCORE::fSYS_INP_S64(OP_ARGS)
{
	DecodeSYS_EA(This,8);
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_INP_F32(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	cin >> *This->op[0].f32;
}

void VMCORE::fSYS_INP_F64(OP_ARGS)
{
	DecodeSYS_EA(This,8);
	cin >> *This->op[0].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

#ifndef XP_WIN32

void VMCORE::fSYS_INP_STR(OP_ARGS)
{
	Decode2SYS_EA(This,4,1);
	//sysBASELIB::MessageBox("VMCORE Debug Info", "Proceed", "*op[0].s32 is %d\nop[1].u8 points to %p", *This->op[0].s32, This->op[1].u8);
	fgets((char*)(This->op[1].u8),*This->op[0].s32, stdin);
}

#else

void VMCORE::fSYS_INP_STR(OP_ARGS)
{
  Decode2SYS_EA(This,4,1);
  //sysBASELIB::MessageBox("VMCORE Debug Info", "Proceed", "*op[0].s32 is %d\nop[1].u8 points to %p", *This->op[0].s32, This->op[1].u8);
  cout.flush();
  //fflush(stdin);
  cin >> (char*)(This->op[1].u8);
  /*char  *s   = (char*)(This->op[1].u8);
  sint32 max = *This->op[0].s32;
  sint32 i   = 0;
  char   ch;
  while(i<max-1 && (ch=getchar())!='\n')
    s[i++] = ch;
  s[i] = 0;*/
  //fgets((char*)(This->op[1].u8),*This->op[0].s32, stdin);
}

#endif

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_BRK(OP_ARGS)
{
	//cout << "Kiss my chuddies, man!\n";
}

void VMCORE::fSYS_DUMP(OP_ARGS)
{
	puts("                 ______________________");
	puts("  ______________/ VMCORE Register Dump \\______________");
	for (sint32 i=0; i<32; i+=2)
		printf("  r%-2d: 0x%08X:%08X    r%-2d: 0x%08X:%08X\n",
					i, This->gpRegs[i].MSW(), This->gpRegs[i].LSW(),
					i+1, This->gpRegs[i+1].MSW(), This->gpRegs[i+1].LSW()	);
	printf("  PC  : %-5dMS  : %-5dRS   : %-5dDS  : %d\n",
				  This->GetPC(), (This->methodStack-This->methodStackBase),
				  (This->regStack-This->regStackBase),
				  (This->stack-This->stackBase)	);
	printf("  Code: %-5dData: %-5dConst: %-5d\n",
					This->vmObject->CodeSize(), This->vmObject->DataSize(), This->vmObject->CnstSize());
	puts("  ____________________________________________________\n");
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_VER(OP_ARGS)
{
	puts("eXtropia VMCORE version 1");
}

#if (X_ENDIAN == XA_BIGENDIAN)

void VMCORE::fSYS_NEW_X8(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	This->gpRegs[((uint8*)This->instPtr)[3]/*&0x1F*/].PtrU8() = new uint8[*This->op[0].s32];
	//cerr << "Allocated " << (*This->op[0].s32) << "bytes\n";
}

void VMCORE::fSYS_NEW_X16(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	This->gpRegs[((uint8*)This->instPtr)[3]/*&0x1F*/].PtrU16() = new uint16[*This->op[0].s32];
	//cerr << "Allocated " << (*This->op[0].s32) << "x16-bit words\n";
}

void VMCORE::fSYS_NEW_X32(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	This->gpRegs[((uint8*)This->instPtr)[3]/*&0x1F*/].PtrU32() = new uint32[*This->op[0].s32];
	//cerr << "Allocated " << (*This->op[0].s32) << "x32-bit words\n";
}

void VMCORE::fSYS_NEW_X64(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	This->gpRegs[((uint8*)This->instPtr)[3]/*&0x1F*/].PtrU64() = new uint64[*This->op[0].s32];
	//cerr << "Allocated " << (*This->op[0].s32) << "x64-bit words\n";
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_DEL_X8(OP_ARGS)
{
	delete[] This->gpRegs[((uint8*)This->instPtr)[3]/*&0x1F*/].PtrU8();
	//cerr << "Free 8-bit\n";
}

void VMCORE::fSYS_DEL_X16(OP_ARGS)
{
	delete[] This->gpRegs[((uint8*)This->instPtr)[3]/*&0x1F*/].PtrU16();
	//cerr << "Free 16-bit\n";
}

void VMCORE::fSYS_DEL_X32(OP_ARGS)
{
	delete[] This->gpRegs[((uint8*)This->instPtr)[3]/*&0x1F*/].PtrU32();
	//cerr << "Free 32-bit\n";
}

void VMCORE::fSYS_DEL_X64(OP_ARGS)
{
	delete[] This->gpRegs[((uint8*)This->instPtr)[3]/*&0x1F*/].PtrU64();
	//cerr << "Free 64-bit\n";
}

/////////////////////////////////////////////////////////////////////////////////////

#else

void VMCORE::fSYS_NEW_X8(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	This->gpRegs[((uint8*)This->instPtr)[0]/*&0x1F*/].PtrU8() = new uint8[*This->op[0].s32];
}

void VMCORE::fSYS_NEW_X16(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	This->gpRegs[((uint8*)This->instPtr)[0]/*&0x1F*/].PtrU16() = new uint16[*This->op[0].s32];
}

void VMCORE::fSYS_NEW_X32(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	This->gpRegs[((uint8*)This->instPtr)[0]/*&0x1F*/].PtrU32() = new uint32[*This->op[0].s32];
}

void VMCORE::fSYS_NEW_X64(OP_ARGS)
{
	DecodeSYS_EA(This,4);
	This->gpRegs[((uint8*)This->instPtr)[0]/*&0x1F*/].PtrU64() = new uint64[*This->op[0].s32];
}

/////////////////////////////////////////////////////////////////////////////////////

void VMCORE::fSYS_DEL_X8(OP_ARGS)
{
	delete[] This->gpRegs[((uint8*)This->instPtr)[0]/*&0x1F*/].PtrU8();
}

void VMCORE::fSYS_DEL_X16(OP_ARGS)
{
	delete[] This->gpRegs[((uint8*)This->instPtr)[0]/*&0x1F*/].PtrU16();
}

void VMCORE::fSYS_DEL_X32(OP_ARGS)
{
	delete[] This->gpRegs[((uint8*)This->instPtr)[0]/*&0x1F*/].PtrU32();
}

void VMCORE::fSYS_DEL_X64(OP_ARGS)
{
	delete[] This->gpRegs[((uint8*)This->instPtr)[0]/*&0x1F*/].PtrU64();
}


#endif

/////////////////////////////////////////////////////////////////////////////////////
