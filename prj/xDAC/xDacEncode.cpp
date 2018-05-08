//****************************************************************************//
//** File:         prj/xDAC/xDac.cpp ($NAME=xDac.cpp)                       **//
//** Description:  eXtropia Dynamic Audio Compression source                **//
//** Comment(s):                                                            **//
//** Created:      2002-01-20                                               **//
//** Updated:      2002-02-21                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include "xDac.hpp"

#include <stdlib.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int compare(const void* p1, const void* p2);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XDACENCODE :: Frame based encoding
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

XDACENCODE::XDACENCODE(PCM& source, sint32 size, sint16 bits, bool fast) : flags(0), waveData(&source), offset(0), allocSize(0)
{
  Set(source, size, bits, fast);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

XDACENCODE::~XDACENCODE()
{
  FreeSpace();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Encoding
//
//  Encoded index values are packed to 16-bit right-alignment. Thus odd bitrates pack as many full values into a 16-bit word as
//  possible, leaving unused bits in the MSB only
//
//  Data is packed with first values towards LSB, eg for 4-bit
//
//  word = (MSB) [val4][val3][val2][val1] (LSB)
//
//  For multiple channel, packed data is interleaved thus
//
//  word = (MSB) [chn0][chn1][chn0][chn1] (LSB) (stereo)
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// This should be encode interleaved body
sint32 XDACENCODE::EncodeBody()
{
  encodeSize = 0;
  if (!workspace)
    return ERR_NO_FREE_STORE;
  if (!(flags & ANALYSED))
    Analyse();
  // if a silent frame, body length is zero words, so just return 0
  if (flags & ZERO_FRAME)
    return OK;
  sint32 tableSize  = TableSize();
  {
    // Interleave the channel data in the packed stream
    sint16* src       = (waveData->Data())+offset;
    sint32  prev[4]   = {0};
    {
      for (rsint32 i=0; i<channels; i++)
        prev[i]=*src++;
    }
    sint32    shiftMx = (8*sizeof(sint16)-encodeRate)-((8*sizeof(sint16)%encodeRate) ? 1 : 0); // right align bits
    sint32    shift   = 0;
    uint32    packed  = 0;
    rsint16*  qTable  = Table();
    ruint16*  encoded = Encoded();
    rsint32 i = frameSize;
    while(--i)
    {
      for(rsint32 c=0; c<channels; c++)
      {
        sint32 best = -1;
        {
          sint32 t = (sint32)(*src++)-prev[c];
          sint32 minT=(1UL<<30);
          for (rsint32 j=0; j<tableSize; j++)
          {
            rsint32 v = abs(qTable[j]-t);
            if (v<minT)
            {
              minT = v;
              best = j;
            }
          }
        }
        if (best>=0)
        {
          prev[c] += qTable[best];
          packed |= (best)<<shift;
          shift += encodeRate;
          if (shift>shiftMx)
          {
            *encoded++ = (uint16)packed;
            shift = packed = 0;
          }
        }
        else
        {
          #ifdef X_VERBOSE
          cerr << "Error during XDACENCODE::Encode()\n";
          #endif
          return ERR_VALUE;
        }
      }
    }
    if (shift)
      *encoded++ = (uint16)packed;
    encodeSize = encoded-Encoded();
  }
  flags |= ENCODED;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDACENCODE::Write(XSFIO& file)
{
  static uint16 silentFrames = 0;
  if (!workspace)
    return ERR_NO_FREE_STORE;
  if (file.Valid()==FALSE)
    return ERR_FILE_WRITE;
  if (!(flags & ENCODED))
    if (EncodeBody()!=OK)
      return ERR_VALUE;
  if ((flags & ZERO_FRAME) && (++silentFrames<8191) && frameNum<maxFrame)
    return 0;
  sint32 wordsWritten=0;
  if (silentFrames)
  {
    silentFrames |= XDAC_SILENT;
    if (file.Write16(&silentFrames, 1)!=1)
    {
      silentFrames = 0;
      return ERR_FILE_WRITE;
    }
    silentFrames = 0;
    wordsWritten++;
  }
  uint16 head = (uint16)XDAC_SETBITRATE(encodeRate) | (uint16)XDAC_SETTABLE(TableSize());
  if (file.Write16(&head, 1)!=1)
    return ERR_FILE_WRITE;
  else
    wordsWritten++;
  if (file.Write16(StartSample(), channels)!=channels)
    return ERR_FILE_WRITE;
  else
    wordsWritten+=channels;
  sint32 bodySize = encodeSize + TableSize();
  return (file.Write16(Table(), bodySize)==bodySize) ? bodySize+wordsWritten : ERR_FILE_WRITE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XDACENCODE
//
//  Utility methods
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDACENCODE::GetSpace(sint32 size)
{
  // Allocates workspace to hold temporary data
  // Uses 4*size to nearest kb
  // This allows us to experiment changing the frame size without
  // reallocating every time
  sint32 newSize = 256*((size/256)+((size%256)?1:0));
  newSize *= (4*sizeof(sint16));
  if (workspace)
  {
    if (newSize != allocSize)
    {
      MEM::Free(workspace);
      workspace = (sint16*)MEM::Alloc(newSize);
      if (!workspace)
        return ERR_NO_FREE_STORE;
      allocSize = newSize;
    }
  }
  else
  {
    workspace = (sint16*)MEM::Alloc(newSize);
    if (!workspace)
      return ERR_NO_FREE_STORE;
    allocSize = newSize;
  }
  // set the data pointers
  qDeltaFreq  = workspace+1*size;
  uDelta      = workspace+2*size;
  uDeltaFreq  = workspace+3*size;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void  XDACENCODE::FreeSpace()
{
  if (workspace)
    MEM::Free(workspace);
  allocSize   = 0;
  workspace   = 0;
  qDeltaFreq  = 0;
  uDelta      = 0;
  uDeltaFreq  = 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32  XDACENCODE::Set(PCM& source, sint16 size, sint16 bits, bool fast)
{
  flags = (fast)? FAST_ENCODE : 0;
  frameSize = Clamp(size, XDAC_MIN_FRAMELEN, XDAC_MAX_FRAMELEN);
  waveData = &source;
  if (GetSpace(frameSize*waveData->Channels())!=OK)
    return ERR_NO_FREE_STORE;

  bitRate   = Clamp(bits, 2, 5);
  frameNum  = maxFrame = offset = 0;
  channels  = waveData->Channels();
  minPop    = (sint16)(0.5F + (float32)(channels*(size-1))/(float32)(1<<bitRate));

  if (waveData->Data())
    maxFrame = (waveData->Length()/frameSize)-1;
  else
    maxFrame = 0;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDACENCODE::Size(sint16 size)
{
  size = Clamp(size, XDAC_MIN_FRAMELEN, XDAC_MAX_FRAMELEN);
  if (size!=frameSize)
  {
    if (GetSpace(size*channels)==OK)
    {
      frameSize = size;
      minPop    = (sint16)(0.5F + (float32)(channels*(size-1))/(float32)(1<<bitRate));
      if (waveData->Data())
        maxFrame = (waveData->Length()/frameSize)-1;
      else
        maxFrame = 0;
    }
    return ERR_RSC;
  }
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void XDACENCODE::First()
{
  frameNum = 0;
  offset = 0;
  flags &= ~(ANALYSED|ENCODED|ZERO_FRAME);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void XDACENCODE::Last()
{
  if (waveData->Data())
  {
    frameNum = maxFrame;
    offset = maxFrame*frameSize*channels;
  }
  else
  {
    frameNum = 0;
    offset = 0;
  }
  flags &= ~(ANALYSED|ENCODED|ZERO_FRAME);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

XDACENCODE& XDACENCODE::operator++(int)
{
  // increment frame position
  if (waveData->Data())
  {
    if (frameNum < maxFrame) // hack for now
    {
      frameNum++;
      offset += frameSize*channels;
      flags &= ~(ANALYSED|ENCODED|ZERO_FRAME);
    }
  }
  else
  {
    offset = 0;
  }
  return *this;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

XDACENCODE& XDACENCODE::operator--(int)
{
  // decrement frame position
  if (waveData->Data())
  {
    if (frameNum>0)
    {
      frameNum--;
      offset -= frameSize*channels;
      flags &= ~(ANALYSED|ENCODED|ZERO_FRAME);
    }
  }
  else
    offset = 0;
  return *this;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XDACENCODE
//
//  Frame analysis
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDACENCODE::TestUpsample()
{
  return OK;
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void XDACENCODE::FetchData()
{
  if (!workspace) return;
  //flags &= ~(ANALYSED|ENCODED|ZERO_FRAME);

  sint16* s = (waveData->Data())+offset;
  sint16* d = workspace;
  maxDelta = minDelta = 0;
  { // workspace data format
    // workspace[0]                          = start 1
    // workspace[n-1]                        = start n
    // workspace[n]                          = delta stream 0
    // workspace[channels + n*(frameSize-1)] = delta stream n
    for (sint32 i=0; i<channels; i++)
      *d++ = *s++;
    for (i=0; i<channels; i++)
    {
      rsint16*  s2    = s++;
      rsint32   prev  = workspace[i];
      rsint32   j     = frameSize;
      while(--j)
      {
        rsint32 t1  = *s2; s2 += channels;
        rsint32 t2  = t1-prev;
        maxDelta    = t2<maxDelta ? maxDelta : t2;
        minDelta    = t2>minDelta ? minDelta : t2;
        prev = t1;  *d++ = t2;
      }
    }
  }

  if (maxDelta==minDelta)
    flags |= ZERO_FRAME;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void XDACENCODE::CalcDeltaPop()
{
  if (!workspace || (flags & ZERO_FRAME)) return;
  // All delta values from each channel are collated here and sorted. Hence we end up at
  // workspace[0]   = start 0
  // workspace[n-1] = start n
  // workspace[n]   = sorted delta values (total = channels * (frameSize-1))

  // Sorting takes time, so we need to use the best sort we can find

  sint32    n = channels*(frameSize-1);
  rsint16*  d = DeltaStream();

  qsort(DeltaStream(), n, sizeof(sint16), compare);


  // Turn the above into a population of unique values
  {
    n = channels*(frameSize-1);
    uniqueDelta = negPop = zeroPop = posPop = uniqueNeg = uniquePos = 0;
    sint16* ud    = uDelta;
    sint16* udf   = uDeltaFreq;
    sint32  cnt   = 1;
    sint32  prev  = d[0];
    for (rsint32 i=1; i<=n; i++)
    {
      rsint16 t = d[i];
      if (t == prev)
        cnt++;
      else
      {
        *ud++   = prev;
        *udf++  = cnt;
        uniqueDelta++;
        if (prev<0)
        {
          negPop += cnt;
          uniqueNeg++;
        }
        else if (prev==0)
          zeroPop += cnt;
        else
        {
          posPop += cnt;
          uniquePos++;
        }
        cnt = 1;
        prev = t;
      }
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void  XDACENCODE::Analyse()
{
  // TO DO
  // Analyse() will perform all the optional extra checks for upsampling, channel merging and silence

  MILLICLOCK t;

  FetchData();
  sint32 t1 = t.Elapsed();

  t.Set();
  CalcDeltaPop();
  sint32 t2 = t.Elapsed();

  t.Set();
  GenTable();
  sint32 t3 = t.Elapsed();

  evalTime = t1+t2+t3;

  //cout << "FetchData(): " << t1 << " ms, CalcDeltaPop(): " << t2 << " ms, GenTable/Quick(): " << t3 << " ms\n";
  flags |= ANALYSED;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void  XDACENCODE::GenTable()
{
  encodeRate = bitRate;
  if (flags & ZERO_FRAME)
    return;
  // if less than (1<<bitRate) unique delta values just use them directly
  // In some cases, esp speech, we have regions where there are so few values that
  // we can drop to a lower bit rate without introducing any additional loss
  if (uniqueDelta<=(1<<bitRate))
  {
    flags |= SKIP_QUANT;
    sint32 u = uniqueDelta;
    while (u < (1<<(encodeRate-1)))
      encodeRate--;
    if (minDelta>-127 && maxDelta<128)
      flags |= TABLE_8BIT;
    return;
  }
  else
    flags &= ~(SKIP_QUANT|TABLE_8BIT);

  // Estimate allocation distribution
  sint32 allocMax   = (1<<bitRate);
  sint32 allocZero  = (zeroPop >= minPop);
  sint32 totalPop   = (channels*(frameSize-1))-(allocZero ? zeroPop : 0); // total non zero delta
  sint32 allocNeg   = Clamp((sint32)(0.5F+(float32)(negPop*(allocMax-allocZero))/(float32)totalPop), 0, uniqueNeg);
  sint32 allocPos   = Clamp((sint32)(allocMax-allocZero-allocNeg), 0, uniquePos);

  // Due to rounding, its possible we have allocated more or less deltas than allocMax, so we may need to
  // do a spot of fine tuning. Note that this doesn't happen often, but it is worth ensuring that we always
  // make best use of the bit rate.
  {
    sint32 rem = allocMax-(allocPos+allocNeg+allocZero);
    if (rem > 0)
    { // Share out the remainder, no point giving to neg/pos if already ideal, no point in allocating
      bool negIdeal = (allocNeg==uniqueNeg), posIdeal = (allocPos==uniquePos);
      if (negIdeal && posIdeal && !allocZero && zeroPop)
      { // this isn't very likely, but if it occurs we only need to use give 1 zero delta
        rem--;
        allocZero = 1;
      }
      if (rem && negIdeal && !posIdeal)
      {
        allocPos+=rem;
        rem = 0;
      }
      if (rem && !negIdeal && posIdeal)
        allocNeg+=rem;
    }
    else if (rem < 0)
    { // Use a simple balancing strategy to reduce the excessive positive or negative portion of the table
      while ((allocNeg+allocZero+allocPos)>allocMax)
      {
        if (allocNeg>allocPos)
          allocNeg--;
        else
          allocPos--;
      }
      while ((allocNeg+allocZero+allocPos)>allocMax)
      {
        if (allocNeg>allocPos)
          allocNeg--;
        else
          allocPos--;
      }
    }
  }

  // Now we need to actually fill our delta table. We have the luxury of being able to use several methods
  // So far, we the original adaptive model, Serkan1, which gives excellent selections but is very slow for
  // large uniqueDelta counts (double exponential complexity)
  // We also have a new model, Karl1, which is very fast (near constant complexity) but gives poor selections
  // when the uniqueDelta count closer to allocMax (which is kinda weird really).

  // For now, we choose based on the the above observation

  if (flags & FORCE_S1)
    DeltaModelSerkan1(allocNeg, allocPos, allocZero);
  else if (flags & FORCE_K1)
    DeltaModelKarl1(allocNeg, allocPos, allocZero);
  else if (uniqueDelta<96)
    DeltaModelSerkan1(allocNeg, allocPos, allocZero);
  else
    DeltaModelKarl1(allocNeg, allocPos, allocZero);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void  XDACENCODE::DeltaModelKarl1(sint16 allocNeg, sint16 allocPos, bool allocZero)
{
  sint32 allocMax = (1<<bitRate);
  rsint16 *dT = Table();
  if (allocNeg)
  {
    rsint16*  uF    = uDeltaFreq;
    rsint16*  uD    = uDelta;
    rsint32   mPop  = negPop/allocNeg;
    rsint32   bias  = /*uniqueDelta>(channels*(frameSize>>1)) ? minDelta :*/ 0;
    allocNeg++;
    while (--allocNeg)
    {
      rsint32 tPop      = 1;
      rsint32 estimate  = bias;
      while (tPop<mPop)
      {
        tPop     += *uF;
        estimate += (*uD++)*(*uF++);
      }
      *dT++ = (estimate/tPop);
      //bias>>=2;
    }
  }
  if (allocZero)
    *dT = 0;
  if (allocPos)
  {
    dT = (Table())+allocMax;
    rsint16*  uF      = uDeltaFreq+uniqueDelta;
    rsint16*  uD      = uDelta+uniqueDelta-1;
    rsint32   mPop    = posPop/allocPos;
    rsint32   bias    = /*uniqueDelta>(channels*(frameSize>>1)) ? maxDelta :*/ 0;
    allocPos++;
    while (--allocPos)
    {
      rsint32 tPop      = 1;
      rsint32 estimate  = bias;
      while (tPop<mPop)
      {
        tPop     += *(--uF);
        estimate += (*uD--)*(*uF);
      }
      *(--dT) = (estimate/tPop);
      //bias>>=2;
    }
  }
  dT = Table();
  if(dT[0]>-127 && dT[allocMax-1]<128)
    flags |= TABLE_8BIT;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void XDACENCODE::DeltaModelSerkan1(sint16 allocNeg, sint16 allocPos, bool allocZero)
{
  sint32 allocMax = (1<<bitRate);
  rsint16 *dT = Table();
  rsint16 *dF = qDeltaFreq;
  if (allocNeg)
  {
    sint32 totalPop = uniqueNeg;
    for (rsint32 i = 0; i < uniqueNeg; i++)
    {
      dT[i] = uDelta[i];
      dF[i] = uDeltaFreq[i];
    }
    while (totalPop > allocNeg)
    {
      sint32 minDif = (1UL<<30), index = -1;
      for (i = 0; i < totalPop-1; i++)
      {
        // this determines the smallest current weighted difference and the index, i, where it occurred
        // Because of sorting, dT[i+1] always greater than dT[i]
        sint32 temp = (dT[i+1]-dT[i])*(dF[i]+dF[i+1]);
        if (temp < minDif)
        {
          minDif = temp;
          index = i;
        }
      }
      if (index!=-1)
      {
        i = index;
        // this produces a weighted average of delta[i] and delta[i+1] -> delta[i] and combines their
        // frequencies into freq[i]
        {
          dT[i] = (dT[i]*dF[i] + dT[i+1]*dF[i+1]) / (dF[i]+dF[i+1]);
          dF[i] += dF[i+1];
        }
        // This loop squeezes out the old delta/freq[i+1] by 'collapsing' those above. Optimise this ?
        for (i = index+1; i < totalPop-1; i++)
        {
          dT[i]=dT[i+1];
          dF[i]=dF[i+1];
        }
      }
      totalPop--; // one less unique value
    }
  }

  dT += allocNeg;
  if (allocZero)
    *dT++ = 0;

  if (allocPos)
  {
    sint32 totalPop = uniqueNeg+allocZero;
    for (rsint32 i=0; i < uniquePos; i++, totalPop++)
    {
      dT[i] = uDelta[totalPop];
      dF[i] = uDeltaFreq[totalPop];
    }
    totalPop = uniquePos;
    while (totalPop > allocPos)
    {
      sint32 minDif = (1UL<<30), index = -1;
      for (i=0;i<totalPop-1;i++)
      {
        // this determines the smallest current weighted difference and the index, i, where it occurred
        sint32 temp = (dT[i+1]-dT[i])*(dF[i]+dF[i+1]);
        if (temp < minDif)
        {
          minDif = temp;
          index = i;
        }
      }
      if (index!=-1)
      {
        i = index;
        // this produces a weighted average of delta[i] and delta[i+1] -> delta[i] and combines their
        // frequencies into freq[i]
        dT[i] = (dT[i]*dF[i] + dT[i+1]*dF[i+1]) / (dF[i]+dF[i+1]);
        dF[i] += dF[i+1];
        // This loop squeezes out the old delta/freq[i+1] by 'collapsing' those above
        for (i = index+1; i < totalPop-1; i++)
        {
          dT[i]=dT[i+1];
          dF[i]=dF[i+1];
        }
      }
      totalPop--; // one less unique value
    }
  }
  dT = Table();
  if(dT[0]>-127 && dT[allocMax-1]<128)
    flags |= TABLE_8BIT;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDACENCODE::GetApprox(sint16 d)
{
  sint32 minAbs=(1UL<<30), index=-1;
  sint16* qTable = Table();
  sint32 tableSize = uniqueDelta < (1<<bitRate) ? uniqueDelta : (1<<bitRate);
  for(rsint32 i=0; i<tableSize; i++)
  {
    rsint32 v = abs(qTable[i]-d);
    if (v<minAbs)
    {
      minAbs = v;
      index  = i;
    }
  }
  if (index==-1)
  {
    #ifdef X_VERBOSE
    cerr << "XDACENCODE::GetApprox() failed to find approximation for " << d << "\n";
    #endif
    return ERR_VALUE;
  }
  return index;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int compare(const void* p1, const void* p2)
{
  rsint16 v1 = *((sint16*)p1);
  rsint16 v2 = *((sint16*)p2);
  if (v1==v2)
    return 0;
  return (v1>v2) ? 1 : -1;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
