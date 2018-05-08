//*****************************************************************//
//** Description:   Axonometric Projector, AmigaOS/68K version   **//
//** First Started:                                              **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

/*

  TO DO

  FIXES

    1) Fix MAPCELL::Visibility() to take into account surface topology. Currently only x/y ordinates tested

  EXPANSION

    1) Implement method for determining z for any x/y point within a MAPCELL (tricky)
       Probably require formal equation of surface through 3 points to derive z = f(x,y)
    2) Implement multiple object support (array of MODEL* ?)
    3) Implement MAPCELL mesh support & geometry level of detail

*/

#include "axon.hpp"
#include <stdlib.h>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  MAPCELL::
//
//  Basic map unit. Since map cells typically involve a lot of vertices, we project straight into our own vertex stack.
//  This way, we dont do the MAPC3D -> W3D_Vertex* conversion for MAPCELLs unless the view changes.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

MAPCELL::MAPCELL() : flags(0), points(4), projected(0), thing(0), tex(0), detail(0)
{
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

MAPCELL::~MAPCELL()
{
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MAPCELL::Set(C3D& tl, C3D& tr, C3D& br, C3D& bl, UINT32 c, xTEXTURE* t, xTEXTURE* d)
{
  data[0].x = (tl.x + tr.x)/2F;
  data[0].y = (tl.y + bl.y)/2F;
  data[0].z = tr.z + bl.z / 2F;
  data[0].u = 2F*d->Width();
  data[0].v = 2F*d->Height();
  data[0].c = c;

  data[1] = tl;
  data[2] = bl;
  data[3] = tr;
  data[4] = br;

  tex = TexHandle(t);
  detail = TexHandle(d);
  for(SINT32 i=0; i < 5; i++)
  {
    if (data[i].z < WORLDMAP::SeaLevel())
      flags |= WATER;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FLOAT32 MAPCELL::Topology()
{
  FLOAT32 z_average = (data[1].z + data[2].z + data[3].z + data[4].z)/4F;
  FLOAT32 dz = fabs(data[1].z-z_average) + fabs(data[2].z-z_average)
             + fabs(data[3].z-z_average) + fabs(data[4].z-z_average);
  return dz/4F;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

BOOL MAPCELL::Visibility(VIEW& view)
{
  flags &= ~VIS;

  SINT16 numVerts = (flags & WATER) ? (2*points)+4 : (2*points);
  FLOAT32 c = QCos(view.Pitch());

  // Evaluates if any of the clip points of the MAPCELL fall into the projected VIEW
  if (view.State(VIEW::BOUNDS_PERP))
  {
    // simple test since boundary is colinear with map
    RSINT32 i = 0;
    while (++i<5)
    {
      RFLOAT32 x = data[i].x;
      RFLOAT32 y = data[i].y;// + c*data[i].z;
      if (x >= view.BTL().x && y <= view.BTL().y && x <= view.BBR().x && y >= view.BBR().y)
      {
        flags |= VIS;
        #ifdef CLIPSTATS
        centreClips++;
        #endif
        projected = WORLDMAP::CachedVertices(numVerts);
        return TRUE;
      }
    }
    projected = NOTSET;
    return FALSE;
  }
  else
  {
    // does projected view corner overlap an edge of the cell ?

    register C2D* vp = view.projected;
    {
      RSINT32 i = 0;
      while (i<4)
      {
        if (vp[i].x >= data[1].x && vp[i].y <= data[1].y && vp[i].x <= data[4].x && vp[i].y >= data[4].y)
        {
          #ifdef CLIPSTATS
          edgeClips++;
          #endif
          flags |= VIS;
          projected = WORLDMAP::CachedVertices(numVerts);
          return TRUE;
        }
        i++;
      }
    }

    // More complex test. Need to check point against following boundaries
    //
    // A1'() Parallel through TL        (TL-TR)
    // A1"() Perpendicular through TL   (TL-BL)
    // A2'() Parallel through BR        (BL-BR)
    // A2"() Perpendicular through BR   (TR-BR)
    //
    // The comparison depends on which quarter circle vA is in

    RFLOAT32 pp = Perp(view.vA);
    RFLOAT32 pl = Parallel(view.vA);
    if (view.vA < 90) // 1st quarter
    {
      RSINT32 i = 0;
      while (i<5)
      {
        RFLOAT32 x = data[i].x; RFLOAT32 y = data[i].y;// + c*data[1].z;
        RFLOAT32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py <= A1'(Px)
        if (y <= yTest)
        {
          yTest = vp[0].y+(x-vp[0].x)*pp;         // Py >= A1"(Px)
          if (y >= yTest)
          {
            yTest = vp[2].y+(x-vp[2].x)*pl;       // Py >= A2'(Px)
            if (y >= yTest)
            {
              yTest = vp[2].y+(x-vp[2].x)*pp;     // Py <= A2"(Px)
              if (y <= yTest)
              {
                flags |= VIS;
                #ifdef CLIPSTATS
                if (i)
                  cornerClips++;
                else
                  centreClips++;
                #endif
                projected = WORLDMAP::CachedVertices(numVerts);
                return TRUE;
              }
            }
          }
        }
        i++;
      }
      projected = NOTSET;
      return FALSE;
    }
    else if (view.vA < 180) // 2nd quarter
    {                                         // When 90 < vA < 180
      RSINT32 i = 0;
      while (i<5)
      {
        RFLOAT32 x = data[i].x; RFLOAT32 y = data[i].y;// + c*data[1].z;
        RFLOAT32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py >= A1'(Px)
        if (y >= yTest)
        {
          yTest = vp[0].y+(x-vp[0].x)*pp;         // Py >= A1"(Px)
          if (y >= yTest)
          {
            yTest = vp[2].y+(x-vp[2].x)*pl;       // Py <= A2'(Px)
            if (y <= yTest)
            {
              yTest = vp[2].y+(x-vp[2].x)*pp;     // Py <= A2"(Px)
              if (y <= yTest)
              {
                flags |= VIS;
                #ifdef CLIPSTATS
                if (i)
                  cornerClips++;
                else
                  centreClips++;
                #endif
                projected = WORLDMAP::CachedVertices(numVerts);
                return TRUE;
              }
            }
          }
        }
        i++;
      }
      projected = NOTSET;
      return FALSE;
    }
    else if (view.vA < 270) // 3rd quarter
    {
      RSINT32 i = 0;
      while (i<5)
      {
        RFLOAT32 x = data[i].x; RFLOAT32 y = data[i].y;// + c*data[1].z;
        RFLOAT32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py >= A1'(Px)
        if (y >= yTest)
        {
          yTest = vp[0].y+(x-vp[0].x)*pp;         // Py <= A1"(Px)
          if (y <= yTest)
          {
            yTest = vp[2].y+(x-vp[2].x)*pl;       // Py <= A2'(Px)
            if (y <= yTest)
            {
              yTest = vp[2].y+(x-vp[2].x)*pp;     // Py >= A2"(Px)
              if (y >= yTest)
              {
                flags |= VIS;
                #ifdef CLIPSTATS
                if (i)
                  cornerClips++;
                else
                  centreClips++;
                #endif
                projected = WORLDMAP::CachedVertices(numVerts);
                return TRUE;
              }
            }
          }
        }
        i++;
      }
      projected = NOTSET;
      return FALSE;
    }
    else if (view.vA < 360) // 4th quarter
    {
      RSINT32 i = 0;
      while (i<5)
      {
        RFLOAT32 x = data[i].x; RFLOAT32 y = data[i].y;// + c*data[1].z;
        RFLOAT32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py <= A1'(Px)
        if (y <= yTest)
        {
          yTest = vp[0].y+(x-vp[0].x)*pp;         // Py <= A1"(Px)
          if (y <= yTest)
          {
            yTest = vp[2].y+(x-vp[2].x)*pl;       // Py >= A2'(Px)
            if (y >= yTest)
            {
              yTest = vp[2].y+(x-vp[2].x)*pp;     // Py >= A2"(Px)
              if (y >= yTest)
              {
                flags |= VIS;
                #ifdef CLIPSTATS
                if (i)
                  cornerClips++;
                else
                  centreClips++;
                #endif
                projected = WORLDMAP::CachedVertices(numVerts);
                return TRUE;
              }
            }
          }
        }
        i++;
      }
      projected = NOTSET;
      return FALSE;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MAPCELL::Display(VIEW& view)
{
  register sysVERTEX* vt = Vertices(4);
  {
    RFLOAT32 scaleF = view.width/WORLDMAP::Scale();
    RFLOAT32 offset = (view.height-view.width)/2F;
    vt[0].x=scaleF*data[1].x;   vt[0].y=scaleF*(WORLDMAP::Scale()-data[1].y)+offset;    vt[0].z=0;
    vt[1].x=scaleF*data[2].x;   vt[1].y=scaleF*(WORLDMAP::Scale()-data[2].y)+offset;    vt[1].z=0;
    vt[2].x=scaleF*data[3].x;   vt[2].y=scaleF*(WORLDMAP::Scale()-data[3].y)+offset;    vt[2].z=0;
    vt[3].x=scaleF*data[4].x;   vt[3].y=scaleF*(WORLDMAP::Scale()-data[4].y)+offset;    vt[3].z=0;
  }
  {
    RUINT32 c = (data[0].c & 0x00FFFFFF)|0xA0000000;
    SetColour(c);
    TriStrip(vt,4);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MAPCELL::Render(VIEW& view)
{
  if (!projected)
  {
    cout << "Error : MAPCELL::Render() no points allocated\n";
    return;
  }
  // Only recalculate if view has changed
  if (view.State(VIEW::CHANGED))
  {
    WorldToView(view, data+1, projected, points);
    {
      C3D d[4] = {
        C3D(data[1].x, data[1].y, WORLDMAP::SeaLevel(), 0,  0,  0xFFFFFFFF),
        C3D(data[2].x, data[2].y, WORLDMAP::SeaLevel(), 0,  96, 0xFFFFFFFF),
        C3D(data[3].x, data[3].y, WORLDMAP::SeaLevel(), 96, 0,  0xFFFFFFFF),
        C3D(data[4].x, data[4].y, WORLDMAP::SeaLevel(), 96, 96, 0xFFFFFFFF)
      };
      WorldToView(view, d, (projected+(2*points)), 4);
    }
  }
/*
  else if (flags & RETEX)
  {
    sysVERTEX* d = projected; C3D* s = data+1;
    flags &= ~RETEX;
    d->u = s->u;    (d++)->v = (s++)->v;
    d->u = s->u;    (d++)->v = (s++)->v;
    d->u = s->u;    (d++)->v = (s++)->v;
    d->u = s->u;    (d++)->v = (s++)->v;
  }
*/
  TriStripTx(projected, points, tex);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MAPCELL::WaterSurf()
{
  TriStripTx((projected+(2*points)), 4, WORLDMAP::WaterTex());
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MAPCELL::Detail()
{
  {
    // Quickly copy the transformed vertex data for the detail view since this is actually
    // faster than flushing the drawing queue and reusing the same verticies over. This
    // will probably cease to be true once we start using meshed MAPCELLS, so the reuse code
    // remains commented for later use
    UINT32* src = (UINT32*)projected;
    UINT32* dst = (UINT32*)(projected+points);
    SINT32 n = 1+points*(sizeof(sysVERTEX)/sizeof(UINT32));
    while (--n)
      *(dst++) = *(src++);
  }

  RFLOAT32 a = 1.66F*(WORLDMAP::LOD()-0.4F);
  sysVERTEX* t = projected+points;
  {
    t[0].u = 0;         t[0].v = 0;         t[0].color.a = a;
    t[1].u = 0;         t[1].v = data[0].v; t[1].color.a = a;
    t[2].u = data[0].u; t[2].v = 0;         t[2].color.a = a;
    t[3].u = data[0].u; t[3].v = data[0].v; t[3].color.a = a;
  }
  //  flags |= RETEX;
  TriStripTx(projected+points, points, detail);
}