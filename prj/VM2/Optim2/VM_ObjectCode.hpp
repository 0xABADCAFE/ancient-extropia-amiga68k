//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _VIRTUALMACHINE_2_OBJCODE_HPP
#define _VIRTUALMACHINE_2_OBJCODE_HPP

#include <xBase.hpp>

#include "VMOpts.hpp"
#include "VMCode.hpp"

#include <xSystem/xIO.hpp>
#include <XSF/XSF.hpp>

// See DesignSpecs.txt for discussion

/////////////////////////////////////////////////////////////////////////////////////
//
//  VIRTUAL MACHINE OBJECT CODE FORMAT
//
//  The Virtual machine code and static data is packaged within an XSF object.
//  The format layout is as follows
//
//  [ Standard XSF object Header ]
//
//  32-bit block
//    uint32 : code length          (in 32-bit words)
//    uint32 : 64-bit data length   (in bytes)
//    uint32 : 32-bit data length   (in bytes)
//    uint32 : 16-bit data length   (in bytes)
//    uint32 : 8-bit data length    (in bytes)
//    uint32 : 64-bit const length  (in bytes)
//    uint32 : 32-bit const length  (in bytes)
//    uint32 : 16-bit const length  (in bytes)
//    uint32 : 8-bit const length   (in bytes)
//    uint32 : checksum
//
//  64-bit block
//    mutable 64-bit data
//    constant 64-bit data
//
//  32-bit block
//    mutable 32-bit data
//    constant 32-bit data
//
//  16-bit block
//    mutable 16-bit data
//    [pad-32]
//    constant 16-bit data
//    [pad-32]
//
//  8-bit block
//    mutable 8-bit data
//    [pad-32]
//    constant 8-bit data
//    [pad-32]
//
//
/////////////////////////////////////////////////////////////////////////////////////

class VMOBJ : public XSFOBJ {

  private:
    // this data portion is xsf persistent. Putting it into a structure allows
    // easier XSF RawSize evaluation
    struct SHARED {
      uint32  codeLen;    // in instruction words
      uint32  data64Len;  // in bytes
      uint32  data32Len;  // in bytes
      uint32  data16Len;  // in bytes
      uint32  data8Len;   // in bytes
      uint32  const64Len; // in bytes
      uint32  const32Len; // in bytes
      uint32  const16Len; // in bytes
      uint32  const8Len;  // in bytes
      uint32  checksum;
      SHARED() : codeLen(0), data64Len(0), data32Len(0), data16Len(0), data8Len(0),
                 const64Len(0), const32Len(0), const16Len(0), const8Len(0), checksum(0x0BADCAFE) {}
    } shared;

    uint32* code;
    uint64* wrtblData;
    uint64* constData;
    static const char* XSFIDString;

    void    Free();
    sint32  Alloc();

  protected:
    sint32  WriteBody(XSFIO& f);
    sint32  ReadBody(XSFIO& f);

  public:
    uint32* Code()  { return code; }
    void*   Data()  { return wrtblData; }
    void*   Cnst()  { return constData; }

    sint32  Create(size_t I, size_t D64, size_t D32, size_t D16, size_t D8, size_t C64, size_t C32, size_t C16, size_t C8);

    VMOBJ();
    ~VMOBJ();
};

/////////////////////////////////////////////////////////////////////////////////////

#endif
