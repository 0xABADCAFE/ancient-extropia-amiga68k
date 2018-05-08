//*****************************************************************// 
//** Description:   extropia IO classes                          **// 
//**                Win32 implementation                         **// 
//** First Started: 2000-12-24                                   **// 
//** Last Updated:  2001-03-21                                   **// 
//** Author         C++ OOP version Karl Churchill               **// 
//** Copyright:     (C)1998-2001, eXtropia Studios               **// 
//**                Serkan YAZICI, Karl Churchill                **// 
//**                All Rights Reserved.                         **// 
//**                Original ASYNCIO C code (C) 1999 Amiga Inc.  **// 
//*****************************************************************// 
 
#ifndef _XSYSTEM_IO_HPP 
#error You must only include the <xSystem/xIO.hpp> stub 
#endif 
 
#ifndef _XSYSTEM_XAFILEIOWIN32_HPP 
#define _XSYSTEM_XAFILEIOWIN32_HPP 
 
#include <stdio.h> 
 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
// 
//  xINPUT : User input interface 
// 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
#define XMOUSE_LEFT 1 
#define XMOUSE_CENTRE 2 
#define XMOUSE_RIGHT 4 
 
class xINPUT { 
  protected: 
    uint32  inputMask; 
 
    // Derived class must override this 
    virtual void    ApplyInputModification() = 0; 
 
  public: 
    // input properties 
    enum { 
      IKEYBOARD       = 0x00000001, // respond to keyboard 
      IMOUSELEFT      = 0x00000002, // respond to left mouse 
      IMOUSECENTRE    = 0x00000004, // respond to centre mouse 
      IMOUSERIGHT     = 0x00000008, // respond to right mouse 
      IMOUSEKEYMOVE   = 0x00000010, // respond to mouse movements whilst left/centre/right button active 
      IMOUSEIDLEMOVE  = 0x00000020, // respond to mouse movements whilst no buttons active (idle) 
      IMOUSENOCLIP    = 0x00000040, // respond to mouse movements outside the display area (windowed displays) 
      ICLOSE          = 0x00000080, // respond to close gadget (if present) 
      IMOUSEMOVE      = IMOUSEKEYMOVE|IMOUSEIDLEMOVE, 
      IMOUSEKEYS      = IMOUSELEFT|IMOUSECENTRE|IMOUSERIGHT, 
      IDEFAULT        = IKEYBOARD|IMOUSEKEYS|ICLOSE 
    }; 
    uint32        InputMask()         { return inputMask; } 
    uint32        SetInput(uint32 f)  { uint32 m = inputMask; inputMask |= f; ApplyInputModification(); return m; } 
    uint32        ClrInput(uint32 f)  { uint32 m = inputMask; inputMask &= ~f; ApplyInputModification(); return m; } 
 
    // Derived class must override these 
    virtual void  MouseEvent(sint32 x, sint32 y, sint32 buttons) = 0; 
    virtual void  KeyEvent(sint32 keyCode, bool state) = 0; 
    virtual void  ExitEvent() = 0; 
 
    // Wait mechanism that returns when an event occurs 
    virtual void  Idle() = 0; 
    virtual bool  InputQueued() = 0; // Returns true whilst input messages are waiting. 
  public: 
    xINPUT() : inputMask(IDEFAULT) {} 
    ~xINPUT() { } 
}; 
 
 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
// 
//  xFILEIO 
// 
//  Karl : This version wraps a C FILE* pointer and as such should be portable 
//  Reccomeneded to use whatever high speed IO provided by OS libraries for this 
// 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
 
class xIOS { 
 
  public: 
    enum { 
      OPEN_READ   = 0x00000001, 
      OPEN_WRITE  = 0x00000002, 
      OPEN_APPEND = 0x00000004, 
      OPEN_EXIST  = 0x00000005, 
      OPEN_ANY    = 0x00000007, 
      WAIT_PACKET = 0x00000008, 
      FILE_END    = 0x00000010, 
      FILE_START  = 0x00000020, 
      FILE_GOOD   = 0x00000040, 
      BUFF_ERROR  = 0x00010000 
    }; 
    enum { 
      READ        = 0x0000001, 
      WRITE       = 0x0000002, 
      APPEND      = 0x0000004, 
      READTEXT    = 0x0000008, 
      WRITETEXT   = 0x0000010, 
      APPENDTEXT  = 0x0000020 
    }; 
    enum { 
      START       = SEEK_SET, 
      CURRENT     = SEEK_CUR, 
      END         = SEEK_END 
    }; 
}; 
 
 
#define XFILEIO_EBUFSIZE 256 
 
class xFILEIO : public xIOS { 
  private: 
    FILE            *fp; 
    static  uint32  endianBuffer[XFILEIO_EBUFSIZE]; 
     
  public: 
    static  bool Exists(char*name)                                                            { FILE*t=fopen(name,"rb"); if(t) { fclose(t); return 1; } return 0; } 
    sint32  Open(const char* fileName, sint32 mode, sint32 bufferSize=1024); 
    sint32  OpenText(const char* fileName, sint32 mode = READTEXT, sint32 bufferSize=1024)    { return Open(fileName, mode, bufferSize); } 
    sint32  Create(const char* fileName, sint32 mode = WRITE, sint32 bufferSize=1024)         { return Open(fileName, mode, bufferSize); } 
    sint32  CreateText(const char* fileName, sint32 mode = WRITETEXT, sint32 bufferSize=1024) { return Open(fileName, mode, bufferSize); } 
    bool    Valid()                                                                           { return (fp!=0); } 
    bool    EndOfFile()                                                                       { return feof(fp); } 
    bool    StartOfFile()                                                                     { return (ftell(fp)==0); } 
    sint32  Seek(sint32 pos, sint32 mode)                                                     { if(fp) { fseek(fp, pos, mode); return OK; } else return ERR_FILE_SEEK; } 
    sint32  Tell()                                                                            { if(fp) return ftell(fp); else return ERR_FILE; } 
    sint32  Size()                                                                            { if (fp) { long s=Tell(); Seek(0,END); long r=Tell(); Seek(s,START); return r; } else return ERR_FILE; } 
    sint32  GetChar()                                                                         { return fgetc(fp); } 
    sint32  PutChar(uint8 ch)                                                                 { fputc((int)ch, fp); return 1; } 
    sint32  Read(void* buffer, size_t s, size_t n)                                            { return fread(buffer,s,n,fp); } 
    sint32  Read8(void* d,size_t n)                                                           { return Read(d,1,n); } 
    sint32  Read16(void* d,size_t n)                                                          { return Read(d,2,n); } 
    sint32  Read32(void* d,size_t n)                                                          { return Read(d,4,n); } 
    sint32  Read64(void* d,size_t n)                                                          { return Read(d,8,n); } 
    sint32  Read16Swap(void* d,size_t n); 
    sint32  Read32Swap(void* d,size_t n); 
    sint32  Read64Swap(void* d,size_t n); 
    sint32  ReadText(char*buf, sint32 max, char mark=0, sint32 num=-1); // read until max chars or 'mark' occured num times 
    sint32  Write(void*d,size_t sz,size_t n)                                                  { return fwrite(d,sz,n,fp); }    
    sint32  Write8(void* d,size_t n)                                                          { return Write(d,1,n); } 
    sint32  Write16(void* d,size_t n)                                                         { return Write(d,2,n); } 
    sint32  Write32(void* d,size_t n)                                                         { return Write(d,4,n); } 
    sint32  Write64(void* d,size_t n)                                                         { return Write(d,8,n); } 
    sint32  Write16Swap(void* d,size_t n); 
    sint32  Write32Swap(void* d,size_t n); 
    sint32  Write64Swap(void* d,size_t n); 
    sint32  WriteText(char* format,...)                                                       { va_list a; va_start(a,format); sint32 n = vfprintf(fp,format,a); va_end(a); return n; } 
    sint32  Flush()                                                                           { if (fp) { fflush(fp); return OK; } else return ERR_FILE_WRITE; } 
    sint32  Close()                                                                           { if (fp) fclose(fp); fp=0; return OK; } 
 
  public: 
    xFILEIO() : fp(0) {} 
    xFILEIO(const char* fileName, sint32 mode, sint32 bufferSize=1024) : fp(0) { Open(fileName, mode, bufferSize); } 
    ~xFILEIO()  { Close(); } 
}; 
 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
#endif 
