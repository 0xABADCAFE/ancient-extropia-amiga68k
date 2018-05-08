//****************************************************************************//
//** File:         xDefs.hpp ($NAME=xDefs.hpp)                              **//
//** Description:  Common and System-Dependent Definitions                  **//
//** Comment(s):   This file is top-most in the library hierarcy            **//
//** Library:      Base                                                     **//
//** Created:      2000-09-24                                               **//
//** Updated:      2001-02-25                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):      1) Only one type of architecture, platform, and compiler **//
//**                  can be defined                                        **//
//**               2) If a new architecture/platform/compiler type is       **//
//**                  defined, the options related to the new type should   **//
//**                  be added by the first implementor                     **//
//** Copyright:    (C)1996-2001, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


/*----------------------------------------------------------------------------------------------------------------

     eXtropia/
     |
     +->include/ ...Set to standard include path !!
     |  +->xDefs.hpp
     |  +->xBase.hpp
     |  +-><name>/ ...Library stub headers
     |  +->Platforms/
     |    +->Amiga68K/
     |    |  +-><name>/ ...Amiga specific headers
     |    :
     |    (other archiectures)
     |
     +->lib/
        +->Common/
        |  +->xBase.cpp
        |  +-><name>/ ...Platform independent .cpp sources
        |
        +->Platforms/
           +->Amiga68K/
           |  +-><name>/ ...Amiga specific .cpp sources
           :
           (other architectures)

----------------------------------------------------------------------------------------------------------------*/


#ifndef __cplusplus
  #error "Error: eXtropia Library is for use with C++ only"
#endif  //__cplusplus//

#ifndef _xDEFS_HPP_INCLUDED
#define _xDEFS_HPP_INCLUDED

#ifndef __STORM__
#pragma once
#endif

//File Version ($VERSION=1.00)
#define xDEFS_HPP_VERSION     0x0100
//Release Ver. ($RELEASE=2)
#define xDEFS_HPP_RELEASE     0x0002


//// DEPENDENCY DEFINITIONS //////////////////////////////////////////////////


//~~~~~~~~ ARCHITECTURE: XA_xxx (Only 32-bit or above) ~~~~~~~~~

#if defined(__STORM__)    // lazy or what ?
  #if defined(__PPC__)
    #define XA_PPC        // Older 601/602/603/603e/604/604e
    //#define XA_PPC_G3+  // Super PowerPC architectures G3 and above..mmmmm G4-II :)
  #else
    #define XA_M680x0
  #endif
#else
  #define XA_I386
#endif

//~~~~~~~~~~~ PLATFORM: XP_xxx (Only 32-bit or above) ~~~~~~~~~~

#if defined(__STORM__)
  #define XP_AMIGAOS     //Classic Amiga 68K / PowerPC
  //#define XP_ELATE
#else
  #define XP_WIN32         //Win9x/NT
#endif // __STORM__

//~~~~~~~~~~~ COMPILER: XC_xxx (Only sexy compilers) ~~~~~~~~~~~

#if defined(__STORM__)
  #define XC_STORM // version I have isn't that sexy, mate :)
  #define XC_ALLOW_REF_ABSTRACT 1

#else
  #define XC_WATCOM
  #define XC_ALLOW_REF_ABSTRACT 0

#endif // __STORM__

//~~~~~~~~~~~~~~~~~~~~~~ ANSI CPP Version ~~~~~~~~~~~~~~~~~~~~~~
//  (Based on compliance with Stroustrup's Language Ref Edition)
#define X_ANSI_CPPVER     2


//~~~~~~~~~~~~~~~~~~~~~~ LANGUAGE OPTIONS ~~~~~~~~~~~~~~~~~~~~~~
//#define X_VERBOSE       //Verbose Output
#define X_DEBUG           //Enable Debug
#define X_HAND_OPTIMISED  //For complex code fragments. Keep original and use this to enable the cryptic but fast version

#ifndef __STORM__
  #define X_SETALIGNMENT    //Structure Alignments will be set to fastest (overrides compiler)
#endif //__STORM__

//// ARCHITECTURE FLAGS //////////////////////////////////////////////////////
//
// Notes: 1) Appropriate flags are combined within X_HARDWARE
//        2) X_HARDWARE [BYTE]:
//           3bit [0-2]  Alignment (Fastest alignment of structures)
//           2bit [3,4]  Pointer Size
//           1bit [5]    Endian Type
//           1bit [6]    Negative Number format
//           1bit [7]    Reserved (0)
//

#define XA_ALIGNMASK            0x07  //Alignment Mask
#define XA_ALIGN8               0x00  //Byte Alignment
#define XA_ALIGN16              0x01  //Word Alignment
#define XA_ALIGN32              0x02  //DWord Alignment
#define XA_ALIGN64              0x03  //QWord Alignment
#define XA_ALIGN128             0x04  //128-Bit Alignment
#define XA_ALIGN256             0x05  //256-Bit Alignment
#define XA_ALIGN512             0x06  //512-Bit Alignment
#define XA_ALIGN1K              0x07  //1K-Bit Alignment

#define XA_PTRMASK              0x18  //Pointer Size Mask
#define XA_PTR32                0x00  //32-Bit Pointers
#define XA_PTR64                0x08  //64-Bit Pointers
#define XA_PTR96                0x10  //96-Bit Pointers.....Karl : Yeah man! Like stuff these 2^n obsessed freaks :)
#define XA_PTR128               0x18  //128-Bit Pointers

#define XA_ENDIANMASK           0x20  //Endian Type Mask
#define XA_BIGENDIAN            0x00  //0 = Motorola (more common)
#define XA_LITTLEENDIAN         0x20  //1 = Intel (most popular :)

#define XA_NEGATIVEMASK         0x40  //Negative Format Mask
#define XA_TWOSCOMP             0x00  //0 = 2's compliment (more common)
#define XA_ONESCOMP             0x40  //1 = 1's compliment (very rare)...Karl : can't actually think of any outside of DSP's...


//// ARCHITECTURE OPTIONS ////////////////////////////////////////////////////

#if defined(XA_M680x0)
  #define X_ARCHITECTURE        "Motorola 680x0"
  #define X_ALIGNMENT           XA_ALIGN32
  #define X_PTRSIZE             XA_PTR32
  #define X_ENDIAN              XA_BIGENDIAN
  #define X_NEGATIVE            XA_TWOSCOMP
  #define X_FPU_IEEE754

  typedef unsigned char         uint8;
  typedef unsigned short        uint16;
  typedef unsigned long         uint32;
  typedef unsigned long long    uint64;
  typedef signed char           sint8;
  typedef signed short          sint16;
  typedef signed long           sint32;
  typedef signed long long      sint64;       // Karl : Careful - long long support not complete
  typedef short                 bool;         // to be compatible with Exec/types.h BOOL
  typedef float                 float32;
  typedef double                float64;
  typedef float                 floatF;
  enum { false = 0, true = 1 };

#elif defined(XA_PPC)
  #define X_ARCHITECTURE        "PowerPC"
  #define X_ALIGNMENT           XA_ALIGN64
  #define X_PTRSIZE             XA_PTR32
  #define X_ENDIAN              XA_BIGENDIAN  // Karl : Technically true, but supports little endian without much fuss
  #define X_NEGATIVE            XA_TWOSCOMP
  #define X_FPU_IEEE754
  //Basic Types//
  typedef unsigned char         uint8;
  typedef unsigned short        uint16;
  typedef unsigned long         uint32;
  typedef unsigned long long    uint64;
  typedef signed char           sint8;
  typedef signed short          sint16;
  typedef signed long           sint32;
  typedef signed long long      sint64;       // Karl : Careful - support not complete
  typedef unsigned short        bool;         // to be compatible with Exec/types.h BOOL
  typedef float                 float32;      // Karl : OK is IEEE-754 standard 32-bit
  typedef double                float64;      // Karl : OK is IEEE-754 standard 64-bit
  typedef double                floatF;       // float for 60x, double for G3 / G4 AFAIK
  enum { false = 0, true = 1 };

#elif defined(XA_I386)
  #define X_ARCHITECTURE        "80x86 32Bit"
  #define X_ALIGNMENT           XA_ALIGN64
  #define X_PTRSIZE             XA_PTR32
  #define X_ENDIAN              XA_LITTLEENDIAN
  #define X_NEGATIVE            XA_TWOSCOMP
  #define X_FPU_IEEE754

  //Basic Types//
  typedef unsigned char         uint8;
  typedef unsigned short        uint16;
  typedef unsigned long         uint32;
  typedef unsigned __int64      uint64;
  typedef signed char           sint8;
  typedef signed short          sint16;
  typedef signed long           sint32;
  typedef signed __int64        sint64;
  typedef unsigned char         bool;
  typedef float                 float32;
  typedef double                float64;
  typedef double                floatF;        //Fast Float
  enum { false = 0, true = 1 };

#else
  #error "Error: Machine Architecture Not Defined"
#endif  //Architecture Options//


//// PLATFORM OPTIONS ////////////////////////////////////////////////////////


#if defined(XP_AMIGAOS)
  #define X_PLATFORM           "AmigaOS"
#elif defined(XP_WIN32)
  #define X_PLATFORM           "Win32s/Win9x/NT"
#else
  #error "Error: OS Platform Not Defined"
#endif  //Platform Options//


//// COMPILER OPTIONS ////////////////////////////////////////////////////////


#if defined(XC_STORM)
  #define X_COMPILER           "Storm C/C++"
#elif defined(XC_WATCOM)
  #define X_COMPILER           "Watcom C/C++"
#else
  #error "Error: Compiler Type Not Defined"
#endif  //Compiler Options//


//// OTHER OPTIONS & DEFINES /////////////////////////////////////////////////

#ifndef NULL
  #define NULL            0
#endif  //NULL//

#define X_HARDWARE        (X_ALIGNMENT|X_PTRSIZE|X_ENDIAN|X_NEGATIVE)

// Sets the alignment of structures based on fastest machine alignment
// setting. Note that this will override the compiler setting for the
// alignments, if you dont want this comment out the "#define X_SETALIGNMENT"
// statement in the LANGUAGE OPTIONS (above)

#ifdef X_SETALIGNMENT
  #if   (X_ALIGNMENT == XA_ALIGN8)
    #pragma pack(1)
  #elif (X_ALIGNMENT == XA_ALIGN16)
    #pragma pack(2)
  #elif (X_ALIGNMENT == XA_ALIGN32)
    #pragma pack(4)
  #elif (X_ALIGNMENT == XA_ALIGN64)
    #pragma pack(8)
  #else
    #pragma pack(16)
  #endif //X_ALIGNMENT//
#endif   //X_SETALIGNMENT//


// Register(ed:) types, especially useful for shortening argument lists
#define ruint8     register uint8
#define ruint16    register uint16
#define ruint32    register uint32
#define ruint64    register uint64
#define rsint8     register sint8
#define rsint16    register sint16
#define rsint32    register sint32
#define rsint64    register sint64
#define rbool      register bool
#define rfloat32   register float32
#define rfloat64   register float64
#define rfloatF    register floatF
#define rsize_t    register size_t

#endif  //_xDEFS_HPP_INCLUDED//

