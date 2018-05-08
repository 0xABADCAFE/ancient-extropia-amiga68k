//****************************************************************************//
//** File:         MemMove.cpp ($NAME=MemMove.cpp)                          **//
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

void MEM::Copy(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t len)
{
  if (!len || dst == src)
    return;
  if ( ((uint32)dst|(uint32)src) & 3UL )
  { // source and destination misaligned wrt one another, fall back on exec's CopyMem() function
    CopyMem(src, dst, len);
    return;
  }
  if (len > 3)
  {
    /*
      int count = len/sizeof(uint32)
      int loop = (count+15)/16;
      switch (count%16)
    */
    rsint32 loop = (len+60)>>6; // each loop copies 64 bytes as 16 32-bit words [nb : 60 == 15<<2]
    switch ((len>>2) & 15)      // each operation copies 4 bytes
    {
      case 0: do  { *((uint32*)dst)++ = *((uint32*)src)++;
      case 15:      *((uint32*)dst)++ = *((uint32*)src)++;
      case 14:      *((uint32*)dst)++ = *((uint32*)src)++;
      case 13:      *((uint32*)dst)++ = *((uint32*)src)++;
      case 12:      *((uint32*)dst)++ = *((uint32*)src)++;
      case 11:      *((uint32*)dst)++ = *((uint32*)src)++;
      case 10:      *((uint32*)dst)++ = *((uint32*)src)++;
      case 9:       *((uint32*)dst)++ = *((uint32*)src)++;
      case 8:       *((uint32*)dst)++ = *((uint32*)src)++;
      case 7:       *((uint32*)dst)++ = *((uint32*)src)++;
      case 6:       *((uint32*)dst)++ = *((uint32*)src)++;
      case 5:       *((uint32*)dst)++ = *((uint32*)src)++;
      case 4:       *((uint32*)dst)++ = *((uint32*)src)++;
      case 3:       *((uint32*)dst)++ = *((uint32*)src)++;
      case 2:       *((uint32*)dst)++ = *((uint32*)src)++;
      case 1:       *((uint32*)dst)++ = *((uint32*)src)++;
              } while (--loop);
    }
  }
  switch (len & 3)
  { // copy any trailing bytes
    case 3: *((uint8*)dst)++ = *((uint8*)src)++;
    case 2: *((uint8*)dst)++ = *((uint8*)src)++;
    case 1: *((uint8*)dst)++ = *((uint8*)src)++;
    case 0:
  }
}




void MEM::Zero(REGP(0) void* dst, REGI(0) size_t len)
{
  if (!len) return;
  if (len>3)
  { // check starting alignment
    sint32 start = ((uint32)dst & 3UL);
    if (start)
    {
      len -= (4+start);
      switch(start)
      {
        case 1: *((uint8*)dst)++ = 0;
        case 2: *((uint8*)dst)++ = 0;
        case 3: *((uint8*)dst)++ = 0;
      }
    }
    // After start alignment overall len may now be less than 3
    if (len>3)
    {
    /*
      int count = len/sizeof(uint32)
      int loop = (count+15)/16;
      switch (count%16)
    */
      rsint32 loop = (len+60)>>6; // each loop clears 64 bytes
      switch ((len>>2) & 15)      // each operation clears 4-bytes
      {
        case 0: do  { *((uint32*)dst)++ = 0;
        case 15:      *((uint32*)dst)++ = 0;
        case 14:      *((uint32*)dst)++ = 0;
        case 13:      *((uint32*)dst)++ = 0;
        case 12:      *((uint32*)dst)++ = 0;
        case 11:      *((uint32*)dst)++ = 0;
        case 10:      *((uint32*)dst)++ = 0;
        case 9:       *((uint32*)dst)++ = 0;
        case 8:       *((uint32*)dst)++ = 0;
        case 7:       *((uint32*)dst)++ = 0;
        case 6:       *((uint32*)dst)++ = 0;
        case 5:       *((uint32*)dst)++ = 0;
        case 4:       *((uint32*)dst)++ = 0;
        case 3:       *((uint32*)dst)++ = 0;
        case 2:       *((uint32*)dst)++ = 0;
        case 1:       *((uint32*)dst)++ = 0;
              } while (--loop);
      }
    }
  }
  switch (len&3)
  {
    case 3: *((uint8*)dst)++ = 0;
    case 2: *((uint8*)dst)++ = 0;
    case 1: *((uint8*)dst)++ = 0;
    case 0:
  }
}


void MEM::Set(REGP(0) void* dst, REGI(0) int c, REGI(1) size_t len)
{
  if (!len) return;
  if (len>3)
  { // check starting alignment
    sint32 start = ((uint32)dst & 3UL);
    if (start)
    {
      len -= (4+start);
      switch(start)
      {
        case 1: *((uint8*)dst)++ = c;
        case 2: *((uint8*)dst)++ = c;
        case 3: *((uint8*)dst)++ = c;
      }
    }
    // After start alignment overall len may now be less than 3
    if (len>3)
    {
    /*
      int count = len/sizeof(uint32)
      int loop = (count+15)/16;
      switch (count%16)
    */
      ruint32 v = c<<24|c<<16|c<<8|c;
      rsint32 loop = (len+60)>>6; // each loop writes 64 bytes
      switch ((len>>2) & 15)      // each operation writes 4 bytes
      {
        case 0: do  { *((uint32*)dst)++ = v;
        case 15:      *((uint32*)dst)++ = v;
        case 14:      *((uint32*)dst)++ = v;
        case 13:      *((uint32*)dst)++ = v;
        case 12:      *((uint32*)dst)++ = v;
        case 11:      *((uint32*)dst)++ = v;
        case 10:      *((uint32*)dst)++ = v;
        case 9:       *((uint32*)dst)++ = v;
        case 8:       *((uint32*)dst)++ = v;
        case 7:       *((uint32*)dst)++ = v;
        case 6:       *((uint32*)dst)++ = v;
        case 5:       *((uint32*)dst)++ = v;
        case 4:       *((uint32*)dst)++ = v;
        case 3:       *((uint32*)dst)++ = v;
        case 2:       *((uint32*)dst)++ = v;
        case 1:       *((uint32*)dst)++ = v;
              } while (--loop>0);
      }
    }
  }
  switch (len&3)
  {
    case 3: *((uint8*)dst)++ = c;
    case 2: *((uint8*)dst)++ = c;
    case 1: *((uint8*)dst)++ = c;
    case 0:
  }
}

void MEM::Set16(REGP(0) void* dst, REGI(0) uint16 c, REGI(1) size_t cnt)
{
  if (!cnt || ((uint32)dst & 1UL) ) return;
  if (cnt>1)
  { // check starting alignment
    if ((uint32)dst & 2UL)
    {
      *((uint16*)dst)++ = c;
      --cnt;
    }
    // after start alignment,
    if (cnt>1)
    {
    /*
      int count = (2*cnt)/sizeof(uint32)
      int loop = (count+15)/16;
      switch (count%16)
    */
      ruint32 v = c<<16|c;
      rsint32 loop = (cnt+30)>>5; // each loop writes 32 16-bit words
      switch ((cnt>>1) & 15)      // each operation writes 2 16-bit words
      {
        case 0: do  { *((uint32*)dst)++ = v;
        case 15:      *((uint32*)dst)++ = v;
        case 14:      *((uint32*)dst)++ = v;
        case 13:      *((uint32*)dst)++ = v;
        case 12:      *((uint32*)dst)++ = v;
        case 11:      *((uint32*)dst)++ = v;
        case 10:      *((uint32*)dst)++ = v;
        case 9:       *((uint32*)dst)++ = v;
        case 8:       *((uint32*)dst)++ = v;
        case 7:       *((uint32*)dst)++ = v;
        case 6:       *((uint32*)dst)++ = v;
        case 5:       *((uint32*)dst)++ = v;
        case 4:       *((uint32*)dst)++ = v;
        case 3:       *((uint32*)dst)++ = v;
        case 2:       *((uint32*)dst)++ = v;
        case 1:       *((uint32*)dst)++ = v;
              } while (--loop);
      }
    }
  }
  if (cnt & 1UL)
  {
    *((uint16*)dst) = c;
  }
}

void MEM::Set32(REGP(0) void* dst, REGI(0) uint32 c, REGI(1) size_t cnt)
{
  if (!cnt || ((uint32)dst & 1UL) ) return;
/*
  int loop = (cnt+15)/16;
  switch (cnt%16)
*/
  rsint32 loop = (cnt+15)>>4; // each full loop writes 16 32-bit words
  switch (cnt & 15)           // each individual writes operation moves 1 32-bit word
  {
    case 0: do  { *((uint32*)dst)++ = c;
    case 15:      *((uint32*)dst)++ = c;
    case 14:      *((uint32*)dst)++ = c;
    case 13:      *((uint32*)dst)++ = c;
    case 12:      *((uint32*)dst)++ = c;
    case 11:      *((uint32*)dst)++ = c;
    case 10:      *((uint32*)dst)++ = c;
    case 9:       *((uint32*)dst)++ = c;
    case 8:       *((uint32*)dst)++ = c;
    case 7:       *((uint32*)dst)++ = c;
    case 6:       *((uint32*)dst)++ = c;
    case 5:       *((uint32*)dst)++ = c;
    case 4:       *((uint32*)dst)++ = c;
    case 3:       *((uint32*)dst)++ = c;
    case 2:       *((uint32*)dst)++ = c;
    case 1:       *((uint32*)dst)++ = c;
            } while (--loop);
  }
}

void MEM::Set64(REGP(0) void* dst, REGP(1) uint64& c, REGI(0) size_t cnt)
{
  if (!cnt || ((uint32)dst & 1UL) ) return;
/*
  int loop = (cnt+7)/8;
  switch (cnt%8)
*/
  ruint32 x1 = ((uint32*)&c)[0];
  ruint32 x2 = ((uint32*)&c)[1];
  rsint32 loop = (cnt+7)>>3;    // each full loop moves 8 64-bit words
  switch (cnt & 7)              // each individual move operation moves 2 32-bit words
  {
    case 0: do  { *((uint32*)dst)++ = x1;
                  *((uint32*)dst)++ = x2;
    case 7:       *((uint32*)dst)++ = x1;
                  *((uint32*)dst)++ = x2;
    case 6:       *((uint32*)dst)++ = x1;
                  *((uint32*)dst)++ = x2;
    case 5:       *((uint32*)dst)++ = x1;
                  *((uint32*)dst)++ = x2;
    case 4:       *((uint32*)dst)++ = x1;
                  *((uint32*)dst)++ = x2;
    case 3:       *((uint32*)dst)++ = x1;
                  *((uint32*)dst)++ = x2;
    case 2:       *((uint32*)dst)++ = x1;
                  *((uint32*)dst)++ = x2;
    case 1:       *((uint32*)dst)++ = x1;
                  *((uint32*)dst)++ = x2;
            } while (--loop);
  }
}