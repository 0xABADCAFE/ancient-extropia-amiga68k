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

// compile then modify asm generated to do byteswap and once thats done, include as .s or .o

// register based byteswap
// 16 bit : rotate by 8 bits left or right
// 32 bit : rotate lower 16 bit word by 8, swap 16 bit word, rotate lower 16 bit word by 8
// 64 bit : if 32 but regs, use 2 regs, perform above 32 bit and write in reverse order to dest

// If possible, try to cache only the destination values, since these are what we need
/*
void MEM::Swap16(REGP(0) uint16* s, REGP(1) uint16* d, REGI(0) size_t n)
{
  if ( ((uint32)s|(uint32)d) & 3UL)
  {
    // 16 bit copy loop
    do {
      ruint16 r = *(s++);
      // your byteswap here
      *(d++) = r;
    } while(--n);
  }
  else
  {
    // 32 bit copy loop, AABBCCDD -> BBAADDCC
    if (n&1UL)
      *(d+n-1) = *(((uint8*)(s+n-1))+1)<<8 | *((uint8*)(s+n-1));
    n >>= 1;
    do {
      ruint32 r = *((uint32*)s++);
      // your byteswap here
      *((uint32*)d++) = r;
    } while(--n);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

void MEM::Swap32(REGP(0) uint32* s, REGP(1) uint32* d, REGI(0) size_t n)
{
  do {
    ruint32 r = *(s++);
    // your byte swap here
    *(d++) = r;
  } while(--n);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

void MEM::Swap64(REGP(0) uint64* s, REGP(1) uint64* d, REGI(0) size_t n)
{
  do {
    ruint32 r1 = *((uint32*)s++);
    ruint32 r2 = *((uint32*)s++);

    // your byteswap here

    *((uint32*)d++) = r2;
    *((uint32*)d++) = r1;
  } while(--n);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
*/


void MEM::Swap16(REGP(0) uint16* from, REGP(1) uint16* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  if (count > 1)
  {
    rsint32 n = count>>5;     // each full loop moves 32 16-bit words as 16*4
    switch ((count>>1) & 15)        // each individual move operation moves 2 16-bit words
    {
      // replace copy with byteswap in asm
      case 0: do {  *((uint32*)to)++ = *((uint32*)from)++;
      case 15:      *((uint32*)to)++ = *((uint32*)from)++;
      case 14:      *((uint32*)to)++ = *((uint32*)from)++;
      case 13:      *((uint32*)to)++ = *((uint32*)from)++;
      case 12:      *((uint32*)to)++ = *((uint32*)from)++;
      case 11:      *((uint32*)to)++ = *((uint32*)from)++;
      case 10:      *((uint32*)to)++ = *((uint32*)from)++;
      case 9:       *((uint32*)to)++ = *((uint32*)from)++;
      case 8:       *((uint32*)to)++ = *((uint32*)from)++;
      case 7:       *((uint32*)to)++ = *((uint32*)from)++;
      case 6:       *((uint32*)to)++ = *((uint32*)from)++;
      case 5:       *((uint32*)to)++ = *((uint32*)from)++;
      case 4:       *((uint32*)to)++ = *((uint32*)from)++;
      case 3:       *((uint32*)to)++ = *((uint32*)from)++;
      case 2:       *((uint32*)to)++ = *((uint32*)from)++;
      case 1:       *((uint32*)to)++ = *((uint32*)from)++;
              } while (--n > 0);
    }
  }
  // replace copy with byteswap in asm
  if (count & 1)
    *((uint16*)to)++ = *((uint16*)from)++;
}



void MEM::Swap32(REGP(0) uint32* from, REGP(1) uint32* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  rsint32 n = count>>4;     // each full loop moves 16 32-bit words
  switch (count & 15)       // each individual move operation moves 1 32-bit word
  {
    // replace copy with byteswap in asm
    case 0: do  { *((uint32*)to)++ = *((uint32*)from)++;
    case 15:      *((uint32*)to)++ = *((uint32*)from)++;
    case 14:      *((uint32*)to)++ = *((uint32*)from)++;
    case 13:      *((uint32*)to)++ = *((uint32*)from)++;
    case 12:      *((uint32*)to)++ = *((uint32*)from)++;
    case 11:      *((uint32*)to)++ = *((uint32*)from)++;
    case 10:      *((uint32*)to)++ = *((uint32*)from)++;
    case 9:       *((uint32*)to)++ = *((uint32*)from)++;
    case 8:       *((uint32*)to)++ = *((uint32*)from)++;
    case 7:       *((uint32*)to)++ = *((uint32*)from)++;
    case 6:       *((uint32*)to)++ = *((uint32*)from)++;
    case 5:       *((uint32*)to)++ = *((uint32*)from)++;
    case 4:       *((uint32*)to)++ = *((uint32*)from)++;
    case 3:       *((uint32*)to)++ = *((uint32*)from)++;
    case 2:       *((uint32*)to)++ = *((uint32*)from)++;
    case 1:       *((uint32*)to)++ = *((uint32*)from)++;
            } while (--n > 0);
  }
}

void MEM::Swap64(REGP(0) uint64* from, REGP(1) uint64* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  rsint32 n = count>>3;   // each full loop moves 8 64-bit words
  switch (count & 7)      // each individual move operation moves 2 32-bit words
  {
    // replace copy with byteswap in asm
    case 0: do  { *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 7:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 6:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 5:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 4:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 3:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 2:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 1:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
            } while (--n > 0);
  }
}


void MEM::Copy8(REGP(0) uint8* from, REGP(1) uint8* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  // handle misaligned source/dest
  if (((uint32)from|(uint32)to) & 1)
  {
    CopyMem(from, to, count);
    return;
  }
  if (count > 3)
  {
    rsint32 n = count>>6;     // each full loop moves 64 bytes as 16*4
    switch ((count>>2) & 15)  // each individual move operation moves 4 bytes
    {
      case 0: do  { *((uint32*)to)++ = *((uint32*)from)++;
      case 15:      *((uint32*)to)++ = *((uint32*)from)++;
      case 14:      *((uint32*)to)++ = *((uint32*)from)++;
      case 13:      *((uint32*)to)++ = *((uint32*)from)++;
      case 12:      *((uint32*)to)++ = *((uint32*)from)++;
      case 11:      *((uint32*)to)++ = *((uint32*)from)++;
      case 10:      *((uint32*)to)++ = *((uint32*)from)++;
      case 9:       *((uint32*)to)++ = *((uint32*)from)++;
      case 8:       *((uint32*)to)++ = *((uint32*)from)++;
      case 7:       *((uint32*)to)++ = *((uint32*)from)++;
      case 6:       *((uint32*)to)++ = *((uint32*)from)++;
      case 5:       *((uint32*)to)++ = *((uint32*)from)++;
      case 4:       *((uint32*)to)++ = *((uint32*)from)++;
      case 3:       *((uint32*)to)++ = *((uint32*)from)++;
      case 2:       *((uint32*)to)++ = *((uint32*)from)++;
      case 1:       *((uint32*)to)++ = *((uint32*)from)++;
              } while (--n > 0);
    }
  }
  switch (count & 3)        // move trailing 1-3 bytes
  {
    case 3: *to++ = *from++;
    case 2: *to++ = *from++;
    case 1: *to++ = *from++;
    case 0:
  }
}

void MEM::Copy16(REGP(0) uint16* from, REGP(1) uint16* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  if (count > 1)
  {
    rsint32 n = count>>5;       // each full loop moves 32 16-bit words as 16*4
    switch ((count>>1) & 15)    // each individual move operation moves 2 16-bit words
    {
      case 0: do {  *((uint32*)to)++ = *((uint32*)from)++;
      case 15:      *((uint32*)to)++ = *((uint32*)from)++;
      case 14:      *((uint32*)to)++ = *((uint32*)from)++;
      case 13:      *((uint32*)to)++ = *((uint32*)from)++;
      case 12:      *((uint32*)to)++ = *((uint32*)from)++;
      case 11:      *((uint32*)to)++ = *((uint32*)from)++;
      case 10:      *((uint32*)to)++ = *((uint32*)from)++;
      case 9:       *((uint32*)to)++ = *((uint32*)from)++;
      case 8:       *((uint32*)to)++ = *((uint32*)from)++;
      case 7:       *((uint32*)to)++ = *((uint32*)from)++;
      case 6:       *((uint32*)to)++ = *((uint32*)from)++;
      case 5:       *((uint32*)to)++ = *((uint32*)from)++;
      case 4:       *((uint32*)to)++ = *((uint32*)from)++;
      case 3:       *((uint32*)to)++ = *((uint32*)from)++;
      case 2:       *((uint32*)to)++ = *((uint32*)from)++;
      case 1:       *((uint32*)to)++ = *((uint32*)from)++;
              } while (--n > 0);
    }
  }
  if (count & 1)
    *((uint16*)to)++ = *((uint16*)from)++;
}

void MEM::Copy32(REGP(0) uint32* from, REGP(1) uint32* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  rsint32 n = count>>4;     // each full loop moves 16 32-bit words
  switch (count & 15)       // each individual move operation moves 1 32-bit word
  {
    case 0: do  { *((uint32*)to)++ = *((uint32*)from)++;
    case 15:      *((uint32*)to)++ = *((uint32*)from)++;
    case 14:      *((uint32*)to)++ = *((uint32*)from)++;
    case 13:      *((uint32*)to)++ = *((uint32*)from)++;
    case 12:      *((uint32*)to)++ = *((uint32*)from)++;
    case 11:      *((uint32*)to)++ = *((uint32*)from)++;
    case 10:      *((uint32*)to)++ = *((uint32*)from)++;
    case 9:       *((uint32*)to)++ = *((uint32*)from)++;
    case 8:       *((uint32*)to)++ = *((uint32*)from)++;
    case 7:       *((uint32*)to)++ = *((uint32*)from)++;
    case 6:       *((uint32*)to)++ = *((uint32*)from)++;
    case 5:       *((uint32*)to)++ = *((uint32*)from)++;
    case 4:       *((uint32*)to)++ = *((uint32*)from)++;
    case 3:       *((uint32*)to)++ = *((uint32*)from)++;
    case 2:       *((uint32*)to)++ = *((uint32*)from)++;
    case 1:       *((uint32*)to)++ = *((uint32*)from)++;
            } while (--n > 0);
  }
}

void MEM::Copy64(REGP(0) uint64* from, REGP(1) uint64* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  rsint32 n = count>>3;   // each full loop moves 8 64-bit words
  switch (count & 7)      // each individual move operation moves 2 32-bit words
  {
    case 0: do  { *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 7:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 6:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 5:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 4:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 3:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 2:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
    case 1:       *((uint32*)to)++ = *((uint32*)from)++;
                  *((uint32*)to)++ = *((uint32*)from)++;
            } while (--n > 0);
  }
}

void MEM::Zero8(REGP(0) uint8* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  if ((uint32)to & 1)
  {
    MEM::Zero(to, count);
    return;
  }
  if (count > 3)
  {
    rsint32 n = count>>6;     // each full loop moves 64 bytes as 16*4
    switch ((count>>2) & 15)  // each individual move operation moves 4 bytes
    {
      case 0: do  { *((uint32*)to)++ = 0;
      case 15:      *((uint32*)to)++ = 0;
      case 14:      *((uint32*)to)++ = 0;
      case 13:      *((uint32*)to)++ = 0;
      case 12:      *((uint32*)to)++ = 0;
      case 11:      *((uint32*)to)++ = 0;
      case 10:      *((uint32*)to)++ = 0;
      case 9:       *((uint32*)to)++ = 0;
      case 8:       *((uint32*)to)++ = 0;
      case 7:       *((uint32*)to)++ = 0;
      case 6:       *((uint32*)to)++ = 0;
      case 5:       *((uint32*)to)++ = 0;
      case 4:       *((uint32*)to)++ = 0;
      case 3:       *((uint32*)to)++ = 0;
      case 2:       *((uint32*)to)++ = 0;
      case 1:       *((uint32*)to)++ = 0;
              } while (--n > 0);
    }
  }
  switch (count & 3)        // move trailing 1-3 bytes
  {
    case 3: *to++ = 0;
    case 2: *to++ = 0;
    case 1: *to++ = 0;
    case 0:
  }
}

void MEM::Zero16(REGP(0) uint16* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  if (count > 1)
  {
    rsint32 n = count>>5;     // each full loop moves 32 16-bit words as 16*4
    switch ((count>>1) & 15)        // each individual move operation moves 2 16-bit words
    {
      case 0: do {  *((uint32*)to)++ = 0;
      case 15:      *((uint32*)to)++ = 0;
      case 14:      *((uint32*)to)++ = 0;
      case 13:      *((uint32*)to)++ = 0;
      case 12:      *((uint32*)to)++ = 0;
      case 11:      *((uint32*)to)++ = 0;
      case 10:      *((uint32*)to)++ = 0;
      case 9:       *((uint32*)to)++ = 0;
      case 8:       *((uint32*)to)++ = 0;
      case 7:       *((uint32*)to)++ = 0;
      case 6:       *((uint32*)to)++ = 0;
      case 5:       *((uint32*)to)++ = 0;
      case 4:       *((uint32*)to)++ = 0;
      case 3:       *((uint32*)to)++ = 0;
      case 2:       *((uint32*)to)++ = 0;
      case 1:       *((uint32*)to)++ = 0;
              } while (--n > 0);
    }
  }
  if (count & 1)
    *((uint16*)to)++ = 0;
}

void MEM::Zero32(REGP(0) uint32* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  rsint32 n = count>>4;     // each full loop moves 16 32-bit words
  switch (count & 15)       // each individual move operation moves 1 32-bit word
  {
    case 0: do  { *((uint32*)to)++ = 0;
    case 15:      *((uint32*)to)++ = 0;
    case 14:      *((uint32*)to)++ = 0;
    case 13:      *((uint32*)to)++ = 0;
    case 12:      *((uint32*)to)++ = 0;
    case 11:      *((uint32*)to)++ = 0;
    case 10:      *((uint32*)to)++ = 0;
    case 9:       *((uint32*)to)++ = 0;
    case 8:       *((uint32*)to)++ = 0;
    case 7:       *((uint32*)to)++ = 0;
    case 6:       *((uint32*)to)++ = 0;
    case 5:       *((uint32*)to)++ = 0;
    case 4:       *((uint32*)to)++ = 0;
    case 3:       *((uint32*)to)++ = 0;
    case 2:       *((uint32*)to)++ = 0;
    case 1:       *((uint32*)to)++ = 0;
            } while (--n > 0);
  }
}

void MEM::Zero64(REGP(0) uint64* to, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  rsint32 n = count>>3;   // each full loop moves 8 64-bit words
  switch (count & 7)      // each individual move operation moves 2 32-bit words
  {
    case 0: do  { *((uint32*)to)++ = 0;
                  *((uint32*)to)++ = 0;
    case 7:       *((uint32*)to)++ = 0;
                  *((uint32*)to)++ = 0;
    case 6:       *((uint32*)to)++ = 0;
                  *((uint32*)to)++ = 0;
    case 5:       *((uint32*)to)++ = 0;
                  *((uint32*)to)++ = 0;
    case 4:       *((uint32*)to)++ = 0;
                  *((uint32*)to)++ = 0;
    case 3:       *((uint32*)to)++ = 0;
                  *((uint32*)to)++ = 0;
    case 2:       *((uint32*)to)++ = 0;
                  *((uint32*)to)++ = 0;
    case 1:       *((uint32*)to)++ = 0;
                  *((uint32*)to)++ = 0;
            } while (--n > 0);
  }
}

void MEM::Set8(REGP(0) uint8* to, REGI(0) uint8 val, REGI(1) size_t count)
{
  if ((uint32)to & 1)
  {
    MEM::Set(to, val, count);
    return;
  }
  if (count > 3)
  {
    ruint32 x = val<<24 | val<<16 | val<<8 | val;
    rsint32 n = count>>6;     // each full loop moves 64 bytes as 16*4
    switch ((count>>2) & 15)  // each individual move operation moves 4 bytes
    {
      case 0: do  { *((uint32*)to)++ = x;
      case 15:      *((uint32*)to)++ = x;
      case 14:      *((uint32*)to)++ = x;
      case 13:      *((uint32*)to)++ = x;
      case 12:      *((uint32*)to)++ = x;
      case 11:      *((uint32*)to)++ = x;
      case 10:      *((uint32*)to)++ = x;
      case 9:       *((uint32*)to)++ = x;
      case 8:       *((uint32*)to)++ = x;
      case 7:       *((uint32*)to)++ = x;
      case 6:       *((uint32*)to)++ = x;
      case 5:       *((uint32*)to)++ = x;
      case 4:       *((uint32*)to)++ = x;
      case 3:       *((uint32*)to)++ = x;
      case 2:       *((uint32*)to)++ = x;
      case 1:       *((uint32*)to)++ = x;
              } while (--n > 0);
    }
  }
  switch (count & 3)        // move trailing 1-3 bytes
  {
    case 3: *to++ = val;
    case 2: *to++ = val;
    case 1: *to++ = val;
    case 0:
  }
}

void MEM::Set16(REGP(0) uint16* to, REGI(0) uint16 val, REGI(1) size_t count)
{
  if (count <= 0)
    return;
  if (count > 1)
  {
    ruint32 x = val<<16 | val;
    rsint32 n = count>>5;     // each full loop moves 32 16-bit words as 16*4
    switch ((count>>1) & 15)        // each individual move operation moves 2 16-bit words
    {
      case 0: do {  *((uint32*)to)++ = x;
      case 15:      *((uint32*)to)++ = x;
      case 14:      *((uint32*)to)++ = x;
      case 13:      *((uint32*)to)++ = x;
      case 12:      *((uint32*)to)++ = x;
      case 11:      *((uint32*)to)++ = x;
      case 10:      *((uint32*)to)++ = x;
      case 9:       *((uint32*)to)++ = x;
      case 8:       *((uint32*)to)++ = x;
      case 7:       *((uint32*)to)++ = x;
      case 6:       *((uint32*)to)++ = x;
      case 5:       *((uint32*)to)++ = x;
      case 4:       *((uint32*)to)++ = x;
      case 3:       *((uint32*)to)++ = x;
      case 2:       *((uint32*)to)++ = x;
      case 1:       *((uint32*)to)++ = x;
              } while (--n > 0);
    }
  }
  if (count & 1)
    *((uint16*)to)++ = val;
}

void MEM::Set32(REGP(0) uint32* to, REGI(0) uint32 val, REGI(1) size_t count)
{
  if (count <= 0)
    return;
  rsint32 n = count>>4;     // each full loop moves 16 32-bit words
  switch (count & 15)       // each individual move operation moves 1 32-bit word
  {
    case 0: do  { *((uint32*)to)++ = val;
    case 15:      *((uint32*)to)++ = val;
    case 14:      *((uint32*)to)++ = val;
    case 13:      *((uint32*)to)++ = val;
    case 12:      *((uint32*)to)++ = val;
    case 11:      *((uint32*)to)++ = val;
    case 10:      *((uint32*)to)++ = val;
    case 9:       *((uint32*)to)++ = val;
    case 8:       *((uint32*)to)++ = val;
    case 7:       *((uint32*)to)++ = val;
    case 6:       *((uint32*)to)++ = val;
    case 5:       *((uint32*)to)++ = val;
    case 4:       *((uint32*)to)++ = val;
    case 3:       *((uint32*)to)++ = val;
    case 2:       *((uint32*)to)++ = val;
    case 1:       *((uint32*)to)++ = val;
            } while (--n > 0);
  }
}

void MEM::Set64(REGP(0) uint64* to, REGP(1) uint64& val, REGI(0) size_t count)
{
  if (count <= 0)
    return;
  ruint32 x1 = ((uint32*)&val)[0];
  ruint32 x2 = ((uint32*)&val)[1];
  rsint32 n = count>>3;   // each full loop moves 8 64-bit words
  switch (count & 7)      // each individual move operation moves 2 32-bit words
  {
    case 0: do  { *((uint32*)to)++ = x1;
                  *((uint32*)to)++ = x2;
    case 7:       *((uint32*)to)++ = x1;
                  *((uint32*)to)++ = x2;
    case 6:       *((uint32*)to)++ = x1;
                  *((uint32*)to)++ = x2;
    case 5:       *((uint32*)to)++ = x1;
                  *((uint32*)to)++ = x2;
    case 4:       *((uint32*)to)++ = x1;
                  *((uint32*)to)++ = x2;
    case 3:       *((uint32*)to)++ = x1;
                  *((uint32*)to)++ = x2;
    case 2:       *((uint32*)to)++ = x1;
                  *((uint32*)to)++ = x2;
    case 1:       *((uint32*)to)++ = x1;
                  *((uint32*)to)++ = x2;
            } while (--n > 0);
  }
}
