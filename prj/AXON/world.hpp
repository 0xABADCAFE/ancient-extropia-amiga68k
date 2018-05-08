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
#error You must include axon.hpp
#endif

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  MAPCELL::
//
//  Basic Rendering unit. This is only the prototype. Will be much expanded later, using level of detail meshing,
//  multitexturing etc.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MODEL;
class MAPCELL : protected AXON {

	private:
		uint32				flags;
		sint32				points;			// expand me
		W3D_Vertex*		projected;
		MODEL*				thing;			// expand me

		// expand me
		W3D_Texture*	tex;
		W3D_Texture*	detail;

		// expand me
		C3D						data[5];
		PLANE					plane[2];

		MAPCELL*			neighbour[8];
		enum {
			TL_VIS	=	0x00000001,
			TR_VIS	= 0x00000002,
			BR_VIS	= 0x00000004,
			BL_VIS	= 0x00000008,
			VIS			= 0x0000000F,
			WATER		= 0x00000010,
			RETEX		= 0x00000020,
			NOTEX		= 0x00000040
		};
		sint32 FindPlane(const VEC3D& p);

	public:
		void Set(C3D& tl, C3D& tr, C3D& br, C3D& bl, uint32 c, xTEXTURE* t, xTEXTURE* d);
		float32	Topology(); // evaluates a cell complexity based on four corners

		bool AddThing(MODEL& t, float32 px, float32 py, float32 s, sint16 rx=0, sint16 ry=0, sint16 rz=0);

	public:
		C3D& 	CT()	{ return data[0]; }
		C3D&	TL()	{ return data[1]; }
		C3D&	TR()	{ return data[3]; }
		C3D&	BR()	{ return data[4]; }
		C3D&	BL()	{ return data[2]; }

		sint32 DropToFloor(VEC3D& c); // adjusts c's z component to touch the surface if c.x & c.y within the cell

		void LinkABLF(MAPCELL* m)	{ neighbour[0]=m; }
		void LinkAB(MAPCELL* m)		{ neighbour[1]=m; }
		void LinkABRT(MAPCELL* m)	{ neighbour[2]=m; }
		void LinkRT(MAPCELL* m)		{ neighbour[3]=m; }
		void LinkBLRT(MAPCELL* m)	{ neighbour[4]=m; }
		void LinkBL(MAPCELL* m)		{ neighbour[5]=m; }
		void LinkBLLF(MAPCELL* m)	{ neighbour[6]=m; }
		void LinkLF(MAPCELL* m)		{ neighbour[7]=m; }
		MAPCELL* NbrABLF()	{ return neighbour[0]; }
		MAPCELL* NbrAB()		{ return neighbour[1]; }
		MAPCELL* NbrABRT()	{ return neighbour[2]; }
		MAPCELL* NbrRT()		{ return neighbour[3]; }
		MAPCELL* NbrBLRT()	{ return neighbour[4]; }
		MAPCELL* NbrBT()		{ return neighbour[5]; }
		MAPCELL* NbrBTLF()	{ return neighbour[6]; }
		MAPCELL* NbrLF()		{ return neighbour[7]; }

	public:
		bool		Visibility(VIEW& v);	// Retests visibility
		bool		Visible(VIEW& v);			// returns TRUE if overlaps projected viewport
		void		Display(VIEW& v);			// displays cell in viewport
		void		Render(VIEW& v);			// renders cell
		void		Detail();							// renders detail, use AFTER Render();
		void		WaterSurf();					// renders water texture
		bool		Wet()							{ return flags & WATER; }
		MODEL*	Thing()						{ return thing; }

		MAPCELL();
		~MAPCELL();
};

inline bool MAPCELL::Visible(VIEW& v)
{
	if (!v.State(VIEW::CHANGED))
		return flags & VIS;
	else
		return Visibility(v);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  WORLDMAP::
//
//  Implements a 2D array of MAPCELLs. Each cell is linked to all of its immediate neighbours.
//  Implements main rendering routine, used to generate an image in the specific VIEW
//  Provides a vertex cache that allows transformed verticies to be continuously reused as long as the
//  view is unchanging
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define MAX_VIS_MODELS	 2047UL

#define MAX_WATER_TEXTURES	8
#define MAX_GROUND_TEXTURES	16

class MODEL;

class WORLDMAP : protected AXON {

	private:
		// Fundamental properties
		static uint32				dimension;		// cells to map edge, equivalent to 2^logDim
		static uint32				logDim;
		static float32			fracLimit;		// surface generation fracture limit
		static C3D*					worldGrid;		// temporary fracture surface
		static float32			minZ, maxZ;		// World height extrema
		static float32			floodLevel;		// World water level

		// Abstract properties
		static float32			scale;				// World scale value
		static char*				unitName;			// World scale unit name (eg 'metres', 'kilometres', etc)
		static float32			detailLevel;

		// Data
		static MAPCELL*			cell;					// World MAPCELL array
		static MAPCELL**		visible;			// render list for currently visible cells
		static MAPCELL**		wet;					// as above for cells with water
		static MODEL**			things;				// as above for objects

		// Performance
		static uint32				frames;
		static uint32				frameTime;
		static uint32				totalTime;
		static MILLICLOCK		stopWatch;

		// Graphics
		static xTEXTURE*		ground[MAX_GROUND_TEXTURES];
		static xTEXTURE*		water[MAX_WATER_TEXTURES];

	private:
		static void					GeneratePoints();
		static sint32				LinkCells();
		static C3D&					Junction(ruint16 i, ruint16 j)	{ return worldGrid[(j*(dimension+1))+i]; }

	public:
		static void					FreeVertices()									{ vCachePtr = 0;}
		static sysTEXTURE*	WaterTex()											{ return water[frames&(MAX_WATER_TEXTURES-1)]->TexHandle(); }
		static float32			WaterSize()											{ return 4F*water[0]->Width(); }
		static float32			Scale()													{ return scale; }
		static char*				UnitName()											{ return unitName; }

	public:
		static sint32				Init(uint32 d, float32 ws, float32 fr, float32 zmn, float32 zmx, char* uName);
		static sint32				Done();
		static float32			LOD()														{ return detailLevel; }
		static float32			MinWZ() 												{ return minZ; }
		static float32			MaxWZ() 												{ return maxZ; }
		static float32			RangeWZ()												{ return maxZ - minZ; }
		static MAPCELL& 		Cell(ruint16 i, ruint16 j)			{ return cell[(j*dimension)+i]; }
		static sint32				Clip(VIEW& v);
		static uint32				Render(VIEW& v);
		static float32			MaxZoom()												{ return 0.75*dimension; }
		static float32			MinZoom()												{ return 0.0625*dimension; }
		static float32			SeaLevel()											{ return floodLevel; }
		static void					DisplayStats(VIEW& v);
		static uint32				Frames()												{ return frames; }
		static uint32				FrameTime()											{ return frameTime; }
		static float32			AvgFrameTime()									{ return (float32)totalTime/(float32)frames; }
};
