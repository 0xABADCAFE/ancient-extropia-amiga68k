//*****************************************************************//
//** Description:   OS Layer classes, AmigaOS/68K version        **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2001-21-08                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xSystem/GraphicsLib.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xSURFACE::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xPOOL_S<RastPort> xSURFACE::rPool;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xSURFACE::Init()
{
  if (rPool.Create(RPORTPOOLSIZE)!=OK)
  {
/*
    #ifdef X_DEBUG
    sysBASELIB::MessageBox("Debug Info", "Proceed", "xSURFACE::Init()\nError creating RastPort pool");
    #endif
*/
    return ERR_RSC_INVALID;
  }
  RastPort *r = 0;
  if (rPool.New(&r,RPORTPOOLSIZE)!=WRN_RSC_EXHAUSTED)
  {
/*
    #ifdef X_DEBUG
    sysBASELIB::MessageBox("Debug Info", "Proceed", "xSURFACE::Init()\nError initializing RastPort pool");
    #endif
*/
    return ERR_RSC_INVALID;
  }
  for (sint32 i = 0; i<RPORTPOOLSIZE; i++)
  {
    InitRastPort(&r[i]);
  }
  rPool.Free(&r);
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xSURFACE::Done()
{
  return rPool.Delete(true);
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xSURFACE::Attach(register sysLAYER* r)
{
  if (flags & OWNBITMAP) // cant attach if own BitMap
    return ERR_PTR_USED;
  if (r==0)
    return ERR_PTR_ZERO; // cant atach to a null pointer

  if (r->BitMap==0)
  { // no BitMap with external RastPort
    if (flags & OWNRPORT)
      rPool.Free(&rPort);
    rPort   = r;
    flags   = EXTERNRPORT;
    width   = 0;
    height  = 0;
    depth   = 0;
    format  = SURF_NONE;
    return OK;
  }
  else
  { // BitMap with external RastPort, only useful if cybergraphics compatible
    if (GetCyberMapAttr(r->BitMap, CYBRMATTR_ISCYBERGFX)==false)
    {
      flags |= ERR_HANDLE;
      return ERR_RSC_INVALID;
    }
    else
    {
      if (flags & OWNRPORT)
        rPool.Free(&rPort);
      rPort = r;
      flags = EXTERNRPORT|EXTERNBITMAP;
      ReadAttrs(rPort->BitMap);
      return OK;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xSURFACE::Attach(register sysSURFACE* s)
{
  if (flags & (BITMAP|EXTERNRPORT))
    return ERR_PTR_USED;

  if (s==0)
    return ERR_PTR_ZERO; // cant atach to a null pointer
  if (GetCyberMapAttr(s, CYBRMATTR_ISCYBERGFX)==false)
  {
    flags |= ERR_HANDLE;
    return ERR_RSC_INVALID;
  }
  if ((flags & OWNRPORT)==0)
  {
    if(rPool.New(&rPort)!=OK)
      return ERR_RSC_EXHAUSTED;
    flags |= OWNRPORT
  }
  rPort->BitMap = s;
  flags |= EXTERNBITMAP;
  ReadAttrs(s);
  return OK;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xSURFACE::Create(S_WH, sint16 d)
{
  // We can create a bitmap as long as were not already using one
  if (flags & BITMAP)
    return ERR_RSC_LOCKED;

  // specify w/h/d
  if (w <= 0 || h <= 0)
    return ERR_VALUE;

  // Choose an appropriate pixel format based on the requested depth
  uint32 f;
  if (d <= 8)       f = (SURF_8<<24)  | BMF_SPECIALFMT | BMF_MINPLANES | BMF_DISPLAYABLE;
  else if (d <= 15) f = (SURF_15<<24) | BMF_SPECIALFMT | BMF_MINPLANES | BMF_DISPLAYABLE;
  else if (d <= 16) f = (SURF_16<<24) | BMF_SPECIALFMT | BMF_MINPLANES | BMF_DISPLAYABLE;
  else if (d <= 24) f = (SURF_24<<24) | BMF_SPECIALFMT | BMF_MINPLANES | BMF_DISPLAYABLE;
  else              f = (SURF_32<<24) | BMF_SPECIALFMT | BMF_MINPLANES | BMF_DISPLAYABLE;

  if ((flags & RPORT) == 0) // No RastPort ?
  {
    if(rPool.New(&rPort)!=OK)
      return ERR_RSC_EXHAUSTED;
    flags |= OWNRPORT;
  }

  #define BIZZARE_PLANES 9 // It seems planes<=8 results in broken bitmap structure for BMF_SPECIALFMT
  rPort->BitMap = AllocBitMap(w, h, BIZZARE_PLANES, f, 0);
  #undef BIZZARE_PLANES

  if (rPort->BitMap == 0)
  {
    if (flags & OWNRPORT)
    {
      rPool.Free(&rPort);
      flags &= ~RPORT;
    }
    flags |= ERR_CREATE | ERR_NOFREEMEM;
    return ERR_NO_FREE_STORE;
  }
  flags |= OWNBITMAP;
  ReadAttrs(rPort->BitMap);
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xSURFACE::Create(S_WH, xSURFACE* surf)
{
  // We can create a bitmap as long as were not already using one
  if (flags & BITMAP)
  {
/*
    #ifdef X_DEBUG
    cerr << "xSURFACE::Create(S_WH, xSURFACE* surf) : object in use\n";
    #endif
*/
    return ERR_RSC_LOCKED;
  }
  // specify w/h
  if (w <= 0 || h <= 0)
  {
/*
    #ifdef X_DEBUG
    cerr << "xSURFACE::Create(S_WH, xSURFACE* surf) : illegal dimensions\n";
    #endif
*/
    return ERR_VALUE;
  }
  // specify w/h/friend, using same format as friend
  if ( (surf==0) || (((surf->flags) & BITMAP)==0) )
  {
/*
    #ifdef X_DEBUG
    cerr << "xSURFACE::Create(S_WH, xSURFACE* surf) : invalid friend surface\n";
    #endif
*/
    flags = ERR_CREATE | ERR_FRIEND;
    return ERR_PTR_ZERO;
  }
  if ((flags & RPORT) == 0) // No RastPort ?
  {
    if(rPool.New(&rPort)!=OK)
    {
/*
      #ifdef X_DEBUG
      cerr << "xSURFACE::Create(S_WH, xSURFACE* surf) : failed to obtain RastPort from pool\n";
      #endif
*/
      return ERR_RSC_EXHAUSTED;
    }
    flags |= OWNRPORT;
  }
  rPort->BitMap = AllocBitMap(w, h, 8, BMF_MINPLANES|BMF_DISPLAYABLE, (surf->rPort->BitMap));
  if (rPort->BitMap == 0)
  {
/*
    #ifdef X_DEBUG
    cerr << "xSURFACE::Create(S_WH, xSURFACE* surf) : failed to allocate surface\n";
    #endif
*/
    if (flags & OWNRPORT)
    {
      rPool.Free(&rPort);
      flags &= ~RPORT;
    }
    flags = ERR_CREATE | ERR_NOFREEMEM;
    return ERR_NO_FREE_STORE;
  }
  flags |= OWNBITMAP;
  ReadAttrs(rPort->BitMap);
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xSURFACE::Delete()
{
  if (lockHandle)
    return ERR_RSC_LOCKED;
  if (rPort==0)
    return OK;

  if (flags & OWNBITMAP && rPort->BitMap)
  { // remove any allocated data
    FreeBitMap(rPort->BitMap);
    rPort->BitMap = 0;
  }
  if (flags & OWNRPORT)
  { // make sure rPort->BitMap is 0 before returning to pool.
    rPort->BitMap = 0;
    rPool.Free(&rPort);
  }
  flags = 0;  width = 0;  height = 0; depth = 0;
  format = SURF_NONE;
  rPort = 0;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xSURFACE::ReadAttrs(sysSURFACE* b)
{
  // read data from bitmap handle to internal data
  width   = GetCyberMapAttr(b, CYBRMATTR_WIDTH);
  height  = GetCyberMapAttr(b, CYBRMATTR_HEIGHT);
  depth   = GetCyberMapAttr(b, CYBRMATTR_DEPTH);
  format  = GetCyberMapAttr(b, CYBRMATTR_PIXFMT);
  if (GetCyberMapAttr(b, CYBRMATTR_ISLINEARMEM))
    flags |=  LINEARMEM;
  else
    flags &= ~LINEARMEM;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_VERBOSE
void xSURFACE::DebugInfo()
{
  sysBASELIB::MessageBox("Debug Info", "Proceed", "xSURFACE info\nWidth %d\nHeight %d\nDepth %d\nType %s", width, height, depth, xGFX::DescSurface((SURFTYPE)format));
}
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xSURFACE::~xSURFACE()
{
  // optimised UnLockData()/Delete()
  if (rPort)
  {
    if (rPort->BitMap)
    {
      if (lockHandle)
        UnLockBitMap(lockHandle);
      if (flags & OWNBITMAP)
        FreeBitMap(rPort->BitMap);
    }
    if (flags & OWNRPORT)
    { // make sure rPort->BitMap is 0 before returning to pool
      rPort->BitMap = 0;
      rPool.Free(&rPort);
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
