/*

	Extropia System Library test code by Karlos, eXtropia Studios

*/

#ifndef _PCM_HPP
#define _PCM_HPP

#include <xBase.hpp>
#include <xSystem/xIO.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class PCM {

	private:
		static char* rawSig;

	private:
		sint16*	data;				// signed 16-bit audio data samples
		sint32	numData;		// number of samples
		sint32	biggest;		// largest allocation

		sint16	channels;
		uint16	frequency;
		float32 biasL;
		float32	biasR;

	private:
		sint32	Free();

	protected:
		void		Frequency(sint32 f)		{ frequency = Clamp(f, 11025, 44100); }
		void		Channels(sint32 c)		{ channels = Clamp(c, 1, 2); }

	public:
		// Process
		sint32	DeBias();
		sint32	Normalize(float32 level=1.0F);

		sint16*	Data(); // ONLY access data via this method!

		// IO
		sint32	LoadRaw16(const char* filename, uint16 freq=22050, sint16 chan=1);
		sint32	SaveRaw16(const char* filename);

		// Info
		sint32	Size()			{ return numData; }
		sint16	Channels()	{ return channels; }
		sint32	Frequency()	{ return frequency; }

		sint32	New(sint32 size, sint32 chn=1, sint32 frq=22050);
		sint32	Delete(bool f=TRUE);

	public:
		PCM()	: data(0), numData(0), biggest(0) {}
		PCM(sint32 size, sint32 chn=1, sint32 frq=22050) : data(0), numData(0), biggest(0) { New(size,chn,frq); }
		~PCM()	{ Free(); }
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif