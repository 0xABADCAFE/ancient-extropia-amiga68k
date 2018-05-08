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

#include "VM_ObjectCode.hpp"

static char str1[] = "Please enter a number : ";
static char str2[] = "Factorial is : ";
static char str3[] = "VM program to generate factorials\nPlease enter your name : ";
static char str4[] = "Hello ";

static char progName[] = "Demo Program";

static uint32 instTable[] = {

  VM::MOVE_X32<<24  | VM::LITERAL<<16   | VM::R1<<8,  (64),
  VM::SYS<<24       | VM::NEW_X8<<16    | VM::R1<<8 | VM::R0,
  VM::SYS<<24       | VM::OUT_STR<<16   | VM::CDS<<8, (sizeof(str1)+sizeof(str2)),
  VM::SYS<<24       | VM::INP_STR<<16   | VM::R1<<8 | VM::IR0,
  VM::SYS<<24       | VM::OUT_STR<<16   | VM::CDS<<8, (sizeof(str1)+sizeof(str2)+sizeof(str3)),
  VM::SYS<<24       | VM::OUT_STR<<16   | VM::IR0<<8,
  VM::SYS<<24       | VM::OUT_U8<<16    | VM::LITERAL<<8, ('\n'),
  VM::SYS<<24       | VM::DEL_X8<<16    | VM::R0<<8,


  VM::SYS<<24       | VM::OUT_STR<<16   | VM::CDS<<8, (0),
  VM::SYS<<24       | VM::INP_S32<<16   | VM::R0<<8,

  VM::PUSH_X32<<24  | VM::R0<<16,
  VM::CALL<<24      | VM::OFFSET_PC<<16,  (8), // call factorial()
  VM::POP_X32<<24   | VM::R0<<16,
  VM::SYS<<24       | VM::OUT_STR<<16   | VM::CDS<<8, (sizeof(str1)),
  VM::SYS<<24       | VM::OUT_S32<<16   | VM::R0<<8,
  VM::SYS<<24       | VM::OUT_U8<<16    | VM::LITERAL<<8, ('\n'),
  VM::END<<24,

  // factorial (n)
  VM::PUSHREGS<<24  | VM::R0<<16      | VM::R1<<8,                // save local
  VM::POP_X32<<24   | VM::R0<<16,                                 // get n
  VM::BLS_I32<<24   | VM::IM0<<16     | VM::R0<<8, (4),
  VM::PUSH_X32<<24  | VM::IM1<<16,
  VM::BRA<<24, (10),

  VM::BGR_I32<<24   | VM::IM2<<16       | VM::R0<<8,  (7),

  VM::SUB_I32<<24   | VM::R0<<16        | VM::IM1<<8  | VM::R1,   // n-1
  VM::PUSH_X32<<24  | VM::R1<<16,
  VM::CALL<<24      | VM::OFFSET_PC<<16,  (-12),                    // recurse
  VM::POP_X32<<24   | VM::R1<<16,
  VM::MUL_I32<<24   | VM::R0<<16        | VM::R1<<8   | VM::R0,

  // return n
  VM::PUSH_X32<<24  | VM::R0<<16,
  VM::POPREGS<<24   | VM::R0<<16        | VM::R1<<8,
  VM::RET<<24

};


#define STRSIZE (sizeof(str1)+sizeof(str2)+sizeof(str3)+sizeof(str4))
#define CODESIZE (sizeof(instTable)/sizeof(uint32))
#define STACKSIZE 4096
#define METHDSIZE 512
#define RGSTKSIZE 512

int main(int argc, char** argv)
{
  if (xBASELIB::Init()!=OK)
  {
    cerr << "Error initializing base library\n";
    return 10;
  }

  if (argc != 2)
  {
    cout << "Usage : genvm <object file>\n";
    xBASELIB::Done();
    return 5;
  }

  VMOBJ program;
  program.Create(progName, 1, 0, CODESIZE,STACKSIZE,METHDSIZE,RGSTKSIZE, 0,0,0,0, 0,0,0, STRSIZE);

  uint32* p = program.Code();
  uint32* t = instTable;

  sint32 i = 1+CODESIZE;
  while(--i)
    *p++ = *t++;

  char* c = (char*)program.Cnst();
  strcpy(c, str1);
  c+=sizeof(str1);
  strcpy(c, str2);
  c+=sizeof(str2);
  strcpy(c, str3);
  c+=sizeof(str3);
  strcpy(c, str4);

  XSFBASIC objFile(VMOBJ::XSFFileSig, VMOBJ::XSFSuperClass, VMOBJ::XSFSubClass, VMOBJ::XSFDataFormat, VMOBJ::XSFFileFormat);
  objFile.Create(argv[1]);
  if (objFile.Valid())
  {
    program.Write(objFile);
    objFile.Close();
    cout << "Wrote VM program '" <<argv[1]<<"'\n";
  }
  xBASELIB::Done();
  return 0;
}