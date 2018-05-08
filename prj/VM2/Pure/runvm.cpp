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
#include <xSystem/xResources.hpp>

#include "VM_Class.hpp"

//char* GetCLIParm(int argc, char** argv, const char* arg);

int main(int argc, char** argv)
{
  if (xBASELIB::Init()!=OK)
  {
    cerr << "Error initializing base library\n";
    return 10;
  }
  if (argc != 2)
  {
    cout << "Usage : runvm <object file>\n";
    xBASELIB::Done();
    return 5;
  }

  VMCORE test;
  XSFBASIC objFile("VMCODE", 1, 0, (XA_ALIGN32|X_ENDIAN|X_NEGATIVE), (0));
  objFile.Open(argv[1]);
  if (objFile.Valid())
  {
    VMOBJ program;
    if (program.Read(objFile) > 0)
    {
      cout << "Loaded program '" << argv[1] << "'\n";
      //xTIMER t;
      test.Execute(program);
      //sint32 dif = t.Elapsed();
      //cout << "Executed in " << dif << "ms\n";
    }
    else
      cout << "Unable to execute '" << argv[1] << "' !\n";
    objFile.Close();
  }
  else
    cout << "Unable to open '" << argv[1] << "' !\n";

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