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

LIBRARY       *Warp3DBase     = 0;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  x3D
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

W3D_Driver*   sys3DDEVICE::hw3D         = 0;
W3D_Context*  sys3DDEVICE::context      = 0;

xSURFACE*     x3D::drawSurface  = 0;
uint32        x3D::flags        = 0;
W3D_Scissor   x3D::drawRegion   = {0};
W3D_Fog       x3D::fogData      = {0};
DVERTEX*      x3D::vertices     = 0;
sysTEXTURE*   x3D::currTex      = 0;
uint32        x3D::currCol      = 0;

bool          x3D::useV4        = FALSE;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 x3D::Init(uint32 ID)
{
  if (Warp3DBase)
    return OK;
  if (Warp3DBase = OpenLibrary("Warp3D.library", 4))
  {
    if (W3D_CheckDriver() != W3D_DRIVER_UNAVAILABLE)
    {
      hw3D = W3D_TestMode(ID);
      if (hw3D)
        return OK;
      else
      {
        //#ifdef X_DEBUG
        //sysBASELIB::MessageBox("Debug Info", "Proceed", "x3D::Init()\nFailed to find suitable driver");
        //#endif
        return ERR_RSC_UNAVAILABLE;
      }
    }
    else
    {
/*
      #ifdef X_DEBUG
      sysBASELIB::MessageBox("Debug Info", "Proceed", "x3D::Init()\nFailed to find any driver");
      #endif
*/
      return ERR_RSC_UNAVAILABLE;
    }
  }
/*
  #ifdef X_DEBUG
  else
    sysBASELIB::MessageBox("Debug Info", "Proceed", "x3D::Init()\nFailed to open Warp3D.library");
  #endif
*/
  return ERR_RSC_UNAVAILABLE;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 x3D::Done()
{
  //SUPPORTS3D::FreeDataBase();
  if (Warp3DBase)
  {
    CloseLibrary(Warp3DBase);
    Warp3DBase = 0;
  }
  return OK;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 x3D::BuildContext(xSURFACE* s, bool indirect)
{
  uint32 fault = 0;
  if (indirect)
    context = W3D_CreateContextTags(&fault,
      W3D_CC_BITMAP,      (uint32)(s->Handle()),
      W3D_CC_DRIVERTYPE,  W3D_DRIVER_BEST,
      W3D_CC_FAST,        true,
      W3D_CC_INDIRECT,    true,
      W3D_CC_YOFFSET,     0,
      TAG_DONE);
  else
    context = W3D_CreateContextTags(&fault,
      W3D_CC_BITMAP,      (uint32)(s->Handle()),
      W3D_CC_DRIVERTYPE,  W3D_DRIVER_BEST,
      W3D_CC_FAST,        true,
      W3D_CC_YOFFSET,     0,
      TAG_DONE);

  if(!context)
  {
/*
    #ifdef X_DEBUG
    sysBASELIB::MessageBox("Debug Info", "Proceed", "x3D::BuildContext()\nFailed");
    #endif
*/
    return ERR_RSC_UNAVAILABLE;
  }
  else
  {
    drawSurface = s;
    drawRegion.width  = s->Width();
    drawRegion.height = s->Height();
    W3D_SetDrawRegion(context, s->Handle(), 0, &drawRegion);
    W3D_SetScissor(context, &drawRegion);
    W3D_SetState(context, W3D_SCISSOR, W3D_ENABLE);
    W3D_SetState(context, W3D_DITHERING, W3D_ENABLE);
    W3D_SetState(context, W3D_GOURAUD, W3D_DISABLE);
    W3D_SetState(context, W3D_TEXMAPPING, W3D_DISABLE);
    W3D_SetState(context, W3D_ZBUFFER, W3D_DISABLE);
    W3D_SetState(context, W3D_GLOBALTEXENV, W3D_DISABLE);
    W3D_SetBlendMode(context, W3D_SRC_ALPHA, W3D_ONE_MINUS_SRC_ALPHA);
    W3D_SetState(context, W3D_BLENDING, W3D_DISABLE);
  }
  // Set the surface rastport options for text rendering and stuff;
  SetDrMd(drawSurface->LHandle(), JAM1);
  return OK;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 x3D::FreeContext()
{
  if (context)
  {
/*
    if (drawSurface && LockHW()==OK)
    {
      W3D_FlushFrame(context);
      UnLockHW();
    }
*/
    W3D_BindTexture(context, 0, 0);
    W3D_VertexPointer(context, 0, 0, W3D_VERTEX_F_F_F, 0);
    W3D_TexCoordPointer(context, 0, 0, 0, 0, 0, 0);
    W3D_ColorPointer(context, 0, 0, W3D_COLOR_UBYTE, W3D_CMODE_ARGB, 0);
    W3D_FlushTextures(context);
    W3D_FreeZBuffer(context);
    W3D_DestroyContext(context);
    context = 0;
    drawSurface = 0;
  }
  return OK;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::DrawSurface(xSURFACE* s)
{
  if (W3D_SetDrawRegion(context, s->Handle(), 0, &drawRegion)==W3D_SUCCESS)
  {
    drawSurface = s;
    return true;
  }
  return false;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
sysTEXTURE* x3D::CreateTexture(S_WH, TX_SURFTYPE fmt, void* data, uint32* pal)
{
  if ((!context) || (!data))
    return 0;
  uint32 result = 0;
  if (pal && (fmt == TXS_LUT_8))
  {
    TagItem tTags[] = {
      W3D_ATO_IMAGE,  (uint32)data,
      W3D_ATO_FORMAT, (uint32)W3D_CHUNKY,
      W3D_ATO_WIDTH,  (uint32)w,
      W3D_ATO_HEIGHT, (uint32)h,
      W3D_ATO_PALETTE,(uint32)pal,
      TAG_DONE,       0
    };
    return W3D_AllocTexObj(context, &result, tTags);
  }
  else
  {
    TagItem tTags[] = {
      W3D_ATO_IMAGE,  (uint32)data,
      W3D_ATO_FORMAT, (uint32)(fmt+1),
      W3D_ATO_WIDTH,  (uint32)w,
      W3D_ATO_HEIGHT, (uint32)h,
      TAG_DONE,       0
    };
    return W3D_AllocTexObj(context, &result, tTags);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 x3D::DeleteTexture(sysTEXTURE* tex)
{
  if ((!tex) || (!context))
    return WRN_RSC_UNAVAILABLE;
  else
    W3D_FreeTexObj(context, tex);
  return OK;
}
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::SetVertexArray(DVERTEX* v)
{
  if (!context)
    return false;
  vertices = v;
  if (v)
  {
    W3D_VertexPointer(context, (uint8*)v+DV_OFS_XYZ, DV_STRIDE, W3D_VERTEX_F_F_F, 0);
    W3D_TexCoordPointer(context, (uint8*)v+DV_OFS_UV, DV_STRIDE, 0, DV_OFS_V, DV_OFS_W, 0);
    W3D_ColorPointer(context, (uint8*)v+DV_OFS_CLR, DV_STRIDE, W3D_COLOR_UBYTE, W3D_CMODE_ARGB, 0);
    return true;
  }
  W3D_VertexPointer(context, 0, DV_STRIDE, W3D_VERTEX_F_F_F, 0);
  W3D_TexCoordPointer(context, 0, DV_STRIDE, 0, DV_OFS_V, DV_OFS_W, 0);
  W3D_ColorPointer(context, 0, DV_STRIDE, W3D_COLOR_UBYTE, W3D_CMODE_ARGB, 0);
  return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::SetDrawArea(S_2CRD)
{
  drawRegion.left   = x1;     drawRegion.top = y1;
  drawRegion.width  = x2-x1;  drawRegion.height = y2-y1;
  return (W3D_SetDrawRegion(context, drawSurface->Handle(), 0, &drawRegion)==W3D_SUCCESS);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::SetDrawArea(xSURFACE* s, S_2CRD)
{
  if (!s || !s->Handle() || !context)
    return false;
  W3D_Scissor t = { x1, y1, x2-x1, y2-y1 };
  if (W3D_SetDrawRegion(context, s->Handle(), 0, &t)==W3D_SUCCESS)
  {
    drawSurface = s;
    drawRegion  = t;
    return true;
  }
  W3D_SetDrawRegion(context, drawSurface->Handle(), 0, &drawRegion);
  return false;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::SetColour(uint32 c)
{
  if (c==currCol)
    return true;
  rfloat32 f = 1F/256F;
  sysCOLOUR4C rgba = {  f*((c&0x00FF0000)>>16),
                        f*((c&0x0000FF00)>>8),
                        f*(c&0x000000FF),
                        f*((c&0xFF000000)>>24) };
  if (W3D_SetCurrentColor(context, &rgba)==W3D_SUCCESS)
  {
    currCol = c;
    return true;
  }
  return false;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::SetFogProperties(x3D::FMODE m, uint32 c, float32 s, float32 e, float32 d)
{
  fogData.fog_start = s;
  fogData.fog_end = e;
  fogData.fog_density = d;
  {
    rfloat32 f = 1F/256F;
    fogData.fog_color.r = f*((c&0x00FF0000)>>16);
    fogData.fog_color.g = f*((c&0x0000FF00)>>8);
    fogData.fog_color.b = f*(c&0x000000FF);
  }
  return (W3D_SetFogParams(context, &fogData, m)==W3D_SUCCESS);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::DownloadZBuffer(S_2CRD, float64* p)
{
  if (!p) return false;
  uint32 span = x2-x1;
  uint32 h    = 1+y2-y1;
  while(--h)
  {
    if (W3D_ReadZSpan(context, x1, y1++, span, p)!=W3D_SUCCESS)
      return false;
    p+=span;
  }
  return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::UploadZBuffer(S_2CRD, float64* p)
{
  if (!p) return false;
  uint32 span = x2-x1;
  uint32 h    = 1+y2-y1;
  while(--h)
  {
    W3D_WriteZSpan(context, x1, y1++, span, p, 0);
    p+=span;
  }
  return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::DownloadStencil(S_2CRD, uint32* p)
{
  if (!p) return false;
  uint32 span = x2-x1;
  uint32 h    = 1+y2-y1;
  while(--h)
  {
    if (W3D_ReadStencilSpan(context, x1, y1++, span, p)!=W3D_SUCCESS)
      return false;
    p+=span;
  }
  return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  OLD STYLE DRAWING
//
//  It seems Warp3D4 vertex array funcs only draw triangles on my set up. The following funcs emulate some
//  array features for other primitives
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool x3D::v3DrawLines(sint32 ofst, sint32 vCnt)
{
  if (vertices==0 || vCnt < 2)
    return false;

  W3D_Line line;
  line.tex = currTex;
  if (Enabled(GOURAUD)) // shaded vertices need more work
  {
    register DVERTEX* d = vertices+ofst;
    rsint32 cnt2 = 1+(vCnt>>1);
    rfloat32 colFac = 1F/256F;
    while (--cnt2)
    {
      line.v1.x       = d->x; line.v1.y = d->y; line.v1.z = d->z; line.v1.w = d->w;
      line.v1.u       = d->u; line.v1.v = d->v;
      ruint32 clr     = (d++)->colour;
      line.v1.color.r = colFac*((clr & 0x00FF0000)>>16);
      line.v1.color.g = colFac*((clr & 0x0000FF00)>>8);
      line.v1.color.b = colFac*( clr & 0x000000FF);
      line.v1.color.a = colFac*((clr & 0xFF000000)>>24);
      line.v2.x       = d->x; line.v2.y = d->y; line.v2.z = d->z; line.v1.w = d->w;
      line.v2.u       = d->u; line.v2.v = d->v;
      clr             = (d++)->colour;
      line.v2.color.r = colFac*((clr & 0x00FF0000)>>16);
      line.v2.color.g = colFac*((clr & 0x0000FF00)>>8);
      line.v2.color.b = colFac*( clr & 0x000000FF);
      line.v2.color.a = colFac*((clr & 0xFF000000)>>24);
      if (W3D_DrawLine(context, &line)!=W3D_SUCCESS)
        return false;
    }
    return true;
  }
  else
  {
    register DVERTEX* d = vertices+ofst;
    rsint32 cnt2 = 1+(vCnt>>1);
    while (--cnt2)
    {
      line.v1.x       = d->x; line.v1.y = d->y; line.v1.z = d->z; line.v1.w = d->w;
      line.v1.u       = d->u; line.v1.v = (d++)->v;
      line.v2.x       = d->x; line.v2.y = d->y; line.v2.z = d->z; line.v2.w = d->w;
      line.v2.u       = d->u; line.v2.v = (d++)->v;
      if (W3D_DrawLine(context, &line)!=W3D_SUCCESS)
        return false;
    }
    return true;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define OLD_STRIP_SEGS 32

bool x3D::v3DrawLineStrip(sint32 ofst, sint32 vCnt)
{
  if (vertices==0 || vCnt < 2)
    return false;

  W3D_Vertex sysVerts[OLD_STRIP_SEGS+2];
  W3D_Lines lines = {0,sysVerts,currTex};
  register DVERTEX* d = vertices+ofst;
  if (Enabled(GOURAUD)) // shaded vertices require more work
  {
    rsint32 c = --vCnt;
    rfloat32 colFac = 1F/256F; lines.vertexcount = OLD_STRIP_SEGS+1;
    while (c>OLD_STRIP_SEGS)
    {
      register W3D_Vertex* v = sysVerts; rsint32 i = OLD_STRIP_SEGS+2;
      while(--i)
      {
        v->x = d->x; v->y = d->y; v->z = d->z; v->w = d->w; v->u = d->u; v->v = d->v;
        ruint32 clr     = (d++)->colour;
        v->color.r      = colFac*((clr & 0x00FF0000)>>16);  v->color.g      = colFac*((clr & 0x0000FF00)>>8);
        v->color.b      = colFac*( clr & 0x000000FF);       (v++)->color.a  = colFac*((clr & 0xFF000000)>>24);
      }
      if (W3D_DrawLineStrip(context, &lines)!=W3D_SUCCESS)
        return false;
      d--;
      c-=OLD_STRIP_SEGS;
    }
    if (c>0)
    {
      if (c<vCnt) // end of existing series of line segments
      {
        d--; c++;
      }
      register W3D_Vertex* v = sysVerts;  lines.vertexcount = ++c;  rsint32 i = ++c;
      while(--i)
      {
        v->x = d->x; v->y = d->y; v->z = d->z; v->w = d->w; v->u = d->u; v->v = d->v;
        ruint32 clr     = (d++)->colour;
        v->color.r      = colFac*((clr & 0x00FF0000)>>16);  v->color.g      = colFac*((clr & 0x0000FF00)>>8);
        v->color.b      = colFac*( clr & 0x000000FF);       (v++)->color.a  = colFac*((clr & 0xFF000000)>>24);
      }
      if (W3D_DrawLineStrip(context, &lines)!=W3D_SUCCESS)
        return false;
    }
    return true;
  }
  else // non shaded vertices
  {
    rsint32 c = --vCnt;
    lines.vertexcount = OLD_STRIP_SEGS+1;
    while (c>OLD_STRIP_SEGS)
    {
      register W3D_Vertex* v = sysVerts;
      rsint32 i = OLD_STRIP_SEGS+2;
      while(--i)
      {
        v->x = d->x; v->y = d->y; v->z = d->z; v->w = d->w; v->u = d->u; (v++)->v = (d++)->v;
      }
      if (W3D_DrawLineStrip(context, &lines)!=W3D_SUCCESS)
        return false;
      d--;
      c-=OLD_STRIP_SEGS;
    }
    if (c>0)
    {
      if (c<vCnt) // end of existing series of line segments
      {
        d--; c++;
      }
      register W3D_Vertex* v = sysVerts; lines.vertexcount = ++c; rsint32 i = ++c;
      while (--i)
      {
        v->x = d->x; v->y = d->y; v->z = d->z; v->w = d->w; v->u = d->u; (v++)->v = (d++)->v;
      }
      if (W3D_DrawLineStrip(context, &lines)!=W3D_SUCCESS)
        return false;
    }
    return true;
  }
}

#undef OLD_STRIP_SEGS

