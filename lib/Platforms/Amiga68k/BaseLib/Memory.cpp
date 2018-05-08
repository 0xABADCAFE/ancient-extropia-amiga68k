//****************************************************************************//
//** File:         sysBase.cpp ($NAME=sysBase.cpp)                          **//
//** Description:  eXtropia Library Base API Source                         **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      Base                                                     **//
//** Created:      2001-02-20                                               **//
//** Updated:      2001-02-26                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2001, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


#include <xBase.hpp>

//// CLASS MEM ///////////////////////////////////////////////////////////////

MEM::MEMINFO*	MEM::allocated	= 0;
sint32				MEM::totSize		= 0;
sint32				MEM::nextFree		= 0;
sint32				MEM::cnt				= 0;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void* MEM::Alloc(size_t len, bool zero, MEM::ALIGNTYPE align)
{
	if (!allocated || cnt == MAXALLOCS) return 0;
	// AllocVec has minimum 4-byte alignment anyway
	uint32 alignLen = ((uint32)align<8) ? 0 : align;
	void* r = AllocVec((len+(alignLen<<1)), (zero?MEMF_PUBLIC|MEMF_CLEAR:MEMF_PUBLIC));
	if (r)
	{
		sint32 index = nextFree;
		allocated[index].real = r;
		if (alignLen)
		{
			uint32 mask = alignLen-1;
			allocated[index].address	= (void*)((mask+(uint32)r) & ~mask);
			//printf("MEM::Alloc() aligned %d [0x%8X : 0x%8X]\n", (sint32)align, (uint32)r, (uint32)allocated[index].address);
		}
		else
			allocated[index].address = r;
		allocated[index].owner		= FindTask(0);
		allocated[index].size			= len;
		totSize += len;
		cnt++;
		while (allocated[nextFree].address != 0)
			nextFree++;
		return allocated[index].address;
	}
	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MEM::Free(void* ptr)
{
	if (!allocated)	return;
	if (ptr)
	{
		sint32 index=-1, found=0;
		while((found==0) && (index<MAXALLOCS))
			found = (ptr==allocated[++index].address);

		if (!found)
		{
			#ifdef X_DEBUG
			sysBASELIB::MessageBox("Debug", "Proceed", "MEM::Free()\nAddress not recognised");
			#endif
			return;
		}

		if (!allocated[index].real)
		{
			#ifdef X_VERBOSE
			sysBASELIB::MessageBox("Debug", "Proceed", "MEM::FreeIndex()\nMemory already free");
			#endif
			return;
		}
		FreeVec(allocated[index].real);
		totSize -= allocated[index].size;
		allocated[index].real			= 0;
		allocated[index].address	= 0;
		allocated[index].owner		= 0;
		allocated[index].size			= 0;
		cnt--;
		if (index < nextFree)
			nextFree = index;
		return;
	}
	#ifdef X_DEBUG
	else
		sysBASELIB::MessageBox("Debug", "Proceed", "MEM::Free()\nAttempt to free null address");
	#endif
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_DEBUG
void MEM::DebugInfo()
{
	if (!allocated)
		return;
	sint32 c=sprintf(sysBASELIB::MsgBuf(), "MEM Statistics\nsysBASE::sysData %d bytes\n\n", \
									 (MAXALLOCS*sizeof(MEMINFO))+MESSAGEBUFFSIZE);

	for (sint32 i=0, l=0, b=0; (i<MAXALLOCS) && (c < MESSAGEBUFFSIZE/2); i++)
	{
		if (allocated[i].address)
		{
			l = sprintf(sysBASELIB::MsgBuf()+c, "Block %d : 0x%08X [%10d]\n",
									b, (uint32)allocated[i].address,
									allocated[i].size);
			b++;
			c+=l;
		}
	}
	if ((b+1) < cnt)
	{
		l = sprintf(sysBASELIB::MsgBuf()+c, "\n<List Truncated>\n");
		c+= l;
	}
	sprintf(sysBASELIB::MsgBuf()+c, "\nTotal %d / %d block(s), %d bytes", cnt, MAXALLOCS, totSize + (MAXALLOCS*sizeof(MEMINFO))+MESSAGEBUFFSIZE);
	EasyStruct mb = {sizeof(EasyStruct),0,"Debug Info", sysBASELIB::MsgBuf(), "Proceed"};
	EasyRequest(0, &mb, 0);
}
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MEM::FreeAll()
{
	if (!allocated)
		return;
	sint32 freed = 0, size=0;
	for (rsint32 i=0; i<MAXALLOCS; i++)
	{
		if (allocated[i].real)
		{
			FreeVec(allocated[i].real);
			totSize -= allocated[i].size;
			size += allocated[i].size;
			allocated[i].real			= 0;
			allocated[i].address	= 0;
			allocated[i].size			= 0;
			allocated[i].owner 		= 0;
			freed++;
			cnt--;
		}
	}
	#ifdef X_DEBUG
	if (freed)
		sysBASELIB::MessageBox("Debug Info","Proceed","MEM::FreeAll()\nReleased %d block(s)\ntotalling %d bytes\n", freed, size);
	#endif
	allocated = 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
void MEM::Copy(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t len)
{
	if (((uint32)dst|(uint32)src|(uint32)len)&3UL)
		CopyMem(src, dst, len);
	else
		CopyMemQuick(src, dst, len);
}
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  MEM::Move() : always attempts to use largest possible bandwith when moving data
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MEM::Move(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t len)
{
	if (dst==src) return;

	if ((uint8*)dst>(uint8*)src)
	{
		// If source+len doesn't overlap dest, just use normal copy
		if (len<=((uint8*)dst-(uint8*)src))
		{
			Copy(dst, src, len);
			return;
		}
		// Need a top-down copy to prevent overwriting source
		// If data aligned to word/dword boundary use optimised copy loops
		// otherwise have to use a crappy bloody byte copy loop
		if (((uint32)dst|(uint32)src)&1UL)
		{	// misaligned
			ruint8* s = (uint8*)src+len;
			ruint8* d = (uint8*)dst+len;
			rsint32 n = len+1;
			// This sort of downward copy is very cache unfriendly
			// Should rewrite as upward block copy based
			while(--n)
				*(--d) = *(--s);
			return;
		}
		else // gap must already be word aligned
		{
			uint32 copyGap = (uint8*)dst-(uint8*)src;
			if (copyGap>7)
			{ // use nearest 32-bit aligned copy length (at least 8)
				copyGap &= (!3UL);
				rsint32 n = len;
				ruint32 *s = (uint32*)src, *d = (uint32*)dst;
				while(n>copyGap)
				{
					rsint32 i=1+(copyGap>>2);
					while (--i)
						*d++ = *s++;
					n-=copyGap;
				}
				if (n) // if remaining data, must be < copyGap thus not overlapping
					Copy(d, s, n);
				return;
			}
			else if (copyGap>3)
			{ // use individual dwords
				rsint32 n = len;
				ruint32 *s = (uint32*)src, *d = (uint32*)dst;
				while(n>4)
				{
					*d++ = *s++;
					n-=4;
				}
				if (n) // 1 - 3 bytes left
				{
					n++;
					while(--n)
						*(((uint8*)d)++) = *(((uint8*)s)++);
				}
				return;
			}
			else
			{
				rsint32 n = len;
				ruint16 *s = (uint16*)src, *d = (uint16*)dst;
				while(n>2)
				{
					*d++ = *s++;
					n-=2;
				}
				if (n) // 1 byte left
					*(((uint8*)d)++) = *(((uint8*)s)++);
				return;
			}
		}
	}
	else // bottom up copy, use normal Copy() for this
		Copy(dst, src, len);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
