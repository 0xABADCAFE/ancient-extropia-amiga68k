//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "VM_ObjectCode.hpp"

const char* VMOBJ::XSFIDString = "eXtropia Virtual Machine Code";


VMOBJ::VMOBJ() : XSFOBJ((char*)XSFIDString, 0, 0, 1, 0),
								 shared(), code(0), constData(0), wrtblData(0)
{
	RawSize(sizeof(shared));
}

VMOBJ::~VMOBJ()
{
	Free();
}

void	VMOBJ::Free()
{
	if (code)				delete[] code;
	if (constData)	delete[] constData;
	if (wrtblData)	delete[] wrtblData;
	wrtblData = 0;
	constData = 0;
	code = 0;
	RawSize(sizeof(shared));
}

sint32 VMOBJ::ReadBody(XSFIO& f)
{
	Free();
	f.Read32(&shared, sizeof(shared)/sizeof(uint32));

	if (Alloc()!= OK)
		return ERR_NO_FREE_STORE;

	// read the code
	if (code && shared.codeLen)
		f.Read32(code, shared.codeLen);

	if (wrtblData && shared.data64Len)
		f.Read64(wrtblData, shared.data64Len/sizeof(uint64));

	if (constData && shared.const64Len)
		f.Read64(constData, shared.const64Len/sizeof(uint64));

	if (wrtblData && shared.data32Len)
	{
		uint32* p = (uint32*)((uint8*)wrtblData + shared.data64Len);
		f.Read32(p, shared.data32Len/sizeof(uint32));
	}
	if (constData && shared.const32Len)
	{
		uint32* p = (uint32*)((uint8*)constData + shared.const64Len);
		f.Read32(p, shared.const32Len/sizeof(uint32));
	}
	if (wrtblData && shared.data16Len)
	{
		uint16* p = (uint16*)((uint8*)wrtblData + shared.data64Len + shared.data32Len);
		f.Read16(p, shared.data16Len/sizeof(uint16));
	}
	if (constData && shared.const16Len)
	{
		uint16* p = (uint16*)((uint8*)constData + shared.data64Len + shared.data32Len);
		f.Read16(p, shared.const16Len/sizeof(uint16));
	}
	if (wrtblData && shared.data8Len)
	{
		uint8* p = ((uint8*)wrtblData + shared.data64Len + shared.data32Len + shared.data16Len);
		f.Read8(p, shared.data8Len);
	}
	if (constData && shared.const8Len)
	{
		uint8* p = ((uint8*)constData + shared.const64Len + shared.const32Len + shared.const16Len);
		f.Read8(p, shared.const8Len);
	}
	return RawSize();
}

sint32 VMOBJ::WriteBody(XSFIO& f)
{
	sint32 size = RawSize()-sizeof(shared);
	f.Write32(&shared, sizeof(shared)/sizeof(uint32));
	if (code)
		f.Write32(code, shared.codeLen);

	if (wrtblData && shared.data64Len)
		f.Write64(wrtblData, shared.data64Len/sizeof(uint64));

	if (constData && shared.const64Len)
		f.Write64(constData, shared.const64Len/sizeof(uint64));

	if (wrtblData && shared.data32Len)
	{
		uint32* p = (uint32*)((uint8*)wrtblData + shared.data64Len);
		f.Write32(p, shared.data32Len/sizeof(uint32));
	}
	if (constData && shared.const32Len)
	{
		uint32* p = (uint32*)((uint8*)constData + shared.const64Len);
		f.Write32(p, shared.const32Len/sizeof(uint32));
	}
	if (wrtblData && shared.data16Len)
	{
		uint16* p = (uint16*)((uint8*)wrtblData + shared.data64Len + shared.data32Len);
		f.Write16(p, shared.data16Len/sizeof(uint16));
	}
	if (constData && shared.const16Len)
	{
		uint16* p = (uint16*)((uint8*)constData + shared.data64Len + shared.data32Len);
		f.Write16(p, shared.const16Len/sizeof(uint16));
	}
	if (wrtblData && shared.data8Len)
	{
		uint8* p = ((uint8*)wrtblData + shared.data64Len + shared.data32Len + shared.data16Len);
		f.Write8(p, shared.data8Len);
	}
	if (constData && shared.const8Len)
	{
		uint8* p = ((uint8*)constData + shared.const64Len + shared.const32Len + shared.const16Len);
		f.Write8(p, shared.const8Len);
	}
	return RawSize();
}

sint32 VMOBJ::Create(size_t I, size_t D64, size_t D32, size_t D16, size_t D8, size_t C64, size_t C32, size_t C16, size_t C8)
{
	Free();
	shared.codeLen		= (I&1) ? I+1 : I;	// always allocate even nbr
	shared.data64Len	= D64*sizeof(uint64);
	shared.data32Len	= D32*sizeof(uint32);
	shared.data16Len	= (D16 + ((D16&1) ? 1 : 0))*sizeof(uint16);
	shared.data8Len		= D8 + ((D8&3) ? 4 - (D8&3) : 0);
	shared.const64Len	= C64*sizeof(uint64);
	shared.const32Len	= C32*sizeof(uint32);
	shared.const16Len	= C16*sizeof(uint16);
	shared.const16Len	= (C16 + ((C16&1) ? 1 : 0))*sizeof(uint16);
	shared.const8Len	= C8 + ((C8&3) ? 4 - (C8&3) : 0);
	return Alloc();
}

sint32 VMOBJ::Alloc()
{
	// allocate the code
	if (shared.codeLen)
	{
		code = new uint32[shared.codeLen];
		if (!code)
			return ERR_NO_FREE_STORE;
	}
	else
		code = 0;


	// allocate the mutable data space
	size_t dataSize = shared.data64Len + shared.data32Len +
										shared.data16Len + shared.data8Len;
	size_t totalSize = sizeof(shared) + shared.codeLen*sizeof(uint32) + dataSize;
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
	dataSize = shared.const64Len + shared.const32Len +
						 shared.const16Len + shared.const8Len;
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
