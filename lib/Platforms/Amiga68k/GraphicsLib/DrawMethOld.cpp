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

#include <math.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDRAW Drawing Functions
//
//  So far, all 3D rasterizer accelerated drawing operations use at least these steps
//
//  1. Coordinate to vertex converison
//  2. ARGB32 to normalised float conversion
//  3. Rendering call
//
//  Functions which need to calculate additional verticies (such as circles etc) do so after colour conversion, allowing the
//  colour data to be written simultaneously
//
//  In this, the 68K version, several hard optimizations are made to boost throughput
//
//  1. Seperate code blocks for each of the 3 main stages to enforce locality of temp variables
//  2. Judicious use and reuse of registers inside blocks
//  3. Colour conversion performed in integer code allowing FPU and IU to operate in parallel for any additional vertex
//     calculations.
//  4. Minimal use of stack variables
//  5. Minimal use of memory read/writes outside of data reading/vertex writing. Those IO operaions that are used are serialised
//     where possible to improve cache performance
//  6. Simplest possible addressing used, eg v->x generates simpler code than v[].x
//
//  Some of these optimisation tricks should also work well with PowerPC, except for 3, maybe - FP calc prob faster than LUT
//  but since the LUT is small (256 entries) hard to know without trying and timing
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Line routines
//
//   0
//    \
//     \
//      \
//       1
//
//  Notes : does not require use of the vertex buffer
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::Line(ruint32 col, RICOORD2D p1, RICOORD2D p2)
{
  // simple single line routine does not use vertex buffer, uses a line structure instead
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  W3D_Line lin = {0};
  {
    register sysVERTEX* v = &lin.v1;
    rfloat64 d = zDepth;
    VTX_X(v)=CoordX(p1);  VTX_Y(v)=CoordY(p1);  VTX_Z(v++)=d;
    VTX_X(v)=CoordX(p2);  VTX_Y(v)=CoordY(p2);  VTX_Z(v)=d;
  }
  {
    Disable(GOURAUD);
    Disable(TEXTURE);
    W3D_DrawLine(x3D::Context(), &lin);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::LineShA(ruint32* col, RICOORD2D p1, RICOORD2D p2)
{
  // simple single line routine does not use vertex buffer, uses a line structure instead
  W3D_Line lin = {0};
  register sysVERTEX* v = &lin.v1;
  {
    rfloat64 d = zDepth;
    VTX_X(v)=CoordX(p1);  VTX_Y(v)=CoordY(p1);  VTX_Z(v++)=d;
    VTX_X(v)=CoordX(p2);  VTX_Y(v)=CoordY(p2);  VTX_Z(v)=d;
  }
  {
    #define WRITECOLOUR(v) {ruint32* c = (uint32*)(v); *(c++) = r; *(c++) = g; *(c++) = b; *(c) = a;}
    p1 = *(col++);  p2 = 8;
    ruint32 b = p1; p1 >>= p2;
    ruint32 g = p1; p1 >>= p2;
    ruint32 r = p1; p1 >>= p2;
    ruint32 a = cTab[(p1)];

    p2 = 0x000000FF; r = cTab[(r&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];
    WRITECOLOUR(VTX_C(v));

    p1 = *col; p2 = 8;
    b = p1; p1 >>= p2;
    g = p1; p1 >>= p2;

    p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];
    WRITECOLOUR(VTX_C(v+1));

    #undef WRITECOLOUR
  }
  {
    Enable(GOURAUD);
    Disable(TEXTURE);
    W3D_DrawLine(x3D::Context(), &lin);
  }
}

void xDRAW::LineStrip(ruint32 col, RICOORD2D* p, ruint32 n)
{
  sysVERTEX*  v = Vertices(n);
  {
    register sysVERTEX* t = v;
    rfloat64 d = zDepth;
    rsint32 i=n+1;
    while(--i)
    {
      VTX_X(t)=CoordX(*p);
      VTX_Y(t)=CoordY(*(p++));
      VTX_Z(t++)=d;
    }
  }
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  {
    Disable(GOURAUD);
    Disable(TEXTURE);
    LineStrip(v,n);
  }
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Triangle routines
//
//      0
//      |\
//      | \
//      |  \
//      1---2
//
//  Notes : Does not require vertex buffer, a W3D_Triangle object (embedding 3 verticies) is used directly
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::Tri(ruint32 col, RICOORD2D p1, RICOORD2D p2, RICOORD2D p3)
{
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  W3D_Triangle tri = {0};
  {
    register sysVERTEX* v = &tri.v1;
    rfloat64 d = zDepth;
    VTX_X(v)=CoordX(p1);  VTX_Y(v)=CoordY(p1);  VTX_Z(v++)=d;
    VTX_X(v)=CoordX(p2);  VTX_Y(v)=CoordY(p2);  VTX_Z(v++)=d;
    VTX_X(v)=CoordX(p3);  VTX_Y(v)=CoordY(p3);  VTX_Z(v)=d;
  }
  {
    Disable(GOURAUD);
    Disable(TEXTURE);
    W3D_DrawTriangle(x3D::Context(), &tri);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::TriShA(ruint32* col, RICOORD2D p1, RICOORD2D p2, RICOORD2D p3)
{
  W3D_Triangle tri = {0};
  register sysVERTEX* v = &tri.v1;
  {
    rfloat64 d = zDepth;
    VTX_X(v)=CoordX(p1);  VTX_Y(v)=CoordY(p1);  VTX_Z(v++)=d;
    VTX_X(v)=CoordX(p2);  VTX_Y(v)=CoordY(p2);  VTX_Z(v++)=d;
    VTX_X(v)=CoordX(p3);  VTX_Y(v)=CoordY(p3);  VTX_Z(v)=d;
  }
  {
    #define WRITECOLOUR(v) {ruint32* c = (uint32*)(v); *(c++) = r; *(c++) = g; *(c++) = b; *(c) = p3};
    // Re use the uint32 registers that were used by p1 / p2 / p3
    // p1 = 32bpp ARGB colour
    // p2 = masking temp
    // p3 = alpha component

    p1 = *(col++);  p2 = 8;
    ruint32 b = p1; p1 >>= p2; // only use this alpha for v[0]-v[3]
    ruint32 g = p1; p1 >>= p2;
    ruint32 r = p1; p1 >>= p2;
    p3 = cTab[(p1)];
    p2 = 0x000000FF; r = cTab[(r&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];
    WRITECOLOUR(VTX_C(v));

    p1 = *(col++); p2 = 8;
    b = p1; p1 >>= p2;
    g = p1; p1 >>= p2;
    p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];
    WRITECOLOUR(VTX_C(v+1));

    p1 = *(col++); p2 = 8;
    b = p1; p1 >>= p2;
    g = p1; p1 >>= p2;
    p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];
    WRITECOLOUR(VTX_C(v+2));

    #undef WRITECOLOUR
  }
  {
    Enable(GOURAUD);
    Disable(TEXTURE);
    W3D_DrawTriangle(x3D::Context(), &tri);
  }
}




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Rectangle routines
//
//  Draw a rectangular strip of two triangles with edge 1/2 shared (cf OpenGL vertex strip definition)
//
//    0-----2
//    |    /|
//    |   / |
//    |  /  |
//    | /   |
//    |/    |
//    1-----3
//
//  Notes : uses vertex stack to hold v[0]-v[3]. By convension, p1 should be top left and p2 bottom right. However, this is not
//  mandatory, but incerting the order will result in 'opposite sense' shading.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



#define WRITECOLOUR(v) {ruint32* c = (uint32*)(v); *(c++) = r; *(c++) = g; *(c++) = b; *(c) = a;}

void xDRAW::Rect(ruint32 col, RICOORD2D p1, RICOORD2D p2)
{
  if ((vBufPos+4) >= vArraySize) Flush();
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v++)=d;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v++)=d;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v++)=d;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d;
    vBufPos += 4;
    v-=3;
  }
  {
    Disable(GOURAUD);
    Disable(TEXTURE);
    TriStrip(v,4);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectScTx(ruint32 col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx)
{
  if ((vBufPos+4) >= vArraySize) Flush();
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1;  VTX_V(v++) = tx.y1;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x2;  VTX_V(v++) = tx.y1;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1;  VTX_V(v++) = tx.y2;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x2;  VTX_V(v) = tx.y2;
    vBufPos += 4;
    v-=3;
  }
  {
    Disable(GOURAUD);
    Enable(TEXTURE);
    TriStripTx(v, 4, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectTlTx(ruint32 col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx)
{
  if ((vBufPos+4) >= vArraySize) Flush();
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1;           VTX_V(v++) = tx.y1;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1 + x2 - x1; VTX_V(v++) = tx.y1;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1;           VTX_V(v++) = tx.y1 + y2 - y1;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1 + x2 - x1; VTX_V(v) = tx.y1 + y2 - y1;
    vBufPos += 4;
    v-=3;
  }
  {
    Disable(GOURAUD);
    Enable(TEXTURE);
    TriStripTx(v, 4, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Macro Insert for vertical gradient fill generation
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define GENGRADIENT                                                         \
  p1 = *(col++);  p2 = 8;                                                   \
  ruint32 b = p1; p1 >>= p2;                                                \
  ruint32 g = p1; p1 >>= p2;                                                \
  ruint32 r = p1; p1 >>= p2;                                                \
  ruint32 a = cTab[(p1)];                                                   \
  p2 = 0x000000FF; r = cTab[(r&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];    \
  WRITECOLOUR(VTX_C(v));                                                    \
  WRITECOLOUR(VTX_C(v+1));                                                  \
  p1 = *col; p2 = 8;                                                        \
  b = p1; p1 >>= p2;                                                        \
  g = p1; p1 >>= p2;                                                        \
  p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];   \
  WRITECOLOUR(VTX_C(v+2));                                                  \
  WRITECOLOUR(VTX_C(v+3));                                                  \

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectShV(ruint32* col, RICOORD2D p1, RICOORD2D p2)
{ // draws a vertically shaded rectangle
  // *c points to array of four ARGB32 values
  if ((vBufPos+4) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d  = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v++)=d;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v++)=d;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v++)=d;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d;
    vBufPos += 4;
    v-=3;
  }
  {
    GENGRADIENT
  }
  {
    Enable(GOURAUD);
    Disable(TEXTURE);
    TriStrip(v, 4);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectScTxShV(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx)
{ // draws a vertically shaded rectangle
  // *c points to array of four ARGB32 values
  if ((vBufPos+4) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d  = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1;  VTX_V(v++) = tx.y1;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x2;  VTX_V(v++) = tx.y1;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1;  VTX_V(v++) = tx.y2;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x2;  VTX_V(v) = tx.y2;
    vBufPos += 4;
    v-=3;
  }
  {
    GENGRADIENT
  }
  {
    Enable(GOURAUD);
    Enable(TEXTURE);
    TriStripTx(v, 4, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectTlTxShV(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx)
{
  if ((vBufPos+4) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d  = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1;           VTX_V(v++) = tx.y1;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1 + x2 - x1; VTX_V(v++) = tx.y1;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1;           VTX_V(v++) = tx.y1 + y2 - y1;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1 + x2 - x1; VTX_V(v) = tx.y1 + y2 - y1;
    vBufPos += 4;
    v-=3;
  }
  {
    GENGRADIENT
  }
  {
    Enable(GOURAUD);
    Enable(TEXTURE);
    TriStripTx(v, 4, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Macro Insert for horizontal gradient fill generation
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#undef GENGRADIENT

#define GENGRADIENT                                                         \
  p1 = *(col++);  p2 = 8;                                                   \
  ruint32 b = p1; p1 >>= p2;                                                \
  ruint32 g = p1; p1 >>= p2;                                                \
  ruint32 r = p1; p1 >>= p2;                                                \
  ruint32 a = cTab[(p1)];                                                   \
  p2 = 0x000000FF; r = cTab[(r&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];    \
  WRITECOLOUR(VTX_C(v));                                                    \
  WRITECOLOUR(VTX_C(v+2));                                                  \
  p1 = *col; p2 = 8;                                                        \
  b = p1; p1 >>= p2;                                                        \
  g = p1; p1 >>= p2;                                                        \
  p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];   \
  WRITECOLOUR(VTX_C(v+1));                                                  \
  WRITECOLOUR(VTX_C(v+3));                                                  \

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectShH(ruint32* col, RICOORD2D p1, RICOORD2D p2)
{ // draws a horizontally shaded rectangle
  // *c points to array of two ARGB32 values
  if ((vBufPos+4) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d  = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v++)=d;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v++)=d;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v++)=d;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d;
    vBufPos += 4;
    v-=3;
  }
  {
    GENGRADIENT
  }
  {
    Enable(GOURAUD);
    Disable(TEXTURE);
    TriStrip(v, 4);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectScTxShH(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx)
{ // draws a horizontally shaded rectangle
  // *c points to array of two ARGB32 values
  if ((vBufPos+4) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d  = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1;  VTX_V(v++) = tx.y1;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x2;  VTX_V(v++) = tx.y1;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1;  VTX_V(v++) = tx.y2;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x2;  VTX_V(v) = tx.y2;
    vBufPos += 4;
    v-=3;
  }
  {
    GENGRADIENT
  }
  {
    Enable(GOURAUD);
    Enable(TEXTURE);
    TriStripTx(v, 4, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectTlTxShH(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx)
{
  if ((vBufPos+4) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d  = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1;           VTX_V(v++) = tx.y1;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1 + x2 - x1; VTX_V(v++) = tx.y1;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1;           VTX_V(v++) = tx.y1 + y2 - y1;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1 + x2 - x1; VTX_V(v) = tx.y1 + y2 - y1;
    vBufPos += 4;
    v-=3;
  }
  {
    GENGRADIENT
  }
  {
    Enable(GOURAUD);
    Enable(TEXTURE);
    TriStripTx(v, 4, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Macro Insert for any gradient fill generation
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#undef GENGRADIENT

#define GENGRADIENT                                                       \
  p1 = *(col++);  p2 = 8;                                                 \
  ruint32 b = p1; p1 >>= p2;                                              \
  ruint32 g = p1; p1 >>= p2;                                              \
  ruint32 r = p1; p1 >>= p2;                                              \
  ruint32 a = cTab[(p1)];                                                 \
  p2 = 0x000000FF; r = cTab[(r&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];  \
  WRITECOLOUR(VTX_C(v));                                                  \
  p1 = *(col++); p2 = 8;                                                  \
  b = p1; p1 >>= p2;                                                      \
  g = p1; p1 >>= p2;                                                      \
  p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)]; \
  WRITECOLOUR(VTX_C(v+1));                                                \
  p1 = *(col++); p2 = 8;                                                  \
  b = p1; p1 >>= p2;                                                      \
  g = p1; p1 >>= p2;                                                      \
  p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)]; \
  WRITECOLOUR(VTX_C(v+2));                                                \
  p1 = *(col++); p2 = 8;                                                  \
  b = p1; p1 >>= p2;                                                      \
  g = p1; p1 >>= p2;                                                      \
  p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)]; \
  WRITECOLOUR(VTX_C(v+3));                                                \

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectShA(ruint32* col, RICOORD2D p1, RICOORD2D p2)
{
  if ((vBufPos+4) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d  = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v++)=d;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v++)=d;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v++)=d;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d;
    vBufPos += 4;
    v-=3;
  }
  {
    GENGRADIENT
  }
  {
    Enable(GOURAUD);
    Disable(TEXTURE);
    TriStrip(v, 4);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectScTxShA(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx)
{
  if ((vBufPos+4) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d  = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1;  VTX_V(v++) = tx.y1;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x2;  VTX_V(v++) = tx.y1;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1;  VTX_V(v++) = tx.y2;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x2;  VTX_V(v) = tx.y2;
    vBufPos += 4;
    v-=3;
  }
  {
    GENGRADIENT
  }
  {
    Enable(GOURAUD);
    Enable(TEXTURE);
    TriStripTx(v, 4, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::RectTlTxShA(ruint32* col, RICOORD2D p1, RICOORD2D p2, register xTEXTURE& tx)
{
  if ((vBufPos+4) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d  = zDepth;
    rfloat32 x1 = CoordX(p1); rfloat32 x2 = CoordX(p2);
    rfloat32 y1 = CoordY(p1); rfloat32 y2 = CoordY(p2);
    VTX_X(v)=x1;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1;           VTX_V(v++) = tx.y1;
    VTX_X(v)=x2;  VTX_Y(v)=y1;  VTX_Z(v)=d; VTX_U(v) = tx.x1 + x2 - x1; VTX_V(v++) = tx.y1;
    VTX_X(v)=x1;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1;           VTX_V(v++) = tx.y1 + y2 - y1;
    VTX_X(v)=x2;  VTX_Y(v)=y2;  VTX_Z(v)=d; VTX_U(v) = tx.x1 + x2 - x1; VTX_V(v) = tx.y1 + y2 - y1;
    vBufPos += 4;
    v-=3;
  }
  {
    GENGRADIENT
  }
  {
    Enable(GOURAUD);
    Enable(TEXTURE);
    TriStripTx(v, 4, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#undef GENGRADIENT

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Quadratic routines
//
//  Circles and elipses are realized as triangle fans, in which the first and last edge vertex overlap. The coordinate calcs are
//  done in floating point and make use of sine/cosine symmetry to reduce overhead. The sine data is stored in a mini LUT, which
//  contains 18 points from 0 - 17*PI/32 inclusive. The 18th point is present for calculations that use sin(n) and sin(n+1) over
//  this range.
//
//  Notes : All quadratic functions Use the vertex buffer
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Macro insert for circle vertex generation
//
//  Basically, only one quarter of the circle vertices are evaluated. The rest are all equivalent thanks to simple symmetry.
//  Those vertices at 90 degree sections are not calculated in the loop, since we just add the radius to the appropriate ordinate.
//  These macros are to reduce source length only, and so use variable names present in the functions in which they are used.
//  As a result, these macros cannot be considered general purpose.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define GENCIRCLEVERTICIES                                          \
  {                                                                 \
    rad = XDRAW_TRIGSIZE;                                           \
    register sysVERTEX* v2 = v+1;                                   \
    VTX_X(v2) = x; VTX_Y(v2) = y - rfx; VTX_Z(v2) = d; v2 += rad;   \
    VTX_X(v2) = x + rfx; VTX_Y(v2) = y; VTX_Z(v2) = d; v2 += rad;   \
    VTX_X(v2) = x; VTX_Y(v2) = y + rfx; VTX_Z(v2) = d; v2 += rad;   \
    VTX_X(v2) = x - rfx; VTX_Y(v2) = y; VTX_Z(v2) = d; v2 += rad;   \
    VTX_X(v2) = x; VTX_Y(v2) = y - rfx; VTX_Z(v2) = d;              \
    for (rad = 1; rad < XDRAW_TRIGSIZE; rad++)                      \
    {                                                               \
      rfloat32 sn = rfx*sTab[rad];                                  \
      rfloat32 cs = rfx*sTab[XDRAW_TRIGSIZE-rad];                   \
      v2 = v + rad+1;                                               \
      VTX_X(v2)  = x + sn; VTX_Y(v2)  = y - cs; VTX_Z(v2)  = d;     \
      v2 += XDRAW_TRIGSIZE;                                         \
      VTX_X(v2)  = x + cs; VTX_Y(v2)  = y + sn; VTX_Z(v2)  = d;     \
      v2 += XDRAW_TRIGSIZE;                                         \
      VTX_X(v2)  = x - sn; VTX_Y(v2)  = y + cs; VTX_Z(v2)  = d;     \
      v2 += XDRAW_TRIGSIZE;                                         \
      VTX_X(v2)  = x - cs; VTX_Y(v2)  = y - sn; VTX_Z(v2)  = d;     \
    }                                                               \
  }                                                                 \

#define GENCIRCLEVERTICIESCLR                                       \
  {                                                                 \
    rad = XDRAW_TRIGSIZE;                                           \
    register sysVERTEX* v2 = v+1;                                   \
    VTX_X(v2) = x; VTX_Y(v2) = y - rfx; VTX_Z(v2) = d;              \
    WRITECOLOUR(VTX_C(v2)); v2 += rad;                              \
    VTX_X(v2) = x + rfx; VTX_Y(v2) = y; VTX_Z(v2) = d;              \
    WRITECOLOUR(VTX_C(v2)); v2 += rad;                              \
    VTX_X(v2) = x; VTX_Y(v2) = y + rfx; VTX_Z(v2) = d;              \
    WRITECOLOUR(VTX_C(v2)); v2 += rad;                              \
    VTX_X(v2) = x - rfx; VTX_Y(v2) = y; VTX_Z(v2) = d;              \
    WRITECOLOUR(VTX_C(v2)); v2 += rad;                              \
    VTX_X(v2) = x; VTX_Y(v2) = y - rfx; VTX_Z(v2) = d;              \
    WRITECOLOUR(VTX_C(v2));                                         \
    for (rad = 1; rad < XDRAW_TRIGSIZE; rad++)                      \
    {                                                               \
      rfloat32 sn = rfx*sTab[rad];                                  \
      rfloat32 cs = rfx*sTab[XDRAW_TRIGSIZE-rad];                   \
      v2 = v + rad+1;                                               \
      VTX_X(v2)  = x + sn; VTX_Y(v2)  = y - cs; VTX_Z(v2)  = d;     \
      WRITECOLOUR(VTX_C(v2)); v2 += XDRAW_TRIGSIZE;                 \
      VTX_X(v2)  = x + cs; VTX_Y(v2)  = y + sn; VTX_Z(v2)  = d;     \
      WRITECOLOUR(VTX_C(v2)); v2 += XDRAW_TRIGSIZE;                 \
      VTX_X(v2)  = x - sn; VTX_Y(v2)  = y + cs; VTX_Z(v2)  = d;     \
      WRITECOLOUR(VTX_C(v2)); v2 += XDRAW_TRIGSIZE;                 \
      VTX_X(v2)  = x - cs; VTX_Y(v2)  = y - sn; VTX_Z(v2)  = d;     \
      WRITECOLOUR(VTX_C(v2));                                       \
    }                                                               \
  }                                                                 \
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::Circle(ruint32 col, RICOORD2D p1, ruint32 rad)
{
  // TO DO : Evaluate a segment count based on radius. minimum 8, max 64
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);
    rfloat32 y = CoordY(p1);
    rfloat32 rfx = rad;

    // Easy verticies

    VTX_X(v)=x; VTX_Y(v)=y; VTX_Z(v)=d; // centre

    GENCIRCLEVERTICIES

    vBufPos += (4*XDRAW_TRIGSIZE+2);
  }
  {
    Disable(GOURAUD);
    Disable(TEXTURE);
    TriFan(v, 4*XDRAW_TRIGSIZE+2);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::CircleShC(ruint32* col, RICOORD2D p1, ruint32 rad)
{
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);
    rfloat32 y = CoordY(p1);
    rfloat32 rfx = rad;

    // colours
    // we can re use the registers occupied by p1 and rad now
    // p1 stores colour
    // rad is a masking/shifting temp
    p1 = *(col++);
    rad = 8;
    ruint32 b = p1; p1 >>= rad;
    ruint32 g = p1; p1 >>= rad;
    ruint32 r = p1; p1 >>= rad;
    ruint32 a = cTab[(p1)];
    rad = 0x000000FF; r = cTab[(r&rad)]; g = cTab[(g&rad)]; b = cTab[(b&rad)];

    VTX_X(v)=x; VTX_Y(v)=y; VTX_Z(v)=d;
    WRITECOLOUR(VTX_C(v));

    p1 = *(col); rad = 8;
    b = p1; p1 >>= rad;
    g = p1; p1 >>= rad;
    rad = 0x000000FF; r = cTab[(p1&rad)]; g = cTab[(g&rad)]; b = cTab[(b&rad)];

    GENCIRCLEVERTICIESCLR

    vBufPos += (4*XDRAW_TRIGSIZE+2);
  }
  {
    Enable(GOURAUD);
    Disable(TEXTURE);
    TriFan(v, 4*XDRAW_TRIGSIZE+2);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::CircleShPt(ruint32* col, RICOORD2D p1, RICOORD2D p2, ruint32 rad)
{
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);
    rfloat32 y = CoordY(p1);
    rfloat32 rfx = rad;

    VTX_X(v)=x+CoordX(p2);  VTX_Y(v)=y+CoordY(p2);  VTX_Z(v)=d;

    // we can re use the registers occupied by p1 and p2 now
    // p1 stores colour
    // p2 is a masking/shifting temp

    p1 = *(col++);  p2 = 8;
    ruint32 b = p1; p1 >>= p2;
    ruint32 g = p1; p1 >>= p2;
    ruint32 r = p1; p1 >>= p2;
    ruint32 a = cTab[(p1)];
    p2 = 0x000000FF; r = cTab[(r&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];

    WRITECOLOUR(VTX_C(v));

    p1 = *(col); p2 = 8;
    b = p1; p1 >>= p2;
    g = p1; p1 >>= p2;
    p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];

    GENCIRCLEVERTICIESCLR

    vBufPos += (4*XDRAW_TRIGSIZE+2);
  }
  {
    Enable(GOURAUD);
    Disable(TEXTURE);
    TriFan(v, 4*XDRAW_TRIGSIZE+2);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Macro insert for elipse vertex generation. The approach used is the same as for circle rendering
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define GENELIPSEVERTICIES                                              \
  {                                                                     \
    rad = XDRAW_TRIGSIZE;                                               \
    register sysVERTEX* v2 = v+1;                                       \
    VTX_X(v2) = x; VTX_Y(v2) = y - rfy; VTX_Z(v2) = d; v2 += rad;       \
    VTX_X(v2) = x + rfx; VTX_Y(v2) = y; VTX_Z(v2) = d; v2 += rad;       \
    VTX_X(v2) = x; VTX_Y(v2) = y + rfy; VTX_Z(v2) = d; v2 += rad;       \
    VTX_X(v2) = x - rfx; VTX_Y(v2) = y; VTX_Z(v2) = d; v2 += rad;       \
    VTX_X(v2) = x; VTX_Y(v2) = y - rfy; VTX_Z(v2) = d;                  \
    for (rad = 1; rad < XDRAW_TRIGSIZE; rad++)                          \
    {                                                                   \
      rfloat32 sn = sTab[rad];                                          \
      rfloat32 cs = sTab[XDRAW_TRIGSIZE-rad];                           \
      v2 = v + rad+1;                                                   \
      VTX_X(v2)  = x + rfx*sn; VTX_Y(v2)  = y - rfy*cs; VTX_Z(v2)  = d; \
      v2 += XDRAW_TRIGSIZE;                                             \
      VTX_X(v2)  = x + rfx*cs; VTX_Y(v2)  = y + rfy*sn; VTX_Z(v2)  = d; \
      v2 += XDRAW_TRIGSIZE;                                             \
      VTX_X(v2)  = x - rfx*sn; VTX_Y(v2)  = y + rfy*cs; VTX_Z(v2)  = d; \
      v2 += XDRAW_TRIGSIZE;                                             \
      VTX_X(v2)  = x - rfx*cs; VTX_Y(v2)  = y - rfy*sn; VTX_Z(v2)  = d; \
    }                                                                   \
  }                                                                     \


#define GENELIPSEVERTICIESCLR                                           \
  {                                                                     \
    rad = XDRAW_TRIGSIZE;                                               \
    register sysVERTEX* v2 = v+1;                                       \
    VTX_X(v2) = x; VTX_Y(v2) = y - rfy; VTX_Z(v2) = d;                  \
    WRITECOLOUR(VTX_C(v2)); v2 += rad;                                  \
    VTX_X(v2) = x + rfx; VTX_Y(v2) = y; VTX_Z(v2) = d;                  \
    WRITECOLOUR(VTX_C(v2)); v2 += rad;                                  \
    VTX_X(v2) = x; VTX_Y(v2) = y + rfy; VTX_Z(v2) = d;                  \
    WRITECOLOUR(VTX_C(v2)); v2 += rad;                                  \
    VTX_X(v2) = x - rfx; VTX_Y(v2) = y; VTX_Z(v2) = d;                  \
    WRITECOLOUR(VTX_C(v2)); v2 += rad;                                  \
    VTX_X(v2) = x; VTX_Y(v2) = y - rfy; VTX_Z(v2) = d;                  \
    WRITECOLOUR(VTX_C(v2));                                             \
    for (rad = 1; rad < XDRAW_TRIGSIZE; rad++)                          \
    {                                                                   \
      rfloat32 sn = sTab[rad];                                          \
      rfloat32 cs = sTab[XDRAW_TRIGSIZE-rad];                           \
      v2 = v + rad+1;                                                   \
      VTX_X(v2)  = x + rfx*sn; VTX_Y(v2)  = y - rfy*cs; VTX_Z(v2)  = d; \
      WRITECOLOUR(VTX_C(v2)); v2 += XDRAW_TRIGSIZE;                     \
      VTX_X(v2)  = x + rfx*cs; VTX_Y(v2)  = y + rfy*sn; VTX_Z(v2)  = d; \
      WRITECOLOUR(VTX_C(v2)); v2 += XDRAW_TRIGSIZE;                     \
      VTX_X(v2)  = x - rfx*sn; VTX_Y(v2)  = y + rfy*cs; VTX_Z(v2)  = d; \
      WRITECOLOUR(VTX_C(v2)); v2 += XDRAW_TRIGSIZE;                     \
      VTX_X(v2)  = x - rfx*cs; VTX_Y(v2)  = y - rfy*sn; VTX_Z(v2)  = d; \
      WRITECOLOUR(VTX_C(v2));                                           \
    }                                                                   \
  }                                                                     \

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::Elipse(ruint32 col, RICOORD2D p1, RICOORD2D rad)
{
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);    rfloat32 y = CoordY(p1);
    rfloat32 rfx = CoordX(rad); rfloat32 rfy = CoordY(rad);

    VTX_X(v)=x; VTX_Y(v)=y; VTX_Z(v)=d; // centre

    GENELIPSEVERTICIES

    vBufPos += (4*XDRAW_TRIGSIZE+2);
  }
  {
    Disable(GOURAUD);
    Disable(TEXTURE);
    TriFan(v, 4*XDRAW_TRIGSIZE+2);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::ElipseShC(ruint32* col, RICOORD2D p1, RICOORD2D rad)
{
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);    rfloat32 y = CoordY(p1);
    rfloat32 rfx = CoordX(rad); rfloat32 rfy = CoordY(rad);

    // we can re use the registers occupied by p1 and rad now
    // p1 stores colour
    // rad is a masking/shifting temp
    p1 = *(col++);  rad = 8;
    ruint32 b = p1; p1 >>= rad;
    ruint32 g = p1; p1 >>= rad;
    ruint32 r = p1; p1 >>= rad;
    ruint32 a = cTab[(p1)];
    rad = 0x000000FF; r = cTab[(r&rad)]; g = cTab[(g&rad)]; b = cTab[(b&rad)];

    VTX_X(v)=x; VTX_Y(v)=y; VTX_Z(v)=d;
    WRITECOLOUR(VTX_C(v));

    p1 = *(col); rad = 8;
    b = p1; p1 >>= rad;
    g = p1; p1 >>= rad;
    rad = 0x000000FF; r = cTab[(p1&rad)]; g = cTab[(g&rad)]; b = cTab[(b&rad)];

    GENELIPSEVERTICIESCLR

    vBufPos += (4*XDRAW_TRIGSIZE+2);
  }
  {
    Enable(GOURAUD);
    Disable(TEXTURE);
    TriFan(v, 4*XDRAW_TRIGSIZE+2);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::ElipseShPt(ruint32* col, RICOORD2D p1, RICOORD2D p2, RICOORD2D rad)
{
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);    rfloat32 y = CoordY(p1);
    rfloat32 rfx = CoordX(rad); rfloat32 rfy = CoordY(rad);

    v[0].x=x+CoordX(p2);  v[0].y=y+CoordY(p2);  v[0].z=d;

    // we can re use the registers occupied by p1 and p2 now
    // p1 stores colour
    // p2 is a masking/shifting temp
    p1 = *(col++);  p2 = 8;
    ruint32 b = p1; p1 >>= p2;
    ruint32 g = p1; p1 >>= p2;
    ruint32 r = p1; p1 >>= p2;
    ruint32 a = cTab[(p1)];
    p2 = 0x000000FF; r = cTab[(r&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];

    WRITECOLOUR(VTX_C(v))

    p1 = *(col);  p2 = 8;
    b = p1; p1 >>= p2;
    g = p1; p1 >>= p2;
    p2 = 0x000000FF; r = cTab[(p1&p2)]; g = cTab[(g&p2)]; b = cTab[(b&p2)];

    GENELIPSEVERTICIESCLR

    vBufPos += 4*XDRAW_TRIGSIZE+2;
  }
  {
    Enable(GOURAUD);
    Disable(TEXTURE);
    TriFan(v, 4*XDRAW_TRIGSIZE+2);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Macro insert for Quadric texture coordinate generation
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define GENTEXCOORDS                                    \
  {                                                     \
    VTX_U(v) = x; VTX_V(v) = y;                         \
    rad = XDRAW_TRIGSIZE;                               \
    register sysVERTEX* v2 = v+1;                       \
    VTX_U(v2) = x; VTX_V(v2) = tx.y1; v2 += rad;        \
    VTX_U(v2) = tx.x2; VTX_V(v2) = y; v2 += rad;        \
    VTX_U(v2) = x; VTX_V(v2) = tx.y2; v2 += rad;        \
    VTX_U(v2) = tx.x1; VTX_V(v2) = y; v2 += rad;        \
    VTX_U(v2) = x; VTX_V(v2) = tx.y1;                   \
    for (rad = 1; rad < XDRAW_TRIGSIZE; rad++)          \
    {                                                   \
      rfloat32 sn = sTab[rad];                          \
      rfloat32 cs = sTab[XDRAW_TRIGSIZE-rad];           \
      v2 = v + rad+1;                                   \
      VTX_U(v2)  = x + rfx*sn; VTX_V(v2)  = y - rfy*cs; \
      v2 += XDRAW_TRIGSIZE;                             \
      VTX_U(v2)  = x + rfx*cs; VTX_V(v2)  = y + rfy*sn; \
      v2 += XDRAW_TRIGSIZE;                             \
      VTX_U(v2)  = x - rfx*sn; VTX_V(v2)  = y + rfy*cs; \
      v2 += XDRAW_TRIGSIZE;                             \
      VTX_U(v2)  = x - rfx*cs; VTX_V(v2)  = y - rfy*sn; \
    }                                                   \
  }                                                     \

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::CircleScTx(ruint32 col, RICOORD2D p1, ruint32 rad, register xTEXTURE& tx)
{
  // TO DO : Evaluate a segment count based on radius. minimum 8, max 64
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);
    rfloat32 y = CoordY(p1);
    rfloat32 rfx = rad;

    VTX_X(v)=x; VTX_Y(v)=y; VTX_Z(v)=d; // centre

    GENCIRCLEVERTICIES

    {
      x   = (tx.x1 + tx.x2)/2F;
      y   = (tx.y1 + tx.y2)/2F;
      rfx = (tx.x2 - tx.x1)/2F;
      rfloat32 rfy  = (tx.y2 - tx.y1)/2F;

      GENTEXCOORDS

    }
    vBufPos += (4*XDRAW_TRIGSIZE+2);
  }
  {
    Disable(GOURAUD);
    Enable(TEXTURE);
    TriFanTx(v, 4*XDRAW_TRIGSIZE+2, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::CircleScTxShC(ruint32* col, RICOORD2D p1, ruint32 rad, register xTEXTURE& tx)
{
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);
    rfloat32 y = CoordY(p1);
    rfloat32 rfx = rad;

    // colours
    p1 = *(col++);
    rad = 8;
    ruint32 b = p1; p1 >>= rad;
    ruint32 g = p1; p1 >>= rad;
    ruint32 r = p1; p1 >>= rad;
    ruint32 a = cTab[(p1)];
    rad = 0x000000FF; r = cTab[(r&rad)]; g = cTab[(g&rad)]; b = cTab[(b&rad)];

    VTX_X(v)=x; VTX_Y(v)=y; VTX_Z(v)=d;
    WRITECOLOUR(VTX_C(v));

    p1 = *(col); rad = 8;
    b = p1; p1 >>= rad;
    g = p1; p1 >>= rad;
    rad = 0x000000FF; r = cTab[(p1&rad)]; g = cTab[(g&rad)]; b = cTab[(b&rad)];

    GENCIRCLEVERTICIESCLR

    {
      x   = (tx.x1 + tx.x2)/2F;
      y   = (tx.y1 + tx.y2)/2F;
      rfx = (tx.x2 - tx.x1)/2F;
      rfloat32 rfy  = (tx.y2 - tx.y1)/2F;

      GENTEXCOORDS

    }
    vBufPos += (4*XDRAW_TRIGSIZE+2);
  }
  {
    Enable(GOURAUD);
    Enable(TEXTURE);
    TriFanTx(v, 4*XDRAW_TRIGSIZE+2, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::ElipseScTx(ruint32 col, RICOORD2D p1, RICOORD2D rad, register xTEXTURE& tx)
{
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  if (col != currentCol)
  {
    currentCol = col;
    SetColour(col);
  }
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);    rfloat32 y = CoordY(p1);
    rfloat32 rfx = CoordX(rad); rfloat32 rfy = CoordY(rad);
    VTX_X(v)=x; VTX_Y(v)=y; VTX_Z(v)=d; // centre

    GENELIPSEVERTICIES

    {
      x   = (tx.x1 + tx.x2)/2F;
      y   = (tx.y1 + tx.y2)/2F;
      rfx = (tx.x2 - tx.x1)/2F;
      rfy = (tx.y2 - tx.y1)/2F;

      GENTEXCOORDS

    }
    vBufPos += (4*XDRAW_TRIGSIZE+2);
  }
  {
    Disable(GOURAUD);
    Enable(TEXTURE);
    TriFanTx(v, 4*XDRAW_TRIGSIZE+2, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::ElipseScTxShC(ruint32* col, RICOORD2D p1, RICOORD2D rad, register xTEXTURE& tx)
{
  if (vBufPos+(4*XDRAW_TRIGSIZE+2) >= vArraySize) Flush();
  register sysVERTEX* v = vBuffer+vBufPos;
  {
    rfloat64 d = zDepth;
    rfloat32 x = CoordX(p1);    rfloat32 y = CoordY(p1);
    rfloat32 rfx = CoordX(rad); rfloat32 rfy = CoordY(rad);


    // we can re use the registers occupied by p1 and rad now
    // p1 stores colour
    // rad is a masking/shifting temp
    p1 = *(col++);  rad = 8;
    ruint32 b = p1; p1 >>= rad;
    ruint32 g = p1; p1 >>= rad;
    ruint32 r = p1; p1 >>= rad;
    ruint32 a = cTab[(p1)];
    rad = 0x000000FF; r = cTab[(r&rad)]; g = cTab[(g&rad)]; b = cTab[(b&rad)];

    VTX_X(v)=x; VTX_Y(v)=y; VTX_Z(v)=d;
    WRITECOLOUR(VTX_C(v));
    p1 = *(col); rad = 8;
    b = p1; p1 >>= rad;
    g = p1; p1 >>= rad;
    rad = 0x000000FF; r = cTab[(p1&rad)]; g = cTab[(g&rad)]; b = cTab[(b&rad)];

    GENELIPSEVERTICIESCLR

    {
      x   = (tx.x1 + tx.x2)/2F;
      y   = (tx.y1 + tx.y2)/2F;
      rfx = (tx.x2 - tx.x1)/2F;
      rfy = (tx.y2 - tx.y1)/2F;

      GENTEXCOORDS

    }
    vBufPos += (4*XDRAW_TRIGSIZE+2);
  }
  {
    Enable(GOURAUD);
    Enable(TEXTURE);
    TriFanTx(v, 4*XDRAW_TRIGSIZE+2, tx.tex);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#undef GENCIRCLEVERTICIES
#undef GENCIRCLEVERTICIESCLR
#undef GENELIPSEVERTICIES
#undef GENELIPSEVERTICIESCLR
#undef WRITECOLOUR
#undef GENTEXCOORDS

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
