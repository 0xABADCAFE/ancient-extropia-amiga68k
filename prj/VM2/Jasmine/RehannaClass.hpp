//****************************************************************************//
//**                                                                        **//
//**  File:          JasmineJIT68K.hpp ($NAME=JasmineJIT68K.hpp)            **//
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

#ifndef _JASMINE_JIT68K_HPP
#define _JASMINE_JIT68K_HPP

#include "Jasmine.hpp"

/////////////////////////////////////////////////////////////////////////////////////

class CODE68020 {

  protected:
    enum {
      // mode field           // Old syntax       New syntax    Notes
      _D_DIR        = 0x0000, // dn               dn            n=0...7
      _A_DIR        = 0x0008, // an               an            n=0...7
      _A_IND        = 0x0010, // (an)             (an)          n=0...7
      _A_INDPSTINC  = 0x0018, // (an)+            (an)+         n=0...7, incr. by operand size
      _A_INDPREDEC  = 0x0020, // -(an)            -(an)         n=0...7, decr. by operand size
      _A_INDDISP    = 0x0028, // d16(an)          (d16,an)      n=0...7, d=-32768...32767
      _A_INDINDEX   = 0x0030, // d8(an,xn*s)      (d8,an,xn*s)  n=0...7, d=-128...127, x=a/d, s=1,2,4,8 *
      _PC_DISP      = 0x003A, // d16(pc)          (d16,pc)      d=-32768...32767
      _PC_INDEX     = 0x003B, // d8(pc,xn*s)      (d8,pc,xn*s)  d=-128...127, x=a/d, s=1,2,4,8 *
      _IMMEDIATE    = 0x003C, // #data
                              // * scale factor used on 68020+ only, ignored on 68000/68010
      _EAMODE       = 0x0038
    };

  // integer unit
    enum { // types
      _BYTE     = 0x0000, _WORD     = 0x0040, _LONG     = 0x0080,
    };

    enum { // direct register/immediate field
      // base register field
      _r0 = 0x0000, _r1 = 0x0001, _r2 = 0x0002, _r3 = 0x0003,
      _r4 = 0x0004, _r5 = 0x0005, _r6 = 0x0006, _r7 = 0x0007,

      _01 = 0x0000, _02 = 0x0200, _03 = 0x0400, _04 = 0x0600,
      _05 = 0x0800, _06 = 0x0A00, _07 = 0x0C00, _08 = 0x0E00,
      _D0 = 0x0000, _D1 = 0x0200, _D2 = 0x0400, _D3 = 0x0600,
      _D4 = 0x0800, _D5 = 0x0A00, _D6 = 0x0C00, _D7 = 0x0E00,
      _A0 = 0x0000, _A1 = 0x0200, _A2 = 0x0400, _A3 = 0x0600,
      _A4 = 0x0800, _A5 = 0x0A00, _A6 = 0x0C00, _A7 = 0x0E00,

      // brief extn word index registers
      _ID0_W = 0x0000, _ID1_W = 0x1000, _ID2_W = 0x2000, _ID3_W = 0x3000,
      _ID4_W = 0x4000, _ID5_W = 0x5000, _ID6_W = 0x6000, _ID7_W = 0x7000,
      _IA0_W = 0x8000, _IA1_W = 0x9000, _IA2_W = 0xA000, _IA3_W = 0xB000,
      _IA4_W = 0xC000, _IA5_W = 0xD000, _IA6_W = 0xE000, _IA7_W = 0xF000,
      _ID0_L = 0x0000, _ID1_L = 0x1000, _ID2_L = 0x2000, _ID3_L = 0x3000,
      _ID4_L = 0x4000, _ID5_L = 0x5000, _ID6_L = 0x6000, _ID7_L = 0x7000,
      _IA0_L = 0x8000, _IA1_L = 0x9000, _IA2_L = 0xA000, _IA3_L = 0xB000,
      _IA4_L = 0xC000, _IA5_L = 0xD000, _IA6_L = 0xE000, _IA7_L = 0xF000,
    };

    enum { // source or dest <ea>
      _EA_XX = 0x0000, _XX_EA = 0x0100
    };
    enum { // arithmetic/logic
      _NOP        = 0x4E71,
      _CLR        = 0x4200,
      _CMP        = 0xB000,
      _CMPA_WORD  = 0xB0C0,
      _CMPA_LONG  = 0xB1C0,
      _CMPM       = 0xB108, // cmpm.t (ay)+,(ax)+
      _CMPI       = 0x0C00,
      _ADD        = 0xD000,
      _ADDI       = 0x0600,
      _ADDQ       = 0x5000,
      _ADDA       = 0xD0C0,
      _ADDX_D     = 0xD100, // addx.t dy,dx
      _ADDX_M     = 0xD108, // addx.t -(ay),-(ax)
      _SUB        = 0x9000,
      _SUBI       = 0x0400,
      _SUBQ       = 0x5100,
      _SUBA       = 0x90C0,
      _SUBX_D     = 0x9100, // subx.t dy,dx
      _SUBX_M     = 0x9108, // subx.t -(ay),-(ax)

      _NEG        = 0x4400, // neg.t <ea>
      _NEGX       = 0x4000, // negx.t <ea>
      _DIVS       = 0x81C0, // divs <ea>,dn
      _DIVU       = 0x80C0, // divu <ea>,dn
      _MULS       = 0xC1C0, // muls <ea>,dn
      _MULU       = 0xC0C0, // mulu <ea>,dn

      _TST        = 0x4A00,

      _EXT_WORD   = 0x4880, // byte -> word
      _EXT_LONG   = 0x48C0, // word -> long
      _EXTB_LONG  = 0x41C0, // byte -> long

      _NOT        = 0x4600,
      _AND        = 0xC000,
      _ANDI       = 0x0200,
      _OR         = 0x8000,
      _ORI        = 0x0000,
      _EOR        = 0xB100,
      _EORI       = 0x0A00,
      _ASL_I      = 0xE000, // asl.t #data,dn [effective address = dn]
      _ASR_I      = 0xE100, // asr.t #data,dn
      _ASL_D      = 0xE020, // asl.t dx,dn
      _ASR_D      = 0xE120, // asr.t dx,dn
      _LSL_I      = 0xE008, // lsl.t #data,dn
      _LSR_I      = 0xE108, // lsr.t #data,dn
      _LSL_D      = 0xE028, // lsl.t dx,dn
      _LSR_D      = 0xE128, // lsr.t dx,dn
      _ROL_I      = 0xE018, // rol.t #data,dn
      _ROR_I      = 0xE118, // ror.t #data,dn
      _ROL_D      = 0xE038, // rol.t dx,dn
      _ROR_D      = 0xE138, // ror.t dx,dn
      _ROXL_I     = 0xE010, // roxl.t #data,dn
      _ROXR_I     = 0xE110, // roxr.t #data,dn
      _ROXL_D     = 0xE030, // roxl.t dx,dn
      _ROXR_D     = 0xE130, // roxr.t dx,dn

      // flow
      _BRA        = 0x6000,
      _BCC        = 0x6400,
      _BCS        = 0x6500,
      _BEQ        = 0x6700,
      _BGE        = 0x6C00,
      _BGT        = 0x6E00,
      _BHI        = 0x6200,
      _BLE        = 0x6F00,
      _BLS        = 0x6300,
      _BLT        = 0x6D00,
      _BMI        = 0x6B00,
      _BNE        = 0x6600,
      _BPL        = 0x6A00,
      _BVC        = 0x6800,
      _BVS        = 0x6900,
      _JMP        = 0x4EC0,
      _JSR        = 0x4E80,
      _RTS        = 0x4E75,

      _LEA        = 0x41C0,

      // data
      _SWAP       = 0x4840,
      _MOVE_BYTE  = 0x1000,
      _MOVE_WORD  = 0x3000,
      _MOVE_LONG  = 0x2000,
      _MOVEA_WORD = 0x3040,
      _MOVEA_LONG = 0x2040,
      _MOVEQ      = 0x7000, // LSB is #data
    };
};

/////////////////////////////////////////////////////////////////////////////////////

class CODE68882 {

  protected:
    enum {
      _FBYTE    = 0x0000, _FWORD    = 0x0000, _FLONG    = 0x0000,
      _FSINGLE  = 0x0000, _FDOUBLE  = 0x0000, _FEXTEND  = 0x0000
    };
};

/////////////////////////////////////////////////////////////////////////////////////
//
//  JASM68K
//
//    This class performs the basic JASMINE VM code to MC680x0 translation. This
//  is performed on a per function basis - an entire VM code function is translated.
//  The translation requires two passes.
//    The first pass converts VM opcodes into the equivalent 68K code, keeping record
//  of the respective VM/native code positions for each transcription performed.
//    On encountering VM branch instructions, the branch direction is examined.
//  Backward branches to already translated code can be resolved immediately by
//  scanning backwards through the current transcription record until the matching
//  target is found. These branches are then flagged as resovled in the record.
//  Forward branches cannot be resolved since the native target is not yet known.
//  These branches are marked as unresolved.
//    The first pass is normally terminated on encountering the last RET or END
//  opcode that can logically be reached having taken into account all branching.
//    The second pass scans through the record and identifies the targets of any
//  remaining unresolved branch targets.
//
//  FIXME :: add transcription end marker opcode ?
//
//    Transcription is performed by handler functions that mimic those in the JASMINE
//  interpreter. Instead of performing the required operation, these handlers emit
//  the 68K code required to achieve the same ends.
//    The code thus generated is not entirely stand-alone. It executes within an
//  environment not dissimilar to the asm optimised interpreter where various
//  machine registers are used for various critical variables. However, where the
//  interpreter may need up to 4 native function calls per opcode, the translated
//  code effectively maps into a single function for the entire block.
//
//    Special behaviour is required when a VM CALL opcode is encountered during
//  transcription. In this instance, a special function call is inserted with the VM
//  address as its arguement. The function belongs to the runtime class and resolves
//  the required native code to call, or invokes a new trancsription if no native
//  code yet exists for the target VM function. The runtime class also contains
//  the VM register set and stack pointers.
//
//  Machine usage
//
//  a0, a1 : scratch pointers [volatile]
//  a2, a3 : available for allocation
//  a4     : runtime class pointer [REHANNA *this]
//  a5     : VM register stack
//  a6     : VM data stack
//  a7     : native stack
//
//  d0, d1 : scratch data [volatile]
//  d2-d7  : available for allocation
//
//  fp0,fp1: scratch float data [volatile]
//  fp2-fp7: available for allocation
//
/////////////////////////////////////////////////////////////////////////////////////


class JASM68K;

#define J68K_ARGS uint32* vmCode, uint16* natCode

class JASM68K : protected CODE68020, protected CODE68882 {
  public:
    typedef void (*Handler)(J68K_ARGS);

  private:
    static Handler  instTable[256];
    static Handler  sysTable[256];

    static void fIllegal(J68K_ARGS);
    static void fNOP(J68K_ARGS);
    static void fEND(J68K_ARGS);
    static void fSYS(J68K_ARGS);
    static void fLEA(J68K_ARGS);
    static void fBRA(J68K_ARGS);
    static void fBNEQ_I8(J68K_ARGS);
    static void fBNEQ_I16(J68K_ARGS);
    static void fBNEQ_I32(J68K_ARGS);
    static void fBNEQ_I64(J68K_ARGS);
    static void fBNEQ_F32(J68K_ARGS);
    static void fBNEQ_F64(J68K_ARGS);
    static void fBLS_I8(J68K_ARGS);
    static void fBLS_I16(J68K_ARGS);
    static void fBLS_I32(J68K_ARGS);
    static void fBLS_I64(J68K_ARGS);
    static void fBLS_F32(J68K_ARGS);
    static void fBLS_F64(J68K_ARGS);
    static void fBLSEQ_I8(J68K_ARGS);
    static void fBLSEQ_I16(J68K_ARGS);
    static void fBLSEQ_I32(J68K_ARGS);
    static void fBLSEQ_I64(J68K_ARGS);
    static void fBLSEQ_F32(J68K_ARGS);
    static void fBLSEQ_F64(J68K_ARGS);
    static void fBEQ_I8(J68K_ARGS);
    static void fBEQ_I16(J68K_ARGS);
    static void fBEQ_I32(J68K_ARGS);
    static void fBEQ_I64(J68K_ARGS);
    static void fBEQ_F32(J68K_ARGS);
    static void fBEQ_F64(J68K_ARGS);
    static void fBGREQ_I8(J68K_ARGS);
    static void fBGREQ_I16(J68K_ARGS);
    static void fBGREQ_I32(J68K_ARGS);
    static void fBGREQ_I64(J68K_ARGS);
    static void fBGREQ_F32(J68K_ARGS);
    static void fBGREQ_F64(J68K_ARGS);
    static void fBGR_I8(J68K_ARGS);
    static void fBGR_I16(J68K_ARGS);
    static void fBGR_I32(J68K_ARGS);
    static void fBGR_I64(J68K_ARGS);
    static void fBGR_F32(J68K_ARGS);
    static void fBGR_F64(J68K_ARGS);
    static void fCALL(J68K_ARGS);
    static void fRET(J68K_ARGS);
    static void fPUSH_X8(J68K_ARGS);
    static void fPUSH_X16(J68K_ARGS);
    static void fPUSH_X32(J68K_ARGS);
    static void fPUSH_X64(J68K_ARGS);
    static void fPOP_X8(J68K_ARGS);
    static void fPOP_X16(J68K_ARGS);
    static void fPOP_X32(J68K_ARGS);
    static void fPOP_X64(J68K_ARGS);
    static void fSAVE(J68K_ARGS);
    static void fRESTORE(J68K_ARGS);
    static void fSET_X8(J68K_ARGS);
    static void fSET_X16(J68K_ARGS);
    static void fSET_X32(J68K_ARGS);
    static void fSET_X64(J68K_ARGS);
    static void fMOVE_X8(J68K_ARGS);
    static void fMOVE_X16(J68K_ARGS);
    static void fMOVE_X32(J68K_ARGS);
    static void fMOVE_X64(J68K_ARGS);
    static void fEMOV_X16(J68K_ARGS);
    static void fEMOV_X32(J68K_ARGS);
    static void fEMOV_X64(J68K_ARGS);
    static void fSWAP_X8(J68K_ARGS);
    static void fSWAP_X16(J68K_ARGS);
    static void fSWAP_X32(J68K_ARGS);
    static void fSWAP_X64(J68K_ARGS);
    static void fI16_U8(J68K_ARGS);
    static void fI32_U8(J68K_ARGS);
    static void fI64_U8(J68K_ARGS);
    static void fF32_U8(J68K_ARGS);
    static void fF64_U8(J68K_ARGS);
    static void fI32_U16(J68K_ARGS);
    static void fI64_U16(J68K_ARGS);
    static void fF32_U16(J68K_ARGS);
    static void fF64_U16(J68K_ARGS);
    static void fI64_U32(J68K_ARGS);
    static void fF32_U32(J68K_ARGS);
    static void fF64_U32(J68K_ARGS);
    static void fF32_U64(J68K_ARGS);
    static void fF64_U64(J68K_ARGS);
    static void fI16_S8(J68K_ARGS);
    static void fI32_S8(J68K_ARGS);
    static void fI64_S8(J68K_ARGS);
    static void fF32_S8(J68K_ARGS);
    static void fF64_S8(J68K_ARGS);
    static void fI32_S16(J68K_ARGS);
    static void fI64_S16(J68K_ARGS);
    static void fF32_S16(J68K_ARGS);
    static void fF64_S16(J68K_ARGS);
    static void fI64_S32(J68K_ARGS);
    static void fF32_S32(J68K_ARGS);
    static void fF64_S32(J68K_ARGS);
    static void fF32_S64(J68K_ARGS);
    static void fF64_S64(J68K_ARGS);
    static void fF64_F32(J68K_ARGS);
    static void fU64_F64(J68K_ARGS);
    static void fU32_F64(J68K_ARGS);
    static void fU16_F64(J68K_ARGS);
    static void fU8_F64(J68K_ARGS);
    static void fU64_F32(J68K_ARGS);
    static void fU32_F32(J68K_ARGS);
    static void fU16_F32(J68K_ARGS);
    static void fU8_F32(J68K_ARGS);
    static void fI32_U64(J68K_ARGS);
    static void fI16_U64(J68K_ARGS);
    static void fI8_U64(J68K_ARGS);
    static void fI16_U32(J68K_ARGS);
    static void fI8_U32(J68K_ARGS);
    static void fI8_U16(J68K_ARGS);
    static void fF32_F64(J68K_ARGS);
    static void fS64_F64(J68K_ARGS);
    static void fS32_F64(J68K_ARGS);
    static void fS16_F64(J68K_ARGS);
    static void fS8_F64(J68K_ARGS);
    static void fS64_F32(J68K_ARGS);
    static void fS32_F32(J68K_ARGS);
    static void fS16_F32(J68K_ARGS);
    static void fS8_F32(J68K_ARGS);
    static void fI32_S64(J68K_ARGS);
    static void fI16_S64(J68K_ARGS);
    static void fI8_S64(J68K_ARGS);
    static void fI16_S32(J68K_ARGS);
    static void fI8_S32(J68K_ARGS);
    static void fI8_S16(J68K_ARGS);
    static void fADD_I8(J68K_ARGS);
    static void fADD_I16(J68K_ARGS);
    static void fADD_I32(J68K_ARGS);
    static void fADD_I64(J68K_ARGS);
    static void fADD_F32(J68K_ARGS);
    static void fADD_F64(J68K_ARGS);
    static void fSUB_I8(J68K_ARGS);
    static void fSUB_I16(J68K_ARGS);
    static void fSUB_I32(J68K_ARGS);
    static void fSUB_I64(J68K_ARGS);
    static void fSUB_F32(J68K_ARGS);
    static void fSUB_F64(J68K_ARGS);
    static void fMUL_U8(J68K_ARGS);
    static void fMUL_U16(J68K_ARGS);
    static void fMUL_U32(J68K_ARGS);
    static void fMUL_U64(J68K_ARGS);
    static void fMUL_I8(J68K_ARGS);
    static void fMUL_I16(J68K_ARGS);
    static void fMUL_I32(J68K_ARGS);
    static void fMUL_I64(J68K_ARGS);
    static void fMUL_F32(J68K_ARGS);
    static void fMUL_F64(J68K_ARGS);
    static void fDIV_U8(J68K_ARGS);
    static void fDIV_U16(J68K_ARGS);
    static void fDIV_U32(J68K_ARGS);
    static void fDIV_U64(J68K_ARGS);
    static void fDIV_I8(J68K_ARGS);
    static void fDIV_I16(J68K_ARGS);
    static void fDIV_I32(J68K_ARGS);
    static void fDIV_I64(J68K_ARGS);
    static void fDIV_F32(J68K_ARGS);
    static void fDIV_F64(J68K_ARGS);
    static void fMOD_U8(J68K_ARGS);
    static void fMOD_U16(J68K_ARGS);
    static void fMOD_U32(J68K_ARGS);
    static void fMOD_U64(J68K_ARGS);
    static void fMOD_I8(J68K_ARGS);
    static void fMOD_I16(J68K_ARGS);
    static void fMOD_I32(J68K_ARGS);
    static void fMOD_I64(J68K_ARGS);
    static void fMOD_F32(J68K_ARGS);
    static void fMOD_F64(J68K_ARGS);
    static void fNEG_I8(J68K_ARGS);
    static void fNEG_I16(J68K_ARGS);
    static void fNEG_I32(J68K_ARGS);
    static void fNEG_I64(J68K_ARGS);
    static void fNEG_F32(J68K_ARGS);
    static void fNEG_F64(J68K_ARGS);
    static void fSHL_I8(J68K_ARGS);
    static void fSHL_I16(J68K_ARGS);
    static void fSHL_I32(J68K_ARGS);
    static void fSHL_I64(J68K_ARGS);
    static void fSHR_I8(J68K_ARGS);
    static void fSHR_I16(J68K_ARGS);
    static void fSHR_I32(J68K_ARGS);
    static void fSHR_I64(J68K_ARGS);
    static void fAND_X8(J68K_ARGS);
    static void fAND_X16(J68K_ARGS);
    static void fAND_X32(J68K_ARGS);
    static void fAND_X64(J68K_ARGS);
    static void fOR_X8(J68K_ARGS);
    static void fOR_X16(J68K_ARGS);
    static void fOR_X32(J68K_ARGS);
    static void fOR_X64(J68K_ARGS);
    static void fXOR_X8(J68K_ARGS);
    static void fXOR_X16(J68K_ARGS);
    static void fXOR_X32(J68K_ARGS);
    static void fXOR_X64(J68K_ARGS);
    static void fINV_X8(J68K_ARGS);
    static void fINV_X16(J68K_ARGS);
    static void fINV_X32(J68K_ARGS);
    static void fINV_X64(J68K_ARGS);
    static void fSHL_X8(J68K_ARGS);
    static void fSHL_X16(J68K_ARGS);
    static void fSHL_X32(J68K_ARGS);
    static void fSHL_X64(J68K_ARGS);
    static void fSHR_X8(J68K_ARGS);
    static void fSHR_X16(J68K_ARGS);
    static void fSHR_X32(J68K_ARGS);
    static void fSHR_X64(J68K_ARGS);
/*
    // TO DO
    static void fROL_X8(J68K_ARGS);
    static void fROL_X16(J68K_ARGS);
    static void fROL_X32(J68K_ARGS);
    static void fROL_X64(J68K_ARGS);
    static void fROR_X8(J68K_ARGS);
    static void fROR_X16(J68K_ARGS);
    static void fROR_X32(J68K_ARGS);
    static void fROR_X64(J68K_ARGS);
*/

/*
    // TO DO
    static void NEW_OBJ(J68K_ARGS);
    static void DEL_OBJ(J68K_ARGS);
    static void CALL_STATIC(J68K_ARGS);
    static void CALL_METHOD(J68K_ARGS);
    static void CALL_VIRTUAL(J68K_ARGS);
    static void CALL_NATIVE(J68K_ARGS);
*/

    static void fSYS_OUT_U8(J68K_ARGS);
    static void fSYS_OUT_U16(J68K_ARGS);
    static void fSYS_OUT_U32(J68K_ARGS);
    static void fSYS_OUT_U64(J68K_ARGS);
    static void fSYS_OUT_S8(J68K_ARGS);
    static void fSYS_OUT_S16(J68K_ARGS);
    static void fSYS_OUT_S32(J68K_ARGS);
    static void fSYS_OUT_S64(J68K_ARGS);
    static void fSYS_OUT_F32(J68K_ARGS);
    static void fSYS_OUT_F64(J68K_ARGS);
    static void fSYS_OUT_STR(J68K_ARGS);
    static void fSYS_INP_U8(J68K_ARGS);
    static void fSYS_INP_U16(J68K_ARGS);
    static void fSYS_INP_U32(J68K_ARGS);
    static void fSYS_INP_U64(J68K_ARGS);
    static void fSYS_INP_S8(J68K_ARGS);
    static void fSYS_INP_S16(J68K_ARGS);
    static void fSYS_INP_S32(J68K_ARGS);
    static void fSYS_INP_S64(J68K_ARGS);
    static void fSYS_INP_F32(J68K_ARGS);
    static void fSYS_INP_F64(J68K_ARGS);
    static void fSYS_INP_STR(J68K_ARGS);
    static void fSYS_BRK(J68K_ARGS);
    static void fSYS_DUMP(J68K_ARGS);
    static void fSYS_VER(J68K_ARGS);
    static void fSYS_NEW_X8(J68K_ARGS);
    static void fSYS_NEW_X16(J68K_ARGS);
    static void fSYS_NEW_X32(J68K_ARGS);
    static void fSYS_NEW_X64(J68K_ARGS);
    static void fSYS_DEL_X8(J68K_ARGS);
    static void fSYS_DEL_X16(J68K_ARGS);
    static void fSYS_DEL_X32(J68K_ARGS);
    static void fSYS_DEL_X64(J68K_ARGS);
    static void fSYS_NEWS_X8(J68K_ARGS);
    static void fSYS_NEWS_X16(J68K_ARGS);
    static void fSYS_NEWS_X32(J68K_ARGS);
    static void fSYS_NEWS_X64(J68K_ARGS);
    static void fSYS_DELS_X8(J68K_ARGS);
    static void fSYS_DELS_X16(J68K_ARGS);
    static void fSYS_DELS_X32(J68K_ARGS);
    static void fSYS_DELS_X64(J68K_ARGS);

    typedef struct FLOWINFO {
      sint32  vmCodePos;        // Position in the VM code
      sint32  natCodePos;       // Position in the 68K code
      sint32  vmBranchTarget;   // Jump target in VM code (pc+offset), if any
      sint16  natDisplacement;  // Jump offset in 68k code, if any
      uint8   isBranch;         // Is a jump
      uint8   isResolved;       // Has been resolved
    };

    FLOWINFO* codePath;
    sint32    maxCodePath;

  public:
    sint32  TranslateFunc(J68K_ARGS);
    sint32  Create(sint32 s);
    void    Delete();

    JASM68K() : codePath(0), maxCodePath(0) {}
    JASM68K(size_t s) : codePath(0), maxCodePath(0) { Create(s); }
    ~JASM68K() { Delete(); }
};

/////////////////////////////////////////////////////////////////////////////////////
//
//  REHANNA
//
//  Machine usage
//
//  a0, a1 : scratch pointers [volatile]
//  a2, a3 : available for allocation
//  a4     : runtime class pointer [REHANNA *this]
//  a5     : VM register stack
//  a6     : VM data stack
//  a7     : native stack
//
//  d0, d1 : scratch data [volatile]
//  d2-d7  : available for allocation
//
//  fp0,fp1: scratch float data [volatile]
//  fp2-fp7: available for allocation
//
/////////////////////////////////////////////////////////////////////////////////////

#define RENVLTLP0 register __a0 void*
#define RENCLASSP register __a4 REHANNA*
#define RENREGSTK register __a5 uint64*
#define RENDATSTK register __a6 void*

class REHANNA {
  protected:
    union GPR { // General Purpose 64-bit register type
      private:  // Data arrangement
        union { uint8     u8[8];    sint8     s8[8];                                       };
        union { uint16    u16[4];   sint16    s16[4];                                      };
        union { uint32    u32[2];   sint32    s32[2];   float32 f32[2];                    };
        union { uint64    u64;      sint64    s64;      float64 f64;                       };
        union { uint8*    pu8[2];   uint16*   pu16[2];  uint32* pu32[2];  uint64* pu64[2]; };
        union { sint8*    ps8[2];   sint16*   ps16[2];  sint32* ps32[2];  sint64* ps64[2]; };
        union { float32*  pf32[2];  float64*  pf64[2];                                     };
        union { char*     pch[2];   wchar_t*  pwch[2];                                     };

      public:
        // Direct data access [pointer to register contents]
        void*     Data8();
        void*     Data16();
        void*     Data32();
        void*     Data64();
        void*     Data(uint32 s);
        // Register pointer access [address of object pointed to by register]
        char*     &PtrCh();
        uint8*    &PtrU8();
        uint16*   &PtrU16();
        uint32*   &PtrU32();
        uint64*   &PtrU64();
        sint8*    &PtrS8();
        sint16*   &PtrS16();
        sint32*   &PtrS32();
        sint64*   &PtrS64();
        float32*  &PtrF32();
        float64*  &PtrF64();
        // register value access [reference to register data]
        uint8&    ValU8();
        uint16&   ValU16();
        uint32&   ValU32();
        uint64&   ValU64();
        sint8&    ValS8();
        sint16&   ValS16();
        sint32&   ValS32();
        sint64&   ValS64();
        float32&  ValF32();
        float64&  ValF64();
        // 32-bit halfword access
        uint32    MSW();
        uint32    LSW();
    } gpRegs[32];

    uint64*         regStack;
    uint8*          stack;
    void*           dataSectPtr;
    void*           constSectPtr;
    uint32          exitReg;
    sint32          countReg;
    uint32          machineReg;
    uint8*          stackTrace;
    uint8*          stackBase;
    uint8*          stackTop;
    uint64*         regStackBase;
    uint64*         regStackTop;
    JASMINEOBJECT*  vmObject;

  private:
    typedef struct TRANSLATED {
      uint32  vmCodeAddr;
      size_t  vmCodeSize;
      void*   nativeCode;
      size_t  nativeCodeSize;
    };
    static void     CallHandler(RENCLASSP, RENVLTLP0);
    void            (*funcHandler)(RENCLASSP, RENVLTLP0);

    void*           codeHeap;
    sint32          codeSize;
    sint32          codeUsed;
    TRANSLATED*     funcList;
    sint32          funcSize;
    sint32          funcUsed;

  public:
    sint32  Create(sint32 size, sint32 maxFuncs);
    void    Delete();

  public:
    REHANNA() : funcHandler(CallHandler), codeHeap(0), codeSize(0), codeUsed(0),
                funcList(0), funcSize(0), funcUsed(0) {}
    REHANNA(sint32 c, sint32 m) : funcHandler(CallHandler), codeHeap(0), codeSize(0),
                codeUsed(0), funcList(0), funcSize(0), funcUsed(0) { Create (c,m); }
    ~REHANNA() { Delete(); }
};



/////////////////////////////////////////////////////////////////////////////////////


#define OFS_R00 offsetof(REHANNA, gpRegs[0])
#define OFS_R01 offsetof(REHANNA, gpRegs[1])
#define OFS_R02 offsetof(REHANNA, gpRegs[2])
#define OFS_R03 offsetof(REHANNA, gpRegs[3])
#define OFS_R04 offsetof(REHANNA, gpRegs[4])
#define OFS_R05 offsetof(REHANNA, gpRegs[5])
#define OFS_R06 offsetof(REHANNA, gpRegs[6])
#define OFS_R07 offsetof(REHANNA, gpRegs[7])
#define OFS_R08 offsetof(REHANNA, gpRegs[8])
#define OFS_R09 offsetof(REHANNA, gpRegs[9])
#define OFS_R10 offsetof(REHANNA, gpRegs[10])
#define OFS_R11 offsetof(REHANNA, gpRegs[11])
#define OFS_R12 offsetof(REHANNA, gpRegs[12])
#define OFS_R13 offsetof(REHANNA, gpRegs[13])
#define OFS_R14 offsetof(REHANNA, gpRegs[14])
#define OFS_R15 offsetof(REHANNA, gpRegs[15])
#define OFS_R16 offsetof(REHANNA, gpRegs[16])
#define OFS_R17 offsetof(REHANNA, gpRegs[17])
#define OFS_R18 offsetof(REHANNA, gpRegs[18])
#define OFS_R19 offsetof(REHANNA, gpRegs[19])
#define OFS_R20 offsetof(REHANNA, gpRegs[20])
#define OFS_R21 offsetof(REHANNA, gpRegs[21])
#define OFS_R22 offsetof(REHANNA, gpRegs[22])
#define OFS_R23 offsetof(REHANNA, gpRegs[23])
#define OFS_R24 offsetof(REHANNA, gpRegs[24])
#define OFS_R25 offsetof(REHANNA, gpRegs[25])
#define OFS_R26 offsetof(REHANNA, gpRegs[26])
#define OFS_R27 offsetof(REHANNA, gpRegs[27])
#define OFS_R28 offsetof(REHANNA, gpRegs[28])
#define OFS_R29 offsetof(REHANNA, gpRegs[29])
#define OFS_R30 offsetof(REHANNA, gpRegs[30])
#define OFS_R31 offsetof(REHANNA, gpRegs[31])
/*
#define OFS_I00 offsetof(REHANNA, imReg[0])
#define OFS_I01 offsetof(REHANNA, imReg[1])
#define OFS_OP0 offsetof(REHANNA, op[0])
#define OFS_OP1 offsetof(REHANNA, op[1])
#define OFS_OP2 offsetof(REHANNA, op[2])
*/
#define OFS_RSTK offsetof(REHANNA, regStack)
#define OFS_DSTK offsetof(REHANNA, stack)
//#define OFS_MSTK offsetof(REHANNA, methodStack)
#define OFS_DSPT offsetof(REHANNA, dataSectPtr)
#define OFS_CSPT offsetof(REHANNA, constSectPtr)
#define OFS_EXIT offsetof(REHANNA, exitReg)
#define OFS_CNTR offsetof(REHANNA, countReg)
#define OFS_MACH offsetof(JASMINE, machineReg)
//#define OFS_MBOT offsetof(REHANNA, methodStackBase)
//#define OFS_MTOP offsetof(REHANNA, methodStackTop)
#define OFS_DBOT offsetof(REHANNA, stackBase)
#define OFS_DTOP offsetof(REHANNA, stackTop)
#define OFS_RBOT offsetof(REHANNA, regStackBase)
#define OFS_RTOP offsetof(REHANNA, regStackTop)

#endif
