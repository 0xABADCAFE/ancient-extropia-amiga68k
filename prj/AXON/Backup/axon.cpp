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

	TO DO

		1) Add further utility methods to AXON:: namespace. Need functions for

		   a) TraceVec - scans from one VEC3D location to another, something like this

		      result = TraceVec(VEC3D* from, VEC3D* to, VEC3D* endPos, MODEL** thing)

					where from / to are the locations to trace between and 'endPos' is the address of a VEC3D object to store
			    the traced end position in. The 'thing' argument is the address of a MODEL* pointer that will be set to the address
			    of the first (if any) MODEL that the trace hit. The result will be a collection of flags.

					VEC3D from(0.1, 0.1, 0.1); VEC3D to(0.8,0.8,0.0); VEC3D endPos(); MODEL* hit=0;
					UINT32 result = TraceVec(&from, &to, &endPos, &hit);
					if (result & TRACE_MODEL)
						cout << "Hit model : " << hit->Name() << "\n";

*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  AXON::
//
//  This is the very back end of the projection system, very little here, actually
//
//  Will add code for geometry calculation for objects
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FLOAT32	AXON::sineData[91] = {0};
FLOAT32	AXON::gradData[91] = {0};

#ifdef CLIPSTATS
SINT32	AXON::centreClips = 0;
SINT32	AXON::cornerClips = 0;
SINT32	AXON::edgeClips = 0;
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SINT32 AXON::Init()
{
	for (int i = 0; i < 91; i++)
	{
		sineData[i] = sin((FLOAT32)i*(PI/180.0));
		gradData[i] = tan((FLOAT32)i*(PI/180.0));
	}
	// tan(PI/4) is asymptotic and screws up boundary calcs so
	gradData[90] = MAX_GRAD;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::Done()
{
	#ifdef CLIPSTATS
	cout << "edges clipped   : " << edgeClips << "\n";
	cout << "corners clippes : " << cornerClips << "\n";
	cout << "centres clipped : " << centreClips << "\n";
	#endif
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

UINT32 AXON::TraceVec(VEC3D* from, VEC3D* to, VEC3D* traceEnd, MODEL** hitThing)
{
	return 0;
}


void AXON::MeshToStrips(C3D* m, sysVERTEX* v, SINT32 n)
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
	for (RSINT32 s=0; s<n; s++, m += (n+1), v += ((n<<1)+1) )
	{
		for (RSINT32 i=0; i<=n; i++)
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

#ifdef AXON_OPTIMISE_BY_POINTER

void AXON::WorldToView(VIEW& view, C3D* src, C3D* dst, SINT32 n)
{
	//  World to View == Z.X

	//    | x'|   | Vx |   |  (CZ.vf.zf)    -(SZ.vf.zf)     0          | | (x-Ox) |
	//    |   |   |    |   |                                           | |        |
	//    | y'| = | Vy | + |  (SX.SZ.vf.zf)  (SX.CZ.vf.zf) -(CX.vf.zf) | | (y-Oy) |
	//    |   |   |    |   |                                           | |        |
	//    | z'|   | Vz |   | -(CX.SZ.zf)    -(CX.CZ.zf)    -(SX.zf)    | | (z-Oz) |

	RFLOAT32 f0 = view.Origin().x;
	RFLOAT32 f1 = view.Origin().y;
	n++;
	while(--n)
	{
		RFLOAT32 f2	= *(((FLOAT32*)src)++) - f0; // x-Ox
		RFLOAT32 f3	= *(((FLOAT32*)src)++) - f1; // y-Oy
		RFLOAT32 f4 = *(((FLOAT32*)src)++);			 // z-Oz
		RFLOAT32 *r	= view.Matrix();

		*(((FLOAT32*)dst)++)	= *(r++) + f2*(*(r++)) + f3*(*(r++));
		*(((FLOAT32*)dst)++)	= *(r++) + f2*(*(r++)) + f3*(*(r++)) + f4*(*(r++));
		*(((FLOAT32*)dst)++)	= ClipFloat( (0.5F + f2*(*(r++)) + f3*(*(r++)) + f4*(*r)), 0F, 1F);
		*(((FLOAT32*)dst)++)	= *(((FLOAT32*)src)++);
		*(((FLOAT32*)dst)++)	= *(((FLOAT32*)src)++);
		*(((UINT32*)dst)++)		= *(((UINT32*)src)++);
	}
}

#else

void AXON::WorldToView(VIEW& view, C3D* src, C3D* dst, SINT32 n)
{
	//  World to View == Z.X

	//    | x'|   | Vx |   |  (CZ.vf.zf)     (SZ.vf.zf)     0          | | (x-Ox) |
	//    |   |   |    |   |                                           | |        |
	//    | y'| = | Vy | + | -(SX.SZ.vf.zf) -(SX.CZ.vf.zf) -(CX.vf.zf) | | (y-Oy) |
	//    |   |   |    |   |                                           | |        |
	//    | z'|   | Vz |   |  (CX.SZ.zf.zs)  (CX.CZ.zf.zs) -(SX.zf.zs) | | (z-Oz) |

	RFLOAT32 f0 = view.Origin().x;
	RFLOAT32 f1 = view.Origin().y;
	n++;
	while(--n)
	{
		RFLOAT32 f2	= src->x - f0; // x-Ox
		RFLOAT32 f3	= src->y - f1; // y-Oy
		RFLOAT32 f4 = src->z;			 // z-Oz
		RFLOAT32 *r	= view.Matrix();

		dst->x			= *(r++) + f2*(*(r++)) + f3*(*(r++));
		dst->y			= *(r++) + f2*(*(r++)) + f3*(*(r++)) + f4*(*(r++));
		dst->z			= ClipFloat( (0.5F + f2*(*(r++)) + f3*(*(r++)) + f4*(*r)), 0F, 1F);
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

#endif

// Project straight into sysVERTEX
void AXON::WorldToView(VIEW& view, C3D* src, sysVERTEX* dst, SINT32 n)
{
	RFLOAT32 f0 = view.Origin().x;
	RFLOAT32 f1 = view.Origin().y;
	n++;
	while(--n)
	{
		RFLOAT32 f2	= src->x - f0; // x-Ox
		RFLOAT32 f3	= src->y - f1; // y-Oy
		RFLOAT32 f4 = src->z;			 // z-Oz
		RFLOAT32 *r	= view.Matrix();

		dst->x			= *(r++) + f2*(*(r++)) + f3*(*(r++));
		dst->y			= *(r++) + f2*(*(r++)) + f3*(*(r++)) + f4*(*(r++));
		dst->z			= ClipFloat( (0.5F + f2*(*(r++)) + f3*(*(r++)) + f4*(*r)), 0F, 1F);
		dst->u			= src->u;
		dst->v			= src->v;
		ARGBtoCol((src++)->c, &((dst++)->color));
	}
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sysVERTEX* AXON::PushCoords(C3D* c, SINT32 n)
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

#define SX QSin(ax)
#define SY QSin(ay)
#define SZ QSin(az)
#define CX QCos(ax)
#define CY QCos(ay)
#define CZ QCos(az)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// SINGLE AXIS ROTATE : SOURCE --> SOURCE
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSX(C3D* src, SINT32 n, SINT16 ax)
{
	//  x-axis
	//
	//    | x'|   | 1  0   0  | | x |
	//    |   |   |           | |   |
	//    | y'| = | 0  CX  SX | | y |
	//    |   |   |           | |   |
	//    | z'|   | 0 -SX  CX | | z |
	RFLOAT32 ca = CX;
	RFLOAT32 sa = SX;
	n++;
	while(--n)
	{
		RFLOAT32 ty = src->y;
		RFLOAT32 tz = src->z;
		src->y			= ty*ca + tz*sa;
		(src++)->z	= tz*ca - ty*sa;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSY(C3D* src, SINT32 n, SINT16 ay)
{
	//  y-axis
	//
	//    | x'|   | CY  0  SY | | x |
	//    |   |   |           | |   |
	//    | y'| = | 0   1  0  | | y |
	//    |   |   |           | |   |
	//    | z'|   |-SY  0  CY | | z |
	RFLOAT32 ca = CY;
	RFLOAT32 sa = SY;
	n++;
	while(--n)
	{
		RFLOAT32 tx = src->x;
		RFLOAT32 tz = src->z;
		src->x			= tx*ca + tz*sa;
		(src++)->z	= tz*ca - tx*sa;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSZ(C3D* src, SINT32 n, SINT16 az)
{
	//  z-axis
	//
	//    | x'|   | CZ -SZ  0 | | x |
	//    |   |   |           | |   |
	//    | y'| = | SZ  CZ  0 | | y |
	//    |   |   |           | |   |
	//    | z'|   | 0   0   1 | | z |
	RFLOAT32 ca = CZ;
	RFLOAT32 sa = SZ;
	n++;
	while(--n)
	{
		RFLOAT32 tx = src->x;
		RFLOAT32 ty = src->y;
		src->x 			= tx*ca - ty*sa;
		(src++)->y 	= ty*ca + tx*sa;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// SINGLE AXIS ROTATE : SOURCE REL TO ORG --> SOURCE
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSX(VEC3D* org, C3D* src, SINT32 n, SINT16 ax)
{
	//  x-axis
	//
	//    | x'|   | 1  0   0  | | x |
	//    |   |   |           | |   |
	//    | y'| = | 0  CX  SX | | y |
	//    |   |   |           | |   |
	//    | z'|   | 0 -SX  CX | | z |
	RFLOAT32 y = org->y;
	RFLOAT32 z = org->z;
	RFLOAT32 ca = CX;
	RFLOAT32 sa = SX;
	n++;
	while(--n)
	{
		RFLOAT32 ty = src->y - y;
		RFLOAT32 tz = src->z - z;
		src->y			= y + ty*ca + tz*sa;
		(src++)->z	= z + tz*ca - ty*sa;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSY(VEC3D* org, C3D* src, SINT32 n, SINT16 ay)
{
	//  y-axis
	//
	//    | x'|   | CY  0  SY | | x |
	//    |   |   |           | |   |
	//    | y'| = | 0   1  0  | | y |
	//    |   |   |           | |   |
	//    | z'|   |-SY  0  CY | | z |
	RFLOAT32 x = org->x;
	RFLOAT32 z = org->z;
	RFLOAT32 ca = CY;
	RFLOAT32 sa = SY;
	n++;
	while(--n)
	{
		RFLOAT32 tx = src->x - x;
		RFLOAT32 tz = src->z - z;
		src->x			= x + tx*ca + tz*sa;
		(src++)->z	= z + tz*ca - tx*sa;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSZ(VEC3D* org, C3D* src, SINT32 n, SINT16 az)
{
	//  z-axis
	//
	//    | x'|   | CZ -SZ  0 | | x |
	//    |   |   |           | |   |
	//    | y'| = | SZ  CZ  0 | | y |
	//    |   |   |           | |   |
	//    | z'|   | 0   0   1 | | z |
	RFLOAT32 x = org->x;
	RFLOAT32 y = org->y;
	RFLOAT32 ca = CZ;
	RFLOAT32 sa = SZ;
	n++;
	while(--n)
	{
		RFLOAT32 tx = src->x - x;
		RFLOAT32 ty = src->y - y;
		src->x 			= x + tx*ca - ty*sa;
		(src++)->y 	= y + ty*ca + tx*sa;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// SINGLE AXIS ROTATE : SOURCE --> DEST
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDX(C3D* src, C3D* dst, SINT32 n, SINT16 ax)
{
	//  x-axis
	//
	//    | x'|   | 1  0   0  | | x |
	//    |   |   |           | |   |
	//    | y'| = | 0  CX  SX | | y |
	//    |   |   |           | |   |
	//    | z'|   | 0 -SX  CX | | z |
	RFLOAT32 ca = CX;
	RFLOAT32 sa = SX;
	n++;
	while(--n)
	{
		RFLOAT32 ty = src->y;
		RFLOAT32 tz = src->z;
		dst->x 			= src->x;
		dst->y 			= ty*ca + tz*sa;
		dst->z 			= tz*ca - ty*sa;
		dst->u 			= src->u;
		dst->v 			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDY(C3D* src, C3D* dst, SINT32 n, SINT16 ay)
{
	//  y-axis
	//
	//    | x'|   | CY  0  SY | | x |
	//    |   |   |           | |   |
	//    | y'| = | 0   1  0  | | y |
	//    |   |   |           | |   |
	//    | z'|   |-SY  0  CY | | z |
	RFLOAT32 ca = CY;
	RFLOAT32 sa = SY;
	n++;
	while(--n)
	{
		RFLOAT32 tx = src->y;
		RFLOAT32 tz = src->z;
		dst->x 			= tx*ca + tz*sa;
		dst->y 			= src->y;
		dst->z 			= tz*ca - tx*sa;
		dst->u 			= src->u;
		dst->v 			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDZ(C3D* src, C3D* dst, SINT32 n, SINT16 az)
{
	//  z-axis
	//
	//    | x'|   | CZ -SZ  0 | | x |
	//    |   |   |           | |   |
	//    | y'| = | SZ  CZ  0 | | y |
	//    |   |   |           | |   |
	//    | z'|   | 0   0   1 | | z |
	RFLOAT32 ca = CZ;
	RFLOAT32 sa = SZ;
	n++;
	while(--n)
	{
		RFLOAT32 tx = src->x;
		RFLOAT32 ty = src->y;
		dst->x			= tx*ca - ty*sa;
		dst->y			= ty*ca + tx*sa;
		dst->z			= src->z;
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// SINGLE AXIS ROTATE : SOURCE REL TO ORG --> DEST
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDX(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ax)
{
	//  x-axis
	//
	//    | x'|   | 1  0   0  | | x |
	//    |   |   |           | |   |
	//    | y'| = | 0  CX  SX | | y |
	//    |   |   |           | |   |
	//    | z'|   | 0 -SX  CX | | z |
	RFLOAT32 y = org->y;
	RFLOAT32 z = org->z;
	RFLOAT32 ca = CX;
	RFLOAT32 sa = SX;
	n++;
	while(--n)
	{
		RFLOAT32 ty = src->y - y;
		RFLOAT32 tz = src->z - z;
		dst->x			= src->x;
		dst->y			= y + ty*ca + tz*sa;
		dst->z			= z + tz*ca - ty*sa;
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDY(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ay)
{
	//  y-axis
	//
	//    | x'|   | CY  0  SY | | x |
	//    |   |   |           | |   |
	//    | y'| = | 0   1  0  | | y |
	//    |   |   |           | |   |
	//    | z'|   |-SY  0  CY | | z |
	RFLOAT32 x = org->x;
	RFLOAT32 z = org->z;
	RFLOAT32 ca = CY;
	RFLOAT32 sa = SY;
	n++;
	while(--n)
	{
		RFLOAT32 tx = src->y - x;
		RFLOAT32 tz = src->z - z;
		dst->x 			= x + tx*ca + tz*sa;
		dst->y 			= src->y;
		dst->z 			= z + tz*ca - tx*sa;
		dst->u 			= src->u;
		dst->v 			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDZ(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 az)
{
	//  z-axis
	//
	//    | x'|   | CZ -SZ  0 | | x |
	//    |   |   |           | |   |
	//    | y'| = | SZ  CZ  0 | | y |
	//    |   |   |           | |   |
	//    | z'|   | 0   0   1 | | z |
	RFLOAT32 x = org->x;
	RFLOAT32 y = org->y;
	RFLOAT32 ca = CZ;
	RFLOAT32 sa = SZ;
	n++;
	while(--n)
	{
		RFLOAT32 tx = src->x - x;
		RFLOAT32 ty = src->y - y;
		dst->x			= x + tx*ca - ty*sa;
		dst->y			= y + ty*ca + tx*sa;
		dst->z			= src->z;
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  MULTI AXIS ROTATE
//
//  Assuming were not using PPC, we need to create an array to hold the rotation axis elements.
//  We can optimise the function noting the following
//
//  1) Preload the sin/cos results into registers
//  2) Initialise the matrix on declaration using the register values, entering only non zero terms
//  3) The matrix elements are used sequentially, so prefer *(p++) over p[n] since this simplifies
//     the generated addressing modes
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// DOUBLE AXIS ROTATE : SOURCE --> SOURCE
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSXY(C3D* src, SINT32 n, SINT16 ax, SINT16 ay)
{
	//  x.y
	//
	//    | x'|   | CY    0   SY   | | x |
	//    |   |   |                | |   |
	//    | y'| = | SXSY  CX  SXCY | | y |
	//    |   |   |                | |   |
	//    | z'|   |-CXSY -SX  CXCY | | z |
	// set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f1 = SY;
	RFLOAT32 f3 = CX;	RFLOAT32 f4 = CY;
	FLOAT32  Rot[8] = { f4, /*0,*/  f1, f0*f1, f3, f0*f4, -f3*f1, -f0, f3*f4 };
	n++;
	while(--n)
	{
		f0 					= src->x;
		f1 					= src->y;
		f3					= src->z;
		RFLOAT32 *r = Rot;
		src->x			= f0*(*(r++)) + f3*(*(r++));
		src->y 			= f0*(*(r++)) + f1*(*(r++)) + f3*(*(r++));
		(src++)->z	= f0*(*(r++)) + f1*(*(r++)) + f3*(*r);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSXZ(C3D* src, SINT32 n, SINT16 ax, SINT16 az)
{
	//  x.z
	//
	//    | x'|   | CZ   -SZ    0  | | x |
	//    |   |   |                | |   |
	//    | y'| = | CXSZ  CXCZ  SX | | y |
	//    |   |   |                | |   |
	//    | z'|   | SXSZ -SXCZ  CX | | z |
	// set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f2 = SZ;
	RFLOAT32 f3 = CX;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[8] = {	f5, -f2, /*0,*/  f3*f2, f3*f5, f0, f0*f2, -f0*f5, f3 };
	n++;
	while(--n)
	{
		f0					= src->x;
		f2 					= src->y;
		f3					= src->z;
		RFLOAT32 *r = Rot;
		src->x			= f0*(*(r++)) + f2*(*(r++));
		src->y			= f0*(*(r++)) + f2*(*(r++)) + f3*(*(r++));
		(src++)->z	= f0*(*(r++)) + f2*(*(r++)) + f3*(*r);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSYZ(C3D* src, SINT32 n, SINT16 ay, SINT16 az)
{
	//  y.z
	//
	//    | x'|   | CYCZ -CYSZ  SY | | x |
	//    |   |   |                | |   |
	//    | y'| = | SZ    CZ    0  | | y |
	//    |   |   |                | |   |
	//    | z'|   |-SYCZ  SYSZ  CY | | z |

	// Set up the rotation matrix
	RFLOAT32 f1 = SY;	RFLOAT32 f2 = SZ;
	RFLOAT32 f4 = CY;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[8] = {	f4*f5, -f4*f2, f1, f2, f5, /*0,*/ -f1*f5, f1*f2, f4 };
	n++;
	while(--n)
	{
		f1					= src->x;
		f2					= src->y;
		f4					= src->z;
		RFLOAT32 *r = Rot;
		src->x			= f1*(*(r++)) + f2*(*(r++)) + f4*(*(r++));
		src->y			= f1*(*(r++)) + f2*(*(r++));
		(src++)->z	= f1*(*(r++)) + f2*(*(r++)) + f4*(*r);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// DOUBLE AXIS ROTATE : SOURCE --> DEST
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDXY(C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 ay)
{
	//  x.y
	//
	//    | x'|   | CY    0   SY   | | x |
	//    |   |   |                | |   |
	//    | y'| = | SXSY  CX  SXCY | | y |
	//    |   |   |                | |   |
	//    | z'|   |-CXSY -SX  CXCY | | z |
	// set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f1 = SY;
	RFLOAT32 f3 = CX;	RFLOAT32 f4 = CY;
	FLOAT32  Rot[8] = { f4, /*0,*/  f1, f0*f1, f3, f0*f4, -f3*f1, -f0, f3*f4 };
	n++;
	while(--n)
	{
		f0					= src->x;
		f1					= src->y;
		f3					= src->z;
		RFLOAT32 *r = Rot;
		dst->x			= f0*(*(r++)) + f3*(*(r++));
		dst->y			= f0*(*(r++)) + f1*(*(r++)) + f3*(*(r++));
		dst->z			= f0*(*(r++)) + f1*(*(r++)) + f3*(*r);
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDXZ(C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 az)
{
	//  x.z
	//
	//    | x'|   | CZ   -SZ    0  | | x |
	//    |   |   |                | |   |
	//    | y'| = | CXSZ  CXCZ  SX | | y |
	//    |   |   |                | |   |
	//    | z'|   | SXSZ -SXCZ  CX | | z |
	// set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f2 = SZ;
	RFLOAT32 f3 = CX;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[8] = {	f5, -f2, /*0,*/  f3*f2, f3*f5, f0, f0*f2, -f0*f5, f3 };
	n++;
	while(--n)
	{
		f0					= src->x;
		f2					= src->y;
		f3					= src->z;
		RFLOAT32 *r = Rot;
		dst->x			= f0*(*(r++)) + f2*(*(r++));
		dst->y			= f0*(*(r++)) + f2*(*(r++)) + f3*(*(r++));
		dst->z			= f0*(*(r++)) + f2*(*(r++)) + f3*(*r);
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDYZ(C3D* src, C3D* dst, SINT32 n, SINT16 ay, SINT16 az)
{
	//  y.z
	//
	//    | x'|   | CYCZ -CYSZ  SY | | x |
	//    |   |   |                | |   |
	//    | y'| = | SZ    CZ    0  | | y |
	//    |   |   |                | |   |
	//    | z'|   |-SYCZ  SYSZ  CY | | z |

	// Set up the rotation matrix
	RFLOAT32 f1 = SY;	RFLOAT32 f2 = SZ;
	RFLOAT32 f4 = CY;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[8] = {	f4*f5, -f4*f2, f1, f2, f5, /*0,*/ -f1*f5, f1*f2, f4 };
	n++;
	while(--n)
	{
		f1					= src->x;
		f2					= src->y;
		f4					= src->z;
		RFLOAT32 *r = Rot;
		dst->x			= f1*(*(r++)) + f2*(*(r++)) + f4*(*(r++));
		dst->y			= f1*(*(r++)) + f2*(*(r++));
		dst->z			= f1*(*(r++)) + f2*(*(r++)) + f4*(*r);
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// DOUBLE AXIS ROTATE : SOURCE REL TO ORG --> SOURCE
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSXY(VEC3D* org, C3D* src, SINT32 n, SINT16 ax, SINT16 ay)
{
	//  x.y
	//
	//    | x'|   | CY    0   SY   | | x |
	//    |   |   |                | |   |
	//    | y'| = | SXSY  CX  SXCY | | y |
	//    |   |   |                | |   |
	//    | z'|   |-CXSY -SX  CXCY | | z |
	// set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f1 = SY;
	RFLOAT32 f3 = CX;	RFLOAT32 f4 = CY;
	FLOAT32  Rot[8] = { f4, /*0,*/  f1, f0*f1, f3, f0*f4, -f3*f1, -f0, f3*f4 };
	f0					= org->x;
	f1					= org->y;
	RFLOAT32 f2 = org->z;
	n++;
	while(--n)
	{
		f3					= src->x-f0;
		f4					= src->y-f1;
		RFLOAT32 f5	= src->z-f2;
		RFLOAT32 *r = Rot;
		src->x			= f0 + f3*(*(r++)) + f5*(*(r++));
		src->y			= f1 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		(src++)->z	= f2 + f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSXZ(VEC3D* org, C3D* src, SINT32 n, SINT16 ax, SINT16 az)
{
	//  x.z
	//
	//    | x'|   | CZ   -SZ    0  | | x |
	//    |   |   |                | |   |
	//    | y'| = | CXSZ  CXCZ  SX | | y |
	//    |   |   |                | |   |
	//    | z'|   | SXSZ -SXCZ  CX | | z |
	// set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f2 = SZ;
	RFLOAT32 f3 = CX;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[8] = {	f5, -f2, /*0,*/  f3*f2, f3*f5, f0, f0*f2, -f0*f5, f3 };

	f0					= org->x;
	RFLOAT32 f1	= org->y;
	f2					= org->z;
	n++;
	while(--n)
	{
		f3					= src->x - f0;
		RFLOAT32 f4	= src->y - f1;
		f5					= src->z - f2;
		RFLOAT32 *r = Rot;
		src->x			= f0 + f3*(*(r++)) + f4*(*(r++));
		src->y			= f1 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		(src++)->z	= f2 + f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSYZ(VEC3D* org, C3D* src, SINT32 n, SINT16 ay, SINT16 az)
{
	//  y.z
	//
	//    | x'|   | CYCZ -CYSZ  SY | | x |
	//    |   |   |                | |   |
	//    | y'| = | SZ    CZ    0  | | y |
	//    |   |   |                | |   |
	//    | z'|   |-SYCZ  SYSZ  CY | | z |

	// Set up the rotation matrix
	RFLOAT32 f1 = SY;	RFLOAT32 f2 = SZ;
	RFLOAT32 f4 = CY;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[8] = {	f4*f5, -f4*f2, f1, f2, f5, /*0,*/ -f1*f5, f1*f2, f4 };
	RFLOAT32 f0	= org->x;
	f1					= org->y;
	f2					= org->z;
	n++;
	while(--n)
	{
		RFLOAT32 f3	= src->x - f0;
		f4					= src->y - f1;
		f5					= src->z - f2;
		RFLOAT32 *r = Rot;
		src->x			= f0 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		src->y			= f1 + f3*(*(r++)) + f4*(*(r++));
		(src++)->z	= f2 + f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// DOUBLE AXIS ROTATE : SOURCE REL TO ORG --> DEST
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDXY(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 ay)
{
	//  x.y
	//
	//    | x'|   | CY    0   SY   | | x |
	//    |   |   |                | |   |
	//    | y'| = | SXSY  CX  SXCY | | y |
	//    |   |   |                | |   |
	//    | z'|   |-CXSY -SX  CXCY | | z |
	// set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f1 = SY;
	RFLOAT32 f3 = CX;	RFLOAT32 f4 = CY;
	FLOAT32  Rot[8] = { f4, /*0,*/  f1, f0*f1, f3, f0*f4, -f3*f1, -f0, f3*f4 };

	f0					= org->x;
	f1					= org->y;
	RFLOAT32 f2	= org->z;
	n++;
	while(--n)
	{
		f3					= src->x - f0;
		f4					= src->y - f1;
		RFLOAT32 f5	= src->z - f2;
		RFLOAT32 *r = Rot;
		dst->x			= f0 + f3*(*(r++)) + f5*(*(r++));
		dst->y			= f1 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		dst->z			= f2 + f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDXZ(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 az)
{
	//  x.z
	//
	//    | x'|   | CZ   -SZ    0  | | x |
	//    |   |   |                | |   |
	//    | y'| = | CXSZ  CXCZ  SX | | y |
	//    |   |   |                | |   |
	//    | z'|   | SXSZ -SXCZ  CX | | z |
	// set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f2 = SZ;
	RFLOAT32 f3 = CX;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[8] = {	f5, -f2, /*0,*/  f3*f2, f3*f5, f0, f0*f2, -f0*f5, f3 };

	f0					= org->x;
	RFLOAT32 f1	= org->y;
	f2					= org->z;
	n++;
	while(--n)
	{
		f3					= src->x - f0;
		RFLOAT32 f4 = src->y - f1;
		f5					= src->z - f2;
		RFLOAT32 *r = Rot;
		dst->x			= f0 + f3*(*(r++)) + f4*(*(r++));
		dst->y			= f1 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		dst->z			= f2 + f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDYZ(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ay, SINT16 az)
{
	//  y.z
	//
	//    | x'|   | CYCZ -CYSZ  SY | | x |
	//    |   |   |                | |   |
	//    | y'| = | SZ    CZ    0  | | y |
	//    |   |   |                | |   |
	//    | z'|   |-SYCZ  SYSZ  CY | | z |

	// Set up the rotation matrix
	RFLOAT32 f1 = SY;	RFLOAT32 f2 = SZ;
	RFLOAT32 f4 = CY;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[8] = {	f4*f5, -f4*f2, f1, f2, f5, /*0,*/ -f1*f5, f1*f2, f4 };
	RFLOAT32 f0	= org->x;
	f1					= org->y;
	f2					= org->z;
	n++;
	while(--n)
	{
		RFLOAT32 f3	= src->x - f0;
		f4					= src->y - f1;
		f5					= src->z - f2;
		RFLOAT32 *r = Rot;
		dst->x			= f0 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		dst->y			= f1 + f3*(*(r++)) + f4*(*(r++));
		dst->z			= f2 + f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
		dst->u			= src->u;
		dst->v			= src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// TRIPLE AXIS ROTATE : SOURCE --> SOURCE
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSXYZ(C3D* src, SINT32 n, SINT16 ax, SINT16 ay, SINT16 az)
{
	//  x.y.z, derived as (x.y).z
	//
	//    | x'|   | CYCZ        -CYSZ         SY   | | x |
	//    |   |   |                                | |   |
	//    | y'| = | SXSYCZ+CXSZ -SXSYSZ+CXCZ  SXCY | | y |
	//    |   |   |                                | |   |
	//    | z'|   |-CXSYCZ-SXSZ  CXSYSZ-SXCZ  CXCY | | z |

	// Set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f1 = SY;	RFLOAT32 f2 = SZ;
	RFLOAT32 f3 = CX;	RFLOAT32 f4 = CY;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[9] = {	f4*f5,								-(f4*f2),						f1,
											f0*f1*f5 + f3*f2,			f3*f5 - (f0*f1*f2),	f0*f4,
											-(f3*f1*f5 + f0*f2),	f3*f1*f2 - (f0*f5),	f3*f4	};
	n++;
	while(--n)
	{
		f3					= src->x;
		f4					= src->y;
		f5					= src->z;
		RFLOAT32 *r = Rot;
		src->x			= f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		src->y			= f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		(src++)->z	= f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// TRIPLE AXIS ROTATE : SOURCE --> DEST
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDXYZ(C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 ay, SINT16 az)
{
	//  x.y.z, derived as (x.y).z
	//
	//    | x'|   | CYCZ        -CYSZ         SY   | | x |
	//    |   |   |                                | |   |
	//    | y'| = | SXSYCZ+CXSZ -SXSYSZ+CXCZ  SXCY | | y |
	//    |   |   |                                | |   |
	//    | z'|   |-CXSYCZ-SXSZ  CXSYSZ-SXCZ  CXCY | | z |

	// Set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f1 = SY;	RFLOAT32 f2 = SZ;
	RFLOAT32 f3 = CX;	RFLOAT32 f4 = CY;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[9] = {	f4*f5,								-(f4*f2),						f1,
											f0*f1*f5 + f3*f2,			f3*f5 - (f0*f1*f2),	f0*f4,
											-(f3*f1*f5 + f0*f2),	f3*f1*f2 - (f0*f5),	f3*f4	};
	n++;
	while(--n)
	{
		f3 = src->x;	f4 = src->y;	f5 = src->z;
		RFLOAT32 *r = Rot;
		dst->x = f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		dst->y = f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		dst->z = f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
		dst->u = src->u;
		dst->v = src->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// TRIPLE AXIS ROTATE : SOURCE REL TO ORG --> SOURCE
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSXYZ(VEC3D* org, C3D* src, SINT32 n, SINT16 ax, SINT16 ay, SINT16 az)
{
	//  x.y.z, derived as (x.y).z
	//
	//    | x'|   | CYCZ        -CYSZ         SY   | | x |
	//    |   |   |                                | |   |
	//    | y'| = | SXSYCZ+CXSZ -SXSYSZ+CXCZ  SXCY | | y |
	//    |   |   |                                | |   |
	//    | z'|   |-CXSYCZ-SXSZ  CXSYSZ-SXCZ  CXCY | | z |

	// Set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f1 = SY;	RFLOAT32 f2 = SZ;
	RFLOAT32 f3 = CX;	RFLOAT32 f4 = CY;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[9] = {	f4*f5,								-(f4*f2),						f1,
											f0*f1*f5 + f3*f2,			f3*f5 - (f0*f1*f2),	f0*f4,
											-(f3*f1*f5 + f0*f2),	f3*f1*f2 - (f0*f5),	f3*f4	};

	f0 = org->x;	f1 = org->y;	f2 = org->z;
	n++;
	while(--n)
	{
		f3 = src->x - f0;	f4 = src->y - f1;	f5 = src->z - f2;
		RFLOAT32 *r = Rot;
		src->x			= f0 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		src->y 			= f1 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		(src++)->z	= f2 + f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// TRIPLE AXIS ROTATE : SOURCE REL TO ORG --> DEST
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void AXON::RotSDXYZ(VEC3D* org, C3D* src, C3D* dst, SINT32 n, SINT16 ax, SINT16 ay, SINT16 az)
{
	//  x.y.z, derived as (x.y).z
	//
	//    | x'|   | CYCZ        -CYSZ         SY   | | x |
	//    |   |   |                                | |   |
	//    | y'| = | SXSYCZ+CXSZ -SXSYSZ+CXCZ  SXCY | | y |
	//    |   |   |                                | |   |
	//    | z'|   |-CXSYCZ-SXSZ  CXSYSZ-SXCZ  CXCY | | z |

	// Set up the rotation matrix
	RFLOAT32 f0 = SX;	RFLOAT32 f1 = SY;	RFLOAT32 f2 = SZ;
	RFLOAT32 f3 = CX;	RFLOAT32 f4 = CY;	RFLOAT32 f5 = CZ;
	FLOAT32  Rot[9] = {	f4*f5,								-(f4*f2),						f1,
											f0*f1*f5 + f3*f2,			f3*f5 - (f0*f1*f2),	f0*f4,
											-(f3*f1*f5 + f0*f2),	f3*f1*f2 - (f0*f5),	f3*f4	};

	f0 = org->x;	f1 = org->y;	f2 = org->z;
	n++;
	while(--n)
	{
		f3 = src->x-f0;	f4 = src->y-f1;	f5 = src->z-f2;
		RFLOAT32 *r = Rot;
		dst->x = f0 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		dst->y = f1 + f3*(*(r++)) + f4*(*(r++)) + f5*(*(r++));
		dst->z = f2 + f3*(*(r++)) + f4*(*(r++)) + f5*(*r);
		dst->u = src->u;
		dst->v = dst->v;
		(dst++)->c	= (src++)->c;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#undef SX
#undef SY
#undef SZ
#undef CX
#undef CY
#undef CZ

#undef MAX_GRAD
