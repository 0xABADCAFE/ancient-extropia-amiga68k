//*****************************************************************//
//** Description:   extropia audio classes                       **//
//**                AmigaOS/68K 3.x level implementation         **//
//** First Started: 2000-12-24                                   **//
//** Last Updated:  2001-03-21                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xSystem/xAudio.hpp>
#include <xSystem/IOLib.hpp>
#include <stdlib.h>

char* PCM::rawSig = "Raw16Bit";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::Free()
{
	if (data)
	{
		MEM::Free(data);
		data = 0;
		biggest = 0;
		//cout << "PCM::Free() : Deallocated OK\n";
	}
	else
		//cout << "PCM::Free() : No data to free\n";
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::New(sint32 size, sint32 chn, sint32 frq)
{
	// System actually only allocates memory when we first request a handle through Data().
	// Delete() leaves the memory allocated, such that subsequent calls to New() just use
	// the same memory over, unless the new size is either bigger or less than half the
	// current largest allocation. This is to help avoid fragmentation. Of course, destroying
	// the object always frees the memory.

	Channels(chn);
	Frequency(frq);
	size*=chn;
	if (size <= 0)
	{
		//cout << "PCM::New(sint32 size) : illegal size\n";
		return ERR_VALUE_MIN;
	}
	if (size > (biggest>>1) && size <= biggest)
	{
		//cout << "PCM::New(sint32 size) : size within biggest/2 - biggest\n";
		numData = size;
		return OK;
	}
	else
	{
		//cout << "PCM::New(sint32 size) : size outside biggest/2 - biggest\n";
		if (data)
			Free();
		numData = size;
		return OK;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::Delete(bool f)
{
	if (f)
		Free();
	numData = 0;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint16* PCM::Data()
{
	// Allocates memory on first call.
	if (numData == 0)
		return 0;
	if (data == 0)
	{
		data = (sint16*)MEM::Alloc(numData*sizeof(sint16), false);
		if (data)
		{
			//cout << "PCM::Data() : Allocated " << numData <<" samples\n";
			biggest = numData;
		}
		else
		{
			//cout << "PCM::Data() : Allocation failed\n";
			biggest = 0;
		}
	}
	return data;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::LoadRaw16(const char* filename, uint16 freq, sint16 chan)
{
	// Will replace existing buffer if loading sucessfull
	xFILEIO src(filename, xFILEIO::READ);
	if (!src.Valid())
	{
		//cout << "PCM::LoadRaw16() unable to open '" << filename << "'\n";
		return ERR_FILE_OPEN;
	}
	sint32 fileSize = src.Size();
	//cout << "PCM::LoadRaw16() File '" << filename << "' " << fileSize << "bytes\n";

	char sig[10] = {0};

	if (src.Read(sig,1,8)<8)
	{
		//cout << "PCM::LoadRaw16() unable to read '" << filename << "'\n";
		return ERR_FILE_OPEN;
	}
	if (strncmp(sig,rawSig,8))
	{
		//cout << "PCM::LoadRaw16() File '" << filename << "' has bad signature\n";
		return ERR_FILE_OPEN;
	}
	Delete();
	New((fileSize-8)/2);

	void* buf = Data();
	if (!buf)
	{
		//cout << "PCM::LoadRaw16() unable to load '" << filename << "', insufficient memory\n";
		return ERR_NO_FREE_STORE;
	}
	sint32 len = src.Read16(Data(), numData);
	src.Close();

	if (len < numData)
		numData = len;

	Frequency(freq);
	Channels(chan);

	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::SaveRaw16(const char* filename)
{
	xFILEIO dst(filename, xFILEIO::WRITE);
	if (!dst.Valid())
		return ERR_FILE_CREATE;

	if (dst.Write(rawSig,1,8)!=8)
		return ERR_FILE_WRITE;
	void* buf = Data();
	if (dst.Write16(buf, numData)==numData)
		return OK;
	return ERR_FILE_WRITE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::DeBias()
{
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::Normalize(float32 level)
{
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xPCM::xPCM() : XSFOBJ("eXtropia PCM audio", T_sound, T_xPCM, XPCM_VERSION, XPCM_REVISION), shared(), data(0)
{
	RawSize(sizeof(shared));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xPCM::xPCM(uint32 s, sint32 c, sint32 b, sint32 f) : XSFOBJ("eXtropia PCM audio", T_sound, T_xPCM, XPCM_VERSION, XPCM_REVISION),
					 shared(s, c, b, f), data(0), size(0)
{
	if (s)
		New(s, c, b, f);
	if (data)
		RawSize(sizeof(shared)+size);
	else
		RawSize(sizeof(shared));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xPCM::New(uint32 s, sint32 c, sint32 b, sint32 f)
{
	if (data)
		MEM::Free(data);
	if (b<9)
		size = s*c;
	else if (b<17)
		size = s*c*sizeof(sint16);
	else
		size = s*c*sizeof(sint32);
	data = MEM::Alloc(size, false);
	if (!data)
	{
		shared.samples = size = 0;
		return ERR_NO_FREE_STORE;
	}
	shared.samples = s;
	shared.bits = Clamp(b, 8, 32);
	shared.chan = Clamp(c, 1, XPCM_MAXCHANS);
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xPCM::Delete()
{
	if (data)
		MEM::Free(data);
	data = 0;
	size = 0;
	shared.samples = 0;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32	xPCM::WriteBody(XSFIO& f)
{
	if ( (f.Write32(&(shared.samples),1)!=1) || (f.Write16(&(shared.freq),1)!=1) || (f.Write8(&(shared.chan),2)!=2) )
		return ERR_FILE_WRITE;
	sint32 r=0, eSize = 1;
	if (shared.bits < 9)
		r = f.Write8(data, shared.samples*shared.chan);
	else if (shared.bits < 17)
	{
		r = f.Write16(data, shared.samples*shared.chan); eSize = sizeof(sint16);
	}
	else
	{
		r = f.Write32(data, shared.samples*shared.chan); eSize = sizeof(sint32);
	}
	if (r<0)
		return r; // error report
	return sizeof(shared)+(r*eSize); // bytes written
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32	xPCM::ReadBody(XSFIO& f)
{
	{
		SHARED temp;
		if ( (f.Read32(&(temp.samples),1)!=1) || (f.Read16(&(temp.freq),1)!=1) || (f.Read8(&(temp.chan),2)!=2) )
			return ERR_FILE_READ;
		if (New(temp.samples, temp.chan, temp.bits, temp.freq)!=OK)
			return ERR_NO_FREE_STORE;
	}
	sint32 r=0, eSize = 1;
	if (shared.bits < 9)
		r = f.Read8(data, shared.samples*shared.chan);
	else if (shared.bits < 17)
	{
		r = f.Read16(data, shared.samples*shared.chan); eSize = sizeof(sint16);
	}
	else
	{
		r = f.Read32(data, shared.samples*shared.chan); eSize = sizeof(sint32);
	}
	if (r<0)
		return r; // error report
	return sizeof(shared)+(r*eSize); // bytes read
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xPCM::DeBias()
{
	// removes any DC component present
	if (!data)
		return ERR_PTR_ZERO;

	sint32 bias[XPCM_MAXCHANS] = {0};
	if (shared.bits < 9)
	{
		rsint8* p = (sint8*)data;
		for (ruint32 s=0; s<shared.samples; s++)
		{
			rsint32 c=shared.chan; rsint32* b=bias;
			while(c--)
				*b++ += (sint32)(*p++);
		}

		for (s=0; s<shared.chan; s++)
			bias[s] = (-bias[s])/shared.samples;

		p = (sint8*)data;
		for (s=0; s<shared.samples; s++)
		{
			rsint32 c=shared.chan; rsint32* b=bias;
			while(c--)
			{
				rsint32 v = (*p)+(*b++);
				*p++ = Clamp(v, -127, 127);
			}
		}
	}
	else if (shared.bits < 17)
	{
		rsint16* p = (sint16*)data;
		for (ruint32 s=0; s<shared.samples; s++)
		{
			rsint32 c=shared.chan; rsint32* b=bias;
			while(c--)
				*b++ += (sint32)(*p++);
		}

		for (s=0; s<shared.chan; s++)
			bias[s] = (-bias[s])/shared.samples;

		p = (sint16*)data;
		for (s=0; s<shared.samples; s++)
		{
			rsint32 c=shared.chan; rsint32* b=bias;
			while(c--)
			{
				rsint32 v = (*p)+(*b++);
				*p++ = Clamp(v, -65535, 65535);
			}
		}
	}
	else
	{
		rsint32* p = (sint32*)data;
		for (ruint32 s=0; s<shared.samples; s++)
		{
			rsint32 c=shared.chan; rsint32* b=bias;
			while(c--)
				*b++ += *p++;
		}

		for (s=0; s<shared.chan; s++)
			bias[s] = (-bias[s])/shared.samples;

		p = (sint32*)data;
		for (s=0; s<shared.samples; s++)
		{
			rsint32 c=shared.chan; rsint32* b=bias;
			while(c--)
			{
				rsint32 v = (*p)+(*b++);
				*p++ = v;
			}
		}
	}
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xPCM::Normalize(float32 level)
{
	if (!data)
		return ERR_PTR_ZERO;
/*
	if (shared.bits < 9)
	{
		rsint8* p = (sint8*)data;
	}
	else if (shared.bits < 17)
	{
	}
	else
	{
	}
*/
	return OK;
}