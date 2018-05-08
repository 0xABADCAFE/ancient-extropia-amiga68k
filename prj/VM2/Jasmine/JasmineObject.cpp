//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "JasmineObject.hpp"

const char*		JASMINEOBJECT::XSFIDString		= "Extropia Studios Virtual Machine";
const char*		JASMINEOBJECT::XSFFileSig			= "VMCODE";
const uint16	JASMINEOBJECT::XSFSuperClass	= 0x0000;
const uint16	JASMINEOBJECT::XSFSubClass		= 0x0000;
const uint8		JASMINEOBJECT::XSFDataFormat	= (XA_ALIGN32|X_ENDIAN|X_NEGATIVE);
const uint8		JASMINEOBJECT::XSFFileFormat	= 0;


JASMINEOBJECT::JASMINEOBJECT() : XSFOBJ((char*)XSFIDString, 0, 0, 1, 0),
								 shared32(), shared16(), shared8(), code(0), constData(0), wrtblData(0)
{
	RawSize(sizeof(shared32)+sizeof(shared16)+sizeof(shared8));
}

JASMINEOBJECT::~JASMINEOBJECT()
{
	Free();
}

void	JASMINEOBJECT::Free()
{
	if (funcTab)
	{
		delete[] funcTab;
	}
	else if (code)
	{
		delete[] code;
	}
	if (constData)
	{
		delete[] constData;
	}
	if (wrtblData)
	{
		delete[] wrtblData;
	}
	funcTab = 0;
	code = 0;
	wrtblData = 0;
	constData = 0;
	RawSize(sizeof(shared32));
}

sint32 JASMINEOBJECT::ReadBody(XSFIO& f)
{
	Free();
	f.Read32(&shared32, sizeof(shared32)/sizeof(uint32));
	f.Read16(&shared16, sizeof(shared16)/sizeof(uint16));
	f.Read8(&shared8, 	sizeof(shared8));

	if (Alloc()!= OK)
		return ERR_NO_FREE_STORE;

	if (funcTab && shared32.funcTabLen)
		f.Read32(funcTab, shared32.funcTabLen*(sizeof(JFINFO)/sizeof(uint32)));
	if (code && shared32.codeLen)
		f.Read32(code, shared32.codeLen);
	if (wrtblData && shared32.data64Len)
		f.Read64(wrtblData, shared32.data64Len/sizeof(uint64));
	if (constData && shared32.const64Len)
		f.Read64(constData, shared32.const64Len/sizeof(uint64));
	if (wrtblData && shared32.data32Len)
	{
		uint32* p = (uint32*)((uint8*)wrtblData + shared32.data64Len);
		f.Read32(p, shared32.data32Len/sizeof(uint32));
	}
	if (constData && shared32.const32Len)
	{
		uint32* p = (uint32*)((uint8*)constData + shared32.const64Len);
		f.Read32(p, shared32.const32Len/sizeof(uint32));
	}
	if (wrtblData && shared32.data16Len)
	{
		uint16* p = (uint16*)((uint8*)wrtblData + shared32.data64Len + shared32.data32Len);
		f.Read16(p, shared32.data16Len/sizeof(uint16));
	}
	if (constData && shared32.const16Len)
	{
		uint16* p = (uint16*)((uint8*)constData + shared32.data64Len + shared32.data32Len);
		f.Read16(p, shared32.const16Len/sizeof(uint16));
	}
	if (wrtblData && shared32.data8Len)
	{
		uint8* p = ((uint8*)wrtblData + shared32.data64Len + shared32.data32Len + shared32.data16Len);
		f.Read8(p, shared32.data8Len);
	}
	if (constData && shared32.const8Len)
	{
		uint8* p = ((uint8*)constData + shared32.const64Len + shared32.const32Len + shared32.const16Len);
		f.Read8(p, shared32.const8Len);
	}
	return RawSize();
}

sint32 JASMINEOBJECT::WriteBody(XSFIO& f)
{
	//sint32 size = RawSize()-sizeof(shared32)-sizeof(shared16)-sizeof(shared8);
	f.Write32(&shared32,	sizeof(shared32)/sizeof(uint32));
	f.Write16(&shared16,	sizeof(shared16)/sizeof(uint16));
	f.Write8(&shared8,		sizeof(shared8));
	if (funcTab)
		f.Write32(funcTab, shared32.funcTabLen*(sizeof(JFINFO)/sizeof(uint32)));
	if (code)
		f.Write32(code, shared32.codeLen);
	if (wrtblData && shared32.data64Len)
		f.Write64(wrtblData, shared32.data64Len/sizeof(uint64));
	if (constData && shared32.const64Len)
		f.Write64(constData, shared32.const64Len/sizeof(uint64));
	if (wrtblData && shared32.data32Len)
	{
		uint32* p = (uint32*)((uint8*)wrtblData + shared32.data64Len);
		f.Write32(p, shared32.data32Len/sizeof(uint32));
	}
	if (constData && shared32.const32Len)
	{
		uint32* p = (uint32*)((uint8*)constData + shared32.const64Len);
		f.Write32(p, shared32.const32Len/sizeof(uint32));
	}
	if (wrtblData && shared32.data16Len)
	{
		uint16* p = (uint16*)((uint8*)wrtblData + shared32.data64Len + shared32.data32Len);
		f.Write16(p, shared32.data16Len/sizeof(uint16));
	}
	if (constData && shared32.const16Len)
	{
		uint16* p = (uint16*)((uint8*)constData + shared32.data64Len + shared32.data32Len);
		f.Write16(p, shared32.const16Len/sizeof(uint16));
	}
	if (wrtblData && shared32.data8Len)
	{
		uint8* p = ((uint8*)wrtblData + shared32.data64Len + shared32.data32Len + shared32.data16Len);
		f.Write8(p, shared32.data8Len);
	}
	if (constData && shared32.const8Len)
	{
		uint8* p = ((uint8*)constData + shared32.const64Len + shared32.const32Len + shared32.const16Len);
		f.Write8(p, shared32.const8Len);
	}
	return RawSize();
}

sint32 JASMINEOBJECT::Alloc()
{
	// allocate the code table and code

	size_t codeTabSize = shared32.funcTabLen*(sizeof(JFINFO)/sizeof(uint32));

	if ((shared32.codeLen+codeTabSize)!=0)
	{
		uint32* space = new uint32[shared32.codeLen+codeTabSize];
		if (!space)
			return ERR_NO_FREE_STORE;
		if (codeTabSize)
			funcTab = (JFINFO*)space;
		else
			funcTab = 0;
		if (shared32.codeLen)
			code = space + codeTabSize;
		else
			code = 0;
	}
	else
	{
		code = 0;
		funcTab = 0;
	}

	// allocate the mutable data space
	size_t totalSize = sizeof(shared32) + shared32.codeLen*sizeof(uint32);
	size_t dataSize = shared32.data64Len + shared32.data32Len +
										shared32.data16Len + shared32.data8Len;
	totalSize += dataSize;

	if (dataSize)
	{
		wrtblData = new uint64[dataSize/sizeof(uint64) +
													(dataSize%sizeof(uint64) ? 1:0)];
		if (!wrtblData)
		{
			Free();
			return ERR_NO_FREE_STORE;
		}
	}
	else
		wrtblData = 0;

	// allocate the constant data space
	dataSize = shared32.const64Len + shared32.const32Len +
						 shared32.const16Len + shared32.const8Len;
	totalSize += dataSize;

	if (dataSize)
	{
		constData = new uint64[dataSize/sizeof(uint64) +
												 	(dataSize%sizeof(uint64) ? 1:0)];
		if (!constData)
		{
			Free();
			return ERR_NO_FREE_STORE;
		}
	}
	else
		constData = 0;

	RawSize(totalSize);
	return OK;
}

uint32	JASMINEOBJECT::FuncSize()		{ return (shared32.funcTabLen); }
uint32	JASMINEOBJECT::CodeSize()		{ return (shared32.codeLen); }
uint32	JASMINEOBJECT::DataSize()		{ return (shared32.data64Len+shared32.data32Len+shared32.data16Len+shared32.data8Len); }
uint32	JASMINEOBJECT::CnstSize()		{ return (shared32.const64Len+shared32.const32Len+shared32.const16Len+shared32.const8Len); }

JFINFO*	JASMINEOBJECT::Method(uint32 n)
{
	if (n > shared32.funcTabLen || !funcTab)
		return 0;
	return &funcTab[n];
}

void JASMINEOBJECT::ListMethods()
{
	if (shared32.funcTabLen && funcTab)
	{
		puts("+-------------------------------------+");
		printf("| %-35s |\n", shared8.progName);
		puts("+-------------------------------------+");
		puts("| Func   Offset Name key   Sign. key  |");
		for (sint32 i=0; i<shared32.funcTabLen; i++)
		{
			printf("| %4d %8d 0x%08X 0x%08X |\n", i, funcTab[i].offset,
						(uint32)funcTab[i].nameKey, (uint32)funcTab[i].signKey);
		}
		puts("+-------------------------------------+");
	}
}

JASMINEOBJECT* JASMINEFACTORY::Create(char* n, sint16 v, sint16 r, size_t F, size_t I, size_t S, size_t MS, size_t RS, \
	size_t D64, size_t D32, size_t D16, size_t D8, size_t C64, size_t C32, size_t C16, size_t C8)
{
	JASMINEOBJECT* j = new JASMINEOBJECT;
	if (!j)
		return 0;
	j->shared32.funcTabLen		= F;
	j->shared32.codeLen				= (I&1) ? I+1 : I;	// always allocate even nbr
	j->shared32.data64Len			= D64*sizeof(uint64);
	j->shared32.data32Len			= D32*sizeof(uint32);
	j->shared32.data16Len			= D16*sizeof(uint16);
	j->shared32.data8Len			= D8 + (D8 ? 4 - (D8&3) : 0);
	j->shared32.const64Len		= D64*sizeof(uint64);
	j->shared32.const32Len		= D32*sizeof(uint32);
	j->shared32.const16Len		= D16*sizeof(uint16);
	j->shared32.const8Len			= C8 + (C8 ? 4 - (C8&3) : 0);
	if (j->Alloc()==OK)
	{
		j->shared32.stackSize			= S  + (S ? 4 - (S&3) : 0);
		j->shared32.methodSize		= MS;
		j->shared32.regSize				= RS;
		j->shared16.progVersion		= v;
		j->shared16.progRevision	= r;
		strncpy(j->shared8.progName, n, 31);
		j->shared8.progName[31] = 0;
		return j;
	}
	delete j;
		return 0;
}
