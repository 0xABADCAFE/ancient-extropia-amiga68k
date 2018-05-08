//****************************************************************************//
//** File:         Gfx2D.hpp ($NAME=Gfx2D.hpp)                              **//
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

#ifndef _XSYSTEM_GRAPHICS2D_68K_HPP
#define _XSYSTEM_GRAPHICS2D_68K_HPP

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  x2D:: Resource class for 2D graphics
//
//  Used as base for xGFX
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xSURFACE;
class xDMODE;

typedef enum {
  SURF_LUT_8      = 0,  // 8-bit palettized
  SURF_RGB_15     = 1,  // 15 bit
  SURF_BGR_15     = 2,
  SURF_RGB_15LE   = 3,  // 15 bit, little endian format
  SURF_BGR_15LE   = 4,
  SURF_RGB_16     = 5,  // 16 bit
  SURF_BGR_16     = 6,
  SURF_RGB_16LE   = 7,  // 16 bit, little endian format
  SURF_BGR_16LE   = 8,
  SURF_RGB_24     = 9,  // 24 bit (packed)
  SURF_BGR_24     = 10,
  SURF_ARGB_32    = 11, // 32 bit
  SURF_ABGR_32    = 12,
  SURF_RGBA_32    = 13,
  SURF_BGRA_32    = 14,
  SURF_NONE       = 15,
  SURF_UNKNOWN    = 16,
  SURF_MAX_TYPES  = 16 // for arrays and stuff
} SURFTYPE;

class x2D {
  friend class xSURFACE;
  private:
    #ifdef X_VERBOSE
    static const char*  formatNames[];
    #endif
  protected:
    static uint32 surfaceTypes;     // bit mask of supported surface formats, built during xGFX::Init()
    static sint32 Init();
    static sint32 Done();

    // Blits src, dest, srcTop, srcLeft, srcBottom, srcRight, destTop, destRight
    static void   BlitDirect(sysSURFACE* src, sysSURFACE* dest, S_3CRD) { BltBitMap(src, x1, y1, dest, x3, y3, (x2-x1), (y2-y1), 0xC0, 0xFF, 0);}
    static void   BlitLayer(sysLAYER* src, sysLAYER* dest, S_3CRD)      { ClipBlit(src, x1, y1, dest, x3, y3, (x2-x1), (y2-y1), 0xC0); }

  // USER LAYER
  public:
    static bool         SupportsSurface(SURFTYPE p) { return (surfaceTypes & (1<<p))!=0; }
    #ifdef X_VERBOSE
    static const char*  DescSurface(SURFTYPE type)  { return (type<SURF_MAX_TYPES) ? formatNames[type] : formatNames[SURF_UNKNOWN]; }
    #endif
};

// Amiga defaults
#define SURF_8  SURF_LUT_8
#define SURF_15 SURF_RGB_15
#define SURF_16 SURF_RGB_16
#define SURF_24 SURF_RGB_24
#define SURF_32 SURF_ARGB_32

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  AREA
//
//  Simple base class describing most common surface properties
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class AREA {

  protected:
    sint16        width;
    sint16        height;
    sint16        depth;
    sint16        format; // 64 bit aligned

  public:
    // protected construction for derived class constructors
    AREA() : width(0), height(0), depth(0), format(SURF_NONE)                                 { }
    AREA(S_RWH, rsint16 d=0, rsint16 f=SURF_NONE) : width(w), height(h), depth(d), format(f)  { }

  // default implementation
  public:
    sint32                Size()    { return width*height; }
    virtual sint32        Width()   { return width; }
    virtual sint32        Height()  { return height; }
    virtual sint32        Depth()   { return depth; }
    virtual sint32        Format()  { return format; }
    virtual ~AREA()       { }
};

#endif