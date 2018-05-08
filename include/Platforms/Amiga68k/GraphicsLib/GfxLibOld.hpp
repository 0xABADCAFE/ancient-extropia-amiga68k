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


#ifndef _XSYSTEM_GRAPHICS_OLD_HPP
#error You must only directly include <xSystem/GraphicsLibOld.hpp> in your source !
#endif

#ifndef _XSYSTEM_GRAPHICSLIB_OLD_68K_HPP
#define _XSYSTEM_GRAPHICSLIB_OLD_68K_HPP

// AmigaOS includes not included by sysBASE or xResources

extern "C" {
  #include <proto/graphics.h>
  #include <cybergraphx/cybergraphics.h>
  #include <clib/cybergraphics_protos.h>
  #include <pragmas/cybergraphics_pragmas.h>
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern  GFXBASE       *::GfxBase;       // AmigaOS graphics routines
extern  LIBRARY       *::CyberGfxBase;  // Graphics Card extensions

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

#define ICOORD2D uint32
#define RICOORD2D register uint32
#define ARGB_RU32 ruint32 a, ruint32 r, ruint32 g, ruint32 b

inline sint16   CoordX(RICOORD2D c)                   { return (sint16)((sint32)c>>16); }
inline sint16   CoordY(RICOORD2D c)                   { return (sint16)(c&0x0000FFFF); }
inline ICOORD2D Coord(S_RXY)                          { return ((uint32)x<<16)|((uint32)y&0x0000FFFF); }
inline uint32   Col32(ARGB_RU32)                      { return a<<24|r<<16|g<<8|b; }
inline uint32   GetCol32A(ruint32 c)                  { return c>>24; }
inline uint32   GetCol32R(ruint32 c)                  { return (c>>16)&0x000000FF; }
inline uint32   GetCol32G(ruint32 c)                  { return (c>>8)&0x000000FF; }
inline uint32   GetCol32B(ruint32 c)                  { return c&0x000000FF; }
inline void     SetCol32A(uint32 &c, ruint32 a)       { c &= 0x00FFFFFF; c |= (a<<24); }
inline void     SetCol32R(uint32 &c, ruint32 r)       { c &= 0xFF00FFFF; c |= (r<<16); }
inline void     SetCol32G(uint32 &c, ruint32 g)       { c &= 0xFFFF00FF; c |= (g<<8); }
inline void     SetCol32B(uint32 &c, ruint32 b)       { c &= 0xFFFFFF00; c |= b; }
inline uint32   RGB565ToCol32(ruint32 c, ruint32 a)   { return (a<<24)|(c&0x0000F800)<<8|(c&0x000007E0)<<6|(c&0x0000001F)<<3; }
inline uint32   RGB555ToCol32(ruint32 c, ruint32 a)   { return (a<<24)|(c&0x00007C00)<<9|(c&0x000003E0)<<6|(c&0x0000001F)<<3; }
inline uint32   ARGB1555ToCol32(ruint32 c, ruint32 a) { return ((c&0x00008000)?(a<<24):0)|(c&0x00007C00)<<9|(c&0x000003E0)<<6|(c&0x0000001F)<<3; }
inline uint32   ARGB4444ToCol32(ruint32 c)            { return (c&0x0000F000)<<16|(c&0x00000F00)<<12|(c&0x000000F0)<<8|(c&0x0000000F)<<4; }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xGFXFTR - simple auxiliary class used for holding information about graphics abilities
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xGFXFTR {
  friend class x2D;
  friend class SUPPORTS3D;
  private:
    uint32 full; // mask for fully supported features
    uint32 part; //  " " partially supported " "
  public:
    uint32 Full(uint32 query) { return full&query; }
    uint32 Part(uint32 query) { return part&query; }
    uint32 Any(uint32 query)  { return (full|part)&query; }
    xGFXFTR() : full(0), part(0) {}
    ~xGFXFTR() {}
};

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
#include <Platforms/Amiga68K/GraphicsLib/DrawOld.hpp>
#endif