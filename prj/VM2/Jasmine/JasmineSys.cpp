//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "Jasmine.hpp"

#if (X_ENDIAN == XA_BIGENDIAN)

void JASMINE_EA::DSYS_EA(EA_ARGS)
{
  uint32 x = ((uint8*)jvm->instPtr)[2];
  if (x<VM::IM0)
    jvm->op[0].any = eaTable[x](jvm,s);
  else
  {
    switch(s)
    {
      case 1:
        jvm->imReg[0].ValU8() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data8();
        break;
      case 2:
        jvm->imReg[0].ValU16() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data16();
        break;
      case 4:
        jvm->imReg[0].ValU32() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data32();
        break;
      case 8:
        jvm->imReg[0].ValU64() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data64();
        break;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_EA::D2SYS_EA(EA_2ARGS)
{
  uint32 x = ((uint8*)jvm->instPtr)[2];
  if (x<VM::IM0)
    jvm->op[0].any = eaTable[x](jvm,s1);
  else
  {
    switch(s1)
    {
      case 1:
        jvm->imReg[0].ValU8() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data8();
        break;
      case 2:
        jvm->imReg[0].ValU16() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data16();
        break;
      case 4:
        jvm->imReg[0].ValU32() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data32();
        break;
      case 8:
        jvm->imReg[0].ValU64() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data64();
        break;
    }
  }

  x = ((uint8*)jvm->instPtr)[3];
  if (x<VM::IM0)
    jvm->op[1].any = eaTable[x](jvm,s2);
  else
  {
    switch(s2)
    {
      case 1:
        jvm->imReg[1].ValU8() = x-VM::IM0;
        jvm->op[1].any = jvm->imReg[1].Data8();
        break;
      case 2:
        jvm->imReg[1].ValU16() = x-VM::IM0;
        jvm->op[1].any = jvm->imReg[1].Data16();
        break;
      case 4:
        jvm->imReg[1].ValU32() = x-VM::IM0;
        jvm->op[1].any = jvm->imReg[1].Data32();
        break;
      case 8:
        jvm->imReg[1].ValU64() = x-VM::IM0;
        jvm->op[1].any = jvm->imReg[1].Data64();
        break;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS(OP_ARGS)
{
  #ifdef XP_AMIGAOS
  sysTable[((uint8*)jvm->instPtr)[1]](jvm, pf);
  #else
  sysTable[((uint8*)jvm->instPtr)[1]](jvm);
  #endif
  jvm->instPtr++;
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #if (X_ENDIAN == XA_BIGENDIAN)

void JASMINE_EA::DSYS_EA(EA_ARGS)
{
  uint32 x = ((uint8*)jvm->instPtr)[1];
  if (x<VM::IM0)
    jvm->op[0].any = eaTable[x](jvm,s);
  else
  {
    switch(s)
    {
      case 1:
        jvm->imReg[0].ValU8() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data8();
        break;
      case 2:
        jvm->imReg[0].ValU16() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data16();
        break;
      case 4:
        jvm->imReg[0].ValU32() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data32();
        break;
      case 8:
        jvm->imReg[0].ValU64() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data64();
        break;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_EA::D2SYS_EA(EA_2ARGS)
{
  uint32 x = ((uint8*)jvm->instPtr)[1];
  if (x<VM::IM0)
    jvm->op[0].any = eaTable[x](jvm,s1);
  else
  {
    switch(s1)
    {
      case 1:
        jvm->imReg[0].ValU8() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data8();
        break;
      case 2:
        jvm->imReg[0].ValU16() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data16();
        break;
      case 4:
        jvm->imReg[0].ValU32() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data32();
        break;
      case 8:
        jvm->imReg[0].ValU64() = x-VM::IM0;
        jvm->op[0].any = jvm->imReg[0].Data64();
        break;
    }
  }

  x = ((uint8*)jvm->instPtr)[0];
  if (x<VM::IM0)
    jvm->op[1].any = eaTable[x](jvm,s2);
  else
  {
    switch(s2)
    {
      case 1:
        jvm->imReg[1].ValU8() = x-VM::IM0;
        jvm->op[1].any = jvm->imReg[1].Data8();
        break;
      case 2:
        jvm->imReg[1].ValU16() = x-VM::IM0;
        jvm->op[1].any = jvm->imReg[1].Data16();
        break;
      case 4:
        jvm->imReg[1].ValU32() = x-VM::IM0;
        jvm->op[1].any = jvm->imReg[1].Data32();
        break;
      case 8:
        jvm->imReg[1].ValU64() = x-VM::IM0;
        jvm->op[1].any = jvm->imReg[1].Data64();
        break;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS(OP_ARGS)
{
  fflush(0);
  sysTable[((uint8*)jvm->instPtr)[2]](jvm);
  jvm->instPtr++;
}

#endif // #if (X_ENDIAN == XA_BIGENDIAN)

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_OUT_U8(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,1);
  printf("%c", *jvm->op[0].u8);
}

void JASMINE_OP::fSYS_OUT_U16(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,2);
  printf("%hu", *jvm->op[0].u16);
}

void JASMINE_OP::fSYS_OUT_U32(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  printf("%lu", *jvm->op[0].u32);
}

void JASMINE_OP::fSYS_OUT_U64(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,8);
  printf("0x%08X%08X",(jvm->op[0].u32)[0],(jvm->op[0].u32)[1]);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_OUT_S8(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,1);
  printf("%c", *jvm->op[0].s8);
}

void JASMINE_OP::fSYS_OUT_S16(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,2);
  printf("%hi", *jvm->op[0].s16);
}

void JASMINE_OP::fSYS_OUT_S32(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  printf("%li", *jvm->op[0].s32);
}

void JASMINE_OP::fSYS_OUT_S64(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,8);
  printf("0x%08X%08X",(jvm->op[0].u32)[0],(jvm->op[0].u32)[1]);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_OUT_F32(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  printf("%.6G", *jvm->op[0].f32);
}

void JASMINE_OP::fSYS_OUT_F64(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,8);
  printf("%.10G", *jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_OUT_STR(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,1);
  printf("%s", jvm->op[0].ch);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_INP_U8(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,1);
  scanf("%c", jvm->op[0].u8);
}

void JASMINE_OP::fSYS_INP_U16(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,2);
  scanf("%hu", jvm->op[0].u16);
}

void JASMINE_OP::fSYS_INP_U32(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  scanf("%lu", jvm->op[0].u32);
}

void JASMINE_OP::fSYS_INP_U64(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,8);
  scanf("%lu", &(jvm->op[0].u32)[1]);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_INP_S8(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,1);
  scanf("%c", jvm->op[0].s8);
}

void JASMINE_OP::fSYS_INP_S16(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,2);
  scanf("%hi", jvm->op[0].s16);
}

void JASMINE_OP::fSYS_INP_S32(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  scanf("%li", jvm->op[0].s32);
}

void JASMINE_OP::fSYS_INP_S64(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,8);
  scanf("%li", &(jvm->op[0].s32)[1]);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_INP_F32(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  scanf("%f", jvm->op[0].f32);
}

void JASMINE_OP::fSYS_INP_F64(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,8);
  scanf("%lf", jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_INP_STR(OP_ARGS)
{
  JASMINE_EA::D2SYS_EA(jvm,4,1);
  fflush(stdout);
  fgets((char*)(jvm->op[1].u8),*jvm->op[0].s32, stdin);
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_BRK(OP_ARGS)
{
  //puts("Kiss my chuddies, man!");
}

void JASMINE_OP::fSYS_DUMP(OP_ARGS)
{
  #ifdef JASMINE_DEBUG_ENABLE
  puts("                 ______________________");
  puts("  ______________/ VMCORE Register Dump \\______________");
  for (sint32 i=0; i<32; i+=2)
    printf("  r%-2d: 0x%08X:%08X    r%-2d: 0x%08X:%08X\n",
          i, jvm->gpRegs[i].MSW(), jvm->gpRegs[i].LSW(),
          i+1, jvm->gpRegs[i+1].MSW(), jvm->gpRegs[i+1].LSW() );
  printf("  i%-2d: 0x%08X:%08X    i%-2d: 0x%08X:%08X\n", 0,
          jvm->imReg[0].MSW(), jvm->imReg[0].LSW(),      1,
          jvm->imReg[1].MSW(), jvm->imReg[1].LSW());

  printf("  PC  : %-5dMS  : %-5dRS   : %-5dDS  : %d\n",
          jvm->GetPC(), (jvm->methodStack-jvm->methodStackBase),
          (jvm->regStack-jvm->regStackBase),
          (jvm->stack-jvm->stackBase) );
  printf("  Code: %-5dData: %-5dConst: %-5d\n",
          jvm->vmObject->CodeSize(), jvm->vmObject->DataSize(), jvm->vmObject->CnstSize());
  puts("  ____________________________________________________\n");
  #endif
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_VER(OP_ARGS)
{
  puts("eXtropia JASMINE version 1");
}

#if (X_ENDIAN == XA_BIGENDIAN)

void JASMINE_OP::fSYS_NEW_X8(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU8() = new uint8[*jvm->op[0].s32];
}

void JASMINE_OP::fSYS_NEW_X16(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU16() = new uint16[*jvm->op[0].s32];
}

void JASMINE_OP::fSYS_NEW_X32(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU32() = new uint32[*jvm->op[0].s32];
}

void JASMINE_OP::fSYS_NEW_X64(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU64() = new uint64[*jvm->op[0].s32];
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_DEL_X8(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU8();
}

void JASMINE_OP::fSYS_DEL_X16(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU16();
}

void JASMINE_OP::fSYS_DEL_X32(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU32();
}

void JASMINE_OP::fSYS_DEL_X64(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU64();
}

/////////////////////////////////////////////////////////////////////////////////////


void JASMINE_OP::fSYS_NEWS_X8(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  //jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU8() = new uint8[*jvm->op[0].s32];
}

void JASMINE_OP::fSYS_NEWS_X16(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  //jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU16() = new uint16[*jvm->op[0].s32];
}

void JASMINE_OP::fSYS_NEWS_X32(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  //jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU32() = new uint32[*jvm->op[0].s32];
}

void JASMINE_OP::fSYS_NEWS_X64(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  //jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU64() = new uint64[*jvm->op[0].s32];
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_DELS_X8(OP_ARGS)
{
  //delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU8();
}

void JASMINE_OP::fSYS_DELS_X16(OP_ARGS)
{
  //delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU16();
}

void JASMINE_OP::fSYS_DELS_X32(OP_ARGS)
{
  //delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU32();
}

void JASMINE_OP::fSYS_DELS_X64(OP_ARGS)
{
  //delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].PtrU64();
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #if (X_ENDIAN == XA_BIGENDIAN)

void JASMINE_OP::fSYS_NEW_X8(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].PtrU8() = new uint8[*jvm->op[0].s32];
}

void JASMINE_OP::fSYS_NEW_X16(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].PtrU16() = new uint16[*jvm->op[0].s32];
}

void JASMINE_OP::fSYS_NEW_X32(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].PtrU32() = new uint32[*jvm->op[0].s32];
}

void JASMINE_OP::fSYS_NEW_X64(OP_ARGS)
{
  JASMINE_EA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].PtrU64() = new uint64[*jvm->op[0].s32];
}

/////////////////////////////////////////////////////////////////////////////////////

void JASMINE_OP::fSYS_DEL_X8(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].PtrU8();
}

void JASMINE_OP::fSYS_DEL_X16(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].PtrU16();
}

void JASMINE_OP::fSYS_DEL_X32(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].PtrU32();
}

void JASMINE_OP::fSYS_DEL_X64(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].PtrU64();
}


#endif // #if (X_ENDIAN == XA_BIGENDIAN)

/////////////////////////////////////////////////////////////////////////////////////
