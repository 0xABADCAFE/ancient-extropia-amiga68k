//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XSFVIRTUALMACHINE2_HPP
#define _XSFVIRTUALMACHINE2_HPP

#include <xBase.hpp>

#include "VMOpts.hpp"
#include "VMCode.hpp"
#include "VM_ObjectCode.hpp"

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
//
/////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////
//
//  VIRTUAL MACHINE CLASS
//
/////////////////////////////////////////////////////////////////////////////////////

class VMCORE {
  private:

    typedef void* (*EAFUNC)(REGP(2) VMCORE*, REGI(7) size_t);
    typedef void  (*OPFUNC)(REGP(2) VMCORE*, REGP(3) EAFUNC*);

    union GPR {
      private:
        union { uint8     u8[8];    sint8     s8[8];                                         };
        union { uint16    u16[4];   sint16    s16[4];                                      };
        union { uint32    u32[2];   sint32    s32[2];   float32 f32[2];                    };
        union { uint64    u64;      sint64    s64;      float64 f64;                       };
        union { uint8*    pu8[2];   uint16*   pu16[2];  uint32* pu32[2];  uint64* pu64[2]; };
        union { sint8*    ps8[2];   sint16*   ps16[2];  sint32* ps32[2];  sint64* ps64[2]; };
        union { float32*  pf32[2];  float64*  pf64[2];                                     };
        union { char*     pch[2];   wchar_t*  pwch[2]; };

      public:
      #if (X_ENDIAN == XA_BIGENDIAN)
        void*     Data8()         { return &u8[7];  }
        void*     Data16()        { return &u16[3]; }
        void*     Data32()        { return &u32[1]; }
        void*     Data64()        { return &u64; }
        void*     Data(uint32 s)  { return &u8[(8-s)]; }
        char*     &PtrCh()        { return pch[1];}
        uint8*    &PtrU8()        { return pu8[1]; }
        uint16*   &PtrU16()       { return pu16[1]; }
        uint32*   &PtrU32()       { return pu32[1]; }
        uint64*   &PtrU64()       { return pu64[1]; }
        sint8*    &PtrS8()        { return ps8[1]; }
        sint16*   &PtrS16()       { return ps16[1]; }
        sint32*   &PtrS32()       { return ps32[1]; }
        sint64*   &PtrS64()       { return ps64[1]; }
        float32*  &PtrF32()       { return pf32[1];}
        float64*  &PtrF64()       { return pf64[1];}
        uint8&    ValU8()         { return u8[7]; }
        uint16&   ValU16()        { return u16[3];}
        uint32&   ValU32()        { return u32[1]; }
        uint64&   ValU64()        { return u64; }
        sint8&    ValS8()         { return s8[7]; }
        sint16&   ValS16()        { return s16[3];}
        sint32&   ValS32()        { return s32[1]; }
        sint64&   ValS64()        { return s64; }
        float32&  ValF32()        { return f32[1]; }
        float64&  ValF64()        { return f64; }
      #else
        void*     Data8()         { return u8;  }
        void*     Data16()        { return u16; }
        void*     Data32()        { return u32; }
        void*     Data64()        { return &u64; }
        void*     Data(uint32 s)  { return &u64; }
        char*     &PtrCh()        { return pch[0];}
        uint8*    &PtrU8()        { return pu8[0]; }
        uint16*   &PtrU16()       { return pu16[0]; }
        uint32*   &PtrU32()       { return pu32[0]; }
        uint64*   &PtrU64()       { return pu64[0]; }
        sint8*    &PtrS8()        { return ps8[0]; }
        sint16*   &PtrS16()       { return ps16[0]; }
        sint32*   &PtrS32()       { return ps32[0]; }
        sint64*   &PtrS64()       { return ps64[0]; }
        float32*  &PtrF32()       { return pf32[0];}
        float64*  &PtrF64()       { return pf64[0];}
        uint8&    ValU8()         { return u8[0]; }
        uint16&   ValU16()        { return u16[0];}
        uint32&   ValU32()        { return u32[0]; }
        uint64&   ValU64()        { return u64; }
        sint8&    ValS8()         { return s8[0]; }
        sint16&   ValS16()        { return s16[0];}
        sint32&   ValS32()        { return s32[0]; }
        sint64&   ValS64()        { return s64; }
        float32&  ValF32()        { return f32[0]; }
        float64&  ValF64()        { return f64; }
      #endif
    } gpRegs[32];

    union {
      uint8* u8;      uint16* u16;      uint32* u32;      uint64* u64;
      sint8* s8;      sint16* s16;      sint32* s32;      sint64* s64;
      float32* f32;   float64* f64;     char*   ch;       wchar_t* wch;
      void*   any;
    } op[3];

    uint32*   instPtr;
    void*     dataSectPtr;
    void*     constSectPtr;
    uint32**  branchStack;
    uint8*    stack;
    uint32    exitReg;
    sint32    countReg;

    uint32**  branchStackBase;
    uint8*    stackBase;

    static OPFUNC instTable[VM::NUM_OPS];
    static EAFUNC eaTable[VM::NUM_EA];

    #include "VMFuncs.hpp"

  private:
    uint32  Execute();

  public:
    uint32  Execute(VMOBJ& prog);

    VMCORE();
    ~VMCORE();
};



/////////////////////////////////////////////////////////////////////////////////////

#endif
