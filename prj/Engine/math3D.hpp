//****************************************************************************//
//**                                                                        **//
//**  File:          math3D.hpp ($NAME=math3D.hpp)                          **//
//**                                                                        **//
//**  Description:   3D vector arithmetic routines                          **//
//**  Comment(s):                                                           **//
//**                                                                        **//
//**  First Started: 2003-01-18                                             **//
//**  Last Updated:  2003-01-18                                             **//
//**                                                                        **//
//**  Author(s):     Karl Churchill                                         **//
//**                                                                        **//
//**  Copyright:     (C)1998-2003, eXtropia Studios                         **//
//**                 Serkan YAZICI, Karl Churchill                          **//
//**                 All Rights Reserved.                                   **//
//**                                                                        **//
//****************************************************************************//

#ifndef _ENGINE_MATH3D_HPP
#define _ENGINE_MATH3D_HPP

#include <xBase.hpp>
#include <math.h>

inline float32 Deg2Rad(float32 x) { return x*(PI/180.0); }

//#define USE_HAND_OPTIMIZED

inline bool FloatCompare(float64 v1, float64 v2)
{
  if (fabs(v1-v2)>0.0001) return false;
  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  VEC3D
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class TRANSFORM;

class VEC3D {
  public:
    float32 x;
    float32 y;
    float32 z;
  public:
    VEC3D() {}
    VEC3D(float32 ix, float32 iy=0, float32 iz=0) : x(ix), y(iy), z(iz) {}
  public:
    VEC3D& operator=(const VEC3D& c)  { x=c.x; y=c.y; z=c.z; return *this; }
    VEC3D& operator+=(const VEC3D& c) { x+=c.x; y+=c.y; z+=c.z; return *this; }
    VEC3D& operator-=(const VEC3D& c) { x-=c.x; y-=c.y; z-=c.z; return *this; }
    VEC3D& operator*=(const VEC3D& c);
    VEC3D& operator*=(rfloat32 i)     { x*=i; y*=i; z*=i; return *this; }
    VEC3D& operator/=(rfloat32 i)     { i=1.0f/i; x*=i; y*=i; z*=i; return *this; }
    VEC3D& operator*=(TRANSFORM& t);
    float32 MagnitudeSqrd()           { return x*x + y*y + z*z; }
    float32 Magnitude()               { return sqrt(MagnitudeSqrd()); }
    void    Normalize()               { rfloat32 f=1.0f/Magnitude(); x*=f; y*=f; z*=f; }
};

inline VEC3D& VEC3D::operator*=(const VEC3D& c)
{ // A x B = (b1*c2-b2*c1)i + (a2*c1-a1*c2)j + (a1*b2-a2*b1)k
  rfloat32 tx = x;  x = y*c.z - c.y*z;  // (b1*c2-b2*c1)i
  rfloat32 ty = y;  y = c.x*z - tx*c.z; // (a2*c1-a1*c2)j
  z = tx*c.y - c.x*ty;                  // (a1*b2-a2*b1)k
  return *this;
}

inline float32 DotProd(const VEC3D& a, const VEC3D& b)  { return a.x*b.x + a.y*b.y + a.z*b.z; }
inline VEC3D operator+(const VEC3D& a, const VEC3D& b)  { VEC3D r=a; r+=b; return r; }
inline VEC3D operator-(const VEC3D& a, const VEC3D& b)  { VEC3D r=a;  r-=b; return r; }
inline VEC3D operator*(const VEC3D& a, const VEC3D& b)  { VEC3D r=a;  r*=b; return r; }

inline float32 AngCosine(VEC3D& a, VEC3D& b)
{
  // returns cos(Ang) where Ang is the angle between two VEC3D
  return DotProd(a, b) / (a.Magnitude()*b.Magnitude());
}

inline float32 Angle(VEC3D& a, VEC3D& b)
{
  return (180.0f/PI) * acos(DotProd(a, b));
}

///////////////////////////////////////////////////////////////////////////////
//
//  TRANSFORM
//
//  Encapsulates a 4x4 matrix for which the last row is always 0 0 0 1. This
//  allows us to represent the data internally as a 3x4 matrix by removing
//  the constant terms.
//
//  The internal representation is double buffered. This is to eliminate the
//  need for the creation of temporaries and data copying.
//
///////////////////////////////////////////////////////////////////////////////

#define M_11 0
#define M_12 1
#define M_13 2
#define M_14 3
#define M_21 4
#define M_22 5
#define M_23 6
#define M_24 7
#define M_31 8
#define M_32 9
#define M_33 10
#define M_34 11
/*
#define M_41 12
#define M_42 13
#define M_43 14
#define M_44 15
*/

class TRANSFORM {
  private:
    float32   data[24];
    float32*  matrix;

  #ifdef USE_HAND_OPTIMIZED
    static void asm_MultiplyAssign(REGP(0) float32 *const, REGP(1) float32 *const);
    static void asm_ApplyRotate(REGP(0) float32* const);
  #endif

  protected:
    void      Swap()    { matrix = &data[12-(matrix-data)]; }

  public:
    float32*  Matrix()    { return matrix; }
    float32*  Secondary() { return &data[12-(matrix-data)]; }

    void Identity() {
      ruint32* m = (uint32*)matrix;
      ruint32 one = 0x3F800000; // integer rep of IEEE754 sp 1.0
      *(m++) = one; *(m++) = 0;   *(m++) = 0;   *(m++) = 0;
      *(m++) = 0;   *(m++) = one; *(m++) = 0;   *(m++) = 0;
      *(m++) = 0;   *(m++) = 0;   *(m++) = one; *(m++) = 0;
    }

    void Scale(float32 s) {                             // Performs M' = s.M
      rfloat32* m = matrix;
      *(m++)*=s; *(m++)*=s; *(m++)*=s; *(m++)*=s;
      *(m++)*=s; *(m++)*=s; *(m++)*=s; *(m++)*=s;
      *(m++)*=s; *(m++)*=s; *(m++)*=s; *(m++)*=s;
    }

    void Scale(float32 x, float32 y, float32 z) {       // Performs M' = S{x,y,z}.M
      rfloat32* m = matrix;
      *(m++)*=x; *(m++)*=x; *(m++)*=x; *(m++)*=x;
      *(m++)*=y; *(m++)*=y; *(m++)*=y; *(m++)*=y;
      *(m++)*=z; *(m++)*=z; *(m++)*=z; *(m++)*=z;
    }

    void Translate(float32 x, float32 y, float32 z) {   // Performs M' = T{x,y,z}.M
      matrix[M_14]+=x; matrix[M_24]+=y; matrix[M_34]+=z;
    }

    void Rotate(float32 rx, float32 ry, float32 rz);    // Performs M' = R{x,y,z}.M

    void Scale(const VEC3D& v)            { Scale(v.x, v.y, v.z); }
    void Scale(const VEC3D *const v)      { Scale(v->x, v->y, v->z); }
    void Translate(const VEC3D& v)        { Translate(v.x, v.y, v.z); }
    void Translate(const VEC3D *const v)  { Translate(v->x, v->y, v->z); }
    void Rotate(const VEC3D& v)           { Rotate(v.x, v.y, v.z); }
    void Rotate(const VEC3D *const v)     { Rotate(v->x, v->y, v->z); }

    void Transform(VEC3D* v, size_t n);

  #ifdef USE_HAND_OPTIMIZED
    TRANSFORM& operator*=(const TRANSFORM& t) { asm_MultiplyAssign(matrix, t.matrix); return *this; }
  #else
    TRANSFORM& operator*=(const TRANSFORM& t);
  #endif
  public:
    TRANSFORM() { matrix = data; Identity(); }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline VEC3D& VEC3D::operator*=(TRANSFORM& t)
{
  rfloat32*m = t.Matrix();
  rfloat32 tx = x;
  rfloat32 ty = y;
  rfloat32 tz = z;
  x = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
  y = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
  z = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m);
  return *this;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif
