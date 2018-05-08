//****************************************************************************//
//** File:         GraphicsLib.hpp ($NAME=GraphicsLib.hpp)                  **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      xGraphics                                                **//
//** Created:      2001-01-20                                               **//
//** Updated:      2002-01-07                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


#ifndef _XSYSTEM_GRAPHICS_HPP
#error You must only directly include <xSystem/GraphicsLib.hpp> in your source !
#endif

#ifndef _XSYSTEM_GRAPHICSLIB68K_HPP
#define _XSYSTEM_GRAPHICSLIB68K_HPP

// AmigaOS includes not included by sysBASE or xResources

extern "C" {
  #include <proto/graphics.h>
  #include <cybergraphx/cybergraphics.h>
  #include <clib/cybergraphics_protos.h>
  #include <pragmas/cybergraphics_pragmas.h>
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern  GFXBASE       *GfxBase;       // AmigaOS graphics routines
extern  LIBRARY       *CyberGfxBase;  // Graphics Card extensions

#define DISPLAYMODE_WINDOW     0x00000000 // Use window on default public screen
#define DISPLAYMODE_BEST       0xFFFFFFFF // Let system choose best display mode ID

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  System graphic element wrappers
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef BitMap        sysSURFACE;
typedef RastPort      sysLAYER;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Utilities
//
//  1. Handy macros for common rectangular argument lists
//  2. Simple coord system that packs a pair of sint16 ordinates into one uint32 to assist register passing
//  3. Some handy colour conversion functions
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////



#define ARGB_RU32 ruint32 a, ruint32 r, ruint32 g, ruint32 b

inline uint32   RGB565ToCol32(ruint32 c, ruint32 a)   { return (a<<24)|(c&0x0000F800)<<8|(c&0x000007E0)<<6|(c&0x0000001F)<<3; }
inline uint32   RGB555ToCol32(ruint32 c, ruint32 a)   { return (a<<24)|(c&0x00007C00)<<9|(c&0x000003E0)<<6|(c&0x0000001F)<<3; }
inline uint32   ARGB1555ToCol32(ruint32 c, ruint32 a) { return ((c&0x00008000)?(a<<24):0)|(c&0x00007C00)<<9|(c&0x000003E0)<<6|(c&0x0000001F)<<3; }
inline uint32   ARGB4444ToCol32(ruint32 c)            { return (c&0x0000F000)<<16|(c&0x00000F00)<<12|(c&0x000000F0)<<8|(c&0x0000000F)<<4; }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include <Platforms/Amiga68K/GraphicsLib/Gfx2D.hpp>
#include <Platforms/Amiga68K/GraphicsLib/Gfx3D.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xGFX
//
//  Sets up machine graphics system for use
//  Builds a database of supported surface types and display modes
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xDMODE;
class xGFX : public x2D, public x3D {

  private:
    static uint32       flags;
    static xDMODE*      mode;             // display mode database
    static uint32       numModes;

    enum {
      GFX_SYSTEM_OK     = 0x00000001,
      GFX_3DHW_AVAIL    = 0x00000002
    };

  public:
    static sint32       Modes()                                                 { return numModes; }
    static xDMODE*      Mode(uint32 m)                                          { return (m<numModes) ? &mode[m] : 0; }
    static xDMODE*      BestMode(S_WH, uint8 bpp, bool exact=false);
  #ifdef X_VERBOSE
    static void         DumpModes(ostream& out);
  #endif
  public:
    static sint32       Init();
    static sint32       Done();
};

#include <Platforms/Amiga68K/GraphicsLib/Surface.hpp>
#include <Platforms/Amiga68K/GraphicsLib/Display.hpp>
#include <Platforms/Amiga68K/GraphicsLib/Draw.hpp>
#include <Platforms/Amiga68K/GraphicsLib/Util.hpp>

#endif