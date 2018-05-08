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

#include <stdlib.h>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  TO DO
//
//  Clean up WORLDMAP code
//	Add load save support
//
//	Implement MAPCELL meshing based on that for WORLDMAP, base Render() call on that
//	Implement MAPCELL unique texturing
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  WORLDMAP::
//
//  Basis of game world
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32			WORLDMAP::dimension 	= 0;
uint32			WORLDMAP::logDim			= 0;
float32			WORLDMAP::fracLimit		= 0F;
C3D*				WORLDMAP::worldGrid		= 0;
float32			WORLDMAP::minZ				= -0.1F;
float32			WORLDMAP::maxZ				= 0.1F;
float32			WORLDMAP::floodLevel	= 0F;

float32			WORLDMAP::scale				= 1F;
char*				WORLDMAP::unitName		= 0;
float32			WORLDMAP::detailLevel = 0F;

uint32			WORLDMAP::frames			= 0;
uint32			WORLDMAP::frameTime		= 0;
uint32			WORLDMAP::totalTime		= 0;
MILLICLOCK	WORLDMAP::stopWatch;

MAPCELL*		WORLDMAP::cell				= 0;
MAPCELL**		WORLDMAP::visible			= 0;
MAPCELL**		WORLDMAP::wet					= 0;
MODEL**			WORLDMAP::things			= 0;

xTEXTURE*		WORLDMAP::ground[MAX_GROUND_TEXTURES]	= {0};
xTEXTURE*		WORLDMAP::water[MAX_WATER_TEXTURES]		= {0};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
sint32 WORLDMAP::Init(uint32 dim, float32 s, float32 fracture, float32 zmin, float32 zmax, char* uName)
{
	// Allocates 2^dim * 2^dim cells
	// Specifies each cells' location
	// defines each cells neighbouring links

	if (uName)
		unitName = uName;
	if (s > 0)
		scale = s;

	minZ			 = ClipFloat(-(scale/2F), 0F, zmin);
	maxZ			 = ClipFloat(0F, (scale/2F), zmax);
	logDim		 = ClipInt(dim, 1, 8); // 8 is big....Very Big ! (256*256)
	fracLimit	 = ClipFloat(fracture, 0F, scale/20F);

	printf("WORLDMAP::Init() : Initialising resources...");
	{
		// char groundName[] = "data/ground00.ppm";
		ground[0] = TEXTUREHEAP::UsePPM("data/ground.ppm");
		if (!ground[0])
		{
			puts("Error reading texture");
			Done();
			return ERR_RSC;
		}
		else
		{
			ground[0]->SetEnv(xTEXTURE::MODULATE);
			ground[0]->SetFilter(xTEXTURE::LINEAR);
		}
	}

	{
		char waterName[] = "data/rip0.tex";
		for (sint32 i = 0; i < 8; i++)
		{
			sprintf(waterName, "data/rip%d.tex", i);
			water[i] = TEXTUREHEAP::UseTex(waterName);
			if (!water[i])
			{
				printf("Error reading texture %s\n", waterName);
				Done();
			}
			else
			{
				water[i]->SetEnv(xTEXTURE::MODULATE);
				water[i]->SetFilter(xTEXTURE::LINEAR);
			}
		}
	}

	dimension = 1<<logDim;

	cell = New(cell, dimension*dimension);
	if (!cell)
	{
		Done();
		return ERR_NO_FREE_STORE;
	}

	// Allocate space for 2 NTA of MAPCELL pointers
	visible = New(visible, (2*dimension*dimension)+2);
	if (!visible)
	{
		Done();
		return ERR_NO_FREE_STORE;
	}
	wet = visible + (dimension*dimension)+1;

	// Allocate space of NTA of MODEL pointers
	things = New(things, MAX_VIS_MODELS+1);
	if (!things)
	{
		Done();
		return ERR_NO_FREE_STORE;
	}

	// Allocate a temporary world grid. This is then fractured and used to define all the cells in the map
	worldGrid = New(worldGrid, (dimension+1)*(dimension+1));
	if (!worldGrid)
	{
		Done();
		return ERR_NO_FREE_STORE;
	}

	MEM::Zero(worldGrid, (dimension+1)*(dimension+1)*sizeof(C3D));

	puts("done");

	{
		printf("WORLDMAP::Init() : Generating surface...");
		GeneratePoints();
		for (sint32 j=0; j<dimension; j++)
		{
			for (sint32 i=0; i<dimension; i++)
			{
				// go for checkerboard pattern
				ruint32 c = (i&1) ? ((j&1) ? 0xFF808080:0xFFFFFFFF) : ((j&1) ? 0xFFFFFFFF:0xFF808080);
				sint32 bl = i+(j*(dimension+1));
				sint32 tl = i+((j+1)*(dimension+1));
				Cell(i,j).Set(worldGrid[tl], worldGrid[tl+1], worldGrid[bl+1], worldGrid[bl], c, ground[0], ground[0]);
			}
		}
		puts("done");
	}

	// No longer need the grid since cells now contain the data
	Delete(worldGrid);
	worldGrid = 0;

	// Link cells to neighbours
	printf("WORLDMAP::Init() : Linking cells...");
	LinkCells();
	puts("done");
	return OK;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 WORLDMAP::Done()
{
	{
		for (sint32 i = 0; i < MAX_GROUND_TEXTURES; i++)
			if (ground[i]) ground[i]->Delete();
	}
	{
		for (sint32 i = 0; i < MAX_WATER_TEXTURES; i++)
			if (water[i]) water[i]->Delete();
	}

	if (cell)
		Delete(cell);
	if (visible)
		Delete(visible);
	if (things)
		Delete(things);
	if (worldGrid)
		Delete(worldGrid);
	cell			= 0;
	visible		= 0;
	wet				= 0;
	things		= 0;
	worldGrid	= 0;
	dimension = 0;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void WORLDMAP::GeneratePoints()
{
	// Define grid
	sint32 i, j;

	#define FRACTURE (fracLimit*(((float32)rand()/RAND_MAX)-0.5F))

	// Set random corner heights
	Junction(0,0).z									= FRACTURE;
	Junction(0,dimension).z					= FRACTURE;
	Junction(dimension,0).z					= FRACTURE;
	Junction(dimension,dimension).z	= FRACTURE;

	float32 minF = 0;
	float32 maxF = 0;

	// Fracture grid junctions
  for (sint32 pass=logDim; pass >= 0; pass--)
  {
    sint32 o = (1<<pass);
    for (j = 0; j < dimension; j += o)
    {
      for (i = 0; i < dimension; i += o)
      {
        sint32 di = i&((1<<(pass+1))-1);
        sint32 dj = j&((1<<(pass+1))-1);
        if (!((di == 0) && (dj == 0)))
        {
          if (di == 0)
          {
            rfloat32 average = (Junction(i, j+o).z + Junction(i, j-o).z)/2F;
            average += FRACTURE;
						if (average < minF)
							minF = average;
						else if (average > maxF)
							maxF = average;
						Junction(i,j).z = ClipFloat(average, minZ, maxZ);
          }
          else if (dj == 0)
          {
            rfloat32 average = (Junction(i+o, j).z + Junction(i-o, j).z)/2F;
            average += FRACTURE;
						if (average < minF)
							minF = average;
						else if (average > maxF)
							maxF = average;
						Junction(i,j).z = ClipFloat(average, minZ, maxZ);
          }
          else if (di && dj)
          {
            rfloat32 average = Junction(i+o, j+o).z + Junction(i+o, j-o).z
														 + Junction(i-o, j+o).z + Junction(i-o, j-o).z;
						average /= 4F;
						average += FRACTURE;
						if (average < minF)
							minF = average;
						else if (average > maxF)
							maxF = average;
						Junction(i,j).z = ClipFloat(average, minZ, maxZ);
          }
        }
      }
    }
  }
	#undef FRACTURE

	{
		float32	d = scale/dimension;
		float32	x, y;
		float32 txScale = (ground[0]->Width() < ground[0]->Height()) ? ground[0]->Height() : ground[0]->Width();
		txScale /= scale;
		for (j=0, y=0; j<=dimension; j++, y+=d)
		{
			for (i=0, x=0.0; i<=dimension; i++, x+=d)
			{
				sint32 m = i+(j*(dimension+1));
				worldGrid[m].x = x;
				worldGrid[m].y = y;

				// TO DO : Real lighting. This is **LAME**

				uint32 c = (uint32)(200F*(worldGrid[m].z-minF)/(maxF-minF))+50;

				worldGrid[m].c = 0xFF | c<<16 | c<<8 | c;
				worldGrid[m].u = 8F*x*txScale;
				worldGrid[m].v = 8F*y*txScale;
			}
		}
	}

	// Rescale the world minimum/maximum z to allow for better object height adjustment
	minZ = minF*1.05F;
	maxZ = maxF*1.10F;

	// TO DO : User defined sea level
	floodLevel = (maxZ + (3F*minZ))/3F;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 WORLDMAP::LinkCells()
{
	//  Do cell linkage. Cells are linked to their neighbours as follows
	//
	//    Body     Edge     Corner
	//
	//    A B C    0 B C    0 0 0
	//     \|/      \|/      \|/
	//    H-X-D    0-X-D    0-X-D
	//     /|\      /|\      /|\
	//    G F E    0 F E    0 F E

	// Do the four corners, then the edges then finally the body

	// TL, none above, none left
	//cout << "Linking map corners\n";
	rsint32 m = dimension;
	cell[0].LinkABLF(0);	cell[0].LinkAB(0);					cell[0].LinkABRT(0);								cell[0].LinkBLLF(0);
	cell[0].LinkLF(0);		cell[0].LinkRT(&cell[1]);		cell[0].LinkBL(&cell[m]);						cell[0].LinkBLRT(&cell[m+1]);
	// TR, none above, none right
	rsint32 n=m-1;
	cell[n].LinkABLF(0);	cell[n].LinkAB(0);					cell[n].LinkABRT(0);								cell[n].LinkRT(0);
	cell[n].LinkBLRT(0);	cell[n].LinkLF(&cell[n-1]);	cell[n].LinkBL(&cell[(2*m)-1]);			cell[n].LinkBLLF(&cell[(2*m)-2]);
	// BR, none below, none right
	n = (m*m)-1;
	cell[n].LinkABRT(0);	cell[n].LinkRT(0);					cell[n].LinkBLRT(0);								cell[n].LinkBL(0);
	cell[n].LinkBLLF(0);	cell[n].LinkLF(&cell[n-1]);	cell[n].LinkAB(&cell[(m*(m-1))-1]);	cell[n].LinkABLF(&cell[(m*(m-1))-2]);
	// BL, none below, none left
	n = m*(m-1);
	cell[n].LinkABLF(0);	cell[n].LinkBLRT(0);				cell[n].LinkBL(0);									cell[n].LinkBLLF(0);
	cell[n].LinkLF(0);		cell[n].LinkRT(&cell[n+1]);	cell[n].LinkAB(&cell[n-m]);					cell[n].LinkABRT(&cell[n-m+1]);
	// Do edges next
	// Top
	//cout << "Linking map top edge\n";
	n = m-1;
	rsint32 i;
	for (i=1; i<n; i++)
	{
		//cout << "i = " << i << "\n";
		cell[i].LinkABLF(0);						cell[i].LinkAB(0);					cell[i].LinkABRT(0);						cell[i].LinkLF(&cell[i-1]);
		cell[i].LinkBLLF(&cell[i+m-1]);	cell[i].LinkBL(&cell[i+m]);	cell[i].LinkBLRT(&cell[i+m+1]);	cell[i].LinkRT(&cell[i+1]);
	}
	// Bottom
	//cout << "Linking map bottom edge\n";
	n = m*m-1;
	rsint32 o = 1+m*(m-1); // index for bottom left+1
	for (i=o; i<n; i++)
	{
		//cout << "i = " << i << "\n";
		cell[i].LinkBLLF(0);						cell[i].LinkBL(0);					cell[i].LinkBLRT(0);						cell[i].LinkLF(&cell[i-1]);
		cell[i].LinkABLF(&cell[i-m-1]);	cell[i].LinkAB(&cell[i-m]);	cell[i].LinkABRT(&cell[i-m+1]);	cell[i].LinkRT(&cell[i+1]);
	}
	// Left
	//cout << "Linking map left edge\n";
	o = m-1;
	for (i=1, n=m; i<o; i++, n+=m)
	{
		//cout << "i = " << n << "\n";
		cell[n].LinkABLF(0);						cell[n].LinkLF(0);					cell[n].LinkBLLF(0);						cell[n].LinkAB(&cell[n-m]);
		cell[n].LinkABRT(&cell[n-m+1]);	cell[n].LinkRT(&cell[n+1]);	cell[n].LinkBLRT(&cell[n+m+1]);	cell[n].LinkBL(&cell[n+m]);
	}
	// Right
	//cout << "Linking map right edge\n";
	for (i=1, n=m+o; i<o; i++, n+=m)
	{
		//cout << "i = " << n << "\n";
		cell[n].LinkABRT(0);						cell[n].LinkRT(0);					cell[n].LinkBLRT(0);						cell[n].LinkAB(&cell[n-m]);
		cell[n].LinkABLF(&cell[n-m-1]);	cell[n].LinkLF(&cell[n-1]);	cell[n].LinkBLLF(&cell[n+m-1]);	cell[n].LinkBL(&cell[n+m]);
	}
	// Body. Thankfully this is easy with 2 loops
	//
	// o == dimension - 1
	// m == dimension
	// i == row offset
	// n == current cell index
	//cout << "Linking map body\n";
	i = m;
	for (rsint32 y=1; y<o; y++, i+=m)
	{
		//cout << "i = " << i+1 << " to " << i+o-1 << "\n";
		for (rsint32 x=1; x<o; x++)
		{
			n = i+x;
			cell[n].LinkLF(&cell[n-1]);	cell[n].LinkABLF(&cell[n-m-1]);	cell[n].LinkAB(&cell[n-m]);	cell[n].LinkABRT(&cell[n-m+1]);
			cell[n].LinkRT(&cell[n+1]);	cell[n].LinkBLRT(&cell[n+m+1]);	cell[n].LinkBL(&cell[n+m]);	cell[n].LinkBLLF(&cell[n+m-1]);
		}
	}
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 WORLDMAP::Clip(VIEW& view)
{
	// Builds a null terminated array of pointers to those cells determined to be visible
	sint32 minX = (sint32)(((view.BTL().x/scale)*(float32)dimension)-0.5F)-1;
	sint32 maxY = (sint32)(((view.BTL().y/scale)*(float32)dimension)+0.5F)+1;
	sint32 maxX = (sint32)(((view.BBR().x/scale)*(float32)dimension)+0.5F)+1;
	sint32 minY = (sint32)(((view.BBR().y/scale)*(float32)dimension)-0.5F)-1;

	minX = ClipInt(minX, 0, dimension);
	minY = ClipInt(minY, 0, dimension);
	maxX = ClipInt(maxX, 0, dimension);
	maxY = ClipInt(maxY, 0, dimension);

	detailLevel = (view.Zoom()-MinZoom())/MaxZoom();
	FreeVertices();
	{
		sint32 i = 0, j = 0, k = 0;
		for (rsint32 y = minY; y < maxY; y++)
		{
			for (rsint32 x = minX; x < maxX; x++)
			{
				register MAPCELL* c = &Cell(x,y);
				if (c->Visibility(view))
				{
					visible[i++] = c;
					if (c->Wet())
						wet[j++] = c;
					if (c->Thing())
						things[k++] = c->Thing();
				}
			}
		}
		// null terminate lists
		visible[i]	= 0;
		wet[j]			= 0;
		things[k]		= 0;
	}
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 WORLDMAP::Render(VIEW& view)
{
	if(view.State(VIEW::CHANGED))
	{
		view.Project();
		Clip(view);
	}
	stopWatch.Set();
	{
		Disable(ALPHA_BLEND);
		Enable(GOURAUD);
		Enable(TEXTURE);
		Enable(DEPTH_BUFFER);
		Enable(DEPTH_UPDATE);
		ClearDepthBuffer();
		rsint32 i = 0;
		while(visible[i])
			visible[i++]->Render(view);

		// Detail texture pass, dont modify z buffer
		if (view.State(VIEW::DETAIL) && detailLevel > 0.4F)
		{
			//Flush();
			Disable(DEPTH_UPDATE);
			Enable(ALPHA_BLEND);
			i = 0;
			while(visible[i])
				visible[i++]->Detail();
			Disable(ALPHA_BLEND);
			Enable(DEPTH_UPDATE);
		}

		// Water pass
		if (view.State(VIEW::WATER))
		{
			Enable(ALPHA_BLEND);
			Disable(GOURAUD);
			SetColour(0xFFB0C0FF);
			i = 0;
			while(wet[i])
				wet[i++]->WaterSurf();
			Enable(GOURAUD);
		}

		// Draw models
		if (view.State(VIEW::MODELS))
		{
			i = 0;
			while(things[i])
				things[i++]->Render(view);
		}
		Disable(GOURAUD);
	}
	frameTime = stopWatch.Elapsed();
	totalTime += frameTime;
/*

*/
	// Draw map view if active
	if (view.State(VIEW::SHOWMAP))
	{
		Disable(DEPTH_UPDATE);
		Disable(TEXTURE);
		Enable(ALPHA_BLEND);
		if (view.State(VIEW::SHOWMAPC))
		{
			rsint32 i = 0;
			while(visible[i])
				visible[i++]->Display(view);
		}
		view.Display();
		Disable(ALPHA_BLEND);
	}
	frames++;
	if (view.State(VIEW::STATS))
		DisplayStats(view);
	view.FrameDone();
	return frameTime;
}

void WORLDMAP::DisplayStats(VIEW& view)
{
	// Renders bar graph display for frameTime, vertex cache usage etc
	static uint32		gradient[] = {0xA0FF2000, 0xFF008000};
	static uint32		peakTime		= 0;
	static float32	peakVCache	= 0;
	sint16					viewW = view.Width();
	sint16					viewH = view.Height();
	float32					vCacheUse = (float32)vCachePtr/VCACHESIZE;

	// reset peak counters after every 64 frames rendered
	peakVCache	= frames&63UL ? (vCacheUse>peakVCache ? vCacheUse:peakVCache):vCacheUse;
	peakTime		= frames&63UL ? (frameTime>peakTime ? frameTime:peakTime):frameTime;

	Disable(DEPTH_BUFFER);
	Enable(ALPHA_BLEND);
	// scale bars
	RectShV(gradient, Coord(16, 16), Coord(32, viewH-16));
	RectShV(gradient, Coord(40, 16), Coord(56, viewH-16));
	RectShV(gradient, Coord(64, 16), Coord(80, viewH-16));
	RectShV(gradient, Coord(88, 16), Coord(104, viewH-16));

	// time
	Rect(0x80FFFFFF, Coord(18, viewH-peakTime-16), Coord(30, viewH-16));
	Rect(0x80FFFFFF, Coord(42, viewH-frameTime-16), Coord(54, viewH-16));

	// vertex cache
	sint16 v = (sint16)(peakVCache*((float32)viewH-32));
	Rect(0x80FFFFFF, Coord(66, viewH-v-16), Coord(78, viewH-16));
	v = (sint16)(vCacheUse*((float32)viewH-32));
	Rect(0x80FFFFFF, Coord(90, viewH-v-16), Coord(102, viewH-16));

	// Depth lines
	{
		Enable(DEPTH_BUFFER);
		Disable(DEPTH_UPDATE);
		Enable(ALPHA_BLEND);
		uint16 w = view.Width();
		uint16 h = view.Height();
		for (uint16 n = 0; n < w; n += 8)
		{
			float64 z = (float64)(w-n)/(float64)w;
			DepthD(z);
			Line(0x7FFFFFFF, Coord(n,0), Coord(n,h));
		}
	}
	Disable(ALPHA_BLEND);
}