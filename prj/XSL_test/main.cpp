/*

	Extropia System Library test code by Karlos, eXtropia Studios

*/

#include <xBase.hpp>
#include <xSystem/xResources.hpp>
#include <xSystem/xDraw.hpp>

extern uint32 BenchmarkQuardics(xDISPLAY& win);
extern uint32 Primitives(xDISPLAY& win);
extern uint32 TriangleFX(xDISPLAY& win);
extern uint32 BounceFX(xDISPLAY& win);
extern uint32 CampFireFX(xDISPLAY& win);
extern uint32 LightSourceTXFX(xDISPLAY& win);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int main()
{
	if (xBASELIB::Init()!=OK)
	{
		return 10;
	}

	if (xGFX::Init()!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", xBASELIB::Error(ERR_RSC_INVALID, "xGFX"));
		goto cleanup;
	}

	{
		//cout << "Testing xDRAW:: class\n";
		if (xDRAW::Init()==OK)
		{
			static xDBWIN test(128,128,512,512,16,"Test Window [class xDBWIN]");
			test.Open();
			if (xDRAW::Bind(test.DrawSurface())==OK)
			{
				bool quit=0;

				while (quit==0)
				{

					uint32 choose = sysBASELIB::MessageBox("xDRAW", "1|2|3|4|5|Exit",
						"Welcome to the eXtropia xDRAW Demonstration\n\n"
						"Version 0.1 Beta (" __DATE__ ") Amiga68K\n"
						"Demo 1 : Basic Primitives\n"
						"Demo 2 : Transparency 1\n"
						"Demo 3 : Transparency 2\n"
						"Demo 4 : Texture Anim\n"
						"Demo 5 : Lightsourcable Textures");
					switch (choose)
					{
						case 1:
							sysBASELIB::MessageBox("Info", "Go on", "xDRAW Demonstration\nDemo 1\n\nBasic Primitives and\nsupported shading methods");
							cout << "Took :  " << Primitives(test) << "ms\n";
							break;

						case 2:
							sysBASELIB::MessageBox("Info", "Go on", "Demo 2\n\nExample of alpha blending\non shaded surfaces");
							cout << "Took " << TriangleFX(test) << "ms\n";
							break;

						case 3:
							sysBASELIB::MessageBox("Info", "Go on", "Demo 3\n\nPicture of a motion blurred\nball falling drawn only\nusing primitives");
							cout << "Took " << BounceFX(test) << "ms\n";
							break;

						case 4:
							sysBASELIB::MessageBox("Info", "Go on", "Demo 4\n\nA (not so) cosy camp fire!\nDemonstrates simple texture\nanimation with blending");
							cout << "Took " << CampFireFX(test) << "ms\n";
							break;

						case 5:
							sysBASELIB::MessageBox("Info", "Go on", "Demo 5\n\nSprite animation using a special\nAB3D-II style lightmapped bitmap\nto simulate realtime lightsourcing\nby blending 5 precalculated\nsource maps\n\nThis is *very* hard in software!");
							cout << "Took " << LightSourceTXFX(test) << "ms\n";
							break;

						default:
							quit = TRUE;
							break;
					}
				}
				xDRAW::Release();
			}
			test.Close();
		}
		xDRAW::Done();
	}

	//sysBASELIB::MessageBox("Debug Info", "OK", "Logical end of application reached in source file\n'" __FILE__ "'\nHave a nice day");
	cleanup:

	xGFX::Done();
	xBASELIB::Done();
	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////

