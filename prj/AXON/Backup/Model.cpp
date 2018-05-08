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
    Absolutely loads...
      Formal model specification, file format etc
      Model frames
      Collision detection
      etc..
*/

#include "axon.hpp"

// A tumbling RGB colourspace cube....Beware, its out to get you :)

void RGBCUBE::Place(VEC3D& org, FLOAT32 s, SINT16 x, SINT16 y, SINT16 z)
{
  o = org;

  // orientation ignored
  pt[10].x = pt[0].x = o.x - s;
  pt[10].y = pt[0].y = o.y - s;
  pt[10].z = pt[0].z = o.z - s;
  pt[10].c = pt[0].c = 0xFF000000;

  pt[12].x = pt[1].x = o.x + s;
  pt[12].y = pt[1].y = o.y - s;
  pt[12].z = pt[1].z = o.z - s;
  pt[12].c = pt[1].c = 0x7F0000FF;

  pt[8].x = pt[2].x = o.x - s;
  pt[8].y = pt[2].y = o.y - s;
  pt[8].z = pt[2].z = o.z + s;
  pt[8].c = pt[2].c = 0x7F00FF00;

  pt[14].x = pt[3].x = o.x + s;
  pt[14].y = pt[3].y = o.y - s;
  pt[14].z = pt[3].z = o.z + s;
  pt[14].c = pt[3].c = 0x7F00FFFF;

  pt[9].x = pt[4].x = o.x - s;
  pt[9].y = pt[4].y = o.y + s;
  pt[9].z = pt[4].z = o.z + s;
  pt[9].c = pt[4].c = 0x7FFFFF00;

  pt[15].x = pt[5].x = o.x + s;
  pt[15].y = pt[5].y = o.y + s;
  pt[15].z = pt[5].z = o.z + s;
  pt[15].c = pt[5].c = 0x7FFFFFFF;

  pt[11].x = pt[6].x = o.x - s;
  pt[11].y = pt[6].y = o.y + s;
  pt[11].z = pt[6].z = o.z - s;
  pt[11].c = pt[6].c = 0x7FFF0000;

  pt[13].x = pt[7].x = o.x + s;
  pt[13].y = pt[7].y = o.y + s;
  pt[13].z = pt[7].z = o.z - s;
  pt[13].c = pt[7].c = 0x7FFF00FF;
}

void RGBCUBE::Render(VIEW& view)
{
  // rotates every frame so no point cacheing projected vertices
  RotSXYZ(&o, pt, 16, 1,2,3);
  register sysVERTEX* v = Vertices(16);
  WorldToView(view, pt, v, 16);
  Disable(TEXTURE);
  TriStrip(v, 8);
  TriStrip(v+8,8);
  Enable(TEXTURE);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define TAN60 1.73205081
#define TAN30 0.57735026
SINT32    PINETREE::count = 0;
xTEXTURE  PINETREE::texture;
C3D   PINETREE::points[30] = {
  // 3 sided trifan cone for trunk
  //     x              y             z     u     v   c
  C3D( 0,             0,            1,    0,    0,  0xFF201000 ),
  C3D( 0,             -0.028877,    0,    0,    0,  0xFF201004 ),
  C3D( 0.025,         0.025*TAN30,  0,    0,    0,  0xFF201004 ),
  C3D( -0.025,        0.025*TAN30,  0,    0,    0,  0xFF201004 ),
  C3D( 0,             -0.028877,    0,    0,    0,  0xFF201004 ),

  // 6 sided trifan cone for bottom tier
  C3D( 0,             0,            0.45, 0,            0,      0xFF000000 ),
  C3D( 0,             -0.3,         0.20, 0,            -0.5,   0xFFFFFFFF ),
  C3D( 0.15*TAN60,    -0.15,        0.21, 0.25*TAN60,   -0.25,  0xFFFFFFFF ),
  C3D( 0.15*TAN60,    0.15,         0.24, 0.25*TAN60,   0.25,   0xFFFFFFFF ),
  C3D( 0,             0.3,          0.20, 0,            0.5,    0xFFFFFFFF ),
  C3D( -0.15*TAN60,   0.15,         0.24, -0.25*TAN60,  0.25,   0xFFFFFFFF ),
  C3D( -0.15*TAN60,   -0.15,        0.20, -0.25*TAN60,  -0.25,  0xFFFFFFFF ),
  C3D( 0,             -0.3,         0.24, 0,            -0.5,   0xFFFFFFFF ),

  // 6 sided trifan con for second tier
  C3D( 0,             0,            0.7,  0,            0,            0xFF000000 ),
  C3D( 0.125,         -0.125*TAN60, 0.36, 0.25,         -0.25*TAN60,  0xFFFFFFFF ),
  C3D( 0.25,          0,            0.33, 0.5,          0,            0xFFFFFFFF ),
  C3D( 0.125,         0.125*TAN60,  0.36, 0.25,         0.25*TAN60,   0xFFFFFFFF ),
  C3D( -0.125,        0.125*TAN60,  0.33, -0.25,        0.25*TAN60,   0xFFFFFFFF ),
  C3D( -0.25,         0,            0.36, -0.5,         0,            0xFFFFFFFF ),
  C3D( -0.125,        -0.125*TAN60, 0.33, -0.25,        -0.25*TAN60,  0xFFFFFFFF ),
  C3D( 0.125,         -0.125*TAN60, 0.36, 0.15,         -0.25*TAN60,  0xFFFFFFFF ),

  // 6 sided trifan cone for top tier
  C3D( 0,             0,            1.0,  0,            0,            0xFF808080 ),
  C3D( 0,             -0.165,       0.54, 0,            -0.5,         0xFFFFFFFF ),
  C3D( 0.0825*TAN60,  -0.0825,      0.57, 0.25*TAN60,   -0.25,        0xFFFFFFFF ),
  C3D( 0.0825*TAN60,  0.0825,       0.54, 0.25*TAN60,   0.25,         0xFFFFFFFF ),
  C3D( 0,             0.165,        0.57, 0,            0.5,          0xFFFFFFFF ),
  C3D( -0.0825*TAN60, 0.0825,       0.54, -0.25*TAN60,  0.25,         0xFFFFFFFF ),
  C3D( -0.0825*TAN60, -0.0825,      0.57, -0.25*TAN60,  -0.25,        0xFFFFFFFF ),
  C3D( 0,           - 0.165,        0.54, 0,            -0.5,         0xFFFFFFFF ),

  // pad
  C3D( 0,           0,            0,    0,    0,  0x00000000 )
};
#undef TAN60
#undef TAN30

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

PINETREE::PINETREE()
{
  if (++count==1)
  {
    if (texture.Load("data/branches.tex")==OK)
    {
      texture.SetEnv(xTEXTURE::MODULATE);
      texture.SetFilter(xTEXTURE::LINEAR);
    }
    else
      cout << "PINETREE:: Error loading texturemap\n";
  }
  tex = TexHandle(&texture);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PINETREE::Place(VEC3D& org, FLOAT32 s, SINT16 x, SINT16 y, SINT16 z)
{
  o = org;
  // copy the points from the static memory, rotating as we go. This object
  // is always vertical, so only z axis rotaion makes sense
  RotSDZ(points, pt, 29, z);
  // scale size, texture coords and add position
  FLOAT32 w = texture.Width();
  FLOAT32 h = texture.Height();
  for (SINT32 i=0; i < 30; i++)
  {
    pt[i].x = o.x + pt[i].x*s;
    pt[i].y = o.y + pt[i].y*s;
    pt[i].z = o.z + pt[i].z*s;
    pt[i].u = (pt[i].u+0.5F)*w;
    pt[i].v = (pt[i].v+0.5F)*h;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PINETREE::Render(VIEW& view)
{
  if (WORLDMAP::LOD() < 0.1F)
    return;
  if (view.State(VIEW::CHANGED))
  {
    pj = WORLDMAP::CachedVertices(30);
    WorldToView(view, pt, pj, 30);
    RFLOAT32 a = ClipFloat((10F*(WORLDMAP::LOD()-0.1F)), 0F, 0.99F);
    pj[0].color.a = 0.1F + 0.9F*a;
    pj[5].color.a = a;
    pj[13].color.a = a;
    pj[21].color.a = a;
  }
  Enable(ALPHA_BLEND);
  Disable(TEXTURE);
  TriFan(pj, 5);          // trunk
  Enable(TEXTURE);
  TriFanTx(pj+5, 8, tex); // tier 1
  TriFanTx(pj+13, 8, tex);  // tier 2
  TriFanTx(pj+21, 8, tex);  // tier 3
  Disable(ALPHA_BLEND);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

PINETREE::~PINETREE()
{
  if (--count==0)
    texture.Delete();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SINT32    BUILDING::count = 0;
xTEXTURE  BUILDING::texture;
C3D       BUILDING::points[6] = {
  C3D( 0,     0,    0.75, 0,  0,  0xFFA0A090 ),
  C3D( -0.5,  -0.5, 0,    0,  0,  0xFF202040 ),
  C3D( 0.5,   -0.5, 0,    0,  0,  0xFF202048 ),
  C3D( 0.5,   0.5,  0,    0,  0,  0xFF908088 ),
  C3D( -0.5,  0.5,  0,    0,  0,  0xFF908088 ),
  C3D( -0.5,  -0.5, 0,    0,  0,  0xFF202040 )
};

BUILDING::BUILDING()
{
/*
  if (++count==1)
  {
    if (texture.Load("data/branches.tex")==OK)
    {
      texture.SetEnv(xTEXTURE::MODULATE);
      texture.SetFilter(xTEXTURE::LINEAR);
    }
    else
      cout << "PINETREE:: Error loading texturemap\n";
  }
  tex = TexHandle(&texture);
*/
}

void BUILDING::Place(VEC3D& org, FLOAT32 s, SINT16 x, SINT16 y, SINT16 z)
{
  o = org;

  // copy the points from the static memory, rotating as we go. This object
  // is always vertical, so only z axis rotaion makes sense
  RotSDZ(points, pt, 6, z);
  // scale size, texture coords and add position
//  FLOAT32 w = texture.Width();
//  FLOAT32 h = texture.Height();
  for (SINT32 i=0; i < 6; i++)
  {
    pt[i].x = o.x + pt[i].x*s;
    pt[i].y = o.y + pt[i].y*s;
    pt[i].z = o.z + pt[i].z*s;
//    pt[i].u = (pt[i].u+0.5F)*w;
//    pt[i].v = (pt[i].v+0.5F)*h;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void BUILDING::Render(VIEW& view)
{
  if (view.State(VIEW::CHANGED))
  {
    pj = WORLDMAP::CachedVertices(6);
    WorldToView(view, pt, pj, 6);
  }
  Disable(ALPHA_BLEND);
  Disable(TEXTURE);
  TriFan(pj, 6);
  Enable(TEXTURE);
  Disable(ALPHA_BLEND);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

BUILDING::~BUILDING()
{
/*
  if (--count==0)
    texture.Delete();
*/
}
