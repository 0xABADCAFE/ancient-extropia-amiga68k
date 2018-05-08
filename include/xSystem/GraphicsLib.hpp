//*****************************************************************//
//** Description:   OS Layer classes                             **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2003-01-04                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2003, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XSYSTEM_GRAPHICS_HPP
#define _XSYSTEM_GRAPHICS_HPP

#include <xBase.hpp>

// Portable definitions /////////////////////////////////////////////////////////////////////////////////////////

#define S_XY		sint16 x, sint16 y
#define S_RXY		rsint16 x, rsint16 y
#define S_WH		sint16 w, sint16 h
#define S_RWH		rsint16 w, rsint16 h
#define S_WHF		sint16 x, sint16 h, uint8 f
#define S_RWHF	rsint16 w, rsint16 h, rsint16 f
#define S_RECT	sint16 x, sint16 y, sint16 w, sint16 h
#define S_RECTF	sint16 x, sint16 y, sint16 w, sint16 h, sint16 f

#define S_1CRD	sint16 x, sint16 y
#define S_2CRD	sint16 x1, sint16 y1, sint16 x2, sint16 y2
#define S_3CRD	sint16 x1, sint16 y1, sint16 x2, sint16 y2, sint16 x3, sint16 y3

#define S_CRD1	sint16 x1, sint16 y1
#define S_CRD2	sint16 x2, sint16 y2
#define S_CRD3	sint16 x3, sint16 y3
#define S_CRD4	sint16 x4, sint16 y4

#if (X_ENDIAN == XA_BIGENDIAN)
#define ARGB_A 0
#define ARGB_R 1
#define ARGB_G 2
#define ARGB_B 3
/*
#define ABGR_A 0
#define ABGR_B 1
#define ABGR_G 2
#define ABGR_R 3
#define RGBA_B 0
#define RGBA_G 1
#define RGBA_R 2
#define RGBA_A 3
#define BGRA_B 0
#define BGRA_G 1
#define BGRA_R 2
#define BGRA_A 3
*/
#else
#define ARGB_A 3
#define ARGB_R 2
#define ARGB_G 1
#define ARGB_B 0
/*
#define ABGR_A 3
#define ABGR_B 2
#define ABGR_G 1
#define ABGR_R 0
#define RGBA_B 3
#define RGBA_G 2
#define RGBA_R 1
#define RGBA_A 0
#define BGRA_B 3
#define BGRA_G 2
#define BGRA_R 1
#define BGRA_A 0
*/
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  ARGB32
//    Abstracts a basic ARGB32 colour. Supports per channel access, assignment, operators
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ARGB32 {
	private:
		union {
			uint32 argb;
			uint8  chan[4];
		};
	public:
		ARGB32() : argb(0) {}
		ARGB32(const ARGB32& c)							{ argb = c.argb; }
		ARGB32(uint32 c)										{ argb = c; }
		uint8&	Alpha()											{ return chan[ARGB_A]; }
		uint8&	Red()												{ return chan[ARGB_R]; }
		uint8&	Green()											{ return chan[ARGB_G]; }
		uint8&	Blue()											{ return chan[ARGB_B]; }
		ARGB32& operator=(const ARGB32& c)	{ argb = c.argb; return *this; }
		ARGB32& operator=(uint32 c)					{ argb = c; return *this; }
		operator uint32()										{ return argb; }
		ARGB32& operator+=(const ARGB32& c)
		{
			ruint32 s = 0x000000FF;
			ruint32	v = chan[ARGB_R]+c.chan[ARGB_R];
			chan[ARGB_R] = v>s ? s : v;
			v = chan[ARGB_G]+c.chan[ARGB_G];
			chan[ARGB_G] = v>s ? s : v;
			v = chan[ARGB_B]+c.chan[ARGB_B];
			chan[ARGB_B] = v>s ? s : v;
			return *this;
		}
		ARGB32& operator*=(const ARGB32& c)
		{
			chan[ARGB_R] = ((uint16)chan[ARGB_R]*(uint16)c.chan[ARGB_R])>>8;
			chan[ARGB_G] = ((uint16)chan[ARGB_G]*(uint16)c.chan[ARGB_G])>>8;
			chan[ARGB_B] = ((uint16)chan[ARGB_B]*(uint16)c.chan[ARGB_B])>>8;
			return *this;
		}
		ARGB32& operator*=(float32 f)
		{
			chan[ARGB_R] *= f;	chan[ARGB_G] *= f;	chan[ARGB_B] *= f;
			return *this;
		}
};
/*
inline ARGB32 operator+(const ARGB32& a, const ARGB32& b){ ARGB32 r(a); r+=b; return r; }
inline ARGB32 operator*(const ARGB32& a, const ARGB32& b){ ARGB32 r(a); r*=b; return r; }
*/

// System dependent definitions /////////////////////////////////////////////////////////////////////////////////

#if defined(XP_AMIGAOS)
  #include "Platforms/Amiga68k/GraphicsLib/GfxLib.hpp"
#elif defined(XP_WIN32)
  #include "Platforms/Win32/GraphicsLib/GfxLib.hpp"
#else
  #error "Error: OS Platform Not Defined"
#endif  //Platform Options//

#endif