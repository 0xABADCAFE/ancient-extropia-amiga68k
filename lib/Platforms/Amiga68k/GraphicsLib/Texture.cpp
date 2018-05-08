//*****************************************************************//
//** Description:   OS Layer classes, AmigaOS/68K version        **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2001-21-08                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xSystem/GraphicsLibOld.hpp>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xTEXTURE::
//
//  format corresponds to TEXSURF type (equiv to W3D type-1)
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXTURE::Create(S_WH, sint16 f, void* data, uint32* pal)
{
  if (x3D::Context() == 0 || data == 0)
  {
    return ERR_PTR_ZERO;
  }
  if (ctx || source)
  {
    return ERR_RSC_LOCKED;
  }
  ctx = x3D::Context(); source = data;
  if (pal && f == TXS_LUT_8)
  {
    TagItem tTags[] = {
      W3D_ATO_IMAGE,  (uint32)source,
      W3D_ATO_FORMAT, (uint32)W3D_CHUNKY,
      W3D_ATO_WIDTH,  (uint32)w,
      W3D_ATO_HEIGHT, (uint32)h,
      W3D_ATO_PALETTE,(uint32)pal,
      TAG_DONE,       0
    };
    tex = W3D_AllocTexObj(ctx, &error, tTags);
  }
  else
  {
    TagItem tTags[] = {
      W3D_ATO_IMAGE,  (uint32)source,
      W3D_ATO_FORMAT, (uint32)(f+1),
      W3D_ATO_WIDTH,  (uint32)w,
      W3D_ATO_HEIGHT, (uint32)h,
      TAG_DONE,       0
    };
    tex = W3D_AllocTexObj(ctx, &error, tTags);
  }
  if (tex)
  {
    x1 = 0; y1 = 0;
    x2 = width  = w;
    y2 = height = h;
    format  = f;
    return OK;
    //cout << "xTEXTURE::Create() OK\n";
  }
  //cout << "xTEXTURE::Create() W3D_AllocTexObj() error " << (sint32)error << "\n";
  return ERR_RSC;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXTURE::Delete()
{ // no texture
  if (tex==0)
  {
    //cout << "xTEXTURE::Delete() nothing to delete\n";
    return OK;
  }
  // context mismatch - This is deadly on current implementation
  // though the future shared context system will alleviate this
  if (ctx != x3D::Context())
  {
    //cout << "xTEXTURE::Delete() Invalid context address\n";
    return ERR_PTR_INCONSISTENT;
  }
  W3D_FreeTexObj(ctx, tex);
  tex     = 0;
  ctx     = 0;
  if (flags & OWNDATA && source!=0)
    MEM::Free(source);
  source  = 0;
  palette = 0;
  error   = 0;
  flags   = 0;
  //cout << "xTEXTURE::Delete() OK\n";
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXTURE::Load(const char* name, sint32 forceFmt)
{
  FILE *f = fopen(name, "r");
  if (!f)
    return ERR_FILE_OPEN;
  char sig[8] = {0};
  fread(sig, 1, 8, f);
  if (strncmp(sig, "xTEX32B",7)!=0)
  {
    fclose(f);
    return ERR_FILE_OPEN;
  }
  uint32 frame[6] = {0};
  fread(frame, 4, 6, f);
  if (frame[0] > 512 || frame[1] > 512)
  {
    fclose(f);
    return ERR_VALUE_MAX;
  }

  if (frame[0]<(frame[2]*frame[4]))
  {
    fclose(f);
    return ERR_FILE_CORRUPT;
  }
  if (frame[1]<(frame[3]*frame[5]))
  {
    fclose(f);
    return ERR_FILE_CORRUPT;
  }

  uint32* buffer = (uint32*)MEM::Alloc(frame[0]*frame[1]*4);
  if (!buffer)
  {
    fclose(f);
    return ERR_NO_FREE_STORE;
  }
  sint32 pix = fread(buffer, 4, frame[0]*frame[1], f);
  fclose(f);

  if (pix!=frame[0]*frame[1])
  {
    MEM::Free(buffer);
    return ERR_FILE_CORRUPT;
  }

  if (Create(frame[0], frame[1], TXS_ARGB_8888, buffer)!=OK)
  {
    MEM::Free(buffer);
    return ERR_RSC;
  }

  flags |= OWNDATA|MULTICELL;
  cW    = frame[2];
  cH    = frame[3];
  cHrz  = frame[4];
  cVrt  = frame[5];
  curr  = 0;
  cells = cHrz*cVrt;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXTURE::LoadPPM(const char* name, uint32 alphagen)
{
  FILE *f = fopen(name, "r");
  if (!f)
  {
    return ERR_FILE_OPEN;
  }
  uint32 w, h;
  sint32 i = fscanf(f, "P6\n%ld\n%ld\n255\n",&w, &h);
  if (i!= 2)
  {
    fclose(f);
    //cout << "xTEXTURE::LoadPPM() Error reading file\n";
    return ERR_FILE_READ;
  }
  void *src = MEM::Alloc(w*h*4); // space for ARGB32
  if (!src)
  {
    fclose(f);
    //cout << "xTEXTURE::LoadPPM() Not enough memory\n";
    return ERR_NO_FREE_STORE;
  }
  i = fread(src, 1, w*h*3, f);
  fclose(f);
  if (i != w*h*3)
  {
    MEM::Free(src);
    //cout << "xTEXTURE::LoadPPM() Unexpected EOF\n";
    return ERR_FILE_CORRUPT;
  }
  //cout << "xTEXTURE::LoadPPM() width = " << w << ", height = " << h << "\n";
  i = (w*h)-1; // index size
  {
    ruint8* s   = (uint8*)src+(3*i); // points to last 24bit PPM pixel
    ruint32* d  = (uint32*)src;

    if ((alphagen & 0x00FFFFFF) == 0)
    { // basic alpha value
      i++;
      while (--i>=0)
      {
        ruint32 x = alphagen | ((*s)<<16) | ((*(s+1))<<8) | (*(s+2));
        d[i] = x;   s-=3;
      }
    }
    else
    { // biased alpha value. Alpha determined through bias. Each colour channel has a bias value
      // that describes its overall contribution to the opacity
      ruint32 red = ((alphagen & 0x00FF0000)>>16);
      ruint32 grn = ((alphagen & 0x0000FF00)>>8);
      ruint32 blu = (alphagen & 0x000000FF);
      ruint32 alp = (alphagen >> 24);
      ruint32 dvz = (red<<8) + (grn<<8) + (blu<<8);
      if (dvz == 0)
      {
        //cout << "eh\n";
        dvz = 65536*3;
      }
      i++;
      while (--i>=0)
      {
        uint32 a = alp*(red*(*s)+grn*(*(s+1))+blu*(*(s+2)));
        a/=dvz;
        d[i] = a<<24|((*s)<<16)|((*(s+1))<<8)|(*(s+2)); s-=3;
      }
    }
  }
  if (Create(w, h, TXS_ARGB_8888, src)!=OK)
  {
    MEM::Free(src);
    return ERR_RSC;
  }
  else
    flags |= OWNDATA;
  //cout << "xTEXTURE::LoadPPM() OK\n";
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXTURE::LoadLST(const char *name, sint16 fmt)
{
/*
  if ((fmt!=TXS_LUT_8) && (fmt!=TXS_ARGB_4444) && (fmt!=TXS_ARGB_8888));
    return ERR_VALUE_ILLEGAL;
*/
  FILE *f = fopen(name, "r");
  if (!f)
    return ERR_FILE_OPEN;
  char sig[8] = {0};
  fread(sig, 1, 8, f);
  if (strncmp(sig, "xLST256",7)!=0)
  {
    fclose(f);
    return ERR_FILE_OPEN;
  }
  uint32 frame[6] = {0};
  fread(frame, 4, 6, f);
  if (frame[0] > 512 || frame[1] > 512)
  {
    fclose(f);
    //cout << "w = " << frame[0] << ", h = " << frame[1] << "\n";
    return ERR_VALUE_MAX;
  }
  if (frame[0]<(frame[2]*frame[4]))
  {
    fclose(f);
    return ERR_FILE_CORRUPT;
  }
  if (frame[1]<(frame[3]*frame[5]))
  {
    fclose(f);
    return ERR_FILE_CORRUPT;
  }
  uint32 dataSize = 1024 + (frame[0]*frame[1]); // 1024 = palette data (can probably be squeezed to 32 by calculating instead of storing)
  void* buffer = MEM::Alloc(dataSize);
  if (!buffer)
  {
    fclose(f);
    return ERR_NO_FREE_STORE;
  }
  fread(buffer, 1, dataSize, f);
  fclose(f);
  uint32* pal = (uint32*)buffer;
  uint8*  dat = (uint8*)buffer+1024;

  if (fmt==TXS_LUT_8)
  { // 8 bit bitmap - seems broken for now. W3D bug ?
    if (Create(frame[0], frame[1], TXS_LUT_8, dat, pal)!=OK)
    {
      MEM::Free(buffer);
      return ERR_RSC;
    }
  }
  else if (fmt==TXS_ARGB_4444)
  { // 16 bit bitmap (4096 colour with 16*alpha)
    uint16* destBuffer = (uint16*)MEM::Alloc(frame[0]*frame[1]*2);
    if (!destBuffer)
    {
      MEM::Free(buffer);
      return ERR_NO_FREE_STORE;
    }
    for (ruint32 i=0; i < (frame[0]*frame[1]); i++)
    {
      ruint32 c = pal[(dat[i])];

      ruint16 t1 = (c & 0x000000F0)>>4;
      t1 |= (c & 0x0000F000)>>8;
      t1 |= (c & 0x00F00000)>>12;
      t1 |= (c & 0xF0000000)>>16;
      destBuffer[i]=t1;;
    }
    MEM::Free(buffer);
    if (Create(frame[0], frame[1], TXS_ARGB_4444, destBuffer)!=OK)
    {
      MEM::Free(destBuffer);
      return ERR_RSC;
    }
  }
  else
  { // full colour
    uint32* destBuffer = (uint32*)MEM::Alloc(frame[0]*frame[1]*4);
    if (!destBuffer)
    {
      MEM::Free(buffer);
      return ERR_NO_FREE_STORE;
    }
    for (uint32 i=0; i < (frame[0]*frame[1]); i++)
    {
      destBuffer[i]=pal[(dat[i])];
    }
    MEM::Free(buffer);
    if (Create(frame[0], frame[1], TXS_ARGB_8888, destBuffer)!=OK)
    {
      MEM::Free(destBuffer);
      return ERR_RSC;
    }
  }
  flags |= OWNDATA|MULTICELL;

  cW    = frame[2];
  cH    = frame[3];
  cHrz  = frame[4];
  cVrt  = frame[5];
  curr  = 0;
  cells = cHrz*cVrt;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXTURE::DefineCell(ICOORD2D cDim, sint16 h, sint16 v)
{
  if ((h*CoordX(cDim)) > width || (v*CoordY(cDim)> height))
    return ERR_VALUE_MAX;
  if (CoordX(cDim)<=0 || CoordY(cDim)<=0 || h<=0 || v<=0)
    return ERR_VALUE_MIN;
  cW = CoordX(cDim); cH = CoordY(cDim); cHrz = h; cVrt = v;
  curr  = 0;
  cells = cHrz*cVrt;
  flags |= MULTICELL;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

