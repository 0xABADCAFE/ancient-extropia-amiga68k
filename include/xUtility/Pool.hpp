//****************************************************************************//
//** File:         Pool.hpp ($NAME=Pool.hpp)                                **//
//** Description:  Fast allocator template for C legacy objects             **//
//** Comment(s):   This file is included in all systems                     **//
//** Library:      xUtility                                                 **//
//** Created:      2001-01-20                                               **//
//** Updated:      2001-07-05                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#ifndef _XUTILITY_POOLS_HPP
#define _XUTILITY_POOLS_HPP

#include <xBase.hpp>

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  OBJECT POOL CLASSES
//
//  Designed for handling blocks of structures etc. Allocations from pooled resources are extremely fast since in
//  reality only a pointer to an existing object is returned. The primary disadvantage is that object storage is treat
//  by the class as raw, no individual object construction is performed. The space is initialised with all bits zero.
//
//  THESE CLASSES ARE CONSIDERED LOW LEVEL 'STRUCTURE' CONTAINER TYPES AND ARE PRIMARILY DESIGNED FOR SPEED
//
//
//      xPOOL_L<T>      xPOOL_S<T>  User level, template ensures type safe handling
//          |               |
//     .....|...............|.....  Implementation level
//          |               |
//       POOL_LT         POOL_ST		protected construction
//          |               |
//          +-------+-------+
//                  |
//              POOL_BASE						protected construction
//
//  NOTE : the template adds type checking only. It does not invoke construction etc, it merely adds the interface
//
//  Memory is handled by MEM:: class directly. This has the advantage of speed, but lacks locking semantics for multiple
//  access. Rebuild on xMEM, or add xLOCKABLE ?
//
//  A better design for multiple access would actually allow the individual locking of each allocation.
//
//  BUGS :
//
//  Allocating all the objects in a pool causes a memory leak on freeing the pool. Until I fix this, remember to only use
//  n-1 maximum allocations.
//
//  Im pretty sure this is related to setting nextFree to -1 to indicate exhaustion. A flag system might be better.
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//#define STRICT // enable some stricter checking at expense of performance

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Base class for common pool features
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class POOL_BASE {
	protected:
		uint32*			data;					// actual pool data
		uint32 			size;					// size of pool (number of T)
		uint32			rawSize;			// size of pool in 16-bit words
		uint32			tSize;				// size of element T, in bytes
		sint32 			nextFree;			// position of next unused T in pool
		sint32			totalFree;		// remaining free T in pool
		uint16***		allocTable;		// pointer to allocation address table (pointer-tastic man !)
		uint16*			pool;					// pointer to pool

	protected:
		// only to be used by derived class
		void		BaseInit();
	#ifdef X_VERBOSE
		void		BasePrint(ostream& out);
	#endif
		sint32	IsInPool(void* t) 				{ return (((uint16*)t >= pool) && ((uint16*)t < &pool[rawSize-1])); }
		POOL_BASE() : data(0), allocTable(0), pool(0), size(0), tSize(0), totalFree(0), nextFree(-1) { }

	public:

		enum {
			ERR_NEW_ALLOC_TO_BIG 		= RPERR(USER,6),	// Attempt to allocate array failed because of insufficent free entries
			ERR_RESIZE_TO_SMALL  		= RPERR(USER,5),	// Attempted to make pool smaller than current number of allocations
			ERR_ALLOC_INCONSISTENT	= RPERR(USER,4),	// External pointers are inconsistant with allocTable
			ERR_ALLOC_CORRUPT				= RPERR(USER,3),	// these are well serious total and utter chicken soup errors
			ERR_POOL_CORRUPT				= RPERR(USER,2),	// meaning that the whole pool is irretrievably screwed up
			ERR_POOL_FRAGMENTED 		= RPERR(USER,1),	// just for new pool evaluation purposes
			ERR_POOL								= RPERR(USER,0)
		};
		sint32	Size()										{ return size; }
		sint32	Space()										{ return totalFree; }
		sint32	Next()										{ return nextFree; }
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// POOL_BASE inlines
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline void POOL_BASE::BaseInit()
{
	data				= 0;
	size				= 0;
	tSize				= 0;
	rawSize			= 0;
	nextFree		= -1;
	totalFree		= 0;
  allocTable	= 0;
	pool				= 0;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// LARGE BLOCK DATA MODEL, 2G entries max / 2G array size max / 64 bits per allocation table entry
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class POOL_LT : public POOL_BASE {
	private:
		uint32* lengthTable;
		void		Init() 														{ lengthTable = 0; BaseInit(); }
		uint32	ExamineBlock(uint32 location);
		sint32	TestConsistency(bool strict=0);
	public:
	#ifdef X_VERBOSE
		void		PrintAlloc(ostream& out, sint32 start=0, sint32 entries=32);
	#endif
		sint32	Delete(bool force=0, bool unallocate=0);
		sint32	Defrag();
		sint32	Resize(sint32 s);
	protected:
		// These are the performance critical methods that should be inlined
		sint32	Create(uint32 entries, uint32 typeSize);
		sint32	NewT(void* vt);							// vt still expected to be pointer to pointer to type !!!
		sint32	NewT(void* vt, sint32 s);		// eg NewT(&<pointer to element>)
		sint32	FreeT(void* vt);						//    FreeT(&<pointer to element>)
		POOL_LT() : lengthTable(0) { }
		POOL_LT(uint32 s, uint32 t);
		~POOL_LT();
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// SMALL BLOCK DATA MODEL, 64K entries max / 64K array size max / 48 bits per allocation table entry
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class POOL_ST : public POOL_BASE {
	private:
		uint16* lengthTable;
		void		Init() 														{ lengthTable = 0; BaseInit(); }
		uint32	ExamineBlock(uint32 location);
		sint32	TestConsistency(bool strict=0);
	public:
	#ifdef X_VERBOSE
		void		PrintAlloc(ostream& out, sint32 start=0, sint32 entries=32);
	#endif
		sint32	Delete(bool force=0, bool unallocate=0);
		sint32	Defrag();
		sint32	Resize(uint16 s);
	protected:
		sint32	Create(uint16 entries, uint32 typeSize);
		sint32	NewT(void* vt);
		sint32	NewT(void* vt, uint16 s);
		sint32	FreeT(void* vt);
		POOL_ST() : lengthTable(0) { }
		POOL_ST(uint16 s, uint32 t);
		~POOL_ST();
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xPOOL_S<T> / xPOOL_L<T> templates
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

template<class T> class xPOOL_S : public POOL_ST {

	public:
		sint32	Create(uint16 entries)		{ return POOL_ST::Create(entries, sizeof(T)); }
		sint32	New(T** t)								{ return POOL_ST::NewT((void*)t); }
		sint32	New(T** t, uint16 s)			{ return POOL_ST::NewT((void*)t,s); }
		sint32	Free(T** t)								{ return POOL_ST::FreeT((void*)t); }

		xPOOL_S()																							{}
		xPOOL_S(uint16 entries) : POOL_ST(entries, sizeof(T)) {}
		~xPOOL_S()																						{}
};

template<class T> class xPOOL_L : public POOL_LT {

	public:
		sint32	Create(uint32 entries)		{ return POOL_LT::Create(entries, sizeof(T)); }
		sint32	New(T** t)								{ return POOL_LT::NewT((void*)t); }
		sint32	New(T** t, sint32 s)			{ return POOL_LT::NewT((void*)t,s); }
		sint32	Free(T** t)								{ return POOL_LT::FreeT((void*)t); }

		xPOOL_L()																							{}
		xPOOL_L(uint32 entries) : POOL_LT(entries, sizeof(T)) {}
		~xPOOL_L()																						{}
};

#endif // _XUTILITY_POOLS_HPP