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

class APP {
	public:
		static SINT32 Init();
		static SINT32 Done();
};

SINT32 APP::Init()
{
	if (xGFX::Init()!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", xBASELIB::Error(ERR_RSC_INVALID, "xGFX"));
		Done();
		return ERR_RSC_INVALID;
	}
	else if (xDRAW::Init(16384)!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", xBASELIB::Error(ERR_RSC_INVALID, "xDRAW"));
		Done();
		return ERR_RSC_INVALID;
	}
	else if (AXON::Init()!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", xBASELIB::Error(ERR_NO_FREE_STORE, "AXON"));
		Done();
		return ERR_RSC_INVALID;
	}
	return OK;
}


SINT32 APP::Done()
{
	AXON::Done();
	xDRAW::Done();
	xGFX::Done();
	return OK;
}

int main()
{
	if (xBASELIB::Init()!=OK)
	{
		cout << "xBASE library initialisation failed\n";
		return 10;
	}

	if (APP::Init()==OK)
	{

		VIEW test(64,64,640,480,16,"WorldMap Display");
		if (test.Open()==OK)
		{
			if (WORLDMAP::Init(6, 1000F, 10F, -50F, 150F, "metres", "data/ground.ppm")==OK)
			{
				UINT32 bg[] = {0xFF000020, 0xFF4080FF};
				UINT32 br = Coord(test.Width(), test.Height());

				PINETREE* tree = New(tree, 400UL);
				{
					SINT32 i = 0;
					while (i<400)
					{
						SINT32 x = (64*rand())/RAND_MAX;
						SINT32 y = (64*rand())/RAND_MAX;
						while(WORLDMAP::Cell(x,y).AddThing(tree[i])==FALSE)
						{
							// choose another location
							x = (64*rand())/RAND_MAX; y = (64*rand())/RAND_MAX;
						}
						FLOAT32 s = 5F + (FLOAT32)rand()/RAND_MAX;
						tree[i++].Place(WORLDMAP::Cell(x,y).TL(), s, x+y);
					}
				}

				BUILDING* building = New(building, 32UL);
				{
					SINT32 i = 0;
					while (i<32)
					{
						SINT32 x = (64*rand())/RAND_MAX;
						SINT32 y = (64*rand())/RAND_MAX;
						while(WORLDMAP::Cell(x,y).AddThing(building[i])==FALSE)
						{
							// choose another location
							x = (64*rand())/RAND_MAX; y = (64*rand())/RAND_MAX;
						}
						building[i++].Place(WORLDMAP::Cell(x,y).TL(), 10);
					}
				}

				test.Camera(500, 500, 20, 45, 25);
				xDRAW::Enable(xDRAW::DEPTH_BUFFER);
				xDRAW::Enable(xDRAW::DEPTH_UPDATE);
				while(!test.State(VIEW::QUIT))
				{
					xDRAW::Begin();
					{
						xDRAW::Disable(xDRAW::ALPHA_BLEND);
						xDRAW::Disable(xDRAW::DEPTH_BUFFER);
						xDRAW::RectShV(bg, 0, br);
						xDRAW::Enable(xDRAW::DEPTH_BUFFER);
						WORLDMAP::Render(test);
					}
					xDRAW::End();
					test.Refresh();
					test.WaitSync();
				}
				Delete(building);
				Delete(tree);
		 		sysBASELIB::MessageBox("Info", "OK",
															 "Finished\nRendered %d frames, average time %f ms/frame",
															 WORLDMAP::Frames(), WORLDMAP::AvgFrameTime());
				WORLDMAP::Done();
			}
			test.Close();
		}
		APP::Done();
	}

	xBASELIB::Done();
	return 0;
}
