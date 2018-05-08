//****************************************************************************//
//** File:         xGraphics.hpp ($NAME=xGraphics.hpp)                      **//
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

#ifndef _XSYSTEM_SURFACE68K_HPP
#define _XSYSTEM_SURFACE68K_HPP

#include <xUtility/Pool.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xSURFACE:: Video Pixel Array Primitive
//
//  Notes
//    Actually wraps a RastPort pointer than a BitMap pointer. This is because a RastPort contains a BitMap
//  pointer, is used by almost all OS level rendering operations and allows automatic Layer clipping. However,
//  a RastPort is a large structure (100 bytes), so is not best suited to 'on the stack' creation. Hence, a
//  pointer is wrapped instead. This allows attaching to existing RastPorts (screen, window etc).
//    If a totally new RastPort is required, we can simply create one on the free store. However, allocating a
//  RastPort is time consuming, so a pool is employed to minimise the overhead. This puts a limit on the number
//  of surfaces that can be allocated, though the pool is created dynamically so the limit can be easily set
//  to requirement.
//
//  Modes of operation
//
//  1. External RastPort / External BitMap
//  2. External RastPort / Own BitMap
//  3. Own RastPort / External BitMap
//  4. Own RastPort / Own BitMap
//
//  In the uninitialised state, neither external / internal
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class SHAREDCONTEXT; // for drawing operations
#define RPORTPOOLSIZE 256

class xSURFACE : public AREA {

  friend class xGFX;
  friend class xDRAW;

  protected:
    static xPOOL_S<RastPort>  rPool;

    sysLAYER*       rPort;            // pointer to a RastPort - may be external or from the pool
    void*           lockHandle;
    void*           baseAddress;      // address returned by LocData() if sucessful
    uint32*         palette;          // pointer to ARGB palette data for CLUT bitmaps
    uint32          flags;

  protected:
    static sint32   Init();
    static sint32   Done();
    // BitMap property querying
    void            ReadAttrs(sysSURFACE* b);

    enum {
      OWNRPORT      = 0x00000001,
      EXTERNRPORT   = 0x00000002,
      RPORT         = 0x00000003, // flags & RPORT non zero if valid RastPort
      OWNBITMAP     = 0x00000004,
      EXTERNBITMAP  = 0x00000008,
      BITMAP        = 0x0000000C, // flags & BITMAP non zero if valid BitMap
      SOURCE        = 0x0000000F, // mask for above flags
      VISIBLE       = 0x00000100,
      CACHED        = 0x00000200, // data in VRAM and not visible
      LINEARMEM     = 0x00000400, // memory continuous
      ERR_NOFREEMEM = 0x00010000,
      ERR_FRIEND    = 0x00020000,
      ERR_HANDLE    = 0x00040000,
      ERR_CREATE    = 0x00080000,
      ERR_LOCK      = 0x00100000,
    };

  public:
    typedef enum {
      PXL_LUT_8     = 0,  // 8-bit palettized
      PXL_RGB_15    = 1,  // 15 bit
      PXL_BGR_15    = 2,
      PXL_RGB_15LE  = 3,  // 15 bit, little endian format
      PXL_BGR_15LE  = 4,
      PXL_RGB_16    = 5,  // 16 bit
      PXL_BGR_16    = 6,
      PXL_RGB_16LE  = 7,  // 16 bit, little endian format
      PXL_BGR_16LE  = 8,
      PXL_RGB_24    = 9,  // 24 bit (packed)
      PXL_BGR_24    = 10,
      PXL_ARGB_32   = 11, // 32 bit
      PXL_ABGR_32   = 12,
      PXL_RGBA_32   = 13,
      PXL_BGRA_32   = 14,
      PXL_NONE      = 15,
      PXL_UNKNOWN   = 16,
      PXL_MAX_TYPES = 16 // for arrays and stuff
    } PIXELTYPE;
    sysSURFACE*   Handle() { if (rPort) return rPort->BitMap; return 0; }
    sysLAYER*     LHandle() { return rPort; }
    sint32        Attach(register sysLAYER* r); // attach to an existing  RastPort
    sint32        Attach(register sysSURFACE* s);
    sint32        Create(S_WH, sint16 d);
    sint32        Create(S_WH, xSURFACE* surf);
    sint32        Delete();
    void*         Lock();       // locks the memory for direct VRAM access
    sint32        UnLock();
    bool          Locked()      { return (lockHandle!=0); }
    bool          LinearData()  { return (flags & LINEARMEM)!=0; } // true if directly accessible as y*width + x (no modulo)
    bool          Allocated()   { return (flags & BITMAP)!=0; }
    sint32        Modulus()     { if (flags & BITMAP) return GetCyberMapAttr(rPort->BitMap, CYBRMATTR_XMOD); return ERR_RSC_UNAVAILABLE; }
    static void   Blit(xSURFACE* s, xSURFACE* d, S_3CRD)  { x2D::BlitDirect(s->rPort->BitMap, d->rPort->BitMap, x1,y1,x2,y2,x3,y3); }
    static void   BlitC(xSURFACE* s, xSURFACE* d, S_3CRD) { x2D::BlitLayer(s->rPort, d->rPort, x1,y1,x2,y2,x3,y3); }

    #ifdef X_VERBOSE
    static void   DumpPool(ostream& out) { rPool.PrintAlloc(out); }
    void          DebugInfo();
    #endif

  public:
    xSURFACE() : rPort(0), lockHandle(0), baseAddress(0), palette(0), flags(0) {}
    ~xSURFACE();
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline void* xSURFACE::Lock()
{
  if (lockHandle)
    return baseAddress;
  TagItem t[2] = { LBMI_BASEADDRESS, (uint32)(&baseAddress), TAG_DONE, 0 };
  lockHandle = LockBitMapTagList(rPort->BitMap, t);
  if (lockHandle)
  {
    flags &= ~ERR_LOCK;
    return baseAddress;
  }
  flags |= ERR_LOCK;
  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline sint32 xSURFACE::UnLock()
{
  if (lockHandle)
  {
    UnLockBitMap(lockHandle);
    lockHandle = 0;
  }
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif