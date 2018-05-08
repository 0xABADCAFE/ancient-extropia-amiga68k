//*****************************************************************//
//** Description:   extropia audio classes                       **//
//**                AmigaOS/68K 3.x level implementation         **//
//** First Started: 2000-12-24                                   **//
//** Last Updated:  2001-03-21                                   **//
//** Author         C++ OOP version Karl Churchill               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//**                Original ASYNCIO C code (C) 1999 Amiga Inc.  **//
//*****************************************************************//

#ifndef _XSYSTEM_AUDIO_HPP
#error You must only include the <xSystem/xAudio.hpp> stub
#endif

#ifndef _XSYSTEM_AUDIO68K_HPP
#define _XSYSTEM_AUDIO68K_HPP

extern "C" {
	#include <exec/devices.h>
	#include <devices/ahi.h>
}

extern	LIBRARY				*AHIBase;	// Sound Card extensions

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef AHIRequest* sysSOUND;

class xAUDIO {

	private:
		static MsgPort*			AHIport; // reply port for AHI
		static AHIRequest*	AHImain; // used for opening AHI
		static uint32				flags;

		enum {
			PORT_ERR		= 0x00000001,
			IOREQ_ERR		= 0x00000002,
			DEVICE_ERR	= 0x00000004,
			AUDIO_ERR		= 0x0000000F
		};

	protected:
		static sysSOUND			Play(void* data, uint16 freq, float32 vol, float32 pan);
		static bool					IsPlaying(sysSOUND);
	public:
		static sint32 Init();
		static sint32 Done();
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include <Platforms/Amiga68K/SoundLib/PCM.hpp>

#endif