//****************************************************************************//
//** File:         xDRAW.hpp ($NAME=xDRAW.hpp)                              **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      xGraphics                                                **//
//** Created:      2001-03-10                                               **//
//** Updated:      2001-12-18                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):      THIS RESOURCE IS DEPRECIATED                             **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

// xDraw.hpp #includes xGraphics.hpp and associated resources

#ifndef _XSYSTEM_DRAW68K_OLD_HPP
#define _XSYSTEM_DRAW68K_OLD_HPP

// OS resources not included by xGraphics

extern "C" {
  #include <proto/diskfont.h>
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  System graphic element wrappers
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xTEXTURE::
//
//  Due to the rather specialist nature of hardware texture maps, xTEXTURE is not derived from xSURFACE. An
//  xTEXTURE object may be constructed from raw data, or using an xSURFACE as a source image only. In either
//  case, the source  must not be deleted before the texture. A texture cannot be created without existing
//  data. There are other constraints also.
//
//  1. Not all xSURFACE formats are supported in HW. Generally, 8-bit CLUT, 16-bit ARGB 1555 and 32-bit ARGB
//     are universal. Other formats may be converted to the nearest HW form. Data conversion is generally
//     undesirable and should be avoided where possible.
//
//  2. Texture dimensions MUST be powers of 2. This constraint also applies to any xSURFACE used as a source.
//
//  3. Textures are bound to the rendering context they were created under. Hopefully this will be less of
//     an issue once the shared context idea is up and running.
//
//  4. The format type refers to one of TEXFORMATS (see xGraphics.hpp).
//
//  Note generation of textures from xSURFACE data is not currently supported (due to a depressingly long list
//  of technical reasons)
//
//  If possible, a blit driven xSURFACE > xTEXTURE would be useful. Uncertian as to how this can be achieved
//
//  On the plus side, each xTEXTURE can have its own environment settings. Also, xTEXTURE supports the notion
//  of 'cells', subdivisions of the texture that can be used for animation purposes, keeping frames together
//  in one place.
//  TO DO : clean up this lot, it is a mess
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef enum {
  TXS_LUT_8         = 0, // 256 palette based
  TXS_ARGB_1555     = 1, // A RRRRRGG..GGGBBBB
  TXS_RGB_565       = 2, // RRRRR GGG..GGG BBBBB
  TXS_RGB_888       = 3, // RRRRRRRR..GGGGGGGG..BBBBBBBB
  TXS_ARGB_4444     = 4, // AAAA RRRR..GGGG BBBB
  TXS_ARGB_8888     = 5, // AAAAAAAA..RRRRRRRR..GGGGGGGG..BBBBBBBB
  TXS_ALPHA_8       = 6, // 8-bit Alpha only
  TXS_GREY_8        = 7, // 8-bit Greyscale R=G=B=GREY
  TXS_GA_88         = 8, // 8-bit Greyscale and 8-bit alpha
  TXS_INTSY_8       = 9, // 8-bit Intensity R=G=B=A=INTENSITY
  TXS_RGBA_8888     = 10,// RRRRRRRR..GGGGGGGG..BBBBBBBB..AAAAAAAA
  TXS_UNKNOWN       = 11,
  TXS_MAX_TYPES     = 11 // for arrays and stuff
} TEXELTYPE;

class xTEXTURE : public AREA {

  friend class xDRAW;

  protected:
    W3D_Context*  ctx;
    W3D_Texture*  tex;
    void*         source;
    uint32*       palette;
    uint32        error;
    uint32        flags;
    sint16        x1, y1, x2, y2;
    sint16        cW, cH, cHrz, cVrt;
    uint16        cells, curr;
    enum {
      OWNDATA     = 0x00000001,
      OWNPAL      = 0x00000002,
      MULTICELL   = 0x00000004
    };

  public:
    enum {
      REPLACE       = W3D_REPLACE,
      DECAL         = W3D_DECAL,
      MODULATE      = W3D_MODULATE,
      LINEAR        = W3D_LINEAR,
      NEAREST       = W3D_NEAREST,
      NEAR_MIP_NEAR = W3D_NEAREST_MIP_NEAREST,
      LINR_MIP_NEAR = W3D_LINEAR_MIP_NEAREST,
      NEAR_MIP_LINR = W3D_NEAREST_MIP_LINEAR,
      LINR_MIP_LINR = W3D_LINEAR_MIP_LINEAR,
      CLAMP         = W3D_CLAMP,
      REPEAT        = W3D_REPEAT
    };
    sysTEXTURE* TexHandle() { return tex; }

    uint32  Error()                                           { return error; }
    sint32  Create(xSURFACE& surf)                            { return ERR_USER ; }
    sint32  Create(S_WH, sint16 f, void* data, uint32* pal=0); // Create a texture from data
    sint32  Delete();

  // environment
    void    SetEnv(ruint32 p)                                 { W3D_SetTexEnv(ctx, tex, p, 0); }
    void    SetFilter(ruint32 max, ruint32 min=NEAREST)       { W3D_SetFilter(ctx, tex, min, max); }
    //void    SetWrap(ruint32 vert=REPEAT, ruint32 horiz=REPEAT){ W3D_SetWrapMode(ctx, tex, vert, horiz, /**/); }
  // anim support
    void    SetArea(sint16 l, sint16 t, sint16 r, sint16 b)   { x1 = l; y1 = t; x2 = r; y2 = b;}
    sint32  DefineCell(ICOORD2D cDim, sint16 h, sint16 v);
    sint32  Cell(rsint16 c);
    sint32  Cells()                                           { return cells; }
    sint16  CellW()                                           { return cW; }
    sint16  CellH()                                           { return cH; }
    sint16  CellsH()                                          { return cHrz; }
    sint16  CellsV()                                          { return cVrt; }
  // load PPM.
    sint32  LoadPPM(const char* name, uint32 alphagen = 0xFF000000);

    sint32  Load(const char* name, sint32 forceFmt = -1);

  // lightsourcable texture (which is kinda special)
    sint32  LoadLST(const char* name, sint16 f=TXS_ARGB_4444);

  public:
    xTEXTURE() : ctx(0), tex(0), source(0), palette(0), error(0), flags(0)  { }
    xTEXTURE(S_WH, sint16 f, void* data, uint32* pal=0) : ctx(0), tex(0), source(0), palette(0), error(0), flags(0) { Create(w,h,f,data,pal); }
    ~xTEXTURE() { Delete(); }
};

inline sint32 xTEXTURE::Cell(rsint16 c)
{
  if (flags & MULTICELL)
  {
    if (c <0 || c > cells)
    return ERR_VALUE_RANGE;
    curr = c;
    x1 = cW*(c%cHrz);
    y1 = cH*(c/cHrz);
    x2 = x1+cW;
    y2 = y1+cH;
    return OK;
  }
  return ERR_RSC_TYPE;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDRAW:: Resource class, inheritable for low level also
//
//    Advanced 2D Drawing class, utilizes 3D HW rasterisation for many features such as blending, dithering etc.
//
//  Public interface provides simple 2D drawing primitives etc. Protected interface provides a much lower level
//  that allows custom drawing in terms of direct driver-level operations. Useful for custom rendering,
//  implementing 3D APIs, etc, etc.
//
//
//  TO DO
//
//    1. Enable an asynchronous drawing thread, use as basis for a 'virtual' GPU that handles buffered drawing
//       requests.
//
//  Specific Warp3D ideas
//
//    1. Attempt to 'hack' indirect queue's state data to allow efficient multi-state changes. Having to manually
//       modify each state in turn is stupid. Have identified that the state for buffered operation is
//
//       ((W3D_QHead*)(context->queue->current))->state
//
//       However, playing with this has no effect. Probable that other data is affected. Will have to dump
//       whole instruction to see what else changes.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define ENABLE  W3D_ENABLE
#define DISABLE W3D_DISABLE
#define VBUFFSIZE 512
#define XDRAW_TRIGSIZE 16
/*
struct TEXT_RETAIN {
  char*   text;
  uint32  len;
  uint32  font;
  sint16  x, y;
};
*/
class xDRAW : public x3D {
  friend class xTEXTURE;

  private:
    // OS level text rendering

    static TextAttr       fontInfo[4]; // descriptors for fonts
    static TextFont*      fontData[4]; // allocated fonts

    static uint32         flags;
    static uint32         flushCnt;
    static uint32         cTab[256]; // colour adjust table, allows for gamma etc
    static float32        sTab[XDRAW_TRIGSIZE+2];
    static uint32         fault;
    static sint32         vBufPos;
    static float64        zDepth;
    static sint32         maxVBufPos;
    static uint32         vArraySize;
    static sysVERTEX*     vArray;
    static sysVERTEX*     vBuffer;

    static sint32         nestCount; // used for nested Begin()/End()

    enum {
      DATAENTRY   = 0x00000001,
      FLUSHFIRST  = 0x00000002, // this is to fix a W3D bug when using first texture operation
      ZBUFFER     = 0x00000004, // a z buffer has been allocated
      DIRECT      = 0x00000010,
      LOCKED      = 0x00000020,
      KEEP_BUFPOS = 0x00000040  // Vertices() can be used outside Begin() End()
    };

  protected:
    // Low level interface

    static uint32         currentCol;

    static uint32         Fault()               { return fault; }
    static sint32         BufferPos()           { return vBufPos; }
    static void           ZDepth(float64 d)     { zDepth = d; }
    static float64        ZDepth()              { return zDepth; }
    static void           Flush()               { W3D_Flush(x3D::Context()); if (vBufPos>maxVBufPos) maxVBufPos = vBufPos; vBufPos = 0; flags &= ~FLUSHFIRST|KEEP_BUFPOS; flushCnt++;}

    // quadric utilities
    static float32        FSin(ruint32 i);
    static float32        FCos(ruint32 i);

    // System level Vertex/Texture access for custom drawing

    static sint32         LockHW();
    static sint32         UnLockHW();
    static sint32         Direct();
    static sint32         Buffered();

    static sysVERTEX*     Vertices(ruint32 n); // Allocates n vertices on the stack. Pointer invalid after Flush()
    static void           TriStrip(register sysVERTEX* v, ruint32 n);
    static void           TriFan(register sysVERTEX* v, ruint32 n);
    static void           TriStripTx(register sysVERTEX* v, ruint32 n, register sysTEXTURE* t);
    static void           TriFanTx(register sysVERTEX* v, ruint32 n, register sysTEXTURE* t);
    static void           LineLoop(register sysVERTEX* v, ruint32 n);
    static void           LineStrip(register sysVERTEX* v, ruint32 n);

  public:

    // Simple Text rendering
    enum {
      ST_FIXED        = 0,
      ST_HEADING,
      ST_PARAGRAPH1,
      ST_PARAGRAPH2
    };

    // utilities
    static void       ARGBtoCol(ruint32 col, register sysCOLOUR4C* c);

    // drawing options
    static void       Enable(ruint32 s)               { W3D_SetState(x3D::Context(), s, W3D_ENABLE); }
    static void       Disable(ruint32 s)              { W3D_SetState(x3D::Context(), s, W3D_DISABLE); }
    static void       SetColour(ruint32 c);
    static void       Clear(ruint32 c=0)              { W3D_ClearDrawRegion(x3D::Context(), c); }
    static void       Depth(ruint32 d)                { zDepth = (float64)d/4294967296.0; }
    static void       DepthD(float64 d)               { zDepth = d; }
    static uint32     GetDepth()                      { return (zDepth*4294967296.0); }
    static sint32     AllocDepthBuffer();
    static sint32     FreeDepthBuffer();
    static void       ClearDepthBuffer(float64 d=1.0) { W3D_ClearZBuffer(x3D::Context(), &d); }
    static sint32     DepthCompareMode(uint32 m)      { return W3D_SUCCESS==W3D_SetZCompareMode(x3D::Context(), m) ? OK : ERR_RSC_UNAVAILABLE; }
    static sint32     BlendMode(ruint32 s, ruint32 d) { return W3D_SUCCESS==W3D_SetBlendMode(x3D::Context(), s, d) ? OK : ERR_RSC_UNAVAILABLE; }
    static sint32     LogicMode(uint32 m)             { return W3D_SUCCESS==W3D_SetLogicOp(x3D::Context(), m) ? OK : ERR_RSC_UNAVAILABLE; }

    // lines
    static void       Line(ruint32 col, RICOORD2D p1, RICOORD2D p2);
    static void       LineStrip(ruint32 col, RICOORD2D* p, ruint32 n);
    static void       LineShA(ruint32* col, RICOORD2D p1, RICOORD2D p2);
    static void       LinesShA(ruint32* col, RICOORD2D* p, ruint32 n) {}

    // triangles
    static void       Tri(ruint32 col, RICOORD2D p1, RICOORD2D p2, RICOORD2D p3);
    static void       TriShA(ruint32* col, RICOORD2D p1, RICOORD2D p2, RICOORD2D p3);

    // rectangles
    static void       Rect(ruint32 col,       RICOORD2D p1, RICOORD2D p2);  // plain
    static void       RectShH(ruint32* col,   RICOORD2D p1, RICOORD2D p2);  // shade Horizontal
    static void       RectShV(ruint32* col,   RICOORD2D p1, RICOORD2D p2);  // shade Vertical
    static void       RectShA(ruint32* col,   RICOORD2D p1, RICOORD2D p2);  // shade all

    static void       RectScTx(ruint32 col,     RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx); // ScaledTexture
    static void       RectScTxShH(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx); // gradient Horizontal
    static void       RectScTxShV(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx); // gradient Vertical
    static void       RectScTxShA(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx); // gradient Any

    static void       RectTlTx(ruint32 col,     RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx); // TiledTexture
    static void       RectTlTxShH(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx); // gradient Horizontal
    static void       RectTlTxShV(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx); // gradient Vertical
    static void       RectTlTxShA(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx); // gradient Any

    // quadrics
    static void       Circle(ruint32 col, RICOORD2D c, ruint32 rad);
    static void       CircleShC(ruint32* col, RICOORD2D c, ruint32 rad);
    static void       CircleShPt(ruint32* col, RICOORD2D c, RICOORD2D c2, ruint32 rad);

    static void       CircleScTx(ruint32 col, RICOORD2D c, ruint32 rad, register xTEXTURE& tx);
    static void       CircleScTxShC(ruint32* col, RICOORD2D c, ruint32 rad, register xTEXTURE& tx);
    static void       CircleScTxShPt(ruint32* col, RICOORD2D c, RICOORD2D c2, ruint32 rad, register xTEXTURE& tx);

    static void       Elipse(ruint32 col, RICOORD2D c, RICOORD2D radi);
    static void       ElipseShC(ruint32* col, RICOORD2D c, RICOORD2D radi);
    static void       ElipseShPt(ruint32* col, RICOORD2D c, RICOORD2D c2, RICOORD2D radi);

    static void       ElipseScTx(ruint32 col, RICOORD2D c, RICOORD2D radi, register xTEXTURE& tx);
    static void       ElipseScTxShC(ruint32* col, RICOORD2D c, RICOORD2D radi,  register xTEXTURE& tx);
    static void       ElipseScTxShPt(ruint32* col, RICOORD2D c, RICOORD2D c2, RICOORD2D radi, register xTEXTURE& tx);

    static void       SimpleText(ICOORD2D c, uint32 font, char* text,...);

  public:
  #ifdef X_VERBOSE
    static void       Dump(ostream& out, sint32 start, sint32 range);
  #endif
    static sint32     Begin();
    static sint32     End();
    static sint32     Bind(xSURFACE* s);
    static xSURFACE*  Bound() { return x3D::DrawSurface(); }
    static sint32     Release();
    static sint32     Init(uint32 vSize = VBUFFSIZE);
    static sint32     Done();
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Lowlevel locking operations

inline sint32 xDRAW::LockHW()
{
  if (flags & LOCKED) return OK;
  if (W3D_LockHardware(x3D::Context())==W3D_SUCCESS)
  {
    flags |= LOCKED;
    return OK;
  }
  else
  {
    flags &= ~LOCKED;
    return ERR_RSC_UNAVAILABLE;
  }
}

inline sint32 xDRAW::UnLockHW()
{
  if (flags & LOCKED==0) return OK;
  flags &= ~LOCKED;
  W3D_UnLockHardware(x3D::Context());
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Begin()/End() : all user drawing must be inbetween. Handles vertex stack, locking etc
//
// Calls may be nested. Beware, all calls to Begin() must be matched with calls to End(). In inderect mode, the
// final call to End() invokes any retained drawing operations. In direct mode, Begin()/End() always lock/unlock

inline sint32 xDRAW::Begin()
{
  if (nestCount++ == 0)
  {
    //cout << "Begin()\n";
    if (flags & DATAENTRY) return ERR_VALUE;
    flags |= FLUSHFIRST|DATAENTRY;
    if (flags & KEEP_BUFPOS)
      flags &= ~KEEP_BUFPOS;
    else
      vBufPos = 0;
  }
  if (flags & DIRECT && LockHW()!=OK)
    return ERR_RSC_UNAVAILABLE;
  return OK;
}

inline sint32 xDRAW::End()
{
  if (!nestCount)
    return ERR_RSC;
  if (--nestCount == 0)
  {
    //cout << "End()\n";
    if (flags & DATAENTRY==0) return ERR_VALUE;
    flags &= ~DATAENTRY|KEEP_BUFPOS;
    W3D_FlushFrame(x3D::Context());
    if (vBufPos>maxVBufPos)
      maxVBufPos = vBufPos;
    vBufPos = 0;
    flushCnt++;
  }
  if (flags & DIRECT)
    UnLockHW();
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Direct()/Buffered() state switching

// Takes care to preserve draw state, may be used inside Begin()/End() pair

inline sint32 xDRAW::Direct()
{
  if (flags & DIRECT) return OK;

  if (W3D_SetState(x3D::Context(), W3D_INDIRECT, W3D_DISABLE)==W3D_SUCCESS)
  { // Note : W3D_SetState() for W3D_DIRECT will flush W3Ds own queue internally
    flags |= DIRECT;
    if (flags & DATAENTRY)
      return LockHW();
    else
      return OK;
  }
  else
    return ERR_RSC_UNAVAILABLE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline sint32 xDRAW::Buffered()
{
  if (flags & DIRECT==0) return OK;

  if (flags & LOCKED)
    UnLockHW();

  if (W3D_SetState(x3D::Context(), W3D_INDIRECT, W3D_ENABLE)==W3D_SUCCESS)
  {
    flags &= ~DIRECT;
    return OK;
  }
  else
    return ERR_RSC_UNAVAILABLE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline void xDRAW::ARGBtoCol(ruint32 col, register sysCOLOUR4C* c)
{
  ruint32 m = 0x00FF0000;
  *((uint32*)c)++ = cTab[((col & m)>>16)];  m>>=8;
  *((uint32*)c)++ = cTab[((col & m)>>8)];   m>>=8;
  *((uint32*)c)++ = cTab[(col & m)];        m<<=24;
  *((uint32*)c)   = cTab[((col & m)>>24)];
}

inline  void xDRAW::SetColour(ruint32 col)
{
  sysCOLOUR4C clr;
  ARGBtoCol(col, &clr);
  W3D_SetCurrentColor(x3D::Context(), &clr);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline  float32 xDRAW::FSin(ruint32 i)
{
  if (i<XDRAW_TRIGSIZE)
    return sTab[i];                   // sin(0...PI/2)
  else if (i<(2*XDRAW_TRIGSIZE))
    return sTab[(2*XDRAW_TRIGSIZE)-i];  // sin(PI/2...PI)    : y axis reflection symmetrical to sin(0...PI/2)
  else if (i<(3*XDRAW_TRIGSIZE))
    return -sTab[i-(2*XDRAW_TRIGSIZE)];// sin(PI...3PI/2)   : x axis reflection symmetrical to sin(0...PI/2)
  else if (i<(4*XDRAW_TRIGSIZE))
    return -sTab[(4*XDRAW_TRIGSIZE)-i];// sin(3PI/2...2PI)  : x/y axis reflection symmetrical to sin(0...PI/2)
  else
    return sTab[i-4*XDRAW_TRIGSIZE];    // to allow interpolator to wrap to first quater
}

inline  float32 xDRAW::FCos(ruint32 i)
{
  if (i<XDRAW_TRIGSIZE)
    return sTab[XDRAW_TRIGSIZE-i];      // cos(0...PI/2)    : y axis reflection symmetrical to sin(0...PI/2)
  else if (i<(2*XDRAW_TRIGSIZE))
    return -sTab[i-XDRAW_TRIGSIZE];   // cos(PI/2...PI)   : x axis reflection symmetrical to sin(0...PI/2)
  else if (i<(3*XDRAW_TRIGSIZE))
    return -sTab[(3*XDRAW_TRIGSIZE)-i];// cos(PI...3PI/2)  : x/y axis reflection symmetrical to sin(0...PI/2)
  else if (i<(4*XDRAW_TRIGSIZE))
    return sTab[i-(3*XDRAW_TRIGSIZE)];  // cos(3PI/2...2PI) : congruent with sin(0...PI/2)
  else
    return sTab[(5*XDRAW_TRIGSIZE)-i];    // to allow interpolator to wrap to first quater
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline sysVERTEX* xDRAW::Vertices(ruint32 n)
{
  if ((vBufPos+n) >= vArraySize)
    Flush();
  //cout << "Vertices : " << n << ", vBufPos : " << vBufPos << "\n";
  register sysVERTEX* v = vBuffer+vBufPos;
  vBufPos+=n;
  flags |= KEEP_BUFPOS;
  return v;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline void xDRAW::TriStrip(register sysVERTEX* v, ruint32 n)
{
  //W3D_SetState(x3D::Context(), W3D_TEXMAPPING, W3D_DISABLE);
  W3D_Triangles tri = {n,v};
  W3D_DrawTriStrip(x3D::Context(), &tri);
}

inline void xDRAW::TriFan(register sysVERTEX* v, ruint32 n)
{
  //W3D_SetState(x3D::Context(), W3D_TEXMAPPING, W3D_DISABLE);
  W3D_Triangles tri = {n,v};
  W3D_DrawTriFan(x3D::Context(), &tri);
}

inline void xDRAW::TriStripTx(register sysVERTEX* v, ruint32 n, register sysTEXTURE* t)
{
  //W3D_SetState(x3D::Context(), W3D_TEXMAPPING, W3D_ENABLE);
  W3D_Triangles tri = {n,v,t};
  W3D_DrawTriStrip(x3D::Context(), &tri);
}

inline void xDRAW::TriFanTx(register sysVERTEX* v, ruint32 n, register sysTEXTURE* t)
{
  //W3D_SetState(x3D::Context(), W3D_TEXMAPPING, W3D_ENABLE);
  W3D_Triangles tri = {n,v,t};
  W3D_DrawTriFan(x3D::Context(), &tri);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline void xDRAW::LineLoop(register sysVERTEX* v, ruint32 n)
{
  //W3D_SetState(x3D::Context(), W3D_TEXMAPPING, W3D_DISABLE);
  W3D_Lines lin = {n,v};
  W3D_DrawLineLoop(x3D::Context(), &lin);
}

inline void xDRAW::LineStrip(register sysVERTEX* v, ruint32 n)
{
  //W3D_SetState(x3D::Context(), W3D_TEXMAPPING, W3D_DISABLE);
  // Seems W3D cant draw more than apx 200 line segments at once, so loop over in steps of 200 till we reach the
  // tail end
  W3D_Lines lin = {n,v};
  if (n>200)
  {
    lin.vertexcount = 201;
    while (n>200)
    {
      W3D_DrawLineStrip(x3D::Context(), &lin);
      lin.v+=200;
      n-= 200;
    }
    lin.vertexcount = n;
  }
  W3D_DrawLineStrip(x3D::Context(), &lin);
}


#endif // _XSYSTEM_DRAW68K_HPP