//****************************************************************************//
//**                                                                        **//
//**  File:          JasmineObject.hpp ($NAME=JasmineObject.hpp)            **//
//**                                                                        **//
//**  Description:   JASMINE Object Code class                              **//
//**  Comment(s):    JASMINE code is encapsulated as portable XSF data      **//
//**                                                                        **//
//**  First Started: 2002-08-04                                             **//
//**  Last Updated:  2002-08-12                                             **//
//**                                                                        **//
//**  Author(s):     Karl Churchill, Serkan YAZICI                          **//
//**                                                                        **//
//**  Copyright:     (C)1998-2002, eXtropia Studios                         **//
//**                 Serkan YAZICI, Karl Churchill                          **//
//**                 All Rights Reserved.                                   **//
//**                                                                        **//
//****************************************************************************//

#ifndef _JASMINE_OBJECT_HPP
#define _JASMINE_OBJECT_HPP

#include <xBase.hpp>

#include "JasmineCode.hpp"

#include <xSystem/IOLib.hpp>
#include <XSF/XSF.hpp>

// See DesignSpecs.txt for discussion
/////////////////////////////////////////////////////////////////////////////////////
//
//  OPCODE FORMAT
//
//  Commands are built using 32-bit words. The first word consists of an opcode byte
//  followed by up to three operand effective address bytes.
//  Each operand effective address may require an extension word
//  Finally, any data words specific to the command (for example, a branch offset)
//  follow.
//
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ]  instruction word
//  [ possible ea 1 extension word    ]  data words
//  [ possible ea 2 extension word    ]
//  [ possible ea 3 extension word    ]
//  [ possible opcode data word #1    ]
//  [            ..etc..              ]
//
//  Notes
//
//  In reality, most commands should require no more than two or three words in
//  their entirety. Also, literal data is not valid as a destination.
//
//  The instruction word uses byte data as opposed to bitfields to simplify
//  decode.
//
/////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////
//
//  JFINFO
//
//  Describes a function within a JASMINEOBJECT. JASMINEOBJECT objects keep all VM
//  code in one block. Functions are expressed as offsets from a base code address.
//  The JASMINEOBJECT embeds a table of JFINFO function definitions. In addition to
//  the function offset identity and access information is included.
//
/////////////////////////////////////////////////////////////////////////////////////

class JFINFO {
  friend class JASMINEOBJECT;
  private:
    uint32    offset;           // offset from the code base pointer
    uint32    access;           // access information (see below)
    XDATAID   nameKey;          // key generated from the original function name
    XDATAID   signKey;          // key generated from the original function signature
  public:
    enum {
      // access information
      F_FUNC        = 0x00000001, // just your basic function (not oop)
      F_MAIN        = 0x00000002, // program entry point (only one per object)
      F_PRIVATE     = 0x00000010, // basic access level
      F_PROTECTED   = 0x00000020, // " " " " " "
      F_PUBLIC      = 0x00000040, // " " " " " "
      F_CTOR        = 0x00000100, // default constructor
      F_COPY        = 0x00000200, // copy constructor
      F_DTOR        = 0x00000400, // destructor
      F_MEMBER      = 0x00010000, // normal member function
      F_VIRTUAL     = 0x00020000, // polymorphic member function
      F_STATIC      = 0x00040000, // class member function
      F_FIXED       = 0x00080000, // cannot be overriden
      F_SYNC        = 0x00100000, // syncrhonized call
      F_NATIVE      = 0x00200000  // native function
    };
    void Define(const char* name, const char* sig, uint32 acc, uint32 ofs)
    {
      offset = ofs;
      access = acc;
      nameKey = name;
      signKey = sig;
    }

  public:
    JFINFO() {}
    ~JFINFO() {}
};


/////////////////////////////////////////////////////////////////////////////////////
//
//  JASMINEOBJECT
//
/////////////////////////////////////////////////////////////////////////////////////

class JASMINEOBJECT : public XSFOBJ {
  friend class JASMINEFACTORY;
  private:
    // this data portion is xsf persistent. Putting it into a structure allows
    // easier XSF RawSize evaluation
    struct SHARED32 {
      uint32  funcTabLen;   // function table size
      uint32  codeLen;      // total code size in instruction words
      uint32  data64Len;    // total 64-bit r/w data (in bytes)
      uint32  data32Len;    // total 32-bit r/w data (in bytes)
      uint32  data16Len;    // total 16-bit r/w data (in bytes)
      uint32  data8Len;     // total 8-bit r/w data (in bytes)
      uint32  const64Len;   // total 64-bit constant data (in bytes)
      uint32  const32Len;   // total 32-bit constant data (in bytes)
      uint32  const16Len;   // total 16-bit constant data (in bytes)
      uint32  const8Len;    // total 8-bit constant data (in bytes)
      uint32  stackSize;    // requested VM stack size (in bytes)
      uint32  methodSize;   // requested VM return stack size (in calls)
      uint32  regSize;      // requested VM register stack size (in units)
      uint32  checksum;

      SHARED32() : funcTabLen(0), codeLen(0), data64Len(0), data32Len(0), data16Len(0), data8Len(0), const64Len(0),
      const32Len(0), const16Len(0), const8Len(0), stackSize(0), methodSize(0), regSize(0), checksum(0xBABECAFE) {}
    } shared32;

    struct SHARED16 {
      sint16  progVersion;
      sint16  progRevision;

      SHARED16() : progVersion(0), progRevision(0) {}
    } shared16;

    struct SHARED8 {
      char progName[32];
      SHARED8() { memset(progName,0,32); }
    } shared8;

    JFINFO*   funcTab;
    uint32*   code;
    uint64*   wrtblData;
    uint64*   constData;
    static const char* XSFIDString;

  protected:
    void    Free();
    sint32  Alloc();

    sint32  WriteBody(XSFIO& f);
    sint32  ReadBody(XSFIO& f);

  public:
    static const char*  XSFFileSig;
    static const uint16 XSFSuperClass;
    static const uint16 XSFSubClass;
    static const uint8  XSFDataFormat;
    static const uint8  XSFFileFormat;

  public:
    uint32*     Code()          { return code; }
    void*       Data()          { return wrtblData; }
    void*       Cnst()          { return constData; }
    size_t      Stack()         { return shared32.stackSize; }
    size_t      MethodStack()   { return shared32.methodSize; }
    size_t      RegisterStack() { return shared32.regSize; }
    sint16      Version()       { return shared16.progVersion; }
    sint16      Revision()      { return shared16.progRevision; }
    const char* Name()          { return (const char*)shared8.progName; }
    uint32      FuncSize();
    uint32      CodeSize();
    uint32      DataSize();
    uint32      CnstSize();
    JFINFO*     Method(uint32 n);

    void        ListMethods();

    JASMINEOBJECT();
    ~JASMINEOBJECT();
};

/////////////////////////////////////////////////////////////////////////////////////

class JASMINEFACTORY {
  public:
    static JASMINEOBJECT* Create(char* n, sint16 v, sint16 r, size_t F, size_t I, size_t S, size_t MS, size_t RS, \
    size_t D64, size_t D32, size_t D16, size_t D8, size_t C64, size_t C32, size_t C16, size_t C8);
};

#endif
