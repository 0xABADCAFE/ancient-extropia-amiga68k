//****************************************************************************//
//** File:         Util.cpp ($NAME=Util.cpp)                                **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is for AmigaOS 68K systems                     **//
//** Library:      GraphicsLib                                              **//
//** Created:      2001-12-10                                               **//
//** Updated:      2002-02-01                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):      Image loaders                                            **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include <xSystem/GraphicsLib.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF_LOADER::ValidatePPM(xFILEIO* f, sint32* width, sint32* height)
{
  if (f->Valid()==false || !width || !height)
    return false;
  sint32 w, h;
  char sig[32] = {0};
  f->ReadText(sig, 32, '\n', 4);
  if (sscanf(sig, "P6\n%ld\n%ld\n255\n", &w, &h)!=2 || (f->Size() - f->Tell()) != w*h*3)
    return false;
  *width = w;
  *height = h;
  return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF_LOADER::ValidatePGM(xFILEIO* f, sint32* width, sint32* height)
{
  if (f->Valid()==false || !width || !height)
    return false;
  sint32 w, h;
  char sig[32] = {0};
  f->ReadText(sig, 32, '\n', 4);
  if (sscanf(sig, "P5\n%ld\n%ld\n255\n", &w, &h)!=2 || (f->Size() - f->Tell()) != w*h)
    return false;
  *width = w;
  *height = h;
  return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF_LOADER::LoadPPMFixedAlphaWide(xTEXSURF* t, const char* ppmName, uint8 alphaVal)
{ // Loads a PPM file as ARGB32, alpha value set by caller
  if (!t || !ppmName || t->Data())
    return false;
  xFILEIO file(ppmName, xFILEIO::READ);
  sint32 w=0, h=0;
  if (ValidatePPM(&file, &w, &h)==false || t->Create(w, h, xTEXSURF::TXL_ARGB_8888)!=OK)
    return false;
  else
  {
    ruint32 a = (uint32)alphaVal<<24;
    rsint32 n = (w*h)+1;
    ruint32* dest = (uint32*)t->Data();
    while (--n)
    {
      ruint32 t = a | ((uint8)file.GetChar())<<16;
      t |= ((uint8)file.GetChar())<<8;
      t |= ((uint8)file.GetChar());
      *(dest++) = t;
    }
  }
  file.Close();
  t->Bind();
  return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF_LOADER::LoadPPMFixedAlphaNarrow(xTEXSURF* t, const char* ppmName, uint8 alphaVal)
{ // Loads a PPM file as ARGB4444, alpha value set by caller
  // If alpha value is totally opaque, data loaded as ARGB1555 to achieve better colour precision
  if (!t || !ppmName || t->Data())
    return false;
  else if ((alphaVal&0xF0) == 0xF0)
    return LoadPPMOpaqueNarrow(t, ppmName);
  xFILEIO file(ppmName, xFILEIO::READ);
  sint32 w=0, h=0;
  if (ValidatePPM(&file, &w, &h)==false || t->Create(w, h, xTEXSURF::TXL_ARGB_4444)!=OK)
    return false;
  else
  {
    ruint16 a = (alphaVal&0xF0)<<8;
    rsint32 n = (w*h)+1;
    ruint16* dest = (uint16*)t->Data();
    while (--n)
    {
      ruint16 t = a | (((uint8)file.GetChar())&0xF0)<<4;
      t |= (((uint8)file.GetChar())&0xF0);
      t |= (((uint8)file.GetChar())&0xF0)>>4;
      *(dest++) = t;
    }
  }
  file.Close();
  t->Bind();
  return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF_LOADER::LoadPPMOpaqueNarrow(xTEXSURF* t, const char* ppmName)
{ // Loads a PPM file as ARGB1555, alpha value set to 1
  if (!t || !ppmName || t->Data())
    return false;
  xFILEIO file(ppmName, xFILEIO::READ);
  sint32 w=0, h=0;
  if (ValidatePPM(&file, &w, &h)==false || t->Create(w, h, xTEXSURF::TXL_ARGB_1555)!=OK)
    return false;
  else
  {
    rsint32 n = (w*h)+1;
    ruint16* dest = (uint16*)t->Data();
    while (--n)
    {
      ruint16 t = 0x8000 | (((uint8)file.GetChar())&0xF8)<<7;
      t |= (((uint8)file.GetChar())&0xF8)<<2;
      t |= (((uint8)file.GetChar())&0xF8)>>3;
      *(dest++) = t;
    }
  }
  file.Close();
  t->Bind();
  return true;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF_LOADER::LoadPPMScaledAlphaWide(xTEXSURF* t, const char* ppmName, ARGB32 alphaGen)
{
  // Loads a PPM file as ARGB32, alpha value calculated based on alphaGen
  if (!t || !ppmName || t->Data())
    return false;
  xFILEIO file(ppmName, xFILEIO::READ);
  sint32 w=0, h=0;
  if (ValidatePPM(&file, &w, &h)==false || t->Create(w, h, xTEXSURF::TXL_ARGB_8888)!=OK)
    return false;
  else
  {
    uint32 dvz = (alphaGen.Red()<<8) + (alphaGen.Green()<<8) + (alphaGen.Blue()<<8);
    rsint32 n = (w*h)+1;
    ruint32* dest = (uint32*)t->Data();
    while (--n)
    {
      ruint32 v = (uint8)file.GetChar();
      ruint32 t = v<<16;
      ruint32 a = v*alphaGen.Red();
      v = (uint8)file.GetChar();  t |= v<<8;  a += v*alphaGen.Green();
      v = (uint8)file.GetChar();  t |= v;     a += v*alphaGen.Blue();
      a = (a*alphaGen.Alpha())/dvz;
      *(dest++) = a<<24 | t;
    }
  }
  file.Close();
  t->Bind();
  return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF_LOADER::LoadPPMScaledAlphaNarrow(xTEXSURF* t, const char* ppmName, ARGB32 alphaGen)
{
  // Loads a PPM file as ARGB32, alpha value calculated based on alphaGen
  if (!t || !ppmName || t->Data())
    return false;
  xFILEIO file(ppmName, xFILEIO::READ);
  sint32 w=0, h=0;
  if (ValidatePPM(&file, &w, &h)==false || t->Create(w, h, xTEXSURF::TXL_ARGB_4444)!=OK)
    return false;
  else
  {
    uint32 dvz = ((alphaGen.Red()<<8) + (alphaGen.Green()<<8) + (alphaGen.Blue()<<8))<<4;
    rsint32 n = (w*h)+1;
    ruint16* dest = (uint16*)t->Data();
    while (--n)
    {
      ruint32 v = (uint8)file.GetChar();
      ruint16 t = (v&0xF0)<<4;
      ruint32 a = v*alphaGen.Red();
      v = (uint8)file.GetChar(); t |= v&0xF0; a += v*alphaGen.Green();
      v = (uint8)file.GetChar(); t |= (v>>4); a += v*alphaGen.Blue();
      a = (a*alphaGen.Alpha())/dvz;
      *(dest++) = a<<12 | t;
    }
  }
  file.Close();
  t->Bind();
  return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF_LOADER::LoadPPMAlphaPGMWide(xTEXSURF* t, const char* ppmName, const char* pgmName)
{
  // Creates an ARGB32 texture
  // Loads colour component a PPM file
  // Loads alpha component from a PGM file
  if (!t || !ppmName || t->Data())
    return false;
  // load colour component
  xFILEIO file(ppmName, xFILEIO::READ);
  sint32 w=0, h=0, aw=0, ah=0;
  if (ValidatePPM(&file, &w, &h)==false || t->Create(w, h, xTEXSURF::TXL_ARGB_8888)!=OK)
    return false;
  else
  {
    rsint32 n = (w*h)+1;
    ruint32* dest = (uint32*)t->Data();
    while (--n)
    {
      ruint32 t = ((uint8)file.GetChar())<<16;
      t |= ((uint8)file.GetChar())<<8;
      t |= ((uint8)file.GetChar());
      *(dest++) = t;
    }
  }
  file.Close();
  // load alpha component
  file.Open(pgmName, xFILEIO::READ);
  if (ValidatePGM(&file, &aw, &ah)==false)
  {
    t->Delete();
    return false;
  }
  else if (aw!=w || ah!=h)
  {
    t->Delete();
    return false;
  }
  else
  {
    rsint32 n = 1+(w*h);
    ruint32* dest = (uint32*)t->Data();
    while (--n)
    {
      ruint32 argb = ((uint8)file.GetChar())<<24;
      argb |= (*dest & 0x00FFFFFF);
      *(dest++) = argb ;
    }
  }
  file.Close();
  t->Bind();
  return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF_LOADER::LoadPPMAlphaPGMNarrow(xTEXSURF* t, const char* ppmName, const char* pgmName)
{
  // Creates an ARGB32 texture
  // Loads colour component a PPM file
  // Loads alpha component from a PGM file
  if (!t || !ppmName || t->Data())
    return false;

  // load colour component
  xFILEIO file(ppmName, xFILEIO::READ);
  sint32 w=0, h=0, aw=0, ah=0;
  if (ValidatePPM(&file, &w, &h)==false || t->Create(w, h, xTEXSURF::TXL_ARGB_8888)!=OK)
    return false;
  else
  {
    rsint32 n = (w*h)+1;
    ruint16* dest = (uint16*)t->Data();
    while (--n)
    {
      ruint16 t = (((uint8)file.GetChar())&0xF0)<<4;
      t |= (((uint8)file.GetChar())&0xF0);
      t |= (((uint8)file.GetChar())&0xF0)>>4;
      *(dest++) = t;
    }
  }
  file.Close();

  // load alpha component
  file.Open(pgmName, xFILEIO::READ);
  if (ValidatePGM(&file, &aw, &ah)==false)
  {
    t->Delete();
    return false;
  }
  else if (aw!=w || ah!=h)
  {
    t->Delete();
    return false;
  }
  else
  {
    rsint32 n = (w*h)+1;
    ruint16* dest = (uint16*)t->Data();
    while (--n)
    {
      ruint16 argb = (((uint8)file.GetChar())&0xF0)<<8;
      argb |= (*dest & 0x0FFF);
      *(dest++) = argb;
    }
  }
  file.Close();
  t->Bind();
  return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
