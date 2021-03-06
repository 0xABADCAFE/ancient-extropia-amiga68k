//****************************************************************************//
//**                                                                        **//
//**  File:          JasmineClass.hpp ($NAME=JasmineClass.hpp)              **//
//**                                                                        **//
//**  Description:   JASMINE Virtual Machine implementation                 **//
//**  Comment(s):    Platform independant inline code only                  **//
//**                                                                        **//
//**  Classes:       JASMINE_EA, JASMINE_OP, JASMINE                        **//
//**                                                                        **//
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

#ifndef _JASMINE_CLASSES_HPP
#define _JASMINE_CLASSES_HPP

class JASMINE;
class JASMINE_EA;
class JASMINE_OP;
class JASMINEOBJECT;

////////////////////////////////////////////////////////////////////////////////
//
//  JASMINE_EA
//
//  Operand Pointer Decoding Engine
//
////////////////////////////////////////////////////////////////////////////////

#if defined(XP_AMIGAOS) && defined(JASMINE_HANDCODED)
  #define EA_ARG    register __a2 JASMINE* jvm
  #define EA_ARGS   register __a2 JASMINE* jvm, register __d7 size_t s
  #define EA_2ARGS  register __a2 JASMINE* jvm, register __d6 size_t s1, register __d7 size_t s2
#else
  #define EA_ARG    JASMINE* jvm
  #define EA_ARGS   JASMINE* jvm, size_t s
  #define EA_2ARGS  JASMINE* jvm, size_t s1, size_t s2
#endif

class JASMINE_EA {
  friend class JASMINE;
  friend class JASMINE_OP;

  public:
    typedef void*   (*Handler)(EA_ARGS);

  private:
    static Handler  eaTable[256];

    static void* fR0(EA_ARGS);
    static void* fR1(EA_ARGS);
    static void* fR2(EA_ARGS);
    static void* fR3(EA_ARGS);
    static void* fR4(EA_ARGS);
    static void* fR5(EA_ARGS);
    static void* fR6(EA_ARGS);
    static void* fR7(EA_ARGS);
    static void* fR8(EA_ARGS);
    static void* fR9(EA_ARGS);
    static void* fR10(EA_ARGS);
    static void* fR11(EA_ARGS);
    static void* fR12(EA_ARGS);
    static void* fR13(EA_ARGS);
    static void* fR14(EA_ARGS);
    static void* fR15(EA_ARGS);
    static void* fR16(EA_ARGS);
    static void* fR17(EA_ARGS);
    static void* fR18(EA_ARGS);
    static void* fR19(EA_ARGS);
    static void* fR20(EA_ARGS);
    static void* fR21(EA_ARGS);
    static void* fR22(EA_ARGS);
    static void* fR23(EA_ARGS);
    static void* fR24(EA_ARGS);
    static void* fR25(EA_ARGS);
    static void* fR26(EA_ARGS);
    static void* fR27(EA_ARGS);
    static void* fR28(EA_ARGS);
    static void* fR29(EA_ARGS);
    static void* fR30(EA_ARGS);
    static void* fR31(EA_ARGS);
    static void* fIR0(EA_ARGS);
    static void* fIR1(EA_ARGS);
    static void* fIR2(EA_ARGS);
    static void* fIR3(EA_ARGS);
    static void* fIR4(EA_ARGS);
    static void* fIR5(EA_ARGS);
    static void* fIR6(EA_ARGS);
    static void* fIR7(EA_ARGS);
    static void* fIR8(EA_ARGS);
    static void* fIR9(EA_ARGS);
    static void* fIR10(EA_ARGS);
    static void* fIR11(EA_ARGS);
    static void* fIR12(EA_ARGS);
    static void* fIR13(EA_ARGS);
    static void* fIR14(EA_ARGS);
    static void* fIR15(EA_ARGS);
    static void* fIR16(EA_ARGS);
    static void* fIR17(EA_ARGS);
    static void* fIR18(EA_ARGS);
    static void* fIR19(EA_ARGS);
    static void* fIR20(EA_ARGS);
    static void* fIR21(EA_ARGS);
    static void* fIR22(EA_ARGS);
    static void* fIR23(EA_ARGS);
    static void* fIR24(EA_ARGS);
    static void* fIR25(EA_ARGS);
    static void* fIR26(EA_ARGS);
    static void* fIR27(EA_ARGS);
    static void* fIR28(EA_ARGS);
    static void* fIR29(EA_ARGS);
    static void* fIR30(EA_ARGS);
    static void* fIR31(EA_ARGS);
    static void* fLIR0(EA_ARGS);
    static void* fLIR1(EA_ARGS);
    static void* fLIR2(EA_ARGS);
    static void* fLIR3(EA_ARGS);
    static void* fLIR4(EA_ARGS);
    static void* fLIR5(EA_ARGS);
    static void* fLIR6(EA_ARGS);
    static void* fLIR7(EA_ARGS);
    static void* fLIR8(EA_ARGS);
    static void* fLIR9(EA_ARGS);
    static void* fLIR10(EA_ARGS);
    static void* fLIR11(EA_ARGS);
    static void* fLIR12(EA_ARGS);
    static void* fLIR13(EA_ARGS);
    static void* fLIR14(EA_ARGS);
    static void* fLIR15(EA_ARGS);
    static void* fLIR16(EA_ARGS);
    static void* fLIR17(EA_ARGS);
    static void* fLIR18(EA_ARGS);
    static void* fLIR19(EA_ARGS);
    static void* fLIR20(EA_ARGS);
    static void* fLIR21(EA_ARGS);
    static void* fLIR22(EA_ARGS);
    static void* fLIR23(EA_ARGS);
    static void* fLIR24(EA_ARGS);
    static void* fLIR25(EA_ARGS);
    static void* fLIR26(EA_ARGS);
    static void* fLIR27(EA_ARGS);
    static void* fLIR28(EA_ARGS);
    static void* fLIR29(EA_ARGS);
    static void* fLIR30(EA_ARGS);
    static void* fLIR31(EA_ARGS);
    static void* fLUIR0(EA_ARGS);
    static void* fLUIR1(EA_ARGS);
    static void* fLUIR2(EA_ARGS);
    static void* fLUIR3(EA_ARGS);
    static void* fLUIR4(EA_ARGS);
    static void* fLUIR5(EA_ARGS);
    static void* fLUIR6(EA_ARGS);
    static void* fLUIR7(EA_ARGS);
    static void* fLUIR8(EA_ARGS);
    static void* fLUIR9(EA_ARGS);
    static void* fLUIR10(EA_ARGS);
    static void* fLUIR11(EA_ARGS);
    static void* fLUIR12(EA_ARGS);
    static void* fLUIR13(EA_ARGS);
    static void* fLUIR14(EA_ARGS);
    static void* fLUIR15(EA_ARGS);
    static void* fLUIR16(EA_ARGS);
    static void* fLUIR17(EA_ARGS);
    static void* fLUIR18(EA_ARGS);
    static void* fLUIR19(EA_ARGS);
    static void* fLUIR20(EA_ARGS);
    static void* fLUIR21(EA_ARGS);
    static void* fLUIR22(EA_ARGS);
    static void* fLUIR23(EA_ARGS);
    static void* fLUIR24(EA_ARGS);
    static void* fLUIR25(EA_ARGS);
    static void* fLUIR26(EA_ARGS);
    static void* fLUIR27(EA_ARGS);
    static void* fLUIR28(EA_ARGS);
    static void* fLUIR29(EA_ARGS);
    static void* fLUIR30(EA_ARGS);
    static void* fLUIR31(EA_ARGS);
    static void* fIRRO(EA_ARGS);
    static void* fIRROU(EA_ARGS);
    static void* fIRSRO(EA_ARGS);
    static void* fIRSROU(EA_ARGS);
    static void* fCTR(EA_ARGS);
    static void* fDS(EA_ARGS);
    static void* fCDS(EA_ARGS);
    static void* fLITERAL(EA_ARGS);
    static void* fOFFSET_PC(EA_ARGS);
    static void* fFUNC_TAB(EA_ARGS);
    static void* IllegalAddress(EA_ARGS);

    // arg decoding funcs
    static void D1_X8(EA_ARG);
    static void D1_X16(EA_ARG);
    static void D1_X32(EA_ARG);
    static void D1_X64(EA_ARG);
    static void D2(EA_2ARGS);
    static void D2_X8(EA_ARG);
    static void D2_X16(EA_ARG);
    static void D2_X32(EA_ARG);
    static void D2_X64(EA_ARG);
    static void D2C_X8(EA_ARG);
    static void D2C_X16(EA_ARG);
    static void D2C_X32(EA_ARG);
    static void D2C_X64(EA_ARG);
    static void D3_X8(EA_ARG);
    static void D3_X16(EA_ARG);
    static void D3_X32(EA_ARG);
    static void D3_X64(EA_ARG);
    static void D2_X8_X32(EA_2ARGS);
    static void D2_X16_X32(EA_2ARGS);
    static void D2_X64_X32(EA_2ARGS);

    static void DSYS_EA(EA_ARGS);
    static void D2SYS_EA(EA_2ARGS);
};


/////////////////////////////////////////////////////////////////////////////////////
//
//  JASMINE_OP
//
//  Opcode Implementation
//
/////////////////////////////////////////////////////////////////////////////////////

#if defined(XP_AMIGAOS) && defined(JASMINE_HANDCODED)
  #define OP_ARGS   register __a2 JASMINE* jvm, register __a3 JASMINE_EA::Handler* pf
#else
  #define OP_ARGS   JASMINE* jvm
#endif

class JASMINE_OP {
  friend class JASMINE;
  friend class JASMINE_EA;

  public:
    typedef void  (*Handler)(OP_ARGS);

  private:
    static Handler  instTable[256];
    static Handler  sysTable[256];
    // Handler functions
    static void IllegalOpcode(OP_ARGS);
    static void fNOP(OP_ARGS);
    static void fEND(OP_ARGS);
    static void fSYS(OP_ARGS);
    static void fLEA(OP_ARGS);
    static void fBRA(OP_ARGS);
    static void fBNEQ_I8(OP_ARGS);
    static void fBNEQ_I16(OP_ARGS);
    static void fBNEQ_I32(OP_ARGS);
    static void fBNEQ_I64(OP_ARGS);
    static void fBNEQ_F32(OP_ARGS);
    static void fBNEQ_F64(OP_ARGS);
    static void fBLS_I8(OP_ARGS);
    static void fBLS_I16(OP_ARGS);
    static void fBLS_I32(OP_ARGS);
    static void fBLS_I64(OP_ARGS);
    static void fBLS_F32(OP_ARGS);
    static void fBLS_F64(OP_ARGS);
    static void fBLSEQ_I8(OP_ARGS);
    static void fBLSEQ_I16(OP_ARGS);
    static void fBLSEQ_I32(OP_ARGS);
    static void fBLSEQ_I64(OP_ARGS);
    static void fBLSEQ_F32(OP_ARGS);
    static void fBLSEQ_F64(OP_ARGS);
    static void fBEQ_I8(OP_ARGS);
    static void fBEQ_I16(OP_ARGS);
    static void fBEQ_I32(OP_ARGS);
    static void fBEQ_I64(OP_ARGS);
    static void fBEQ_F32(OP_ARGS);
    static void fBEQ_F64(OP_ARGS);
    static void fBGREQ_I8(OP_ARGS);
    static void fBGREQ_I16(OP_ARGS);
    static void fBGREQ_I32(OP_ARGS);
    static void fBGREQ_I64(OP_ARGS);
    static void fBGREQ_F32(OP_ARGS);
    static void fBGREQ_F64(OP_ARGS);
    static void fBGR_I8(OP_ARGS);
    static void fBGR_I16(OP_ARGS);
    static void fBGR_I32(OP_ARGS);
    static void fBGR_I64(OP_ARGS);
    static void fBGR_F32(OP_ARGS);
    static void fBGR_F64(OP_ARGS);
    static void fCALL(OP_ARGS);
    static void fRET(OP_ARGS);
    static void fPUSH_X8(OP_ARGS);
    static void fPUSH_X16(OP_ARGS);
    static void fPUSH_X32(OP_ARGS);
    static void fPUSH_X64(OP_ARGS);
    static void fPOP_X8(OP_ARGS);
    static void fPOP_X16(OP_ARGS);
    static void fPOP_X32(OP_ARGS);
    static void fPOP_X64(OP_ARGS);
    static void fSAVE(OP_ARGS);
    static void fRESTORE(OP_ARGS);
    static void fSET_X8(OP_ARGS);
    static void fSET_X16(OP_ARGS);
    static void fSET_X32(OP_ARGS);
    static void fSET_X64(OP_ARGS);
    static void fMOVE_X8(OP_ARGS);
    static void fMOVE_X16(OP_ARGS);
    static void fMOVE_X32(OP_ARGS);
    static void fMOVE_X64(OP_ARGS);
    static void fEMOV_X16(OP_ARGS);
    static void fEMOV_X32(OP_ARGS);
    static void fEMOV_X64(OP_ARGS);
    static void fSWAP_X8(OP_ARGS);
    static void fSWAP_X16(OP_ARGS);
    static void fSWAP_X32(OP_ARGS);
    static void fSWAP_X64(OP_ARGS);
    static void fI16_U8(OP_ARGS);
    static void fI32_U8(OP_ARGS);
    static void fI64_U8(OP_ARGS);
    static void fF32_U8(OP_ARGS);
    static void fF64_U8(OP_ARGS);
    static void fI32_U16(OP_ARGS);
    static void fI64_U16(OP_ARGS);
    static void fF32_U16(OP_ARGS);
    static void fF64_U16(OP_ARGS);
    static void fI64_U32(OP_ARGS);
    static void fF32_U32(OP_ARGS);
    static void fF64_U32(OP_ARGS);
    static void fF32_U64(OP_ARGS);
    static void fF64_U64(OP_ARGS);
    static void fI16_S8(OP_ARGS);
    static void fI32_S8(OP_ARGS);
    static void fI64_S8(OP_ARGS);
    static void fF32_S8(OP_ARGS);
    static void fF64_S8(OP_ARGS);
    static void fI32_S16(OP_ARGS);
    static void fI64_S16(OP_ARGS);
    static void fF32_S16(OP_ARGS);
    static void fF64_S16(OP_ARGS);
    static void fI64_S32(OP_ARGS);
    static void fF32_S32(OP_ARGS);
    static void fF64_S32(OP_ARGS);
    static void fF32_S64(OP_ARGS);
    static void fF64_S64(OP_ARGS);
    static void fF64_F32(OP_ARGS);
    static void fU64_F64(OP_ARGS);
    static void fU32_F64(OP_ARGS);
    static void fU16_F64(OP_ARGS);
    static void fU8_F64(OP_ARGS);
    static void fU64_F32(OP_ARGS);
    static void fU32_F32(OP_ARGS);
    static void fU16_F32(OP_ARGS);
    static void fU8_F32(OP_ARGS);
    static void fI32_U64(OP_ARGS);
    static void fI16_U64(OP_ARGS);
    static void fI8_U64(OP_ARGS);
    static void fI16_U32(OP_ARGS);
    static void fI8_U32(OP_ARGS);
    static void fI8_U16(OP_ARGS);
    static void fF32_F64(OP_ARGS);
    static void fS64_F64(OP_ARGS);
    static void fS32_F64(OP_ARGS);
    static void fS16_F64(OP_ARGS);
    static void fS8_F64(OP_ARGS);
    static void fS64_F32(OP_ARGS);
    static void fS32_F32(OP_ARGS);
    static void fS16_F32(OP_ARGS);
    static void fS8_F32(OP_ARGS);
    static void fI32_S64(OP_ARGS);
    static void fI16_S64(OP_ARGS);
    static void fI8_S64(OP_ARGS);
    static void fI16_S32(OP_ARGS);
    static void fI8_S32(OP_ARGS);
    static void fI8_S16(OP_ARGS);
    static void fADD_I8(OP_ARGS);
    static void fADD_I16(OP_ARGS);
    static void fADD_I32(OP_ARGS);
    static void fADD_I64(OP_ARGS);
    static void fADD_F32(OP_ARGS);
    static void fADD_F64(OP_ARGS);
    static void fSUB_I8(OP_ARGS);
    static void fSUB_I16(OP_ARGS);
    static void fSUB_I32(OP_ARGS);
    static void fSUB_I64(OP_ARGS);
    static void fSUB_F32(OP_ARGS);
    static void fSUB_F64(OP_ARGS);
    static void fMUL_U8(OP_ARGS);
    static void fMUL_U16(OP_ARGS);
    static void fMUL_U32(OP_ARGS);
    static void fMUL_U64(OP_ARGS);
    static void fMUL_I8(OP_ARGS);
    static void fMUL_I16(OP_ARGS);
    static void fMUL_I32(OP_ARGS);
    static void fMUL_I64(OP_ARGS);
    static void fMUL_F32(OP_ARGS);
    static void fMUL_F64(OP_ARGS);
    static void fDIV_U8(OP_ARGS);
    static void fDIV_U16(OP_ARGS);
    static void fDIV_U32(OP_ARGS);
    static void fDIV_U64(OP_ARGS);
    static void fDIV_I8(OP_ARGS);
    static void fDIV_I16(OP_ARGS);
    static void fDIV_I32(OP_ARGS);
    static void fDIV_I64(OP_ARGS);
    static void fDIV_F32(OP_ARGS);
    static void fDIV_F64(OP_ARGS);
    static void fMOD_U8(OP_ARGS);
    static void fMOD_U16(OP_ARGS);
    static void fMOD_U32(OP_ARGS);
    static void fMOD_U64(OP_ARGS);
    static void fMOD_I8(OP_ARGS);
    static void fMOD_I16(OP_ARGS);
    static void fMOD_I32(OP_ARGS);
    static void fMOD_I64(OP_ARGS);
    static void fMOD_F32(OP_ARGS);
    static void fMOD_F64(OP_ARGS);
    static void fNEG_I8(OP_ARGS);
    static void fNEG_I16(OP_ARGS);
    static void fNEG_I32(OP_ARGS);
    static void fNEG_I64(OP_ARGS);
    static void fNEG_F32(OP_ARGS);
    static void fNEG_F64(OP_ARGS);
    static void fSHL_I8(OP_ARGS);
    static void fSHL_I16(OP_ARGS);
    static void fSHL_I32(OP_ARGS);
    static void fSHL_I64(OP_ARGS);
    static void fSHR_I8(OP_ARGS);
    static void fSHR_I16(OP_ARGS);
    static void fSHR_I32(OP_ARGS);
    static void fSHR_I64(OP_ARGS);
    static void fAND_X8(OP_ARGS);
    static void fAND_X16(OP_ARGS);
    static void fAND_X32(OP_ARGS);
    static void fAND_X64(OP_ARGS);
    static void fOR_X8(OP_ARGS);
    static void fOR_X16(OP_ARGS);
    static void fOR_X32(OP_ARGS);
    static void fOR_X64(OP_ARGS);
    static void fXOR_X8(OP_ARGS);
    static void fXOR_X16(OP_ARGS);
    static void fXOR_X32(OP_ARGS);
    static void fXOR_X64(OP_ARGS);
    static void fINV_X8(OP_ARGS);
    static void fINV_X16(OP_ARGS);
    static void fINV_X32(OP_ARGS);
    static void fINV_X64(OP_ARGS);
    static void fSHL_X8(OP_ARGS);
    static void fSHL_X16(OP_ARGS);
    static void fSHL_X32(OP_ARGS);
    static void fSHL_X64(OP_ARGS);
    static void fSHR_X8(OP_ARGS);
    static void fSHR_X16(OP_ARGS);
    static void fSHR_X32(OP_ARGS);
    static void fSHR_X64(OP_ARGS);
/*
    // TO DO
    static void fROL_X8(OP_ARGS);
    static void fROL_X16(OP_ARGS);
    static void fROL_X32(OP_ARGS);
    static void fROL_X64(OP_ARGS);
    static void fROR_X8(OP_ARGS);
    static void fROR_X16(OP_ARGS);
    static void fROR_X32(OP_ARGS);
    static void fROR_X64(OP_ARGS);
*/

/*
    // TO DO
    static void NEW_OBJ(OP_ARGS);
    static void DEL_OBJ(OP_ARGS);
    static void CALL_STATIC(OP_ARGS);
    static void CALL_METHOD(OP_ARGS);
    static void CALL_VIRTUAL(OP_ARGS);
    static void CALL_NATIVE(OP_ARGS);
*/

    static void fSYS_OUT_U8(OP_ARGS);
    static void fSYS_OUT_U16(OP_ARGS);
    static void fSYS_OUT_U32(OP_ARGS);
    static void fSYS_OUT_U64(OP_ARGS);
    static void fSYS_OUT_S8(OP_ARGS);
    static void fSYS_OUT_S16(OP_ARGS);
    static void fSYS_OUT_S32(OP_ARGS);
    static void fSYS_OUT_S64(OP_ARGS);
    static void fSYS_OUT_F32(OP_ARGS);
    static void fSYS_OUT_F64(OP_ARGS);
    static void fSYS_OUT_STR(OP_ARGS);
    static void fSYS_INP_U8(OP_ARGS);
    static void fSYS_INP_U16(OP_ARGS);
    static void fSYS_INP_U32(OP_ARGS);
    static void fSYS_INP_U64(OP_ARGS);
    static void fSYS_INP_S8(OP_ARGS);
    static void fSYS_INP_S16(OP_ARGS);
    static void fSYS_INP_S32(OP_ARGS);
    static void fSYS_INP_S64(OP_ARGS);
    static void fSYS_INP_F32(OP_ARGS);
    static void fSYS_INP_F64(OP_ARGS);
    static void fSYS_INP_STR(OP_ARGS);
    static void fSYS_BRK(OP_ARGS);
    static void fSYS_DUMP(OP_ARGS);
    static void fSYS_VER(OP_ARGS);
    static void fSYS_NEW_X8(OP_ARGS);
    static void fSYS_NEW_X16(OP_ARGS);
    static void fSYS_NEW_X32(OP_ARGS);
    static void fSYS_NEW_X64(OP_ARGS);
    static void fSYS_DEL_X8(OP_ARGS);
    static void fSYS_DEL_X16(OP_ARGS);
    static void fSYS_DEL_X32(OP_ARGS);
    static void fSYS_DEL_X64(OP_ARGS);
    static void fSYS_NEWS_X8(OP_ARGS);
    static void fSYS_NEWS_X16(OP_ARGS);
    static void fSYS_NEWS_X32(OP_ARGS);
    static void fSYS_NEWS_X64(OP_ARGS);
    static void fSYS_DELS_X8(OP_ARGS);
    static void fSYS_DELS_X16(OP_ARGS);
    static void fSYS_DELS_X32(OP_ARGS);
    static void fSYS_DELS_X64(OP_ARGS);
};


////////////////////////////////////////////////////////////////////////////////
//
//  JASMINE
//
//  Runtime core
//
////////////////////////////////////////////////////////////////////////////////

#if defined(XP_AMIGAOS) && defined(JASMINE_HANDCODED)
  #define JCLASSP   register __a2 JASMINE* This
  #define VLDREG1   register __d0
  #define VLDREG2   register __d1
  //#define EX_ARGS   register __a2 JASMINE* This, register __a6 JASMINE_OP::Handler* iTab
#else
  #define JCLASSP   JASMINE* This
  //#define EX_ARGS   JASMINE* This, JASMINE_OP::Handler* iTab
  #define VLDREG1
  #define VLDREG2
#endif

#define EX_ARGS JASMINE* This

class JASMINE {
  friend class JASMINE_EA;
  friend class JASMINE_OP;

  private:
    enum { // states
      RUNNING           = 0,
      END_OF_CODE,
      USER_BREAK,
      MATH_DIVBYZERO,
      STACK_OVERFLOW,
      STACK_UNDERFLOW,
      METHD_OVERFLOW,
      METHD_UNDERFLOW,
      REGS_OVERFLOW,
      REGS_UNDERFLOW,
      ILLEGAL_OPCODE,
      ILLEGAL_EATYPE,
      NUM_EXITCODES
    };

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

    GPR imReg[2];       // immediate data temporary
    uint32*   instPtr;  // instruction pointer

    union { // operand pointers. Used by seperate EA decode/execute implementation
      uint8* u8;      uint16* u16;      uint32* u32;      uint64* u64;
      sint8* s8;      sint16* s16;      sint32* s32;      sint64* s64;
      float32* f32;   float64* f64;     char*   ch;       wchar_t* wch;
      void*   any;    GPR* reg;
    } op[3];

    uint64*   regStack;
    uint8*    stack;
    uint32**  methodStack;
    void*     dataSectPtr;
    void*     constSectPtr;
    uint32    exitReg;
    sint32    countReg;
    uint32    machineReg;
    uint8*    stackTrace; // keeps track of items pushed on stack (by size)

    uint32**            methodStackBase;
    uint32**            methodStackTop;
    uint8*              stackBase;
    uint8*              stackTop;
    uint64*             regStackBase;
    uint64*             regStackTop;
    JASMINEOBJECT*      vmObject;
    static sint32       illegalDone;
    static const char*  resultString[NUM_EXITCODES];

    static  sint32  PushRegs(JCLASSP, VLDREG1 sint32 first, VLDREG2 sint32 num);
    static  sint32  PopRegs(JCLASSP, VLDREG1 sint32 first, VLDREG2 sint32 num);

    static  void    Execute(EX_ARGS);

    sint32          Alloc(size_t stackSize, size_t methStackSize, size_t regStackSize=128);
    void            Free();

  protected:
    enum {
      STACK_TRACE_8   = 1,
      STACK_TRACE_16  = 2,
      STACK_TRACE_32  = 4,
      STACK_TRACE_64  = 8,
      STACK_SIZE_X8   = 2,
      STACK_SIZE_X16  = 2,
      STACK_SIZE_X32  = 4,
      STACK_SIZE_X64  = 8
    };

    // inheritance level interface
    sint32          GetPC();
    GPR&            Reg(uint32 r) { return gpRegs[r&0x1F]; }

    sint32          SaveRegs(sint32 first, sint32 last)     { return PushRegs(this, first, last-first); }
    sint32          RestoreRegs(sint32 first, sint32 last)  { return PopRegs(this, first, last-first); }

  public:
    const char*     ExitResult()  { return (const char*)resultString[exitReg]; }
    uint32          Execute(JASMINEOBJECT& prog);

    static void     GenInclude();

    JASMINE();
    virtual ~JASMINE();
};

/////////////////////////////////////////////////////////////////////////////////////


#endif // _JASMINE_CLASSES_HPP
