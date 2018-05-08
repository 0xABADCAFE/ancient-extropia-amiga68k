//*****************************************************************//
//** Description:   Axonometric Projector, AmigaOS/68K version   **//
//** First Started:                                              **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "axon.hpp"

#define MAX_GRAD 1000.0

/*

    Require following methods : need a good 3D geometry book

		PLANE:: class



    2) Other utility methods

       a) TraceVec - scans from one VEC3D location to another, something like this
          result = TraceVec(VEC3D* from, VEC3D* to, VEC3D* endPos, MODEL** thing)

          From / to are the locations to trace between and 'endPos' is the address of a VEC3D object to store
          the traced end position in. The 'thing' argument is the address of a MODEL* pointer that will be set to the address
          of the first (if any) MODEL that the trace hit. The result will be a collection of flags.

          VEC3D from(0.1, 0.1, 0.1); VEC3D to(0.8,0.8,0.0); VEC3D endPos(); MODEL* hit=0;
          uint32 result = TraceVec(&from, &to, &endPos, &hit);
          if (result & TRACE_MODEL)
          cout << "Hit model : " << hit->Name() << "\n";
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  AXON::
//
//  This is the very back end of the projection system, very little here, actually.
//  Provides rotation and projection methods for vertices and other low level work
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32			AXON::vCachePtr		= 0;
sysVERTEX*	AXON::vCache			= 0;

#ifdef CLIPSTATS
sint32	AXON::centreClips = 0;
sint32	AXON::cornerClips = 0;
sint32	AXON::edgeClips = 0;
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 AXON::Init()
{
	if (TEXTUREHEAP::Init(64)!=OK)
	{
		Done();
		return ERR_RSC_UNAVAILABLE;
	}

	vCache = New(vCache, VCACHESIZE);
	if (!vCache)
	{
		Done();
		return ERR_NO_FREE_STORE;
	}
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::Done()
{
	if (vCache)
		Delete(vCache);
	vCache		= 0;

	TEXTUREHEAP::Done();

	#ifdef CLIPSTATS
	printf("edges clipped   : %d\n", edgeClips);
	printf("corners clippes : %d\n", cornerClips);
	printf("centres clipped : %d\n", centreClips);
	#endif
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 AXON::TraceVec(VEC3D* from, VEC3D* to, VEC3D* traceEnd, MODEL** hitThing)
{
	// this is gonna be quite tough to do
	// Simply tracing along the line to-from in small increments is silly and time consuming.
	// We need something like
  // 1. Build a list of each cell that vector to-from crosses
	// 2. Stop list the moment we detect that the trace has passed through the ground
  // 3. Use that list to build a list of MODELS that the trace could possibly hit
  // 4. Sort list in order of nearest ... farthest from 'from'
	// 5. Test each MODEL for contact with the trace

	// Hardest parts are 2 and 5. Part 2 would probably be implemented by evaluating which PLANEs the trace passes through as we
	// test the cell. We need to test not that the trace crosses a PLANE, but that it crosses the PLANE at a point INSIDE the three
	// boundary points used in its definition. Probably, PLANE will need 3 VEC3D* members added to its definition to enable this

	return 0;
}


void AXON::MeshToStrips(C3D* m, sysVERTEX* v, sint32 n)
{
	//  The source data is a nth order 2D mesh of MAP3D coordinates.
	//  We convert this into n strips of 2*n triangles suitable
	//  for xDRAW::TriStrip()
	//
	//  Note, for an nth order mesh there are (n+1)^2 C3D coordinates
	//  and each converted strip has 2n+2 vertices -> 2(n^2 + n) overall
	//
 	//  The vertex addresses are calculated by
	//
	//    strip i begins at &v[i*(2n+2)];
	//
	//  Hence, an 8th order mesh would comprise
	//
	//    81  MAP3D coords
	//    128 triangles as 8 triangle strips
	//    144 vertices
	//
	//    strip 0 at &v[0]
	//    strip 1 at &v[18]
	//
	//
	for (rsint32 s=0; s<n; s++, m += (n+1), v += ((n<<1)+1) )
	{
		for (rsint32 i=0; i<=n; i++)
		{
			// Even vertices (top of strip)
			register C3D*			mSrc = m+i;
			register sysVERTEX*	vDst = v+(i+i);

			vDst->x = mSrc->x;
			vDst->y = mSrc->y;
			vDst->z = mSrc->z;
			vDst->u = mSrc->u;
			vDst->v = mSrc->v;
			xDRAW::ARGBtoCol(mSrc->c, &(vDst->color));

			// Odd vertices (bottom of strip)
			mSrc += (n+1); vDst++;

			vDst->x = mSrc->x;
			vDst->y = mSrc->y;
			vDst->z = mSrc->z;
			vDst->u = mSrc->u;
			vDst->v = mSrc->v;
			xDRAW::ARGBtoCol(mSrc->c, &(vDst->color));
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sysVERTEX* AXON::PushCoords(C3D* c, sint32 n)
{
	sysVERTEX* v = Vertices(n);
	{
		register sysVERTEX* vt = v; n++;
		while(--n)
		{
			vt->x = c->x;		vt->y = c->y;		vt->z = c->z;
			vt->u = c->u;		vt->v = c->v;
			ARGBtoCol((c++)->c, &((vt++)->color));
		}
	}
	return v;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  WORLDMAP SPACE LOCAL AXIS ROTATION
//
//      +z (up)           WORLDMAP space uses right hand coordinate reference
//      |
//      |  +y (forwards)  Positive angles are defined as clockwise around the positive axis direction
//      | /
//      |/
//      O-------- +x (right)
//
//  C = cos(); S = sin(), X = rotation around X axis, Y rotation around Y axis, etc.
//
//  Single axis rotation
//
//  Can be optimised to point where full blown matrix is not required since only two unique
//  factors (ignoring sign) are required. These can be easily put into registers.
//
//  x-axis
//
//    | x'|   | 1  0   0  | | x |   eg X=90 degrees, point p[1,2,3] --> point p'[1,3,-2]
//    |   |   |           | |   |
//    | y'| = | 0  CX  SX | | y |
//    |   |   |           | |   |
//    | z'|   | 0 -SX  CX | | z |
//
//  y-axis
//
//    | x'|   | CY  0  SY | | x |   eg Y=90 degrees, point p[1,2,3] --> point p'[3,2,-1]
//    |   |   |           | |   |
//    | y'| = | 0   1  0  | | y |
//    |   |   |           | |   |
//    | z'|   |-SY  0  CY | | z |
//
//  z-axis
//
//    | x'|   | CZ -SZ  0 | | x |   eg Z=90 degrees, point p[1,2,3] --> point p'[-2,1,3]
//    |   |   |           | |   |
//    | y'| = | SZ  CZ  0 | | y |
//    |   |   |           | |   |
//    | z'|   | 0   0   1 | | z |
//
//
//  Double axis rotation
//
//  A matrix is required for most machines since there are at least 8 unique factors
//  PowerPC : can optimise to put all 8 into registers
//
//  x.y
//
//    | x'|   | CY    0   SY   | | x |
//    |   |   |                | |   |
//    | y'| = | SXSY  CX  SXCY | | y |
//    |   |   |                | |   |
//    | z'|   |-CXSY -SX  CXCY | | z |
//
//  x.z
//
//    | x'|   | CZ   -SZ    0  | | x |
//    |   |   |                | |   |
//    | y'| = | CXSZ  CXCZ  SX | | y |
//    |   |   |                | |   |
//    | z'|   | SXSZ -SXCZ  CX | | z |
//
//  y.z
//
//    | x'|   | CYCZ -CYSZ  SY | | x |
//    |   |   |                | |   |
//    | y'| = | SZ    CZ    0  | | y |
//    |   |   |                | |   |
//    | z'|   |-SYCZ  SYSZ  CY | | z |
//
//
//  Triple axis rotation
//
//  A matrix is required for most machines since there are at least 9 unique factors
//  PowerPC : can optimise to put all 9 into registers
//  x.y.z, derived as (x.y).z
//
//    | x'|   | CYCZ        -CYSZ         SY   | | x |
//    |   |   |                                | |   |
//    | y'| = | SXSYCZ+CXSZ -SXSYSZ+CXCZ  SXCY | | y |
//    |   |   |                                | |   |
//    | z'|   |-CXSYCZ-SXSZ  CXSYSZ-SXCZ  CXCY | | z |
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#undef MAX_GRAD
