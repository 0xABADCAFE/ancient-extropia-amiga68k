//****************************************************************************//
//** File:         IOLib.hpp ($NAME=IOLib.hpp)                              **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      xIO                                                      **//
//** Created:      2001-08-27                                               **//
//** Updated:      2002-01-23                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#ifndef _XSYSTEM_IOLIB68K_HPP
#define _XSYSTEM_IOLIB68K_HPP

// OS resources not included by sysBase
extern "C" {
	#include <proto/keymap.h>
}

class xKEY {
	private:
		static sint32 useCount;
	protected:
		static sint32	KeyToChar(IntuiMessage* m);
	public:
		enum {
			SPACE		= 0x40,
			BACKSP	= 0x41,
			TAB			= 0x42,
			ENTER		= 0x44,
			ESC			= 0x45,
			DEL			= 0x46,
			UP			= 0x4C,
			DOWN		= 0x4D,
			RIGHT		= 0x4E,
			LEFT		= 0x4F,
			F1			= 0x50,
			F2			= 0x51,
			F3			= 0x52,
			F4			= 0x53,
			F5			= 0x54,
			F6			= 0x55,
			F7			= 0x56,
			F8			= 0x57,
			F9			= 0x58,
			F10			= 0x59,
			SHIFTL	= 0x60,
			SHIFTR	= 0x61,
			CAPSL		= 0x62,
			CTRL		= 0x63,
			ALTL		= 0x64,
			ALTR		= 0x65,
			AMIGAL	= 0x66,
			AMIGAR	= 0x67,
			NP_0		= 0x0F,
			NP_1		= 0x1D,
			NP_2		= 0x1E,
			NP_3		= 0x1F,
			NP_4		= 0x2D,
			NP_5		= 0x2E,
			NP_6		= 0x2F,
			NP_7		= 0x3D,
			NP_8		= 0x3E,
			NP_9		= 0x3F,
			NP_INS	= 0x0F,
			NP_END	= 0x1D,
			NP_DEL	= 0x3C,
			NP_PNT	= 0x3C,
			NP_ENT	= 0x43,
			NP_MINUS= 0x4A,
			NP_PLUS	=	0x5E,
			WINDOZE	= 0x7F
		};
		bool					Valid()	{ return (useCount>0); }
		virtual void	KeyEvent(sint32 keyCode, bool state, sint32 ch) = 0;

	public:
		xKEY();
		virtual ~xKEY();
};

typedef enum {
	XMOUSE_KEY1					= 0x00000001,
	XMOUSE_KEY2					= 0x00000002,
	XMOUSE_KEY3					= 0x00000004,
	XMOUSE_KEY4					= 0x00000008,
	XMOUSE_KEY5					= 0x00000010,
	XMOUSE_YWHEEL_UP		= 0x00010000,
	XMOUSE_YWHEEL_DOWN	= 0x00020000,
	XMOUSE_XWHEEL_LEFT	= 0x00040000,
	XMOUSE_XWHEEL_RIGHT	= 0x00080000
} XMOUSEBITS;

class xMOUSE {

};

#define XMOUSE_LEFT		XMOUSE_KEY1
#define XMOUSE_CENTRE XMOUSE_KEY2
#define XMOUSE_RIGHT	XMOUSE_KEY3

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xINPUT : Principal user input interface
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class xINPUT : public xKEY {
	protected:
		uint32	inputMask;

		// Derived class must override this
		virtual void		ApplyInputModification() = 0;

	public:
		// input properties
		enum {
			IKEYBOARD				= 0x00000001,	// respond to keyboard
			IMOUSELEFT			= 0x00000002,	// respond to left mouse
			IMOUSECENTRE		= 0x00000004,	// respond to centre mouse
			IMOUSERIGHT			= 0x00000008,	// respond to right mouse
			IMOUSEKEYMOVE		= 0x00000010,	// respond to mouse movements whilst left/centre/right button active
			IMOUSEIDLEMOVE	= 0x00000020,	// respond to mouse movements whilst no buttons active (idle)
			IMOUSENOCLIP		= 0x00000040, // respond to mouse movements outside the display area (windowed displays)
			ICLOSE					= 0x00000080,	// respond to close gadget (if present)
			IMOUSEMOVE			= IMOUSEKEYMOVE|IMOUSEIDLEMOVE,
			IMOUSEKEYS			= IMOUSELEFT|IMOUSECENTRE|IMOUSERIGHT,
			IDEFAULT				= IKEYBOARD|IMOUSEKEYS|ICLOSE
		};
		uint32				InputMask()					{ return inputMask; }
		uint32				SetInput(uint32 f)	{ uint32 m = inputMask; inputMask |= f; ApplyInputModification(); return m; }
		uint32				ClrInput(uint32 f)	{ uint32 m = inputMask; inputMask &= ~f; ApplyInputModification(); return m; }

		// Derived class must override these
		//virtual void	KeyEvent(sint32 keyCode, bool state, sint32 ch) = 0;
		virtual void	MouseEvent(sint32 x, sint32 y, sint32 buttons) = 0;
		virtual void	ExitEvent() = 0;

		// Wait mechanism that returns when an event occurs
		virtual void	Idle() = 0;
		virtual bool	InputQueued() = 0; // Returns true whilst input messages are waiting.
	public:
		xINPUT() : xKEY(), inputMask(IDEFAULT) {}
		~xINPUT() { }
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Basic IO stream defs
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xIOS {

	public:
		enum {
			OPEN_READ		= 0x00000001,
			OPEN_WRITE	= 0x00000002,
			OPEN_APPEND = 0x00000004,
			OPEN_EXIST	= 0x00000005,
			OPEN_ANY		= 0x00000007,
			WAIT_PACKET = 0x00000008,
			FILE_ATEND	= 0x00000010,
			FILE_START	= 0x00000020,
			FILE_GOOD		= 0x00000040,
			BUFF_ERROR	= 0x00010000
		};
		enum {
    	READ				= 0x0000001,
	    WRITE				= 0x0000002,
	    APPEND			= 0x0000004,
			READTEXT		= 0x0000001,// AmigaOS treats text == binary, other implementations may not
			WRITETEXT		= 0x0000002,
			APPENDTEXT	= 0x0000004
		};
		enum {
  	  START = -1,
	    CURRENT,
	    END
		};
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xFILEIO
//
//  Implements a high performance FILE like IO. This particular implementation uses asynchronous double buffering for IO requests
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xFILEIO : public xIOS {
	private:
		void*						bufferSpace;
		sint32					fileSize;
		BPTR						af_File;
		uint32					af_BlockSize;
		MsgPort*				af_Handler;
		void*						af_Offset;
		sint32					af_BytesLeft;
		uint32					af_BufferSize;
		void*						af_Buffers[2];
		StandardPacket	af_Packet;
		MsgPort					af_PacketPort;
		uint32					af_CurrentBuf;
		uint32					af_SeekOffset;
		uint32					flags;

		sint32					WaitPacket();
		void						SendPacket(void* arg2);
		void						RequeuePacket();
		void						RecordSyncFailure();

	public:
		static	bool Exists(const char* fileName);
		sint32	Open(const char* fileName, sint32 mode=READ, sint32 bufferSize=1024);
		sint32	OpenText(const char* fileName, sint32 mode = READTEXT, sint32 bufferSize=1024)		{ return Open(fileName, mode, bufferSize); }
		sint32	Create(const char* fileName, sint32 mode = WRITE, sint32 bufferSize=1024)					{ return Open(fileName, mode, bufferSize); }
		sint32	CreateText(const char* fileName, sint32 mode = WRITETEXT, sint32 bufferSize=1024)	{ return Open(fileName, mode, bufferSize); }
		bool		Valid()																																						{ return flags & FILE_GOOD; }
		bool		EndOfFile() 																																			{ return flags & FILE_ATEND; }
		bool		StartOfFile()																																			{ return flags & FILE_START; }
		sint32	Seek(sint32 position, sint32 mode=START);
		sint32	Tell();
		sint32	Size() 																																						{ return (flags & OPEN_EXIST) ? fileSize : ERR_FILE; }
		sint32	GetChar();
		sint32	PutChar(uint8 ch);
		sint32	Read(void* buffer, size_t s, size_t n);
		sint32	Read8(void* d,size_t n)																														{ return Read(d,1,n); }
		sint32	Read16(void* d,size_t n)																													{ return Read(d,2,n); }
		sint32	Read32(void* d,size_t n)																													{ return Read(d,4,n); }
		sint32	Read64(void* d,size_t n)																													{ return Read(d,8,n); }
		sint32	Read16Swap(void* d,size_t n);
		sint32	Read32Swap(void* d,size_t n);
		sint32	Read64Swap(void* d,size_t n);
		sint32	ReadText(char*buf, sint32 max, char mark=0, sint32 num=-1); // read until max chars or 'mark' occured num times
		sint32	Write(void* buffer, size_t s, size_t n);
		sint32	Write8 (void* d,size_t n)																													{ return Write(d,1,n); }
		sint32	Write16(void* d,size_t n)																													{ return Write(d,2,n); }
		sint32	Write32(void* d,size_t n)																													{ return Write(d,4,n); }
		sint32	Write64(void* d,size_t n)																													{ return Write(d,8,n); }
		sint32	Write16Swap(void* d,size_t n);
  	sint32	Write32Swap(void* d,size_t n);
		sint32	Write64Swap(void* d,size_t n);
		sint32	WriteText(char* format,...);
		sint32	Flush();
		sint32	Close();

	public:
		xFILEIO() : flags(0), bufferSpace(0) {}
		xFILEIO(const char* fileName, sint32 mode, sint32 bufferSize=1024) : flags(0), bufferSpace(0) { Open(fileName, mode, bufferSize); }
		~xFILEIO()	{ Close(); }
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline sint32 xFILEIO::GetChar()
{
	if (af_BytesLeft==0)
	{
		sint32 bytesArrived = WaitPacket();
		if (bytesArrived <= 0)
		{
			if (bytesArrived == 0)
			{ // end of file reached
				flags |= FILE_ATEND;
				SetIoErr(0);
				return EOF;
			}
			else
			{
				flags &= ~FILE_GOOD;
				return ERR_FILE_READ;
			}
		}
		// ask that the buffer be filled
		SendPacket(af_Buffers[1-af_CurrentBuf]);
		if (af_SeekOffset > bytesArrived)
			af_SeekOffset = bytesArrived;
		af_Offset      = (void*)((uint32)af_Buffers[af_CurrentBuf] + af_SeekOffset);
		af_CurrentBuf  = 1 - af_CurrentBuf;
		af_BytesLeft   = bytesArrived - af_SeekOffset;
		af_SeekOffset  = 0;
	}
	char ch = *(char*)af_Offset;
	af_BytesLeft--;
	af_Offset = (void*)((uint32)af_Offset + 1);
	return (sint32)ch;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

inline sint32 xFILEIO::PutChar(uint8 ch)
{
	if (af_BytesLeft==0)
	{
		if (WaitPacket() < 0)
		{
			flags &= ~FILE_GOOD;
			return ERR_FILE_WRITE;
		}
		// send the current buffer out to disk
		SendPacket(af_Buffers[af_CurrentBuf]);

		af_CurrentBuf	= 1 - af_CurrentBuf;
		af_Offset			= af_Buffers[af_CurrentBuf];
		af_BytesLeft	= af_BufferSize;
	}

	*(uint8 *)af_Offset = ch;
	af_BytesLeft--;
	af_Offset = (void*)((uint32)af_Offset + 1);
	return 1;
}

#endif
