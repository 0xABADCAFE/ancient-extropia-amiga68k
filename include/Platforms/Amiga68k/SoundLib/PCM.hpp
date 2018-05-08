//*****************************************************************//
//** Description:   extropia PCM base class                      **//
//**                AmigaOS/68K 3.x level implementation         **//
//** First Started: 2000-12-24                                   **//
//** Last Updated:  2001-03-21                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _PCM_HPP
#define _PCM_HPP

#include <xBase.hpp>
#include <xsf/xsf.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class PCM {

  private:
    static char* rawSig;

  private:
    sint16* data;       // signed 16-bit audio data samples
    sint32  numData;    // number of samples
    sint32  biggest;    // largest allocation

    sint16  channels;
    uint16  frequency;

  private:
    sint32  Free();

  protected:
    void    Frequency(sint32 f)   { frequency = Clamp(f, 4410, 64000); }
    void    Channels(sint32 c)    { channels = Clamp(c, 1, 4); }

  public:
    // Process
    sint32  DeBias();
    sint32  Normalize(float32 level=1.0F);

    sint16* Data(); // ONLY access data via this method!

    // IO
    sint32  LoadRaw16(const char* filename, uint16 freq=22050, sint16 chan=1);
    sint32  SaveRaw16(const char* filename);

    // Info
    sint32  Size()      { return numData; }
    sint32  Length()    { if (!channels) return 0; return numData/channels; }
    sint16  Channels()  { return channels; }
    sint32  Frequency() { return frequency; }

    sint32  New(sint32 size, sint32 chn=1, sint32 frq=22050);
    sint32  Delete(bool f=true);

    virtual sint32 Load(const char* name) { return LoadRaw16(name); }
    virtual sint32 Save(const char* name) { return SaveRaw16(name); }

  public:
    PCM() : data(0), numData(0), biggest(0) {}
    PCM(sint32 size, sint32 chn=1, sint32 frq=22050) : data(0), numData(0), biggest(0) { New(size,chn,frq); }
    virtual ~PCM()  { Free(); }
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xPCM::  XSF capable waveform class.
//
//    Supports
//      1-8  channels
//      8-32 bits per sample (to nearest 8/16/32 bit, MSB justified)
//      4G   sample size
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define XPCM_VERSION 1
#define XPCM_REVISION 0
#define XPCM_MAXCHANS 8

class xPCM : public XSFOBJ {

  private:
    struct SHARED { // shared with file representaion
      uint32  samples;
      uint16  freq;
      uint8   chan;
      uint8   bits;
      SHARED() : samples(0), freq(0), chan(0), bits(0) {}
      SHARED(uint32 s, uint16 f, uint8 c, uint8 b) : samples(s), freq(f), chan(c), bits(b) {}
    } shared;

    void*   data;
    uint32  size; // size of data block

  protected:
    // required XSFOBJ methods
    sint32  ReadyForWrite()         { if (!data) return ERR_PTR_ZERO; return OK; }
    sint32  WriteBody(XSFIO& f);
    sint32  ReadBody(XSFIO& f);

    // properties control
    void    Frequency(sint32 f)     { shared.freq = Clamp(f, 4410, 64000); }
    void    Channels(sint32 c)      { shared.chan = Clamp(c, 1, XPCM_MAXCHANS); }
    void    BitsPerSample(sint32 b) { shared.bits = Clamp(b, 8, 32); }

  public:
    // channel definitions
    enum {
      CH_LEFT             = 0,  // stereo/triple
      CH_RIGHT            = 1,
      CH_CENTRE           = 2,  // triple
      CH_SURROUND         = 3,  // stereo+mid+surround
      CH_FRONTLEFT        = 0,  // quad
      CH_FRONTRIGHT       = 1,
      CH_BACKLEFT         = 2,
      CH_BACKRIGHT        = 3,
      CH_SUB              = 4,  // quad + sub
      CH_UPPERFRONTLEFT   = 0,  // omni (8-channel!)
      CH_UPPERFRONTRIGHT  = 1,
      CH_UPPERBACKLEFT    = 2,
      CH_UPPERBACKRIGHT   = 3,
      CH_LOWERFRONTLEFT   = 4,
      CH_LOWERFRONTRIGHT  = 5,
      CH_LOWERBACKLEFT    = 6,
      CH_LOWERBACKRIGHT   = 7
    };
    sint32  New(uint32 size, sint32 chn=1, sint32 bps=16, sint32 frq=22050);
    sint32  Delete();
    void*   Data()          { return data; }

    // Info
    sint32  Size()          { return shared.samples; }
    sint32  Length()        { if (!shared.chan) return 0; return shared.samples/shared.chan; }
    sint32  Channels()      { return shared.chan; }
    sint32  Frequency()     { return shared.freq; }
    sint32  BitsPerSample() { return shared.bits; }

    // Process
    sint32  DeBias();                       // removes any DC component
    sint32  Normalize(float32 level=1.0);   // normalizes signal level

  public:
    xPCM();
    xPCM(uint32 size, sint32 chn, sint32 bps, sint32 frq); // zero is acceptable as a size arg, in which case no allocation is done
    virtual ~xPCM() { Delete(); }
};

#endif