//*****************************************************************//
//** Description:   xUtility library : Bit array class           **//
//** First Started: 2001-03-15                                   **//
//** Last Updated:  2001-03-15                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2000, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XUTILITY_BITARRAY_HPP
#define _XUTILITY_BITARRAY_HPP

#include <xBase.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  BITARRAY / BITARRAY_X (X= 16, 32, 64)
//
//    A simple utility class that allows the treatment of an arbitrary external array as a giant indexable
//  bitfield. The 16 and 32 types are optimised for arrays of objects that are multiples of 16 and 32 bit
//  sizes respectively. The standard type can be used for any data located at any alignment, but internal
//  operations are byte based so likely to be slower.
//
//
//  NOTE : YOU SHOULD NOT ASSIGN TWO DIFFERENT BITARRAY TYPES TO THE SAME DATA !!!!!
//
//    This is probably ok on little endian systems, but on big endian the bit numbering causes a fat load
//  of indexing errors - eg
//
//  uint32 b[2] = {0,0};
//  sint32 v;
//  BITARRAY_32 x(b);
//  BITARRAY    y(b); // x and y reference b[] internally using 32-bit and 8-bit modes
//
//  x.Set(0);     // OK
//  v = x.Bit(0); // OK v == 1
//  v = y.Bit(0); // ERROR v == 0 !!!
//
//  This is explained by the (big endian) representation of how each bitarray interprets the space it sees.
//
//  BITARRAY_32 x
//
//       b[1] :  00000000000000000000000000000000
//       bit# :  63                            32
//      byte# :  4       5       6       7
//
//       b[0] :  00000000000000000000000000000001 <- after x.Set(0)
//       bit# :  31                             0
//      byte# :  0       1       2       3
//
//  BITARRAY y
//
//       b[1] : 00000000 00000000 00000000 00000000
//       bit# : 39    32 47    40 55    48 63    56
//      byte# : 4        5        6        7
//
//       b[0] : 00000000 00000000 00000000 00000001 <- after x.Set(0)
//       bit# : 7      0 15     8 23    16 31    24
//      byte# : 0        1        2        3
//
//  As we can see, x.Bit(0) == y.Bit(24) ! So, pick a type and stick to it. Probably best off using 32 bit
//  else choose a size matching the size of the real array's type
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class BITARRAY {
  private:
    uint8* array;

  public:
    uint8 Bit(ruint32 n)  { return (array[(n>>3)] & (1<<(n&7))) != 0; }
    void  Set(ruint32 n)  { array[(n>>3)] |= (1<<(n&7)); }
    void  Set(ruint32 n, ruint32 l);
    void  Clr(ruint32 n)  { array[(n>>3)] &= ~(1<<(n&7)); }
    void  Clr(ruint32 n, ruint32 l);
    void  Attach(void* block)     { array = (uint8*)block; }
  #ifdef X_DEBUG
    void  Dump(ostream& out, uint32 s, uint32 l);
  #endif
  public:
    BITARRAY() : array(NOTSET)                    { }
    BITARRAY(void* block) : array((uint8*)block)  { }
    ~BITARRAY()                                   { }
};

class BITARRAY_16 {
  private:
    uint16* array;

  public:
    uint8 Bit(ruint32 n)  { return (array[(n>>4)] & (1<<(n&15))) != 0; }
    void  Set(ruint32 n)  { array[(n>>4)] |= (1<<(n&15)); }
    void  Set(ruint32 n, ruint32 l);
    void  Clr(ruint32 n)  { array[(n>>4)] &= ~(1<<(n&15)); }
    void  Clr(ruint32 n, ruint32 l);
    void  Attach(void* block)     { array = (uint16*)block; }
  #ifdef X_DEBUG
    void  Dump(ostream& out, uint32 s, uint32 l);
  #endif
    public:
    BITARRAY_16() : array(NOTSET)                     { }
    BITARRAY_16(void* block) : array((uint16*)block)  { }
    ~BITARRAY_16()                                    { }
};

class BITARRAY_32 {
  private:
    uint32* array;

  public:
    uint8 Bit(ruint32 n)  { return (array[(n>>5)] & (1<<(n&31))) != 0; }
    void  Set(ruint32 n)  { array[(n>>5)] |= (1<<(n&31)); }
    void  Set(ruint32 n, ruint32 l);
    void  Clr(ruint32 n)  { array[(n>>5)] &= ~(1<<(n&31)); }
    void  Clr(ruint32 n, ruint32 l);
    void  Attach(void* block)     { array = (uint32*)block; }
  #ifdef X_DEBUG
    void  Dump(ostream& out, uint32 s, uint32 l);
  #endif
  public:
    BITARRAY_32() : array(NOTSET)                     { }
    BITARRAY_32(void* block) : array((uint32*)block)  { }
    ~BITARRAY_32()                                    { }
};

class BITARRAY_64 {
  private:
    uint64* array;

  public:
    uint8 Bit(ruint32 n)  { return (array[(n>>6)] & (1<<(n&63))) != 0; }
    void  Set(ruint32 n)  { array[(n>>6)] |= (1<<(n&63)); }
    void  Set(ruint32 n, ruint32 l);
    void  Clr(ruint32 n)  { array[(n>>6)] &= ~(1<<(n&63)); }
    void  Clr(ruint32 n, ruint32 l);
    void  Attach(void* block)     { array = (uint64*)block; }
  #ifdef X_DEBUG
    void  Dump(ostream& out, uint32 s, uint32 l);
  #endif
  public:
    BITARRAY_64() : array(NOTSET)                     { }
    BITARRAY_64(void* block) : array((uint64*)block)  { }
    ~BITARRAY_64()                                    { }
};

inline void BITARRAY::Set(ruint32 n, ruint32 l)
{
  // block set
  if ((n>>3) == ((n+l)>>3))
  {
    // start and end are in same 8-bit block
    // generate mask for bits to set
    ruint8 mask = ~((1<<(n&7))-1);
    mask &= (1<<((n+l)&7))-1;
    array[(n>>3)] |= mask;
    return;
  }
  else
  {
    // start and end are in different 8-bit blocks
    {
      // generate masks for start and end
      ruint8 mask = ~((1<<(n&7))-1);
      array[(n>>3)] |= mask;
      mask = (1<<((n+l)&7))-1;
      array[((n+l)>>3)] |= mask;
    }
    // set inbetween 8-bit blocks directly
    rsint32 i = ((n+l)>>3)-1;
    while (i > (n>>3))
      array[i--] = 0xFF;
  }
}

inline void BITARRAY::Clr(ruint32 n, ruint32 l)
{
  // block clear
  if ((n>>3) == ((n+l)>>3))
  {
    // start and end are in same 16-bit block
    // generate mask for bits to clear
    ruint8 mask = ~((1<<(n&7))-1);
    mask &= (1<<((n+l)&7))-1;
    array[(n>>3)] &= ~mask;
    return;
  }
  else
  {
    // start and end are in different 16-bit blocks
    {
      // generate masks for start and end
      ruint8 mask = ~((1<<(n&7))-1);
      array[(n>>3)] &= ~mask;
      mask = (1<<((n+l)&7))-1;
      array[((n+l)>>3)] &= ~mask;
    }
    // clear inbetween 16-bit blocks directly
    rsint32 i = ((n+l)>>3)-1;
    while (i > (n>>3))
      array[i--] = 0;
  }
}

inline void BITARRAY_16::Set(ruint32 n, ruint32 l)
{
  // block set
  if ((n>>4) == ((n+l)>>4))
  {
    // start and end are in same 16-bit block
    // generate mask for bits to set
    ruint16 mask = ~((1<<(n&15))-1);
    mask &= (1<<((n+l)&15))-1;
    array[(n>>4)] |= mask;
    return;
  }
  else
  {
    // start and end are in different 16-bit blocks
    {
      // generate masks for start and end
      ruint16 mask = ~((1<<(n&15))-1);
      array[(n>>4)] |= mask;
      mask = (1<<((n+l)&15))-1;
      array[((n+l)>>4)] |= mask;
    }
    // set inbetween 16-bit blocks directly
    rsint32 i = ((n+l)>>4)-1;
    while (i > (n>>4))
      array[i--] = 0xFFFF;
  }
}

inline void BITARRAY_16::Clr(ruint32 n, ruint32 l)
{
  // block clear
  if ((n>>4) == ((n+l)>>4))
  {
    // start and end are in same 16-bit block
    // generate mask for bits to clear
    ruint16 mask = ~((1<<(n&15))-1);
    mask &= (1<<((n+l)&15))-1;
    array[(n>>4)] &= ~mask;
    return;
  }
  else
  {
    // start and end are in different 16-bit blocks
    {
      // generate masks for start and end
      ruint16 mask = ~((1<<(n&15))-1);
      array[(n>>4)] &= ~mask;
      mask = (1<<((n+l)&15))-1;
      array[((n+l)>>4)] &= ~mask;
    }
    // clear inbetween 16-bit blocks directly
    rsint32 i = ((n+l)>>4)-1;
    while (i > (n>>4))
      array[i--] = 0;
  }
}

inline void BITARRAY_32::Set(ruint32 n, ruint32 l)
{
  // block set
  if ((n>>5) == ((n+l)>>5))
  {
    // start and end are in same 32-bit block
    // generate mask for bits to set
    ruint32 mask = ~((1<<(n&31))-1);
    mask &= (1<<((n+l)&31))-1;
    array[(n>>5)] |= mask;
    return;
  }
  else
  {
    // start and end are in different 32-bit blocks
    {
      // generate masks for start and end
      ruint32 mask = ~((1<<(n&31))-1);
      array[(n>>5)] |= mask;
      mask = (1<<((n+l)&31))-1;
      array[((n+l)>>5)] |= mask;
    }
    // set inbetween 32-bit blocks directly
    rsint32 i = ((n+l)>>5)-1;
    while (i > (n>>5))
      array[i--] = 0xFFFFFFFF;
  }
}

inline void BITARRAY_32::Clr(ruint32 n, ruint32 l)
{
  // block clear
  if ((n>>5) == ((n+l)>>5))
  {
    // start and end are in same 32-bit block
    // generate mask for bits to clear
    ruint32 mask = ~((1<<(n&31))-1);
    mask &= (1<<((n+l)&31))-1;
    array[(n>>5)] &= ~mask;
    return;
  }
  else
  {
    // start and end are in different 32-bit blocks
    {
      // generate masks for start and end
      ruint32 mask = ~((1<<(n&31))-1);
      array[(n>>5)] &= ~mask;
      mask = (1<<((n+l)&31))-1;
      array[((n+l)>>5)] &= ~mask;
    }
    // clear inbetween 32-bit blocks directly
    rsint32 i = ((n+l)>>5)-1;
    while (i > (n>>5))
      array[i--] = 0;
  }
}

inline void BITARRAY_64::Set(ruint32 n, ruint32 l)
{
  // uses 32-bit for this implementation, 64-bit support a bit flaky

  ruint32* parray = (uint32*)array;

  // block set
  if ((n>>5) == ((n+l)>>5))
  {
    // start and end are in same 32-bit block
    // generate mask for bits to set
    ruint32 mask = ~((1<<(n&31))-1);
    mask &= (1<<((n+l)&31))-1;
    parray[(n>>5)] |= mask;
    return;
  }
  else
  {
    // start and end are in different 32-bit blocks
    {
      // generate masks for start and end
      ruint32 mask = ~((1<<(n&31))-1);
      parray[(n>>5)] |= mask;
      mask = (1<<((n+l)&31))-1;
      parray[((n+l)>>5)] |= mask;
    }
    // set inbetween 32-bit blocks directly
    rsint32 i = ((n+l)>>5)-1;
    while (i > (n>>5))
      parray[i--] = 0xFFFFFFFF;
  }
}

inline void BITARRAY_64::Clr(ruint32 n, ruint32 l)
{
  ruint32* parray = (uint32*)array;
  // block clear
  if ((n>>5) == ((n+l)>>5))
  {
    // start and end are in same 32-bit block
    // generate mask for bits to clear
    ruint32 mask = ~((1<<(n&31))-1);
    mask &= (1<<((n+l)&31))-1;
    parray[(n>>5)] &= ~mask;
    return;
  }
  else
  {
    // start and end are in different 32-bit blocks
    {
      // generate masks for start and end
      ruint32 mask = ~((1<<(n&31))-1);
      parray[(n>>5)] &= ~mask;
      mask = (1<<((n+l)&31))-1;
      parray[((n+l)>>5)] &= ~mask;
    }
    // clear inbetween 32-bit blocks directly
    rsint32 i = ((n+l)>>5)-1;
    while (i > (n>>5))
      parray[i--] = 0;
  }
}

#ifdef X_DEBUG
inline void BITARRAY::Dump(ostream& out, uint32 s, uint32 l)
{
  l = Clamp(l, 1, 127);
  char buf[128];
  buf[l] = '\0';
  for (sint32 i = 0; i < l; i++)
    buf[i] = '0'+Bit(s+i);
  out << "[ 8-bit]Bits " << s << "-" << s+l-1 << " : " << buf << "\n";
}

inline void BITARRAY_16::Dump(ostream& out, uint32 s, uint32 l)
{
  l = Clamp(l, 1, 127);
  char buf[128];
  buf[l] = '\0';
  for (sint32 i = 0; i < l; i++)
    buf[i] = '0'+Bit(s+i);
  out << "[16-bit]Bits " << s << "-" << s+l-1 << " : " << buf << "\n";
}

inline void BITARRAY_32::Dump(ostream& out, uint32 s, uint32 l)
{
  l = Clamp(l, 1, 127);
  char buf[128];
  buf[l] = '\0';
  for (sint32 i = 0; i < l; i++)
    buf[i] = '0'+Bit(s+i);
  out << "[32-bit]Bits " << s << "-" << s+l-1 << " : " << buf << "\n";
}

inline void BITARRAY_64::Dump(ostream& out, uint32 s, uint32 l)
{
  l = Clamp(l, 1, 127);
  char buf[128];
  buf[l] = '\0';
  for (sint32 i = 0; i < l; i++)
    buf[i] = '0'+Bit(s+i);
  out << "[64-bit]Bits " << s << "-" << s+l-1 << " : " << buf << "\n";
}
#endif

#endif // _XUTILITY_BITARRAY_HPP
