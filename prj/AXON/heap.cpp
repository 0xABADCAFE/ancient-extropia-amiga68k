//*****************************************************************//
//** Description:   Axonometric Projector, AmigaOS/68K version   **//
//** First Started:                                              **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "axon.hpp"

xTEXTURE*	TEXTUREHEAP::heap					= 0;
uint32*		TEXTUREHEAP::keys					= 0;
sint32		TEXTUREHEAP::index				= 0;
sint32		TEXTUREHEAP::heapSize			= 0;
xTEXTURE*	TEXTUREHEAP::lastTexture	= 0;
uint32		TEXTUREHEAP::lastKey			= 0;

sint32 TEXTUREHEAP::Init(sint32 size)
{
	heap = New(heap, (size_t)size);
	if (!heap)
	{
		Done();
		return ERR_NO_FREE_STORE;
	}
	keys = New(keys, size);
	if (!keys)
	{
		Done();
		return ERR_NO_FREE_STORE;
	}
	heapSize = size;
	printf("TEXTUREHEAP::Init(%d) OK\n", size);
	return OK;
}

sint32 TEXTUREHEAP::Done()
{
	if (keys)
	{
		Delete(keys);
		keys = 0;
	}
	if (heap)
	{
		Delete(heap);
		heap = 0;
	}
	lastTexture = 0;
	lastKey = 0;
	index = 0;
	heapSize = 0;
	puts("TEXTUREHEAP::Done() OK");
	return OK;
}

xTEXTURE* TEXTUREHEAP::UsePPM(const char* name, uint32 alphagen)
{
	ruint32 key = Key(name);
	xTEXTURE* result = FindByKey(key);
	if (!result)
	{
		if (index < heapSize)
		{
			if (heap[index].LoadPPM(name, alphagen)!=OK)
				return 0;
			keys[index] = key;
			result = &heap[index++];
		}
		else
			return 0;
	}

	lastKey = key;
	lastTexture = result;
	return result;
}

xTEXTURE* TEXTUREHEAP::UseTex(const char* name, sint32 forceFmt)
{
	uint32 key = Key(name);
	xTEXTURE* result = FindByKey(key);
	if (!result)
	{
		if (index < heapSize)
		{
			if (heap[index].Load(name, forceFmt)!=OK)
				return 0;
			keys[index] = key;
			result = &heap[index++];
		}
		else
			return 0;
	}
	lastKey = key;
	lastTexture = result;
	return result;
}