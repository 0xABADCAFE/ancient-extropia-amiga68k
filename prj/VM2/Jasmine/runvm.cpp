//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xBase.hpp>
#include <xSystem/ServiceLib.hpp>

#include "Jasmine.hpp"

//char* GetCLIParm(int argc, char** argv, const char* arg);

int main(int argc, char** argv)
{
  if (xBASELIB::Init()!=OK)
  {
    puts("Error initializing base library");
    return 10;
  }

  if (argc != 2)
  {
    puts("Usage : jasmine <object file>");
    xBASELIB::Done();
    return 5;
  }

  JASMINE test;
  XSFBASIC objFile("VMCODE", 1, 0, (XA_ALIGN32|X_ENDIAN|X_NEGATIVE), (0));
  objFile.Open(argv[1]);
  if (objFile.Valid())
  {
    JASMINEOBJECT program;
    if (program.Read(objFile) > 0)
    {
      printf("Loaded program '%s'\n", argv[1]);
      program.ListMethods();
      //xTIMER t;
      test.Execute(program);
      //sint32 dif = t.Elapsed();
      //printf("Execution took %ld ms\n", dif);
    }
    else
      printf("Unable to execute '%s'\n", argv[1]);
    objFile.Close();
  }
  else
    printf("Unable to open '%s'\n", argv[1]);


  xBASELIB::Done();
  return 0;
}

/*
char* GetCLIParm(int argc, char** argv, const char* arg)
{
  for (int i=0; i<argc; i++)
  {
    if (0 == stricmp(argv[i], arg))
      if (++i<argc)
        return argv[i];
  }
  return 0;
}
*/