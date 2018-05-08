//****************************************************************************//
//** File:         prj/xDAC/xDacDecode.cpp ($NAME=xDacDecode.cpp)           **//
//** Description:  Decoding methods for xDAC stream                         **//
//** Comment(s):                                                            **//
//** Created:      2002-01-20                                               **//
//** Updated:      2002-02-24                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include "xDac.hpp"

// Slpit out like this so we can do better hand optimisation later

sint32 XDAC::DecodeMergedStereo(sint16* dest, sint32 num)
{
  rsint16*  d = dest;
  ruint16*  s = current;
  rsint32   n = num+1;
  while(--n)
  {
    ruint16 c = *s++;
    if (XDAC_SILENCE(c))
    {
      ruint16 f = XDAC_SLNC_LEN(c);
      #ifdef XDAC_DEBUG_FRAMES
      if (f>n)
      {
        #ifdef X_VERBOSE
        cerr << "Error during DecodeMergedStereo() - stream probably misaligned\n";
        cerr << "Words into stream: " << (s-current-1) << "\n";
        cerr << "Samples decoded: " << (d-dest) << "\n";
        cerr << "Prev word = 0x" << (void*)(*(s-2)) << "\n";
        cerr << "Curr word = 0x" << (void*)(*(s-1)) << "\n";
        cerr << "Next word = 0x" << (void*)(*(s)) << "\n";
        #endif
        return ERR_RSC;
      }
      #endif
      rsint32 len = (shared.frameLen*f)<<1;
      MEM::Zero(d,(len<<1));
      d += len;
      n -= (f-1);
    }
    else
    {
      #ifdef XDAC_DEBUG_FRAMES
      if (c&XDAC_RESERVED)
      {
        #ifdef X_VERBOSE
        cerr << "Error during DecodeMergedStereo() - stream probably misaligned\n";
        cerr << "Words into stream: " << (s-current-1) << "\n";
        cerr << "Samples decoded: " << (d-dest) << "\n";
        cerr << "Prev word = 0x" << (void*)(*(s-2)) << "\n";
        cerr << "Curr word = 0x" << (void*)(*(s-1)) << "\n";
        cerr << "Next word = 0x" << (void*)(*(s)) << "\n";
        #endif
        return ERR_RSC;
      }
      #endif
      rsint16   bitRate = XDAC_BITRATE(c);
      ruint16   mask    = (1<<bitRate)-1;
      rsint16   shiftMx = ((8*sizeof(sint16))/bitRate);
      rsint16   shifted = shiftMx;
      rsint16   sample1 = *((sint16*)s++);
      rsint16   sample2 = *((sint16*)s++);
      *d++  =   (sint16)sample1;
      *d++  =   (sint16)sample2;

      rsint16*  qTable  = (sint16*)s;
      s     +=  XDAC_TABLESIZE(c);

      ruint16 packed = *s++;
      rsint16 i = shared.frameLen;

      while(--i)
      {
        sample1 += qTable[(packed & mask)];
        *d++ = sample1;
        packed >>= bitRate;
        if (--shifted==0)
        {
          shifted = shiftMx;
          packed = *s++;
        }
        sample2 += qTable[(packed & mask)];
        *d++ = sample2;
        packed >>= bitRate;
        if (--shifted==0)
        {
          shifted = shiftMx;
          packed = *s++;
        }
      }
      // we may have overshot the frame end in the while loop
      // if there were an exact nbr of words used
      if (shifted==shiftMx)
        s--;
    }
  }
  current = s;
  frameNum += num;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDAC::DecodeMonoFrames(sint16* dest, sint32 num)
{
  rsint16*  d = dest;
  ruint16*  s = current;
  rsint32   n = num+1;
  while(--n)
  {
    ruint16 c = *s++;
    if (XDAC_SILENCE(c))
    {
      ruint16 f = XDAC_SLNC_LEN(c);
      #ifdef XDAC_DEBUG_FRAMES
      if (f>n)
      {
        #ifdef X_VERBOSE
        cerr << "Error during DecodeMonoFrames() - stream probably misaligned\n";
        cerr << "Words into stream: " << (s-current-1) << "\n";
        cerr << "Samples decoded: " << (d-dest) << "\n";
        cerr << "Prev word = 0x" << (void*)(*(s-2)) << "\n";
        cerr << "Curr word = 0x" << (void*)(*(s-1)) << "\n";
        cerr << "Next word = 0x" << (void*)(*(s)) << "\n";
        #endif
        return ERR_RSC;
      }
      #endif
      rsint32 len = shared.frameLen*f;
      MEM::Zero(d,(len<<1)); // in bytes
      d += len;
      n -= (f-1);
    }
    else
    {
      #ifdef XDAC_DEBUG_FRAMES
      if (c&XDAC_RESERVED)
      {
        #ifdef X_VERBOSE
        cerr << "Error during DecodeMonoFrames() - stream probably misaligned\n";
        cerr << "Words into stream: " << (s-current-1) << "\n";
        cerr << "Samples decoded: " << (d-dest) << "\n";
        cerr << "Prev word = 0x" << (void*)(*(s-2)) << "\n";
        cerr << "Curr word = 0x" << (void*)(*(s-1)) << "\n";
        cerr << "Next word = 0x" << (void*)(*(s)) << "\n";
        #endif
        return ERR_RSC;
      }
      #endif
      rsint16   bitRate = XDAC_BITRATE(c);
      ruint16   mask    = (1<<bitRate)-1;
      rsint16   shiftMx = ((8*sizeof(sint16))/bitRate);
      rsint16   shifted = shiftMx;
      rsint16   sample  = *((sint16*)s++);
      rsint16*  qTable  = (sint16*)s;

      s     +=  XDAC_TABLESIZE(c);
      *d++  =   (sint16)sample;

      ruint16 packed = *s++;
      rsint16 i = shared.frameLen;

      while(--i)
      {
        sample += qTable[(packed & mask)];
        *d++ = sample;
        packed >>= bitRate;
        if (--shifted==0)
        {
          shifted = shiftMx;
          packed = *s++;
        }
      }
      // we may have overshot the frame end in the while loop
      // if there were an exact nbr of words used
      if (shifted==shiftMx)
        s--;
    }
  }
  current = s;
  frameNum += num;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDAC::DecodeMergedFrames(sint16* dest, sint32 num)
{
  rsint16*  d = dest;
  ruint16*  s = current;
  rsint32 n = num+1;
  while(--n)
  {
    ruint16 c = *s++;
    if (XDAC_SILENCE(c))
    {
      ruint16 f = XDAC_SLNC_LEN(c);
      #ifdef XDAC_DEBUG_FRAMES
      if (f>n)
      {
        #ifdef X_VERBOSE
        cerr << "Error during DecodeMergedFrames() - stream probably misaligned\n";
        cerr << "Words into stream: " << (s-current-1) << "\n";
        cerr << "Samples decoded: " << (d-dest) << "\n";
        cerr << "Prev word = 0x" << (void*)(*(s-2)) << "\n";
        cerr << "Curr word = 0x" << (void*)(*(s-1)) << "\n";
        cerr << "Next word = 0x" << (void*)(*(s)) << "\n";
        #endif
        return ERR_RSC;
      }
      #endif
      rsint32 len = shared.frameLen*shared.channels*f;
      MEM::Zero(d,(len<<1));
      d += len;
      n -= (f-1);
    }
    else
    {
      #ifdef XDAC_DEBUG_FRAMES
      if (c&XDAC_RESERVED)
      {
        #ifdef X_VERBOSE
        cerr << "Error during DecodeMergedFrames() - stream probably misaligned\n";
        cerr << "Words into stream: " << (s-current-1) << "\n";
        cerr << "Samples decoded: " << (d-dest) << "\n";
        cerr << "Prev word = 0x" << (void*)(*(s-2)) << "\n";
        cerr << "Curr word = 0x" << (void*)(*(s-1)) << "\n";
        cerr << "Next word = 0x" << (void*)(*(s)) << "\n";
        #endif
        return ERR_RSC;
      }
      #endif
      sint16    sample[4];

      for (rsint16 ch=0, *smp=sample; ch<shared.channels; ch++)
        *d++ = *smp++ = *((sint16*)s)++;

      rsint16   bitRate = XDAC_BITRATE(c);
      ruint16   mask    = (1<<bitRate)-1;
      rsint16   shiftMx = ((8*sizeof(sint16))/bitRate);
      rsint16   shifted = shiftMx;
      rsint16*  qTable  = (sint16*)s;

      s +=  XDAC_TABLESIZE(c);

      ruint16   packed  = *s++;
      rsint16   i       = shared.frameLen;

      while (--i)
      {
        for(ch=0; ch<shared.channels; ch++)
        {
          rsint16 curr = sample[ch] + qTable[(packed&mask)];
          *d++ = sample[ch] = curr;
          packed >>= bitRate;
          if (--shifted==0)
          {
            shifted = shiftMx;
            packed = *s++;
          }
        }
      }
      // we may have overshot the frame end in the while loop
      // if there were an exact nbr of words used
      if (shifted==shiftMx)
        s--;
    }
  }
  current = s;
  frameNum += num;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32  XDAC::DecodeAlternFrames(sint16* dest, sint32 num)
{
  ruint16*  s = current;
  rsint32   n = num+1;

  while(--n)
  {
    for (rsint16 ch=0; ch<shared.channels; ch++)
    {
      rsint16*  d = dest+ch;
      ruint16 c = *s++;
      if (XDAC_SILENCE(c))
      {
        MEM::Zero(d,(shared.frameLen<<1));
        d += shared.frameLen;
      }
      else
      {
        #ifdef XDAC_DEBUG_FRAMES
        if (c&XDAC_RESERVED)
        {
          #ifdef X_VERBOSE
          cerr << "Error during DecodeAlternFrames() - stream probably misaligned\n";
          cerr << "Words into stream: " << (s-current-1) << "\n";
          cerr << "Samples decoded: " << (d-dest) << "\n";
          cerr << "Prev word = 0x" << (void*)(*(s-2)) << "\n";
          cerr << "Curr word = 0x" << (void*)(*(s-1)) << "\n";
          cerr << "Next word = 0x" << (void*)(*(s)) << "\n";
          #endif
          return ERR_RSC;
        }
        #endif
        rsint16   bitRate = XDAC_BITRATE(c);
        ruint16   mask    = (1<<bitRate)-1;
        rsint16   shiftMx = ((8*sizeof(sint16))/bitRate);
        rsint16   shifted = shiftMx;
        rsint16   sample  = *((sint16*)s++);
        rsint16*  qTable  = (sint16*)s;

        rsint16   ch      = shared.channels;

        s     +=  XDAC_TABLESIZE(c);
        *d    =   (sint16)sample;
        d     +=  ch;

        ruint16 packed = *s++;
        rsint16 i = shared.frameLen;

        while(--i)
        {
          sample += qTable[(packed & mask)];
          *d  = sample;
          d   += ch;

          packed >>= bitRate;
          if (--shifted==0)
          {
            shifted = shiftMx;
            packed = *s++;
          }
        }
        // we may have overshot the frame end in the while loop
        // if there were an exact nbr of words used
        if (shifted==shiftMx)
          s--;
      }
    }
  }
  current = s;
  frameNum += num;
  return ERR_RSC;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32  XDAC::DecodeEitherFrames(sint16* dest, sint32 num)
{
  return ERR_RSC;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
