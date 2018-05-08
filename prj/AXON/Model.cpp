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

void RGBCUBE::Place(const VEC3D& org, float32 s, sint16 x, sint16 y, sint16 z)
{
  origin = org;

  // orientation ignored
  pt[10].x = pt[0].x = origin.x - s;
  pt[10].y = pt[0].y = origin.y - s;
  pt[10].z = pt[0].z = origin.z - s;
  pt[10].c = pt[0].c = 0xFF000000;

  pt[12].x = pt[1].x = origin.x + s;
  pt[12].y = pt[1].y = origin.y - s;
  pt[12].z = pt[1].z = origin.z - s;
  pt[12].c = pt[1].c = 0x7F0000FF;

  pt[8].x = pt[2].x = origin.x - s;
  pt[8].y = pt[2].y = origin.y - s;
  pt[8].z = pt[2].z = origin.z + s;
  pt[8].c = pt[2].c = 0x7F00FF00;

  pt[14].x = pt[3].x = origin.x + s;
  pt[14].y = pt[3].y = origin.y - s;
  pt[14].z = pt[3].z = origin.z + s;
  pt[14].c = pt[3].c = 0x7F00FFFF;

  pt[9].x = pt[4].x = origin.x - s;
  pt[9].y = pt[4].y = origin.y + s;
  pt[9].z = pt[4].z = origin.z + s;
  pt[9].c = pt[4].c = 0x7FFFFF00;

  pt[15].x = pt[5].x = origin.x + s;
  pt[15].y = pt[5].y = origin.y + s;
  pt[15].z = pt[5].z = origin.z + s;
  pt[15].c = pt[5].c = 0x7FFFFFFF;

  pt[11].x = pt[6].x = origin.x - s;
  pt[11].y = pt[6].y = origin.y + s;
  pt[11].z = pt[6].z = origin.z - s;
  pt[11].c = pt[6].c = 0x7FFF0000;

  pt[13].x = pt[7].x = origin.x + s;
  pt[13].y = pt[7].y = origin.y + s;
  pt[13].z = pt[7].z = origin.z - s;
  pt[13].c = pt[7].c = 0x7FFF00FF;
}

void RGBCUBE::Render(VIEW& view)
{
  register sysVERTEX* v = Vertices(16);
  view.Transform(pt, v ,16);
  Disable(TEXTURE);
  TriStrip(v, 8);
  TriStrip(v+8,8);
  Enable(TEXTURE);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define TAN60 1.73205081
#define TAN30 0.57735026
sint32    PINETREE::count = 0;
xTEXTURE* PINETREE::texture;

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
    texture = TEXTUREHEAP::UseTex("data/branches.tex");
    if (texture)
    {
      texture->SetEnv(xTEXTURE::MODULATE);
      texture->SetFilter(xTEXTURE::LINEAR);
    }
    else
      puts("PINETREE:: Error loading texturemap");
    // Set the texture coords
    {
      float32 w = texture->Width();
      float32 h = texture->Height();
      for (sint32 i=0; i < 30; i++)
      {
        points[i].u = (points[i].u+0.5F)*w;
        points[i].v = (points[i].v+0.5F)*h;
      }
    }
  }
  tex = texture->TexHandle();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PINETREE::Place(const VEC3D& org, float32 s, sint16 x, sint16 y, sint16 z)
{
  origin = org;
  angles = VEC3D(x,y,z);
  scale  = VEC3D(s,s,s);
  transform.Scale(scale);
  transform.Rotate(angles);
  transform.Translate(origin);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PINETREE::Render(VIEW& view)
{
  if (WORLDMAP::LOD() < 0.1F)
    return;
  if (view.State(VIEW::CHANGED))
  {
    pj = CachedVertices(30);

    view*=transform;
    view.Transform(points, pj, 30);
    rfloat32 a = ClipFloat((10F*(WORLDMAP::LOD()-0.1F)), 0F, 0.99F);
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
    texture->Delete();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32    BUILDING::count = 0;
xTEXTURE* BUILDING::texture;

BUILDING::BUILDING()
{
  if (++count==1)
  {
    texture = TEXTUREHEAP::UsePPM("data/stony.ppm");
    if (texture)
    {
      texture->SetEnv(xTEXTURE::MODULATE);
      texture->SetFilter(xTEXTURE::LINEAR);
    }
    else
      puts("BUILDING:: Error loading texturemap");
    // Set the texture coords
    {
      float32 w = texture->Width();
      float32 h = texture->Height();
      for (sint32 i=0; i < 30; i++)
      {
        points[i].u *= 2*w;
        points[i].v *= 2*h;
      }
    }
  }
  tex = texture->TexHandle();
}

C3D       BUILDING::points[20] = {

  // wall 1
  C3D(-0.25,    -0.25,    2.0,    0.5,    0.0,    0xFFFFFFFF),
  C3D(-0.5,     -0.5,     0.0,    0.0,    4.0,    0xFFAFAFAF),
  C3D(0.25,     -0.25,    2.0,    1.5,    0.0,    0xFFFFFFFF),
  C3D(0.5,      -0.5,     0.0,    2.0,    4.0,    0xFFAFAFAF),

  // wall 2
  C3D(0.25,     -0.25,    2.0,    0.5,    0.0,    0xFF7F7F7F),
  C3D(0.5,      -0.5,     0.0,    0.0,    4.0,    0xFF5F5F5F),
  C3D(0.25,     0.25,     2.0,    1.5,    0.0,    0xFF7F7F7F),
  C3D(0.5,      0.5,      0.0,    2.0,    4.0,    0xFF5F5F5F),

  // wall 3
  C3D(0.25,     0.25,     2.0,    0.5,    0.0,    0xFF3F3F3F),
  C3D(0.5,      0.5,      0.0,    0.0,    4.0,    0xFF1F1F1F),
  C3D(-0.25,    0.25,     2.0,    1.5,    0.0,    0xFF3F3F3F),
  C3D(-0.5,     0.5,      0.0,    2.0,    4.0,    0xFF1F1F1F),

  // wall 4
  C3D(-0.25,    0.25,     2.0,    0.5,    0.0,    0xFF7F7F7F),
  C3D(-0.5,     0.5,      0.0,    0.0,    4.0,    0xFF5F5F5F),
  C3D(-0.25,    -0.25,    2.0,    1.5,    0.0,    0xFF7F7F7F),
  C3D(-0.5,     -0.5,     0.0,    2.0,    4.0,    0xFF5F5F5F),

  // roof
  C3D(-0.25,    0.25,     2.0,    0.5,    0.5,    0xFFFFFFFF),
  C3D(-0.25,    -0.25,    2.0,    0.5,    1.5,    0xFFFFFFFF),
  C3D(0.25,     0.25,     2.0,    1.5,    0.5,    0xFFFFFFFF),
  C3D(0.25,     -0.25,    2.0,    1.5,    1.5,    0xFFFFFFFF),
};


void BUILDING::Place(const VEC3D& org, float32 s, sint16 x, sint16 y, sint16 z)
{
  origin  = org+VEC3D(0,0,-0.15);
  angles  = VEC3D(x,y,z);
  scale   = VEC3D(s,s,s);
  transform.Scale(scale);
  transform.Rotate(angles);
  transform.Translate(origin);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void BUILDING::Render(VIEW& view)
{
  if (view.State(VIEW::CHANGED))
  {
    pj = CachedVertices(20);
    view*=transform;
    view.Transform(points, pj, 20);
  }
  Disable(ALPHA_BLEND);
  Enable(TEXTURE);
  TriStripTx(pj,    4, tex);
  TriStripTx(pj+4,  4, tex);
  TriStripTx(pj+8,  4, tex);
  TriStripTx(pj+12, 4, tex);
  TriStripTx(pj+16, 4, tex);
  Enable(ALPHA_BLEND);
  Disable(TEXTURE);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

BUILDING::~BUILDING()
{
  if (--count==0)
    texture->Delete();
}
