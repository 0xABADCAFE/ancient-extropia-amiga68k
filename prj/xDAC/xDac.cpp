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


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XDAC : XSFOBJ based stream class
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

char xDAC_XSFDesc[] = "eXtropia Delta Audio Compression";

XDAC::XDAC() : XSFOBJ(xDAC_XSFDesc, T_sound, T_xDAC, XDAC_VERSION, XDAC_REVISION),
							 shared(), ownData(0), data(0), current(0), frameNum(0)
{
	RawSize(sizeof(shared));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

XDAC::XDAC(sint32 n, sint16 l, uint16 c, uint16 f, uint16* d, uint16 g) : XSFOBJ(xDAC_XSFDesc, T_sound, T_xDAC, XDAC_VERSION, XDAC_REVISION),
			shared(n, l, c, f, g), ownData(0), data(d), current(0), frameNum(0)
{
	RawSize(sizeof(shared));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDAC::ReadBody(XSFIO& f)
{
	if (ownData)
		MEM::Free(ownData);
	sint32 size = RawSize()-sizeof(shared);

#ifdef PARANOID
	data=0;
	if ( size<=sizeof(shared) )
	{
		#ifdef X_VERBOSE
		cerr << "XDAC::ReadBody() : got a nonsense rawSize\n";
		#endif
		return ERR_FILE_READ;
	}
#endif

	data = ownData = (uint16*)MEM::Alloc(size); // allocate memory for data
	if (!data)
	{
#ifdef X_VERBOSE
		cerr << "XDAC::ReadBody() : couldn't allocate " << size << " bytes of memory for data\n";
#endif
		return ERR_NO_FREE_STORE;
	}
	// Load the data
	size/=sizeof(sint16);
	f.Read32(&(shared.numFrames),1);
	f.Read16(&(shared.frameLen), 4);

	if (shared.channels<1 || shared.channels>4)
	{
#ifdef X_VERBOSE
		cerr << "XDAC::ReadBody() : Unsupported number (" << shared.channels << ") of channels\n";
#endif
		return ERR_FILE_READ;
	}

	if (f.Read16(data, size)!=size)
	{
#ifdef X_VERBOSE
		cerr << "XDAC::ReadBody() : Read incorrect amount of data\n";
#endif
		return ERR_FILE_READ;
	}

	frameNum = 0;
	current = data;
	return RawSize();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDAC::WriteBody(XSFIO& f)
{
	if (!f.Valid())
		return ERR_FILE_WRITE;

	f.Write32(&(shared.numFrames),1);
	f.Write16(&(shared.frameLen), 4);
	if (data)
	{
		sint32 size = (RawSize()-sizeof(shared))/sizeof(sint16);
		if (f.Write16(data, size)!=size)
		{
#ifdef X_VERBOSE
			puts("XDAC::WriteBody() : Wrote incorrect amount of data");
#endif
			return ERR_FILE_WRITE;
		}
	}
	return RawSize();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDAC::Frame(sint32 f)
{
	if (!data)
		return ERR_RSC_UNAVAILABLE;

	if (f==frameNum)
		return OK;
	f = Clamp(f, 0, shared.numFrames);

	// Jumping to a frame directly is not possible since stream contains packets of
	// different sizes. The only option is to seek through the stream to the required
	// location. However, only the start and current frame addresses are known.
	// Also, we can only scan forwards due to the fact that there is no way to know
	// for sure what the preceeding frame start address is.
	// Can only jump to non-silent frames

	// TO DO
	// Support for per frame channel spec

	rsint32		scan = f;
	ruint16*	pos = data;
	{
		sint32 t = abs(f-frameNum);
		if (t < scan)
		{
			scan = t;
			pos = current;
		}
		scan++;
	}
	while(--scan)
	{
		ruint16 c = *pos;
		if (XDAC_SILENCE(c))
		{
			pos+= XDAC_SLNC_LEN(c);
		}
		else
		{
			rsint16 spw = (8*sizeof(sint16))/XDAC_BITRATE(c);
			rsint32 skip = shared.frameLen*shared.channels;
			pos += ((skip/spw) + ((skip%spw)?1:0) + XDAC_TABLESIZE(c) + shared.channels);
		}
	}
	frameNum = f;
	current = pos;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDAC::DecodeFrames(sint16* dest, sint32 start, sint32 num)
{
	if (!num)		num = shared.numFrames;
	if (start)	Frame(start);
	switch (XDAC_G_CHANS(shared.globalOpts))
	{
		case XDAC_G_SINGLE_CHANNEL:
			return DecodeMonoFrames(dest,num);
			break;
		case XDAC_G_CHANS_ALWAYS_MERGED:
			if (shared.channels==2)
				return DecodeMergedStereo(dest,num); // optimised
			else
				return DecodeMergedFrames(dest,num);
			break;
		case XDAC_G_CHANS_ALWAYS_SEPERATE:
			return DecodeAlternFrames(dest,num);
			break;
		case XDAC_G_CHANS_FRAME_DEPENDENT:
			return DecodeEitherFrames(dest,num);
			break;
	}
	return ERR_RSC;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XDACCODEC Simple bidirectional codec. Uses both XDACENCODE and XDAC
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

XDACCODEC::XDACCODEC(sint32 size, sint32 bits) : XDACENCODE()
{
	frameSize	= Clamp(size, 32, 1024);
	bitRate		= Clamp(bits, 2, 5);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

XDACCODEC::~XDACCODEC()
{
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDACCODEC::Encode(const char* file, PCM& pcm, bool fast)
{
	if (!pcm.Data())
		return ERR_PTR_ZERO;

	if (Set(pcm, frameSize, bitRate, fast)!=OK)
		return ERR_RSC_UNAVAILABLE;

	//cout << "Creating XSF XDAC file '" << file << "'\n";

	XSFBASIC output(XDAC_IDSTRING, XDAC_VERSION, XDAC_REVISION, XDAC_DATAFORMAT, XDAC_FILEFORMAT);

	output.Create(file);
	if (!output.Valid())
		return ERR_FILE_CREATE;
	sint32 filePos = output.Tell();

	XDAC dummy(1+maxFrame, frameSize, pcm.Channels(), pcm.Frequency(), 0,	\
						((pcm.Channels()>1) ? XDAC_G_CHANS_ALWAYS_MERGED : XDAC_G_SINGLE_CHANNEL));

	dummy.Write(output);

	//cout << "\nBit rate " << bitRate <<"\nChannels " << channels << ", Frequency " << pcm.Frequency() << ", Frame size " << frameSize << "\nTotal frames " << 1+maxFrame << "\n\n";

	sint32 totSize = 0;
	First();
	for (sint32 i=0; i<=maxFrame; i++)
	{
		sint32 size = Write(output);
		if (size<0)
		{
			output.Close();
			return ERR_FILE_WRITE;
		}
		totSize += size;
		(*((XDACENCODE*)this))++;
/*
		if ((i & 15)==0)
			cout << "\rEncoding " << i << "/" << maxFrame;
*/
	}
	// Go back and write the raw size info
	totSize *= sizeof(uint16); // All data items were 16 bits
	totSize += dummy.RawSize();

	//cout << "\rCompressed stream size " << totSize << " bytes\n";

	output.Seek(filePos+XSFOBJ_FILEOFFSET_RAWSIZE, xIOS::START);
	output.Write32(&totSize,1);
	output.Close();

	//cout << "Encoding finished\n";
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XDACCODEC::Decode(const char* file, PCM& pcm)
{
	if (pcm.Data())
	{
#ifdef X_VERBOSE
		cerr << "XDACCODEC::Decode() : PCM object in use\n";
#endif
		return ERR_PTR_USED;
	}
	XSFBASIC input(XDAC_IDSTRING, XDAC_VERSION, XDAC_REVISION, XDAC_DATAFORMAT, XDAC_FILEFORMAT);
	input.Open(file, FALSE, xIOS::READ);
	if (!input.Valid())
	{
#ifdef X_VERBOSE
		cerr << "XDACCODEC::Decode() : Unable to open '" << file << "'\n";
#endif
		return ERR_FILE_OPEN;
	}
	XDAC source;
	if (source.Read(input)<0)
	{
#ifdef X_VERBOSE
		cerr << "XDACCODEC::Decode() : Error loading '" << file << "'\n";
#endif
	}
	input.Close();

#ifdef X_VERBOSE
	cout << "\nDecoding xDAC file '" << file << "'\nChannels " << source.Channels() << ", Frequency " << source.Frequency() << ", Frame size " << source.FrameLength() << "\nTotal frames " << source.TotalFrames() << "\n\n";
#endif
	sint32 space = source.TotalFrames()*source.FrameLength();
	if (pcm.New(space, source.Channels(), source.Frequency())!=OK)
	{
#ifdef X_VERBOSE
		cerr << "XDACCODEC::Decode() : Couldn't initialise PCM\n";
#endif
		return ERR_RSC_UNAVAILABLE;
	}
	sint16* destData = pcm.Data();
	if (!destData)
	{
#ifdef X_VERBOSE
		cerr << "XDACCODEC::Decode() : Couldn't get PCM handle (memory shortage)\n";
#endif
		return ERR_NO_FREE_STORE;
	}
/*
#ifdef XP_AMIGAOS
	xTIMER t;
	t.Set();
#endif
*/
	source.DecodeFrames(destData);
/*
#ifdef XP_AMIGAOS
	sint32 timeTaken = t.ElapsedSet();
	cout << "Complete decode took " << timeTaken << " ms\n";
#endif
*/
	return OK;
}
