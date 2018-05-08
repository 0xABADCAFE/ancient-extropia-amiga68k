//****************************************************************************//
//** File:         prj/xDAC/APP.hpp ($NAME=APP.hpp)                         **//
//** Description:  xDAC AmigaOS Application class header                    **//
//** Comment(s):                                                            **//
//** Created:      2002-01-20                                               **//
//** Updated:      2002-02-21                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//
#ifndef _APP_HPP
#define _APP_HPP

#include <xBase.hpp>
#include <xSystem/IOLib.hpp>
#include <xSystem/xAudio.hpp>
#include <xSystem/GraphicsLib.hpp> // Drawlist based drawing system

#include "xDac.hpp"
#include "SoundFormats.hpp"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern DRAWLIST draw;
extern xTEXFONT font;

class APPWINDOW : public xDBWIN, public xDISPLAYIO {

	private:
		uint32	flags;
		xCHAIN	drawThings;

		void		MouseEvent(sint32 x, sint32 y, sint32 buttons);
		void		KeyEvent(sint32 keyCode, bool state, sint32 ch);
		void		ExitEvent();
		void		ResizeEvent();
		void		MoveEvent();

		enum {
			DRAW_BOUND	= 0x00000001,
			QUIT				= 0x00010000
		};

	public:
		sint32		AddDrawThing(xDISPLAYABLE& t) { return t.LinkEnd(&drawThings); }
		sint32		Open();
		sint32		Close();
		bool			IsRunning() { return (flags & QUIT)==0; }
		void			Refresh();
		void			Clear();

	public:
		APPWINDOW();
		APPWINDOW(S_RECT, sint16 d, const char* title="xDAC");
		~APPWINDOW();
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class DRAWWAVE : public AIFF, public xDISPLAYABLE {

	private:
		//char			audioName[256]; // Used for holding AHI audio device opts

		// drawing info
		uint32		flags;
		float32		borderTop;
		float32		borderLeft;
		float32		borderRight;
		float32		borderBottom;

		uint32		drawStart;
		uint32		drawRange;
		float32		drawYMag;

		enum {
			SND_PLAY			= 0x00000001,
			SND_STOP			= 0x00000002,
			SND_COMMAND		= 0x0000000F,
			IS_PLAYING		= 0x00000010,
			SND_STATE			= 0x000000F0,
			VIEW_CHANGED	= 0x01000000,
			REDRAW_ME			= 0x02000000
		};

	public:
		// Range Options
		sint32	SetRange(uint32 start, uint32 range, float32 yMag);
		void		ZoomRange(float32 factor);
		void		ZoomY(float32 factor);
		void		ScrollRange(float32 factor);
		uint32	StartPos()	{ return drawStart; }
		uint32	EndPos()		{ return drawStart+drawRange; }
		uint32	Range()			{ return drawRange; }
		float32	YMag()			{ return drawYMag; }

		// Audio
		void		SetFreq(uint32 freq) { Frequency(freq); flags |= REDRAW_ME; }
		sint32	Play(uint32 start, uint32 len, float32 volume=1F, float32 pan=0F);

		sint32	Stop();
		bool		IsPlaying() { return flags & IS_PLAYING; }
		// Visualisation - from xDISPLAYABLE
		sint32	ViewDefine(S_2CRD);
		sint32	ViewClear();
		sint32 	ViewRender();

		DRAWWAVE() : AIFF(), flags(0) { }
		~DRAWWAVE() { }
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class DRAWFRAME : public XDACENCODE, public xDISPLAYABLE {

	private:
		uint32		flags;
		sint32		evaluateTime;
		float32		borderTop;
		float32		borderLeft;
		float32		borderRight;
		float32		borderBottom;

		enum {
			VIEW_CHANGED	= 0x01000000,
			REDRAW_ME			= 0x02000000,
			ENCODING			= 0x04000000
		};

	public:
		// Visualisation - from xDISPLAYABLE
		sint32			ViewDefine(S_2CRD);
		sint32			ViewClear();
		sint32 			ViewRender();
		sint32			Set(PCM& w, sint16 s=256, sint16 b=4, bool f=FALSE) { if (XDACENCODE::Set(w,s,b,f)==OK) Analyse(); return ERR_VALUE; }
		void				First()																							{ flags |= REDRAW_ME; XDACENCODE::First(); Analyse(); }
		void				Last()																							{ flags |= REDRAW_ME; XDACENCODE::Last(); Analyse(); }
		DRAWFRAME&	operator++(int)																			{ flags |= REDRAW_ME; ((XDACENCODE)(*this))++; Analyse(); return *this; }
		DRAWFRAME&	operator--(int)																			{ flags |= REDRAW_ME; ((XDACENCODE)(*this))--; Analyse(); return *this; }
		void				Finished()																					{ flags &= ~ENCODING; }
		void				IncBitRate()																				{ flags |= REDRAW_ME; BitRate(bitRate+1); Analyse(); }
		void				DecBitRate()																				{ flags |= REDRAW_ME; BitRate(bitRate-1); Analyse(); }
		void				IncFrameLen(sint16 n)																{ Size(Size()+n); First(); }
		void				DecFrameLen(sint16 n)																{ Size(Size()-n); First(); }
		sint32			Write(XSFIO& file);
		void				ForceK1()																						{ flags |= REDRAW_ME; XDACENCODE::ForceK1(); Analyse();}
		void				ForceS1()																						{ flags |= REDRAW_ME; XDACENCODE::ForceS1(); Analyse();}
		void				ForceNone()																					{ flags |= REDRAW_ME; XDACENCODE::ForceNone(); Analyse();}
	public:
		DRAWFRAME() : flags(0) {}
		DRAWFRAME(PCM& source, sint32 size, sint16 bits);
		~DRAWFRAME() {}
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class APP {
	private:
		static char*			xDacName;
	public:
		static DRAWWAVE		sourceWave;
		static DRAWFRAME	frame;
		static APPWINDOW	viewWindow;
		static sint32			Init(const char* waveFile, const char* xDac, sint32 frameSize=256, sint32 bitRate=4, bool fast=FALSE);
		static sint32			Done();
		static sint32			EncodeXDAC();
};

#endif