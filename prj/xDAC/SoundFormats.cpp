//****************************************************************************//
//** File:         prj/xDAC/SoundFormats.cpp ($NAME=SoundFormats.cpp)       **//
//** Description:  PCM derived sound class implementations                  **//
//** Comment(s):                                                            **//
//** Created:      2002-01-20                                               **//
//** Updated:      2002-02-21                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include "SoundFormats.hpp"

#include <math.h>

// Double<->IEEE extended (c) 1988-1991 Apple Computer, Inc
// Hopefully these are machine independent
//
// Does anybody know what possessed the AIFF designers to use 80-bit real for frequency?

#define COMMSIZE 18
#define SSNDSIZE 8

#define U2F(u) (((float64)((sint32)(u - 2147483647L - 1))) + 2147483648.0)

sint32  AIFF::DecodeFreq(void* data)
{
  uint8* bytes = (uint8*)data;

  float64 f;
  sint32  expnt   = (((*bytes++) & 0x7F)<<8) | ((*bytes++) & 0xFF);
  uint32  hiMant  = ((uint32)((*bytes++) & 0xFF)<<24)
                  | ((uint32)((*bytes++) & 0xFF)<<16)
                  | ((uint32)((*bytes++) & 0xFF)<<8)
                  | ((uint32)((*bytes++) & 0xFF));
  uint32  loMant  = ((uint32)((*bytes++) & 0xFF)<<24)
                  | ((uint32)((*bytes++) & 0xFF)<<16)
                  | ((uint32)((*bytes++) & 0xFF)<<8)
                  | ((uint32)((*bytes) & 0xFF));

  if ((!expnt) && (!hiMant) && (!loMant))
    f = 0;
  else
  {
    if (expnt == 0x7FFF)
      f = HUGE_VAL;
    else
    {
      expnt -= 16383;
      f =   ldexp(U2F(hiMant), expnt-=31);
      f +=  ldexp(U2F(loMant), expnt-=32);
    }
  }
  return (sint32)(Clamp(f, 4410.0, 64000.0));
}

///////////////////////////////////////////////////////////////////////////////////////

#define F2U(f) ((uint32)(((sint32)(f - 2147483648.0)) + 2147483647L + 1))

void  AIFF::EncodeFreq(void* data, sint32 f)
{
  if (f==0)
  {
    MEM::Zero(data,10);
    return;
  }
  else
  { // freq never outside range 4410 - 64000, so don't need to do
    // sign, denomalized or extrema testing
    float64 frq     = (float64)f;
    int     expnt   = 0;
    float64 fMant   = frexp(frq, &expnt);
    expnt           += 16383;
    fMant           = ldexp(fMant, 32);
    float64 fsMant  = floor(fMant);
    uint32  hiMant  = F2U(fsMant);
    fMant           = ldexp(fMant - fsMant, 32);
    fsMant          = floor(fMant);
    uint32  loMant  = F2U(fsMant);
    sint8*  bytes   = (sint8*)data;

    *bytes++ = (expnt >> 8)   & 0x000000FF;
    *bytes++ = (expnt)        & 0x000000FF;
    *bytes++ = (hiMant >> 24) & 0x000000FF;
    *bytes++ = (hiMant >> 16) & 0x000000FF;
    *bytes++ = (hiMant >> 8)  & 0x000000FF;
    *bytes++ = (hiMant)       & 0x000000FF;
    *bytes++ = (loMant >> 24) & 0x000000FF;
    *bytes++ = (loMant >> 16) & 0x000000FF;
    *bytes++ = (loMant >> 8)  & 0x000000FF;
    *bytes   = (loMant)       & 0x000000FF;
  }
}

///////////////////////////////////////////////////////////////////////////////////////

sint32 AIFF::Load(const char* name)
{
  xFILEIO source(name, xIOS::READ);
  if (!source.Valid())
    return ERR_FILE_OPEN;

  // FORM chunk
  char chunkName[4];
  uint32 totalSize;
  if ( (source.Read8(chunkName, 4)!=4)  ||  (strncmp(chunkName, "FORM", 4)!=0)  ||  (READBIG32(source,&totalSize,1)!=1) || \
       (source.Read8(chunkName, 4)!=4)  ||  (strncmp(chunkName, "AIFF", 4)!=0) )
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Load() : couldn't read FORM header\n";
    #endif
    return ERR_FILE_READ;
  }

  // COMM chunk
  uint32  chunkSize;
  uint32  samples;
  uint16  chan;
  uint16  bitsPerSample;
  uint8   freq[10];
  if ( (source.Read8(chunkName, 4)!=4)  ||  (strncmp(chunkName, "COMM", 4)!=0)  ||  (READBIG32(source,&chunkSize,1)!=1) || \
       (chunkSize!=COMMSIZE)            ||  (READBIG16(source,&chan,1)!=1)      ||  (READBIG32(source,&samples,1)!=1)   || \
       (READBIG16(source,&bitsPerSample,1)!=1) || (source.Read8(freq, 10)!=10) )
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Load() : couldn't read COMM chunk\n";
    #endif
    return ERR_FILE_READ;
  }
  if (bitsPerSample!=16)
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Load() : Only 16-bit AIFF supported\n";
    #endif
    return ERR_FILE_READ;
  }
  sint32 frq = DecodeFreq(freq);

  // SSND chunk
  uint32 offset;
  uint32 blockSize;
  if ( (source.Read8(chunkName, 4)!=4)  ||  (strncmp(chunkName, "SSND", 4)!=0)  ||  (READBIG32(source,&chunkSize,1)!=1) ||  \
       (READBIG32(source,&offset,1)!=1) ||  (READBIG32(source,&blockSize,1)!=1) )
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Load() : couldn't find SSND chunk\n";
    #endif
    return ERR_FILE_READ;
  }
  if (blockSize)
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Load() : Non-zero SSND blockSize\n";
    #endif
    return ERR_FILE_READ;
  }
  if (offset)
    source.Seek(offset, xIOS::CURRENT);
  if (Data())
    Delete();

  if (New(samples, chan, frq)!=OK || !Data())
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Load() : [PCM::New()] Not enough memory\n";
    #endif
    return ERR_NO_FREE_STORE;
  }
  if (READBIG16(source, Data(), Size())!=Size())
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Load() : Read an unexpected amount of data\n";
    #endif
  }
  return OK;
}

///////////////////////////////////////////////////////////////////////////////////////

#define AIFFHEADSIZE (8+18+8+12) // COMM head + COMM body + SSND head + SSND body

sint32 AIFF::Save(const char* name)
{
  if (!Data())
    return ERR_PTR_ZERO;
  xFILEIO dest(name, xIOS::WRITE);
  if (!dest.Valid())
    return ERR_FILE_OPEN;

  // FORM chunk
  uint32 chunkSize = AIFFHEADSIZE + Size()*sizeof(sint16);
  if ( (dest.Write8("FORM",4)!=4) ||  (WRITEBIG32(dest,&chunkSize,1)!=1)  ||  (dest.Write8("AIFF",4)!=4) )
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Save() : unable to write FORM chunk\n";
    #endif
    return ERR_FILE_WRITE;
  }

  // COMM chunk
  chunkSize         = COMMSIZE;
  uint32 samples    = Length();
  uint16 chan       = Channels();
  uint16 bits       = 16;
  uint8  freq[10];  EncodeFreq(freq, Frequency());
  if ( (dest.Write8("COMM",4)!=4) ||  (WRITEBIG32(dest,&chunkSize,1)!=1)  ||  (WRITEBIG16(dest,&chan,1)!=1) || \
       (WRITEBIG32(dest,&samples,1)!=1) ||  (WRITEBIG16(dest,&bits,1)!=1) ||  (dest.Write8(freq,10)!=10) )
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Save() : unable to write COMM chunk\n";
    #endif
    return ERR_FILE_WRITE;
  }

  // SSND chunk
  chunkSize       = SSNDSIZE + Size()*sizeof(sint16);
  uint32 dummy[2] = {0};
  if ( (dest.Write8("SSND",4)!=4) ||  (WRITEBIG32(dest,&chunkSize,1)!=1) || (WRITEBIG32(dest,dummy,2)!=2) )
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Save() : unable to write SSND chunk\n";
    #endif
    return ERR_FILE_WRITE;
  }
  if (WRITEBIG16(dest,Data(),Size())!=Size())
  {
    #ifdef X_VERBOSE
    cerr << "AIFF::Save() : wrote unexpected amount of data\n";
    #endif
  }
  return OK;
}