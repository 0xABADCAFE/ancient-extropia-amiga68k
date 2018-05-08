//*****************************************************************// 
//** Description:   extropia file IO class                       **// 
//**                ANSI level implementation                    **// 
//** First Started: 2000-12-24                                   **// 
//** Last Updated:  2001-03-21                                   **// 
//** Author         Serkan YAZICI, Karl Churchill                **// 
//** Copyright:     (C)1998-2001, eXtropia Studios               **// 
//**                Serkan YAZICI, Karl Churchill                **// 
//**                All Rights Reserved.                         **// 
//**                Original ASYNCIO C code (C) 1999 Amiga Inc.  **// 
//*****************************************************************// 
 
#include <xSystem/xIO.hpp> 
 
/* 
class xFILEIO { 
  FILE *fp; 
public: 
  xFILEIO() : fp(0)                        { } 
  char Open(char*name,char*mode="rb")     { return (fp=fopen(name,mode))==0; }  //NONZERO on Error 
  char Create(char*name,char*mode="wb")   { return (fp=fopen(name,mode))==0; }  //NONZERO on Error 
  char CreateText(char*name)              { return (fp=fopen(name,"wt"))==0; }  //NONZERO on Error 
  char OpenText(char*name)                { return (fp=fopen(name,"rt"))==0; }  //NONZERO on Error 
  static char Exists(char*name)           { FILE*t=fopen(name,"rb"); if(t) { fclose(t); return 1; } return 0; } 
  long Valid()                            { return fp!=0; } 
  void Seek(long off,int w=SEEK_SET)      { fseek(fp,off,w); } 
  long Tell()                             { return ftell(fp); } 
  long Size()                             { long s=Tell(); Seek(0,SEEK_END); long r=Tell(); Seek(s); return r; } 
  sint32 Read(void*d,size_t sz,size_t n)  { return fread(d,sz,n,fp); } 
  sint32 Read8 (void*d,size_t n)          { return Read(d,1,n); } 
  sint32 Read16(void*d,size_t n)          { return Read(d,2,n); } 
  sint32 Read32(void*d,size_t n)          { return Read(d,4,n); } 
  sint32 Read64(void*d,size_t n)          { return Read(d,8,n); } 
  sint32 Read16Swap(void*d,size_t n);     //Reads WORDs  [Endian Swapped] 
  sint32 Read32Swap(void*d,size_t n);     //Reads DWORDs [Endian Swapped] 
  sint32 Read64Swap(void*d,size_t n);     //Reads QWORDs [Endian Swapped] 
  sint32 Write(void*d,size_t sz,size_t n) { return fwrite(d,sz,n,fp); } 
  sint32 Write8 (void*d,size_t n)         { return Write(d,1,n); } 
  sint32 Write16(void*d,size_t n)         { return Write(d,2,n); } 
  sint32 Write32(void*d,size_t n)         { return Write(d,4,n); } 
  sint32 Write64(void*d,size_t n)         { return Write(d,8,n); } 
  sint32 Write16Swap(void*d,size_t n);    //Writes WORDs  [Endian Swapped] 
  sint32 Write32Swap(void*d,size_t n);    //Writes DWORDs [Endian Swapped] 
  sint32 Write64Swap(void*d,size_t n);    //Writes QWORDs [Endian Swapped] 
  void WriteText(char*format,...)         { va_list a; va_start(a,format); vfprintf(fp,format,a); va_end(a); } 
  char*ReadText(char*buf,int max)         { return fgets(buf,max,fp); } 
  bool EndOfFile()                        { return feof(fp); }                  //NONZERO if EOF Reached 
  void Flush()                            { fflush(fp); } 
  void Close()                            { if(fp) { fclose(fp); fp=0; } } 
  ~FILEIO()                               { Close(); } 
}; 
*/
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
uint32 xFILEIO::endianBuffer[XFILEIO_EBUFSIZE] = {0}; 
 
sint32 xFILEIO::ReadText(char* buf, sint32 max, char mark, sint32 num) 
{ 
  // Works by reading until either max chars read or 'mark' occured 'num' times. Handy for reading 
  // several lines, pass '\n' as mark and nbr of lines as num  
  if(!fp) 
    return ERR_FILE; 
  char* p = buf; 
  rsint32 i = max; 
  while (--i && num) 
  {  
    char c = fgetc(fp); 
    if (c==EOF) // terminate if error 
      break; 
    if (c==mark) 
      num--; 
    *p++ = c; 
  } 
  *p = 0; // null terminate 
  return (max-i); // return num chars read 
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
sint32 xFILEIO::Open(const char* fileName, sint32 mode, sint32 bufferSize) 
{ 
  switch (mode) { 
    case xIOS::READ: 
    fp = fopen(fileName, "rb"); 
    break; 
     
    case xIOS::WRITE: 
    fp = fopen(fileName, "wb"); 
    break; 
     
    case xIOS::APPEND: 
    fp = fopen(fileName, "wb"); 
    if (fp) 
      fseek(fp, 0, SEEK_END); 
    break; 
     
    case xIOS::READTEXT: 
    fp = fopen(fileName, "r"); 
    break; 
     
    case xIOS::WRITETEXT: 
    fp = fopen(fileName, "w"); 
    break; 
     
    case APPENDTEXT: 
    fp = fopen(fileName, "w"); 
    if (fp) 
      fseek(fp, 0, SEEK_END); 
 
    default: 
      return ERR_FILE_OPEN; 
      break; 
  } 
   
  if (fp) 
    return OK; 
  return ERR_FILE_OPEN; 
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
// 
//  Endian swapping block IO. These impose fairly strict alignment. For each, the buffer and file 
//  buffer alignment must be at least 16 bits 
// 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
sint32 xFILEIO::Read16Swap(void* buffer,size_t n) 
{ 
  if (((uint32)buffer)&1UL) 
    return ERR_PTR; 
  rsint32 i = n; 
  ruint16* d = (uint16*)buffer; 
  while (i>XFILEIO_EBUFSIZE*2) 
  { 
    Read16(endianBuffer,XFILEIO_EBUFSIZE*2); 
    MEM::Swap16((uint16*)endianBuffer, d, XFILEIO_EBUFSIZE*2); 
    i -= XFILEIO_EBUFSIZE*2; 
    d += XFILEIO_EBUFSIZE*2; 
  } 
  if (i>0) 
  { 
    Read16(endianBuffer,i); 
    MEM::Swap16((uint16*)endianBuffer, d, i); 
  } 
  return n; 
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
sint32 xFILEIO::Read32Swap(void* buffer,size_t n) 
{ 
  if (((uint32)buffer)&1UL) 
    return ERR_PTR; 
  rsint32 i = n; 
  ruint32* d = (uint32*)buffer; 
  while (i>XFILEIO_EBUFSIZE) 
  { 
    Read32(endianBuffer,XFILEIO_EBUFSIZE); 
    MEM::Swap32(endianBuffer, d, XFILEIO_EBUFSIZE); 
    i -= XFILEIO_EBUFSIZE; 
    d += XFILEIO_EBUFSIZE; 
  } 
  if (i>0) 
  { 
    Read32(endianBuffer,i); 
    MEM::Swap32(endianBuffer, d, i); 
  } 
  return n;    
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
sint32 xFILEIO::Read64Swap(void* buffer,size_t n) 
{ 
  if (((uint32)buffer)&1UL) 
    return ERR_PTR; 
  ruint64* d = (uint64*)buffer; 
  rsint32 i = n; 
  while (i>XFILEIO_EBUFSIZE/2) 
  { 
    Read64(endianBuffer,XFILEIO_EBUFSIZE/2); 
    MEM::Swap64((uint64*)endianBuffer, d, XFILEIO_EBUFSIZE/2); 
    i -= XFILEIO_EBUFSIZE/2; 
    d += XFILEIO_EBUFSIZE/2; 
  } 
  if (i>0) 
  { 
    Read64(endianBuffer,i); 
    MEM::Swap64((uint64*)endianBuffer, d, i); 
  } 
  return n; 
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
sint32 xFILEIO::Write16Swap(void* buffer,size_t n) 
{ 
  if (((uint32)buffer)&1UL) 
    return ERR_PTR; 
  ruint16* s = (uint16*)buffer; 
  rsint32 i = n; 
  while (i>XFILEIO_EBUFSIZE*2) 
  { 
    MEM::Swap16(s, (uint16*)endianBuffer, XFILEIO_EBUFSIZE*2); 
    Write16(endianBuffer,XFILEIO_EBUFSIZE*2); 
    i -= XFILEIO_EBUFSIZE*2; 
    s += XFILEIO_EBUFSIZE*2; 
  } 
  if (i>0) 
  { 
    MEM::Swap16(s, (uint16*)endianBuffer, i); 
    Write16(endianBuffer,i); 
  } 
  return n; 
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
sint32 xFILEIO::Write32Swap(void* buffer,size_t n) 
{ 
  if (((uint32)buffer)&1UL) 
    return ERR_PTR; 
  rsint32 i = n; 
  ruint32* s = (uint32*)buffer; 
  while (i>XFILEIO_EBUFSIZE) 
  { 
    MEM::Swap32(s, endianBuffer, XFILEIO_EBUFSIZE); 
    Write32(endianBuffer,XFILEIO_EBUFSIZE); 
    i -= XFILEIO_EBUFSIZE; 
    s += XFILEIO_EBUFSIZE; 
  } 
  if (i>0) 
  { 
    MEM::Swap32(s, endianBuffer, i); 
    Write32(endianBuffer,i); 
  } 
  return n; 
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
sint32 xFILEIO::Write64Swap(void* buffer,size_t n) 
{ 
  if (((uint32)buffer)&1UL) 
    return ERR_PTR; 
  rsint32 i = n; 
  ruint64* s = (uint64*)buffer; 
  while (i>XFILEIO_EBUFSIZE/2) 
  { 
    MEM::Swap64(s, (uint64*)endianBuffer, XFILEIO_EBUFSIZE/2); 
    Write64(endianBuffer,XFILEIO_EBUFSIZE/2); 
    i -= XFILEIO_EBUFSIZE/2; 
    s += XFILEIO_EBUFSIZE/2; 
  } 
  if (i>0) 
  { 
    MEM::Swap64(s, (uint64*)endianBuffer, i); 
    Write64(endianBuffer,i); 
  } 
  return n; 
} 
