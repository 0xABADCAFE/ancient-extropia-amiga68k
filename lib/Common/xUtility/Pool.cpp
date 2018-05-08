//*****************************************************************//
//** Description:   xUtility library : Pool classes              **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2001-03-13                                   **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xUtility/Pool.hpp>

//#define STRICT // enable some stricter checking at expense of performance

// Note, memory is always allocated using sharePPC option where possible

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// POOL_BASE
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_VERBOSE
void POOL_BASE::BasePrint(ostream& out)
{
	out << "\nPOOL information\n" << "        size =   " << size << " entries\n";
	out << "    nextFree =   " << nextFree << "\n" << "   totalFree =   " << totalFree << "\n";
	out << "    base add = 0x" << pool << "\n";
}
#endif

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// POOL_LT
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

POOL_LT::POOL_LT(uint32 entries, uint32 typeSize) : lengthTable(0)
{
	Create(entries, typeSize);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

POOL_LT::~POOL_LT()
{
	Delete(true); // force delete but dont force unallocate - external pointers may be out of scope
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_VERBOSE
void POOL_LT::PrintAlloc(ostream& out, sint32 s, sint32 l)
{
	out << "\nPOOL_LT Allocation Information\n";
	rsint32 i = 0, j = 0;
	while (i <size && j < l)
	{
		// Hop through allocations
		if (allocTable[i])
			out << "Allocated";
		else
			out << "Free     ";
		out <<" : pool["<< i << "], size " << lengthTable[i] << "\n";
			i += lengthTable[i];
		j++;
	}
	out << "\n";
}
#endif

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 POOL_LT::ExamineBlock(uint32 location)
{
	// Scan from the supplied position until we hit something concrete
	sint32 i = location, endOfBlock = 0, length = 1;
	while (i < size && !endOfBlock)
	{
		i++;
		if (lengthTable[i] || allocTable[i]) // end of this block marked when we hit any kind of non-zero data
			endOfBlock = length;
		else
			length++;
	}
	return length;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_LT::TestConsistency(bool strict)
{
	// TestConsistency() performs sanity checking on the pool and is able to fix
	// problems relating to bad blocksizes (though they should not happen)

	sint32 mismatches = 0, i = 0, blockErrs = 0;

	//if (!strict)
	{
		// non strict mode uses block hopping technique. It is theoretically possible that
		// some small blocks might be skipped across if the pool size info is really broken
		// Only those sizes that lead to broken positions can be detected here.
		// Strict mode works by linearly examining the whole array with ExamineBlock()
		sint32 lastPos = 0;
		while (i < size)
		{
			uint32 sizeBuff = lengthTable[i];
			// 1. If we jump anywhere with a zero lengthTable[] the previous location's
			//    lengthTable[] was erronious and needs correcting. We may have jumped
			//    short of the next block or overshot one or more other blocks.
			//    ExamineBlock will test the block at lastPos, returning the correct
			//    lengthTable so we can fix it here.
			if (!sizeBuff)
			{
				blockErrs++;
				sizeBuff = ExamineBlock(lastPos);
				lengthTable[lastPos] = sizeBuff;
				i = lastPos + sizeBuff;
			}
			// 2. Test the pointer allocation consistency
			//    Mismatches are caused if the pointer backreferenced in allocTable[]
			//    does not point to the corresponding pool[] entry. Technically the
			//    external code has the responsibility not to forget it's
			//    own pointers, but we can use this information to prevent
			//    changes to the pool that the external code might miss
			if (allocTable[i] && (*(allocTable[i]) != &pool[i*tSize]))
				mismatches++;

	    // 3. Check where the next jump is headed - it may be the case that it
			//    points off the end of the pool, this could not be caught by (1)
  	  //    because of the while ( i < size ) loop construct. Fix it here
			if (i + sizeBuff > size)
			{
				blockErrs++;
				sizeBuff = ExamineBlock(i);
				lengthTable[i] = sizeBuff;
			}
			// We always track the n-1 postion just in case we jump somewhere strange
			lastPos = i;
			i += sizeBuff;
		}
	}
/*
	else
	{
		// Strict mode. Do not trust any data
		uint32 sizeBuff = 0;
		while (i < size)
		{
			// check for uncatenated free blocks, generate overall length and eliminate fragments
	 		while (i+sizeBuff < size && !allocTable[i+sizeBuff])
			{
				BlockErrs++;
				lengthTable[i+sizeBuff] = 0;
				sizeBuff += ExamineBlock(i+sizeBuff);
			}
			// write concatenated free block space
			lengthTable[i] = sizeBuff;

			i += sizeBuff; // bump i to point to next block (or end of array)
			sizeBuff = 1;

			if ( i < size )
			{
				// we must, logically,  have an allocation block now
				if (allocTable[i] && (*(allocTable[i]) != &pool[i*tSize])
				{
					#ifdef PARANOID
					out << "   -> INFO - pointer referenced by allocTable[" << i << "] does not point to pool[" << i << "]\n";
					#endif
					mismatches++;
				}
			}

		}
	}
*/
	return mismatches;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_LT::Create(uint32 s, uint32 t)
{
	if (pool)
		return ERR_RSC_LOCKED;

	tSize = t/2 + (t & 1); // size to nearest 16-bit word
	rawSize = tSize*s;

	// Allocate 1 big block for everything, all 32bit based for now
	// This is sensible given that the whole purpose of the pool
	// is to eliminate fragmentation :)

	uint32 allocationSize = s + s + (rawSize/2) + (rawSize & 1);
	data = (uint32*)MEM::Alloc(allocationSize*sizeof(uint32), true);

	if (!data)
	{
		Init(); // never leave part constructed
		return ERR_NO_FREE_STORE;
	}

	// Use data[] like this
	//  [0]               [s]               [2*s]
	//	[................][................][.......... ... ...........]
	//     allocTable[]      lengthTable[]              pool[]
	//
	// Each table starts at a 32-bit aligned address irrespective of contents

	allocTable = (uint16***)&data[0];
	lengthTable  = (uint32*)&data[s];
	pool			 = (uint16*)&data[2*s];

	size          = s;
	totalFree			= size;
	nextFree			= 0;
	lengthTable[0]  = size;
	return OK;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_LT::Delete(bool force, bool update)
{
	sint32 inUse =  size - totalFree; // should be zero, force can override if not
	if (!force)
	{	// Dont Delete if allocations still in use
		if (inUse)
			return ERR_RSC_LOCKED;
	}
	else
	{
		if (data && inUse && update)
		{	// With force option, we delete regardless. Also, with update we can clear any known external
			// pointers into the pool (assuming pool and allocTable are valid), before we nuke it.
			sint32 p = 0;
			for (sint32 i=0; i < size; i++)
			{
				if (IsInPool(*(allocTable[i])))
					*(allocTable[i]) = 0;
				p++;
			}
		}
	}
	if (data)
	{
		MEM::Free(data);
		Init(); // ensure all data set to appropriate values
	}
	return OK;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_LT::Resize(sint32 s)
{
	if (size == s)
		return OK;

	// minimum size we can reach
	if (s > (size - totalFree))
	{
		// safety check before commiting resize
		if (TestConsistency())
			return ERR_ALLOC_INCONSISTENT;

		uint32 newRawSize = s*tSize;
		uint32 allocationSize = s + s + (newRawSize/2) + (newRawSize & 1);
		uint32* newData = (uint32*)MEM::Alloc(allocationSize*sizeof(uint32), true);

		if (!newData)
			return ERR_NO_FREE_STORE;

		// Use data[] like this
		//  [0]               [s]               [2*s]
		//	[................][................][.......... ... ...........]
		//     allocTable[]      lengthTable[]              pool[]
		//
		// Each table starts at a 32-bit aligned address irrespective of contents

		uint16***	newAllocTable = (uint16***)&newData[0];
		uint32*		newASizeData  = (uint32*)&newData[s];
		uint16*		newPool				= (uint16*)&newData[2*s];

		// All ok so far. Everything in our new pool is zeroed because of new[]
		// Copy all of the allocations block by block

		rsint32 i = 0, j = 0;
		while (i <size)
		{
			// Hop through blocks, copying only allocations
			if (allocTable[i])
			{
				newAllocTable[j]	= allocTable[i];
				newASizeData[j]		= lengthTable[i];
				MEM::Copy(&newPool[j*tSize], &pool[i*tSize], lengthTable[i]*tSize*2); // copy whole block
				j += lengthTable[i];
			}
			i += lengthTable[i];
		}

		// Free the old pool info and transfer the pool vars

		MEM::Free(data);

		data				= newData;
		lengthTable		= newASizeData;
		pool				= newPool;
		allocTable	= newAllocTable;

		totalFree += (s - size);
		size			= s;
		rawSize		= newRawSize;
		nextFree	= size - totalFree;
		return OK;
	}
	return ERR_RESIZE_TO_SMALL;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_LT::Defrag()
{
	if (TestConsistency())
		return ERR_ALLOC_INCONSISTENT;

	// This is still the basic collapse optimization of old, but a bit better optimized thanks to storing the
	// size data. Loop iterations are reduced and we can often copy whole runs of data - in essence we copy
	// as much as possible without overlapping the memory. This is derived from the notion that copying
	// non-overlapping memory blocks is often a bit quicker than copying overlapping ones

	sint32 c = nextFree;			// current index
	sint32 s = c+lengthTable[c];// scan index
	while (s < size)
	{
		rsint32 sizeBuff = lengthTable[s]; // size of current area, free or not
		if (allocTable[s])
		{ // found something at position s or still copying an existing block
			// new block of data
			lengthTable[c]  = sizeBuff;			// copy block size
			allocTable[c] = allocTable[s];		// copy external pointer
			lengthTable[s]  = 0;								// zero original block size
			allocTable[s] = 0;						// zero original pointer
			*(allocTable[c]) = &pool[c*tSize];// update external pointer

			if (s-c > sizeBuff)
			{
				// block to move is smaller than the gap between s and c, so we can copy all at once without overlap
				MEM::Copy(&pool[c*tSize], &pool[s*tSize], sizeBuff*tSize*2);
			}
			else
			{
				register sint32 t = 0, max = s-c; // max is largest non-overlapping block that we can move
				while (t < sizeBuff)
				{
					MEM::Copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], max*tSize*2);
					if (t + max > sizeBuff)
					{// check next iteration will not overun sizeBuff and if true, copy what's left
						max = sizeBuff-t;
						t += max;
						MEM::Copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], max*tSize*2);
					}
					t += max;
				}
			}
			c += sizeBuff;
		}
		s += sizeBuff; // scan hop to next block
	}
	nextFree = c; // set nextFree pointer
	lengthTable[nextFree] = totalFree;
	return OK;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_LT::NewT(void* vt)
{
	ruint16** t = (uint16**)vt;
	if (*(t) != 0)
		return ERR_PTR_USED;
	if (totalFree)
	{
		uint32 sizeBuff = lengthTable[nextFree]; // size of nextFree, >= 1
		allocTable[nextFree] = t;
		lengthTable[nextFree] = 1;				// we allocated 1 entry
		*(t) = &pool[nextFree*tSize];		// set the external pointer to point to the allocated T object
		totalFree--;
		if (totalFree)
		{
			// logically there must be a free entry available somewhere
			if (--sizeBuff) // sizeBuff > 1 == --sizeBuff > 0
			{
				lengthTable[++nextFree] = sizeBuff;
				return OK;
			}
			// to find the nextFree allocation we need to 'hop' across the existing allocations
			rsint32 i = nextFree+1;
			while ((i < size) && allocTable[i]) // i < size just a precaution
				i += lengthTable[i];
			nextFree = i;
			return OK;
		}
		// pool filled
		nextFree = -1;
		return WRN_RSC_EXHAUSTED;
	}
	return ERR_RSC_EXHAUSTED;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_LT::NewT(void* vt, sint32 s)
{
	ruint16** t = (uint16**)vt;
	if (*(t) != 0) // already in use, possibly external
		return ERR_PTR_USED;
	// For arrays, we need a continous run of free space. First, check that there is enough space overall
	if (totalFree < s)
		return ERR_NEW_ALLOC_TO_BIG;
	// OK, now we have to locate a big free wedge of objects, starting at nextFree and scanning upwards
	// Hop over the existing spaces/allocations until we find a space large enough, starting at nextFree
	rsint32 i = nextFree, found = -1;
	while ((i < size) && (found < 0))
	{
		if (allocTable[i] == 0 && lengthTable[i] >= s)
			found = i;
		else
			i += lengthTable[i];
	}
	if (found < 0)
	{
		if (Defrag());
			return ERR_ALLOC_INCONSISTENT;
		found = nextFree;
	}
	uint32 sizeBuff = lengthTable[found];
	// Note : s <= sizeBuff
	if (s < sizeBuff)
	{
		lengthTable[found] = s;								// write size of allocation into lengthTable
		lengthTable[found+s] = sizeBuff - s;	// write remainder free space right after
	}
	allocTable[found] = t;			// copy the pointer address
	*(t) = &pool[found*tSize];	// assign the pointer
	totalFree -= s;
	// If totalfree > 0 and found == nextFree, we need to update
	if (totalFree)
	{
		if (nextFree == found)
		{
			// start looking from the end of this allocation
			i = found+s;
			while ((i < size) && allocTable[i])
				i += lengthTable[i];
			nextFree = i;
		}
		return OK;
	}
	// pool filled
	nextFree = -1;
	return WRN_RSC_EXHAUSTED;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_LT::FreeT(void* vt)
{
	ruint16** t = (uint16**)vt;
	if (*(t) == 0)
		return ERR_PTR_ZERO;
	if (!IsInPool(*(t)))
		return ERR_PTR_RANGE;
	// Work out which entry this is, if any - could be a pointer into the pool but not matching any given allocation
	// Such may happen if someone foolishly increments/decrements the pointer returned by NewT()
	rsint32 found = -1;
	{
		// this uses 2 divisions, but is of absolutely constant complexity
		// neglecting the alignment check perhaps could be optional, but would be
		// possibly a bit more dangerous
		ruint32 p = (uint32)(*(t) - pool);
		#ifdef STRICT
		if (p%tSize)
			return ERR_PTR_INCONSISTENT;
		#endif
		found = p/tSize;
		if (!allocTable[found])
			return ERR_PTR_INCONSISTENT;
	}
	// found now points to the allocation to be freed, check if pointer is the same as one initialized by NewT()
	sint32 result = OK;
	#ifdef STRICT
	if (t != allocTable[found])
		result = WRN_PTR_NOT_UNIQUE;
	#endif
	// Zero the external pointer and alloctable references
	*(t) = 0;
	allocTable[found] = 0;
	ruint32 sizeBuff = lengthTable[found]; // get size of the newly freed area
	totalFree += sizeBuff;											// and add to free space
	// Now the more complicated bit
	// We have just created a block of free space starting at [found] and of lengthTable[found] entries
	// We need to check if the freed area borders any existing ones, and if so, combine them into a
	// singularly marked block of space
	// Check space above (the easy bit)
	if (found + sizeBuff < size)	// first make sure were not already at the end of the pool
	{
		// fuse block above if free
		uint32 next = found + sizeBuff;
		if (allocTable[next] == 0)
		{
			sizeBuff += lengthTable[next]; // add free space lengths
			lengthTable[next] = 0;				 // remove upper block's size marker
			lengthTable[found] = sizeBuff; // write new free space size
		}
	}
	if (found == 0 || found < nextFree || nextFree == -1)
	{
		// Lower boundary does not need to be tested in these cases and nextFree should be updated
		nextFree = found;
		return result;
	}
	// Since nextFree < found there is space before found that may border. Hop through the allocations
	// from nextFree to found and the penultimate area, if free, should be added
	{
		rsint32 prev = -1;
		rsint32 i = nextFree;
		while (i < found)
		{
			if (allocTable[i]==0)
				prev = i;
			else
				prev = -1;
			i += lengthTable[i];
		}
		// when i == found then if prev != -1 we can fuse prev to current free space block
		if (prev >= 0)
		{
			lengthTable[prev] += sizeBuff;
			lengthTable[found] = 0;
		}
	}
	return result;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// POOL_ST
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

POOL_ST::POOL_ST(uint16 entries, uint32 typeSize) : lengthTable(0)
{
	Create(entries, typeSize);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

POOL_ST::~POOL_ST()
{
	Delete (true);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_VERBOSE
void POOL_ST::PrintAlloc(ostream& out, sint32 s, sint32 l)
{
	out << "\nPOOL_ST Allocation Information\n";
	rsint32 i = 0, j = 0;
	while (i <size && j < l)
	{
		if (allocTable[i])
			out << "Allocated";
		else
			out << "Free     ";
		out <<" : pool["<< i << "], size " << lengthTable[i] << "\n";
			i += lengthTable[i];
		j++;
	}
	out << "\n";
}
#endif

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 POOL_ST::ExamineBlock(uint32 location)
{
	uint32 i = location, endOfBlock = 0, length = 1;
	while (i < size && !endOfBlock)
	{
		i++;
		if (lengthTable[i] || allocTable[i])
			endOfBlock = length;
		else
			length++;
	}
	return length;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_ST::TestConsistency(bool strict)
{
	sint32 mismatches = 0, i = 0, blockErrs = 0;

	//if (!strict)
	{
		sint32 lastPos = 0;
		while (i < size)
		{
			uint32 sizeBuff = lengthTable[i];
			if (!sizeBuff)
			{
				blockErrs++;
				sizeBuff = ExamineBlock(lastPos);
				lengthTable[lastPos] = sizeBuff;
				i = lastPos + sizeBuff;
			}
			if (allocTable[i] && (*(allocTable[i]) != &pool[i*tSize]))
				mismatches++;

			if (i + sizeBuff > size)
			{
				blockErrs++;
				sizeBuff = ExamineBlock(i);
				lengthTable[i] = sizeBuff;
			}

			lastPos = i;
			i += sizeBuff;
		}
	}
/*
	else
	{
		// Strict mode. Do not trust any data
		uint32 sizeBuff = 0;
		while (i < size)
		{
			// check for uncatenated free blocks, generate overall length and eliminate fragments
	 		while (i+sizeBuff < size && !allocTable[i+sizeBuff])
			{
				BlockErrs++;
				lengthTable[i+sizeBuff] = 0;
				sizeBuff += ExamineBlock(i+sizeBuff);
			}
			// write concatenated free block space
			lengthTable[i] = sizeBuff;

			i += sizeBuff; // bump i to point to next block (or end of array)
			sizeBuff = 1;

			if ( i < size )
			{
				// we must, logically,  have an allocation block now
				if (allocTable[i] && (*(allocTable[i]) != &pool[i*tSize])
				{
					mismatches++;
				}
			}

		}
	}
*/
	return mismatches;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_ST::Create(uint16 s, uint32 t)
{
	if (pool)
		return ERR_RSC_LOCKED;

	tSize = t/2 + (t & 1); // size to nearest 16-bit word
	rawSize = tSize*s;

	uint32 allocationSize = s + (s/2) + (s & 1) + (rawSize/2) + (rawSize & 1);

	data = (uint32*)MEM::Alloc(allocationSize*sizeof(uint32), true);

	if (!data)
	{
		Init();
		return ERR_NO_FREE_STORE;
	}

	// Use data[] like this
	//  [0]               [s]               [1.5*s]
	//	[................][................][.......... ... ...........]
	//     allocTable[]      lengthTable[]              pool[]
	//
	// Each table starts at a 32-bit aligned address irrespective of contents

	allocTable = (uint16***)&data[0];
	lengthTable  = (uint16*)&data[s];
	pool			 = (uint16*)&data[s + (s/2) + (s&1)];

	size          = s;
	totalFree			= size;
	nextFree			= 0;
	lengthTable[0]  = size;
	return OK;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_ST::Delete(bool force, bool update)
{
	sint32 inUse =  size - totalFree;
	if (!force)
	{
		if (inUse)
			return ERR_RSC_LOCKED;
	}
	else
	{
		if (data && inUse && update)
		{
			sint32 p = 0;
			for (sint32 i=0; i < size; i++)
			{
				if (IsInPool(*(allocTable[i])))
					*(allocTable[i]) = 0;
				p++;
			}
		}
	}
	if (data)
	{
		MEM::Free(data);
		Init();
	}
	return OK;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_ST::Resize(uint16 s)
{
	if (size == s)
		return OK;

	if (s > (size - totalFree))
	{
		if (TestConsistency())
			return ERR_ALLOC_INCONSISTENT;

		uint32 newRawSize = s*tSize;
		uint32 allocationSize = s + (s/2) + (s & 1) + (rawSize/2) + (rawSize & 1);

		uint32* newData = (uint32*)MEM::Alloc(allocationSize*sizeof(uint32), true);

		if (!newData)
			return ERR_NO_FREE_STORE;

		uint16***	newAllocTable = (uint16***)&newData[0];
		uint16*		newASizeData  = (uint16*)&newData[s];
		uint16*		newPool				= (uint16*)&newData[s + (s/2 + s&1)];

		rsint32 i = 0, j = 0;
		while (i <size)
		{
			if (allocTable[i])
			{
				newAllocTable[j]	= allocTable[i];
				newASizeData[j]		= lengthTable[i];
				MEM::Copy(&newPool[j*tSize], &pool[i*tSize], lengthTable[i]*tSize*2);
				j += lengthTable[i];
			}
			i += lengthTable[i];
		}

		MEM::Free(data);
		data				= newData;
		lengthTable	= newASizeData;
		pool				= newPool;
		allocTable	= newAllocTable;

		totalFree += (s - size);
		size			= s;
		rawSize		= newRawSize;
		nextFree	= size - totalFree;
		return OK;
	}
	return ERR_RESIZE_TO_SMALL;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_ST::Defrag()
{
	if (TestConsistency())
		return ERR_ALLOC_INCONSISTENT;

	sint32 c = nextFree;
	sint32 s = c+lengthTable[c];
	while (s < size)
	{
		rsint32 sizeBuff = lengthTable[s];
		if (allocTable[s])
		{
			lengthTable[c]  = sizeBuff;
			allocTable[c] = allocTable[s];
			lengthTable[s]  = 0;
			allocTable[s] = 0;
			*(allocTable[c]) = &pool[c*tSize];

			if (s-c > sizeBuff)
				MEM::Copy(&pool[c*tSize], &pool[s*tSize], sizeBuff*tSize*2);
			else
			{
				rsint32 t = 0, max = s-c;
				while (t < sizeBuff)
				{
					MEM::Copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], max*tSize*2);
					if (t + max > sizeBuff)
					{
						max = sizeBuff-t;
						t += max;
						MEM::Copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], max*tSize*2);
					}
					t += max;
				}
			}
			c += sizeBuff;
		}
		s += sizeBuff;
	}
	nextFree = c;
	lengthTable[nextFree] = totalFree;
	return OK;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_ST::NewT(void* vt)
{
	ruint16** t = (uint16**)vt;
	if (*(t) != 0)
		return ERR_PTR_USED;
	if (totalFree)
	{
		uint32 sizeBuff = lengthTable[nextFree];
		allocTable[nextFree] = t;
		lengthTable[nextFree] = 1;
		*(t) = &pool[nextFree*tSize];
		totalFree--;
		if (totalFree)
		{
			if (--sizeBuff)
			{
				lengthTable[++nextFree] = sizeBuff;
				return OK;
			}
			rsint32 i = nextFree+1;
			while ((i < size) && allocTable[i])
				i += lengthTable[i];
			nextFree = i;
			return OK;
		}
		nextFree = -1;
		return WRN_RSC_EXHAUSTED;
	}
	return ERR_RSC_EXHAUSTED;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_ST::NewT(void* vt, uint16 s)
{
	ruint16** t = (uint16**)vt;
	if (*(t) != 0)
		return ERR_PTR_USED;
	if (totalFree < s)
		return ERR_NEW_ALLOC_TO_BIG;
	rsint32 i = nextFree, found = -1;
	while ((i < size) && (found < 0))
	{
		if (allocTable[i] == 0 && lengthTable[i] >= s)
			found = i;
		else
			i += lengthTable[i];
	}
	if (found < 0)
	{
		if (Defrag())
			return ERR_ALLOC_INCONSISTENT;
		found = nextFree;
	}
	uint32 sizeBuff = lengthTable[found];
	if (s < sizeBuff)
	{
		lengthTable[found] = s;
		lengthTable[found+s] = sizeBuff - s;
	}
	allocTable[found] = t;
	*(t) = &pool[found*tSize];
	totalFree -= s;
	if (totalFree)
	{
		if (nextFree == found)
		{
			i = found+s;
			while ((i < size) && allocTable[i])
				i += lengthTable[i];
			nextFree = i;
		}
		return OK;
	}
	nextFree = -1;
	return WRN_RSC_EXHAUSTED;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 POOL_ST::FreeT(void* vt)
{
	ruint16** t = (uint16**)vt;
	if (*(t) == 0)
		return ERR_PTR_ZERO;
	if (!IsInPool(*(t)))
		return ERR_PTR_RANGE;
	rsint32 found = -1;
	{
		ruint32 p = (uint32)(*(t) - pool);
		#ifdef STRICT
		if (p%tSize)
			return ERR_PTR_INCONSISTENT;
		#endif
		found = p/tSize;
		if (!allocTable[found])
			return ERR_PTR_INCONSISTENT;
	}
	sint32 result = OK;
	#ifdef STRICT
	if (t != allocTable[found])
		result = WRN_PTR_NOT_UNIQUE;
	#endif
	*(t) = 0;
	allocTable[found] = 0;
	ruint32 sizeBuff = lengthTable[found];
	totalFree += sizeBuff;
	if (found + sizeBuff < size)
	{
		uint32 next = found + sizeBuff;
		if (allocTable[next] == 0)
		{
			sizeBuff += lengthTable[next];
			lengthTable[next] = 0;
			lengthTable[found] = sizeBuff;
		}
	}
	if (found == 0 || found < nextFree || nextFree == -1)
	{
		nextFree = found;
		return result;
	}
	{
		rsint32 prev = -1;
		rsint32 i = nextFree;
		while (i < found)
		{
			if (allocTable[i]==0)
				prev = i;
			else
				prev = -1;
			i += lengthTable[i];
		}
		if (prev >= 0)
		{
			lengthTable[prev] += sizeBuff;
			lengthTable[found] = 0;
		}
	}
	return result;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

