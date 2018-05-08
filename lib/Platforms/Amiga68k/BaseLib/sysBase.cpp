//****************************************************************************//
//** File:         sysBase.cpp ($NAME=sysBase.cpp)                          **//
//** Description:  eXtropia Library Base API Source                         **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      Base                                                     **//
//** Created:      2001-02-20                                               **//
//** Updated:      2001-02-26                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2001, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


#include <xBase.hpp>

//// CLASS sysBASELIB ////////////////////////////////////////////////////////

INTUITIONBASE *IntuitionBase  = 0;
void*         sysBASELIB::sysData       = 0;
char*         sysBASELIB::msgbuff       = 0;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 sysBASELIB::Init()
{
  // Open OS intuition library so we can use messageboxes and stuff
  IntuitionBase = (INTUITIONBASE*)OpenLibrary("intuition.library", 40);
  if (IntuitionBase == 0)
    return ERR_RSC_UNAVAILABLE;

  // allocate runtime system data heap. This is one single block of memory allocated at startup and freed
  // at exit. It is used to hold blocks of data used by the system libraries, amongst other things
  // Currently this comprises of a continous block of memory containing MEM::allocated and sysBASELIB::msgbuff

  sysData = AllocVec((MAXALLOCS*sizeof(MEMINFO))+MESSAGEBUFFSIZE, MEMF_PUBLIC|MEMF_CLEAR);
  if (sysData == 0)
  {
    CloseLibrary((LIBRARY*)IntuitionBase);
    return ERR_NO_FREE_STORE;
  }

  MEM::allocated = (MEMINFO*)sysData;
  msgbuff = (char*)((uint32)sysData+(MAXALLOCS*sizeof(MEMINFO)));

  #ifdef X_VERBOSE
  cout.setf(ios::unitbuf);
  cerr << "sysBASELIB Debug build : " __DATE__ " at " __TIME__ "\n";

  #ifdef SMALL_DATA_A4
  cerr << "Small Data Model [base a4/r2]\n";
  #endif

  #endif
  return OK;  //SUCCESS
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void sysBASELIB::Done()
{
  MEM::FreeAll();
  if (sysData)
  {
    FreeVec(sysData);
    sysData = 0;    msgbuff = 0;
  }
  if (IntuitionBase)
    CloseLibrary((LIBRARY*)IntuitionBase);
  IntuitionBase = 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 sysBASELIB::MessageBox(char* title, char* opts, char* body,...)
{
  va_list arglist;
  va_start(arglist,body);
  vsprintf(msgbuff,body,arglist);
  va_end(arglist);
  EasyStruct mb = {sizeof(EasyStruct),0,title, msgbuff, opts};
  return EasyRequest(0, &mb, 0, arglist);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void sysBASELIB::OpenDebugFile(char *name)
{
  sprintf(msgbuff,"Run >NIL: %s \"%s\" ", xFILE_VIEWER_APP, name);
  RunAsyncProgram(msgbuff);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
