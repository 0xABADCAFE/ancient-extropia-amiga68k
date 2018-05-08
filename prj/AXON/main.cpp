//*****************************************************************//
//** Description:   Axonometric Projector, AmigaOS/68K version   **//
//** First Started:                                              **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xBase.hpp>

#include "axon.hpp"

inline float32 QRnd(float32 x=1F) { return (x*rand())/RAND_MAX; }

class APP {
	private:
		static RGBCUBE*	buildings;
		static PINETREE*	trees;
		static VIEW				view;

	public:
		static sint32 Init();
		static sint32 Done();
		static sint32 Run();
};

BUILDING*	APP::buildings	= 0;
PINETREE*	APP::trees			= 0;
VIEW			APP::view(128,128,640,480,16,"WorldMap Display");

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APP::Init()
{
	sint32 r = xGFX::Init();
	if (r!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", "xGFX Error");
		Done();
		return ERR_RSC_INVALID;
	}
	else if (xDRAW::Init()!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", "xDRAW Error");
		Done();
		return ERR_RSC_UNAVAILABLE;
	}
	else if (AXON::Init()!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", "Not enough memory for engine");
		Done();
		return ERR_RSC_UNAVAILABLE;
	}
	if (view.Open()!=OK)
	{
		sysBASELIB::MessageBox("Program Aborted", "OK", "Failed to create display");
		Done();
		return ERR_RSC_UNAVAILABLE;
	}
	else if (WORLDMAP::Init(6, 1000F, 5F, -100F, 200F, "metres")!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", "WORLDMAP initialisation failed");
		Done();
		return ERR_RSC_UNAVAILABLE;
	}
	else
	{

		trees = New(trees, 500);
		if (trees)
		{
			sint32 i = 500;
			while (--i)
			{
				sint32 x = QRnd(64);	sint32 y = QRnd(64);	float32 s = 5F + QRnd();
				while(WORLDMAP::Cell(x,y).AddThing(trees[i], QRnd(1000F/64F), QRnd(1000/64F), s)==FALSE)
				{
					x = QRnd(64); y = QRnd(64);
				}
			}
		}
		else
		{
	 		sysBASELIB::MessageBox("Program Aborted", "OK", "Failed to create tree objects");
			Done();
			return ERR_NO_FREE_STORE;
		}
		buildings = New(buildings, 32);
		if (buildings)
		{
			sint32 i = 32;
			while (--i)
			{
				sint32 x = QRnd(64);	sint32 y = QRnd(64);
				while(WORLDMAP::Cell(x,y).AddThing(buildings[i], 500F/64F, 500F/64F, 5)==FALSE)
				{
					x = QRnd(64); y = QRnd(64);
				}
			}
		}
		else
		{
 			sysBASELIB::MessageBox("Program Aborted", "OK", "Failed to create building objects");
			Done();
			return ERR_NO_FREE_STORE;
		}
	}
	view.Camera(500, 500, 20, 45, 30);
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APP::Done()
{
	if (trees)
		Delete(trees);
	if (buildings)
		Delete(buildings);
	WORLDMAP::Done();
	view.Close();
	AXON::Done();
	xDRAW::Done();
	xGFX::Done();
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APP::Run()
{
	uint32 bg[] = {0xFF000020, 0xFF4080FF};					// quick background gradient fill for window
	uint32 br = Coord(view.Width(), view.Height()); // bottom right coord
	while(!view.State(VIEW::QUIT))
	{
		sint32 t;
		xDRAW::Begin();
		{
			// this just draws a nice background gradient
			if (view.State(VIEW::BACKFILL))
			{
				xDRAW::Disable(x3D::ALPHA_BLEND);
				xDRAW::Disable(x3D::DEPTH_BUFFER);
				xDRAW::RectShV(bg, 0, br);
			}
			else
				xDRAW::Clear();
			// The important stuff happens here
			t = WORLDMAP::Render(view);
		}
		xDRAW::End();
		xDRAW::SimpleText(Coord(8,16), xDRAW::ST_PARAGRAPH1, "Origin : %f,%f, yaw : %d, pitch : %d, zoom : %f, took : %d ms",\
											view.Origin().x, view.Origin().y, view.Yaw(), view.Pitch(), view.Zoom(), t);
		view.Refresh();
		view.HandleInput();
		view.WaitSync();
	}
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int main()
{
	if (xBASELIB::Init()!=OK)
	{
		puts("xBASE library initialisation failed");
		return 10;
	}

	if (APP::Init()==OK)
	{
		APP::Run();
 		sysBASELIB::MessageBox("Info", "OK", "Finished\nRendered %d frames, average time %f ms/frame",
													 WORLDMAP::Frames(), WORLDMAP::AvgFrameTime());
		APP::Done();
	}
	xBASELIB::Done();
	return 0;
}
