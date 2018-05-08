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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Globals
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

GFXBASE       *GfxBase        = 0;
LIBRARY       *CyberGfxBase   = 0;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  x2D/xGFX DATA
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// x2D /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32        x2D::surfaceTypes   = 0;

#ifdef X_VERBOSE
const char* x2D::formatNames[]  = {
  "8 bpp CLUT",
  "15 bpp RGB 555",
  "15 bpp BGR 555",
  "15 bpp RGB 555, little endian",
  "15 bpp BGR 555, little endian",
  "16 bpp RGB 565",
  "16 bpp BGR 565",
  "16 bpp RGB 565, little endian",
  "16 bpp BGR 565, little endian",
  "24 bpp RGB 888, packed pixels",
  "24 bpp BGR 888, packed pixels",
  "32 bpp ARGB 8888",
  "32 bpp ABGR 8888",
  "32 bpp RGBA 8888",
  "32 bpp BGRA 8888",
  "<empty>",
  "Unknown pixel format",
  0
};
#endif
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 x2D::Init()
{
  // Libraries

  ::GfxBase = (GFXBASE*)OpenLibrary("graphics.library", 40);
  if (!::GfxBase)
  {
    #ifdef X_DEBUG
    sysBASELIB::MessageBox("Debug Info", "Proceed", "x2D::Init()\nFailed to open graphics.library");
    #endif
    return ERR_RSC_UNAVAILABLE;
  }
  CyberGfxBase = OpenLibrary("cybergraphics.library", 42);
  if (!CyberGfxBase)
  {
    #ifdef X_DEBUG
    sysBASELIB::MessageBox("Debug Info", "Proceed", "x2D::Init()\nFailed to open cybergraphics.library");
    #endif
    return ERR_RSC_UNAVAILABLE;
  }

  return OK;
}

sint32 x2D::Done()
{
  if (CyberGfxBase)
  {
    CloseLibrary(CyberGfxBase);
    CyberGfxBase = 0;
  }
  if (::GfxBase)
  {
    CloseLibrary((LIBRARY*)::GfxBase);
    ::GfxBase = 0;
  }
  return OK;
}

// xGFX /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32        xGFX::flags     = 0;
xDMODE*       xGFX::mode      = 0;
uint32        xGFX::numModes  = 0;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xGFX CODE
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xGFX::Init()
{
  // Primary resources
  {
    if (flags & GFX_SYSTEM_OK)
      return OK; // prevents ill effects of multiple calls
  }

  // Set up the 2D system
  if (x2D::Init()!=OK)
    return ERR_RSC_UNAVAILABLE;

  // Build our xDMODE display database
  {
    List* cyberModeList = AllocCModeListTagList(0);
    if (cyberModeList == 0)
      return ERR_RSC_UNAVAILABLE;
    // count the number of modes present, add 1 for window mode
    for (Node* n = cyberModeList->lh_Head; n->ln_Succ; n = n->ln_Succ)
      numModes++;
    numModes++;

    mode = New(mode, numModes); // NOTE : replacement new[], broken in STORM 3 for polymorphic types
    if (mode == 0)
    {
      FreeCModeList(cyberModeList);
      return ERR_NO_FREE_STORE;
    }

    // mode[0] is really just a reference for window mode
    mode[0].ID = DISPLAYMODE_WINDOW;
    strncpy(mode[0].name, "Windowed", DISPLAYNAMELEN-1);

    sint32 m = 1;
    for (n = cyberModeList->lh_Head; n->ln_Succ; n = n->ln_Succ, m++)
    {
      mode[m].ReadCGXData((CyberModeNode*)n);
      surfaceTypes |= (1<<(mode[m].Format()));
    }
    FreeCModeList(cyberModeList);
    flags = GFX_SYSTEM_OK;
  }

  xDMODE* md = BestMode(640,380,15);

  // See if we have 3D support
  if (x3D::Init(md->ID)==OK) // choose a dead common display for 3D driver allocation
    flags |= GFX_3DHW_AVAIL;

  // Initialise any other xGraphics class static members
  xSURFACE::Init();
  #ifdef X_VERBOSE
  cerr << "xGFX Debug build : " __DATE__ " at " __TIME__ "\n";
  #endif
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xGFX::Done()
{
  if (!flags)
    return OK; // prevents ill effects of multiple calls

  // Free the display mode database
  if (mode)
    Delete(mode);

  // Finalise any other xGraphics class static members
  xSURFACE::Done();

  // Finalise 3D, if used
  if (flags & GFX_3DHW_AVAIL)
    x3D::Done();

  // Finalise 2D
  x2D::Done();

  // zero the status register
  flags = 0;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xDMODE* xGFX::BestMode(sint16 w, sint16 h, uint8 bpp, bool exact)
{
  sint32 m = 0, found = -1;
  if (exact)
  {
    while (++m < numModes && found == -1)
      found = ((mode[m].Width() == w) && (mode[m].Height() == h) && (mode[m].Depth() == bpp)) ? m : -1;
    if (found == -1)
    {
      return mode; // Window
    }
    else
      return &mode[found];
  }
  else
  {
    while (++m < numModes && found == -1)
      found = ((mode[m].Width() >= w) && (mode[m].Height() >= h) && (mode[m].Depth() >= bpp)) ? m : -1;
    if (found == -1)
      return mode;
    else
      return &mode[found];
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_VERBOSE
void xGFX::DumpModes(ostream& out)
{
  out << "xGFX : Mode dump, " << numModes << " modes available\n";
  for (sint32 n = 0; n < numModes; n++)
    mode[n].Dump(out);
  out << "\n";
}
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDMODE::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDMODE::ReadCGXData(CyberModeNode* m)
{
  ID      = m->DisplayID;
  width   = m->Width;
  height  = m->Height;
  depth   = m->Depth;
  format  = GetCyberIDAttr(CYBRIDATTR_PIXFMT, ID);
  strncpy(name, m->ModeText, DISPLAYNAMELEN-1);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_VERBOSE
void xDMODE::Dump(ostream& out)
{
  out << "\nxDMODE  : '" << Name() << "'\nProperties : W: " << Width() << ", H: " << Height() << ", " \
      << xGFX::DescSurface((SURFTYPE)Format()) << "\n";
}

#endif // X_DEBUG

