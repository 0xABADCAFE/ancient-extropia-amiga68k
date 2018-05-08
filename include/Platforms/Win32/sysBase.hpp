//****************************************************************************//
//** File:         sysBase.hpp ($NAME=sysBase.hpp)                          **//
//** Description:  eXtropia Library Base API for Win32s                     **//
//** Comment(s):   This file is included in Win32 systems                   **//
//** Library:      Base                                                     **//
//** Created:      2001-02-20                                               **//
//** Updated:      2001-02-26                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2001, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


#ifndef _sysBASE_HPP_INCLUDED
#define _sysBASE_HPP_INCLUDED
#pragma once

#include <process.h> // for the sysBASELIB::RunAsyncProgram() method

#ifndef XP_WIN32
  #error "Error: This file is for use with Win32 systems only"
#endif  //XP_WIN32//

//// DODGY ALIGNMENT MACROS //////////////////////////////////////////////////

// I have defined these so that they have the same base behaviour as the
// amiga versions, but they dont do any alignment modification, since you
// dont need nor want it. One possible difference is in that these versions
// probably call the constructor. The amiga verions dont. They exist only to
// ensure code ported from AmigaOS => Win32 that uses them still compiles

#define XSL_AlignObject32(T, name) T name;
#define XSL_AlignObject64(T, name) T name;
#define XSL_AlignBlock32(T, name, num) T name[num];
#define XSL_AlignBlock64(T, name, num) T name[num];

//// OTHER MACROS ////////////////////////////////////////////////////////////

#define XSL_FILE_VIEWER_APP "Explorer" // Karl : I have no idea....

// Precise register definitions here

// Pointer
#define REGP(x) register
// Integer
#define REGI(x) register
// Float
#define REGF(x) register

//// GLOBAL VARIABLES ////////////////////////////////////////////////////////


//// GLOBAL VARIABLES ////////////////////////////////////////////////////////


//// FUNCTION PROTOTYPES /////////////////////////////////////////////////////


//// CLASSES /////////////////////////////////////////////////////////////////


//-- Memory Wrapper
class MEM {
	public:
		static void *Set(void*dst,int c,RSIZET len)     { return memset(dst,c,len); }
		static void *Zero(void*dst,RSIZET len)          { return memset(dst,0,len); }
		static void *Copy(void*dst,void*src,RSIZET len) { return memcpy(dst,src,len); }
		static void *Move(void*dst,void*src,RSIZET len) { return memmove(dst,src,len); }
		static void	*Alloc(rsize_t len, rbool zero=TRUE){ void* p = malloc(len); if (p && zero) Zero(p,len); return p; }
		static void	Free(void* mem)											{ if (mem) free(mem); }
	
		// block endian conversion
		static void Swap16(ruint16* s, ruint16* d, rsize_t n);
		static void Swap32(ruint32* s, ruint32* d, rsize_t n);
		static void Swap64(ruint64* s, ruint64* d, rsize_t n);
		
		static void DebugInfo() {}
};


//-- System Base Library
class sysBASELIB {
	public:
		static sint32	Init();                    //Returns NONZERO on Error
		static sint32	Done();
		static void		RunAsyncProgram(char* name) {execl(name,"",0);}
		static void		OpenDebugFile(char *name);
};

inline void sysBASELIB::OpenDebugFile(char *name)
{
  char cmdLine[300];
  sprintf(cmdLine,"\"%s %s\" ", XSL_FILE_VIEWER_APP, name);
  RunAsyncProgram(cmdLine);
}


//// INLINE FUNCTIONS ////////////////////////////////////////////////////////

// The following emulates new/delete through MEM:: class
/*
inline void* operator new(size_t s, void* p)
{
	return p;
}
*/
template<class T, class U> inline T* New(T*, U n)
{	// class U should be a numeric type
	void* temp = MEM::Alloc((2*sizeof(uint32) + n*sizeof(T)), TRUE);	// allocate enough room for n T objects + 2 uint32 values, zero the memory
	if (temp)
	{
		{
			uint32* sData = (uint32*)temp;
			sData[0] = n;											// no of elements
			sData[1] = sizeof(T);							// individual size
		}
		T*	oData = (T*)((uint32)temp + 2*sizeof(uint32));
		{		
			for (ruint32 i=0; i < n; i++)
				T* d = new(&oData[i]) T; 				// individually construct each object at the desired address
		}
		return oData; 											// note that the return address is actually temp + 2*sizeof(uint32)
	}
	else
		return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

template<class T> inline void Delete(T* p)
{
	if (p)
	{	// get sData (8 bytes before the first T object)
		uint32* sData = (uint32*)((uint32)p-(2*sizeof(uint32)));
		for(uint32 i = 0; i<sData[0]; i++)
			delete (&p[i]);									// individually destroy each object at the computed address
		MEM::Free(sData);
	}
}

#endif  //_sysBASE_HPP_INCLUDED//

