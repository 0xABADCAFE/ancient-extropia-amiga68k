//****************************************************************************//
//** File:         prj/xDAC/xDac.hpp ($NAME=xDac.hpp)                       **//
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

#ifndef _XDAC_HPP
#define _XDAC_HPP

#include <xBase.hpp>

#ifdef XP_AMIGAOS
#include <xSystem/ServiceLib.hpp> // timer and stuff
#include <xSystem/xAudio.hpp>     // general sound & PCM stuff
#else
#include "pcm.hpp" // Quick and dirty PCM class
#endif

#include <xSystem/IOLib.hpp>
#include <XSF/XSF.hpp>


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDAC simple file header. Follows XSF 1.0 subformat specification
//
//  char[6] signature  (XDAC_SIGNATURE)
//  uint8   version    (XDAC_VERSION)
//  uint8   revision   (XDAC_REVISION)
//  uint8   dataFormat (XDAC_DATAFORMAT)
//  uint8   fileFormat (unused here)
//  uint16  bitRate    (bitRate 0 == variable)
//  uint16  channels   (channels 0 == intensity encoded, not supported yet)
//  uint16  frequency
//  uint16  frameSize  (32 - 1024 so far)
//  sint32  numFrames
//
//  Total 24 bytes (aligned to 64 bits)
//
//  For full decode, need to allocate numFrames*frameSize*channels worth of sint16 words
//  For full xDac load, allocate filesize-16 bytes to load all frames
//
//  xDAC file definition notes
//
//  Don't change alignment data. All frame data is 16-bit, there is no benefit in aligning beyond 16-bits
//  The full header is 64-bit aligned (24 bytes)
//  Endian conversion is handled as expected
//
//
//  xDAC v1 Frame definition
//
//  Frames are virtually self contained units of data.
//  Frame length and channel count are the only global data, though channel information can be included in the
//  frame also.
//
//  Frame length is defined as number of sample units*number of channels. So a mono frame of framelength 256
//  encodes 256 16-bit samples. A stereo frame encodes 256*2 16-bit samples and is correspondingly longer.
//
//  Word        15  13 12  10   8   6  5      0
//     0       [S][xx][i][cc][bb][xx][T][ttttt] : control word
//     1        <start sample 1>                : first sample in frame
//    (2        <start sample 2>)               : [i]=0 & [cc]=1 (stereo)
//    (3        <start sample 3>)               : [i]=0 & [cc]=2 (3 channel, usually stereo + sub bass)
//    (4        <start sample 4>)               : [i]=0 & [cc]=3 (4 channel surround)
//  2(..5)      <delta table[0]>                : delta LUT
//   ...        <delta table[n]>
//   ...        data word[0]                : packed data
//   ...        data word[n]
//
//  Control
//
//   S : silence frame. When set, the remaining data is as follows
//        15 14  13         0
//       [S][i][cc][<length>], length is the number of silent sample frames. [i] and [cc] are as normal
//
//   x : reserved
//
//   i : individual. When set, frame encodes just one of several channels rather than interleaving all of them
//
//   c : channel/s. When [i] is not set, [cc] is the number of interleaved channels number that this frame
//       encodes. If [i] is set, [cc] is the number of the channel that this frame encodes.
//
//   b : bitrate. This value indicates the bit rate used to encode the frame.
//
//   T : table type. If set, table entries are 8-bit rather than 16-bit.
//   t : table size. This gives the size of the delta table used in the frame. Odd 8-bit table sizes are padded
//
//  Information
//
//  Upsampling
//    The upsample index describes how many times the original data was halved. Upsampled data is decoded
//  via interpolation. Not implemented yet
//
//  Bit rates
//    The bit rate value is normally global, but per-frame bit rate is allowed for size critical apps.
//  Generally bit rates below 3 should not be used. Bit rates above 5 are not supported since the
//  compression rate suffers too much. A bit rate of 4 is sufficient for most purposes.
//
//  Channels
//    The channel number is to allow for future spacial intensity encoding, should be same as the global
//  channel value otherwise. Not implemented yet.
//
//  Table size
//    In cases where there are less than the available number of delta values, only the number of values used
//  are stored. The table size reflects this rare occasion.
//
//    Evidently, increasing the frame length until the maximum number of delta values is obtained would eliminate
//  this eventuality. This is not done for 2 reasons
//
//    1. A Similar number, or more, bits than used for table size would be needed to describe the frame
//       extension length.
//
//    2. Planned enhancements to encoding will use dynamic bandwidth filtering to improve signal/noise ratio
//       The FFT/FIR algorithms ***ABSOLUTELY REQUIRE*** a total frame length (including start samples) that is
//       a power of 2
//
//  Data format
//    Packed data is right aligned to 16-bit boundaries. Thus, odd bit rates have unused
//  data in the MSB of each data word.
//
//  NOTES
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define XDAC_SIGNATURE 'x','D','A','C',0,0
#define XDAC_IDSTRING "xDAC"
#define XDAC_VERSION 1
#define XDAC_REVISION 0
#define XDAC_DATAFORMAT (XA_ALIGN16|X_ENDIAN|X_NEGATIVE)
#define XDAC_FILEFORMAT 0

#define XDAC_MAX_FRAMELEN 2048
#define XDAC_MIN_FRAMELEN   64
#define XDAC_MAX_BITRATE     5
#define XDAC_MIN_BITRATE     2

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XDACENCODE : Provides encoding, not required for basic playback etc.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class XDACENCODE {

  private:
    uint32    flags;
    PCM*      waveData;
    sint32    offset;
    sint16*   workspace;
    sint16*   qDeltaFreq;
    sint16*   uDelta;
    sint16*   uDeltaFreq;
    sint32    allocSize;

    enum {
      ZERO_FRAME    = 0x00000001,
      SKIP_QUANT    = 0x00000002,
      UPSAMPLE      = 0x00000004,
      ANALYSED      = 0x00000008,
      TABLE_8BIT    = 0x00000010,
      FAST_ENCODE   = 0x00000020,
      FORCE_S1      = 0x00010000,
      FORCE_K1      = 0x00020000,
      ENCODED       = 0x01000000
    };

    sint32    GetSpace(sint32 size);
    void      FreeSpace();

    // Specific table generation strategies
    void      DeltaModelSerkan1(sint16 neg, sint16 pos, bool zero);
    void      DeltaModelKarl1(sint16 neg, sint16 pos, bool zero);

  protected:
    sint32    maxFrame;
    sint32    frameNum;
    sint32    evalTime;
    sint16    frameSize;
    sint16    channels;
    sint16    bitRate;
    sint16    uniqueDelta;

    sint16    encodeRate;
    sint16    encodeSize;

    sint16    negPop;     // total delta < 0
    sint16    zeroPop;    // total delta == 0
    sint16    posPop;     // total delta > 0
    sint16    minPop;     //
    sint16    uniqueNeg;  // total unique delta < 0
    sint16    uniquePos;  // total unique delta > 0
    sint16    minDelta;
    sint16    maxDelta;
    sint32    TestUpsample();
    sint16*   DeltaStream(rsint32 i=0){ return workspace+channels+i*(frameSize-1); }
    bool      ZeroFrame()             { return flags & ZERO_FRAME; }
    sint16*   StartSample()           { return workspace;} // support mono, stereo, stereo+sub, quad
    sint16*   WorkSpace()             { return workspace; }
    sint16*   DeltaUnique()           { return uDelta; }
    sint16*   DeltaFreq()             { return uDeltaFreq; }
    sint16*   Table()                 { return (flags & SKIP_QUANT) ? uDelta : DeltaStream(); }
    sint32    TableSize()             { return (flags & SKIP_QUANT) ? uniqueDelta : (1<<bitRate); }
    void      FetchData();
    void      CalcDeltaPop();
    void      GenTable();       // Chooses the best n values for the current bit rate
    uint16*   Encoded()         { return (flags & ANALYSED) ? ((uint16*)Table())+TableSize() : 0; }

    void      Analyse();
    sint32    GetApprox(sint16 d); // returns closest Table() approximation of d
    sint32    EncodeBody();     // Encode the frame

  public:
    void      ForceNone()       { flags &= ~(FORCE_K1|FORCE_S1); }
    void      ForceS1()         { ForceNone(); flags |= FORCE_S1; }
    void      ForceK1()         { ForceNone(); flags |= FORCE_K1; }
    sint32    Set(PCM& source, sint16 size=256, sint16 bits=4, bool fast = FALSE);
    sint32    Max()             { if (waveData && waveData->Data()) return maxFrame; return 0; }
    void      Delete()          { FreeSpace(); frameSize=0; offset = 0; }
    uint32    StartPos()        { if (waveData && waveData->Data()) return offset; return 0; }
    uint32    Size()            { if (waveData && waveData->Data()) return frameSize; return 0;}
    sint16    BitRate()         { return bitRate; }
    void      BitRate(sint16 b) { bitRate = Clamp(b, XDAC_MIN_BITRATE, XDAC_MAX_BITRATE);}
    sint32    Size(sint16 s);
    uint32    EndPos()          { if (waveData && waveData->Data()) return offset+(frameSize*channels); return (frameSize*channels); }

    // Frame positioning
    void          First();
    void          Last();
    XDACENCODE&   operator++(int);
    XDACENCODE&   operator--(int);

    sint32        Write(XSFIO& file); // writes encoded frame to XSF stream

  public:
    XDACENCODE() : flags(0), waveData(0), frameSize(0), offset(0), workspace(0) { }
    XDACENCODE(PCM& source, sint32 size, sint16 bits=4, bool fast=FALSE);
    ~XDACENCODE();
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XDAC
//    This is the end user class. It provides decode only and implements XSFIO.
//
//    Read(XSFIO& f)  reads from an open XSF stream
//    Write(XSFIO& f) writes to an open XSF stream
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// global options
#define XDAC_G_CHANS(v)               ((v)&0x0003)
#define XDAC_G_SINGLE_CHANNEL         0             // single channel only
#define XDAC_G_CHANS_ALWAYS_MERGED    1             // channels merged in a frame, sharing same delta table
#define XDAC_G_CHANS_ALWAYS_SEPERATE  2             // channels stored individually in alternating frames
#define XDAC_G_CHANS_FRAME_DEPENDENT  3             // channels stored merged or individually on a per frame basis

// Normal frame types
#define XDAC_TABLESIZE(v)     (((v)&0x001F)+1)
#define XDAC_BITRATE(v)       ((((v)&0x0300)>>8)+2)
#define XDAC_CHANNEL(v)       (((v)&0x0C00)>>10)
#define XDAC_CHANNELS(v)      ((((v)&0x0C00)>>10)+1)
#define XDAC_INDIVIDUAL(v)    ((v)&0x1000)

#define XDAC_SETTABLE(v)      (((v)-1)&0x001F)
#define XDAC_SETBITRATE(v)    ((((v)-2)&0x0003)<<8)
#define XDAC_SETCHANNEL(v)    ((((v)-1)&0x0003)<<10)
#define XDAC_SETINDIVIDUAL    (0x0100)

#define XDAC_DEBUG_FRAMES // inserts frame checking in decode routines, remove once fully tested

// Silent frame type - length is in frame units;
#define XDAC_SILENCE(v)       ((v)&0x8000)
#define XDAC_SLNC_INDIV(v)    ((v)&0x4000)
#define XDAC_SLNC_CHAN(v)     (((v)&0x3000)>>12)
#define XDAC_SLNC_CHNS(v)     ((((v)&0x3000)>>12)+1)
#define XDAC_SLNC_LEN(v)      ((v)&0x0FFF)
#define XDAC_SILENT           (0x8000)
#define XDAC_SLNT_INDIV       (0x4000)
#define XDAC_SET_SLNT_C(v)    ((((v)-1)&0x0003)<<12)
#define XDAC_RESERVED         0xF0E0 // so far these bits are not used, we can use to test alignment errors

class XDAC : public XSFOBJ {

  private:
    // this data portion is xsf persistent. Putting it into a structure allows easier XSF RawSize evaluation
    struct SHARED {
      sint32  numFrames;
      uint16  frameLen;
      uint16  channels;
      uint16  frequency;
      uint16  globalOpts;
      SHARED() : numFrames(0), frameLen(0), channels(0), frequency(0), globalOpts(0) {}
      SHARED(sint32 n, sint16 l, uint16 c, uint16 f, uint16 g) : numFrames(n), frameLen(l), channels(c), frequency(f), globalOpts(g) {}
    } shared;

  private:
    uint16* ownData;
    uint16* data;
    uint16* current;
    sint32  frameNum;
    sint32  DecodeMergedStereo(sint16* dest, sint32 num); // optimised for merged stereo streams

  protected:
    sint32  DecodeMonoFrames(sint16* dest, sint32 num);   // optimised for single channel
    sint32  DecodeMergedFrames(sint16* dest, sint32 num); // optimised decode for channels merged in all frames
    sint32  DecodeAlternFrames(sint16* dest, sint32 num); // optimised decode for individual channels in alternating frames
    sint32  DecodeEitherFrames(sint16* dest, sint32 num); // general per frame case

  protected:
    sint32  WriteBody(XSFIO& f);
    sint32  ReadBody(XSFIO& f);

  protected:
    sint32  Frame() { return data ? frameNum : ERR_RSC_UNAVAILABLE; }
    sint32  Frame(sint32 f);

  public:
    sint32  TotalFrames() { return shared.numFrames; }
    uint16  FrameLength() { return shared.frameLen; }
    uint16  Channels()    { return shared.channels; }
    uint16  Frequency()   { return shared.frequency; }

    sint32  DecodeFrames(sint16* dest, sint32 start=0, sint32 num=0);

  public:
    XDAC();
    XDAC(sint32 frames, sint16 len, uint16 ch, uint16 fq, uint16* dat, uint16 opts=0);
    ~XDAC() { if (ownData) MEM::Free(ownData); }
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  basic XDACCODEC interface, provides basic interface for encoding and decoding xDAC files
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class XDACCODEC : public XDACENCODE {

  protected:
    sint32 Expand(sint16* src, sint16* d);

  public:
    sint32 Encode(const char* file, PCM& pcm, bool fast=FALSE);
    sint32 Decode(const char* file, PCM& pcm);

  public:
    XDACCODEC() : XDACENCODE() {}
    XDACCODEC(sint32 size, sint32 bits);
    ~XDACCODEC();
};

#endif
