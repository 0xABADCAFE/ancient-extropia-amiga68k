//****************************************************************************//
//** File:         prj/xDAC/SoundFormats.hpp ($NAME=SoundFormats.hpp)       **//
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

#ifndef _SOUNDSUPPORT_HPP
#define _SOUNDSUPPORT_HPP

#include <xBase.hpp>
#include <xSystem/IOLib.hpp>
#include <xSystem/xAudio.hpp>

// AIFF/WAV etc used specific endian formats, which means that we need to define
// IO based on the current architectures endian representation

#if (X_ENDIAN == XA_BIGENDIAN)
	#define READBIG64(f,d,n) (f.Read64((d),(n)))
	#define READBIG32(f,d,n) (f.Read32((d),(n)))
	#define READBIG16(f,d,n) (f.Read16((d),(n)))
	#define WRITEBIG64(f,d,n) (f.Write64((d),(n)))
	#define WRITEBIG32(f,d,n) (f.Write32((d),(n)))
	#define WRITEBIG16(f,d,n) (f.Write16((d),(n)))
	#define READLITTLE64(f,d,n) (f.Read64Swap((d),(n)))
	#define READLITTLE32(f,d,n) (f.Read32Swap((d),(n)))
	#define READLITTLE16(f,d,n) (f.Read16Swap((d),(n)))
	#define WRITELITTLE64(f,d,n) (f.Write64Swap((d),(n)))
	#define WRITELITTLE32(f,d,n) (f.Write32Swap((d),(n)))
	#define WRITELITTLE16(f,d,n) (f.Write16Swap((d),(n)))
#else
	#define READBIG64(f,d,n) (f.Read64Swap((d),(n)))
	#define READBIG32(f,d,n) (f.Read32Swap((d),(n)))
	#define READBIG16(f,d,n) (f.Read16Swap((d),(n)))
	#define WRITEBIG64(f,d,n) (f.Write64Swap((d),(n)))
	#define WRITEBIG32(f,d,n) (f.Write32Swap((d),(n)))
	#define WRITEBIG16(f,d,n) (f.Write16Swap((d),(n)))
	#define READLITTLE64(f,d,n) (f.Read64((d),(n)))
	#define READLITTLE32(f,d,n) (f.Read32((d),(n)))
	#define READLITTLE16(f,d,n) (f.Read16((d),(n)))
	#define WRITELITTLE64(f,d,n) (f.Write64((d),(n)))
	#define WRITELITTLE32(f,d,n) (f.Write32((d),(n)))
	#define WRITELITTLE16(f,d,n) (f.Write16((d),(n)))
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class AIFF : public PCM {
	private:
		sint32	DecodeFreq(void* data);						 // interprets 10-byte float80 to frequency
		void		EncodeFreq(void* data, sint32 f);
	public:
		sint32 Load(const char* name);
		sint32 Save(const char* name);
	public:
		AIFF() : PCM() {}
		AIFF(sint32 size, sint32 chn=1, sint32 frq=22050) : PCM(size, chn, frq) {}
		~AIFF() {}
};

/*
class RIFFWAV : public PCM {

	public:
		sint32 Load(const char* name);
		sint32 Save(const char* name);

	public:
		RIFFWAV() : PCM() {}
		RIFFWAV(sint32 size, sint32 chn=1, sint32 frq=22050) : PCM(size, chn, frq) {}
		~RIFFWAV() {}
};
*/
#endif
