//****************************************************************************//
//** File:         xResources.hpp ($NAME=xResources.hpp)                    **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      xServices                                                **//
//** Created:      2001-01-20                                               **//
//** Updated:      2001-11-17                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#ifndef _XSYSTEM_SOUND68K_HPP
#define _XSYSTEM_SOUND68K_HPP

#ifndef KARL_FIXES
#error Thread.hpp needs KARL_FIXES defined to compile correctly
#endif

#include <xBase.hpp>
#include <xSystem/ServiceLib.hpp>

// OS resources not included by sysBase

extern "C" {
	#include <exec/devices.h>
	#include <devices/ahi.h>
}

struct DUMMYSOUND {
	size_t	len;
	size_t	pos;
	sint16	vol;
	sint16	data[0];
};

inline DUMMYSOUND*	NewSound(size_t len)
{
	DUMMYSOUND* t = (DUMMYSOUND*)MEM::Alloc(sizeof(DUMMYSOUND)+(len*2), FALSE, FALSE);
	if (t)
	{
		t->len = len;
		t->pos = 0;
		t->vol = 255;
	}
	return t;
}

inline void DelSound(DUMMYSOUND* s)
{
	if(s)	MEM::Free(s);
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MIXER : public THREAD {
	private:
		enum {
			PORT_FAIL	= 0x00000001,
			IORQ_FAIL = 0x00000002,
			OPDV_FAIL = 0x00000004,
			IORQ_USED = 0x00000008,
			IORQ_4EVR	= 0x00000010,
			IORQ_PNDG	= 0x00000020,
		};
		uint32				flags;
		MsgPort*			soundPort;
		union {
			IORequest*	io;
			IOStdReq*		std;
			AHIRequest*	ahi;
		} soundIO[2];
		sysSIGNAL			soundSignal;
		FILE*					debugOut;
		MILLICLOCK		timer;
		sint32*				mix;
		sint16*				out;
		size_t				bufferSize;
		uint16				freq;
		uint8					maxCh;
		uint8					currBuf;
		struct {
			DUMMYSOUND* sound;
			size_t			mixOffset;
		}							chanInfo[16];

	private:
		bool		OpenHardware();
		void		CloseHardware();

		void		Mix();


	protected:
		sint32 Run();

	public:
		void	Play(DUMMYSOUND* s);

		size_t	GetDMAPos();


	public:
		MIXER(size_t bs, uint32 f, uint8 ch);
		~MIXER();
};

#endif