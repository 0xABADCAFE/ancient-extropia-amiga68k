//****************************************************************************//
//** File:         DRAW.hpp ($NAME=DRAW.hpp)                                **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      xGraphics                                                **//
//** Created:      2001-12-10                                               **//
//** Updated:      2002-02-01                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#ifndef _XSYSTEM_GFXLIBUTIL68K_HPP
#define _XSYSTEM_GFXLIBUTIL68K_HPP

#include <xsf/xsf.hpp>

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xTEXSURF_LOADER
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xTEXSURF_LOADER {

  private:
    static bool ValidatePPM(xFILEIO* f, sint32* w, sint32* h);
    static bool ValidatePGM(xFILEIO* f, sint32* w, sint32* h);
  public:
    static bool LoadPPMFixedAlphaWide(xTEXSURF* t, const char* name, uint8 alphaVal);
    static bool LoadPPMFixedAlphaNarrow(xTEXSURF* t, const char* ppmName, uint8 alphaVal);
    static bool LoadPPMOpaqueNarrow(xTEXSURF* t, const char* ppmName);
    static bool LoadPPMScaledAlphaWide(xTEXSURF* t, const char* ppmName, ARGB32 alphaGen);
    static bool LoadPPMScaledAlphaNarrow(xTEXSURF* t, const char* ppmName, ARGB32 alphaGen);
    static bool LoadPPMAlphaPGMWide(xTEXSURF* t, const char* ppmName, const char* pgmName);
    static bool LoadPPMAlphaPGMNarrow(xTEXSURF* t, const char* ppmName, const char* pgmName);
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xTEXFONT_FACTORY
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xTEXFONT_FACTORY {

};

#endif