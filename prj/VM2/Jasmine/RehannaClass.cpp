//****************************************************************************//
//**                                                                        **//
//**  File:          JasmineJIT68K.cpp ($NAME=JasmineJIT68K.cpp)            **//
//**                                                                        **//
//**  Description:   JASMINE Just In Time Compiler Implementation           **//
//**  Comment(s):    MC68020+/68882 implementation                          **//
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

#include "Rehanna.hpp"

sint32 JASM68K::TranslateFunc(J68K_ARGS)
{
  // Translate a single vm function
  return 0;
}


sint32 REHANNA::Create(sint32 size, sint32 maxF)
{
  if (codeHeap || funcList)
    return ERR_RSC_LOCKED;
  size = Clamp(size, 4096, 4194304);
  maxF = Clamp(maxF, 1, 4096);

  codeHeap = MEM::Alloc(size);
  funcList = (TRANSLATED*)MEM::Alloc(maxF*sizeof(TRANSLATED));

  if ((!codeHeap) || (!funcList))
  {
    Delete();
    return ERR_NO_FREE_STORE;
  }
  codeSize = size;
  codeUsed = 0;
  funcSize = maxF;
  funcUsed = 0;
  return OK;
}

void REHANNA::Delete()
{
  if (codeHeap)
  {
    CPU::FlushInstCache(codeHeap);
    MEM::Free(codeHeap);
  }
  if (funcList)
    MEM::Free(funcList);
  codeHeap = 0;
  codeSize = 0;
  codeUsed = 0;
  funcList = 0;
  funcSize = 0;
  funcUsed = 0;
}

int main(int argc, char** argv)
{
  if (xBASELIB::Init(argc, argv)!=OK)
  {
    puts("Error initializing base library");
    return 10;
  }

  if (argc != 2)
  {
    puts("Usage : rehanna <object file>");
    xBASELIB::Done();
    return 5;
  }

  printf("File : %s\n", argv[1]);

  xBASELIB::Done();
  return 0;
}
