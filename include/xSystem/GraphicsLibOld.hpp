//*****************************************************************//
//** Description:   OS Layer classes                             **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2001-21-08                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XSYSTEM_GRAPHICS_OLD_HPP
#define _XSYSTEM_GRAPHICS_OLD_HPP

#include <xBase.hpp>

#define S_XY    sint16 x, sint16 y
#define S_RXY   rsint16 x, rsint16 y
#define S_WH    sint16 w, sint16 h
#define S_RWH   rsint16 w, rsint16 h
#define S_WHF   sint16 x, sint16 h, uint8 f
#define S_RWHF  rsint16 w, rsint16 h, rsint16 f
#define S_RECT  sint16 x, sint16 y, sint16 w, sint16 h
#define S_RECTF sint16 x, sint16 y, sint16 w, sint16 h, sint16 f

#define S_1CRD  sint16 x, sint16 y
#define S_2CRD  sint16 x1, sint16 y1, sint16 x2, sint16 y2
#define S_3CRD  sint16 x1, sint16 y1, sint16 x2, sint16 y2, sint16 x3, sint16 y3

#define S_CRD1  sint16 x1, sint16 y1
#define S_CRD2  sint16 x2, sint16 y2
#define S_CRD3  sint16 x3, sint16 y3
#define S_CRD4  sint16 x4, sint16 y4

#if defined(XP_AMIGAOS)
  #include "Platforms/Amiga68k/GraphicsLib/GfxLibOld.hpp"
#elif defined(XP_WIN32)
  #include "Platforms/Win32/GraphicsLib/GfxLibOld.hpp"
#else
  #error "Error: OS Platform Not Defined"
#endif  //Platform Options//

#endif