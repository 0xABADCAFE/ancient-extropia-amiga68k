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

		1) Implement multiple object support (array of MODEL* ?)
		2) Implement MAPCELL mesh support & geometry level of detail

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

//C3D& tl, C3D& tr, C3D& br, C3D& bl, uint32 c, xTEXTURE* t, xTEXTURE* d

void MAPCELL::Set(C3D& tl, C3D& tr, C3D& br, C3D& bl, uint32 c, xTEXTURE* t, xTEXTURE* d)
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

	plane[0].Define(tl, bl, tr);
	plane[1].Define(br, tr, bl);

	tex = t->TexHandle();
	detail = d->TexHandle();
	for(sint32 i=0; i < 5; i++)
	{
		if (data[i].z < WORLDMAP::SeaLevel())
			flags |= WATER;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 MAPCELL::FindPlane(const VEC3D& p)
{
	if (p.x < data[1].x || p.y > data[1].y || p.x > data[4].x || p.y < data[4].y)
	{
		puts("MAPCELL::FindPlane() : Point outside cell");
		return ERR_VALUE;
	}
	// Since square cell, x/y plane gradient always 1.
	return (p.y-data[4].y) < (p.x-data[1].x) ? 1 : 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 MAPCELL::DropToFloor(VEC3D& c)
{
	// Which plane is c over, if any ?
	sint32 p = FindPlane(c);
	if (p!=ERR_VALUE)
	{
		plane[p].ZForXY(c);
		return OK;
	}
	else
		return ERR_VALUE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 MAPCELL::Topology()
{
	float32 z_average = (data[1].z + data[2].z + data[3].z + data[4].z)/4F;
	float32 dz = fabs(data[1].z-z_average) + fabs(data[2].z-z_average)
						 + fabs(data[3].z-z_average) + fabs(data[4].z-z_average);
	return dz/4F;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool MAPCELL::AddThing(MODEL& t, float32 px, float32 py, float32 s, sint16 rx, sint16 ry, sint16 rz)
{
	if (thing || flags & WATER)
		return false;

	thing = &t;
	// position relative to bottom left of cell and clamp range to cell size

	VEC3D newpos(ClipFloat(px+data[1].x, data[1].x, data[4].x), ClipFloat(py+data[4].y, data[4].y, data[1].y), 0);

	// set positon to cell surface
	DropToFloor(newpos);
	// place the object
	t.Place(newpos, s, rx, ry, rz);
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool MAPCELL::Visibility(VIEW& view)
{
	flags &= ~VIS;

	sint16 numVerts = (flags & WATER) ? (2*points)+4 : (2*points);
	float32 c = QTRIG::CosI(view.Pitch());

	// Evaluates if any of the clip points of the MAPCELL fall into the projected VIEW
	if (view.State(VIEW::BOUNDS_PERP))
	{
		// simple test since boundary is colinear with map
		rsint32 i = 0;
		while (++i<5)
		{
			rfloat32 x = data[i].x;
			rfloat32 y = data[i].y;// + c*data[i].z;
			if (x >= view.BTL().x && y <= view.BTL().y && x <= view.BBR().x && y >= view.BBR().y)
			{
				flags |= VIS;
				#ifdef CLIPSTATS
				centreClips++;
				#endif
				projected = CachedVertices(numVerts);
				return true;
			}
		}
		projected = 0;
		return false;
	}
	else
	{
		// does projected view corner overlap an edge of the cell ?

		register VEC3D* vp = view.projected;
		{
			rsint32 i = 0;
			while (i<4)
			{
				if (vp[i].x >= data[1].x && vp[i].y <= data[1].y && vp[i].x <= data[4].x && vp[i].y >= data[4].y)
				{
					#ifdef CLIPSTATS
					edgeClips++;
					#endif
					flags |= VIS;
					projected = CachedVertices(numVerts);
					return true;
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

		rfloat32 pp = QTRIG::CotI(view.vA);
		rfloat32 pl = QTRIG::TanI(view.vA);
		if (view.vA < 90) // 1st quarter
		{
			rsint32 i = 0;
			while (i<5)
			{
				rfloat32 x = data[i].x; rfloat32 y = data[i].y;// + c*data[1].z;
				rfloat32 yTest = vp[0].y+(x-vp[0].x)*pl;	// Py <= A1'(Px)
				if (y <= yTest)
				{
					yTest = vp[0].y+(x-vp[0].x)*pp;					// Py >= A1"(Px)
					if (y >= yTest)
					{
						yTest = vp[2].y+(x-vp[2].x)*pl;				// Py >= A2'(Px)
						if (y >= yTest)
						{
							yTest = vp[2].y+(x-vp[2].x)*pp;			// Py <= A2"(Px)
							if (y <= yTest)
							{
								flags |= VIS;
								#ifdef CLIPSTATS
								if (i)
									cornerClips++;
								else
									centreClips++;
								#endif
								projected = CachedVertices(numVerts);
								return true;
							}
						}
					}
				}
				i++;
			}
			projected = 0;
			return false;
		}
		else if (view.vA < 180) // 2nd quarter
		{																					// When 90 < vA < 180
			rsint32 i = 0;
			while (i<5)
			{
				rfloat32 x = data[i].x; rfloat32 y = data[i].y;// + c*data[1].z;
				rfloat32 yTest = vp[0].y+(x-vp[0].x)*pl;	// Py >= A1'(Px)
				if (y >= yTest)
				{
					yTest = vp[0].y+(x-vp[0].x)*pp;					// Py >= A1"(Px)
					if (y >= yTest)
					{
						yTest = vp[2].y+(x-vp[2].x)*pl;				// Py <= A2'(Px)
						if (y <= yTest)
						{
							yTest = vp[2].y+(x-vp[2].x)*pp;			// Py <= A2"(Px)
							if (y <= yTest)
							{
								flags |= VIS;
								#ifdef CLIPSTATS
								if (i)
									cornerClips++;
								else
									centreClips++;
								#endif
								projected = CachedVertices(numVerts);
								return true;
							}
						}
					}
				}
				i++;
			}
			projected = 0;
			return false;
		}
		else if (view.vA < 270) // 3rd quarter
		{
			rsint32 i = 0;
			while (i<5)
			{
				rfloat32 x = data[i].x; rfloat32 y = data[i].y;/// + c*data[1].z;
				rfloat32 yTest = vp[0].y+(x-vp[0].x)*pl;	// Py >= A1'(Px)
				if (y >= yTest)
				{
					yTest = vp[0].y+(x-vp[0].x)*pp;					// Py <= A1"(Px)
					if (y <= yTest)
					{
						yTest = vp[2].y+(x-vp[2].x)*pl;				// Py <= A2'(Px)
						if (y <= yTest)
						{
							yTest = vp[2].y+(x-vp[2].x)*pp;			// Py >= A2"(Px)
							if (y >= yTest)
							{
								flags |= VIS;
								#ifdef CLIPSTATS
								if (i)
									cornerClips++;
								else
									centreClips++;
								#endif
								projected = CachedVertices(numVerts);
								return true;
							}
						}
					}
				}
				i++;
			}
			projected = 0;
			return false;
		}
		else if (view.vA < 360) // 4th quarter
		{
			rsint32 i = 0;
			while (i<5)
			{
				rfloat32 x = data[i].x; rfloat32 y = data[i].y;// + c*data[1].z;
				rfloat32 yTest = vp[0].y+(x-vp[0].x)*pl;	// Py <= A1'(Px)
				if (y <= yTest)
				{
					yTest = vp[0].y+(x-vp[0].x)*pp;					// Py <= A1"(Px)
					if (y <= yTest)
					{
						yTest = vp[2].y+(x-vp[2].x)*pl;				// Py >= A2'(Px)
						if (y >= yTest)
						{
							yTest = vp[2].y+(x-vp[2].x)*pp;			// Py >= A2"(Px)
							if (y >= yTest)
							{
								flags |= VIS;
								#ifdef CLIPSTATS
								if (i)
									cornerClips++;
								else
									centreClips++;
								#endif
								projected = CachedVertices(numVerts);
								return true;
							}
						}
					}
				}
				i++;
			}
			projected = 0;
			return false;
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MAPCELL::Display(VIEW& view)
{
	register sysVERTEX* vt = Vertices(4);
	{
		rfloat32 scaleF = view.width/WORLDMAP::Scale();
		rfloat32 offset = (view.height-view.width)/2F;
		vt[0].x=scaleF*data[1].x;		vt[0].y=scaleF*(WORLDMAP::Scale()-data[1].y)+offset;		vt[0].z=0;
		vt[1].x=scaleF*data[2].x;		vt[1].y=scaleF*(WORLDMAP::Scale()-data[2].y)+offset;		vt[1].z=0;
		vt[2].x=scaleF*data[3].x;		vt[2].y=scaleF*(WORLDMAP::Scale()-data[3].y)+offset;		vt[2].z=0;
		vt[3].x=scaleF*data[4].x;		vt[3].y=scaleF*(WORLDMAP::Scale()-data[4].y)+offset;		vt[3].z=0;
	}
	{
		ruint32 c = (data[0].c & 0x00FFFFFF)|0xA0000000;
		SetColour(c);
		TriStrip(vt,4);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MAPCELL::Render(VIEW& view)
{
	if (!projected)
	{
		puts("Error : MAPCELL::Render() no points allocated");
		return;
	}
	// Only recalculate if view has changed
	if (view.State(VIEW::CHANGED))
	{
		view.Transform(data+1, projected, points);
		{
			C3D d[4] = {
				C3D(data[1].x, data[1].y, WORLDMAP::SeaLevel(), 0,	0,	0xFFFFFFFF),
				C3D(data[2].x, data[2].y, WORLDMAP::SeaLevel(), 0,	128,	0xFFFFFFFF),
				C3D(data[3].x, data[3].y, WORLDMAP::SeaLevel(), 128,	0,	0xFFFFFFFF),
				C3D(data[4].x, data[4].y, WORLDMAP::SeaLevel(), 128,	128,	0xFFFFFFFF)
			};
			view.Transform(d, (projected+(2*points)), 4);
		}
	}
/*
	else if (flags & RETEX)
	{
		sysVERTEX* d = projected; C3D* s = data+1;
		flags &= ~RETEX;
		d->u = s->u;		(d++)->v = (s++)->v;
		d->u = s->u;		(d++)->v = (s++)->v;
		d->u = s->u;		(d++)->v = (s++)->v;
		d->u = s->u;		(d++)->v = (s++)->v;
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
		uint32* src = (uint32*)projected;
		uint32* dst = (uint32*)(projected+points);
		sint32 n = 1+points*(sizeof(sysVERTEX)/sizeof(uint32));
		while (--n)
			*(dst++) = *(src++);
	}

	rfloat32 a = 1.66F*(WORLDMAP::LOD()-0.4F);
	sysVERTEX* t = projected+points;
	{
		t[0].u = 0;					t[0].v = 0;					t[0].color.a = a;
		t[1].u = 0;					t[1].v = data[0].v;	t[1].color.a = a;
		t[2].u = data[0].u;	t[2].v = 0;					t[2].color.a = a;
		t[3].u = data[0].u;	t[3].v = data[0].v;	t[3].color.a = a;
	}
	//	flags |= RETEX;
	TriStripTx(projected+points, points, detail);
}