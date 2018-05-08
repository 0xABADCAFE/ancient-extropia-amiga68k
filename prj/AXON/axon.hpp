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
#include <xSystem/GraphicsLibOld.hpp>

extern "C" {
  #include <math.h>
  #include <limits.h>
}

#include "3DBase.hpp"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  AXON::
//
//    Contains global data and rotation methods needed by the axonometric projection, plus a few utilities, such as high speed
//  trig operations etc. Angles are defined in degrees, with a resolution of 1 degree. This allows us to replace sin/cos/tan etc
//  with compact, cache-friendly LUTs.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define VCACHESIZE 16384UL

class VIEW;
class MODEL;

class AXON : protected xDRAW {

  private:

  #ifdef CLIPSTATS
    static sint32     centreClips;
    static sint32     cornerClips;
    static sint32     edgeClips;
  #endif

  protected:
    // Vertex Cache
    static sint32     vCachePtr;  // Current vertex cache index
    static sysVERTEX* vCache;     // Cache for projected vertices, reset every time view changes
    static sysVERTEX* CachedVertices(sint32 n);

    static void       MeshToStrips(C3D* m, sysVERTEX* v, sint32 n);
    static sysVERTEX* PushCoords(C3D* c, sint32 n);

  public:
    // Utility functions
    static uint32   TraceVec(VEC3D* from, VEC3D* to, VEC3D* traceEnd, MODEL** hitThing);

  public:
    static sint32 Init();
    static void Done();
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline sysVERTEX* AXON::CachedVertices(sint32 n)
{
  if (n+vCachePtr > VCACHESIZE)
  {
    puts("Vertex Overflow");
    return 0;
  }
  sysVERTEX* v = vCache+vCachePtr;
  vCachePtr+=n;
  return v;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "heap.hpp"
#include "view.hpp"
#include "world.hpp"
#include "model.hpp"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif // _AXON_HPP