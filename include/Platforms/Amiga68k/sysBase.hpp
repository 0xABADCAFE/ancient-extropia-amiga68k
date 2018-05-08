//****************************************************************************//
//** File:         sysBase.hpp ($NAME=sysBase.hpp)                          **//
//** Description:  eXtropia Library Base API for Amiga68K                   **//
//** Comment(s):   This file is included in Amiga 680x0 systems             **//
//** Library:      Base                                                     **//
//** Created:      2001-02-20                                               **//
//** Updated:      2002-01-22                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


#ifndef _sysBASE_HPP_INCLUDED
#define _sysBASE_HPP_INCLUDED

extern "C" {
  #include <stdlib.h>
  #include <exec/exec.h>
  #include <proto/exec.h>           // OS realtime kernel
  #include <proto/intuition.h>      // OS windowing environment
  #include <proto/timer.h>          // Timer functions
  #include <proto/dos.h>            // IO
  #include <dos/dostags.h>          // Process
  #include <clib/alib_protos.h>     // amiga lib
  #include <pragma/powerpc_lib.h>   // For PowerPC support
}

//// STACK ALIGNMENT MACROS //////////////////////////////////////////////////

/*
  These macros align objects created on the stack. Intended mostly for OS
  includes that don't care about 32-bit+ alignment. No construction is
  performed, but the storage allocated is set all bits zero. The macros exist
  in the Win32 version also but have no effect other than to ensure the object
  is actually created

  xAlignObjectNN(T, name)

    Creates a zero-initialized object of type T, aligned to NN-bits and defines
  name as a reference to it.

  xAlignBlockNN(T, name, num)

    Creates an uninitialised array of type T, aligned to NN-bits and defines
  *name as as a pointer to the first element.
*/

#define xAlignObject32(T, name) char __a32##name[sizeof(T)+3];  \
        T &name = *( (T*)((uint32)(__a32##name+3)&~3) );

#define xAlignObject64(T, name) char __a64##name[sizeof(T)+7];  \
        T &name = *( (T*)((uint32)(__a32##name+7)&~7) );

#define xAlignBlock32(T,name,num) char __ba32##name[3+((num)*sizeof(T))]; \
        T *name = (T*)((uint32)(__ba32##name+3) & ~3);

#define xAlignBlock64(T,name,num) char __ba64##name[7+((num)*sizeof(T))]; \
        T *name = (T*)((uint32)(__ba64##name+7) & ~7);


//// OTHER MACROS ////////////////////////////////////////////////////////////

#define xFILE_VIEWER_APP "SYS:Utilities/Multiview"

// Precise 68K register definitions

// Pointer
#define REGP(x) register __a##x
// Integer
#define REGI(x) register __d##x
// Float
#define REGF(x) register __fp##x


//// GLOBAL VARIABLES ////////////////////////////////////////////////////////

#define INTUITIONBASE struct IntuitionBase
#define GFXBASE       struct GfxBase
#define LIBRARY       struct Library

extern ExecBase       *SysBase;
extern INTUITIONBASE  *IntuitionBase;

//// FUNCTION PROTOTYPES /////////////////////////////////////////////////////


//// CLASSES /////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// System Base Library
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define MESSAGEBUFFSIZE 4096

class sysBASELIB {
  private:
    static void*    sysData;
    static char*    msgbuff;
    static Task*    main;
  public:
    static char*    MsgBuf()  { return msgbuff; }
    static sint32   Init();
    static void     Done();
    static void     RunAsyncProgram(char* name) { system(name); }
    static void     OpenDebugFile(char *name);
    static sint32   MessageBox(char* title, char* opts, char* body,...);
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Memory Wrapper
//
//  Provides services for allocatring and releasing memory on the free store. Allocations are tracked internally, recording the
//  address, size and owning thread of each allocation. No thread arbitration is provided, but the inbuilt resource tracking can be
//  inherited to provide locking protected shared memory access (See xSystem/xMEM)
//
//  TO DO implement flags for cache options and improve support system for New() Delete() templates through flags
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define MAXALLOCS 512 // maximum number of allocations registered in class

class MEM {
  friend class sysBASELIB;
  protected:
    static struct MEMINFO {
      void*   real;     // the real address, needed if alignment specified
      void*   address;  // the address returned by the allocation mechanism
      Task*   owner;
      size_t  size;
    } *allocated;
    static sint32   totSize;
    static sint32   nextFree;
    static sint32   cnt;
    static sint32   maxAllocs;
    static void     FreeAll();

  public:
    typedef enum {
      ALIGN_DEFAULT = 0,
      ALIGN_16      = 2,
      ALIGN_32      = 4,
      ALIGN_64      = 8,
      ALIGN_CACHE   = 16,
      ALIGN_PAGE    = 4096,
    } ALIGNTYPE;

    static void*    Alloc(size_t len, bool zero=false, ALIGNTYPE align=ALIGN_DEFAULT);
    static void     Free(void* mem);

    // Memory functions optimized for maximum bandwith (see MEM.asm) Precise
    // register definitions required

    // Copy
    static void     Copy(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t len);
    static void     Move(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t len);
    // Byteswap
    static void     Swap16(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t n);
    static void     Swap32(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t n);
    static void     Swap64(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t n);
    // Clear
    static void     Zero(REGP(0) void* dst, REGI(0) size_t len);
    // Set
    static void     Set(REGP(0) void* dst, REGI(0) int c, REGI(1) size_t len);
    static void     Set16(REGP(0) void* dst, REGI(0) uint16 c, REGI(1) size_t n);
    static void     Set32(REGP(0) void* dst, REGI(0) uint32 c, REGI(1) size_t n);
    static void     Set64(REGP(0) void* dst, REGP(1) uint64& c, REGI(0) size_t n);

  #ifdef X_DEBUG
    static void     DebugInfo();
  #endif
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CPU Wrapper
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class CPU {
  public:
    typedef enum {
      FP_DEFAULT,
      FP_HIGH,
      FP_LOW
    } FPPREC;

    typedef enum {
      DEFAULT,
      USER,
      SUPERVISOR,
    } ACCESS;

  private:
    static FPPREC fpuPrecision;
    static char*  cpuNames[];

  public:
    static const char*  Name();

    // Cache options. CPU dependent if these have any effect
    static void         FlushDataCache(void* adr, uint32 l=0xFFFFFFFF) { CacheClearE(adr, l, CACRF_ClearD); }
    static void         FlushInstCache(void* adr, uint32 l=0xFFFFFFFF) { CacheClearE(adr, l, CACRF_ClearI); }
    static void         FlushAllCaches(void* adr, uint32 l=0xFFFFFFFF) { CacheClearE(adr, l, CACRF_ClearD|CACRF_ClearI); }

    // Set FPU options. CPU dependent if these have any effect
    static void         FPPrecision(FPPREC p);
    static FPPREC       FPPrecision() { return fpuPrecision; }

    // CPU pipeline synchronisation.
    static void         SynchronisePipeline();
};

//// INLINE FUNCTIONS ////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// New() / Delete() template functions //////////////////////////////////////////////////////////////////////////////////////////////

inline void* operator new(size_t s, void* p)
{
  return p;
}

template<class T, class U> inline T* New(T*, U n)
{ // class U should be a numeric type
  register void* ptr = MEM::Alloc((2*sizeof(size_t) + n*sizeof(T)));  // allocate enough room for n T objects + 2 uint32 values, zero the memory
  if (ptr)
  {
    ((size_t*)ptr)[0] = n;                // no of elements
    ((size_t*)ptr)[1] = sizeof(T);        // individual size
    T*  obj = (T*) (&((size_t*)ptr)[2]);
    {
      register T* o = obj;
      rsint32 i = n+1;
      while (--i)
        new(o++) T;         // individually construct each object at the desired address
    }
    return obj;             // note that the return address is actually temp + 2*sizeof(uint32)
  }
  else
    return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

template<class T> inline void Delete(T* ptr)
{
  if (ptr)
  { // get sData (8 bytes before the first T object)
    size_t* sizeInfo = (size_t*)((uint32)ptr-(2*sizeof(size_t)));
    rsint32 i = 1+sizeInfo[0];
    while(--i)
      delete (ptr++);                 // individually destroy each object at the computed address
    MEM::Free(sizeInfo);
  }
}

#endif  //_sysBASE_HPP_INCLUDED//

