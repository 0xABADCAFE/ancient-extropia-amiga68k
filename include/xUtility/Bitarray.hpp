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
//  BITARRAY
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

template<size_t s> class BITARRAY {
  private:
    uint32 data[s];

  public:
    uint8 Bit(ruint32 n)  { return (data[(n>>5)] & (1<<(n&31))) != 0; }
    void  Set(ruint32 n)  { data[(n>>5)] |= (1<<(n&31)); }
    void  Clr(ruint32 n)  { data[(n>>5)] &= ~(1<<(n&31)); }
    void  Set(ruint32 n, ruint32 l);
    void  Clr(ruint32 n, ruint32 l);
  public:
    BITARRAY()  { }
    ~BITARRAY() { }
};


template<size_t s> void BITARRAY::Clr(ruint32 n, ruint32 l)
{ // block clear
  if ((n>>5) == ((n+l)>>5))
  { // start and end are in same 32-bit block. Generate mask for bits to clear
    ruint32 mask = ~((1<<(n&31))-1);
    mask &= (1<<((n+l)&31))-1;
    data[(n>>5)] &= ~mask;
  }
  else
  { // start and end are in different 32-bit blocks
    // generate masks for start and end
    {
      ruint32 mask = ~((1<<(n&31))-1);
      data[(n>>5)] &= ~mask;
      mask = (1<<((n+l)&31))-1;
      data[((n+l)>>5)] &= ~mask;
    }
    // clear inbetween 32-bit blocks directly
    rsint32 i = ((n+l)>>5)-1;
    while (i > (n>>5))
      data[i--] = 0;
  }
}

template <size_t s> void BITARRAY::Set(ruint32 n, ruint32 l)
{ // block set
  if ((n>>5) == ((n+l)>>5))
  { // start and end are in same 32-bit block. Generate mask for bits to set
    ruint32 mask = ~((1<<(n&31))-1);
    mask &= (1<<((n+l)&31))-1;
    data[(n>>5)] |= mask;
  }
  else
  { // start and end are in different 32-bit blocks
    // generate masks for start and end
    {
      ruint32 mask = ~((1<<(n&31))-1);
      data[(n>>5)] |= mask;
      mask = (1<<((n+l)&31))-1;
      data[((n+l)>>5)] |= mask;
    }
    // set inbetween 32-bit blocks directly
    rsint32 i = ((n+l)>>5)-1;
    while (i > (n>>5))
      data[i--] = 0xFFFFFFFF;
  }
}


#endif // _XUTILITY_BITARRAY_HPP
