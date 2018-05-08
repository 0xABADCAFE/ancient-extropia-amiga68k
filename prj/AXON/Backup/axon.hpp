//*****************************************************************//
//** Description:   Axonometric Projector, AmigaOS/68K version   **//
//** First Started:                                              **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _AXON_HPP

#define _AXON_HPP

#include <xBase.hpp>
#include <xSystem/xResources.hpp>
#include <xSystem/xDraw.hpp>
#include <iostream.h>

extern "C" {
  #include <math.h>
}

struct C2D {
  FLOAT32 x;
  FLOAT32 y;
  C2D() : x(0), y(0) {}
  C2D(FLOAT32 ix, FLOAT32 iy) : x(ix), y(iy) {}
};

// Vector3D type, basis for C3D coordinate

struct VEC3D {
  FLOAT32 x;
  FLOAT32 y;
  FLOAT32 z;
  VEC3D() {}
  VEC3D(FLOAT32 ix, FLOAT32 iy=0, FLOAT32 iz=0) : x(ix), y(iy), z(iz) {}
  VEC3D& operator=(VEC3D& c)    { x=c.x; y=c.y; z=c.z; return *this; }
  VEC3D& operator+=(VEC3D& c)   { x+=c.x; y+=c.y; z+=c.z; return *this; }
  VEC3D& operator-=(VEC3D& c)   { x-=c.x; y-=c.y; z-=c.z; return *this; }
  VEC3D& operator*=(RFLOAT32 i) { x*=i; y*=i; z*=i; return *this; }
  VEC3D& operator/=(RFLOAT32 i) { x/=i; y/=i; z/=i; return *this; }
};

inline VEC3D operator+(VEC3D& a, VEC3D& b)
{
  VEC3D r=a;
  return r+=b;
}

inline VEC3D operator-(VEC3D& a, VEC3D& b)
{
  VEC3D r=a;
  return r-=b;
}

struct C3D : public VEC3D {
  FLOAT32 u; // 2D texture ordinates
  FLOAT32 v;
  UINT32  c; // basic point color
  C3D() {}
  C3D(FLOAT32 ix, FLOAT32 iy=0, FLOAT32 iz=0, FLOAT32 iu=0, FLOAT32 iv=0, UINT32 ic=0) : VEC3D(ix,iy,iz), u(iu), v(iv), c(ic) {}
  C3D& operator=(C3D& a) { x=a.x, y=a.y; z=a.z; u=a.u; v=a.v; c=a.c; return *this; }
};

inline C3D operator+(C3D& a, VEC3D& b)
{
  C3D r=a; r+=b;
  return r; // VEC3D::operator+=()
}

inline C3D operator+(VEC3D& a,C3D& b)
{
  C3D r=b; r+=a;
  return r; // VEC3D::operator+=()
}

inline C3D operator-(C3D& a, VEC3D& b)
{
  C3D r=a; r-=b;
  return r; // VEC3D::operator-=()
}

inline C3D operator-(VEC3D& a, C3D& b)
{
  C3D r=b; r-=a;
  return r; // VEC3D::operator+=()
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  AXON
//
//  Contains global data needed by axonometric projector, plus a few utilities, such as high speed trig operations etc.
//
//  Angles are defined in degrees, with a resolution of 1 degree. This allows us to replace sin/cos/tan etc with compact
//  LUTs.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define MAXMAPVERTICES 5120

class VIEW;

class MODEL;

class AXON : protected xDRAW {

  private:
    static FLOAT32  sineData[91]; // small sine LUT for 0-90 deg inclusive
    static FLOAT32  gradData[91]; // small LUT for angular gradient data (tan)

  protected:

  #ifdef CLIPSTATS
    static SINT32     centreClips;
    static SINT32     cornerClips;
    static SINT32     edgeClips;
  #endif

    static FLOAT32    QSin(RUINT32 i); // i = 0-360 degrees
    static FLOAT32    QCos(RUINT32 i); // i = 0-360 degrees
    static FLOAT32    Parallel(RUINT32 i);
    static FLOAT32    Perp(RUINT32 i);

    static void       MeshToStrips(C3D* m, sysVERTEX* v, SINT32 n);
    static sysVERTEX* PushCoords(C3D* c, SINT32 n);

  public:

    //  World Space Rotation
    //
    //  These rotate points in World space, to orientate models etc. with respect to the WORLDMAP
    //  Every conceiveable rotation operation in world space is presented here. Each is as optimal as possible
    //  for the operation it performs. The following are taken into consideration
    //  1) Avoidance of large temporaries
    //  2) Avoidance of multiple passes through source/destination
    //  3) Minimisation of data copying
    //  4) Elimination of non-essential calculation

    // Rotate src
    static void     RotSX(C3D* src, SINT32 n, SINT16 ax);
    static void     RotSY(C3D* src, SINT32 n, SINT16 ay);
    static void     RotSZ(C3D* src, SINT32 n, SINT16 az);
    static void     RotSXY(C3D* src, SINT32 n, SINT16 ax, SINT16 ay);
    static void     RotSXZ(C3D* src, SINT32 n, SINT16 ax, SINT16 az);
    static void     RotSYZ(C3D* src, SINT32 n, SINT16 ay, SINT16 az);
    static void     RotSXYZ(C3D* src, SINT32 n, SINT16 ax, SINT16 ay, SINT16 az);
    // Rotate src about org
    static void     RotSX(VEC3D* org, C3D* src, SINT32 n, SINT16 ax);
    static void     RotSY(VEC3D* org, C3D* src, SINT32 n, SINT16 ay);
    static void     RotSZ(VEC3D* org, C3D* src, SINT32 n, SINT16 az);
    static void     RotSXY(VEC3D* org, C3D* src, SINT32 n, SINT16 ax, SINT16 ay);
    static void     RotSXZ(VEC3D* org, C3D* src, SINT32 n, SINT16 ax, SINT16 az);
    static void     RotSYZ(VEC3D* org, C3D* src, SINT32 n, SINT16 ay, SINT16 az);
    static void     RotSXYZ(VEC3D* org, C3D* src, SINT32 n, SINT16 ax, SINT16 ay, SINT16 az);
    // Rotate src --> dst
    static void     RotSDX(C3D* src, C3D* dst, SINT32 n, SINT16 ax);
    static void     RotSDY(C3D* src, C3D* dst, SINT32 n, SINT16 ay);
    static void     RotSDZ(C3D* src, C3D* dst, SINT32 n, SINT16 az);
    static void     RotSDXY(C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 ay);
    static void     RotSDXZ(C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 az);
    static void     RotSDYZ(C3D* src, C3D* dst, SINT32 n, SINT16 ay, SINT16 az);
    static void     RotSDXYZ(C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 ay, SINT16 az);
    // Rotate src about org --> dst
    static void     RotSDX(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ax);
    static void     RotSDY(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ay);
    static void     RotSDZ(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 az);
    static void     RotSDXY(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 ay);
    static void     RotSDXZ(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 az);
    static void     RotSDYZ(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ay, SINT16 az);
    static void     RotSDXYZ(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 ay, SINT16 az);

    // General purpose rotation.
    // These functions always attempt to use the most appropriate method from those above. There is a small
    // runtime overhead incurred due to a switch statement that determines which to use. In critical cases,
    // don't use these funcs if the rotation is known at compile time. Instead, use the appropriate one from
    // the list above.

    static void     Rotate(register C3D* src, register C3D* dst, RSINT32 n, RSINT16 ax, RSINT16 ay, RSINT16 az);
    static void     Rotate(register VEC3D* org, register C3D* src, register C3D* dst, RSINT32 n, RSINT16 ax, RSINT16 ay, RSINT16 az);

    // World space to View space projection
    static void     WorldToView(VIEW& v, C3D* src, C3D* dst, SINT32 n);
    static void     WorldToView(VIEW& v, C3D* src, sysVERTEX* dst, SINT32 n);


    // Utility functions
    static UINT32   TraceVec(VEC3D* from, VEC3D* to, VEC3D* traceEnd, MODEL** hitThing);

  public:
    static SINT32 Init();
    static void Done();
};

inline  FLOAT32 AXON::QSin(RUINT32 i)
{
  if (i<90)
    return sineData[i];     // sin(0...PI/2)
  else if (i<180)
    return sineData[180-i]; // sin(PI/2...PI)    : y axis reflection symmetrical to sin(0...PI/2)
  else if (i<270)
    return -sineData[i-180];// sin(PI...3PI/2)   : x axis reflection symmetrical to sin(0...PI/2)
  else if (i<360)
    return -sineData[360-i];// sin(3PI/2...2PI)  : x/y axis reflection symmetrical to sin(0...PI/2)
  else
    return sineData[i-360]; // to allow interpolator to wrap to first quater
}

inline  FLOAT32 AXON::QCos(RUINT32 i)
{
  if (i<90)
    return sineData[90-i];  // cos(0...PI/2)    : y axis reflection symmetrical to sin(0...PI/2)
  else if (i<180)
    return -sineData[i-90]; // cos(PI/2...PI)   : x axis reflection symmetrical to sin(0...PI/2)
  else if (i<270)
    return -sineData[270-i];// cos(PI...3PI/2)  : x/y axis reflection symmetrical to sin(0...PI/2)
  else if (i<360)
    return sineData[i-270]; // cos(3PI/2...2PI) : congruent with sin(0...PI/2)
  else
    return sineData[450-i]; // to allow interpolator to wrap to first quater
}

inline  FLOAT32 AXON::Parallel(RUINT32 i)
{
  if (i<90)
    return gradData[i];       // 0 --> infinity
  else if (i<180)
    return -gradData[180-i];  // -infinity --> 0
  else if (i<270)
    return gradData[i-180];   // 0 --> infinity
  else if (i<360)
    return -gradData[360-i];  // -infinity --> 0
  else
    return gradData[i-360];
}

inline  FLOAT32 AXON::Perp(RUINT32 i)
{
  if (i<90)
    return -gradData[90-i];   // -infinity --> 0
  else if (i<180)
    return gradData[i-90];    // 0 --> infinity
  else if (i<270)
    return -gradData[270-i];  // -infinity --> 0
  else if (i<360)
    return gradData[i-270];   // 0 --> infinity
  else
    return -gradData[450-i];
}

inline void AXON::Rotate(register C3D* src, register C3D* dst, RSINT32 n, RSINT16 ax, RSINT16 ay, RSINT16 az)
{
  UINT32 bestFunc = (src==dst)<<3 | (ax==0) <<2 | (ay==0)<<1 | (az==0);
  switch(bestFunc)
  {
    case 0:   RotSDXYZ(src, dst, n, ax, ay, az);      break;
    case 1:   RotSDXY(src, dst, n, ax, ay);           break;
    case 2:   RotSDXZ(src, dst, n, ax, az);           break;
    case 3:   RotSDX(src, dst, n, ax);                break;
    case 4:   RotSDYZ(src, dst, n, ay, az);           break;
    case 5:   RotSDY(src, dst, n, ay);                break;
    case 6:   RotSDZ(src, dst, n, az);                break;
    case 7:   MEM::Copy(src, dst, n*sizeof(C3D)); break;
    case 8:   RotSXYZ(src, n, ax, ay, az);            break;
    case 9:   RotSXY(src, n, ax, ay);                 break;
    case 10:  RotSXZ(src, n, ax, az);                 break;
    case 11:  RotSX(src, n, ax);                      break;
    case 12:  RotSYZ(src,n, ay, az);                  break;
    case 13:  RotSY(src, n, ay);                      break;
    case 14:  RotSZ(src, n, az);                      break;
    default:
      break;
  }
}

inline void AXON::Rotate(register VEC3D* org, register C3D* src, register C3D* dst, RSINT32 n, RSINT16 ax, RSINT16 ay, RSINT16 az)
{
  UINT32 bestFunc = (src==dst)<<3 | (ax==0) <<2 | (ay==0)<<1 | (az==0);
  switch(bestFunc)
  {
    case 0:   RotSDXYZ(org, src, dst, n, ax, ay, az); break;
    case 1:   RotSDXY(org, src, dst, n, ax, ay);      break;
    case 2:   RotSDXZ(org, src, dst, n, ax, az);      break;
    case 3:   RotSDX(org, src, dst, n, ax);           break;
    case 4:   RotSDYZ(org, src, dst, n, ay, az);      break;
    case 5:   RotSDY(org, src, dst, n, ay);           break;
    case 6:   RotSDZ(org, src, dst, n, az);           break;
    case 7:   MEM::Copy(src, dst, n*sizeof(C3D)); break;
    case 8:   RotSXYZ(org, src, n, ax, ay, az);       break;
    case 9:   RotSXY(org, src, n, ax, ay);            break;
    case 10:  RotSXZ(org, src, n, ax, az);            break;
    case 11:  RotSX(org, src, n, ax);                 break;
    case 12:  RotSYZ(org, src,n, ay, az);             break;
    case 13:  RotSY(org, src, n, ay);                 break;
    case 14:  RotSZ(org,src, n, az);                  break;
    default:
      break;
  }
}

#include "view.hpp"
#include "world.hpp"
#include "model.hpp"

#endif // _AXON_HPP